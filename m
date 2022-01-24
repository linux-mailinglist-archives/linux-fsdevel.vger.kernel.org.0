Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E761D497E28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 12:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiAXLln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 06:41:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:52131 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237794AbiAXLlm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643024502; x=1674560502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qSwxcSWc61GCN/jeYgEf7uRAI0O6FiXI5qymb1AvrOY=;
  b=B1ixWgMgdaeKc340do+YY8dOXT5AS8oKjA/dZ5BUFs0YCIf2SD3o+YLD
   mqv31BRxY7L00ZI0vY8TbiXR80/z6QQr57LHMzMKsADE7DGidJGVz/0rK
   uNvkjz7T4ESMtBV270I6bZIeoB2su5TYgKhYukj+Z90EWQNj3wqIgk7mT
   jMi2aNpp3G4Ni3r1anM/cHqjvZrmuz95usATUSN7VHHflauV8AJb3oaq5
   kOmpPGEJSJlirR/TJMjQ8rDTm6K+9zJRQnuNpAkvyftYcICAYo/AJep3m
   oBBi2rTFHMXm1m9y2qKoRz1tXUEMe5DO53iLq9VhGII0l5Ws5rH5XMxSv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245971943"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245971943"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 03:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476691737"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 03:41:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBxj7-000IFp-Tr; Mon, 24 Jan 2022 11:41:37 +0000
Date:   Mon, 24 Jan 2022 19:40:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tong Zhang <ztong0001@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
Message-ID: <202201241937.i9KSsyAj-lkp@intel.com>
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
config: riscv-randconfig-r001-20220123 (https://download.01.org/0day-ci/archive/20220124/202201241937.i9KSsyAj-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/d649008f3214eb4d94760873831ef5e53c292976
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tong-Zhang/binfmt_misc-fix-crash-when-load-unload-module/20220124-083500
        git checkout d649008f3214eb4d94760873831ef5e53c292976
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/binfmt_misc.c:828:21: error: incompatible pointer types assigning to 'struct ctl_table_header *' from 'struct sysctl_header *' [-Werror,-Wincompatible-pointer-types]
           binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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
