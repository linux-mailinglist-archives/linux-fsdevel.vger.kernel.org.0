Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0292850CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbfHGQNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 12:13:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:62225 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388257AbfHGQNz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:13:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 09:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="182325788"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2019 09:13:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvOZV-0006Ja-5r; Thu, 08 Aug 2019 00:13:53 +0800
Date:   Thu, 8 Aug 2019 00:12:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kbuild-all@01.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/24] shrinker: defer work only to kswapd
Message-ID: <201908080021.L0zJBvz1%lkp@intel.com>
References: <20190801021752.4986-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-5-david@fromorbit.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc3 next-20190807]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dave-Chinner/mm-xfs-non-blocking-inode-reclaim/20190804-042311
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> mm/vmscan.c:539:70: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected struct atomic64_t [usertype] *v @@    got ruct atomic64_t [usertype] *v @@
>> mm/vmscan.c:539:70: sparse:    expected struct atomic64_t [usertype] *v
>> mm/vmscan.c:539:70: sparse:    got struct atomic_t [usertype] *
   arch/x86/include/asm/irqflags.h:54:9: sparse: sparse: context imbalance in 'check_move_unevictable_pages' - unexpected unlock

vim +539 mm/vmscan.c

   498	
   499	static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
   500					    struct shrinker *shrinker, int priority)
   501	{
   502		unsigned long freed = 0;
   503		int64_t freeable_objects = 0;
   504		int64_t scan_count;
   505		int64_t scanned_objects = 0;
   506		int64_t next_deferred = 0;
   507		int64_t deferred_count = 0;
   508		long new_nr;
   509		int nid = shrinkctl->nid;
   510		long batch_size = shrinker->batch ? shrinker->batch
   511						  : SHRINK_BATCH;
   512	
   513		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
   514			nid = 0;
   515	
   516		scan_count = shrink_scan_count(shrinkctl, shrinker, priority,
   517						&freeable_objects);
   518		if (scan_count == 0 || scan_count == SHRINK_EMPTY)
   519			return scan_count;
   520	
   521		/*
   522		 * If kswapd, we take all the deferred work and do it here. We don't let
   523		 * direct reclaim do this, because then it means some poor sod is going
   524		 * to have to do somebody else's GFP_NOFS reclaim, and it hides the real
   525		 * amount of reclaim work from concurrent kswapd operations. Hence we do
   526		 * the work in the wrong place, at the wrong time, and it's largely
   527		 * unpredictable.
   528		 *
   529		 * By doing the deferred work only in kswapd, we can schedule the work
   530		 * according the the reclaim priority - low priority reclaim will do
   531		 * less deferred work, hence we'll do more of the deferred work the more
   532		 * desperate we become for free memory. This avoids the need for needing
   533		 * to specifically avoid deferred work windup as low amount os memory
   534		 * pressure won't excessive trim caches anymore.
   535		 */
   536		if (current_is_kswapd()) {
   537			int64_t	deferred_scan;
   538	
 > 539			deferred_count = atomic64_xchg(&shrinker->nr_deferred[nid], 0);
   540	
   541			/* we want to scan 5-10% of the deferred work here at minimum */
   542			deferred_scan = deferred_count;
   543			if (priority)
   544				do_div(deferred_scan, priority);
   545			scan_count += deferred_scan;
   546	
   547			/*
   548			 * If there is more deferred work than the number of freeable
   549			 * items in the cache, limit the amount of work we will carry
   550			 * over to the next kswapd run on this cache. This prevents
   551			 * deferred work windup.
   552			 */
   553			if (deferred_count > freeable_objects * 2)
   554				deferred_count = freeable_objects * 2;
   555	
   556		}
   557	
   558		/*
   559		 * Avoid risking looping forever due to too large nr value:
   560		 * never try to free more than twice the estimate number of
   561		 * freeable entries.
   562		 */
   563		if (scan_count > freeable_objects * 2)
   564			scan_count = freeable_objects * 2;
   565	
   566		trace_mm_shrink_slab_start(shrinker, shrinkctl, deferred_count,
   567					   freeable_objects, scan_count,
   568					   scan_count, priority);
   569	
   570		/*
   571		 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
   572		 * defer the work to a context that can scan the cache.
   573		 */
   574		if (shrinkctl->will_defer)
   575			goto done;
   576	
   577		/*
   578		 * Normally, we should not scan less than batch_size objects in one
   579		 * pass to avoid too frequent shrinker calls, but if the slab has less
   580		 * than batch_size objects in total and we are really tight on memory,
   581		 * we will try to reclaim all available objects, otherwise we can end
   582		 * up failing allocations although there are plenty of reclaimable
   583		 * objects spread over several slabs with usage less than the
   584		 * batch_size.
   585		 *
   586		 * We detect the "tight on memory" situations by looking at the total
   587		 * number of objects we want to scan (total_scan). If it is greater
   588		 * than the total number of objects on slab (freeable), we must be
   589		 * scanning at high prio and therefore should try to reclaim as much as
   590		 * possible.
   591		 */
   592		while (scan_count >= batch_size ||
   593		       scan_count >= freeable_objects) {
   594			unsigned long ret;
   595			unsigned long nr_to_scan = min_t(long, batch_size, scan_count);
   596	
   597			shrinkctl->nr_to_scan = nr_to_scan;
   598			shrinkctl->nr_scanned = nr_to_scan;
   599			ret = shrinker->scan_objects(shrinker, shrinkctl);
   600			if (ret == SHRINK_STOP)
   601				break;
   602			freed += ret;
   603	
   604			count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
   605			scan_count -= shrinkctl->nr_scanned;
   606			scanned_objects += shrinkctl->nr_scanned;
   607	
   608			cond_resched();
   609		}
   610	
   611	done:
   612		if (deferred_count)
   613			next_deferred = deferred_count - scanned_objects;
   614		else if (scan_count > 0)
   615			next_deferred = scan_count;
   616		/*
   617		 * move the unused scan count back into the shrinker in a
   618		 * manner that handles concurrent updates. If we exhausted the
   619		 * scan, there is no need to do an update.
   620		 */
   621		if (next_deferred > 0)
   622			new_nr = atomic_long_add_return(next_deferred,
   623							&shrinker->nr_deferred[nid]);
   624		else
   625			new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
   626	
   627		trace_mm_shrink_slab_end(shrinker, nid, freed, deferred_count, new_nr,
   628						scan_count);
   629		return freed;
   630	}
   631	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
