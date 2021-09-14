Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B2140B9BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhINVPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 17:15:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46900 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhINVPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:15:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B76D51FE30;
        Tue, 14 Sep 2021 21:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631654040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7HOhMJiSvEdnqg2c8rgOboivLABb0GSRM2C1XyfMK0=;
        b=D1GJj9aNpzzAT0YUJGnFdmW0iot6sNFvPRFUKGthNXwX2VG+VdlQH86I3u4pFey4+I+5bk
        P8KNxZGnYuGQgjj84ICJDWVeJJBZe8qDO+CYJBuVpDZa4bb4Q2k2F7VGHJ0Qky/19CwcHp
        fORe0hxvENVJigFZ/wIHzwIxrEdDZjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631654040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7HOhMJiSvEdnqg2c8rgOboivLABb0GSRM2C1XyfMK0=;
        b=pI1W8hgJ2Vg6NRag8uc+MK00GPMD7aCANHwz9e1iXwyYnyAcjTQtnZadcfDajSuz0jYDPt
        CHwO2jm8qSSDNlBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2216913B43;
        Tue, 14 Sep 2021 21:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v5amNJQQQWFzMwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 21:13:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@suse.com>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] XFS: remove congestion_wait() loop from xfs_buf_alloc_pages()
In-reply-to: <20210914164504.GS3828@suse.com>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>,
 <163157838440.13293.12568710689057349786.stgit@noble.brown>,
 <20210914020837.GH2361455@dread.disaster.area>,
 <163158695921.3992.9776900395549582360@noble.neil.brown.name>,
 <20210914164504.GS3828@suse.com>
Date:   Wed, 15 Sep 2021 07:13:54 +1000
Message-id: <163165403435.3992.14639160345151711607@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Sep 2021, Mel Gorman wrote:
> On Tue, Sep 14, 2021 at 12:35:59PM +1000, NeilBrown wrote:
> > On Tue, 14 Sep 2021, Dave Chinner wrote:
> > > On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > > > Documentation commment in gfp.h discourages indefinite retry loops on
> > > > ENOMEM and says of __GFP_NOFAIL that it
> > > >=20
> > > >     is definitely preferable to use the flag rather than opencode
> > > >     endless loop around allocator.
> > > >=20
> > > > congestion_wait() is indistinguishable from
> > > > schedule_timeout_uninterruptible() in practice and it is not a good w=
ay
> > > > to wait for memory to become available.
> > > >=20
> > > > So instead of waiting, allocate a single page using __GFP_NOFAIL, then
> > > > loop around and try to get any more pages that might be needed with a
> > > > bulk allocation.  This single-page allocation will wait in the most
> > > > appropriate way.
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/xfs/xfs_buf.c |    6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > > > index 5fa6cd947dd4..1ae3768f6504 100644
> > > > --- a/fs/xfs/xfs_buf.c
> > > > +++ b/fs/xfs/xfs_buf.c
> > > > @@ -372,8 +372,8 @@ xfs_buf_alloc_pages(
> > > > =20
> > > >  	/*
> > > >  	 * Bulk filling of pages can take multiple calls. Not filling the e=
ntire
> > > > -	 * array is not an allocation failure, so don't back off if we get =
at
> > > > -	 * least one extra page.
> > > > +	 * array is not an allocation failure, so don't fail or fall back on
> > > > +	 * __GFP_NOFAIL if we get at least one extra page.
> > > >  	 */
> > > >  	for (;;) {
> > > >  		long	last =3D filled;
> > > > @@ -394,7 +394,7 @@ xfs_buf_alloc_pages(
> > > >  		}
> > > > =20
> > > >  		XFS_STATS_INC(bp->b_mount, xb_page_retries);
> > > > -		congestion_wait(BLK_RW_ASYNC, HZ / 50);
> > > > +		bp->b_pages[filled++] =3D alloc_page(gfp_mask | __GFP_NOFAIL);
> > >=20
> > > This smells wrong - the whole point of using the bulk page allocator
> > > in this loop is to avoid the costly individual calls to
> > > alloc_page().
> > >=20
> > > What we are implementing here fail-fast semantics for readahead and
> > > fail-never for everything else.  If the bulk allocator fails to get
> > > a page from the fast path free lists, it already falls back to
> > > __alloc_pages(gfp, 0, ...) to allocate a single page. So AFAICT
> > > there's no need to add another call to alloc_page() because we can
> > > just do this instead:
> > >=20
> > > 	if (flags & XBF_READ_AHEAD)
> > > 		gfp_mask |=3D __GFP_NORETRY;
> > > 	else
> > > -		gfp_mask |=3D GFP_NOFS;
> > > +		gfp_mask |=3D GFP_NOFS | __GFP_NOFAIL;
> > >=20
> > > Which should make the __alloc_pages() call in
> > > alloc_pages_bulk_array() do a __GFP_NOFAIL allocation and hence
> > > provide the necessary never-fail guarantee that is needed here.
> >=20
> > That is a nice simplification.
> > Mel Gorman told me
> >   https://lore.kernel.org/linux-nfs/20210907153116.GJ3828@suse.com/
> > that alloc_pages_bulk ignores GFP_NOFAIL.  I added that to the
> > documentation comment in an earlier patch.
> >=20
> > I had a look at the code and cannot see how it would fail to allocate at
> > least one page.  Maybe Mel can help....
> >=20
>=20
> If there are already at least one page an the array and the first attempt
> at bulk allocation fails, it'll simply return. It's an odd corner case
> that may never apply but it's possible.  That said, I'm of the opinion that
> __GFP_NOFAIL should not be expanded and instead congestion_wait should be
> deleted and replaced with something triggered by reclaim making progress.

Ahh.... that was (I think) fixed by
https://patchwork.kernel.org/project/linux-mm/patch/163027609524.7591.4987241=
695872857175@noble.neil.brown.name/
(which I cannot find on lore.kernel.org - strange)
which you acked - and which I meant to include in this series but
somehow missed.

NeilBrown
