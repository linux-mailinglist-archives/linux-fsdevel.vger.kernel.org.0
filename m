Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC21606ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 23:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgBPWfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 17:35:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:17206 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPWfc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 17:35:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 14:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,450,1574150400"; 
   d="gz'50?scan'50,208,50";a="435378460"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2020 14:35:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j3SVd-00030w-0G; Mon, 17 Feb 2020 06:35:29 +0800
Date:   Mon, 17 Feb 2020 06:35:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:untested.uaccess 18/22] arch/x86/kernel/signal.c:309:51: error:
 macro "unsafe_put_user" requires 3 arguments, but only 2 given
Message-ID: <202002170605.k2OSCkAE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git untested.uaccess
head:   094cadd628e4f679e8d2a5edbf9564ac1ec5bb03
commit: c6bab75849c01b2ea5ce1ac94a1c26db84efce6c [18/22] x86: __setup_frame(): consolidate uaccess areas
config: i386-alldefconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-4) 7.5.0
reproduce:
        git checkout c6bab75849c01b2ea5ce1ac94a1c26db84efce6c
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/signal.c: In function '__setup_frame':
>> arch/x86/kernel/signal.c:309:51: error: macro "unsafe_put_user" requires 3 arguments, but only 2 given
     unsafe_put_user(set->sig[1], &frame->extramask[0]), Efault)
                                                      ^
>> arch/x86/kernel/signal.c:309:2: error: 'unsafe_put_user' undeclared (first use in this function)
     unsafe_put_user(set->sig[1], &frame->extramask[0]), Efault)
     ^~~~~~~~~~~~~~~
   arch/x86/kernel/signal.c:309:2: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/kernel/signal.c:309:54: error: 'Efault' undeclared (first use in this function)
     unsafe_put_user(set->sig[1], &frame->extramask[0]), Efault)
                                                         ^~~~~~
   arch/x86/kernel/signal.c:309:52: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     unsafe_put_user(set->sig[1], &frame->extramask[0]), Efault)
                                                       ^
>> arch/x86/kernel/signal.c:309:60: error: expected ';' before ')' token
     unsafe_put_user(set->sig[1], &frame->extramask[0]), Efault)
                                                               ^
>> arch/x86/kernel/signal.c:309:60: error: expected statement before ')' token
   arch/x86/kernel/signal.c:298:6: warning: unused variable 'err' [-Wunused-variable]
     int err = 0;
         ^~~
   arch/x86/kernel/signal.c: In function 'x32_setup_rt_frame':
   arch/x86/kernel/signal.c:580:1: warning: label 'Efault' defined but not used [-Wunused-label]
    Efault:
    ^~~~~~

vim +/unsafe_put_user +309 arch/x86/kernel/signal.c

   291	
   292	static int
   293	__setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
   294		      struct pt_regs *regs)
   295	{
   296		struct sigframe __user *frame;
   297		void __user *restorer;
   298		int err = 0;
   299		void __user *fpstate = NULL;
   300	
   301		frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
   302	
   303		if (!user_access_begin(frame, sizeof(*frame)))
   304			return -EFAULT;
   305	
   306		unsafe_put_user(sig, &frame->sig, Efault);
   307		if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
   308			goto Efault;
 > 309		unsafe_put_user(set->sig[1], &frame->extramask[0]), Efault)
   310		if (current->mm->context.vdso)
   311			restorer = current->mm->context.vdso +
   312				vdso_image_32.sym___kernel_sigreturn;
   313		else
   314			restorer = &frame->retcode;
   315		if (ksig->ka.sa.sa_flags & SA_RESTORER)
   316			restorer = ksig->ka.sa.sa_restorer;
   317	
   318		/* Set up to return from userspace.  */
   319		unsafe_put_user(restorer, &frame->pretcode, Efault);
   320	
   321		/*
   322		 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
   323		 *
   324		 * WE DO NOT USE IT ANY MORE! It's only left here for historical
   325		 * reasons and because gdb uses it as a signature to notice
   326		 * signal handler stack frames.
   327		 */
   328		unsafe_put_user(*((u64 *)&retcode), (u64 *)frame->retcode, Efault);
   329		user_access_end();
   330	
   331		/* Set up registers for signal handler */
   332		regs->sp = (unsigned long)frame;
   333		regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
   334		regs->ax = (unsigned long)sig;
   335		regs->dx = 0;
   336		regs->cx = 0;
   337	
   338		regs->ds = __USER_DS;
   339		regs->es = __USER_DS;
   340		regs->ss = __USER_DS;
   341		regs->cs = __USER_CS;
   342	
   343		return 0;
   344	
   345	Efault:
   346		user_access_end();
   347		return -EFAULT;
   348	}
   349	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
