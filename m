Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C38413C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhIUV3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:29:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhIUV3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:29:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7982D201B4;
        Tue, 21 Sep 2021 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632259658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tk+dmVsPFcVo++hN/dqeiaxPyODTE1Gskdip0VpKIC8=;
        b=a9L6wobgSc1sLIFF5zMHkvzj2PbmTSi1VsrJja+WZdf/m4uKmE/csx8gU/v1rJ0gWr9EcD
        hpJ7llt69lxsRQKn4OZS0Eu6WzzU3Hr7D62NF7ql1pDClKAGhoBwSYo+23z0KwAZhpiFLy
        9gl2gynR0TC1FQkcpFYcUSOsR//0Xek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632259658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tk+dmVsPFcVo++hN/dqeiaxPyODTE1Gskdip0VpKIC8=;
        b=BoxvFoB4jRoMzKHmCeVSlR2nucNXrBZFpz0+l+HOODtOLPEuQvd0t7Fdq+B2RhdM1zT3ep
        orR49AXsh3Jdz1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8775A13BFB;
        Tue, 21 Sep 2021 21:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P4RDEUZOSmEiHgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 21 Sep 2021 21:27:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Linux-MM" <linux-mm@kvack.org>, "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
In-reply-to: <20210921111234.GQ3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>,
 <20210920085436.20939-2-mgorman@techsingularity.net>,
 <163217994752.3992.5443677201798473600@noble.neil.brown.name>,
 <20210921111234.GQ3959@techsingularity.net>
