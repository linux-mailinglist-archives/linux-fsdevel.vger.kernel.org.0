Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BDA499E70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 00:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588833AbiAXWeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 17:34:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390879AbiAXWRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:17:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5A08E21138;
        Mon, 24 Jan 2022 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643062631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zp/ugdyNjv+ZK/vufq42OIU9Itixj/olNJM3ZUEc75M=;
        b=C/Bc/zdfDjcl6gHQQ6i6LTrmGWKjYDNwlUdo1+hRP0iD3BkOXGIo7i0aFnwQO0PGZPE1AU
        qdHQhy/k1erNHd+WxVQPRrpWOwEClyKqAKtigGqnhK5MZuC9dCXrN8t8/+3j7BdrIdoV3G
        0ZTJKqYPJ0FUeoD0h9QeRy75yhdDrQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643062631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zp/ugdyNjv+ZK/vufq42OIU9Itixj/olNJM3ZUEc75M=;
        b=0IbJcbnZ25FmTgkE60E4ZdoejcWYe0CRZUEhkb7nAcmBSpQ/7if/iRw2Rz+3lp2ZxjHq05
        MnNPMdF3djj1sFCw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C854A3B8E;
        Mon, 24 Jan 2022 22:17:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 02C89A05E6; Mon, 24 Jan 2022 23:17:09 +0100 (CET)
Date:   Mon, 24 Jan 2022 23:17:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Message-ID: <20220124221709.kzsaqkdp3gmjie3z@quack3.lan>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
 <923c30a5-747e-148b-43c9-32dfacda0d0a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923c30a5-747e-148b-43c9-32dfacda0d0a@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-01-22 13:06:03, John Hubbard wrote:
> On 1/24/22 02:05, Jan Kara wrote:
> ...
> > > do_direct_IO()
> > >      dio_zero_block()
> > >          page = ZERO_PAGE(0); <-- This is a problem
> > > 
> > > I'm not sure what to use, instead of that zero page! The zero page
> > > doesn't need to be allocated nor tracked, and so any replacement
> > > approaches would need either other storage, or some horrid scheme that I
> > > won't go so far as to write on the screen. :)
> > 
> > Well, I'm not sure if you consider this ugly but currently we use
> > get_page() in that path exactly so that bio_release_pages() does not have
> > to care about zero page. So now we could grab pin on the zero page instead
> > through try_grab_page() or something like that...
> > 
> > 								Honza
> 
> So it sounds like you prefer this over checking for the zero page in
> bio_release_pages(). I'll take a look at both ideas, then, and see what
> it looks like.

Yes, I somewhat prefer this because it seems more transparent to me.
Furthermore if e.g. we can have zero page mapped to userspace (not sure if
we can for normal mappings but at least for DAX mapping we can), and userspace
provides such mapping as a buffer for direct IO write, then we'll get zero
page attached to bio through iov_iter_get_pages() and we'd have to be very
careful to special-case zero page in iov_iter_get_pages() as well. Overall
it seems fragile to me... So it seems more robust to make sure all pages we
attach to bio are pinned.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
