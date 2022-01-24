Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602BE497F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 13:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiAXMPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 07:15:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:63891 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241954AbiAXMOn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643026483; x=1674562483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FR/Plqwyf6P+JXGAx4Yblw5sOsYQlSfhlYedmM/BhpI=;
  b=It3GvrS4HsbnwOAl9k9BxeAmnNFPLkYcoUt7DYeG1atxtJyvOxi3r388
   N6xz97Up10aOq6P3iaQzf19+IkWFRj0nYmUtCPRjxH3fw6a8nPsW33c82
   9g1nc0Y+mxB85s9g9IDAGpUI7sJUdTQt8ocookAjndJxMFmyIGVFdc7KG
   riXbHaLrotnJjY7ZmRgk//+1NFHXy7ziHk4pIM/nayCaszrfOO3P17rjy
   4gDU8UZMuXE5cw1p3MCoWMHARV1g5fmhC+z88w+T7oQqwJR3PZa/Bq9/t
   /LzOKoPyJNTmRRRU3rb1Z9gdRsDHNgmyZKxNAeIsRI6Esc3Li+XmJe4Ln
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243626687"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243626687"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617214240"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 04:14:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nByF5-000II9-52; Mon, 24 Jan 2022 12:14:39 +0000
Date:   Mon, 24 Jan 2022 20:14:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tong Zhang <ztong0001@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
Message-ID: <202201242006.cqM8NznF-lkp@intel.com>
References: <20220124003342.1457437-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124003342.1457437-1-ztong0001@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tong-Zhang/binfmt_misc-fix-crash-when-load-unload-module/20220124-083500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
config: arm-randconfig-c002-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242006.cqM8NznF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d649008f3214eb4d94760873831ef5e53c292976
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tong-Zhang/binfmt_misc-fix-crash-when-load-unload-module/20220124-083500
        git checkout d649008f3214eb4d94760873831ef5e53c292976
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/binfmt_misc.c: In function 'init_misc_binfmt':
>> fs/binfmt_misc.c:828:28: error: assignment to 'struct ctl_table_header *' from incompatible pointer type 'struct sysctl_header *' [-Werror=incompatible-pointer-types]
     828 |         binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
         |                            ^
   cc1: some warnings being treated as errors


vim +828 fs/binfmt_misc.c

   821	
   822	static int __init init_misc_binfmt(void)
   823	{
   824		int err = register_filesystem(&bm_fs_type);
   825		if (!err)
   826			insert_binfmt(&misc_format);
   827	
 > 828		binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
   829		if (!binfmt_misc_header) {
   830			pr_warn("Failed to create fs/binfmt_misc sysctl mount point");
   831			return -ENOMEM;
   832		}
   833		return 0;
   834	}
   835	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
