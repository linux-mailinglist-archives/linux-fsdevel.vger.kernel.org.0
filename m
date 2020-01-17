Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8737140728
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 10:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAQJ66 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 04:58:58 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56234 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgAQJ64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:58:56 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so2928264pjz.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 01:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FGHlcmrZlkCD14csl2UH6ff+eFSYVPYwCbaX2SijTrU=;
        b=UhUuhCRH7MnDdIQleOna7oQSbaPKylFRrqZ4sORZh1VWDg5yGdGfnGpxpjHjzEpYC3
         UQHsUfge5HIfl3Qzxy8nWp1rg56Jc/tucXgqcJum32LVIF88/d0dneuzrBlb34KtEqzK
         2X8n9PySXdJVOK6o1kCOR9EZtg90HtME94qY5NgYQEAgPCiiF6F5eE6b0W5qp4+guoaz
         kgW+gVwDokCzwMyqPSKr1JSfsE7D2DItIRwrJhBxOnNCY6TKTCoCUwHyYGDlInGARvYP
         scGcVRCwbAYJeE4fw0Y1hERJYD92nI7Ky3yqpAWezPOmOEJrPj/+Ah+c1zkreU9TyaoR
         faTw==
X-Gm-Message-State: APjAAAWVMxx4lfaSu8y6+kiyua+BBtScTiLFGlv68alkOMFrJZLEyBdi
        ZZxsoDVkB4RXadKkBUvs6wXs0A2b
X-Google-Smtp-Source: APXvYqw3WmraMivE/O/LwAI38sHXcgzTmW8anTvqWsxQ+td4BddNLyhnFQ0Ancppd76lsoiQ4iTqOw==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr38227618plo.5.1579255134642;
        Fri, 17 Jan 2020 01:58:54 -0800 (PST)
Received: from resnet-11-27.resnet.ucsb.edu (ResNet-11-27.resnet.ucsb.edu. [169.231.11.27])
        by smtp.gmail.com with ESMTPSA id y38sm27718992pgk.33.2020.01.17.01.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 01:58:54 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.2\))
Subject: Re: [PATCH] vfs: prevent signed overflow by using u64 over loff_t
From:   Saagar Jha <saagar@saagarjha.com>
In-Reply-To: <202001162347.Tb8u9nZn%lkp@intel.com>
Date:   Fri, 17 Jan 2020 01:58:52 -0800
Cc:     viro@zeniv.linux.org.uk
Content-Transfer-Encoding: 8BIT
Message-Id: <4EB51B0B-F49D-4613-A6F1-3436B9D27508@saagarjha.com>
References: <AECA23B8-C4AC-4280-A709-746DD9FC44F9@saagarjha.com>
 <202001162347.Tb8u9nZn%lkp@intel.com>
