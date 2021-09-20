Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13095412994
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 01:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbhITXvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 19:51:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbhITXts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:49:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0B25220C9;
        Mon, 20 Sep 2021 23:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632181698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDR8rd0yeY+WwyoUfkNID7NmGWHu0FjMPIrB2wt75VE=;
        b=chupZgMQPOxHEij3AQE2fQ2gSjEBexoIhCfHuOMAHmdvWRbUCZ3gF+k/9vweTWz5Vta7u7
        mQNBvpOGiocqZ8S2DLOKWCj1DnMxDgqu+pm+lZ995Bqs12YFbnoaxjNRQ+fsjkM3Y2EJf6
        IcYOJqc0DX/D4NVZVgH8EEpAAkJy30I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632181698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDR8rd0yeY+WwyoUfkNID7NmGWHu0FjMPIrB2wt75VE=;
        b=D5EiDX5Iks4DL7NrQNDrrqwivNtaz8nkcu8GToJ6VdTOfRtsYDcTPgMQNgtEz/8W0CdMf5
        geVHQgv+cPcW2OAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40BED13B3F;
        Mon, 20 Sep 2021 23:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5j12O70dSWH0bgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Sep 2021 23:48:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@suse.de>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Jesper Dangaard Brouer" <jbrouer@redhat.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] MM: Support __GFP_NOFAIL in  alloc_pages_bulk_*() and
 improve doco
In-reply-to: <20210917144233.GD3891@suse.de>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>,
 <163184741776.29351.3565418361661850328.stgit@noble.brown>,
 <20210917144233.GD3891@suse.de>
Date:   Tue, 21 Sep 2021 09:48:11 +1000
Message-id: <163218169134.3992.18152143151159846850@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 18 Sep 2021, Mel Gorman wrote:
> I'm top-posting to cc Jesper with full context of the patch. I don't
> have a problem with this patch other than the Fixes: being a bit
> marginal, I should have acked as Mel Gorman <mgorman@suse.de> and the
> @gfp in the comment should have been @gfp_mask.
>=20
> However, an assumption the API design made was that it should fail fast
> if memory is not quickly available but have at least one page in the
> array. I don't think the network use case cares about the situation where
> the array is already populated but I'd like Jesper to have the opportunity
> to think about it.  It's possible he would prefer it's explicit and the
> check becomes
> (!nr_populated || ((gfp_mask & __GFP_NOFAIL) && !nr_account)) to
> state that __GFP_NOFAIL users are willing to take a potential latency
> penalty if the array is already partially populated but !__GFP_NOFAIL
> users would prefer fail-fast behaviour. I'm on the fence because while
> I wrote the implementation, it was based on other peoples requirements.

I can see that it could be desirable to not try too hard when we already
have pages allocated, but maybe the best way to achieve that is for the
called to clear __GFP_RECLAIM in that case.

Alternately, callers that really want the __GFP_RECLAIM and __GFP_NOFAIL
flags to be honoured could ensure that the array passed in is empty.
That wouldn't be difficult (for current callers).

In either case, the documentation should make it clear which flags are
honoured when.

Let's see what Jesper has to say.

Thanks,
NeilBrown


>=20
> On Fri, Sep 17, 2021 at 12:56:57PM +1000, NeilBrown wrote:
> > When alloc_pages_bulk_array() is called on an array that is partially
> > allocated, the level of effort to get a single page is less than when
> > the array was completely unallocated.  This behaviour is inconsistent,
> > but now fixed.  One effect if this is that __GFP_NOFAIL will not ensure
> > at least one page is allocated.
> >=20
> > Also clarify the expected success rate.  __alloc_pages_bulk() will
> > allocated one page according to @gfp, and may allocate more if that can
> > be done cheaply.  It is assumed that the caller values cheap allocation
> > where possible and may decide to use what it has got, or to call again
> > to get more.
> >=20
> > Acked-by: Mel Gorman <mgorman@suse.com>
> > Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the =
bulk page allocator")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  mm/page_alloc.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b37435c274cf..aa51016e49c5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5191,6 +5191,11 @@ static inline bool prepare_alloc_pages(gfp_t gfp_m=
ask, unsigned int order,
> >   * is the maximum number of pages that will be stored in the array.
> >   *
> >   * Returns the number of pages on the list or array.
> > + *
> > + * At least one page will be allocated if that is possible while
> > + * remaining consistent with @gfp.  Extra pages up to the requested
> > + * total will be allocated opportunistically when doing so is
> > + * significantly cheaper than having the caller repeat the request.
> >   */
> >  unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> >  			nodemask_t *nodemask, int nr_pages,
> > @@ -5292,7 +5297,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
> >  								pcp, pcp_list);
> >  		if (unlikely(!page)) {
> >  			/* Try and get at least one page */
> > -			if (!nr_populated)
> > +			if (!nr_account)
> >  				goto failed_irq;
> >  			break;
> >  		}
> >=20
> >=20
>=20
>=20
