Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5542B130547
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgAEBNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 20:13:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:30564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgAEBNv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:13:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2020 17:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,396,1571727600"; 
   d="gz'50?scan'50,208,50";a="222510239"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2020 17:13:46 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1inuUE-0001r6-49; Sun, 05 Jan 2020 09:13:46 +0800
Date:   Sun, 5 Jan 2020 09:12:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 4/6] fs: implement fsconfig via configfd
Message-ID: <202001050942.GIIg3HY7%lkp@intel.com>
References: <20200104201432.27320-5-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hhs7eq4iwqodfd7k"
Content-Disposition: inline
In-Reply-To: <20200104201432.27320-5-James.Bottomley@HansenPartnership.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hhs7eq4iwqodfd7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi James,

I love your patch! Yet something to improve:

[auto build test ERROR on s390/features]
[also build test ERROR on linus/master v5.5-rc4]
[cannot apply to arm64/for-next/core tip/x86/asm arm/for-next ia64/next m68k/for-next hp-parisc/for-next powerpc/next sparc-next/master next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/James-Bottomley/introduce-configfd-as-generalisation-of-fsconfig/20200105-080415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from fs/fsopen.c:13:0:
>> include/linux/syscalls.h:239:18: error: conflicting types for 'sys_fsconfig'
     asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                     ^
   include/linux/syscalls.h:225:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
>> fs/fsopen.c:412:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(fsconfig,
    ^~~~~~~~~~~~~~~
   In file included from fs/fsopen.c:13:0:
   include/linux/syscalls.h:996:17: note: previous declaration of 'sys_fsconfig' was here
    asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
                    ^~~~~~~~~~~~

vim +/sys_fsconfig +239 include/linux/syscalls.h

1bd21c6c21e848 Dominik Brodowski   2018-04-05  228  
e145242ea0df6b Dominik Brodowski   2018-04-09  229  /*
e145242ea0df6b Dominik Brodowski   2018-04-09  230   * The asmlinkage stub is aliased to a function named __se_sys_*() which
e145242ea0df6b Dominik Brodowski   2018-04-09  231   * sign-extends 32-bit ints to longs whenever needed. The actual work is
e145242ea0df6b Dominik Brodowski   2018-04-09  232   * done within __do_sys_*().
e145242ea0df6b Dominik Brodowski   2018-04-09  233   */
1bd21c6c21e848 Dominik Brodowski   2018-04-05  234  #ifndef __SYSCALL_DEFINEx
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  235  #define __SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3 Arnd Bergmann       2018-06-19  236  	__diag_push();							\
bee20031772af3 Arnd Bergmann       2018-06-19  237  	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
bee20031772af3 Arnd Bergmann       2018-06-19  238  		      "Type aliasing is used to sanitize syscall arguments");\
83460ec8dcac14 Andi Kleen          2013-11-12 @239  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
e145242ea0df6b Dominik Brodowski   2018-04-09  240  		__attribute__((alias(__stringify(__se_sys##name))));	\
c9a211951c7c79 Howard McLauchlan   2018-03-21  241  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
e145242ea0df6b Dominik Brodowski   2018-04-09  242  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
e145242ea0df6b Dominik Brodowski   2018-04-09  243  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
e145242ea0df6b Dominik Brodowski   2018-04-09  244  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
1a94bc34768e46 Heiko Carstens      2009-01-14  245  	{								\
e145242ea0df6b Dominik Brodowski   2018-04-09  246  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
07fe6e00f6cca6 Al Viro             2013-01-21  247  		__MAP(x,__SC_TEST,__VA_ARGS__);				\
2cf0966683430b Al Viro             2013-01-21  248  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
2cf0966683430b Al Viro             2013-01-21  249  		return ret;						\
1a94bc34768e46 Heiko Carstens      2009-01-14  250  	}								\
bee20031772af3 Arnd Bergmann       2018-06-19  251  	__diag_pop();							\
e145242ea0df6b Dominik Brodowski   2018-04-09  252  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
1bd21c6c21e848 Dominik Brodowski   2018-04-05  253  #endif /* __SYSCALL_DEFINEx */
1a94bc34768e46 Heiko Carstens      2009-01-14  254  

:::::: The code at line 239 was first introduced by commit
:::::: 83460ec8dcac14142e7860a01fa59c267ac4657c syscalls.h: use gcc alias instead of assembler aliases for syscalls

:::::: TO: Andi Kleen <ak@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--hhs7eq4iwqodfd7k
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--hhs7eq4iwqodfd7k--
