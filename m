Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00CC6D532A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 23:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDCVLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 17:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjDCVL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:11:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DC4C23
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680556262; x=1712092262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/TL/94C71e8Y6Y2kHK5wljKsZJcW/biraeaZgkzhOkE=;
  b=AOVuDcdfPyXWQgKqdO21uzNwd/+0l2Qk8AwNf2JDM/gFOx8dXFcDeFY9
   SuO1VTHGWipmZvjgMN5CbENHVzofHQp/S1b1wvSuQvhKZRNaF8pQA47uh
   gvfcVhK2bKZZe9k9gSP7UXab2sSm/7KOa3gEatfrtnJkXdtRkm84oe8iM
   fQ6/3sfmmJUV6SNNEg/bHV53Z7psSF+5qVov8TUj8Mz6lvG2pdE2Gr/cw
   wIyo/iqRWN5GWejWQp2ge6Y4g8/OC5GUZ9xIlrxi5FU3CcgTp1dkJrsFL
   1UWJTlPYCaLMn4giGhB6yjKaySRkU2aDMt5a5+awIZ0WRhVEncqZCXN5v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342042403"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="342042403"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="932189509"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="932189509"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Apr 2023 14:10:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjRRp-000Opm-13;
        Mon, 03 Apr 2023 21:10:41 +0000
Date:   Tue, 4 Apr 2023 05:10:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     cem@kernel.org, hughd@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jack@suse.cz,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH 2/6] shmem: make shmem_get_inode() return ERR_PTR instead
 of NULL
Message-ID: <202304040420.J4BUN9E6-lkp@intel.com>
References: <20230403084759.884681-3-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403084759.884681-3-cem@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BODY_ENHANCEMENT2,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc5]
[cannot apply to akpm-mm/mm-everything next-20230403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/cem-kernel-org/shmem-make-shmem_inode_acct_block-return-error/20230403-165022
patch link:    https://lore.kernel.org/r/20230403084759.884681-3-cem%40kernel.org
patch subject: [PATCH 2/6] shmem: make shmem_get_inode() return ERR_PTR instead of NULL
config: arm-randconfig-r046-20230403 (https://download.01.org/0day-ci/archive/20230404/202304040420.J4BUN9E6-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/98aa926ee22a768f6a2dc8b0b897d018fc47497e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cem-kernel-org/shmem-make-shmem_inode_acct_block-return-error/20230403-165022
        git checkout 98aa926ee22a768f6a2dc8b0b897d018fc47497e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304040420.J4BUN9E6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/shmem.c:4261:29: error: too many arguments to function call, expected 5, have 6
                                   S_IFREG | S_IRWXUGO, 0, flags);
                                                           ^~~~~
   mm/shmem.c:4231:29: note: 'shmem_get_inode' declared here
   static inline struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
                               ^
   1 error generated.


vim +4261 mm/shmem.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  4241  
703321b60b605b Matthew Auld      2017-10-06  4242  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, loff_t size,
c7277090927a5e Eric Paris        2013-12-02  4243  				       unsigned long flags, unsigned int i_flags)
^1da177e4c3f41 Linus Torvalds    2005-04-16  4244  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  4245  	struct inode *inode;
93dec2da7b2349 Al Viro           2018-07-08  4246  	struct file *res;
^1da177e4c3f41 Linus Torvalds    2005-04-16  4247  
703321b60b605b Matthew Auld      2017-10-06  4248  	if (IS_ERR(mnt))
703321b60b605b Matthew Auld      2017-10-06  4249  		return ERR_CAST(mnt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  4250  
285b2c4fdd69ea Hugh Dickins      2011-08-03  4251  	if (size < 0 || size > MAX_LFS_FILESIZE)
^1da177e4c3f41 Linus Torvalds    2005-04-16  4252  		return ERR_PTR(-EINVAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  4253  
^1da177e4c3f41 Linus Torvalds    2005-04-16  4254  	if (shmem_acct_size(flags, size))
^1da177e4c3f41 Linus Torvalds    2005-04-16  4255  		return ERR_PTR(-ENOMEM);
^1da177e4c3f41 Linus Torvalds    2005-04-16  4256  
7a80e5b8c6fa7d Giuseppe Scrivano 2023-01-20  4257  	if (is_idmapped_mnt(mnt))
7a80e5b8c6fa7d Giuseppe Scrivano 2023-01-20  4258  		return ERR_PTR(-EINVAL);
7a80e5b8c6fa7d Giuseppe Scrivano 2023-01-20  4259  
7a80e5b8c6fa7d Giuseppe Scrivano 2023-01-20  4260  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
7a80e5b8c6fa7d Giuseppe Scrivano 2023-01-20 @4261  				S_IFREG | S_IRWXUGO, 0, flags);
98aa926ee22a76 Lukas Czerner     2023-04-03  4262  
98aa926ee22a76 Lukas Czerner     2023-04-03  4263  	if (IS_ERR(inode)) {
dac2d1f6cbfe3f Al Viro           2018-06-09  4264  		shmem_unacct_size(flags, size);
98aa926ee22a76 Lukas Czerner     2023-04-03  4265  		return ERR_CAST(inode);
dac2d1f6cbfe3f Al Viro           2018-06-09  4266  	}
c7277090927a5e Eric Paris        2013-12-02  4267  	inode->i_flags |= i_flags;
^1da177e4c3f41 Linus Torvalds    2005-04-16  4268  	inode->i_size = size;
6d6b77f163c7ea Miklos Szeredi    2011-10-28  4269  	clear_nlink(inode);	/* It is unlinked */
26567cdbbf1a6b Al Viro           2013-03-01  4270  	res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
93dec2da7b2349 Al Viro           2018-07-08  4271  	if (!IS_ERR(res))
93dec2da7b2349 Al Viro           2018-07-08  4272  		res = alloc_file_pseudo(inode, mnt, name, O_RDWR,
4b42af81f0d7f9 Al Viro           2009-08-05  4273  				&shmem_file_operations);
6b4d0b2793337c Al Viro           2013-02-14  4274  	if (IS_ERR(res))
93dec2da7b2349 Al Viro           2018-07-08  4275  		iput(inode);
6b4d0b2793337c Al Viro           2013-02-14  4276  	return res;
^1da177e4c3f41 Linus Torvalds    2005-04-16  4277  }
c7277090927a5e Eric Paris        2013-12-02  4278  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
