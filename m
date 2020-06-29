Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAFB20E95F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 01:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgF2Xa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 19:30:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:52950 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgF2Xa2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:30:28 -0400
IronPort-SDR: rFTAXN+4WfgpGme5Us8mD0K9IBO373ZMl4NLVMisaaFqSEo2QH+Lv10qMIr02pMZXZlwh8zXgB
 wG+tno4brmPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133540578"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="gz'50?scan'50,208,50";a="133540578"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:29:53 -0700
IronPort-SDR: 4Y0x9GoSgam6ElC+V2pkSdNdw0AXwnNTc/YjOyRsypxaqr+g3kETLqjxxgTLlr+1y8Go/h9eqk
 m2bR6kvTNVrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="gz'50?scan'50,208,50";a="312200344"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2020 16:29:51 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jq3Di-0001G4-Sd; Mon, 29 Jun 2020 23:29:50 +0000
Date:   Tue, 30 Jun 2020 07:29:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:regset.sparc 4/5] arch/sparc/kernel/ptrace_32.c:320:6: error:
 variable 'ret' set but not used
Message-ID: <202006300758.5QnOzS2A%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git regset.sparc
head:   9a5f61635dbb139673402d2c556f7dde6c73f55c
commit: 135142ffb5b0ed417ab394cb63ddfb57da674182 [4/5] sparc32: get rid of odd callers of copy_regset_from_user()
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 135142ffb5b0ed417ab394cb63ddfb57da674182
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/kernel/ptrace_32.c: In function 'setregs_set':
>> arch/sparc/kernel/ptrace_32.c:320:6: error: variable 'ret' set but not used [-Werror=unused-but-set-variable]
     320 |  int ret;
         |      ^~~
   arch/sparc/kernel/ptrace_32.c: In function 'arch_ptrace':
>> arch/sparc/kernel/ptrace_32.c:430:33: error: variable 'view' set but not used [-Werror=unused-but-set-variable]
     430 |  const struct user_regset_view *view;
         |                                 ^~~~
   cc1: all warnings being treated as errors

