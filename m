Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D55BB440
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 00:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIPWEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 18:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIPWEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:04:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A91E3D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663365883; x=1694901883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pliEC0VA84fxEVZK/u5ab2EfL18m+bAaQ7a6VJ99zgI=;
  b=RmTuRGhK/e0ka7RrQxv3diZ5tfRU0PuPCepBUpaBnwYzTBB7miyaxFkp
   YRTGFysA4Vsh3wetZkdTGrXu7XM/JdJBLChQnJ1r6pP9syWiXH7e/AEnr
   qjnhBEIsV7h/+Efm7CAFP8SOwRhtVQ0kndxvJSuPLqWT2ge5wVmvzJLvZ
   tNbZMjj4Qsc0k3kPA4bLuwfdY+s2JnuPWI2xsIGUdNIdHWFE9XDd0EWvO
   H4ZXCAr/F7eMdW6d9Bx6rs4Ew7dfW8IFh0ZHwzvOGYIAYV5eFmwzZvb5j
   /M1jsAyslo9L4ROyboH1RENjBnW/zs2EV57AaXo8Fxvo6RC/st53iLwVZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299910851"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="299910851"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 15:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="862877480"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2022 15:04:40 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZJRv-0002BI-3D;
        Fri, 16 Sep 2022 22:04:39 +0000
Date:   Sat, 17 Sep 2022 06:04:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH 7/8] vfs: open inside ->tmpfile()
Message-ID: <202209170555.zV70MRNl-lkp@intel.com>
References: <20220916194416.1657716-7-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916194416.1657716-7-mszeredi@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on jaegeuk-f2fs/dev-test linus/master v6.0-rc5]
[cannot apply to viro-vfs/for-next next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miklos-Szeredi/cachefiles-tmpfile-error-handling-cleanup/20220917-034700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220917/202209170555.zV70MRNl-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/87f47d099f22ea898e5d05215f9b2c4647012001
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Miklos-Szeredi/cachefiles-tmpfile-error-handling-cleanup/20220917-034700
        git checkout 87f47d099f22ea898e5d05215f9b2c4647012001
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/ext4/ fs/f2fs/ fs/minix/ fs/ramfs/ fs/ubifs/ fs/udf/ mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/fs.h:8,
                    from include/linux/dax.h:5,
                    from mm/filemap.c:15:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
--
   In file included from include/linux/fs.h:8,
                    from mm/shmem.c:24:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
   mm/shmem.c: In function 'shmem_tmpfile':
   mm/shmem.c:2930:27: error: passing argument 1 of 'd_tmpfile' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2930 |                 d_tmpfile(file, inode);
         |                           ^~~~
         |                           |
         |                           struct file *
   include/linux/dcache.h:253:23: note: expected 'struct file *' but argument is of type 'struct file *'
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                       ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/fs.h:8,
                    from fs/ext4/namei.c:28:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
   fs/ext4/namei.c: In function 'ext4_tmpfile':
   fs/ext4/namei.c:2874:27: error: passing argument 1 of 'd_tmpfile' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2874 |                 d_tmpfile(file, inode);
         |                           ^~~~
         |                           |
         |                           struct file *
   include/linux/dcache.h:253:23: note: expected 'struct file *' but argument is of type 'struct file *'
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                       ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/fs.h:8,
                    from fs/f2fs/namei.c:8:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
   fs/f2fs/namei.c: In function '__f2fs_tmpfile':
   fs/f2fs/namei.c:896:35: error: passing argument 1 of 'd_tmpfile' from incompatible pointer type [-Werror=incompatible-pointer-types]
     896 |                         d_tmpfile(file, inode);
         |                                   ^~~~
         |                                   |
         |                                   struct file *
   include/linux/dcache.h:253:23: note: expected 'struct file *' but argument is of type 'struct file *'
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                       ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/fs.h:8,
                    from fs/minix/minix.h:5,
                    from fs/minix/namei.c:8:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
   fs/minix/namei.c: In function 'minix_tmpfile':
   fs/minix/namei.c:63:27: error: passing argument 1 of 'd_tmpfile' from incompatible pointer type [-Werror=incompatible-pointer-types]
      63 |                 d_tmpfile(file, inode);
         |                           ^~~~
         |                           |
         |                           struct file *
   include/linux/dcache.h:253:23: note: expected 'struct file *' but argument is of type 'struct file *'
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                       ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/fs.h:8,
                    from fs/ramfs/inode.c:26:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
   fs/ramfs/inode.c: In function 'ramfs_tmpfile':
   fs/ramfs/inode.c:156:19: error: passing argument 1 of 'd_tmpfile' from incompatible pointer type [-Werror=incompatible-pointer-types]
     156 |         d_tmpfile(file, inode);
         |                   ^~~~
         |                   |
         |                   struct file *
   include/linux/dcache.h:253:23: note: expected 'struct file *' but argument is of type 'struct file *'
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                       ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/fs.h:8,
                    from fs/ubifs/ubifs.h:16,
                    from fs/ubifs/dir.c:31:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
   fs/ubifs/dir.c: In function 'ubifs_tmpfile':
   fs/ubifs/dir.c:479:19: error: passing argument 1 of 'd_tmpfile' from incompatible pointer type [-Werror=incompatible-pointer-types]
     479 |         d_tmpfile(file, inode);
         |                   ^~~~
         |                   |
         |                   struct file *
   include/linux/dcache.h:253:23: note: expected 'struct file *' but argument is of type 'struct file *'
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                       ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/fs.h:8,
                    from fs/udf/udfdecl.h:10,
                    from fs/udf/namei.c:22:
>> include/linux/dcache.h:253:30: warning: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                              ^~~~
   fs/udf/namei.c: In function 'udf_tmpfile':
   fs/udf/namei.c:643:19: error: passing argument 1 of 'd_tmpfile' from incompatible pointer type [-Werror=incompatible-pointer-types]
     643 |         d_tmpfile(file, inode);
         |                   ^~~~
         |                   |
         |                   struct file *
   include/linux/dcache.h:253:23: note: expected 'struct file *' but argument is of type 'struct file *'
     253 | extern void d_tmpfile(struct file *, struct inode *);
         |                       ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +253 include/linux/dcache.h

   252	
 > 253	extern void d_tmpfile(struct file *, struct inode *);
   254	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