Date:   Wed, 22 Sep 2021 07:27:31 +1000
Message-id: <163225965160.21861.15527333497403949557@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Sep 2021, Mel Gorman wrote:
> On Tue, Sep 21, 2021 at 09:19:07AM +1000, NeilBrown wrote:
> > On Mon, 20 Sep 2021, Mel Gorman wrote:
> > > =20
> > > +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page);
> > > +static inline void acct_reclaim_writeback(struct page *page)
> > > +{
> > > +	pg_data_t *pgdat =3D page_pgdat(page);
> > > +
> > > +	if (atomic_read(&pgdat->nr_reclaim_throttled))
> > > +		__acct_reclaim_writeback(pgdat, page);
> >=20
> > The first thing __acct_reclaim_writeback() does is repeat that
> > atomic_read().
> > Should we read it once and pass the value in to
> > __acct_reclaim_writeback(), or is that an unnecessary
> > micro-optimisation?
> >=20
>=20
> I think it's a micro-optimisation but I can still do it.
>=20
> >=20
> > > +/*
> > > + * Account for pages written if tasks are throttled waiting on dirty
> > > + * pages to clean. If enough pages have been cleaned since throttling
> > > + * started then wakeup the throttled tasks.
> > > + */
> > > +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
> > > +{
> > > +	unsigned long nr_written;
> > > +	int nr_throttled =3D atomic_read(&pgdat->nr_reclaim_throttled);
> > > +
> > > +	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
> > > +	nr_written =3D node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
> > > +		READ_ONCE(pgdat->nr_reclaim_start);
> > > +
> > > +	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
> > > +		wake_up_interruptible_all(&pgdat->reclaim_wait);
> >=20
> > A simple wake_up() could be used here.  "interruptible" is only needed
> > if non-interruptible waiters should be left alone.  "_all" is only needed
> > if there are some exclusive waiters.  Neither of these apply, so I think
> > the simpler interface is best.
> >=20
>=20
> You're right.
>=20
> >=20
> > > +}
> > > +
> > >  /* possible outcome of pageout() */
> > >  typedef enum {
> > >  	/* failed to write page out, page is locked */
> > > @@ -1412,9 +1453,8 @@ static unsigned int shrink_page_list(struct list_=
head *page_list,
> > > =20
> > >  		/*
> > >  		 * The number of dirty pages determines if a node is marked
> > > -		 * reclaim_congested which affects wait_iff_congested. kswapd
> > > -		 * will stall and start writing pages if the tail of the LRU
> > > -		 * is all dirty unqueued pages.
> > > +		 * reclaim_congested. kswapd will stall and start writing
> > > +		 * pages if the tail of the LRU is all dirty unqueued pages.
> > >  		 */
> > >  		page_check_dirty_writeback(page, &dirty, &writeback);
> > >  		if (dirty || writeback)
> > > @@ -3180,19 +3220,20 @@ static void shrink_node(pg_data_t *pgdat, struc=
t scan_control *sc)
> > >  		 * If kswapd scans pages marked for immediate
> > >  		 * reclaim and under writeback (nr_immediate), it
> > >  		 * implies that pages are cycling through the LRU
> > > -		 * faster than they are written so also forcibly stall.
> > > +		 * faster than they are written so forcibly stall
> > > +		 * until some pages complete writeback.
> > >  		 */
> > >  		if (sc->nr.immediate)
> > > -			congestion_wait(BLK_RW_ASYNC, HZ/10);
> > > +			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
> > >  	}
> > > =20
> > >  	/*
> > >  	 * Tag a node/memcg as congested if all the dirty pages
> > >  	 * scanned were backed by a congested BDI and
> >=20
> > "congested BDI" doesn't mean anything any more.  Is this a good time to
> > correct that comment.
> > This comment seems to refer to the test
> >=20
> >       sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
> >=20
> > a few lines down.  But nr.congested is set from nr_congested which
> > counts when inode_write_congested() is true - almost never - and when=20
> > "writeback and PageReclaim()".
> >=20
> > Is that last test the sign that we are cycling through the LRU to fast?
> > So the comment could become:
> >=20
> >    Tag a node/memcg as congested if all the dirty page were
> >    already marked for writeback and immediate reclaim (counted in
> >    nr.congested).
> >=20
> > ??
> >=20
> > Patch seems to make sense to me, but I'm not expert in this area.
> >=20
>=20
> Comments updated.
>=20
> Diff on top looks like
>=20
> diff --git a/mm/internal.h b/mm/internal.h
> index e25b3686bfab..90764d646e02 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -34,13 +34,15 @@
> =20
>  void page_writeback_init(void);
> =20
> -void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page);
> +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
> +						int nr_throttled);
>  static inline void acct_reclaim_writeback(struct page *page)
>  {
>  	pg_data_t *pgdat =3D page_pgdat(page);
> +	int nr_throttled =3D atomic_read(&pgdat->nr_reclaim_throttled);
> =20
> -	if (atomic_read(&pgdat->nr_reclaim_throttled))
> -		__acct_reclaim_writeback(pgdat, page);
> +	if (nr_throttled)
> +		__acct_reclaim_writeback(pgdat, page, nr_throttled);
>  }
> =20
>  vm_fault_t do_swap_page(struct vm_fault *vmf);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b58ea0b13286..2dc17de91d32 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1034,10 +1034,10 @@ reclaim_throttle(pg_data_t *pgdat, enum vmscan_thro=
ttle_state reason,
>   * pages to clean. If enough pages have been cleaned since throttling
>   * started then wakeup the throttled tasks.
>   */
> -void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
> +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
> +							int nr_throttled)
>  {
>  	unsigned long nr_written;
> -	int nr_throttled =3D atomic_read(&pgdat->nr_reclaim_throttled);
> =20
>  	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
>  	nr_written =3D node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
> @@ -3228,9 +3228,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan=
_control *sc)
>  	}
> =20
>  	/*
> -	 * Tag a node/memcg as congested if all the dirty pages
> -	 * scanned were backed by a congested BDI and
> -	 * non-kswapd tasks will stall on reclaim_throttle.
> +	 * Tag a node/memcg as congested if all the dirty pages were marked
> +	 * for writeback and immediate reclaim (counted in nr.congested).
>  	 *
>  	 * Legacy memcg will stall in page writeback so avoid forcibly
>  	 * stalling in reclaim_throttle().
> @@ -3241,8 +3240,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan=
_control *sc)
>  		set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
> =20
>  	/*
> -	 * Stall direct reclaim for IO completions if underlying BDIs
> -	 * and node is congested. Allow kswapd to continue until it
> +	 * Stall direct reclaim for IO completions if the lruvec is
> +	 * node is congested. Allow kswapd to continue until it
>  	 * starts encountering unqueued dirty pages or cycling through
>  	 * the LRU too quickly.
>  	 */
> @@ -4427,7 +4426,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags=
, int order,
> =20
>  	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, highest_zoneidx, order,
>  				      gfp_flags);
> -	wake_up_interruptible(&pgdat->kswapd_wait);
> +	wake_up_all(&pgdat->kswapd_wait);

???

That isn't the wake_up that I pointed too.

Other changes look good - thanks.

NeilBrown


>  }
> =20
>  #ifdef CONFIG_HIBERNATION
>=20
>=20
