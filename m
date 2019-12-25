Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5FB12A7F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 14:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfLYNCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 08:02:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:20249 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLYNCN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:02:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 05:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,355,1571727600"; 
   d="gz'50?scan'50,208,50";a="219656733"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Dec 2019 05:02:09 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ik6Ii-000EBi-Rz; Wed, 25 Dec 2019 21:02:08 +0800
Date:   Wed, 25 Dec 2019 21:01:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     kbuild-all@lists.01.org, hannes@cmpxchg.org, david@fromorbit.com,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 5/5] memcg, inode: protect page cache from freeing
 inode
Message-ID: <201912252008.Lm7IU6Lm%lkp@intel.com>
References: <1577174006-13025-6-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="urjkd25lfriyrrbj"
Content-Disposition: inline
In-Reply-To: <1577174006-13025-6-git-send-email-laoar.shao@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--urjkd25lfriyrrbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yafang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.5-rc3 next-20191219]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Yafang-Shao/protect-page-cache-from-freeing-inode/20191225-193636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 46cf053efec6a3a5f343fead837777efe8252a46
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/swap.h:9:0,
                    from mm/vmscan.c:22:
   include/linux/memcontrol.h:872:23: error: conflicting types for 'memcg'
            struct inode *memcg)
                          ^~~~~
   include/linux/memcontrol.h:871:63: note: previous definition of 'memcg' was here
    static inline bool memcg_can_reclaim_inode(struct mem_cgroup *memcg,
                                                                  ^~~~~
   mm/vmscan.c: In function 'shrink_node_memcgs':
>> mm/vmscan.c:2670:9: error: dereferencing pointer to incomplete type 'struct mem_cgroup'
       memcg->in_low_reclaim = 1;
            ^~
--
   In file included from include/linux/swap.h:9:0,
                    from fs/inode.c:11:
   include/linux/memcontrol.h:872:23: error: conflicting types for 'memcg'
            struct inode *memcg)
                          ^~~~~
   include/linux/memcontrol.h:871:63: note: previous definition of 'memcg' was here
    static inline bool memcg_can_reclaim_inode(struct mem_cgroup *memcg,
                                                                  ^~~~~
   fs/inode.c: In function 'prune_icache_sb':
>> fs/inode.c:822:7: error: 'struct inode_head' has no member named 'memcg'
     ihead.memcg = sc->memcg;
          ^

vim +2670 mm/vmscan.c

  2639	
  2640	static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
  2641	{
  2642		struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
  2643		struct mem_cgroup *memcg;
  2644	
  2645		memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
  2646		do {
  2647			struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
  2648			unsigned long reclaimed;
  2649			unsigned long scanned;
  2650	
  2651			switch (mem_cgroup_protected(target_memcg, memcg)) {
  2652			case MEMCG_PROT_MIN:
  2653				/*
  2654				 * Hard protection.
  2655				 * If there is no reclaimable memory, OOM.
  2656				 */
  2657				continue;
  2658			case MEMCG_PROT_LOW:
  2659				/*
  2660				 * Soft protection.
  2661				 * Respect the protection only as long as
  2662				 * there is an unprotected supply
  2663				 * of reclaimable memory from other cgroups.
  2664				 */
  2665				if (!sc->memcg_low_reclaim) {
  2666					sc->memcg_low_skipped = 1;
  2667					continue;
  2668				}
  2669	
> 2670				memcg->in_low_reclaim = 1;
  2671				memcg_memory_event(memcg, MEMCG_LOW);
  2672				break;
  2673			case MEMCG_PROT_NONE:
  2674				/*
  2675				 * All protection thresholds breached. We may
  2676				 * still choose to vary the scan pressure
  2677				 * applied based on by how much the cgroup in
  2678				 * question has exceeded its protection
  2679				 * thresholds (see get_scan_count).
  2680				 */
  2681				break;
  2682			case MEMCG_PROT_SKIP:
  2683				/*
  2684				 * Skip scanning this memcg if the usage of it is
  2685				 * zero.
  2686				 */
  2687				continue;
  2688			}
  2689	
  2690			reclaimed = sc->nr_reclaimed;
  2691			scanned = sc->nr_scanned;
  2692	
  2693			shrink_lruvec(lruvec, sc);
  2694	
  2695			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
  2696				    sc->priority);
  2697	
  2698			if (memcg->in_low_reclaim)
  2699				memcg->in_low_reclaim = 0;
  2700	
  2701			/* Record the group's reclaim efficiency */
  2702			vmpressure(sc->gfp_mask, memcg, false,
  2703				   sc->nr_scanned - scanned,
  2704				   sc->nr_reclaimed - reclaimed);
  2705	
  2706		} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
  2707	}
  2708	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--urjkd25lfriyrrbj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
uhs+b8q8+T/w16fUQIIAAA==

--urjkd25lfriyrrbj--
