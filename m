Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A9577174
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGPU5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPU5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:57:34 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B541BE94
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658005053; x=1689541053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Esvxm4yF85SMFreYBvw2s0NzkvoA1iTYIQUIeEaN1BI=;
  b=c4Vlo0R/YAoFfWFJBVL6ZXOyKiT26nM9x3k7KziPkmM9Dcl47YXHffdw
   gWms1FA5N1j5h8nUmwmKZWOZ6F4Jqob/hDH6BnqozxBhK2bkdMpzqJ11c
   5lTi1sLs2NW38uu6Pq6ssNJAfNDPVIRjDDYv2nS/Yl+X7XNjUqxvQZBuY
   s=;
X-IronPort-AV: E=Sophos;i="5.92,277,1650931200"; 
   d="scan'208";a="219154845"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 16 Jul 2022 20:57:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id 4BFFF2E00EC;
        Sat, 16 Jul 2022 20:57:32 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 16 Jul 2022 20:57:31 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.209) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sat, 16 Jul 2022 20:57:29 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <lkp@intel.com>
CC:     <chuck.lever@oracle.com>, <jlayton@kernel.org>,
        <kbuild-all@lists.01.org>, <kuniyu@amazon.com>,
        <linux-fsdevel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/lock: Don't allocate file_lock in flock_make_lock().
Date:   Sat, 16 Jul 2022 13:57:21 -0700
Message-ID: <20220716205721.15412-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202207170400.ddCuQ7sy-lkp@intel.com>
References: <202207170400.ddCuQ7sy-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.209]
X-ClientProxiedBy: EX13D30UWC002.ant.amazon.com (10.43.162.235) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From:   kernel test robot <lkp@intel.com>
Date:   Sun, 17 Jul 2022 04:46:27 +0800
> Hi Kuniyuki,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.19-rc6 next-20220715]
> [cannot apply to jlayton/linux-next cel-2.6/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/fs-lock-Don-t-allocate-file_lock-in-flock_make_lock/20220716-225519
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9b59ec8d50a1f28747ceff9a4f39af5deba9540e
> config: mips-randconfig-r003-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170400.ddCuQ7sy-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mipsel-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/7f68b5b24c3d8d371fb96ebe278dabb8c08bbf51
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Kuniyuki-Iwashima/fs-lock-Don-t-allocate-file_lock-in-flock_make_lock/20220716-225519
>         git checkout 7f68b5b24c3d8d371fb96ebe278dabb8c08bbf51
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/locks.c:2103:6: warning: variable 'error' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>            if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Oops, I'll fix this in v2.

Thanks!


>    fs/locks.c:2139:9: note: uninitialized use occurs here
>            return error;
>                   ^~~~~
>    fs/locks.c:2103:2: note: remove the 'if' if its condition is always false
>            if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/locks.c:2089:11: note: initialize the variable 'error' to silence this warning
>            int error;
>                     ^
>                      = 0
>    1 warning generated.
> 
> 
> vim +2103 fs/locks.c
> 
> e55c34a66f87e7 Benjamin Coddington   2015-10-22  2068  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2069  /**
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2070   *	sys_flock: - flock() system call.
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2071   *	@fd: the file descriptor to lock.
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2072   *	@cmd: the type of lock to apply.
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2073   *
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2074   *	Apply a %FL_FLOCK style lock to an open file descriptor.
> 80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2075   *	The @cmd can be one of:
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2076   *
> 80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2077   *	- %LOCK_SH -- a shared lock.
> 80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2078   *	- %LOCK_EX -- an exclusive lock.
> 80b79dd0e2f29f Mauro Carvalho Chehab 2017-05-27  2079   *	- %LOCK_UN -- remove an existing lock.
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2080   *	- %LOCK_MAND -- a 'mandatory' flock. (DEPRECATED)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2081   *
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2082   *	%LOCK_MAND support has been removed from the kernel.
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2083   */
> 002c8976ee5377 Heiko Carstens        2009-01-14  2084  SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2085  {
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2086  	int can_sleep, unlock, type;
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2087  	struct file_lock fl;
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2088  	struct fd f;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2089  	int error;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2090  
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2091  	type = flock_translate_cmd(cmd);
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2092  	if (type < 0)
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2093  		return type;
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2094  
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2095  	f = fdget(fd);
> 2903ff019b346a Al Viro               2012-08-28  2096  	if (!f.file)
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2097  		return -EBADF;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2098  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2099  	can_sleep = !(cmd & LOCK_NB);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2100  	cmd &= ~LOCK_NB;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2101  	unlock = (cmd == LOCK_UN);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2102  
> 90f7d7a0d0d686 Jeff Layton           2021-09-10 @2103  	if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2104  		goto out_putf;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2105  
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2106  	/*
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2107  	 * LOCK_MAND locks were broken for a long time in that they never
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2108  	 * conflicted with one another and didn't prevent any sort of open,
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2109  	 * read or write activity.
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2110  	 *
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2111  	 * Just ignore these requests now, to preserve legacy behavior, but
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2112  	 * throw a warning to let people know that they don't actually work.
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2113  	 */
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2114  	if (cmd & LOCK_MAND) {
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2115  		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n");
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2116  		error = 0;
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2117  		goto out_putf;
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2118  	}
> 90f7d7a0d0d686 Jeff Layton           2021-09-10  2119  
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2120  	flock_make_lock(f.file, &fl, type);
> 6e129d00689c4d Jeff Layton           2014-09-04  2121  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2122  	if (can_sleep)
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2123  		fl.fl_flags |= FL_SLEEP;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2124  
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2125  	error = security_file_lock(f.file, fl.fl_type);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2126  	if (error)
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2127  		goto out_putf;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2128  
> de2a4a501e716b Miklos Szeredi        2018-07-18  2129  	if (f.file->f_op->flock)
> 2903ff019b346a Al Viro               2012-08-28  2130  		error = f.file->f_op->flock(f.file,
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2131  					    can_sleep ? F_SETLKW : F_SETLK,
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2132  					    &fl);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2133  	else
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2134  		error = locks_lock_file_wait(f.file, &fl);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2135  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2136   out_putf:
> 2903ff019b346a Al Viro               2012-08-28  2137  	fdput(f);
> 7f68b5b24c3d8d Kuniyuki Iwashima     2022-07-15  2138  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2139  	return error;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2140  }
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2141  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
