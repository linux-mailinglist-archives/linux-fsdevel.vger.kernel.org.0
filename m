Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB21412955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 01:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhITXWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 19:22:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhITXUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:20:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8602D220BF;
        Mon, 20 Sep 2021 23:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632179954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTG5leen4lsheGEtRl+XIP6c1M4zrXLbsnzmWtAP2fg=;
        b=0PmnifexSNW1CkM5Wvo8xI+UTLtvD1h/brYNC9wlrEXICRvuaD41l7d/xPXLmWBuQIzevP
        8OtmGkeRuTHSl5TG6Ze9tLzkeoPYDP7PC4lNLiYrXYNfaI+b+WLO4ZVR2jC+E53Sy31C+g
        jreTclLqJ1O+a3xXLWB/gMXRjBYBudI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632179954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTG5leen4lsheGEtRl+XIP6c1M4zrXLbsnzmWtAP2fg=;
        b=6efB7MK0zg99DdxQyQNC5nu0tx+KnQdjfTcYNA5gLMMlp8yu0SqI0xDLsW8MkwvvdVE3Qo
        eV+PlbVFs6OSTEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F5E213B38;
        Mon, 20 Sep 2021 23:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EFA3F+4WSWGxZQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Sep 2021 23:19:10 +0000
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
        "LKML" <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
In-reply-to: <20210920085436.20939-2-mgorman@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>,
 <20210920085436.20939-2-mgorman@techsingularity.net>
Date:   Tue, 21 Sep 2021 09:19:07 +1000
Message-id: <163217994752.3992.5443677201798473600@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Sep 2021, Mel Gorman wrote:
> =20
> +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page);
> +static inline void acct_reclaim_writeback(struct page *page)
> +{
> +	pg_data_t *pgdat =3D page_pgdat(page);
> +
> +	if (atomic_read(&pgdat->nr_reclaim_throttled))
> +		__acct_reclaim_writeback(pgdat, page);

The first thing __acct_reclaim_writeback() does is repeat that
atomic_read().
Should we read it once and pass the value in to
__acct_reclaim_writeback(), or is that an unnecessary
micro-optimisation?


> +/*
> + * Account for pages written if tasks are throttled waiting on dirty
> + * pages to clean. If enough pages have been cleaned since throttling
> + * started then wakeup the throttled tasks.
> + */
> +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
> +{
> +	unsigned long nr_written;
> +	int nr_throttled =3D atomic_read(&pgdat->nr_reclaim_throttled);
> +
> +	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
> +	nr_written =3D node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
> +		READ_ONCE(pgdat->nr_reclaim_start);
> +
> +	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
> +		wake_up_interruptible_all(&pgdat->reclaim_wait);

A simple wake_up() could be used here.  "interruptible" is only needed
if non-interruptible waiters should be left alone.  "_all" is only needed
if there are some exclusive waiters.  Neither of these apply, so I think
the simpler interface is best.


> +}
> +
>  /* possible outcome of pageout() */
>  typedef enum {
>  	/* failed to write page out, page is locked */
> @@ -1412,9 +1453,8 @@ static unsigned int shrink_page_list(struct list_head=
 *page_list,
> =20
>  		/*
>  		 * The number of dirty pages determines if a node is marked
> -		 * reclaim_congested which affects wait_iff_congested. kswapd
> -		 * will stall and start writing pages if the tail of the LRU
> -		 * is all dirty unqueued pages.
> +		 * reclaim_congested. kswapd will stall and start writing
> +		 * pages if the tail of the LRU is all dirty unqueued pages.
>  		 */
>  		page_check_dirty_writeback(page, &dirty, &writeback);
>  		if (dirty || writeback)
> @@ -3180,19 +3220,20 @@ static void shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>  		 * If kswapd scans pages marked for immediate
>  		 * reclaim and under writeback (nr_immediate), it
>  		 * implies that pages are cycling through the LRU
> -		 * faster than they are written so also forcibly stall.
> +		 * faster than they are written so forcibly stall
> +		 * until some pages complete writeback.
>  		 */
>  		if (sc->nr.immediate)
> -			congestion_wait(BLK_RW_ASYNC, HZ/10);
> +			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
>  	}
> =20
>  	/*
>  	 * Tag a node/memcg as congested if all the dirty pages
>  	 * scanned were backed by a congested BDI and

"congested BDI" doesn't mean anything any more.  Is this a good time to
correct that comment.
This comment seems to refer to the test

      sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)

a few lines down.  But nr.congested is set from nr_congested which
counts when inode_write_congested() is true - almost never - and when=20
"writeback and PageReclaim()".

Is that last test the sign that we are cycling through the LRU to fast?
So the comment could become:

   Tag a node/memcg as congested if all the dirty page were
   already marked for writeback and immediate reclaim (counted in
   nr.congested).

??

Patch seems to make sense to me, but I'm not expert in this area.

Thanks!
NeilBrown
