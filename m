Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692E6EE3CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfKDPaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 10:30:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43625 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfKDPaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572881402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcgDDpXNskbpfNmglvt+lRA/X0pT5r2sa1muBARm9Tc=;
        b=B09HhwSx32vE7e8F78uwLLrlvDLgQuusbxe7UOiXa9fQ0w8Riy8SnKUeXh1PEIG5SyhAU+
        c2ieRsxYgLOGtmk0fS+pkv/R5SsXG7PHSyx/u449RYpfRJnZfQRYqRNT+eTwN7anPz4Y0o
        AyyVG10csMifjpZn2DldhDKSbCyM7Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Oze8pseKP-emimqWNAKh_Q-1; Mon, 04 Nov 2019 10:29:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53ECD800C73;
        Mon,  4 Nov 2019 15:29:57 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A46C85D9CD;
        Mon,  4 Nov 2019 15:29:56 +0000 (UTC)
Date:   Mon, 4 Nov 2019 10:29:54 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/28] shrinker: defer work only to kswapd
Message-ID: <20191104152954.GC10665@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-13-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-13-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Oze8pseKP-emimqWNAKh_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:02AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Right now deferred work is picked up by whatever GFP_KERNEL context
> reclaimer that wins the race to empty the node's deferred work
> counter. However, if there are lots of direct reclaimers, that
> work might be continually picked up by contexts taht can't do any
> work and so the opportunities to do the work are missed by contexts
> that could do them.
>=20
> A further problem with the current code is that the deferred work
> can be picked up by a random direct reclaimer, resulting in that
> specific process having to do all the deferred reclaim work and
> hence can take extremely long latencies if the reclaim work blocks
> regularly. This is not good for direct reclaim fairness or for
> minimising long tail latency events.
>=20
> To avoid these problems, simply limit deferred work to kswapd
> contexts. We know kswapd is a context that can always do reclaim
> work, and hence deferring work to kswapd allows the deferred work to
> be done in the background and not adversely affect any specific
> process context doing direct reclaim.
>=20
> The advantage of this is that amount of work to be done in direct
> reclaim is now bound and predictable - it is entirely based on
> the cache's freeable objects and the reclaim priority. hence all
> direct reclaimers running at the same time should be doing
> relatively equal amounts of work, thereby reducing the incidence of
> long tail latencies due to uneven reclaim workloads.
>=20
> Note that we use signed integers for everything except the freed
> count as the returns from the shrinker callouts cannot be guaranteed
> untainted. Indeed, the shrinkers can return scan counts larger that
> were fed in, so we need scan counts to underflow in a detectable
> manner to terminate loops. This is necessary to avoid a misbehaving
> shrinker from triggering endless scanning loops.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/linux/shrinker.h |   2 +-
>  mm/vmscan.c              | 100 ++++++++++++++++++++-------------------
>  2 files changed, 53 insertions(+), 49 deletions(-)
>=20
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 3405c39ab92c..30c10f42109f 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -81,7 +81,7 @@ struct shrinker {
>  =09int id;
>  #endif
>  =09/* objs pending delete, per node */
> -=09atomic_long_t *nr_deferred;
> +=09atomic64_t *nr_deferred;
>  };
>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
> =20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2d39ec37c04d..c0e2bf656e3f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -517,16 +517,16 @@ static int64_t shrink_scan_count(struct shrink_cont=
rol *shrinkctl,
>  static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  =09=09=09=09    struct shrinker *shrinker, int priority)
>  {
> -=09unsigned long freed =3D 0;
> -=09long total_scan;
> +=09uint64_t freed =3D 0;
>  =09int64_t freeable_objects =3D 0;
>  =09int64_t scan_count;
> -=09long nr;
> -=09long new_nr;
> +=09int64_t scanned_objects =3D 0;
> +=09int64_t next_deferred =3D 0;
> +=09int64_t deferred_count =3D 0;
> +=09int64_t new_nr;
>  =09int nid =3D shrinkctl->nid;
>  =09long batch_size =3D shrinker->batch ? shrinker->batch
>  =09=09=09=09=09  : SHRINK_BATCH;
> -=09long scanned =3D 0, next_deferred;
> =20
>  =09if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>  =09=09nid =3D 0;
> @@ -537,47 +537,51 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
>  =09=09return scan_count;
> =20
>  =09/*
> -=09 * copy the current shrinker scan count into a local variable
> -=09 * and zero it so that other concurrent shrinker invocations
> -=09 * don't also do this scanning work.
> -=09 */
> -=09nr =3D atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> -
> -=09total_scan =3D nr + scan_count;
> -=09if (total_scan < 0) {
> -=09=09pr_err("shrink_slab: %pS negative objects to delete nr=3D%ld\n",
> -=09=09       shrinker->scan_objects, total_scan);
> -=09=09total_scan =3D scan_count;
> -=09=09next_deferred =3D nr;
> -=09} else
> -=09=09next_deferred =3D total_scan;
> -
> -=09/*
> -=09 * We need to avoid excessive windup on filesystem shrinkers
> -=09 * due to large numbers of GFP_NOFS allocations causing the
> -=09 * shrinkers to return -1 all the time. This results in a large
> -=09 * nr being built up so when a shrink that can do some work
> -=09 * comes along it empties the entire cache due to nr >>>
> -=09 * freeable. This is bad for sustaining a working set in
> -=09 * memory.
> +=09 * If kswapd, we take all the deferred work and do it here. We don't =
let
> +=09 * direct reclaim do this, because then it means some poor sod is goi=
ng
> +=09 * to have to do somebody else's GFP_NOFS reclaim, and it hides the r=
eal
> +=09 * amount of reclaim work from concurrent kswapd operations. Hence we=
 do
> +=09 * the work in the wrong place, at the wrong time, and it's largely
> +=09 * unpredictable.
>  =09 *
> -=09 * Hence only allow the shrinker to scan the entire cache when
> -=09 * a large delta change is calculated directly.
> +=09 * By doing the deferred work only in kswapd, we can schedule the wor=
k
> +=09 * according the the reclaim priority - low priority reclaim will do
> +=09 * less deferred work, hence we'll do more of the deferred work the m=
ore
> +=09 * desperate we become for free memory. This avoids the need for need=
ing
> +=09 * to specifically avoid deferred work windup as low amount os memory
> +=09 * pressure won't excessive trim caches anymore.

That last sentence is hard to read. ;)

>  =09 */
> -=09if (scan_count < freeable_objects / 4)
> -=09=09total_scan =3D min_t(long, total_scan, freeable_objects / 2);
> +=09if (current_is_kswapd()) {
> +=09=09int64_t=09deferred_scan;
> +
> +=09=09deferred_count =3D atomic64_xchg(&shrinker->nr_deferred[nid], 0);
> +
> +=09=09/* we want to scan 5-10% of the deferred work here at minimum */
> +=09=09deferred_scan =3D deferred_count;
> +=09=09if (priority)
> +=09=09=09do_div(deferred_scan, priority);
> +=09=09scan_count +=3D deferred_scan;
> +
> +=09=09/*
> +=09=09 * If there is more deferred work than the number of freeable
> +=09=09 * items in the cache, limit the amount of work we will carry
> +=09=09 * over to the next kswapd run on this cache. This prevents
> +=09=09 * deferred work windup.
> +=09=09 */
> +=09=09deferred_count =3D min(deferred_count, freeable_objects * 2);
> +

Extra whitespace above.

> +=09}
> =20
>  =09/*
>  =09 * Avoid risking looping forever due to too large nr value:
>  =09 * never try to free more than twice the estimate number of
>  =09 * freeable entries.
>  =09 */

The comment refers to a variable that no longer exists.

I also wonder if it's a little cleaner to move the deferred_count =3D
min(...); statement above down here and condense the two comments.

> -=09if (total_scan > freeable_objects * 2)
> -=09=09total_scan =3D freeable_objects * 2;
> +=09scan_count =3D min(scan_count, freeable_objects * 2);
> =20
> -=09trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> +=09trace_mm_shrink_slab_start(shrinker, shrinkctl, deferred_count,
>  =09=09=09=09   freeable_objects, scan_count,
> -=09=09=09=09   total_scan, priority);
> +=09=09=09=09   scan_count, priority);
> =20
>  =09/*
>  =09 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> @@ -601,10 +605,10 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
>  =09 * scanning at high prio and therefore should try to reclaim as much =
as
>  =09 * possible.
>  =09 */
> -=09while (total_scan >=3D batch_size ||
> -=09       total_scan >=3D freeable_objects) {
> +=09while (scan_count >=3D batch_size ||
> +=09       scan_count >=3D freeable_objects) {
>  =09=09unsigned long ret;
> -=09=09unsigned long nr_to_scan =3D min(batch_size, total_scan);
> +=09=09unsigned long nr_to_scan =3D min_t(long, batch_size, scan_count);
> =20
>  =09=09shrinkctl->nr_to_scan =3D nr_to_scan;
>  =09=09shrinkctl->nr_scanned =3D nr_to_scan;
> @@ -614,29 +618,29 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
>  =09=09freed +=3D ret;
> =20
>  =09=09count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
> -=09=09total_scan -=3D shrinkctl->nr_scanned;
> -=09=09scanned +=3D shrinkctl->nr_scanned;
> +=09=09scan_count -=3D shrinkctl->nr_scanned;
> +=09=09scanned_objects +=3D shrinkctl->nr_scanned;
> =20
>  =09=09cond_resched();
>  =09}
> -
>  done:
> -=09if (next_deferred >=3D scanned)
> -=09=09next_deferred -=3D scanned;
> +=09if (deferred_count)
> +=09=09next_deferred =3D deferred_count - scanned_objects;
>  =09else
> -=09=09next_deferred =3D 0;
> +=09=09next_deferred =3D scan_count;

Hmm.. so if there was no deferred count on this cycle, we set
next_deferred to whatever is left from scan_count and add that back into
the shrinker struct below. If there was a pending deferred count on this
cycle, we subtract what we scanned from that and add that value back.
But what happens to the remaining scan_count in the latter case? Is it
lost, or am I missing something?

For example, suppose we start this cycle with a large scan_count and
->scan_objects() returned SHRINK_STOP before doing much work. In that
scenario, it looks like whether ->nr_deferred is 0 or not is the only
thing that determines whether we defer the entire remaining scan_count
or just what is left from the previous ->nr_deferred. The existing code
appears to consistently factor in what is left from the current scan
with the previous deferred count. Hm?

>  =09/*
>  =09 * move the unused scan count back into the shrinker in a
>  =09 * manner that handles concurrent updates. If we exhausted the
>  =09 * scan, there is no need to do an update.
>  =09 */
>  =09if (next_deferred > 0)
> -=09=09new_nr =3D atomic_long_add_return(next_deferred,
> +=09=09new_nr =3D atomic64_add_return(next_deferred,
>  =09=09=09=09=09=09&shrinker->nr_deferred[nid]);
>  =09else
> -=09=09new_nr =3D atomic_long_read(&shrinker->nr_deferred[nid]);
> +=09=09new_nr =3D atomic64_read(&shrinker->nr_deferred[nid]);

It looks like we could kill new_nr and just reuse next_deferred here
too.

Brian

> =20
> -=09trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan=
);
> +=09trace_mm_shrink_slab_end(shrinker, nid, freed, deferred_count, new_nr=
,
> +=09=09=09=09=09scan_count);
>  =09return freed;
>  }
> =20
> --=20
> 2.24.0.rc0
>=20

