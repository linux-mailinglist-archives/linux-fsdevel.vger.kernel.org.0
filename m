Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A676A58B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 12:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB1L5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 06:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjB1L5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:57:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE27A302B7;
        Tue, 28 Feb 2023 03:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677585415; x=1709121415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8KXKh05zvvXmBiBlla6UAU9gMBZihB631H77fNyc5ms=;
  b=Kcfg7Twj3eivYPR6IiGm9VlZgGVLYQ4ucVF3gxYsbNYihnrf8+xLzkgW
   +xR9dWB6Iq+guvEqoVOj1/t/OLh/Q3ZxkuI95Ba68Qgyst+PYE8AhZgAj
   aLgXEkD4Ku/Gpp1DUFmpibUl2pL0r8RnOdOCkKxr5HeY/atC/qkQOHHlx
   u02VfzANwAz+g/bOosh34vmHSijC+52GxhONz6G5SxdQ3J+/M7VCbVTbl
   g1J8UP+9TpLQkC/5uMoNt7EJGZlMrbPTHqqt9a/u/xUMucPRQSVDQJU3T
   LcFVsGDpk8BvhtO16GC5DJBZmZFfPG9g96gcfczoz+4kts72Y3WPb4Qrg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314540212"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="314540212"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 03:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="676272332"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="676272332"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2023 03:56:31 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWyat-0005N9-0F;
        Tue, 28 Feb 2023 11:56:31 +0000
Date:   Tue, 28 Feb 2023 19:55:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg
 reclaim
Message-ID: <202302281933.vU1PHuZr-lkp@intel.com>
References: <20230228085002.2592473-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228085002.2592473-3-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yosry,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20230228]
[cannot apply to vbabka-slab/for-next xfs-linux/for-next v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-vmscan-refactor-updating-reclaimed-pages-in-reclaim_state/20230228-165214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230228085002.2592473-3-yosryahmed%40google.com
patch subject: [PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
config: i386-randconfig-a002-20230227 (https://download.01.org/0day-ci/archive/20230228/202302281933.vU1PHuZr-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f6d2b849f186a927925a29e289d60895048550f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yosry-Ahmed/mm-vmscan-refactor-updating-reclaimed-pages-in-reclaim_state/20230228-165214
        git checkout f6d2b849f186a927925a29e289d60895048550f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302281933.vU1PHuZr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:549:13: error: redefinition of 'cgroup_reclaim'
   static bool cgroup_reclaim(struct scan_control *sc)
               ^
   mm/vmscan.c:191:13: note: previous definition is here
   static bool cgroup_reclaim(struct scan_control *sc)
               ^
>> mm/vmscan.c:554:13: error: redefinition of 'global_reclaim'
   static bool global_reclaim(struct scan_control *sc)
               ^
   mm/vmscan.c:196:13: note: previous definition is here
   static bool global_reclaim(struct scan_control *sc)
               ^
   2 errors generated.


vim +/cgroup_reclaim +549 mm/vmscan.c

86750830468506 Yang Shi        2021-05-04  548  
b5ead35e7e1d34 Johannes Weiner 2019-11-30 @549  static bool cgroup_reclaim(struct scan_control *sc)
89b5fae5368f6a Johannes Weiner 2012-01-12  550  {
b5ead35e7e1d34 Johannes Weiner 2019-11-30  551  	return false;
89b5fae5368f6a Johannes Weiner 2012-01-12  552  }
97c9341f727105 Tejun Heo       2015-05-22  553  
a579086c99ed70 Yu Zhao         2022-12-21 @554  static bool global_reclaim(struct scan_control *sc)
a579086c99ed70 Yu Zhao         2022-12-21  555  {
a579086c99ed70 Yu Zhao         2022-12-21  556  	return true;
a579086c99ed70 Yu Zhao         2022-12-21  557  }
a579086c99ed70 Yu Zhao         2022-12-21  558  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