vim +/ret +320 arch/sparc/kernel/ptrace_32.c

   312	
   313	static int setregs_set(struct task_struct *target,
   314				 const struct user_regset *regset,
   315				 unsigned int pos, unsigned int count,
   316				 const void *kbuf, const void __user *ubuf)
   317	{
   318		struct pt_regs *regs = target->thread.kregs;
   319		u32 v[4];
 > 320		int ret;
   321	
   322		if (target == current)
   323			flush_user_windows();
   324	
   325		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
   326					 v,
   327					 0, 4 * sizeof(u32));
   328		regs->psr = (regs->psr & ~(PSR_ICC | PSR_SYSCALL)) |
   329			    (v[0] & (PSR_ICC | PSR_SYSCALL));
   330		regs->pc = v[1];
   331		regs->npc = v[2];
   332		regs->y = v[3];
   333		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
   334					 regs->u_regs + 1,
   335					 4 * sizeof(u32) , 19 * sizeof(u32));
   336	}
   337	
   338	static int getfpregs_get(struct task_struct *target,
   339				const struct user_regset *regset,
   340				unsigned int pos, unsigned int count,
   341				void *kbuf, void __user *ubuf)
   342	{
   343		const unsigned long *fpregs = target->thread.float_regs;
   344		int ret = 0;
   345	
   346	#if 0
   347		if (target == current)
   348			save_and_clear_fpu();
   349	#endif
   350	
   351		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
   352					  fpregs,
   353					  0, 32 * sizeof(u32));
   354		if (ret)
   355			return ret;
   356		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
   357					  &target->thread.fsr,
   358					  32 * sizeof(u32), 33 * sizeof(u32));
   359		if (ret)
   360			return ret;
   361		return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
   362					  33 * sizeof(u32), 68 * sizeof(u32));
   363	}
   364	
   365	static int setfpregs_set(struct task_struct *target,
   366				const struct user_regset *regset,
   367				unsigned int pos, unsigned int count,
   368				const void *kbuf, const void __user *ubuf)
   369	{
   370		unsigned long *fpregs = target->thread.float_regs;
   371		int ret;
   372	
   373	#if 0
   374		if (target == current)
   375			save_and_clear_fpu();
   376	#endif
   377		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
   378					 fpregs,
   379					 0, 32 * sizeof(u32));
   380		if (ret)
   381			return ret;
   382		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
   383					 &target->thread.fsr,
   384					 32 * sizeof(u32),
   385					 33 * sizeof(u32));
   386	}
   387	
   388	static const struct user_regset ptrace32_regsets[] = {
   389		[REGSET_GENERAL] = {
   390			.n = 19, .size = sizeof(u32),
   391			.get = getregs_get, .set = setregs_set,
   392		},
   393		[REGSET_FP] = {
   394			.n = 68, .size = sizeof(u32),
   395			.get = getfpregs_get, .set = setfpregs_set,
   396		},
   397	};
   398	
   399	static const struct user_regset_view ptrace32_view = {
   400		.regsets = ptrace32_regsets, .n = ARRAY_SIZE(ptrace32_regsets)
   401	};
   402	
   403	static const struct user_regset_view user_sparc32_view = {
   404		.name = "sparc", .e_machine = EM_SPARC,
   405		.regsets = sparc32_regsets, .n = ARRAY_SIZE(sparc32_regsets)
   406	};
   407	
   408	const struct user_regset_view *task_user_regset_view(struct task_struct *task)
   409	{
   410		return &user_sparc32_view;
   411	}
   412	
   413	struct fps {
   414		unsigned long regs[32];
   415		unsigned long fsr;
   416		unsigned long flags;
   417		unsigned long extra;
   418		unsigned long fpqd;
   419		struct fq {
   420			unsigned long *insnaddr;
   421			unsigned long insn;
   422		} fpq[16];
   423	};
   424	
   425	long arch_ptrace(struct task_struct *child, long request,
   426			 unsigned long addr, unsigned long data)
   427	{
   428		unsigned long addr2 = current->thread.kregs->u_regs[UREG_I4];
   429		void __user *addr2p;
 > 430		const struct user_regset_view *view;
   431		struct pt_regs __user *pregs;
   432		struct fps __user *fps;
   433		int ret;
   434	
   435		view = task_user_regset_view(current);
   436		addr2p = (void __user *) addr2;
   437		pregs = (struct pt_regs __user *) addr;
   438		fps = (struct fps __user *) addr;
   439	
   440		switch(request) {
   441		case PTRACE_GETREGS: {
   442			ret = copy_regset_to_user(child, &ptrace32_view,
   443						  REGSET_GENERAL, 0,
   444						  19 * sizeof(u32),
   445						  pregs);
   446			break;
   447		}
   448	
   449		case PTRACE_SETREGS: {
   450			ret = copy_regset_from_user(child, &ptrace32_view,
   451						    REGSET_GENERAL, 0,
   452						    19 * sizeof(u32),
   453						    pregs);
   454			break;
   455		}
   456	
   457		case PTRACE_GETFPREGS: {
   458			ret = copy_regset_to_user(child, &ptrace32_view,
   459						  REGSET_FP, 0,
   460						  68 * sizeof(u32),
   461						  fps);
   462			break;
   463		}
   464	
   465		case PTRACE_SETFPREGS: {
   466			ret = copy_regset_from_user(child, &ptrace32_view,
   467						  REGSET_FP, 0,
   468						  33 * sizeof(u32),
   469						  fps);
   470			break;
   471		}
   472	
   473		case PTRACE_READTEXT:
   474		case PTRACE_READDATA:
   475			ret = ptrace_readdata(child, addr, addr2p, data);
   476	
   477			if (ret == data)
   478				ret = 0;
   479			else if (ret >= 0)
   480				ret = -EIO;
   481			break;
   482	
   483		case PTRACE_WRITETEXT:
   484		case PTRACE_WRITEDATA:
   485			ret = ptrace_writedata(child, addr2p, addr, data);
   486	
   487			if (ret == data)
   488				ret = 0;
   489			else if (ret >= 0)
   490				ret = -EIO;
   491			break;
   492	
   493		default:
   494			if (request == PTRACE_SPARC_DETACH)
   495				request = PTRACE_DETACH;
   496			ret = ptrace_request(child, request, addr, data);
   497			break;
   498		}
   499	
   500		return ret;
   501	}
   502	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--h31gzZEtNLTqOjlF--
