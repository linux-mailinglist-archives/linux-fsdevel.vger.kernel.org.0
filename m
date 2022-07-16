Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE357716E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiGPUql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 16:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPUqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:46:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090C140E8
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658004399; x=1689540399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LrmoLtJ1Uggt3F9Z/GHOW0s5sU72zhEL2H8Utx4nz8s=;
  b=eeR9aHZNrFsr+AMSA+43TM7BSeO6JfvsAeIwMBlGcS7hLc8PFzF7fX+j
   MpP384GSVR/3+2/Z3x2Q9i08bWoLnxkJvfq8Qf+5X+17qt1JVYpCtYVvC
   6rxwtbR4HQdtyxCFHn7vVvUVCk3cWSsXF6uyq2HZAobYu6Kn493ZOhU4i
   f5cqt39n7NYKS0UYp4p09N0Xr03vQH2O3GNi/r8xj2POt+Dq72Zv0MSKE
   0xfg49o357PYzcayBEJzo+OglZLezOIJmK2DLM01g129d6FVSnZb6kq8x
   SJEKGqQMH1ol9n2ws/ool/KcPGpt+dUip+jzBBYuiTPa6Tk5VS3kFk6c/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="349968662"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="349968662"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 13:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="739029013"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2022 13:46:36 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCogN-00027P-UE;
        Sat, 16 Jul 2022 20:46:35 +0000
