Return-Path: <linux-fsdevel+bounces-4475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5D87FF9E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD572817F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7C5A108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhcVeBak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8C10E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 10:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701367473; x=1732903473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rAEJf0UEaI0GmJKQ+Y6Lp9E1JimEBbr0vz7esnjnITA=;
  b=nhcVeBakpKSFT3TIbTZcpV7UjHu59HmqR2teAZCmvPooQtcJcAUfTWN9
   tbFxIA1vB8rnWiLOgvgp9In8WIcv6v4vuR26HL222ejlfIw/MmnWEBqWt
   sK9Nv9dO6xnGe1p3JyqF/fzwP22skW0y2LCN0LIqp9yMZhntUc9o//mF2
   vsy/Yuh7aPKwYIGfnPffbPDa/K/CvhQHvAEkTlIPejJjEguExy59CJP9x
   LNyHhhArppn0WB4wSLlALCDJPmnEQMnB8WWsflVKDbO+9a10RcOsCB/y2
   EBROkjSaK5OHqWqo6ISspkQu+4BYSZp/cNB53oyQiyVlOUoFrCVGFyFqz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392233500"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="392233500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 10:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="942793694"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="942793694"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2023 10:04:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8lOl-0002Vc-2u;
	Thu, 30 Nov 2023 18:04:27 +0000
Date: Fri, 1 Dec 2023 02:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Andy.Wu@sony.com" <Andy.Wu@sony.com>,
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
	"cpgs@samsung.com" <cpgs@samsung.com>
Subject: Re: [PATCH v5 1/2] exfat: change to get file size from DataLength
Message-ID: <202312010116.gCpHjGSB-lkp@intel.com>
References: <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc3 next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuezhang-Mo-sony-com/exfat-do-not-zero-the-extended-part/20231130-164222
base:   linus/master
patch link:    https://lore.kernel.org/r/PUZPR04MB6316F0640983B00CC55D903F8182A%40PUZPR04MB6316.apcprd04.prod.outlook.com
patch subject: [PATCH v5 1/2] exfat: change to get file size from DataLength
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231201/202312010116.gCpHjGSB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231201/202312010116.gCpHjGSB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010116.gCpHjGSB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/exfat/file.c:6:
   fs/exfat/file.c: In function 'exfat_file_write_iter':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'ssize_t' {aka 'int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:498:9: note: in expansion of macro 'printk'
     498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:498:16: note: in expansion of macro 'KERN_ERR'
     498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   fs/exfat/exfat_fs.h:545:9: note: in expansion of macro 'pr_err'
     545 |         pr_err("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
         |         ^~~~~~
   fs/exfat/file.c:541:25: note: in expansion of macro 'exfat_err'
     541 |                         exfat_err(inode->i_sb,
         |                         ^~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

