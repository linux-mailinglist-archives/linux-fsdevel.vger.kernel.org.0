Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2C3D64A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbhGZQAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 12:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239874AbhGZP6y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B84460F11;
        Mon, 26 Jul 2021 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627317562;
        bh=2V+n70BOKIV4yKlANEh8mr0Ca45xZl/Lan3YYFb5GQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aN+kq03AaV0oDH0WPR5uFmK9Lx76YUVi9n6+UXyT04etfzep9HCnNGQZtCxh3SP04
         1Rj8TJPGAhgzqDeiJsmv528NBDiXrZIR/3b7C/btCDidvxL+Vr1qRaTFpwpD4Q0A0C
         jlc0xlcHJprfaiXdkZ14vNsvdNWUJGhd0eoinfsGuMW1+rTBmDlMzhchdOcI5nPyeo
         AUqdSrRWtsjw7CLFoup0OXFMy4fWNQ/cbnebcPTDwP8Rg53hv5tnhHtYDgVqDJxh1y
         el2j7hTZekOQDhHiqFskE/A4hwrR6hzcEapR0ENx5hXqQ2mMg0+3dv2IlBJ4/9R7vm
         TDT0e3fwRGfyg==
Date:   Mon, 26 Jul 2021 09:39:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 16/27] iomap: switch iomap_bmap to use iomap_iter
Message-ID: <20210726163922.GA559142@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-17-hch@lst.de>
 <20210719170545.GF22402@magnolia>
 <20210726081942.GD14853@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726081942.GD14853@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:19:42AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 10:05:45AM -0700, Darrick J. Wong wrote:
> > >  	bno = 0;
> > > -	ret = iomap_apply(inode, pos, blocksize, 0, ops, &bno,
> > > -			  iomap_bmap_actor);
> > > +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > > +		if (iter.iomap.type != IOMAP_MAPPED)
> > > +			continue;
> > 
> > There isn't a mapped extent, so return 0 here, right?
> 
> We can't just return 0, we always need the final iomap_iter() call
> to clean up in case a ->iomap_end method is supplied.  No for bmap
> having and needing one is rather theoretical, but people will copy
> and paste that once we start breaking the rules.

Oh, right, I forgot that someone might want to ->iomap_end.  The
"continue" works because we only asked for one block, therefore we know
that we'll never get to the loop body a second time; and we ignore
iter.processed, which also means we never revisit the loop body.

This "continue without setting iter.processed to break out of loop"
pattern is a rather indirect subtlety, since C programmers are taught
that they can break out of a loop using break;.  This new iomap_iter
pattern fubars that longstanding language feature, and the language
around it is soft:

> /**
>  * iomap_iter - iterate over a ranges in a file
>  * @iter: iteration structue
>  * @ops: iomap ops provided by the file system
>  *
>  * Iterate over file system provided contiguous ranges of blocks with the same
>  * state.  Should be called in a loop that continues as long as this function
>  * returns a positive value.  If 0 or a negative value is returned the caller
>  * should break out of the loop - a negative value is an error either from the
>  * file system or from the last iteration stored in @iter.copied.
>  */

The documentation needs to be much more explicit about the fact that you
cannot "break;" your way out of an iomap_iter loop.  I think the comment
should be rewritten along these lines:

"Iterate over filesystem-provided space mappings for the provided file
range.  This function handles cleanup of resources acquired for
iteration when the filesystem indicates there are no more space
mappings, which means that this function must be called in a loop that
continues as long it returns a positive value.  If 0 or a negative value
is returned, the caller must not return to the loop body.  Within a loop
body, there are two ways to break out of the loop body: leave
@iter.processed unchanged, or set it to the usual negative errno."

Hm.

What if we provide an explicit loop break function?  That would be clear
overkill for bmap, but somebody else wanting to break out of a more
complex loop body ought to be able to say "break" to do that, not
"continue with subtleties".

static inline int
iomap_iter_break(struct iomap_iter *iter, int ret)
{
	int ret2;

	if (!iter->iomap.length || !ops->iomap_end)
		return ret;

	ret2 = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
			0, iter->flags, &iter->iomap);
	return ret ? ret : ret2;
}

And then then theoretical loop body becomes:

	while ((ret = iomap_iter(&iter, ops)) > 0) {
		if (iter.iomap.type != WHAT_I_WANT) {
			ret = iomap_iter_break(&iter, 0);
			break;
		}

		<large blob of code here>

		ret = vfs_do_some_risky_thing(...);
		if (ret) {
			ret = iomap_iter_break(&iter, ret);
			break;
		}

		<more loop body here>

		iter.processed = iter.iomap.length;
	}
	return ret;

Clunky, for sure, but at least we still get to use break as the language
designers intended.

--D