Date:   Sun, 17 Jul 2022 04:46:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/lock: Don't allocate file_lock in flock_make_lock().
Message-ID: <202207170400.ddCuQ7sy-lkp@intel.com>
References: <20220716013140.61445-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716013140.61445-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kuniyuki,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc6 next-20220715]
[cannot apply to jlayton/linux-next cel-2.6/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/fs-lock-Don-t-allocate-file_lock-in-flock_make_lock/20220716-225519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9b59ec8d50a1f28747ceff9a4f39af5deba9540e
config: mips-randconfig-r003-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170400.ddCuQ7sy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7f68b5b24c3d8d371fb96ebe278dabb8c08bbf51
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuniyuki-Iwashima/fs-lock-Don-t-allocate-file_lock-in-flock_make_lock/20220716-225519
        git checkout 7f68b5b24c3d8d371fb96ebe278dabb8c08bbf51
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/locks.c:2103:6: warning: variable 'error' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/locks.c:2139:9: note: uninitialized use occurs here
           return error;
                  ^~~~~
   fs/locks.c:2103:2: note: remove the 'if' if its condition is always false
           if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/locks.c:2089:11: note: initialize the variable 'error' to silence this warning
           int error;
                    ^
                     = 0
   1 warning generated.


vim +2103 fs/locks.c

e55c34a66f87e7 Benjamin Coddington   2015-10-22  2068  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2069  /**
^1da177e4c3f41 Linus Torvalds        2005-04-16  2070   *	sys_flock: - flock() system call.
^1da177e4c3f41 Linus Torvalds        2005-04-16  2071   *	@fd: the file descriptor to lock.
^1da177e4c3f41 Linus Torvalds        2005-04-16  2072   *	@cmd: the type of lock to apply.
^1da177e4c3f41 Linus Torvalds        2005-04-16  2073   *
^1da177e4c3f41 Linus Torvalds        2005-04-16  2074   *	Apply a %FL_FLOCK style lock to an open file descriptor.
80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2075   *	The @cmd can be one of:
^1da177e4c3f41 Linus Torvalds        2005-04-16  2076   *
80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2077   *	- %LOCK_SH -- a shared lock.
80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2078   *	- %LOCK_EX -- an exclusive lock.
80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2079   *	- %LOCK_UN -- remove an existing lock.
90f7d7a0d0d686 Jeff Layton           2021-09-10  2080   *	- %LOCK_MAND -- a 'mandatory' flock. (DEPRECATED)
^1da177e4c3f41 Linus Torvalds        2005-04-16  2081   *
90f7d7a0d0d686 Jeff Layton           2021-09-10  2082   *	%LOCK_MAND support has been removed from the kernel.
^1da177e4c3f41 Linus Torvalds        2005-04-16  2083   */
002c8976ee5377 Heiko Carstens        2009-01-14  2084  SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
^1da177e4c3f41 Linus Torvalds        2005-04-16  2085  {
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2086  	int can_sleep, unlock, type;
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2087  	struct file_lock fl;
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2088  	struct fd f;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2089  	int error;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2090  
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2091  	type = flock_translate_cmd(cmd);
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2092  	if (type < 0)
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2093  		return type;
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2094  
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2095  	f = fdget(fd);
2903ff019b346a Al Viro               2012-08-28  2096  	if (!f.file)
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2097  		return -EBADF;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2098  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2099  	can_sleep = !(cmd & LOCK_NB);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2100  	cmd &= ~LOCK_NB;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2101  	unlock = (cmd == LOCK_UN);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2102  
90f7d7a0d0d686 Jeff Layton           2021-09-10 @2103  	if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
^1da177e4c3f41 Linus Torvalds        2005-04-16  2104  		goto out_putf;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2105  
90f7d7a0d0d686 Jeff Layton           2021-09-10  2106  	/*
90f7d7a0d0d686 Jeff Layton           2021-09-10  2107  	 * LOCK_MAND locks were broken for a long time in that they never
90f7d7a0d0d686 Jeff Layton           2021-09-10  2108  	 * conflicted with one another and didn't prevent any sort of open,
90f7d7a0d0d686 Jeff Layton           2021-09-10  2109  	 * read or write activity.
90f7d7a0d0d686 Jeff Layton           2021-09-10  2110  	 *
90f7d7a0d0d686 Jeff Layton           2021-09-10  2111  	 * Just ignore these requests now, to preserve legacy behavior, but
90f7d7a0d0d686 Jeff Layton           2021-09-10  2112  	 * throw a warning to let people know that they don't actually work.
90f7d7a0d0d686 Jeff Layton           2021-09-10  2113  	 */
90f7d7a0d0d686 Jeff Layton           2021-09-10  2114  	if (cmd & LOCK_MAND) {
90f7d7a0d0d686 Jeff Layton           2021-09-10  2115  		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n");
90f7d7a0d0d686 Jeff Layton           2021-09-10  2116  		error = 0;
90f7d7a0d0d686 Jeff Layton           2021-09-10  2117  		goto out_putf;
90f7d7a0d0d686 Jeff Layton           2021-09-10  2118  	}
90f7d7a0d0d686 Jeff Layton           2021-09-10  2119  
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2120  	flock_make_lock(f.file, &fl, type);
6e129d00689c4d Jeff Layton           2014-09-04  2121  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2122  	if (can_sleep)
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2123  		fl.fl_flags |= FL_SLEEP;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2124  
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2125  	error = security_file_lock(f.file, fl.fl_type);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2126  	if (error)
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2127  		goto out_putf;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2128  
de2a4a501e716b Miklos Szeredi        2018-07-18  2129  	if (f.file->f_op->flock)
2903ff019b346a Al Viro               2012-08-28  2130  		error = f.file->f_op->flock(f.file,
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2131  					    can_sleep ? F_SETLKW : F_SETLK,
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2132  					    &fl);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2133  	else
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2134  		error = locks_lock_file_wait(f.file, &fl);
^1da177e4c3f41 Linus Torvalds        2005-04-16  2135  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2136   out_putf:
2903ff019b346a Al Viro               2012-08-28  2137  	fdput(f);
7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2138  
^1da177e4c3f41 Linus Torvalds        2005-04-16  2139  	return error;
^1da177e4c3f41 Linus Torvalds        2005-04-16  2140  }
^1da177e4c3f41 Linus Torvalds        2005-04-16  2141  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
