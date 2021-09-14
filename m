Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF940BAB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 23:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhINVtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 17:49:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41496 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhINVth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:49:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E49C220CD;
        Tue, 14 Sep 2021 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631656098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhFSWrxHkd6OQeorqDO+a0YPv78ije3lBSiZuteI3EA=;
        b=aongA3E4O9BouWJkziSrMVBjk0OTypYyrsp8H6X22lE/LtFF93au63SIGCt58gUosr771i
        UWHomHg/03xCMmneZV8XEWJJhDhm/CC6E8RQ+maOnYIFJxr+HlVG83IYJnyHzCC410fcv5
        1vmfQION2u7vQLOh0fqG/ddm0lLXtvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631656098;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhFSWrxHkd6OQeorqDO+a0YPv78ije3lBSiZuteI3EA=;
        b=BpFJU9XtY1VTa3+zYvLpvxVFLuV8HIA6/xnOjnpabxX356XtaP/abbkYvu1tAry4agIvuz
        mcqZu6xBRKvjmGCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2096313B4D;
        Tue, 14 Sep 2021 21:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 16E+NJ0YQWHBQAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 21:48:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@suse.de>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, "Jan Kara" <jack@suse.cz>,
        "Michal Hocko" <mhocko@suse.com>,
        "Matthew Wilcox" <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
In-reply-to: <20210914163432.GR3828@suse.com>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>,
 <163157838437.13293.14244628630141187199.stgit@noble.brown>,
 <20210914163432.GR3828@suse.com>
Date:   Wed, 15 Sep 2021 07:48:11 +1000
Message-id: <163165609100.3992.1570739756456048657@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Sep 2021, Mel Gorman wrote:
> On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > Indefinite loops waiting for memory allocation are discouraged by
> > documentation in gfp.h which says the use of __GFP_NOFAIL that it
> >=20
> >  is definitely preferable to use the flag rather than opencode endless
> >  loop around allocator.
> >=20
> > Such loops that use congestion_wait() are particularly unwise as
> > congestion_wait() is indistinguishable from
> > schedule_timeout_uninterruptible() in practice - and should be
> > deprecated.
> >=20
> > So this patch changes the two loops in ext4_ext_truncate() to use
> > __GFP_NOFAIL instead of looping.
> >=20
> > As the allocation is multiple layers deeper in the call stack, this
> > requires passing the EXT4_EX_NOFAIL flag down and handling it in various
> > places.
> >=20
> > Of particular interest is the ext4_journal_start family of calls which
> > can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
> > as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
> > a high bit, so it is safe in practice.
> >=20
> > jbd2__journal_start() is enhanced so that the gfp_t flags passed are
> > used for *all* allocations.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> I'm not a fan. GFP_NOFAIL allows access to emergency reserves increasing
> the risk of a livelock if memory is completely depleted where as some
> callers can afford to wait.

Maybe we should wind back and focus on the documentation patches.
As quoted above, mm.h says:

> >  is definitely preferable to use the flag rather than opencode endless
> >  loop around allocator.

but you seem to be saying that is wrong.  I'd certainly like to get the
documentation right before changing any code.

Why does __GFP_NOFAIL access the reserves? Why not require that the
relevant "Try harder" flag (__GFP_ATOMIC or __GFP_MEMALLOC) be included
with __GFP_NOFAIL if that is justified?

There are over 100 __GFP_NOFAIL allocation sites.  I don't feel like
reviewing them all and seeing if any really need a try-harder flag.
Can we rename __GFP_NOFAIL to __GFP_NEVERFAIL and then
#define __GFP_NOFAIL (__GFP_NEVERFAIL | __GFP_ATOMIC)
and encourage the use of __GFP_NEVERFAIL in future?

When __GFP_NOFAIL loops, it calls congestion_wait() internally.  That
certainly needs to be fixed and the ideas you present below are
certainly worth considering when trying to understand how to address
that.  I'd rather fix it once there in page_alloc.c rather then export a
waiting API like congestion_wait().  That would provide more
flexibility.  e.g.  a newly freed page could be handed directly back to
the waiter.

Thanks,
NeilBrown