To:     linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm, that’s my old patch again :( The new one should build properly, but I don’t know how to tell the bot to use it…

Saagar Jha

> On Jan 16, 2020, at 07:21, kbuild test robot <lkp@intel.com> wrote:
> 
> Hi Saagar,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on vfs/for-next]
> [also build test ERROR on linus/master v5.5-rc6 next-20200115]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Saagar-Jha/vfs-prevent-signed-overflow-by-using-u64-over-loff_t/20200113-144149
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-next
> config: x86_64-randconfig-h001-20200114 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>   fs/read_write.c: In function '__do_compat_sys_preadv':
>   fs/read_write.c:1253:47: error: expected ')' before ';' token
>     loff_t pos = (((u64)pos_high << 32) | pos_low;
>                                                  ^
>   fs/read_write.c:1256:1: error: expected ',' or ';' before '}' token
>    }
>    ^
>   In file included from include/linux/syscalls.h:96:0,
>                    from fs/read_write.c:17:
>   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_preadv64v2'
>     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
>                 ^
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_preadv64v2'
>     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
>                        ^
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_preadv64v2' follows non-static declaration
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_preadv64v2' was here
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__x32_compat_sys_preadv64v2':
>   arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_preadv64v2'; did you mean '__se_compat_sys_preadv64'? [-Werror=implicit-function-declaration]
>      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
>             ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__do_compat_sys_preadv':
>   arch/x86/include/asm/syscall_wrapper.h:106:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
>                ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:139:14: error: invalid storage class for function '__se_compat_sys_preadv64v2'
>     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                 ^
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__se_compat_sys_preadv64v2':
>   arch/x86/include/asm/syscall_wrapper.h:141:10: error: implicit declaration of function '__do_compat_sys_preadv64v2'; did you mean '__se_compat_sys_preadv64v2'? [-Werror=implicit-function-declaration]
>      return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
>             ^
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__do_compat_sys_preadv':
>   arch/x86/include/asm/syscall_wrapper.h:143:21: error: invalid storage class for function '__do_compat_sys_preadv64v2'
>     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>                        ^
>   include/linux/compat.h:64:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1259:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE5'
>    COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_preadv2'
>     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
>                 ^
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_preadv2'
>     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
>                        ^
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_preadv2' follows non-static declaration
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_preadv2' was here
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__x32_compat_sys_preadv2':
>   arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_preadv2'; did you mean '__se_compat_sys_preadv'? [-Werror=implicit-function-declaration]
>      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
>             ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__do_compat_sys_preadv':
>   arch/x86/include/asm/syscall_wrapper.h:106:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
>                ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:139:14: error: invalid storage class for function '__se_compat_sys_preadv2'
>     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                 ^
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__se_compat_sys_preadv2':
>   arch/x86/include/asm/syscall_wrapper.h:141:10: error: implicit declaration of function '__do_compat_sys_preadv2'; did you mean '__do_compat_sys_preadv'? [-Werror=implicit-function-declaration]
>      return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
>             ^
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__do_compat_sys_preadv':
>   arch/x86/include/asm/syscall_wrapper.h:143:21: error: invalid storage class for function '__do_compat_sys_preadv2'
>     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>                        ^
>   include/linux/compat.h:66:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1270:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
>    COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1283:15: error: invalid storage class for function 'compat_writev'
>    static size_t compat_writev(struct file *file,
>                  ^~~~~~~~~~~~~
>   fs/read_write.c:1305:15: error: invalid storage class for function 'do_compat_writev'
>    static size_t do_compat_writev(compat_ulong_t fd,
>                  ^~~~~~~~~~~~~~~~
>   In file included from include/linux/syscalls.h:96:0,
>                    from fs/read_write.c:17:
>   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_writev'
>     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
>                 ^
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_writev'
>     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
>                        ^
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_writev' follows non-static declaration
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_writev' was here
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__x32_compat_sys_writev':
>>> arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_writev'; did you mean '__x32_compat_sys_writev'? [-Werror=implicit-function-declaration]
>      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
>             ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__do_compat_sys_preadv':
>   arch/x86/include/asm/syscall_wrapper.h:106:13: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
>                ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:139:14: error: invalid storage class for function '__se_compat_sys_writev'
>     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                 ^
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__se_compat_sys_writev':
>   arch/x86/include/asm/syscall_wrapper.h:141:10: error: implicit declaration of function '__do_compat_sys_writev'; did you mean '__se_compat_sys_writev'? [-Werror=implicit-function-declaration]
>      return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
>             ^
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__do_compat_sys_preadv':
>   arch/x86/include/asm/syscall_wrapper.h:143:21: error: invalid storage class for function '__do_compat_sys_writev'
>     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>                        ^
>   include/linux/compat.h:60:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1323:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
>    COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1330:13: error: invalid storage class for function 'do_compat_pwritev64'
>    static long do_compat_pwritev64(unsigned long fd,
>                ^~~~~~~~~~~~~~~~~~~
>   In file included from include/linux/syscalls.h:96:0,
>                    from fs/read_write.c:17:
>   arch/x86/include/asm/syscall_wrapper.h:135:14: error: invalid storage class for function '__se_compat_sys_pwritev64'
>     static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
>                 ^
>   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
>    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:136:21: error: invalid storage class for function '__do_compat_sys_pwritev64'
>     static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
>                        ^
>   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
>    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>>> arch/x86/include/asm/syscall_wrapper.h:106:18: error: static declaration of '__x32_compat_sys_pwritev64' follows non-static declaration
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
>    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   arch/x86/include/asm/syscall_wrapper.h:104:18: note: previous declaration of '__x32_compat_sys_pwritev64' was here
>     asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
>                     ^
>>> arch/x86/include/asm/syscall_wrapper.h:138:2: note: in expansion of macro '__X32_COMPAT_SYS_STUBx'
>     __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)    \
>     ^~~~~~~~~~~~~~~~~~~~~~
>   include/linux/compat.h:62:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>     COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>     ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c:1350:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
>    COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
>    ^~~~~~~~~~~~~~~~~~~~~~
>   fs/read_write.c: In function '__x32_compat_sys_pwritev64':
>>> arch/x86/include/asm/syscall_wrapper.h:108:10: error: implicit declaration of function '__se_compat_sys_pwritev64'; did you mean '__x32_compat_sys_pwritev64'? [-Werror=implicit-function-declaration]
>      return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
>             ^
> 
> vim +/__x32_compat_sys_preadv64v2 +106 arch/x86/include/asm/syscall_wrapper.h
> 
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   87  
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   88  
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   89  #ifdef CONFIG_X86_X32
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   90  /*
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   91   * For the x32 ABI, we need to create a stub for compat_sys_*() which is aware
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   92   * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   93   * with x86_64 obviously do not need such care.
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05   94   */
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08   95  #define __X32_COMPAT_SYS_STUB0(x, name, ...)				\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08   96  	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs);\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08   97  	ALLOW_ERROR_INJECTION(__x32_compat_sys_##name, ERRNO);		\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08   98  	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs)\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08   99  	{								\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  100  		return __se_compat_sys_##name();\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  101  	}
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  102  
> c76fc98260751e Dominik Brodowski 2018-04-09  103  #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09  104  	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09  105  	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09 @106  	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  107  	{								\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09 @108  		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  109  	}
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  110  
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  111  #else /* CONFIG_X86_X32 */
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  112  #define __X32_COMPAT_SYS_STUB0(x, name)
> c76fc98260751e Dominik Brodowski 2018-04-09  113  #define __X32_COMPAT_SYS_STUBx(x, name, ...)
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  114  #endif /* CONFIG_X86_X32 */
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  115  
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  116  
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  117  #ifdef CONFIG_COMPAT
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  118  /*
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  119   * Compat means IA32_EMULATION and/or X86_X32. As they use a different
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  120   * mapping of registers to parameters, we need to generate stubs for each
> d5a00528b58cdb Dominik Brodowski 2018-04-09  121   * of them.
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  122   */
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  123  #define COMPAT_SYSCALL_DEFINE0(name)					\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  124  	static long __se_compat_sys_##name(void);			\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  125  	static inline long __do_compat_sys_##name(void);		\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  126  	__IA32_COMPAT_SYS_STUB0(x, name)				\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  127  	__X32_COMPAT_SYS_STUB0(x, name)					\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  128  	static long __se_compat_sys_##name(void)			\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  129  	{								\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  130  		return __do_compat_sys_##name();			\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  131  	}								\
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  132  	static inline long __do_compat_sys_##name(void)
> cf3b83e19d7c92 Andy Lutomirski   2019-10-08  133  
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  134  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09  135  	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09  136  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
> c76fc98260751e Dominik Brodowski 2018-04-09  137  	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
> c76fc98260751e Dominik Brodowski 2018-04-09 @138  	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09  139  	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  140  	{									\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09  141  		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  142  	}									\
> 5ac9efa3c50d7c Dominik Brodowski 2018-04-09  143  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  144  
> 
> :::::: The code at line 106 was first introduced by commit
> :::::: 5ac9efa3c50d7caff9f3933bb8a3ad1139d92d92 syscalls/core, syscalls/x86: Clean up compat syscall stub naming convention
> 
> :::::: TO: Dominik Brodowski <linux@dominikbrodowski.net>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> <.config.gz>

