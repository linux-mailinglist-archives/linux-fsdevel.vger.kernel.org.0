Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB9495E2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 12:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiAULJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 06:09:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34890 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380091AbiAULJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:09:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A6C461A27;
        Fri, 21 Jan 2022 11:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D39C340E1;
        Fri, 21 Jan 2022 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642763364;
        bh=V4yrtIZgsqs0WlCeHnDvpWADei1ftXx0D93HzFs1TeE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ya147kKlKxdnovsF2UwX6JG6zUdeR8jBsqvCaJt65ir2ypFpa2QyGXlhBimN6qnuI
         RrWi/1U0aXj0+rP4CTDIm7ijzGB3c9fGjejbsAd6JjlGUvRE9Vwp4JHO+YrpM9AKHR
         vlJR8yRzE5PEbb1cDOvrupBsMPn8jECTSC7UvlVYYXweW4JiL117tzwJgTIftPfsMr
         QKT81eO5olDojn0UoKokGbUrmaAOHU1CdJ4BIJGxArOPoZUmJR9in/NI2uAECynvm7
         UV4LOZcj/5Df6dZZw3d6ZMwAUMyQnGVXQjTOb42+P/kWLNQEDg6LTzztVmdfx2qujv
         PSSyU5Qr9YEQQ==
Message-ID: <b65ee653c451a485d85d0207322e650e7535c22d.camel@kernel.org>
Subject: Re: [PATCH 2/3] ceph: Uninline the data on a file opened for writing
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 21 Jan 2022 06:09:22 -0500
In-Reply-To: <YeWdlR7nsBG8fYO2@casper.infradead.org>
References: <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
         <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
         <YeWdlR7nsBG8fYO2@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-17 at 16:47 +0000, Matthew Wilcox wrote:
> On Mon, Jan 17, 2022 at 04:26:36PM +0000, David Howells wrote:
> > +	folio = read_mapping_folio(inode->i_mapping, 0, file);
> > +	if (IS_ERR(folio))
> > +		goto out;
> 
> ... you need to set 'err' here, right?
> 
> > +	if (folio_test_uptodate(folio))
> > +		goto out_put_folio;
> 
> Er ... if (!folio_test_uptodate(folio)), perhaps?  And is it even
> worth testing if read_mapping_folio() returned success?  I feel like
> we should take ->readpage()'s word for it that success means the
> folio is now uptodate.
> 
> > +	err = folio_lock_killable(folio);
> > +	if (err < 0)
> > +		goto out_put_folio;
> > +
> > +	if (inline_version == 1 || /* initial version, no data */
> > +	    inline_version == CEPH_INLINE_NONE)
> > +		goto out_unlock;
> > +
> > +	len = i_size_read(inode);
> > +	if (len >  folio_size(folio))
> 
> extra space.  Plus, you're hardcoding 4096 below, but using folio_size()
> here which is a bit weird to me.

The client actually decides how big a region to inline when it does
this. The default is 4k, but someone could inline up to 64k (and
potentially larger, if they tweak settings the right way).

I'd suggest not capping the length in this function at all. If you find
more than 4k, just assume that some other client stashed more data than
expected, and uninline whatever is there.

You might also consider throwing in a pr_warn or something in that case,
since finding more than 4k uninlined would be unexpected (though not
necessarily broken).
-- 
Jeff Layton <jlayton@kernel.org>
