Return-Path: <linux-fsdevel+bounces-6047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ACA812C49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AB81C2152F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431D139FC2;
	Thu, 14 Dec 2023 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFR7f0gg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B01106;
	Thu, 14 Dec 2023 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702547801; x=1734083801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqiCkuGCEaun1cH6jxYGjDo0sb5DoR/NddNRX5ci++o=;
  b=YFR7f0ggx7pvKRdxPqfAJWk6muVAmlWTeUeeTcfwXEpqy/LYTgnaE5AG
   t2qgsAzDrYrvaXFmVI3r9PEIOHZFM2uFK4CxU0WSBAJywcCoAH+d9bTw9
   E1gxsTDL8zVXy/qJVmUaMk+dewM/Xe7i+0U8n2Hrfd+7VHURfrnWfohUn
   5BPi/yazk8JyE7oG1m9/IXcPlXUhjSkHJfMhqXoVEJVLzX4+M7wAoey5N
   7Xi4DOB/x9SKlmUUUkvkazo+1IRE6ZNaSJLPcobbv5BgCfL0INuDFBiUv
   f049gnR1Ao/rtOVDIkJxmkdqWSc27uNoKTG98sr3+9ZquS488O6c2eAn6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459419580"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="459419580"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021452328"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1021452328"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2023 01:56:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDiSE-000LsP-36;
	Thu, 14 Dec 2023 09:56:30 +0000
Date: Thu, 14 Dec 2023 17:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com
Subject: Re: [PATCH v3 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <202312141733.PALHOosm-lkp@intel.com>
References: <20231213224118.1949-2-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213224118.1949-2-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on geert-m68k/for-next geert-m68k/for-linus deller-parisc/for-next powerpc/next powerpc/fixes s390/features jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master linus/master tip/x86/asm v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231214-064236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231213224118.1949-2-gregory.price%40memverge.com
patch subject: [PATCH v3 01/11] mm/mempolicy: implement the sysfs-based weighted_interleave interface
config: x86_64-randconfig-161-20231214 (https://download.01.org/0day-ci/archive/20231214/202312141733.PALHOosm-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141733.PALHOosm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141733.PALHOosm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/trace/events/tlb.h:9,
                    from arch/x86/include/asm/mmu_context.h:10,
                    from include/linux/mmu_context.h:5,
                    from include/linux/cpuset.h:18,
                    from mm/mempolicy.c:83:
   mm/mempolicy.c: In function 'add_weight_node':
>> mm/mempolicy.c:3145:28: error: 'struct iw_node_attr' has no member named 'attr'
    3145 |  sysfs_attr_init(&node_attr->attr);
         |                            ^~
   include/linux/sysfs.h:55:3: note: in definition of macro 'sysfs_attr_init'
      55 |  (attr)->key = &__key;    \
         |   ^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=m] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [m]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=m] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +3145 mm/mempolicy.c

  3129	
  3130	static int add_weight_node(int nid, struct kobject *wi_kobj)
  3131	{
  3132		struct iw_node_attr *node_attr;
  3133		char *name;
  3134	
  3135		node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
  3136		if (!node_attr)
  3137			return -ENOMEM;
  3138	
  3139		name = kasprintf(GFP_KERNEL, "node%d", nid);
  3140		if (!name) {
  3141			kfree(node_attr);
  3142			return -ENOMEM;
  3143		}
  3144	
> 3145		sysfs_attr_init(&node_attr->attr);
  3146		node_attr->kobj_attr.attr.name = name;
  3147		node_attr->kobj_attr.attr.mode = 0644;
  3148		node_attr->kobj_attr.show = node_show;
  3149		node_attr->kobj_attr.store = node_store;
  3150		node_attr->nid = nid;
  3151	
  3152		if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
  3153			kfree(node_attr->kobj_attr.attr.name);
  3154			kfree(node_attr);
  3155			pr_err("failed to add attribute to weighted_interleave\n");
  3156			return -ENOMEM;
  3157		}
  3158	
  3159		node_attrs[nid] = node_attr;
  3160		return 0;
  3161	}
  3162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

