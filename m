Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1013A24C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 08:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANHyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 02:54:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:55767 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgANHyY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:54:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 23:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="gz'50?scan'50,208,50";a="372507633"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2020 23:54:20 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1irH1n-0005Dg-NX; Tue, 14 Jan 2020 15:54:19 +0800
Date:   Tue, 14 Jan 2020 15:54:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Saagar Jha <saagar@saagarjha.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs: prevent signed overflow by using u64 over loff_t
Message-ID: <202001141531.7tVBJ9ap%lkp@intel.com>
References: <AECA23B8-C4AC-4280-A709-746DD9FC44F9@saagarjha.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ebotx42mpszlfssy"
Content-Disposition: inline
In-Reply-To: <AECA23B8-C4AC-4280-A709-746DD9FC44F9@saagarjha.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ebotx42mpszlfssy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Saagar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vfs/for-next]
[also build test ERROR on linus/master v5.5-rc6 next-20200110]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Saagar-Jha/vfs-prevent-signed-overflow-by-using-u64-over-loff_t/20200113-144149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=powerpc 

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
   In file included from fs/read_write.c:20:0:
>> include/linux/compat.h:78:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
                ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:17:0:
   fs/read_write.c:1271:16: warning: 'alias' attribute ignored [-Wattributes]
      const struct compat_iovec __user *,vec,
                   ^
   include/linux/syscalls.h:117:25: note: in definition of macro '__SC_DECL'
    #define __SC_DECL(t, a) t a
                            ^
   include/linux/syscalls.h:114:35: note: in expansion of macro '__MAP5'
    #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:115:22: note: in expansion of macro '__MAP6'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
>> include/linux/compat.h:79:35: note: in expansion of macro '__MAP'
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                                      ^~~~~
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:20:0:
>> include/linux/compat.h:82:21: error: invalid storage class for function '__do_compat_sys_preadv2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:82:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
     ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compat.h:84:18: error: static declaration of '__se_compat_sys_preadv2' follows non-static declaration
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:83:18: note: previous declaration of '__se_compat_sys_preadv2' was here
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                     ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__se_compat_sys_preadv2':
>> include/linux/compat.h:86:14: error: implicit declaration of function '__do_compat_sys_preadv2'; did you mean '__do_compat_sys_preadv'? [-Werror=implicit-function-declaration]
      long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
                 ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   include/linux/compat.h:91:21: error: invalid storage class for function '__do_compat_sys_preadv2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:91:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
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
   In file included from fs/read_write.c:20:0:
>> include/linux/compat.h:78:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
                ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:17:0:
   fs/read_write.c:1324:16: warning: 'alias' attribute ignored [-Wattributes]
      const struct compat_iovec __user *, vec,
                   ^
   include/linux/syscalls.h:117:25: note: in definition of macro '__SC_DECL'
    #define __SC_DECL(t, a) t a
                            ^
   include/linux/syscalls.h:111:35: note: in expansion of macro '__MAP2'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:115:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
>> include/linux/compat.h:79:35: note: in expansion of macro '__MAP'
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                                      ^~~~~
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:20:0:
>> include/linux/compat.h:82:21: error: invalid storage class for function '__do_compat_sys_writev'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:82:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
     ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compat.h:84:18: error: static declaration of '__se_compat_sys_writev' follows non-static declaration
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:83:18: note: previous declaration of '__se_compat_sys_writev' was here
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                     ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__se_compat_sys_writev':
>> include/linux/compat.h:86:14: error: implicit declaration of function '__do_compat_sys_writev'; did you mean '__se_compat_sys_writev'? [-Werror=implicit-function-declaration]
      long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
                 ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   include/linux/compat.h:91:21: error: invalid storage class for function '__do_compat_sys_writev'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:91:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
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
   In file included from fs/read_write.c:20:0:
>> include/linux/compat.h:78:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
                ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:17:0:
   fs/read_write.c:1359:16: warning: 'alias' attribute ignored [-Wattributes]
      const struct compat_iovec __user *,vec,
                   ^
   include/linux/syscalls.h:117:25: note: in definition of macro '__SC_DECL'
    #define __SC_DECL(t, a) t a
                            ^
   include/linux/syscalls.h:113:35: note: in expansion of macro '__MAP4'
    #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:115:22: note: in expansion of macro '__MAP5'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
>> include/linux/compat.h:79:35: note: in expansion of macro '__MAP'
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                                      ^~~~~
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:20:0:
>> include/linux/compat.h:82:21: error: invalid storage class for function '__do_compat_sys_pwritev'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:82:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
     ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compat.h:84:18: error: static declaration of '__se_compat_sys_pwritev' follows non-static declaration
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:83:18: note: previous declaration of '__se_compat_sys_pwritev' was here
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                     ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__se_compat_sys_pwritev':
>> include/linux/compat.h:86:14: error: implicit declaration of function '__do_compat_sys_pwritev'; did you mean '__do_compat_sys_writev'? [-Werror=implicit-function-declaration]
      long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
                 ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   include/linux/compat.h:91:21: error: invalid storage class for function '__do_compat_sys_pwritev'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:91:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
     ^
   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1358:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
    COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compat.h:78:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
                ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:17:0:
   fs/read_write.c:1380:16: warning: 'alias' attribute ignored [-Wattributes]
      const struct compat_iovec __user *,vec,
                   ^
   include/linux/syscalls.h:117:25: note: in definition of macro '__SC_DECL'
    #define __SC_DECL(t, a) t a
                            ^
   include/linux/syscalls.h:114:35: note: in expansion of macro '__MAP5'
    #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:115:22: note: in expansion of macro '__MAP6'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
