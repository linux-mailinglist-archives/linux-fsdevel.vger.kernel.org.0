Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D711D6B3455
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 03:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCJCiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 21:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCJCiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:38:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5F30E6;
        Thu,  9 Mar 2023 18:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678415876; x=1709951876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a49MuUqY9uTekKka3fjSfGx7KEeZta0jUytQypcPsz4=;
  b=NBMWznDdDXBUP28JrQIKgX39GTrDDLvDhmA2XxM3FfnD2y0m8LUX0SLW
   yZH5e4cLS8HYxGq8neMC0Qi0I0nVKQHKJcUVUg/5kF1n5CEcwfypTIJ+I
   dNOcexVjFX/17BTWuTJsZhpcyD34tyYR7d6k8hftlwvemjrP7LuU0dZii
   k4wIwS7u+VzL98MgYKlOiwt+4De8E6r8cg+Lafu3kgsvr0BdYk05SFjOk
   CVV8enYhTDZpeEZ6Qu2Y2nQ9uotNFahLL300I86s64HFJUML62Y0yiL24
   yjrp54NT3C85teApsyJ8qXLMsglEEBHMbR/HjH6G9WzWVnGNH+hgW69XK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335325555"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="335325555"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 18:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801413998"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="801413998"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 18:37:50 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paSdh-0003OJ-03;
        Fri, 10 Mar 2023 02:37:49 +0000
Date:   Fri, 10 Mar 2023 10:37:25 +0800
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
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v2 2/3] mm: vmscan: refactor updating reclaimed pages in
 reclaim_state
Message-ID: <202303101037.13QFIjZH-lkp@intel.com>
References: <20230309093109.3039327-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309093109.3039327-3-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yosry,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on xfs-linux/for-next]
[also build test ERROR on linus/master v6.3-rc1 next-20230309]
[cannot apply to akpm-mm/mm-everything vbabka-slab/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-vmscan-move-set_task_reclaim_state-after-cgroup_reclaim/20230309-173354
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20230309093109.3039327-3-yosryahmed%40google.com
patch subject: [PATCH v2 2/3] mm: vmscan: refactor updating reclaimed pages in reclaim_state
config: powerpc-g5_defconfig (https://download.01.org/0day-ci/archive/20230310/202303101037.13QFIjZH-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/63df60b27250f3f7a2892f99f27258b60a6e8e13
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yosry-Ahmed/mm-vmscan-move-set_task_reclaim_state-after-cgroup_reclaim/20230309-173354
        git checkout 63df60b27250f3f7a2892f99f27258b60a6e8e13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/ drivers/net/usb/ fs/xfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303101037.13QFIjZH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/xfs/xfs_buf.c:289:2: error: call to undeclared function 'report_freed_pages'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           report_freed_pages(bp->b_page_count);
           ^
   fs/xfs/xfs_buf.c:289:2: note: did you mean 'mempool_free_pages'?
   include/linux/mempool.h:102:6: note: 'mempool_free_pages' declared here
   void mempool_free_pages(void *element, void *pool_data);
        ^
   1 error generated.


vim +/report_freed_pages +289 fs/xfs/xfs_buf.c

   273	
   274	static void
   275	xfs_buf_free_pages(
   276		struct xfs_buf	*bp)
   277	{
   278		uint		i;
   279	
   280		ASSERT(bp->b_flags & _XBF_PAGES);
   281	
   282		if (xfs_buf_is_vmapped(bp))
   283			vm_unmap_ram(bp->b_addr, bp->b_page_count);
   284	
   285		for (i = 0; i < bp->b_page_count; i++) {
   286			if (bp->b_pages[i])
   287				__free_page(bp->b_pages[i]);
   288		}
 > 289		report_freed_pages(bp->b_page_count);
   290	
   291		if (bp->b_pages != bp->b_page_array)
   292			kmem_free(bp->b_pages);
   293		bp->b_pages = NULL;
   294		bp->b_flags &= ~_XBF_PAGES;
   295	}
   296	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
