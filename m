Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E16A587F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjB1Lpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 06:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjB1Lph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:45:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1E01DB8B;
        Tue, 28 Feb 2023 03:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677584736; x=1709120736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVg3sGlt00QgG3sEB9rSq0uJyw0mKZJvOIL+heEjZDw=;
  b=cXi0DUXVNbfMj4l8aLcSYthihv5pxAkm+t9KoJNBUMqsKxIpIatKcxET
   X53ETFyM5xTAS/8MLPVk3iuHyOAiMnPSDBVCzflLrNgEgJxBn91v79EhF
   tV5yVOKLGXD/SCBJWFKEnLNaCHDNLqrLqAGcZJo3WjIa2TD1U7Px2BmDs
   B+hUcU+k44SihdZW1NDIqYZNqlx7tAtbE6nbleHWdAsPeLvUX+PQomc4w
   kFUCZld4GcR7N82o7pYzBOxb6X6AwH8VUxfDG351UM1Ctrp+k/m6nPuBa
   6VlKRTt44bUpJtmbQ0xbv50B84Z0rAgeNjNCm7pWSfsViDbT0S1tNrc5B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="332841407"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="332841407"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 03:45:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="783805950"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="783805950"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2023 03:45:31 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWyQE-0005Mt-2S;
        Tue, 28 Feb 2023 11:45:30 +0000
Date:   Tue, 28 Feb 2023 19:45:25 +0800
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
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg
 reclaim
Message-ID: <202302281959.EmOJaeae-lkp@intel.com>
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
[cannot apply to vbabka-slab/for-next xfs-linux/for-next v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-vmscan-refactor-updating-reclaimed-pages-in-reclaim_state/20230228-165214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230228085002.2592473-3-yosryahmed%40google.com
patch subject: [PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
config: x86_64-randconfig-a014-20230227 (https://download.01.org/0day-ci/archive/20230228/202302281959.EmOJaeae-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f6d2b849f186a927925a29e289d60895048550f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yosry-Ahmed/mm-vmscan-refactor-updating-reclaimed-pages-in-reclaim_state/20230228-165214
        git checkout f6d2b849f186a927925a29e289d60895048550f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302281959.EmOJaeae-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:549:13: error: redefinition of 'cgroup_reclaim'
     549 | static bool cgroup_reclaim(struct scan_control *sc)
         |             ^~~~~~~~~~~~~~
   mm/vmscan.c:191:13: note: previous definition of 'cgroup_reclaim' with type 'bool(struct scan_control *)' {aka '_Bool(struct scan_control *)'}
     191 | static bool cgroup_reclaim(struct scan_control *sc)
         |             ^~~~~~~~~~~~~~
>> mm/vmscan.c:554:13: error: redefinition of 'global_reclaim'
     554 | static bool global_reclaim(struct scan_control *sc)
         |             ^~~~~~~~~~~~~~
   mm/vmscan.c:196:13: note: previous definition of 'global_reclaim' with type 'bool(struct scan_control *)' {aka '_Bool(struct scan_control *)'}
     196 | static bool global_reclaim(struct scan_control *sc)
         |             ^~~~~~~~~~~~~~
   mm/vmscan.c:196:13: warning: 'global_reclaim' defined but not used [-Wunused-function]


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