>=20
> The key event should be reclaim making progress. The hack below is
> intended to vaguely demonstrate how blocking can be based on reclaim
> making progress instead of "congestion" but has not even been booted. A
> more complete overhaul may involve introducing
> reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout, nodemask_t *=
nodemask)
> and
> reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout)
> and converting congestion_wait and wait_iff_congestion to calling
> reclaim_congestion_wait_nodemask which waits on the first usable node
> and then audit every single congestion_wait() user to see which API
> they should call. Further work would be to establish whether the page alloc=
ator should
> call reclaim_congestion_wait_nodemask() if direct reclaim is not making
> progress or whether that should be in vmscan.c. Conceivably, GFP_NOFAIL
> could then soften its access to emergency reserves but I haven't given
> it much thought.
>=20
> Yes it's significant work, but it would be a better than letting
> __GFP_NOFAIL propagate further and kicking us down the road.
>=20
> This hack is terrible, it's not the right way to do it, it's just to
> illustrate the idea of "waiting on memory should be based on reclaim
> making progress and not the state of storage" is not impossible.
>=20
> --8<--
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 5c0318509f9e..5ed81c5746ec 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -832,6 +832,7 @@ typedef struct pglist_data {
>  	unsigned long node_spanned_pages; /* total size of physical page
>  					     range, including holes */
>  	int node_id;
> +	wait_queue_head_t reclaim_wait;
>  	wait_queue_head_t kswapd_wait;
>  	wait_queue_head_t pfmemalloc_wait;
>  	struct task_struct *kswapd;	/* Protected by
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 6122c78ce914..21a9cd693d12 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/writeback.h>
>  #include <linux/device.h>
> +#include <linux/swap.h>
>  #include <trace/events/writeback.h>
> =20
>  struct backing_dev_info noop_backing_dev_info;
> @@ -1013,25 +1014,41 @@ void set_bdi_congested(struct backing_dev_info *bdi=
, int sync)
>  EXPORT_SYMBOL(set_bdi_congested);
> =20
>  /**
> - * congestion_wait - wait for a backing_dev to become uncongested
> - * @sync: SYNC or ASYNC IO
> - * @timeout: timeout in jiffies
> + * congestion_wait - the docs are now worthless but avoiding a rename
>   *
> - * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) to=
 exit
> - * write congestion.  If no backing_devs are congested then just wait for =
the
> - * next write to be completed.
> + * New thing -- wait for a timeout or reclaim to make progress
>   */
>  long congestion_wait(int sync, long timeout)
>  {
> +	pg_data_t *pgdat;
>  	long ret;
>  	unsigned long start =3D jiffies;
>  	DEFINE_WAIT(wait);
> -	wait_queue_head_t *wqh =3D &congestion_wqh[sync];
> +	wait_queue_head_t *wqh;
> =20
> -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> -	ret =3D io_schedule_timeout(timeout);
> +	/* Never let kswapd sleep on itself */
> +	if (current_is_kswapd())
> +		goto trace;
> +
> +	/*
> +	 * Dangerous, local memory may be forbidden by cpuset or policies,
> +	 * use first eligible zone in zonelists node instead
> +	 */
> +	preempt_disable();
> +	pgdat =3D NODE_DATA(smp_processor_id());
> +	preempt_enable();
> +	wqh =3D &pgdat->reclaim_wait;
> +
> +	/*
> +	 * Should probably check watermark of suitable zones here
> +	 * in case this is spuriously called
> +	 */
> +
> +	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
> +	ret =3D schedule_timeout(timeout);
>  	finish_wait(wqh, &wait);
> =20
> +trace:
>  	trace_writeback_congestion_wait(jiffies_to_usecs(timeout),
>  					jiffies_to_usecs(jiffies - start));
> =20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5b09e71c9ce7..4b87b73d1264 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7418,6 +7418,7 @@ static void __meminit pgdat_init_internals(struct pgl=
ist_data *pgdat)
>  	pgdat_init_split_queue(pgdat);
>  	pgdat_init_kcompactd(pgdat);
> =20
> +	init_waitqueue_head(&pgdat->reclaim_wait);
>  	init_waitqueue_head(&pgdat->kswapd_wait);
>  	init_waitqueue_head(&pgdat->pfmemalloc_wait);
> =20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 158c9c93d03c..0ac2cf6be5e3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2888,6 +2888,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, stru=
ct scan_control *sc)
>  	} while ((memcg =3D mem_cgroup_iter(target_memcg, memcg, NULL)));
>  }
> =20
> +static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneid=
x);
> +
>  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	struct reclaim_state *reclaim_state =3D current->reclaim_state;
> @@ -3070,6 +3072,18 @@ static void shrink_node(pg_data_t *pgdat, struct sca=
n_control *sc)
>  				    sc))
>  		goto again;
> =20
> +	/*
> +	 * Might be race-prone, more appropriate to do this when exiting
> +	 * direct reclaim and when kswapd finds that pgdat is balanced.
> +	 * May also be appropriate to update pgdat_balanced to take
> +	 * a watermark level and wakeup when min watermarks are ok
> +	 * instead of waiting for the high watermark
> +	 */
> +	if (waitqueue_active(&pgdat->reclaim_wait) &&
> +	    pgdat_balanced(pgdat, 0, ZONE_MOVABLE)) {
> +		wake_up_interruptible(&pgdat->reclaim_wait);
> +	}
> +
>  	/*
>  	 * Kswapd gives up on balancing particular nodes after too
>  	 * many failures to reclaim anything from them and goes to
>=20
>=20
