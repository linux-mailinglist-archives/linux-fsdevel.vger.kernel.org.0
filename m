Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AAD13DEA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 16:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgAPPWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 10:22:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:4627 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgAPPWO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:22:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 07:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="gz'50?scan'50,208,50";a="220402220"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2020 07:22:02 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1is6yA-0002q3-Cc; Thu, 16 Jan 2020 23:22:02 +0800
Date:   Thu, 16 Jan 2020 23:21:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Saagar Jha <saagar@saagarjha.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs: prevent signed overflow by using u64 over loff_t
Message-ID: <202001162347.Tb8u9nZn%lkp@intel.com>
References: <AECA23B8-C4AC-4280-A709-746DD9FC44F9@saagarjha.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kf6v3holdecf7icg"
Content-Disposition: inline
In-Reply-To: <AECA23B8-C4AC-4280-A709-746DD9FC44F9@saagarjha.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--kf6v3holdecf7icg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Saagar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vfs/for-next]
[also build test ERROR on linus/master v5.5-rc6 next-20200115]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Saagar-Jha/vfs-prevent-signed-overflow-by-using-u64-over-loff_t/20200113-144149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-next
config: x86_64-randconfig-h001-20200114 (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   fs/read_write.c: In function '__do_compat_sys_preadv':
   fs/read_write.c:1253:47: error: expected ')' before ';' token
     loff_t pos = (((u64)pos_high << 32) | pos_low;
                                                  ^
   fs/read_write.c:1256:1: error: expected ',' or ';' before '}' token
    }
    ^
   In file included from include/linux/syscalls.h:96:0,
                    from fs/read_write.c:17:
   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_preadv64v2'
     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                 ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_preadv64v2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_preadv64v2' follows non-static declaration
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_preadv64v2' was here
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__x32_compat_sys_preadv64v2':
   arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_preadv64v2'; did you mean '__se_compat_sys_preadv64'? [-Werror=implicit-function-declaration]
      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
             ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   arch/x86/include/asm/syscall_wrapper.h:106:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
                ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:139:14: error: invalid storage class for function '__se_compat_sys_preadv64v2'
     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                 ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__se_compat_sys_preadv64v2':
   arch/x86/include/asm/syscall_wrapper.h:141:10: error: implicit declaration of function '__do_compat_sys_preadv64v2'; did you mean '__se_compat_sys_preadv64v2'? [-Werror=implicit-function-declaration]
      return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
             ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   arch/x86/include/asm/syscall_wrapper.h:143:21: error: invalid storage class for function '__do_compat_sys_preadv64v2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_preadv2'
     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                 ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_preadv2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_preadv2' follows non-static declaration
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_preadv2' was here
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__x32_compat_sys_preadv2':
   arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_preadv2'; did you mean '__se_compat_sys_preadv'? [-Werror=implicit-function-declaration]
      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
             ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   arch/x86/include/asm/syscall_wrapper.h:106:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
                ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:139:14: error: invalid storage class for function '__se_compat_sys_preadv2'
     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                 ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__se_compat_sys_preadv2':
   arch/x86/include/asm/syscall_wrapper.h:141:10: error: implicit declaration of function '__do_compat_sys_preadv2'; did you mean '__do_compat_sys_preadv'? [-Werror=implicit-function-declaration]
      return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
             ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   arch/x86/include/asm/syscall_wrapper.h:143:21: error: invalid storage class for function '__do_compat_sys_preadv2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1283:15: error: invalid storage class for function 'compat_writev'
    static size_t compat_writev(struct file *file,
                  ^~~~~~~~~~~~~
   fs/read_write.c:1305:15: error: invalid storage class for function 'do_compat_writev'
    static size_t do_compat_writev(compat_ulong_t fd,
                  ^~~~~~~~~~~~~~~~
   In file included from include/linux/syscalls.h:96:0,
                    from fs/read_write.c:17:
   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_writev'
     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                 ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_writev'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_writev' follows non-static declaration
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_writev' was here
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__x32_compat_sys_writev':
>> arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_writev'; did you mean '__x32_compat_sys_writev'? [-Werror=implicit-function-declaration]
      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
             ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   arch/x86/include/asm/syscall_wrapper.h:106:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
                ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:139:14: error: invalid storage class for function '__se_compat_sys_writev'
     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                 ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__se_compat_sys_writev':
   arch/x86/include/asm/syscall_wrapper.h:141:10: error: implicit declaration of function '__do_compat_sys_writev'; did you mean '__se_compat_sys_writev'? [-Werror=implicit-function-declaration]
      return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
             ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   arch/x86/include/asm/syscall_wrapper.h:143:21: error: invalid storage class for function '__do_compat_sys_writev'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1330:13: error: invalid storage class for function 'do_compat_pwritev64'
    static long do_compat_pwritev64(unsigned long fd,
                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/syscalls.h:96:0,
                    from fs/read_write.c:17:
   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_pwritev64'
     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                 ^
   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_pwritev64'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_pwritev64' follows non-static declaration
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_pwritev64' was here
     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
                     ^
>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__x32_compat_sys_pwritev64':
>> arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_pwritev64'; did you mean '__x32_compat_sys_pwritev64'? [-Werror=implicit-function-declaration]
      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
             ^

vim +/__x32_compat_sys_preadv64v2 +106 arch/x86/include/asm/syscall_wrapper.h

ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   87  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   88  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   89  #ifdef CONFIG_X86_X32
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   90  /*
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   91   * For the x32 ABI, we need to create a stub for compat_sys_*() which is aware
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   92   * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   93   * with x86_64 obviously do not need such care.
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   94   */
cf3b83e19d7c92 Andy Lutomirski   2019-10-08   95  #define __X32_COMPAT_SYS_STUB0(x, name, ...)				\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08   96  	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs);\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08   97  	ALLOW_ERROR_INJECTION(__x32_compat_sys_##name, ERRNO);		\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08   98  	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs)\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08   99  	{								\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  100  		return __se_compat_sys_##name();\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  101  	}
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  102  
c76fc98260751e Dominik Brodowski 2018-04-09  103  #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  104  	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  105  	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09 @106  	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  107  	{								\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09 @108  		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  109  	}
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  110  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  111  #else /* CONFIG_X86_X32 */
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  112  #define __X32_COMPAT_SYS_STUB0(x, name)
c76fc98260751e Dominik Brodowski 2018-04-09  113  #define __X32_COMPAT_SYS_STUBx(x, name, ...)
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  114  #endif /* CONFIG_X86_X32 */
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  115  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  116  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  117  #ifdef CONFIG_COMPAT
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  118  /*
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  119   * Compat means IA32_EMULATION and/or X86_X32. As they use a different
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  120   * mapping of registers to parameters, we need to generate stubs for each
d5a00528b58cdb Dominik Brodowski 2018-04-09  121   * of them.
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  122   */
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  123  #define COMPAT_SYSCALL_DEFINE0(name)					\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  124  	static long __se_compat_sys_##name(void);			\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  125  	static inline long __do_compat_sys_##name(void);		\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  126  	__IA32_COMPAT_SYS_STUB0(x, name)				\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  127  	__X32_COMPAT_SYS_STUB0(x, name)					\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  128  	static long __se_compat_sys_##name(void)			\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  129  	{								\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  130  		return __do_compat_sys_##name();			\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  131  	}								\
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  132  	static inline long __do_compat_sys_##name(void)
cf3b83e19d7c92 Andy Lutomirski   2019-10-08  133  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  134  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  135  	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  136  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
c76fc98260751e Dominik Brodowski 2018-04-09  137  	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
c76fc98260751e Dominik Brodowski 2018-04-09 @138  	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  139  	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  140  	{									\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  141  		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  142  	}									\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  143  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  144  

:::::: The code at line 106 was first introduced by commit
:::::: 5ac9efa3c50d7caff9f3933bb8a3ad1139d92d92 syscalls/core, syscalls/x86: Clean up compat syscall stub naming convention

:::::: TO: Dominik Brodowski <linux@dominikbrodowski.net>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--kf6v3holdecf7icg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--kf6v3holdecf7icg--