>> include/linux/compat.h:79:35: note: in expansion of macro '__MAP'
     asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                                      ^~~~~
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/read_write.c:20:0:
>> include/linux/compat.h:82:21: error: invalid storage class for function '__do_compat_sys_pwritev2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
                        ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:82:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
     ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compat.h:84:18: error: static declaration of '__se_compat_sys_pwritev2' follows non-static declaration
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                     ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:83:18: note: previous declaration of '__se_compat_sys_pwritev2' was here
     asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
                     ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__se_compat_sys_pwritev2':
>> include/linux/compat.h:86:14: error: implicit declaration of function '__do_compat_sys_pwritev2'; did you mean '__do_compat_sys_pwritev'? [-Werror=implicit-function-declaration]
      long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
                 ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c: In function '__do_compat_sys_preadv':
   include/linux/compat.h:91:21: error: invalid storage class for function '__do_compat_sys_pwritev2'
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compat.h:91:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
     ^
   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1379:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
    ^~~~~~~~~~~~~~~~~~~~~~
   fs/read_write.c:1393:16: error: invalid storage class for function 'do_sendfile'
    static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
                   ^~~~~~~~~~~
   fs/read_write.c:1492:1: warning: 'alias' attribute ignored [-Wattributes]
    SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd, off_t __user *, offset, size_t, count)
    ^~~~~~~~~~~~~~~
   In file included from fs/read_write.c:17:0:

vim +/__do_compat_sys_preadv2 +82 include/linux/compat.h

217f4433fc2fe7 Heiko Carstens    2014-02-26  54  
468366138850f2 Al Viro           2012-11-23  55  #define COMPAT_SYSCALL_DEFINE1(name, ...) \
468366138850f2 Al Viro           2012-11-23  56          COMPAT_SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  57  #define COMPAT_SYSCALL_DEFINE2(name, ...) \
468366138850f2 Al Viro           2012-11-23  58  	COMPAT_SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  59  #define COMPAT_SYSCALL_DEFINE3(name, ...) \
468366138850f2 Al Viro           2012-11-23  60  	COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  61  #define COMPAT_SYSCALL_DEFINE4(name, ...) \
468366138850f2 Al Viro           2012-11-23  62  	COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  63  #define COMPAT_SYSCALL_DEFINE5(name, ...) \
468366138850f2 Al Viro           2012-11-23  64  	COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  65  #define COMPAT_SYSCALL_DEFINE6(name, ...) \
468366138850f2 Al Viro           2012-11-23  66  	COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
468366138850f2 Al Viro           2012-11-23  67  
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  68  /*
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  69   * The asmlinkage stub is aliased to a function named __se_compat_sys_*() which
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  70   * sign-extends 32-bit ints to longs whenever needed. The actual work is
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  71   * done within __do_compat_sys_*().
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  72   */
7303e30ec1d8fb Dominik Brodowski 2018-04-05  73  #ifndef COMPAT_SYSCALL_DEFINEx
468366138850f2 Al Viro           2012-11-23  74  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3 Arnd Bergmann     2018-06-19  75  	__diag_push();								\
bee20031772af3 Arnd Bergmann     2018-06-19  76  	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
bee20031772af3 Arnd Bergmann     2018-06-19  77  		      "Type aliasing is used to sanitize syscall arguments");\
3e2052e5dd4062 Dominik Brodowski 2018-03-22 @78  	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
83460ec8dcac14 Andi Kleen        2013-11-12 @79  	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  80  		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
c9a211951c7c79 Howard McLauchlan 2018-03-21  81  	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09 @82  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  83  	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09 @84  	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
468366138850f2 Al Viro           2012-11-23  85  	{									\
bee20031772af3 Arnd Bergmann     2018-06-19 @86  		long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
bee20031772af3 Arnd Bergmann     2018-06-19  87  		__MAP(x,__SC_TEST,__VA_ARGS__);					\
bee20031772af3 Arnd Bergmann     2018-06-19  88  		return ret;							\
468366138850f2 Al Viro           2012-11-23  89  	}									\
bee20031772af3 Arnd Bergmann     2018-06-19  90  	__diag_pop();								\
5ac9efa3c50d7c Dominik Brodowski 2018-04-09  91  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
7303e30ec1d8fb Dominik Brodowski 2018-04-05  92  #endif /* COMPAT_SYSCALL_DEFINEx */
468366138850f2 Al Viro           2012-11-23  93  

:::::: The code at line 82 was first introduced by commit
:::::: 5ac9efa3c50d7caff9f3933bb8a3ad1139d92d92 syscalls/core, syscalls/x86: Clean up compat syscall stub naming convention

:::::: TO: Dominik Brodowski <linux@dominikbrodowski.net>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--ebotx42mpszlfssy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ebotx42mpszlfssy--
