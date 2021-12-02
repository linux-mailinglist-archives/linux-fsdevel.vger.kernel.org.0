Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163894665D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 15:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358808AbhLBO4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 09:56:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:59773 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358641AbhLBOz7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:55:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="234228697"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="234228697"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 06:52:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="541247071"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Dec 2021 06:52:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msnRo-000GPN-OZ; Thu, 02 Dec 2021 14:52:32 +0000
Date:   Thu, 2 Dec 2021 22:51:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <202112022232.gARZWe0c-lkp@intel.com>
References: <20211202131842.9217-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202131842.9217-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Mel-Gorman/mm-vmscan-Reduce-throttling-due-to-a-failure-to-make-progress/20211202-212004
base:   https://github.com/hnaz/linux-mm master
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211202/202112022232.gARZWe0c-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/01dada07590ae9c69a9415ba9af96d5ae184d861
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mel-Gorman/mm-vmscan-Reduce-throttling-due-to-a-failure-to-make-progress/20211202-212004
        git checkout 01dada07590ae9c69a9415ba9af96d5ae184d861
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/vmscan.c:1024:6: warning: no previous prototype for 'skip_throttle_noprogress' [-Wmissing-prototypes]
    1024 | bool skip_throttle_noprogress(pg_data_t *pgdat)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/skip_throttle_noprogress +1024 mm/vmscan.c

  1023	
> 1024	bool skip_throttle_noprogress(pg_data_t *pgdat)
  1025	{
  1026		int reclaimable = 0, write_pending = 0;
  1027		int i;
  1028	
  1029		/*
  1030		 * If kswapd is disabled, reschedule if necessary but do not
  1031		 * throttle as the system is likely near OOM.
  1032		 */
  1033		if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
  1034			return true;
  1035	
  1036		/*
  1037		 * If there are a lot of dirty/writeback pages then do not
  1038		 * throttle as throttling will occur when the pages cycle
  1039		 * towards the end of the LRU if still under writeback.
  1040		 */
  1041		for (i = 0; i < MAX_NR_ZONES; i++) {
  1042			struct zone *zone = pgdat->node_zones + i;
  1043	
  1044			if (!populated_zone(zone))
  1045				continue;
  1046	
  1047			reclaimable += zone_reclaimable_pages(zone);
  1048			write_pending += zone_page_state_snapshot(zone,
  1049							  NR_ZONE_WRITE_PENDING);
  1050		}
  1051		if (2 * write_pending <= reclaimable)
  1052			return true;
  1053	
  1054		return false;
  1055	}
  1056	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
