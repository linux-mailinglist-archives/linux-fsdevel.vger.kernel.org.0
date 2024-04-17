Return-Path: <linux-fsdevel+bounces-17129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A48A836D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA0A1F221D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8B13D265;
	Wed, 17 Apr 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzpMB1DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50812139F;
	Wed, 17 Apr 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358283; cv=none; b=NFqt3K0nYgnCXyibgVgUs2s3EA+79ElEgjyJKVGGsJUhH5DrCQC6k9AmTM9KTMTqU62ZajcXWOCyEMUHj016XTcTTiZ8HTKkpcXZVJxkg3AMxjn1+zlKd/NcR4YkWmeMFJfbwXGe8P/YVAgWVrD4iUHPUqWolloOo+MQvY6SLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358283; c=relaxed/simple;
	bh=Y1P2CaMn+LrzgvU4o01v4Q/DI6tWvvgnLk/hUDA6n0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLHQhqthS32RgbI4FMwAfo4+qgq/3s2s+PNm3J0PaRzPL6kh85HPDjWhJUClzeAOpKkj2G4qhWNSAtbkq9vfvOdQPZdjZK17kHU4LYZXNg85HG7Qf85Oe7IN66T9Ud5yzJ05fBvXdAI5LfmO0Wb+nTqB6y48Mw4XIFBHmK+yGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzpMB1DL; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7ebeb178ec4so57545241.0;
        Wed, 17 Apr 2024 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713358277; x=1713963077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H50Yq/1bKm6UpkKla+gr4omGSPJd+D/ukVzmoYU6VxM=;
        b=RzpMB1DLrsYpKtGy+jkDSsG2jsKgmFhYh92gwnw4zs1GuTKyMRcTY0tGfTP/uvXx+n
         ceLXQsiuRmLmkBo9fGfRiU0HadJYXpGnqrwSiBBQf+xrfuxROzup3U4Hjl2hXCzHXBBt
         97q24U2vBq5bJc0tfEyEUY5GuzHdBM5O1eCpU656Th3GScAA58PcfWhsaMs5ng+tvyy1
         Ls0nPlGRceYuT3WBvHfIXU0lTXj3Opm7oiyDNXX7A0TBmEV3O0heSyQFNFYtvavUYnEr
         xjTw/0AMHr1VMNcV4EJpq8GUiCq0vB5ZrneTblV97CK5KatwmUmL5xFPixoowIafL7Df
         F60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358277; x=1713963077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H50Yq/1bKm6UpkKla+gr4omGSPJd+D/ukVzmoYU6VxM=;
        b=L56dZztU3hZdelwK9ZzSlvGIylsOll5FNAEW75jPNi11VxSTdUAKLm2PfQZ3KlDHKl
         qZ3FgefE2aKuSGDbZ2S7JeEJZhZAHBYBy+wW7NzcWrrJXDg6HmYM8lvYI2xxtCZfw0NV
         j71bA1W1oPw07raoqFfLgCfT7oME/hu7smapxeIpuprtohXJSbeFPmxLLZ+RHFG+W8mW
         QJS2lH7Wxf6aKGeAz4lGe6hOulBFZfLitStd/rk8wlL+dpyTKGx1oet7B+BXdAx4u5jx
         qMVRTmGQ8UHrBPYEGq+DVpcZvcI/JLqXe3RPxDj4PiylMQsSCj4wwphYDB7C5JB9Nz9q
         dtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIRWU208FItk50MW4lZrAfipOgdgtVxO5fxIznu0qgR8eSZBPK8rC/TbZm+3OswucQyH64icYHFZFIi8I04erveBE+55ofXP9JBjdLJV7vmMg/qssA//Vxvlzu68C1voqtTfiUC9aNDRGdmg==
X-Gm-Message-State: AOJu0Yzq6M+yzsSZBtFfiOb4dyWVa6t+KVYdQYMEToo6e7qD7ehZ8GYt
	x1sMvPhLEzyQiVFjfUVVtb0OqjmEgXHdPyJu0qM58jv2fbBELAkjr/adJVifM/4yAGphoHdKE0z
	qbAc55K7MG5FwlLIIq+fc99XPJKEqTGrbnu4=
X-Google-Smtp-Source: AGHT+IGlNuM1/ctkQH8dPwVCI4Nd4R/jxC1r5KeL2Eh7UO8EPm3yIw/sPDJNr0073C1QI9k7mq2+eRrhcoffULFDwkw=
X-Received: by 2002:a05:6122:c84:b0:4d3:34f4:7e99 with SMTP id
 ba4-20020a0561220c8400b004d334f47e99mr5078353vkb.0.1713358276403; Wed, 17 Apr
 2024 05:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLw_9S4NZDrVf1_KRizU7MBxEGwMUFn_rFgibK8_KWxd+A@mail.gmail.com>
In-Reply-To: <CABOYnLw_9S4NZDrVf1_KRizU7MBxEGwMUFn_rFgibK8_KWxd+A@mail.gmail.com>
From: lee bruce <xrivendell7@gmail.com>
Date: Wed, 17 Apr 2024 20:51:04 +0800
Message-ID: <CABOYnLxuMzSAaF6Eu3duq+ukUE=0Hni8S+e92+6nBVqPBD6RXA@mail.gmail.com>
Subject: Re: [syzbot] [jffs2?] kernel BUG in jffs2_sum_write_sumnode
To: syzbot+badbb16b0a5dd4c2f676@syzkaller.appspotmail.com
Cc: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for containing the HTML part, repeat.
Hello, I reproduced this bug and confirmed in the latest upstream.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

I use the same kernel as syzbot instance:
https://syzkaller.appspot.com/bug?extid=3D5a281fe8aadf8f11230d
Kernel Commit: upstream fe46a7dd189e25604716c03576d05ac8a5209743
Kernel Config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D4d=
90a36f0cab495a
with KASAN enabled

root@syzkaller:~# ./0
[  406.727577][ T8177] ------------[ cut here ]------------
[  406.728272][ T8177] kernel BUG at fs/jffs2/summary.c:865!
[  406.729014][ T8177] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  406.729850][ T8177] CPU: 2 PID: 8177 Comm: 0 Not tainted
6.8.0-08951-gfe46a7dd189e-dirty #6
[  406.730904][ T8177] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  406.732206][ T8177] RIP: 0010:jffs2_sum_write_sumnode+0x1f50/0x2630
[  406.733061][ T8177] Code: 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 81 01
00 00 8b b3 c0 05 00 00 48 c7 c2 c0 7e a4 8b 48 c7 c7 c0 7a a4 8b e8
51 ba 82 fe 90 <0f> 0b e8 69 29 01 ff e9 70 e19
[  406.735472][ T8177] RSP: 0018:ffffc9000396f4e0 EFLAGS: 00010286
[  406.736416][ T8177] RAX: 0000000000000045 RBX: ffff888022a20040
RCX: ffff888022a20040
[  406.737446][ T8177] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
[  406.738435][ T8177] RBP: ffffc9000396f660 R08: 0000000000000005
R09: 0000000000000000
[  406.739470][ T8177] R10: 0000000080000000 R11: 0000000000000001
R12: 0000000000000000
[  406.740463][ T8177] R13: 0000000000000000 R14: ffff888028bb1000
R15: 000000000000106c
[  406.741459][ T8177] FS:  0000000007a66480(0000)
GS:ffff8880b9300000(0000) knlGS:0000000000000000
[  406.742581][ T8177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  406.743418][ T8177] CR2: 0000000020003029 CR3: 000000002be68000
CR4: 0000000000750ef0
[  406.744407][ T8177] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[  406.745398][ T8177] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[  406.746373][ T8177] PKRU: 55555554
[  406.746833][ T8177] Call Trace:
[  406.747271][ T8177]  <TASK>
[  406.747651][ T8177]  ? show_regs+0x97/0xa0
[  406.748215][ T8177]  ? die+0x3b/0xb0
[  406.748701][ T8177]  ? do_trap+0x245/0x440
[  406.749262][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
[  406.750005][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
[  406.750711][ T8177]  ? do_error_trap+0xff/0x250
[  406.751342][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
[  406.752094][ T8177]  ? handle_invalid_op+0x39/0x40
[  406.752740][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
[  406.753479][ T8177]  ? exc_invalid_op+0x2e/0x50
[  406.754090][ T8177]  ? asm_exc_invalid_op+0x1a/0x20
[  406.754716][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
[  406.755477][ T8177]  ? __pfx_jffs2_sum_write_sumnode+0x10/0x10
[  406.756234][ T8177]  ? rcu_is_watching+0x12/0xc0
[  406.756861][ T8177]  ? lock_acquire+0x1b1/0x540
[  406.757489][ T8177]  ? __pfx_lock_acquire+0x10/0x10
[  406.758117][ T8177]  ? __pfx___mutex_lock+0x10/0x10
[  406.758769][ T8177]  ? jffs2_do_reserve_space+0xc59/0x1190
[  406.759502][ T8177]  jffs2_do_reserve_space+0xc59/0x1190
[  406.760223][ T8177]  jffs2_reserve_space+0x67e/0xc20
[  406.760883][ T8177]  ? avc_has_perm_noaudit+0x152/0x3d0
[  406.761584][ T8177]  ? __pfx_jffs2_reserve_space+0x10/0x10
[  406.762302][ T8177]  ? avc_has_perm_noaudit+0x152/0x3d0
[  406.763030][ T8177]  ? cred_has_capability.isra.0+0x19d/0x310
[  406.763788][ T8177]  ? __pfx_jffs2_security_setxattr+0x10/0x10
[  406.764567][ T8177]  do_jffs2_setxattr+0x1ab/0x1770
[  406.765224][ T8177]  ? cap_capable+0x1e4/0x250
[  406.765783][ T8177]  ? __pfx_do_jffs2_setxattr+0x10/0x10
[  406.766514][ T8177]  ? xattr_resolve_name+0x292/0x440
[  406.767220][ T8177]  ? __pfx_jffs2_security_setxattr+0x10/0x10
[  406.768026][ T8177]  __vfs_setxattr+0x182/0x1f0
[  406.768646][ T8177]  ? __pfx_evm_protect_xattr.isra.0+0x10/0x10
[  406.769411][ T8177]  ? __pfx___vfs_setxattr+0x10/0x10
[  406.770067][ T8177]  __vfs_setxattr_noperm+0x132/0x610
[  406.770752][ T8177]  __vfs_setxattr_locked+0x195/0x270
[  406.771452][ T8177]  vfs_setxattr+0x151/0x370
[  406.772052][ T8177]  ? __pfx_vfs_setxattr+0x10/0x10
[  406.772704][ T8177]  ? __might_fault+0xee/0x1a0
[  406.773326][ T8177]  do_setxattr+0x153/0x180
[  406.773881][ T8177]  setxattr+0x166/0x180
[  406.774421][ T8177]  ? __pfx_setxattr+0x10/0x10
[  406.775043][ T8177]  ? mnt_get_write_access+0x21d/0x320
[  406.775743][ T8177]  path_setxattr+0x188/0x1f0
[  406.776338][ T8177]  ? __pfx_path_setxattr+0x10/0x10
[  406.776986][ T8177]  ? handle_mm_fault+0x541/0xab0
[  406.777648][ T8177]  __x64_sys_lsetxattr+0xc6/0x160
[  406.778281][ T8177]  ? do_syscall_64+0x91/0x260
[  406.778927][ T8177]  ? lockdep_hardirqs_on+0x7c/0x110
[  406.779598][ T8177]  do_syscall_64+0xd2/0x260
[  406.780194][ T8177]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[  406.780944][ T8177] RIP: 0033:0x437d49
[  406.781454][ T8177] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17
00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 488
[  406.783841][ T8177] RSP: 002b:00007fff7cd51d28 EFLAGS: 00000246
ORIG_RAX: 00000000000000bd
[  406.784889][ T8177] RAX: ffffffffffffffda RBX: 0000000020002047
RCX: 0000000000437d49
[  406.785900][ T8177] RDX: 0000000020002040 RSI: 00000000200002c0
RDI: 00000000200001c0
[  406.786886][ T8177] RBP: 00007fff7cd51d80 R08: 0000000000000003
R09: 000000017cd51d40
[  406.787878][ T8177] R10: 0000000000001009 R11: 0000000000000246
R12: 0000000000000001
[  406.788872][ T8177] R13: 00007fff7cd51f88 R14: 0000000000000001
R15: 0000000000000001
[  406.789879][ T8177]  </TASK>


=3D* repro.c =3D*
    #define _GNU_SOURCE

    #include <dirent.h>
    #include <endian.h>
    #include <errno.h>
    #include <fcntl.h>
    #include <setjmp.h>
    #include <signal.h>
    #include <stdarg.h>
    #include <stdbool.h>
    #include <stddef.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/ioctl.h>
    #include <sys/mman.h>
    #include <sys/mount.h>
    #include <sys/prctl.h>
    #include <sys/stat.h>
    #include <sys/syscall.h>
    #include <sys/types.h>
    #include <sys/wait.h>
    #include <time.h>
    #include <unistd.h>

    #include <linux/loop.h>

    #ifndef __NR_memfd_create
    #define __NR_memfd_create 319
    #endif

    static unsigned long long procid;

    static __thread int clone_ongoing;
    static __thread int skip_segv;
    static __thread jmp_buf segv_env;

    static void segv_handler(int sig, siginfo_t* info, void* ctx) {
        if (__atomic_load_n(&clone_ongoing, __ATOMIC_RELAXED) !=3D 0) {
            exit(sig);
        }
        uintptr_t addr =3D (uintptr_t)info->si_addr;
        const uintptr_t prog_start =3D 1 << 20;
        const uintptr_t prog_end =3D 100 << 20;
        int skip =3D __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) !=3D 0;
        int valid =3D addr < prog_start || addr > prog_end;
        if (skip && valid) {
            _longjmp(segv_env, 1);
        }
        exit(sig);
    }

    static void install_segv_handler(void) {
        struct sigaction sa;
        memset(&sa, 0, sizeof(sa));
        sa.sa_handler =3D SIG_IGN;
        syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
        syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
        memset(&sa, 0, sizeof(sa));
        sa.sa_sigaction =3D segv_handler;
        sa.sa_flags =3D SA_NODEFER | SA_SIGINFO;
        sigaction(SIGSEGV, &sa, NULL);
        sigaction(SIGBUS, &sa, NULL);
    }

    #define NONFAILING(...)                                  \
        ({                                                     \
            int ok =3D 1;                                          \
            __atomic_fetch_add(&skip_segv, 1, __ATOMIC_SEQ_CST); \
            if (_setjmp(segv_env) =3D=3D 0) {                        \
                __VA_ARGS__;                                       \
            } else                                               \
                ok =3D 0;                                            \
            __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST); \
            ok;                                                  \
        })

    static void sleep_ms(uint64_t ms) {
        usleep(ms * 1000);
    }

    static uint64_t current_time_ms(void) {
        struct timespec ts;
        if (clock_gettime(CLOCK_MONOTONIC, &ts))
            exit(1);
        return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
    }

    static bool write_file(const char* file, const char* what, ...) {
        char buf[1024];
        va_list args;
        va_start(args, what);
        vsnprintf(buf, sizeof(buf), what, args);
        va_end(args);
        buf[sizeof(buf) - 1] =3D 0;
        int len =3D strlen(buf);
        int fd =3D open(file, O_WRONLY | O_CLOEXEC);
        if (fd =3D=3D -1)
            return false;
        if (write(fd, buf, len) !=3D len) {
            int err =3D errno;
            close(fd);
            errno =3D err;
            return false;
        }
        close(fd);
        return true;
    }

    //% This code is derived from puff.{c,h}, found in the zlib development=
. The
    //% original files come with the following copyright notice:

    //% Copyright (C) 2002-2013 Mark Adler, all rights reserved
    //% version 2.3, 21 Jan 2013
    //% This software is provided 'as-is', without any express or implied
    //% warranty.  In no event will the author be held liable for any damag=
es
    //% arising from the use of this software.
    //% Permission is granted to anyone to use this software for any purpos=
e,
    //% including commercial applications, and to alter it and redistribute=
 it
    //% freely, subject to the following restrictions:
    //% 1. The origin of this software must not be misrepresented; you must=
 not
    //%    claim that you wrote the original software. If you use this soft=
ware
    //%    in a product, an acknowledgment in the product documentation wou=
ld be
    //%    appreciated but is not required.
    //% 2. Altered source versions must be plainly marked as such, and
must not be
    //%    misrepresented as being the original software.
    //% 3. This notice may not be removed or altered from any source
distribution.
    //% Mark Adler    madler@alumni.caltech.edu

    //% BEGIN CODE DERIVED FROM puff.{c,h}

    #define MAXBITS 15
    #define MAXLCODES 286
    #define MAXDCODES 30
    #define MAXCODES (MAXLCODES + MAXDCODES)
    #define FIXLCODES 288

    struct puff_state {
        unsigned char* out;
        unsigned long outlen;
        unsigned long outcnt;
        const unsigned char* in;
        unsigned long inlen;
        unsigned long incnt;
        int bitbuf;
        int bitcnt;
        jmp_buf env;
    };
    static int puff_bits(struct puff_state* s, int need) {
        long val =3D s->bitbuf;
        while (s->bitcnt < need) {
            if (s->incnt =3D=3D s->inlen)
                longjmp(s->env, 1);
            val |=3D (long)(s->in[s->incnt++]) << s->bitcnt;
            s->bitcnt +=3D 8;
        }
        s->bitbuf =3D (int)(val >> need);
        s->bitcnt -=3D need;
        return (int)(val & ((1L << need) - 1));
    }
    static int puff_stored(struct puff_state* s) {
        s->bitbuf =3D 0;
        s->bitcnt =3D 0;
        if (s->incnt + 4 > s->inlen)
            return 2;
        unsigned len =3D s->in[s->incnt++];
        len |=3D s->in[s->incnt++] << 8;
        if (s->in[s->incnt++] !=3D (~len & 0xff) ||
                s->in[s->incnt++] !=3D ((~len >> 8) & 0xff))
            return -2;
        if (s->incnt + len > s->inlen)
            return 2;
        if (s->outcnt + len > s->outlen)
            return 1;
        for (; len--; s->outcnt++, s->incnt++) {
            if (s->in[s->incnt])
                s->out[s->outcnt] =3D s->in[s->incnt];
        }
        return 0;
    }
    struct puff_huffman {
        short* count;
        short* symbol;
    };
    static int puff_decode(struct puff_state* s, const struct puff_huffman*=
 h) {
        int first =3D 0;
        int index =3D 0;
        int bitbuf =3D s->bitbuf;
        int left =3D s->bitcnt;
        int code =3D first =3D index =3D 0;
        int len =3D 1;
        short* next =3D h->count + 1;
        while (1) {
            while (left--) {
                code |=3D bitbuf & 1;
                bitbuf >>=3D 1;
                int count =3D *next++;
                if (code - count < first) {
                    s->bitbuf =3D bitbuf;
                    s->bitcnt =3D (s->bitcnt - len) & 7;
                    return h->symbol[index + (code - first)];
                }
                index +=3D count;
                first +=3D count;
                first <<=3D 1;
                code <<=3D 1;
                len++;
            }
            left =3D (MAXBITS + 1) - len;
            if (left =3D=3D 0)
                break;
            if (s->incnt =3D=3D s->inlen)
                longjmp(s->env, 1);
            bitbuf =3D s->in[s->incnt++];
            if (left > 8)
                left =3D 8;
        }
        return -10;
    }
    static int puff_construct(struct puff_huffman* h, const short*
length, int n) {
        int len;
        for (len =3D 0; len <=3D MAXBITS; len++)
            h->count[len] =3D 0;
        int symbol;
        for (symbol =3D 0; symbol < n; symbol++)
            (h->count[length[symbol]])++;
        if (h->count[0] =3D=3D n)
            return 0;
        int left =3D 1;
        for (len =3D 1; len <=3D MAXBITS; len++) {
            left <<=3D 1;
            left -=3D h->count[len];
            if (left < 0)
                return left;
        }
        short offs[MAXBITS + 1];
        offs[1] =3D 0;
        for (len =3D 1; len < MAXBITS; len++)
            offs[len + 1] =3D offs[len] + h->count[len];
        for (symbol =3D 0; symbol < n; symbol++)
            if (length[symbol] !=3D 0)
                h->symbol[offs[length[symbol]]++] =3D symbol;
        return left;
    }
    static int puff_codes(struct puff_state* s,
                                                const struct
puff_huffman* lencode,
                                                const struct
puff_huffman* distcode) {
        static const short lens[29] =3D {3,  4,  5,  6,   7,   8,   9,
10,  11, 13,

15, 17, 19, 23,  27,  31,  35,  43,  51, 59,

67, 83, 99, 115, 131, 163, 195, 227, 258};
        static const short lext[29] =3D {0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
1, 1, 2, 2, 2,

2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
        static const short dists[30] =3D {
                1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
                33,   49,   65,   97,   129,  193,  257,  385,   513,   769=
,
                1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 245=
77};
        static const short dext[30] =3D {0, 0, 0,  0,  1,  1,  2,  2,  3,  =
3,

4, 4, 5,  5,  6,  6,  7,  7,  8,  8,

9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
        int symbol;
        do {
            symbol =3D puff_decode(s, lencode);
            if (symbol < 0)
                return symbol;
            if (symbol < 256) {
                if (s->outcnt =3D=3D s->outlen)
                    return 1;
                if (symbol)
                    s->out[s->outcnt] =3D symbol;
                s->outcnt++;
            } else if (symbol > 256) {
                symbol -=3D 257;
                if (symbol >=3D 29)
                    return -10;
                int len =3D lens[symbol] + puff_bits(s, lext[symbol]);
                symbol =3D puff_decode(s, distcode);
                if (symbol < 0)
                    return symbol;
                unsigned dist =3D dists[symbol] + puff_bits(s, dext[symbol]=
);
                if (dist > s->outcnt)
                    return -11;
                if (s->outcnt + len > s->outlen)
                    return 1;
                while (len--) {
                    if (dist <=3D s->outcnt && s->out[s->outcnt - dist])
                        s->out[s->outcnt] =3D s->out[s->outcnt - dist];
                    s->outcnt++;
                }
            }
        } while (symbol !=3D 256);
        return 0;
    }
    static int puff_fixed(struct puff_state* s) {
        static int virgin =3D 1;
        static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
        static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
        static struct puff_huffman lencode, distcode;
        if (virgin) {
            lencode.count =3D lencnt;
            lencode.symbol =3D lensym;
            distcode.count =3D distcnt;
            distcode.symbol =3D distsym;
            short lengths[FIXLCODES];
            int symbol;
            for (symbol =3D 0; symbol < 144; symbol++)
                lengths[symbol] =3D 8;
            for (; symbol < 256; symbol++)
                lengths[symbol] =3D 9;
            for (; symbol < 280; symbol++)
                lengths[symbol] =3D 7;
            for (; symbol < FIXLCODES; symbol++)
                lengths[symbol] =3D 8;
            puff_construct(&lencode, lengths, FIXLCODES);
            for (symbol =3D 0; symbol < MAXDCODES; symbol++)
                lengths[symbol] =3D 5;
            puff_construct(&distcode, lengths, MAXDCODES);
            virgin =3D 0;
        }
        return puff_codes(s, &lencode, &distcode);
    }
    static int puff_dynamic(struct puff_state* s) {
        static const short order[19] =3D {16, 17, 18, 0, 8,  7, 9,  6, 10, =
5,

 11, 4,  12, 3, 13, 2, 14, 1, 15};
        int nlen =3D puff_bits(s, 5) + 257;
        int ndist =3D puff_bits(s, 5) + 1;
        int ncode =3D puff_bits(s, 4) + 4;
        if (nlen > MAXLCODES || ndist > MAXDCODES)
            return -3;
        short lengths[MAXCODES];
        int index;
        for (index =3D 0; index < ncode; index++)
            lengths[order[index]] =3D puff_bits(s, 3);
        for (; index < 19; index++)
            lengths[order[index]] =3D 0;
        short lencnt[MAXBITS + 1], lensym[MAXLCODES];
        struct puff_huffman lencode =3D {lencnt, lensym};
        int err =3D puff_construct(&lencode, lengths, 19);
        if (err !=3D 0)
            return -4;
        index =3D 0;
        while (index < nlen + ndist) {
            int symbol;
            int len;
            symbol =3D puff_decode(s, &lencode);
            if (symbol < 0)
                return symbol;
            if (symbol < 16)
                lengths[index++] =3D symbol;
            else {
                len =3D 0;
                if (symbol =3D=3D 16) {
                    if (index =3D=3D 0)
                        return -5;
                    len =3D lengths[index - 1];
                    symbol =3D 3 + puff_bits(s, 2);
                } else if (symbol =3D=3D 17)
                    symbol =3D 3 + puff_bits(s, 3);
                else
                    symbol =3D 11 + puff_bits(s, 7);
                if (index + symbol > nlen + ndist)
                    return -6;
                while (symbol--)
                    lengths[index++] =3D len;
            }
        }
        if (lengths[256] =3D=3D 0)
            return -9;
        err =3D puff_construct(&lencode, lengths, nlen);
        if (err && (err < 0 || nlen !=3D lencode.count[0] + lencode.count[1=
]))
            return -7;
        short distcnt[MAXBITS + 1], distsym[MAXDCODES];
        struct puff_huffman distcode =3D {distcnt, distsym};
        err =3D puff_construct(&distcode, lengths + nlen, ndist);
        if (err && (err < 0 || ndist !=3D distcode.count[0] + distcode.coun=
t[1]))
            return -8;
        return puff_codes(s, &lencode, &distcode);
    }
    static int puff(unsigned char* dest,
                                    unsigned long* destlen,
                                    const unsigned char* source,
                                    unsigned long sourcelen) {
        struct puff_state s =3D {
                .out =3D dest,
                .outlen =3D *destlen,
                .outcnt =3D 0,
                .in =3D source,
                .inlen =3D sourcelen,
                .incnt =3D 0,
                .bitbuf =3D 0,
                .bitcnt =3D 0,
        };
        int err;
        if (setjmp(s.env) !=3D 0)
            err =3D 2;
        else {
            int last;
            do {
                last =3D puff_bits(&s, 1);
                int type =3D puff_bits(&s, 2);
                err =3D type =3D=3D 0 ? puff_stored(&s)
                                                : (type =3D=3D 1 ? puff_fix=
ed(&s)

  : (type =3D=3D 2 ? puff_dynamic(&s) : -1));
                if (err !=3D 0)
                    break;
            } while (!last);
        }
        *destlen =3D s.outcnt;
        return err;
    }

    //% END CODE DERIVED FROM puff.{c,h}

    #define ZLIB_HEADER_WIDTH 2

    static int puff_zlib_to_file(const unsigned char* source,
                                                             unsigned
long sourcelen,
                                                             int dest_fd) {
        if (sourcelen < ZLIB_HEADER_WIDTH)
            return 0;
        source +=3D ZLIB_HEADER_WIDTH;
        sourcelen -=3D ZLIB_HEADER_WIDTH;
        const unsigned long max_destlen =3D 132 << 20;
        void* ret =3D mmap(0, max_destlen, PROT_WRITE | PROT_READ,
                                         MAP_PRIVATE | MAP_ANON, -1, 0);
        if (ret =3D=3D MAP_FAILED)
            return -1;
        unsigned char* dest =3D (unsigned char*)ret;
        unsigned long destlen =3D max_destlen;
        int err =3D puff(dest, &destlen, source, sourcelen);
        if (err) {
            munmap(dest, max_destlen);
            errno =3D -err;
            return -1;
        }
        if (write(dest_fd, dest, destlen) !=3D (ssize_t)destlen) {
            munmap(dest, max_destlen);
            return -1;
        }
        return munmap(dest, max_destlen);
    }

    static int setup_loop_device(unsigned char* data,
                                                             unsigned long =
size,
                                                             const
char* loopname,
                                                             int* loopfd_p)=
 {
        int err =3D 0, loopfd =3D -1;
        int memfd =3D syscall(__NR_memfd_create, "syzkaller", 0);
        if (memfd =3D=3D -1) {
            err =3D errno;
            goto error;
        }
        if (puff_zlib_to_file(data, size, memfd)) {
            err =3D errno;
            goto error_close_memfd;
        }
        loopfd =3D open(loopname, O_RDWR);
        if (loopfd =3D=3D -1) {
            err =3D errno;
            goto error_close_memfd;
        }
        if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
            if (errno !=3D EBUSY) {
                err =3D errno;
                goto error_close_loop;
            }
            ioctl(loopfd, LOOP_CLR_FD, 0);
            usleep(1000);
            if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
                err =3D errno;
                goto error_close_loop;
            }
        }
        close(memfd);
        *loopfd_p =3D loopfd;
        return 0;

    error_close_loop:
        close(loopfd);
    error_close_memfd:
        close(memfd);
    error:
        errno =3D err;
        return -1;
    }

    static long syz_mount_image(volatile long fsarg,
                                                            volatile long d=
ir,
                                                            volatile long f=
lags,
                                                            volatile
long optsarg,
                                                            volatile
long change_dir,
                                                            volatile
unsigned long size,
                                                            volatile
long image) {
        unsigned char* data =3D (unsigned char*)image;
        int res =3D -1, err =3D 0, loopfd =3D -1, need_loop_device =3D !!si=
ze;
        char* mount_opts =3D (char*)optsarg;
        char* target =3D (char*)dir;
        char* fs =3D (char*)fsarg;
        char* source =3D NULL;
        char loopname[64];
        if (need_loop_device) {
            memset(loopname, 0, sizeof(loopname));
            snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
            if (setup_loop_device(data, size, loopname, &loopfd) =3D=3D -1)
                return -1;
            source =3D loopname;
        }
        mkdir(target, 0777);
        char opts[256];
        memset(opts, 0, sizeof(opts));
        if (strlen(mount_opts) > (sizeof(opts) - 32)) {
        }
        strncpy(opts, mount_opts, sizeof(opts) - 32);
        if (strcmp(fs, "iso9660") =3D=3D 0) {
            flags |=3D MS_RDONLY;
        } else if (strncmp(fs, "ext", 3) =3D=3D 0) {
            bool has_remount_ro =3D false;
            char* remount_ro_start =3D strstr(opts, "errors=3Dremount-ro");
            if (remount_ro_start !=3D NULL) {
                char after =3D *(remount_ro_start + strlen("errors=3Dremoun=
t-ro"));
                char before =3D remount_ro_start =3D=3D opts ? '\0' :
*(remount_ro_start - 1);
                has_remount_ro =3D ((before =3D=3D '\0' || before =3D=3D ',=
') &&
                                                    (after =3D=3D '\0' ||
after =3D=3D ','));
            }
            if (strstr(opts, "errors=3Dpanic") || !has_remount_ro)
                strcat(opts, ",errors=3Dcontinue");
        } else if (strcmp(fs, "xfs") =3D=3D 0) {
            strcat(opts, ",nouuid");
        }
        res =3D mount(source, target, fs, flags, opts);
        if (res =3D=3D -1) {
            err =3D errno;
            goto error_clear_loop;
        }
        res =3D open(target, O_RDONLY | O_DIRECTORY);
        if (res =3D=3D -1) {
            err =3D errno;
            goto error_clear_loop;
        }
        if (change_dir) {
            res =3D chdir(target);
            if (res =3D=3D -1) {
                err =3D errno;
            }
        }

    error_clear_loop:
        if (need_loop_device) {
            ioctl(loopfd, LOOP_CLR_FD, 0);
            close(loopfd);
        }
        errno =3D err;
        return res;
    }

    static void kill_and_wait(int pid, int* status) {
        kill(-pid, SIGKILL);
        kill(pid, SIGKILL);
        for (int i =3D 0; i < 100; i++) {
            if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
                return;
            usleep(1000);
        }
        DIR* dir =3D opendir("/sys/fs/fuse/connections");
        if (dir) {
            for (;;) {
                struct dirent* ent =3D readdir(dir);
                if (!ent)
                    break;
                if (strcmp(ent->d_name, ".") =3D=3D 0 ||
strcmp(ent->d_name, "..") =3D=3D 0)
                    continue;
                char abort[300];
                snprintf(abort, sizeof(abort),
"/sys/fs/fuse/connections/%s/abort",
                                 ent->d_name);
                int fd =3D open(abort, O_WRONLY);
                if (fd =3D=3D -1) {
                    continue;
                }
                if (write(fd, abort, 1) < 0) {
                }
                close(fd);
            }
            closedir(dir);
        } else {
        }
        while (waitpid(-1, status, __WALL) !=3D pid) {
        }
    }

    static void reset_loop() {
        char buf[64];
        snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
        int loopfd =3D open(buf, O_RDWR);
        if (loopfd !=3D -1) {
            ioctl(loopfd, LOOP_CLR_FD, 0);
            close(loopfd);
        }
    }

    static void setup_test() {
        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
        setpgrp();
        write_file("/proc/self/oom_score_adj", "1000");
    }

    static void execute_one(void);

    #define WAIT_FLAGS __WALL

    static void loop(void) {
        int iter =3D 0;
        for (;; iter++) {
            reset_loop();
            int pid =3D fork();
            if (pid < 0)
                exit(1);
            if (pid =3D=3D 0) {
                setup_test();
                execute_one();
                exit(0);
            }
            int status =3D 0;
            uint64_t start =3D current_time_ms();
            for (;;) {
                if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
                    break;
                sleep_ms(1);
                if (current_time_ms() - start < 5000)
                    continue;
                kill_and_wait(pid, &status);
                break;
            }
        }
    }

    void execute_one(void) {
        NONFAILING(memcpy((void*)0x20000040, "vfat\000", 5));
        NONFAILING(memcpy((void*)0x20000200, "./file0\000", 8));
        NONFAILING(syz_mount_image(/*fs=3D*/0x20000040, /*dir=3D*/0x2000020=
0,

/*flags=3D*/0x220e002, /*opts=3D*/0, /*chdir=3D*/1,

/*size=3D*/0, /*img=3D*/0x20000100));
        NONFAILING(memcpy((void*)0x20000040, "mtd", 3));
        NONFAILING(sprintf((char*)0x20000043, "0x%016llx", (long long)0));
        NONFAILING(memcpy((void*)0x200000c0, "./file0\000", 8));
        NONFAILING(memcpy((void*)0x20001200, "jffs2\000", 6));
        syscall(__NR_mount, /*src=3D*/0x20000040ul, /*dst=3D*/0x200000c0ul,
                        /*type=3D*/0x20001200ul, /*flags=3D*/0ul, /*data=3D=
*/0ul);
        NONFAILING(memcpy((void*)0x200001c0, "./file0\000", 8));
        NONFAILING(memcpy((void*)0x200002c0, "security.evm\000", 13));
        NONFAILING(*(uint8_t*)0x20002040 =3D 3);
        NONFAILING(*(uint8_t*)0x20002041 =3D 2);
        NONFAILING(*(uint8_t*)0x20002042 =3D 0xb);
        NONFAILING(*(uint32_t*)0x20002043 =3D htobe32(4));
        NONFAILING(*(uint16_t*)0x20002047 =3D htobe16(0x1000));
        NONFAILING(memcpy(
                (void*)0x20002049,

"\x78\x8d\x9c\xb2\x99\xab\xd7\x2e\xce\x91\x3d\x53\x36\x5e\x16\x68\x8e\x51"

"\xac\xe1\x59\x84\xab\x53\xd1\x66\x6a\xe3\xf5\xdf\xbc\x86\x0b\xef\x87\x38"

"\x9e\x21\x28\x6b\xe2\x36\xdd\xc3\xd0\xfa\x2e\x51\xd5\xc5\xc7\xb3\x5c\x5d"

"\x50\x3c\x5b\x2c\x3b\x6b\xe0\xfc\x56\xe9\x7d\xf8\x8f\xaa\x06\x35\x36\x3b"

"\xa9\x2b\x82\xc4\x7a\x81\x7a\xc9\x7f\x1d\x63\x8a\x14\x61\x82\x12\x55\xec"

"\x23\xbd\x0c\xe5\xbf\x10\x94\xe3\xa8\x98\x0d\x7e\x6d\x19\x76\xba\x77\x87"

"\x45\x92\x0e\x17\x18\xfd\xda\xc4\xbd\x66\xb0\xa6\x06\x80\x1a\xae\xfd\xed"

"\x29\x3c\x3f\xce\xba\xd3\xb2\xc0\x64\x03\xdb\xa9\x99\x49\x71\x65\x9b\x7f"

"\x4a\x07\x7a\xdd\xae\xb8\xae\x3e\x5a\xca\x70\x27\xfd\xe1\xe4\x00\x01\xc0"

"\xbd\xd8\x00\xbc\xc2\x87\xe0\x2c\x86\x7e\x27\x82\xde\xaf\x67\x6a\x26\x16"

"\x47\xdb\x8c\x2f\x39\x45\x02\x20\x57\xde\x76\x81\x00\xa8\xbf\x73\xd9\xf9"

"\xff\x29\x22\x9b\x46\xde\xad\x58\xb2\xdd\xf9\x64\x33\x46\x8e\x9e\xee\x89"

"\x50\xdf\x65\x87\x11\xe4\x11\x36\x4e\x44\x14\x5e\x68\x2f\x3c\x05\x3c\x6f"

"\x5a\x18\x61\xee\xe6\xed\xf8\x85\xa9\x7c\x54\x58\x05\xac\x0c\x35\xa5\xe4"

"\x62\x3b\x20\x01\x86\x1c\x59\x33\x54\xb5\x70\xff\x3b\x4a\x45\xf1\xac\xde"

"\x0a\x8d\xbd\x17\xc0\x9c\xe4\x48\xed\x5d\xfd\x9e\x74\x72\xe6\x89\x67\xde"

"\xcb\x76\x9f\xa6\x00\xcd\x30\xbe\xb6\xc8\x03\x0e\x94\x74\xc7\xec\x4c\x1d"

"\xaf\x3e\x00\x7b\xbc\x57\x65\xb3\x66\xd4\xa1\x76\xe3\x8b\xdf\xab\xed\xd2"

"\xb0\x76\xa5\xed\x7d\x50\xf5\x17\x7b\x94\xa6\xa0\xf0\x00\xcd\x3a\xca\xdd"

"\xe8\xe8\x0f\x66\xea\xda\x14\x01\x86\x20\xb1\x59\xe9\xe1\x4c\x25\x2d\x20"

"\xc8\xdb\xb0\xfe\x36\x05\xb5\x69\x8b\x53\xe4\x21\x0b\x62\xfc\xbd\x00\x01"

"\x7e\xaa\x01\xeb\x1f\xa5\x21\xbd\xb8\xd3\x0e\x83\x95\x1b\x4e\xa0\x28\x6c"

"\x8f\x0d\x46\x45\x17\xa1\x1d\x79\x22\xd6\xcc\xe4\xd2\x05\x8e\xc8\xcd\x7b"

"\x02\xb7\x3d\x82\x5d\x7e\x0a\xbb\xbd\x85\xe9\x91\x22\x0f\xc7\x99\x55\x34"

"\xb7\xb1\x99\x8c\xa7\x52\x89\x0b\x07\x9a\x7c\xa3\xfd\xe5\x64\x38\xcf\x82"

"\xd5\xdd\x9e\xdb\xd1\x1f\xd2\x93\xc1\x7d\x1c\xf1\x66\x57\xd0\xb3\x52\xa8"

"\xc6\xc3\x63\x00\xad\x09\xa7\x8e\x3e\xe3\x91\x3b\x9b\x6f\x53\xde\xbf\xfc"

"\x7e\x32\xbf\xb6\x4b\x0e\x8c\xbe\x07\xfe\x9b\x0d\xad\xb0\x97\xae\xb2\xc2"

"\x42\x43\x0b\xec\x75\x63\x0a\x39\x21\x82\x8a\x73\x14\xde\x14\x04\x82\x9e"

"\x7a\xfb\x3b\x84\x20\xe8\x5f\x2c\x8f\x6e\x88\xde\x04\x23\x14\x41\x6e\x5c"

"\x00\xc5\x9b\x22\x20\x80\x04\xbe\xc1\x61\xf8\x45\x7c\x7f\x8e\x3a\x8c\xa4"

"\x17\x4a\x4b\x78\xdf\x6e\x46\x0d\x56\xd2\x4e\x01\xae\x1a\x24\x11\x27\x0f"

"\x79\xd0\x20\xa6\xba\xc8\x55\xf1\xa3\xef\x7b\x3d\x09\x91\x88\x26\x56\xb4"

"\x08\xdc\xda\xf0\x2d\xb4\x6a\xc8\xfc\xab\x0c\x87\x5d\x1f\x2e\x8d\xb3\x66"

"\xe6\xa2\x0c\xb6\x7a\x4d\xb9\x20\x38\x2a\x69\x15\x71\x5d\x3b\x42\x66\xf7"

"\x79\xfe\x86\x33\xbe\xa6\xde\xf2\x8c\xc1\x59\x13\x8b\x83\x43\x34\xce\xde"

"\xf3\xde\xc5\x4e\xa5\x30\x3d\xf5\x6b\xe8\x71\x15\x31\x5e\xc0\xf1\x47\x8a"

"\x0c\x08\x69\xe5\xf7\xc3\x3d\xa6\x4b\x23\xaf\x58\x11\x75\x10\x55\xc9\x08"

"\x49\x48\x44\x81\xd5\xa1\x0d\x72\xe0\x8c\xcd\x12\x71\x0c\x4f\x2f\xf5\x86"

"\xa9\xea\x17\x5f\x4a\xa7\x0b\x15\x6c\x00\xc5\x7e\x22\xc1\x36\x0b\xfc\x7d"

"\x36\xaa\x47\x92\x44\x4f\x81\xd8\xa0\xed\x41\xbf\x6a\x45\x2e\xa5\x26\x8b"

"\x86\x05\x68\x2a\xc6\x3e\xaa\x46\x52\x18\xf4\xd9\x62\xdb\x42\x15\x4d\x01"

"\x96\x6d\x3a\xd8\xfc\x2f\xde\x48\xef\x71\xbe\x08\xbe\x58\xe5\xad\x6d\x5a"

"\x35\x93\xef\xc9\xc1\x33\x6e\x54\x13\x72\xa3\x47\x99\xd2\x4e\xa0\x0d\x4d"

"\x49\x85\xbe\xd1\xda\xb1\x06\x20\x91\x1e\x9f\x69\x67\x88\x08\x26\xbe\x5a"

"\x1f\x1b\xb4\xb2\xa3\x94\x86\x54\xc6\x93\x5c\xaf\xeb\x49\x25\xe1\x07\xa0"

"\x1f\x9d\xda\x66\x8e\x5f\xd7\x48\x9e\x82\x13\x92\x41\xa9\x19\x0f\x09\x0a"

"\xfe\x20\x94\x23\x4c\x75\xfe\xc0\x74\x62\x27\x48\xd4\xdd\x78\x2a\x93\x0f"

"\x42\xb0\xe7\x5d\x92\x4b\xef\x68\xff\xaf\xba\xa9\x89\x16\x15\x1a\x36\xef"

"\x29\x98\xaf\xd3\x00\x09\x55\xef\xbf\xa0\xa9\xa0\x08\x35\x8c\x11\x04\x3c"

"\x0f\x96\xb5\x2f\xc7\x8a\x42\x53\x1a\xa5\xdf\xd8\xde\x09\x51\x8c\xff\x00"

"\x8b\x33\x92\x59\xb2\x66\xc4\x88\xbb\x1d\xa0\x58\xba\x21\x8c\xd6\x4b\x3e"

"\x41\x3c\xa2\x88\x9d\x10\x86\xe8\xc4\x0a\xe1\x15\x01\x98\x41\x21\xdc\xfa"

"\x2f\xde\x09\xd0\x68\xf6\xdb\xbe\x83\x59\x98\x0d\xad\x96\xed\x22\x0b\x85"

"\x34\xaa\xef\x35\x3d\xfc\x81\x56\x09\x07\xd2\x6c\x02\x44\x29\x24\xad\x55"

"\xb1\x1d\x3a\xee\x7e\x55\x16\xd9\x6a\xd0\x78\xc8\x5a\xd1\xcd\xb1\x8a\x45"

"\x47\x43\x05\xa8\xdb\x35\x0f\x98\x44\x38\x0e\x20\x94\xf6\x91\xa0\x5e\xa0"

"\x94\x58\xbc\x53\xf3\x23\x6a\x1f\x3f\xa5\xe1\x44\xa5\x75\xba\x57\xe5\x8d"

"\x00\xf7\x65\x3d\x2e\x6b\x6c\xbe\x18\xd2\x8c\xe3\xf5\x79\x25\x38\xad\x20"

"\xc0\xe0\xe1\x0b\x03\xda\xc3\x40\x09\xd6\xd3\xe4\xc7\x66\x2c\xca\x88\xb5"

"\x30\x66\xe9\x5e\xfe\x45\xee\x3e\x04\xda\x32\x86\x90\xda\xe1\xaa\x00\x70"

"\xf0\x94\x5e\x26\x9b\x75\x73\x3b\x10\x6f\xf6\x51\x45\x55\xd5\x4d\x95\x8f"

"\x73\x13\x44\x1f\xa2\x1f\x97\x61\x53\x12\xc4\xf6\x00\xa1\x43\x0f\x62\x98"

"\x12\xf2\x3c\xd2\x1e\x70\x3b\x96\x6e\x04\xaa\x6d\x0b\xba\x6f\x25\x39\x36"

"\x9a\x3b\xad\xeb\xfa\xa8\x19\x7d\x89\xe3\x29\x4b\x44\xc0\xea\x54\xae\x6b"

"\x7f\x4a\x49\x65\x68\x04\x31\x75\xa5\x66\x65\x41\xb5\x59\xa9\xfe\xaf\x0c"

"\x54\x54\xf1\x2f\x23\x0e\x97\xbc\xf8\x4d\xae\x11\xd1\xa8\x35\x94\x11\xb9"

"\x8b\xb6\x06\x3e\xe8\xae\x0f\xfa\x30\xb5\x75\x77\x71\xc7\xb7\x0e\x4f\xbb"

"\x6e\x95\x1a\x68\x08\x73\xe6\xda\x53\x16\x00\xe9\x51\x11\x0c\x34\xca\xac"

"\xc8\xe9\x78\xc0\x6b\x48\x48\xc8\x80\xc4\x8a\xd8\xe6\xc5\x4b\xc7\x92\xce"

"\x54\xea\x4b\x1c\x05\xab\x04\xaf\xb4\xd6\xca\xb2\x5b\x85\xd1\xc4\xb6\xc4"

"\x74\xc7\xec\x92\x67\xb5\x01\xed\xaa\x20\xee\x0e\x41\x58\x68\xd8\x78\x66"

"\x42\x6b\x13\x74\xe5\x8a\x66\x65\x30\xb9\x4e\x34\x2c\x8b\x2e\xbd\xd4\x05"

"\xfe\xf0\xa2\x6d\xf8\x2b\xbc\x50\x2d\xa2\xca\x15\x50\xc2\x8d\x3c\x0b\x69"

"\x87\x2f\xf8\x61\xcd\x23\xcb\x6e\x1f\xf1\xe6\x2f\x62\x5a\xe9\x2f\x90\xf3"

"\x09\x33\xfc\x82\x7e\xdd\x38\x61\x21\x31\x53\x52\xdb\xc9\xf4\xca\xb3\xdd"

"\xda\xde\xb8\xdf\x05\x1d\x2f\x59\xcd\x59\xe9\x7d\xc9\x2c\xe4\x34\x1f\x97"

"\x80\x03\xe4\x86\x85\xe7\x67\x3c\xf1\xe6\x02\x60\x60\x0e\x7c\xbf\x73\x1d"

"\xc1\x68\xb9\xa4\x11\xdc\x3c\x85\xf8\x43\xbd\x2c\x5f\xca\x89\xc0\x6d\x12"

"\xba\xc0\x8a\x61\xcf\x09\x9a\xe5\xf2\x3e\x5e\x90\x84\x48\xe8\x1f\x27\x79"

"\xb3\x85\xb3\x1d\xcd\x5c\xf8\xaa\xad\x4b\x85\xae\x70\x63\x62\x4a\x7d\xf5"

"\x73\xae\xcc\xc8\xb6\x19\x77\xf8\xec\x10\xe6\x8b\x5d\xf1\xc1\xb8\x05\xc7"

"\xe0\x01\x22\x8a\x65\xc0\xe7\x72\xc5\x25\x14\x66\xa4\x9f\x10\x21\x9b\xb7"

"\x18\xa4\xaa\x2e\x35\xc4\x08\x11\xa9\x72\xeb\x58\x53\x0f\x7f\x07\x41\xd3"

"\xbe\x0c\x00\xe3\x8f\x58\x99\x4a\x51\x99\x54\x7f\xc5\x15\x0c\x78\x1f\xfe"

"\x2e\x56\x56\x0f\x08\xeb\x75\xbf\xcd\x90\x85\xff\x14\x0c\xee\xfd\x0d\x6e"

"\xd4\x3d\xad\x39\xd2\xcd\xa8\x69\x4d\x42\x0e\x86\x1a\x1d\xec\x4a\x28\xd1"

"\xcf\x53\x24\xc5\xc5\xab\x81\x92\x21\x54\x87\x3b\x3f\x82\xdf\x1b\xc0\x6c"

"\xb9\x56\x5c\x08\xf7\x74\xd9\xfa\x6f\xe5\x75\xda\xf8\x7b\x32\x8a\xb1\x0b"

"\x91\x22\x43\xf1\x00\x71\x2a\x27\xf4\x98\x1f\xaa\x37\x2d\x73\x67\x02\xc5"

"\x65\xa0\x8c\x4d\x6b\x0a\xa3\x12\xd3\xc9\x01\x7f\xd1\xe7\xab\x98\x1d\xe7"

"\xee\x1d\xfc\x1a\x84\x99\x24\xaa\x92\xea\xb1\xb3\xe6\xe9\x74\x2f\x69\x13"

"\xa0\x8b\x56\x99\xd6\x70\x69\x7a\x60\x8d\x74\x9e\x06\xc3\x41\x42\x1a\x80"

"\x9a\x36\x5d\xca\x3f\x8d\x88\xd8\x42\x68\x50\x80\xf8\xed\x93\x48\x28\x88"

"\x06\x5b\x50\xbf\x9a\xbd\xe7\x5f\xe3\x7c\x8f\xf2\xae\x4f\x24\xe2\x6f\x83"

"\x94\x9a\xb5\xc4\xf4\xa9\x6e\x13\xb2\xcd\xf7\x42\xda\xf9\xc1\xb5\x83\x05"

"\x69\x14\x56\xc6\xc1\x90\xbf\xb7\xbb\xbb\x08\x4e\xa9\xf9\x7e\x99\xc3\xe0"

"\x28\x41\x5d\x4e\x05\xcc\xf7\x71\x7b\x57\x97\xff\x5b\xaf\xa2\x51\x8a\x0a"

"\xca\xb4\x34\xa1\x88\xd4\x79\x7a\x85\xf3\x65\x57\xdd\x6a\xa3\x9c\x75\xe8"

"\x0b\x72\x49\x63\x72\x65\x25\x44\xb1\x42\x49\x01\xa6\xa9\xd4\xb7\x45\x30"

"\x86\xb6\xba\x26\xa4\x05\x21\xda\x94\xab\x54\xde\x4a\x11\xb5\x1b\x4a\xd7"

"\xab\x1d\x68\x05\xf3\x23\xb0\x44\x95\x5f\x77\x9c\xfe\x7c\x1c\x35\x86\xf4"

"\xbe\x0e\xab\x22\x6a\x25\xae\x16\xbd\x8d\xc7\xeb\x01\x50\x24\xb7\x43\x4b"

"\x64\x08\x34\x3a\x1b\xe6\xe1\xdd\x39\x25\xc1\x02\xb4\xc9\xc5\x43\x98\x38"

"\x35\xb6\xbb\x45\xf8\x0e\xa3\x5b\xf7\xfc\xec\xab\x5d\x94\x72\x24\xbf\xdb"

"\x1c\x03\xb2\x0f\xc0\x7a\x5c\xac\x63\x0b\xeb\x4b\x30\x44\xeb\xe5\x5c\x90"

"\x23\x84\x4c\x1f\xd6\x4b\x4e\xb0\x25\x53\x68\x67\xf0\xaf\xa3\x88\x57\x6c"

"\x5b\x25\x64\xcd\x2e\x20\xae\x26\x33\xf7\xb7\x6c\xf6\xfb\xce\xff\x24\x0f"

"\x65\xe5\xee\xba\x28\x43\xfa\xa1\xe7\x71\x08\xd3\x5c\x59\xb3\xf5\x70\x11"

"\x26\x60\xe9\x27\x8d\xa3\x12\x76\x86\xdc\x2a\x96\x5a\x6a\xd1\x67\x2e\x29"

"\xff\x9e\xdd\x62\xf4\x9e\x41\xbd\xd6\x53\x48\xd2\x65\x78\x46\xbe\x80\x47"

"\x9c\xea\x41\x5b\xfb\x59\x27\x22\x9f\x3b\x77\x2e\xd9\xc9\xb7\x63\x9d\x8f"

"\x75\xff\x66\x21\x84\x1a\x7b\x64\x97\x81\x31\xe8\x69\x52\xbf\xe5\x10\x71"

"\x5b\x25\xef\xbc\xf3\x93\x32\x0c\x1d\x62\x99\xac\x6c\x19\xdd\x90\x88\x70"

"\xf9\x6d\x92\xb8\xbd\xcf\x11\xe3\xc9\x87\x8f\x2e\x37\xbd\xaf\x72\x71\x8a"

"\xd0\xbc\x28\x72\xc7\xa0\xb1\x01\xf6\xe3\x92\x99\x72\x34\xe0\x6c\x9b\x1b"

"\xdc\x32\x49\x71\x42\x7d\x6b\x97\xc3\xc1\x65\x31\x17\x8f\x40\xa8\xab\x52"

"\xf9\x8e\x06\x67\x80\x97\x7a\xbd\x35\x2e\x1e\xfe\x61\x85\xf7\x02\x33\xb3"

"\x0f\xdc\x96\xb6\xa2\x89\xb9\xe0\xfc\xee\x55\x59\x23\xef\x59\x0b\xd9\xcd"

"\x2f\x0e\xf7\x02\x46\x41\x45\x0d\x1a\x92\x58\x04\x6a\xc0\xe8\x0a\xcd\x44"

"\xf2\x67\x44\x69\x46\xc0\x96\xdb\x98\x48\xf7\x8c\xdd\xba\x9f\x54\x09\xb0"

"\x90\xdd\x23\x44\xd8\xd4\x5a\x16\xcd\x2e\xcc\xe5\xbf\x22\xbd\x4c\xb8\x9a"

"\xfd\x30\x67\xcb\x0b\xd9\xa7\x27\x9b\xe1\xb1\xe5\x03\x49\x8f\x39\xed\xce"

"\x71\x4f\x37\x59\x7d\x0e\x64\x60\x71\x6d\x09\xea\x37\x6d\x73\xe8\xa7\x1f"

"\xff\x13\x24\xfa\x2a\xeb\xa7\x5e\x8b\xbd\x0e\xa4\xc4\x18\xb4\x57\x84\x55"

"\x01\x53\xd4\x92\x89\x8e\x15\xda\x88\xb6\xed\x3f\x67\xe8\x5d\xbb\x11\x1c"

"\x2f\xea\xc2\xfd\x78\xb6\xf9\x01\x1c\x68\x64\xb9\xbb\x11\x65\x36\x94\xf7"

"\xf0\x25\x68\xb7\x68\xb6\xa2\x7d\x08\x0e\xad\xc0\x09\x37\x44\xb9\x11\x5a"

"\xa2\xf8\xd0\x3f\xa2\x7f\xae\xa2\xe3\x56\xef\x8c\xe6\x2e\x47\x22\xdd\xd1"

"\x39\xf7\x84\xac\x3b\x8a\xfb\x98\xc8\xd3\x98\x4c\x8c\xf9\x43\x8e\x83\x71"

"\x03\x30\x42\x8b\x78\x30\xc1\x70\x9a\x30\x9b\xba\xc3\xbb\xdb\xd0\x83\xe5"

"\x39\x93\x8c\x57\x89\xe1\x70\x9d\x2c\x0e\xe9\x4d\xcb\x2f\xe6\x4c\x31\xc8"

"\x7d\x25\xcc\x7f\x82\x6b\xbf\x5e\x02\x1d\x5a\xaa\x17\x29\x70\xaa\xe9\x6a"

"\x68\x58\xf8\xc1\x1f\xdf\xb7\x48\x32\x8d\x97\x41\x1e\xdc\x10\xdd\x16\xfd"

"\x10\xfa\xa7\xc3\xb9\x4c\xe1\x91\x52\xfb\x29\x65\x69\x04\x21\xd3\xc6\xdb"

"\x2e\x7e\x88\x88\xc7\xbb\x06\x44\x3d\xb3\x11\x1e\x3d\xb6\x9a\x88\xdd\x09"

"\x7a\xb8\xc6\x4d\x6b\xea\x30\xda\x24\x7f\xcd\x11\x7a\x30\xee\xf4\x5c\xd9"

"\x33\x9a\x78\x37\x56\x28\xcd\xbf\xa2\x6d\x6b\x34\x19\xe6\x9b\xbe\x8e\x88"

"\x47\x91\x29\x68\x4b\x23\x04\xda\xa2\xd6\x84\x30\x48\x26\xee\xe9\x7d\x34"

"\x63\x03\xcc\x63\x1e\x10\x46\x5a\x2f\x92\x43\xe8\x4d\x32\x28\x10\x38\x8b"

"\xa2\xd3\x06\x26\xa6\x3d\xf9\x79\x3e\xb9\x63\xdf\x23\x48\x65\xcb\xb6\x8c"

"\xdb\xc0\x43\x63\xe1\x7a\x6a\x6e\xb1\xc8\x01\x41\x77\xc9\x9f\xaa\xcb\x8d"

"\x7a\x8e\x99\xd8\x97\x71\x8b\xc5\x10\x55\x72\x78\x20\xd3\x21\xf2\x5f\xd1"

"\x5d\x24\xd0\x29\xd4\xfa\xd6\xfd\xe9\x7f\x09\x11\x80\xef\x2b\xc3\x91\x3b"

"\xc1\x1f\x8f\x10\x4b\xcc\x7e\xa0\x02\x41\x57\x48\x1b\x35\x37\xce\x54\x3f"

"\xe8\xab\x93\xa2\x6c\xb9\xba\x51\xfa\x78\xd3\x37\xbf\x10\xba\x29\xdc\x5f"

"\xeb\xfe\x4a\xd0\x14\xbd\x40\xf3\x33\x30\x82\x3d\x7f\x45\x73\xba\xeb\xd9"

"\xe0\x63\xd5\x9a\x87\x66\x2b\xef\x85\x9c\xee\x8a\x8e\x53\x18\xaa\xe2\x2e"

"\x79\xfb\x4d\x31\xe0\x88\xf0\x56\x9c\x67\xbb\xa4\x18\x68\xfe\x46\x4e\xd7"

"\x7e\xc7\xfe\x07\xdd\x3a\x5c\x2c\x81\xc1\xfd\xed\x16\x05\x98\xb3\x75\x64"

"\x51\x31\x73\xf1\x3f\xee\xb9\xdf\x4b\x47\xed\xe8\x05\x0a\xac\x43\x1e\x1b"

"\x20\x58\xc6\xaf\xe7\xe4\x4b\xcc\x6f\x28\xdc\x58\x33\xdd\xed\x10\xe6\x91"

"\x7e\x15\xb9\x30\x88\xcd\x90\x79\x18\x26\xca\x7c\x3b\x9a\x42\x11\xe9\xe2"

"\xff\xd4\x96\x62\x23\x81\x6d\xb6\xe4\xed\xe5\x70\x1b\x76\x98\x8d\x8f\x34"

"\xaa\x14\x0f\xfb\x4b\xc3\xef\xfc\xcb\xe5\xaf\x39\x42\xd4\xc5\x71\x77\x00"

"\xe5\x92\xa1\x70\x01\xd2\x0b\x66\x5f\xb7\xc6\xf6\x53\x61\x10\x8a\x13\x70"

"\xa4\x5d\xb4\x77\xa1\xf4\x49\xe5\xc3\xf9\xa8\x9f\x96\x72\x90\xaf\x23\x1d"

"\xb8\x2f\xed\xec\xfc\xa2\xc3\xce\xdf\xfe\xad\xb7\x75\x72\x8b\x45\xce\x4b"

"\xde\x06\x30\xe9\xe1\xdf\xcd\x98\x13\x8a\x55\x6d\xd4\x0b\x65\x55\x81\xb4"

"\x51\xa7\x16\x4a\xd5\x7c\x4f\xb2\xb5\xdc\x5b\x14\x5e\x87\x33\xde\x33\xaf"

"\x84\x4e\x40\x04\x14\xf8\x5c\x28\xca\x1f\x88\x8e\x70\xc4\x5d\x28\xc8\x23"

"\xe0\x7e\xdd\xf3\x0d\xf7\x91\x1d\xf5\x84\xad\x45\x8a\x25\x35\x50\x84\x16"

"\x3a\x9a\x7c\xc3\xba\xc4\x27\x6e\x95\x72\x11\x62\x6e\x28\x82\x12\x00\x53"

"\x34\xde\xc7\x42\xcf\xe5\x7e\x6c\x82\x34\xe5\x20\xd8\xbe\xd4\x5a\xf4\x76"

"\x77\x0f\x47\x18\xf7\x99\xc1\xa1\xf6\x37\xfc\x04\xa7\x37\x80\xa3\x5d\x21"

"\x94\xe6\x01\x7e\x40\x5d\x3e\x0b\x1e\x9f\x2c\x7c\x0f\x6a\x0e\xd2\x8a\x2e"

"\xaf\xdd\x79\x22\x76\x20\x59\xfe\x0e\xbc\x77\x59\x92\x45\xb1\x2c\x9f\x0c"

"\xef\x9e\xda\xb1\xa2\x51\x71\xa6\xa9\xa0\x56\x2e\x24\xdb\x76\xe2\x5d\xfb"

"\x5e\xcb\x73\x52\xd0\xbf\xc7\x8d\x85\x8e\x8a\xaa\xc9\x13\xef\xa4\xff\x60"

"\x48\x96\x79\xe8\xc7\x20\x19\x89\x7a\x8a\x85\xa9\xee\x29\xf1\x09\x22\x31"

"\x5b\xa7\xdb\x0a\x12\x6f\x82\x7c\x03\xfa\x5b\xbb\x90\xf9\x91\xcb\x98\x66"

"\xb3\xe0\x30\x47\xcb\x1f\xab\xbb\xdb\xe5\xa3\x52\x82\xf0\x30\xc0\xdb\xdb"

"\xd2\x27\xf8\x5b\x05\x72\x1c\x45\xc8\xb2\xb8\x5d\x33\x10\xbb\x41\xd6\xaa"

"\x56\x14\xa6\x0d\x98\x74\xd1\x2f\x11\xf5\xa9\x4b\x15\xf7\x41\xdb\x31\x0c"

"\x92\x7b\x2e\x90\x60\x7a\x2a\xf8\xc4\xb5\x7d\x6b\x69\x37\xd5\xa1\xeb\x14"

"\x58\x9d\x1e\x36\x16\x42\x45\x8c\xc2\xfb\xd2\x96\xac\x03\x1d\x09\x9d\xf4"

"\x9a\x53\xe8\xf0\xd4\x50\x6b\x2d\xcb\xb2\x0f\x54\x56\x0b\x69\x5a\x4e\x0a"

"\x4a\x5a\x13\x23\x19\x85\xd5\x3b\xb3\x53\x31\x26\xad\xd2\x81\xfd\x38\xcd"

"\xdf\x7e\xf4\x37\x20\x1e\x8a\xea\x1a\xb6\x3a\xd6\x73\xcd\xcc\x6c\x60\x41"

"\x14\xae\xc7\x71\x88\x1b\x4f\xb7\xaa\x7c\xcb\xd3\x97\xe7\x03\xf1\x08\x95"

"\x61\x9e\x15\xc7\x16\x84\xbb\xbf\xa2\xb2\xc6\x0a\x79\x0d\xe0\xe5\x05\x95"

"\x38\xb5\x1d\x34\x7a\x68\xad\x05\x74\x72\xa9\xf1\xea\xf0\x54\xdf\x77\x91"

"\xb5\x8f\x63\x8c\x05\x95\x55\xbb\xb9\x70\xed\xf8\x77\xd5\xf6\x23\xe2\x54"

"\x1d\xba\x27\xdf\x8d\x71\x3f\xe7\xc5\x5f\x40\xfb\xf3\xdb\xdc\x3d\x04\x2e"

"\x92\xb8\x3f\x94\xdd\x66\xd1\xcd\x2b\xc5\xcc\x98\xa6\xa5\x02\xb5\xd8\xd8"

"\xee\x6e\xfe\xca\xcf\xb7\x62\x46\x4c\x6f\x8c\xea\x8b\xda\xd1\x4a\x29\x19"

"\x99\x28\xe0\xcb\x07\xfb\xc3\x06\xb9\xee\xcc\xc4\xc7\xa3\x26\x18\x52\x54"

"\x41\x48\x92\xb6\x14\xdd\xcc\x20\xe9\xb5\xd2\x58\xe6\x62\x71\x43\x0c\x07"

"\x05\xc5\xa6\x22\xfa\x56\x46\xda\x48\x97\xa0\x88\xf6\x8f\xde\xb6\x68\x42"

"\xad\x3d\x72\xf2\x32\xf4\x87\xb3\xdb\x3b\x83\xd8\x26\x22\xc9\x1d\xaf\x77"

"\x96\x34\xfa\x1b\x97\xc7\xd5\xad\xb5\xd5\x3b\xe5\x19\x8b\xc5\x9a\xef\x1a"

"\xab\x60\xc3\x79\x52\x96\xa8\x4a\xc3\xf7\x73\x99\xfe\xed\x5b\x86\xf4\x4b"

"\x3a\x1c\xa3\x5e\xe4\x68\x91\xee\x90\x3a\x90\x34\x08\x83\xce\xc4\x1d\x57"

"\x7a\x88\x80\x94\x5b\x50\x4c\x7e\xa5\xbd\xc9\x4d\x66\xbf\x25\xb4\xd2\xe0"

"\x64\xbd\x69\xdf\xce\x4f\x00\xf8\xdf\xad\xe0\x73\x9f\xab\x52\x75\xdb\x11"

"\xe9\x99\xb2\x56\x22\xc2\x0c\xa0\xa9\xf1\x0f\x27\xc8\x00\xa4\xf5\xd1\x9a"

"\xa9\x2d\x04\xcd\x28\x2f\x96\xe9\x90\x30\x18\x74\xc5\xdd\xcf\xb1\x32\x23"

"\xc4\xf5\xfd\x37\xc4\x49\xad\xde\x53\x2a\x16\xae\xe6\x64\x07\xbf\xee\xee"

"\xbd\xa4\xf5\x13\xf2\x24\xe4\x34\xa9\xc0\x8a\x22\x81\xd5\xe1\xf4\x59\x1c"

"\x9a\x43\x3a\xb1\x57\x6c\x11\xed\xd0\xdf\x9f\xb6\xf4\x7b\x76\x1f\xc8\x78"

"\xd5\x32\xd7\xfc\x2a\x76\x24\x61\xfd\x14\x73\xeb\x7c\x7c\x88\x66\x8b\x74"

"\x9b\x9b\xbf\x43\xc9\x37\xfa\x2b\xd7\x3a\xe9\x17\xea\x2a\x90\x3b\xf5\xf7"

"\xd7\x1a\xe1\xc7\xd7\x1c\x60\xde\xf1\xbb\xc4\xe8\x15\x1b\xee\x5f\x4a\x39"

"\x63\x25\x90\x7f\x4f\x2b\xcb\xe9\x80\x38\xe4\x6b\xc9\xfb\x30\xd1\x99\xf0"

"\x25\xea\xbe\xb0\x37\xce\xae\xc3\xee\x18\x7f\x73\xa1\x36\xb8\x56\x6a\x94"

"\x3d\x5b\x32\x71\x19\x9e\x6d\x19\xb7\x06\x6d\x90\xb1\x0d\x0c\x11\xe7\xcb"

"\x0c\x0b\x5f\x73\x12\x7c\xd6\x85\xa7\x63\x8b\x99\xa1\xc9\xae\xa4\xfb\xf3"

"\xfa\xc6\x7a\x4b\x11\x4c\xa9\xfa\x60\xd2\xc9\xc2\x47\x23\xb0\x37\x14\x2e"

"\x3e\x47\x50\x3f\x3d\xfd\xff\xc4\x87\x21\x20\x90\xd2\x21\xeb\x85\xf5\x3c"

"\xf6\x17\x6c\x26\xb9\x3c\x75\x7b\x52\x1d\x01\x7c\xa1\x7a\xc7\x88\x9c\x26"

"\xc6\x47\x3f\xb4\x4c\xc2\xab\x79\xcd\x76\xfb\xf8\xfc\x5a\x81\xdc\x24\xbd"

"\x7b\xa6\xd5\x5d\x80\x36\xf4\xd6\x02\x18\xe7\xc8\xfd\xf7\xf3\xb9\x15\xef"

"\xd0\xbd\x0e\xdf\xac\x38\x0e\x37\x17\x79\x4a\xb4\x6b\x2a\x5d\xae\xd5\x8f"

"\xdb\x3e\xa6\x67\x20\xc0\xe7\x8a\x0c\xe8\x25\xb1\x55\xeb\xc0\x97\x9c\xf7"

"\x79\x15\xdb\x3d\xf6\x00\xbb\xd1\x79\xf1\xd2\xd6\x74\xd7\x6b\x12\xaf\xf0"

"\x87\x75\x7d\x4a\xa4\x80\xee\x15\x66\x78\x40\x74\xa5\x28\x7b\xe0\x08\x8e"

"\xfb\xe1\x2f\x55\x0b\xad\x3b\x41\x0c\xf0\x4f\xba\x8f\x06\xd1\x12\x0a\x1d"

"\xad\x35\xde\x9c\x7a\x22\xc3\xca\xf8\x3c\x1b\xf6\xea\x57\xa0\x55\xaf\xcb"

"\xc6\x1b\x06\x8f\xeb\x5d\x17\xf5\xd0\xcd\x9e\x59\x11\xd2\xd9\xc8\xc6\xff"

"\x89\xfc\x37\x72\x5a\x4b\x9a\xc3\xa8\x80\x0d\x17\x31\x19\x9c\x82\x01\xc0"

"\x52\x2e\x9a\xf7\x49\xfe\x36\xe1\x41\x94\x31\x0a\x5a\xaf\xd9\x44\xc3\x21"

"\xef\xb4\xec\xf5\xc1\x31\xcc\xf9\xde\x48\xc8\xb3\x6a\x90\x5f\x47\xeb\xa8"

"\xfb\x42\xce\x43\x5d\x1b\xd4\x08\xdc\x87\xb1\xc9\x15\x77\xff\xba\x16\xe3"

"\x2b\x9b\xe2\x19\x82\xd3\x17\x63\x20\xc8\xe2\x37\x99\xb6\xc5\xcc\x3d\x83"

"\x4c\xcb\xe9\xac\xed\xa7\x0b\xd2\xc7\x3a\x15\x41\x37\xac\xdd\x65\xf4\x19"

"\x1e\x44\x70\x89\x3e\xb2\x4e\x4a\xb0\x07\x00\xc2\xc1\x35\x14\x9f\xb8\x66"

"\x44\xb5\xac\x0b\xe1\x66\x92\x88\xb9\xc2\x9a\x1f\x6f\x61\x51\x7d\x8b\x4f"
                "\x09\x61\x6e\x76\x7b\xd7\x2d\x13\xf8\x33",
                4096));
        syscall(__NR_lsetxattr, /*path=3D*/0x200001c0ul, /*name=3D*/0x20000=
2c0ul,
                        /*val=3D*/0x20002040ul, /*size=3D*/0x1009ul, /*flag=
s=3D*/3ul);
    }
    int main(void) {
        syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul,
                        /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
        syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
/*prot=3D*/7ul,
                        /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
        syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul,
                        /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
        install_segv_handler();
        for (procid =3D 0; procid < 4; procid++) {
            if (fork() =3D=3D 0) {
                loop();
            }
        }
        sleep(1000000);
        return 0;
    }


=3D* repro.txt =3D*
syz_mount_image$vfat(&(0x7f0000000040),
&(0x7f0000000200)=3D'./file0\x00', 0x220e002, 0x0, 0x1, 0x0,
&(0x7f0000000100))
mount(&(0x7f0000000040)=3DANY=3D[@ANYBLOB=3D'mtd', @ANYRESHEX=3D0x0],
&(0x7f00000000c0)=3D'./file0\x00', &(0x7f0000001200)=3D'jffs2\x00', 0x0,
0x0)
lsetxattr$security_evm(&(0x7f00000001c0)=3D'./file0\x00',
&(0x7f00000002c0), &(0x7f0000002040)=3D@v2=3D{0x3, 0x2, 0xb, 0x4, 0x1000,
"788d9cb299abd72ece913d53365e16688e51ace15984ab53d1666ae3f5dfbc860bef87389e=
21286be236ddc3d0fa2e51d5c5c7b35c5d503c5b2c3b6be0fc56e97df88faa0635363ba92b8=
2c47a817ac97f1d638a1461821255ec23bd0ce5bf1094e3a8980d7e6d1976ba778745920e17=
18fddac4bd66b0a606801aaefded293c3fcebad3b2c06403dba9994971659b7f4a077addaeb=
8ae3e5aca7027fde1e40001c0bdd800bcc287e02c867e2782deaf676a261647db8c2f394502=
2057de768100a8bf73d9f9ff29229b46dead58b2ddf96433468e9eee8950df658711e411364=
e44145e682f3c053c6f5a1861eee6edf885a97c545805ac0c35a5e4623b2001861c593354b5=
70ff3b4a45f1acde0a8dbd17c09ce448ed5dfd9e7472e68967decb769fa600cd30beb6c8030=
e9474c7ec4c1daf3e007bbc5765b366d4a176e38bdfabedd2b076a5ed7d50f5177b94a6a0f0=
00cd3acadde8e80f66eada14018620b159e9e14c252d20c8dbb0fe3605b5698b53e4210b62f=
cbd00017eaa01eb1fa521bdb8d30e83951b4ea0286c8f0d464517a11d7922d6cce4d2058ec8=
cd7b02b73d825d7e0abbbd85e991220fc7995534b7b1998ca752890b079a7ca3fde56438cf8=
2d5dd9edbd11fd293c17d1cf16657d0b352a8c6c36300ad09a78e3ee3913b9b6f53debffc7e=
32bfb64b0e8cbe07fe9b0dadb097aeb2c242430bec75630a3921828a7314de1404829e7afb3=
b8420e85f2c8f6e88de042314416e5c00c59b22208004bec161f8457c7f8e3a8ca4174a4b78=
df6e460d56d24e01ae1a2411270f79d020a6bac855f1a3ef7b3d0991882656b408dcdaf02db=
46ac8fcab0c875d1f2e8db366e6a20cb67a4db920382a6915715d3b4266f779fe8633bea6de=
f28cc159138b834334cedef3dec54ea5303df56be87115315ec0f1478a0c0869e5f7c33da64=
b23af5811751055c90849484481d5a10d72e08ccd12710c4f2ff586a9ea175f4aa70b156c00=
c57e22c1360bfc7d36aa4792444f81d8a0ed41bf6a452ea5268b8605682ac63eaa465218f4d=
962db42154d01966d3ad8fc2fde48ef71be08be58e5ad6d5a3593efc9c1336e541372a34799=
d24ea00d4d4985bed1dab10620911e9f6967880826be5a1f1bb4b2a3948654c6935cafeb492=
5e107a01f9dda668e5fd7489e82139241a9190f090afe2094234c75fec074622748d4dd782a=
930f42b0e75d924bef68ffafbaa98916151a36ef2998afd3000955efbfa0a9a008358c11043=
c0f96b52fc78a42531aa5dfd8de09518cff008b339259b266c488bb1da058ba218cd64b3e41=
3ca2889d1086e8c40ae11501984121dcfa2fde09d068f6dbbe8359980dad96ed220b8534aae=
f353dfc81560907d26c02442924ad55b11d3aee7e5516d96ad078c85ad1cdb18a45474305a8=
db350f9844380e2094f691a05ea09458bc53f3236a1f3fa5e144a575ba57e58d00f7653d2e6=
b6cbe18d28ce3f5792538ad20c0e0e10b03dac34009d6d3e4c7662cca88b53066e95efe45ee=
3e04da328690dae1aa0070f0945e269b75733b106ff6514555d54d958f7313441fa21f97615=
312c4f600a1430f629812f23cd21e703b966e04aa6d0bba6f2539369a3badebfaa8197d89e3=
294b44c0ea54ae6b7f4a496568043175a5666541b559a9feaf0c5454f12f230e97bcf84dae1=
1d1a8359411b98bb6063ee8ae0ffa30b5757771c7b70e4fbb6e951a680873e6da531600e951=
110c34caacc8e978c06b4848c880c48ad8e6c54bc792ce54ea4b1c05ab04afb4d6cab25b85d=
1c4b6c474c7ec9267b501edaa20ee0e415868d87866426b1374e58a666530b94e342c8b2ebd=
d405fef0a26df82bbc502da2ca1550c28d3c0b69872ff861cd23cb6e1ff1e62f625ae92f90f=
30933fc827edd386121315352dbc9f4cab3dddadeb8df051d2f59cd59e97dc92ce4341f9780=
03e48685e7673cf1e60260600e7cbf731dc168b9a411dc3c85f843bd2c5fca89c06d12bac08=
a61cf099ae5f23e5e908448e81f2779b385b31dcd5cf8aaad4b85ae7063624a7df573aeccc8=
b61977f8ec10e68b5df1c1b805c7e001228a65c0e772c5251466a49f10219bb718a4aa2e35c=
40811a972eb58530f7f0741d3be0c00e38f58994a5199547fc5150c781ffe2e56560f08eb75=
bfcd9085ff140ceefd0d6ed43dad39d2cda8694d420e861a1dec4a28d1cf5324c5c5ab81922=
154873b3f82df1bc06cb9565c08f774d9fa6fe575daf87b328ab10b912243f100712a27f498=
1faa372d736702c565a08c4d6b0aa312d3c9017fd1e7ab981de7ee1dfc1a849924aa92eab1b=
3e6e9742f6913a08b5699d670697a608d749e06c341421a809a365dca3f8d88d842685080f8=
ed93482888065b50bf9abde75fe37c8ff2ae4f24e26f83949ab5c4f4a96e13b2cdf742daf9c=
1b58305691456c6c190bfb7bbbb084ea9f97e99c3e028415d4e05ccf7717b5797ff5bafa251=
8a0acab434a188d4797a85f36557dd6aa39c75e80b72496372652544b1424901a6a9d4b7453=
086b6ba26a40521da94ab54de4a11b51b4ad7ab1d6805f323b044955f779cfe7c1c3586f4be=
0eab226a25ae16bd8dc7eb015024b7434b6408343a1be6e1dd3925c102b4c9c543983835b6b=
b45f80ea35bf7fcecab5d947224bfdb1c03b20fc07a5cac630beb4b3044ebe55c9023844c1f=
d64b4eb025536867f0afa388576c5b2564cd2e20ae2633f7b76cf6fbceff240f65e5eeba284=
3faa1e77108d35c59b3f570112660e9278da3127686dc2a965a6ad1672e29ff9edd62f49e41=
bdd65348d2657846be80479cea415bfb5927229f3b772ed9c9b7639d8f75ff6621841a7b649=
78131e86952bfe510715b25efbcf393320c1d6299ac6c19dd908870f96d92b8bdcf11e3c987=
8f2e37bdaf72718ad0bc2872c7a0b101f6e392997234e06c9b1bdc324971427d6b97c3c1653=
1178f40a8ab52f98e066780977abd352e1efe6185f70233b30fdc96b6a289b9e0fcee555923=
ef590bd9cd2f0ef7024641450d1a9258046ac0e80acd44f267446946c096db9848f78cddba9=
f5409b090dd2344d8d45a16cd2ecce5bf22bd4cb89afd3067cb0bd9a7279be1b1e503498f39=
edce714f37597d0e6460716d09ea376d73e8a71fff1324fa2aeba75e8bbd0ea4c418b457845=
50153d492898e15da88b6ed3f67e85dbb111c2feac2fd78b6f9011c6864b9bb11653694f7f0=
2568b768b6a27d080eadc0093744b9115aa2f8d03fa27faea2e356ef8ce62e4722ddd139f78=
4ac3b8afb98c8d3984c8cf9438e83710330428b7830c1709a309bbac3bbdbd083e539938c57=
89e1709d2c0ee94dcb2fe64c31c87d25cc7f826bbf5e021d5aaa172970aae96a6858f8c11fd=
fb748328d97411edc10dd16fd10faa7c3b94ce19152fb2965690421d3c6db2e7e8888c7bb06=
443db3111e3db69a88dd097ab8c64d6bea30da247fcd117a30eef45cd9339a78375628cdbfa=
26d6b3419e69bbe8e88479129684b2304daa2d684304826eee97d346303cc631e10465a2f92=
43e84d322810388ba2d30626a63df9793eb963df234865cbb68cdbc04363e17a6a6eb1c8014=
177c99faacb8d7a8e99d897718bc51055727820d321f25fd15d24d029d4fad6fde97f091180=
ef2bc3913bc11f8f104bcc7ea0024157481b3537ce543fe8ab93a26cb9ba51fa78d337bf10b=
a29dc5febfe4ad014bd40f33330823d7f4573baebd9e063d59a87662bef859cee8a8e5318aa=
e22e79fb4d31e088f0569c67bba41868fe464ed77ec7fe07dd3a5c2c81c1fded160598b3756=
4513173f13feeb9df4b47ede8050aac431e1b2058c6afe7e44bcc6f28dc5833dded10e6917e=
15b93088cd90791826ca7c3b9a4211e9e2ffd4966223816db6e4ede5701b76988d8f34aa140=
ffb4bc3effccbe5af3942d4c5717700e592a17001d20b665fb7c6f65361108a1370a45db477=
a1f449e5c3f9a89f967290af231db82fedecfca2c3cedffeadb775728b45ce4bde0630e9e1d=
fcd98138a556dd40b655581b451a7164ad57c4fb2b5dc5b145e8733de33af844e400414f85c=
28ca1f888e70c45d28c823e07eddf30df7911df584ad458a25355084163a9a7cc3bac4276e9=
57211626e288212005334dec742cfe57e6c8234e520d8bed45af476770f4718f799c1a1f637=
fc04a73780a35d2194e6017e405d3e0b1e9f2c7c0f6a0ed28a2eafdd7922762059fe0ebc775=
99245b12c9f0cef9edab1a25171a6a9a0562e24db76e25dfb5ecb7352d0bfc78d858e8aaac9=
13efa4ff60489679e8c72019897a8a85a9ee29f10922315ba7db0a126f827c03fa5bbb90f99=
1cb9866b3e03047cb1fabbbdbe5a35282f030c0dbdbd227f85b05721c45c8b2b85d3310bb41=
d6aa5614a60d9874d12f11f5a94b15f741db310c927b2e90607a2af8c4b57d6b6937d5a1eb1=
4589d1e361642458cc2fbd296ac031d099df49a53e8f0d4506b2dcbb20f54560b695a4e0a4a=
5a13231985d53bb3533126add281fd38cddf7ef437201e8aea1ab63ad673cdcc6c604114aec=
771881b4fb7aa7ccbd397e703f10895619e15c71684bbbfa2b2c60a790de0e5059538b51d34=
7a68ad057472a9f1eaf054df7791b58f638c059555bbb970edf877d5f623e2541dba27df8d7=
13fe7c55f40fbf3dbdc3d042e92b83f94dd66d1cd2bc5cc98a6a502b5d8d8ee6efecacfb762=
464c6f8cea8bdad14a29199928e0cb07fbc306b9eeccc4c7a326185254414892b614ddcc20e=
9b5d258e66271430c0705c5a622fa5646da4897a088f68fdeb66842ad3d72f232f487b3db3b=
83d82622c91daf779634fa1b97c7d5adb5d53be5198bc59aef1aab60c3795296a84ac3f7739=
9feed5b86f44b3a1ca35ee46891ee903a90340883cec41d577a8880945b504c7ea5bdc94d66=
bf25b4d2e064bd69dfce4f00f8dfade0739fab5275db11e999b25622c20ca0a9f10f27c800a=
4f5d19aa92d04cd282f96e990301874c5ddcfb13223c4f5fd37c449adde532a16aee66407bf=
eeeebda4f513f224e434a9c08a2281d5e1f4591c9a433ab1576c11edd0df9fb6f47b761fc87=
8d532d7fc2a762461fd1473eb7c7c88668b749b9bbf43c937fa2bd73ae917ea2a903bf5f7d7=
1ae1c7d71c60def1bbc4e8151bee5f4a396325907f4f2bcbe98038e46bc9fb30d199f025eab=
eb037ceaec3ee187f73a136b8566a943d5b3271199e6d19b7066d90b10d0c11e7cb0c0b5f73=
127cd685a7638b99a1c9aea4fbf3fac67a4b114ca9fa60d2c9c24723b037142e3e47503f3df=
dffc487212090d221eb85f53cf6176c26b93c757b521d017ca17ac7889c26c6473fb44cc2ab=
79cd76fbf8fc5a81dc24bd7ba6d55d8036f4d60218e7c8fdf7f3b915efd0bd0edfac380e371=
7794ab46b2a5daed58fdb3ea66720c0e78a0ce825b155ebc0979cf77915db3df600bbd179f1=
d2d674d76b12aff087757d4aa480ee1566784074a5287be0088efbe12f550bad3b410cf04fb=
a8f06d1120a1dad35de9c7a22c3caf83c1bf6ea57a055afcbc61b068feb5d17f5d0cd9e5911=
d2d9c8c6ff89fc37725a4b9ac3a8800d1731199c8201c0522e9af749fe36e14194310a5aafd=
944c321efb4ecf5c131ccf9de48c8b36a905f47eba8fb42ce435d1bd408dc87b1c91577ffba=
16e32b9be21982d3176320c8e23799b6c5cc3d834ccbe9aceda70bd2c73a154137acdd65f41=
91e4470893eb24e4ab00700c2c135149fb86644b5ac0be1669288b9c29a1f6f61517d8b4f09=
616e767bd72d13f833"},
0x1009, 0x3)

and see also in
https://gist.github.com/xrivendell7/fdc7fa3a7b55a9174666944c07732eec

I hope it helps.
Best regards


lee bruce <xrivendell7@gmail.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=89 20:48=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello, I reproduced this bug and comfired in the latest upstream.
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
>
> I use the same kernel as syzbot instance: https://syzkaller.appspot.com/b=
ug?extid=3D5a281fe8aadf8f11230d
> Kernel Commit: upstream fe46a7dd189e25604716c03576d05ac8a5209743
> Kernel Config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
4d90a36f0cab495a with KASAN enabled
>
> root@syzkaller:~# ./0
> [  406.727577][ T8177] ------------[ cut here ]------------
> [  406.728272][ T8177] kernel BUG at fs/jffs2/summary.c:865!
> [  406.729014][ T8177] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [  406.729850][ T8177] CPU: 2 PID: 8177 Comm: 0 Not tainted 6.8.0-08951-g=
fe46a7dd189e-dirty #6
> [  406.730904][ T8177] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  406.732206][ T8177] RIP: 0010:jffs2_sum_write_sumnode+0x1f50/0x2630
> [  406.733061][ T8177] Code: 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 81 01 00=
 00 8b b3 c0 05 00 00 48 c7 c2 c0 7e a4 8b 48 c7 c7 c0 7a a4 8b e8 51 ba 82=
 fe 90 <0f> 0b e8 69 29 01 ff e9 70 e19
> [  406.735472][ T8177] RSP: 0018:ffffc9000396f4e0 EFLAGS: 00010286
> [  406.736416][ T8177] RAX: 0000000000000045 RBX: ffff888022a20040 RCX: f=
fff888022a20040
> [  406.737446][ T8177] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000000000000
> [  406.738435][ T8177] RBP: ffffc9000396f660 R08: 0000000000000005 R09: 0=
000000000000000
> [  406.739470][ T8177] R10: 0000000080000000 R11: 0000000000000001 R12: 0=
000000000000000
> [  406.740463][ T8177] R13: 0000000000000000 R14: ffff888028bb1000 R15: 0=
00000000000106c
> [  406.741459][ T8177] FS:  0000000007a66480(0000) GS:ffff8880b9300000(00=
00) knlGS:0000000000000000
> [  406.742581][ T8177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  406.743418][ T8177] CR2: 0000000020003029 CR3: 000000002be68000 CR4: 0=
000000000750ef0
> [  406.744407][ T8177] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [  406.745398][ T8177] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [  406.746373][ T8177] PKRU: 55555554
> [  406.746833][ T8177] Call Trace:
> [  406.747271][ T8177]  <TASK>
> [  406.747651][ T8177]  ? show_regs+0x97/0xa0
> [  406.748215][ T8177]  ? die+0x3b/0xb0
> [  406.748701][ T8177]  ? do_trap+0x245/0x440
> [  406.749262][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
> [  406.750005][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
> [  406.750711][ T8177]  ? do_error_trap+0xff/0x250
> [  406.751342][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
> [  406.752094][ T8177]  ? handle_invalid_op+0x39/0x40
> [  406.752740][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
> [  406.753479][ T8177]  ? exc_invalid_op+0x2e/0x50
> [  406.754090][ T8177]  ? asm_exc_invalid_op+0x1a/0x20
> [  406.754716][ T8177]  ? jffs2_sum_write_sumnode+0x1f50/0x2630
> [  406.755477][ T8177]  ? __pfx_jffs2_sum_write_sumnode+0x10/0x10
> [  406.756234][ T8177]  ? rcu_is_watching+0x12/0xc0
> [  406.756861][ T8177]  ? lock_acquire+0x1b1/0x540
> [  406.757489][ T8177]  ? __pfx_lock_acquire+0x10/0x10
> [  406.758117][ T8177]  ? __pfx___mutex_lock+0x10/0x10
> [  406.758769][ T8177]  ? jffs2_do_reserve_space+0xc59/0x1190
> [  406.759502][ T8177]  jffs2_do_reserve_space+0xc59/0x1190
> [  406.760223][ T8177]  jffs2_reserve_space+0x67e/0xc20
> [  406.760883][ T8177]  ? avc_has_perm_noaudit+0x152/0x3d0
> [  406.761584][ T8177]  ? __pfx_jffs2_reserve_space+0x10/0x10
> [  406.762302][ T8177]  ? avc_has_perm_noaudit+0x152/0x3d0
> [  406.763030][ T8177]  ? cred_has_capability.isra.0+0x19d/0x310
> [  406.763788][ T8177]  ? __pfx_jffs2_security_setxattr+0x10/0x10
> [  406.764567][ T8177]  do_jffs2_setxattr+0x1ab/0x1770
> [  406.765224][ T8177]  ? cap_capable+0x1e4/0x250
> [  406.765783][ T8177]  ? __pfx_do_jffs2_setxattr+0x10/0x10
> [  406.766514][ T8177]  ? xattr_resolve_name+0x292/0x440
> [  406.767220][ T8177]  ? __pfx_jffs2_security_setxattr+0x10/0x10
> [  406.768026][ T8177]  __vfs_setxattr+0x182/0x1f0
> [  406.768646][ T8177]  ? __pfx_evm_protect_xattr.isra.0+0x10/0x10
> [  406.769411][ T8177]  ? __pfx___vfs_setxattr+0x10/0x10
> [  406.770067][ T8177]  __vfs_setxattr_noperm+0x132/0x610
> [  406.770752][ T8177]  __vfs_setxattr_locked+0x195/0x270
> [  406.771452][ T8177]  vfs_setxattr+0x151/0x370
> [  406.772052][ T8177]  ? __pfx_vfs_setxattr+0x10/0x10
> [  406.772704][ T8177]  ? __might_fault+0xee/0x1a0
> [  406.773326][ T8177]  do_setxattr+0x153/0x180
> [  406.773881][ T8177]  setxattr+0x166/0x180
> [  406.774421][ T8177]  ? __pfx_setxattr+0x10/0x10
> [  406.775043][ T8177]  ? mnt_get_write_access+0x21d/0x320
> [  406.775743][ T8177]  path_setxattr+0x188/0x1f0
> [  406.776338][ T8177]  ? __pfx_path_setxattr+0x10/0x10
> [  406.776986][ T8177]  ? handle_mm_fault+0x541/0xab0
> [  406.777648][ T8177]  __x64_sys_lsetxattr+0xc6/0x160
> [  406.778281][ T8177]  ? do_syscall_64+0x91/0x260
> [  406.778927][ T8177]  ? lockdep_hardirqs_on+0x7c/0x110
> [  406.779598][ T8177]  do_syscall_64+0xd2/0x260
> [  406.780194][ T8177]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> [  406.780944][ T8177] RIP: 0033:0x437d49
> [  406.781454][ T8177] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00=
 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08=
 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 488
> [  406.783841][ T8177] RSP: 002b:00007fff7cd51d28 EFLAGS: 00000246 ORIG_R=
AX: 00000000000000bd
> [  406.784889][ T8177] RAX: ffffffffffffffda RBX: 0000000020002047 RCX: 0=
000000000437d49
> [  406.785900][ T8177] RDX: 0000000020002040 RSI: 00000000200002c0 RDI: 0=
0000000200001c0
> [  406.786886][ T8177] RBP: 00007fff7cd51d80 R08: 0000000000000003 R09: 0=
00000017cd51d40
> [  406.787878][ T8177] R10: 0000000000001009 R11: 0000000000000246 R12: 0=
000000000000001
> [  406.788872][ T8177] R13: 00007fff7cd51f88 R14: 0000000000000001 R15: 0=
000000000000001
> [  406.789879][ T8177]  </TASK>
>
>
> =3D* repro.c =3D*
>     #define _GNU_SOURCE
>
>     #include <dirent.h>
>     #include <endian.h>
>     #include <errno.h>
>     #include <fcntl.h>
>     #include <setjmp.h>
>     #include <signal.h>
>     #include <stdarg.h>
>     #include <stdbool.h>
>     #include <stddef.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <string.h>
>     #include <sys/ioctl.h>
>     #include <sys/mman.h>
>     #include <sys/mount.h>
>     #include <sys/prctl.h>
>     #include <sys/stat.h>
>     #include <sys/syscall.h>
>     #include <sys/types.h>
>     #include <sys/wait.h>
>     #include <time.h>
>     #include <unistd.h>
>
>     #include <linux/loop.h>
>
>     #ifndef __NR_memfd_create
>     #define __NR_memfd_create 319
>     #endif
>
>     static unsigned long long procid;
>
>     static __thread int clone_ongoing;
>     static __thread int skip_segv;
>     static __thread jmp_buf segv_env;
>
>     static void segv_handler(int sig, siginfo_t* info, void* ctx) {
>         if (__atomic_load_n(&clone_ongoing, __ATOMIC_RELAXED) !=3D 0) {
>             exit(sig);
>         }
>         uintptr_t addr =3D (uintptr_t)info->si_addr;
>         const uintptr_t prog_start =3D 1 << 20;
>         const uintptr_t prog_end =3D 100 << 20;
>         int skip =3D __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) !=3D 0=
;
>         int valid =3D addr < prog_start || addr > prog_end;
>         if (skip && valid) {
>             _longjmp(segv_env, 1);
>         }
>         exit(sig);
>     }
>
>     static void install_segv_handler(void) {
>         struct sigaction sa;
>         memset(&sa, 0, sizeof(sa));
>         sa.sa_handler =3D SIG_IGN;
>         syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
>         syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
>         memset(&sa, 0, sizeof(sa));
>         sa.sa_sigaction =3D segv_handler;
>         sa.sa_flags =3D SA_NODEFER | SA_SIGINFO;
>         sigaction(SIGSEGV, &sa, NULL);
>         sigaction(SIGBUS, &sa, NULL);
>     }
>
>     #define NONFAILING(...)                                  \
>         ({                                                     \
>             int ok =3D 1;                                          \
>             __atomic_fetch_add(&skip_segv, 1, __ATOMIC_SEQ_CST); \
>             if (_setjmp(segv_env) =3D=3D 0) {                        \
>                 __VA_ARGS__;                                       \
>             } else                                               \
>                 ok =3D 0;                                            \
>             __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST); \
>             ok;                                                  \
>         })
>
>     static void sleep_ms(uint64_t ms) {
>         usleep(ms * 1000);
>     }
>
>     static uint64_t current_time_ms(void) {
>         struct timespec ts;
>         if (clock_gettime(CLOCK_MONOTONIC, &ts))
>             exit(1);
>         return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 100000=
0;
>     }
>
>     static bool write_file(const char* file, const char* what, ...) {
>         char buf[1024];
>         va_list args;
>         va_start(args, what);
>         vsnprintf(buf, sizeof(buf), what, args);
>         va_end(args);
>         buf[sizeof(buf) - 1] =3D 0;
>         int len =3D strlen(buf);
>         int fd =3D open(file, O_WRONLY | O_CLOEXEC);
>         if (fd =3D=3D -1)
>             return false;
>         if (write(fd, buf, len) !=3D len) {
>             int err =3D errno;
>             close(fd);
>             errno =3D err;
>             return false;
>         }
>         close(fd);
>         return true;
>     }
>
>     //% This code is derived from puff.{c,h}, found in the zlib developme=
nt. The
>     //% original files come with the following copyright notice:
>
>     //% Copyright (C) 2002-2013 Mark Adler, all rights reserved
>     //% version 2.3, 21 Jan 2013
>     //% This software is provided 'as-is', without any express or implied
>     //% warranty.  In no event will the author be held liable for any dam=
ages
>     //% arising from the use of this software.
>     //% Permission is granted to anyone to use this software for any purp=
ose,
>     //% including commercial applications, and to alter it and redistribu=
te it
>     //% freely, subject to the following restrictions:
>     //% 1. The origin of this software must not be misrepresented; you mu=
st not
>     //%    claim that you wrote the original software. If you use this so=
ftware
>     //%    in a product, an acknowledgment in the product documentation w=
ould be
>     //%    appreciated but is not required.
>     //% 2. Altered source versions must be plainly marked as such, and mu=
st not be
>     //%    misrepresented as being the original software.
>     //% 3. This notice may not be removed or altered from any source dist=
ribution.
>     //% Mark Adler    madler@alumni.caltech.edu
>
>     //% BEGIN CODE DERIVED FROM puff.{c,h}
>
>     #define MAXBITS 15
>     #define MAXLCODES 286
>     #define MAXDCODES 30
>     #define MAXCODES (MAXLCODES + MAXDCODES)
>     #define FIXLCODES 288
>
>     struct puff_state {
>         unsigned char* out;
>         unsigned long outlen;
>         unsigned long outcnt;
>         const unsigned char* in;
>         unsigned long inlen;
>         unsigned long incnt;
>         int bitbuf;
>         int bitcnt;
>         jmp_buf env;
>     };
>     static int puff_bits(struct puff_state* s, int need) {
>         long val =3D s->bitbuf;
>         while (s->bitcnt < need) {
>             if (s->incnt =3D=3D s->inlen)
>                 longjmp(s->env, 1);
>             val |=3D (long)(s->in[s->incnt++]) << s->bitcnt;
>             s->bitcnt +=3D 8;
>         }
>         s->bitbuf =3D (int)(val >> need);
>         s->bitcnt -=3D need;
>         return (int)(val & ((1L << need) - 1));
>     }
>     static int puff_stored(struct puff_state* s) {
>         s->bitbuf =3D 0;
>         s->bitcnt =3D 0;
>         if (s->incnt + 4 > s->inlen)
>             return 2;
>         unsigned len =3D s->in[s->incnt++];
>         len |=3D s->in[s->incnt++] << 8;
>         if (s->in[s->incnt++] !=3D (~len & 0xff) ||
>                 s->in[s->incnt++] !=3D ((~len >> 8) & 0xff))
>             return -2;
>         if (s->incnt + len > s->inlen)
>             return 2;
>         if (s->outcnt + len > s->outlen)
>             return 1;
>         for (; len--; s->outcnt++, s->incnt++) {
>             if (s->in[s->incnt])
>                 s->out[s->outcnt] =3D s->in[s->incnt];
>         }
>         return 0;
>     }
>     struct puff_huffman {
>         short* count;
>         short* symbol;
>     };
>     static int puff_decode(struct puff_state* s, const struct puff_huffma=
n* h) {
>         int first =3D 0;
>         int index =3D 0;
>         int bitbuf =3D s->bitbuf;
>         int left =3D s->bitcnt;
>         int code =3D first =3D index =3D 0;
>         int len =3D 1;
>         short* next =3D h->count + 1;
>         while (1) {
>             while (left--) {
>                 code |=3D bitbuf & 1;
>                 bitbuf >>=3D 1;
>                 int count =3D *next++;
>                 if (code - count < first) {
>                     s->bitbuf =3D bitbuf;
>                     s->bitcnt =3D (s->bitcnt - len) & 7;
>                     return h->symbol[index + (code - first)];
>                 }
>                 index +=3D count;
>                 first +=3D count;
>                 first <<=3D 1;
>                 code <<=3D 1;
>                 len++;
>             }
>             left =3D (MAXBITS + 1) - len;
>             if (left =3D=3D 0)
>                 break;
>             if (s->incnt =3D=3D s->inlen)
>                 longjmp(s->env, 1);
>             bitbuf =3D s->in[s->incnt++];
>             if (left > 8)
>                 left =3D 8;
>         }
>         return -10;
>     }
>     static int puff_construct(struct puff_huffman* h, const short* length=
, int n) {
>         int len;
>         for (len =3D 0; len <=3D MAXBITS; len++)
>             h->count[len] =3D 0;
>         int symbol;
>         for (symbol =3D 0; symbol < n; symbol++)
>             (h->count[length[symbol]])++;
>         if (h->count[0] =3D=3D n)
>             return 0;
>         int left =3D 1;
>         for (len =3D 1; len <=3D MAXBITS; len++) {
>             left <<=3D 1;
>             left -=3D h->count[len];
>             if (left < 0)
>                 return left;
>         }
>         short offs[MAXBITS + 1];
>         offs[1] =3D 0;
>         for (len =3D 1; len < MAXBITS; len++)
>             offs[len + 1] =3D offs[len] + h->count[len];
>         for (symbol =3D 0; symbol < n; symbol++)
>             if (length[symbol] !=3D 0)
>                 h->symbol[offs[length[symbol]]++] =3D symbol;
>         return left;
>     }
>     static int puff_codes(struct puff_state* s,
>                                                 const struct puff_huffman=
* lencode,
>                                                 const struct puff_huffman=
* distcode) {
>         static const short lens[29] =3D {3,  4,  5,  6,   7,   8,   9,   =
10,  11, 13,
>                                                                      15, =
17, 19, 23,  27,  31,  35,  43,  51, 59,
>                                                                      67, =
83, 99, 115, 131, 163, 195, 227, 258};
>         static const short lext[29] =3D {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,=
 1, 2, 2, 2,
>                                                                      2, 3=
, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
>         static const short dists[30] =3D {
>                 1,    2,    3,    4,    5,    7,    9,    13,    17,    2=
5,
>                 33,   49,   65,   97,   129,  193,  257,  385,   513,   7=
69,
>                 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 2=
4577};
>         static const short dext[30] =3D {0, 0, 0,  0,  1,  1,  2,  2,  3,=
  3,
>                                                                      4, 4=
, 5,  5,  6,  6,  7,  7,  8,  8,
>                                                                      9, 9=
, 10, 10, 11, 11, 12, 12, 13, 13};
>         int symbol;
>         do {
>             symbol =3D puff_decode(s, lencode);
>             if (symbol < 0)
>                 return symbol;
>             if (symbol < 256) {
>                 if (s->outcnt =3D=3D s->outlen)
>                     return 1;
>                 if (symbol)
>                     s->out[s->outcnt] =3D symbol;
>                 s->outcnt++;
>             } else if (symbol > 256) {
>                 symbol -=3D 257;
>                 if (symbol >=3D 29)
>                     return -10;
>                 int len =3D lens[symbol] + puff_bits(s, lext[symbol]);
>                 symbol =3D puff_decode(s, distcode);
>                 if (symbol < 0)
>                     return symbol;
>                 unsigned dist =3D dists[symbol] + puff_bits(s, dext[symbo=
l]);
>                 if (dist > s->outcnt)
>                     return -11;
>                 if (s->outcnt + len > s->outlen)
>                     return 1;
>                 while (len--) {
>                     if (dist <=3D s->outcnt && s->out[s->outcnt - dist])
>                         s->out[s->outcnt] =3D s->out[s->outcnt - dist];
>                     s->outcnt++;
>                 }
>             }
>         } while (symbol !=3D 256);
>         return 0;
>     }
>     static int puff_fixed(struct puff_state* s) {
>         static int virgin =3D 1;
>         static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
>         static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
>         static struct puff_huffman lencode, distcode;
>         if (virgin) {
>             lencode.count =3D lencnt;
>             lencode.symbol =3D lensym;
>             distcode.count =3D distcnt;
>             distcode.symbol =3D distsym;
>             short lengths[FIXLCODES];
>             int symbol;
>             for (symbol =3D 0; symbol < 144; symbol++)
>                 lengths[symbol] =3D 8;
>             for (; symbol < 256; symbol++)
>                 lengths[symbol] =3D 9;
>             for (; symbol < 280; symbol++)
>                 lengths[symbol] =3D 7;
>             for (; symbol < FIXLCODES; symbol++)
>                 lengths[symbol] =3D 8;
>             puff_construct(&lencode, lengths, FIXLCODES);
>             for (symbol =3D 0; symbol < MAXDCODES; symbol++)
>                 lengths[symbol] =3D 5;
>             puff_construct(&distcode, lengths, MAXDCODES);
>             virgin =3D 0;
>         }
>         return puff_codes(s, &lencode, &distcode);
>     }
>     static int puff_dynamic(struct puff_state* s) {
>         static const short order[19] =3D {16, 17, 18, 0, 8,  7, 9,  6, 10=
, 5,
>                                                                         1=
1, 4,  12, 3, 13, 2, 14, 1, 15};
>         int nlen =3D puff_bits(s, 5) + 257;
>         int ndist =3D puff_bits(s, 5) + 1;
>         int ncode =3D puff_bits(s, 4) + 4;
>         if (nlen > MAXLCODES || ndist > MAXDCODES)
>             return -3;
>         short lengths[MAXCODES];
>         int index;
>         for (index =3D 0; index < ncode; index++)
>             lengths[order[index]] =3D puff_bits(s, 3);
>         for (; index < 19; index++)
>             lengths[order[index]] =3D 0;
>         short lencnt[MAXBITS + 1], lensym[MAXLCODES];
>         struct puff_huffman lencode =3D {lencnt, lensym};
>         int err =3D puff_construct(&lencode, lengths, 19);
>         if (err !=3D 0)
>             return -4;
>         index =3D 0;
>         while (index < nlen + ndist) {
>             int symbol;
>             int len;
>             symbol =3D puff_decode(s, &lencode);
>             if (symbol < 0)
>                 return symbol;
>             if (symbol < 16)
>                 lengths[index++] =3D symbol;
>             else {
>                 len =3D 0;
>                 if (symbol =3D=3D 16) {
>                     if (index =3D=3D 0)
>                         return -5;
>                     len =3D lengths[index - 1];
>                     symbol =3D 3 + puff_bits(s, 2);
>                 } else if (symbol =3D=3D 17)
>                     symbol =3D 3 + puff_bits(s, 3);
>                 else
>                     symbol =3D 11 + puff_bits(s, 7);
>                 if (index + symbol > nlen + ndist)
>                     return -6;
>                 while (symbol--)
>                     lengths[index++] =3D len;
>             }
>         }
>         if (lengths[256] =3D=3D 0)
>             return -9;
>         err =3D puff_construct(&lencode, lengths, nlen);
>         if (err && (err < 0 || nlen !=3D lencode.count[0] + lencode.count=
[1]))
>             return -7;
>         short distcnt[MAXBITS + 1], distsym[MAXDCODES];
>         struct puff_huffman distcode =3D {distcnt, distsym};
>         err =3D puff_construct(&distcode, lengths + nlen, ndist);
>         if (err && (err < 0 || ndist !=3D distcode.count[0] + distcode.co=
unt[1]))
>             return -8;
>         return puff_codes(s, &lencode, &distcode);
>     }
>     static int puff(unsigned char* dest,
>                                     unsigned long* destlen,
>                                     const unsigned char* source,
>                                     unsigned long sourcelen) {
>         struct puff_state s =3D {
>                 .out =3D dest,
>                 .outlen =3D *destlen,
>                 .outcnt =3D 0,
>                 .in =3D source,
>                 .inlen =3D sourcelen,
>                 .incnt =3D 0,
>                 .bitbuf =3D 0,
>                 .bitcnt =3D 0,
>         };
>         int err;
>         if (setjmp(s.env) !=3D 0)
>             err =3D 2;
>         else {
>             int last;
>             do {
>                 last =3D puff_bits(&s, 1);
>                 int type =3D puff_bits(&s, 2);
>                 err =3D type =3D=3D 0 ? puff_stored(&s)
>                                                 : (type =3D=3D 1 ? puff_f=
ixed(&s)
>                                                                          =
: (type =3D=3D 2 ? puff_dynamic(&s) : -1));
>                 if (err !=3D 0)
>                     break;
>             } while (!last);
>         }
>         *destlen =3D s.outcnt;
>         return err;
>     }
>
>     //% END CODE DERIVED FROM puff.{c,h}
>
>     #define ZLIB_HEADER_WIDTH 2
>
>     static int puff_zlib_to_file(const unsigned char* source,
>                                                              unsigned lon=
g sourcelen,
>                                                              int dest_fd)=
 {
>         if (sourcelen < ZLIB_HEADER_WIDTH)
>             return 0;
>         source +=3D ZLIB_HEADER_WIDTH;
>         sourcelen -=3D ZLIB_HEADER_WIDTH;
>         const unsigned long max_destlen =3D 132 << 20;
>         void* ret =3D mmap(0, max_destlen, PROT_WRITE | PROT_READ,
>                                          MAP_PRIVATE | MAP_ANON, -1, 0);
>         if (ret =3D=3D MAP_FAILED)
>             return -1;
>         unsigned char* dest =3D (unsigned char*)ret;
>         unsigned long destlen =3D max_destlen;
>         int err =3D puff(dest, &destlen, source, sourcelen);
>         if (err) {
>             munmap(dest, max_destlen);
>             errno =3D -err;
>             return -1;
>         }
>         if (write(dest_fd, dest, destlen) !=3D (ssize_t)destlen) {
>             munmap(dest, max_destlen);
>             return -1;
>         }
>         return munmap(dest, max_destlen);
>     }
>
>     static int setup_loop_device(unsigned char* data,
>                                                              unsigned lon=
g size,
>                                                              const char* =
loopname,
>                                                              int* loopfd_=
p) {
>         int err =3D 0, loopfd =3D -1;
>         int memfd =3D syscall(__NR_memfd_create, "syzkaller", 0);
>         if (memfd =3D=3D -1) {
>             err =3D errno;
>             goto error;
>         }
>         if (puff_zlib_to_file(data, size, memfd)) {
>             err =3D errno;
>             goto error_close_memfd;
>         }
>         loopfd =3D open(loopname, O_RDWR);
>         if (loopfd =3D=3D -1) {
>             err =3D errno;
>             goto error_close_memfd;
>         }
>         if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
>             if (errno !=3D EBUSY) {
>                 err =3D errno;
>                 goto error_close_loop;
>             }
>             ioctl(loopfd, LOOP_CLR_FD, 0);
>             usleep(1000);
>             if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
>                 err =3D errno;
>                 goto error_close_loop;
>             }
>         }
>         close(memfd);
>         *loopfd_p =3D loopfd;
>         return 0;
>
>     error_close_loop:
>         close(loopfd);
>     error_close_memfd:
>         close(memfd);
>     error:
>         errno =3D err;
>         return -1;
>     }
>
>     static long syz_mount_image(volatile long fsarg,
>                                                             volatile long=
 dir,
>                                                             volatile long=
 flags,
>                                                             volatile long=
 optsarg,
>                                                             volatile long=
 change_dir,
>                                                             volatile unsi=
gned long size,
>                                                             volatile long=
 image) {
>         unsigned char* data =3D (unsigned char*)image;
>         int res =3D -1, err =3D 0, loopfd =3D -1, need_loop_device =3D !!=
size;
>         char* mount_opts =3D (char*)optsarg;
>         char* target =3D (char*)dir;
>         char* fs =3D (char*)fsarg;
>         char* source =3D NULL;
>         char loopname[64];
>         if (need_loop_device) {
>             memset(loopname, 0, sizeof(loopname));
>             snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid)=
;
>             if (setup_loop_device(data, size, loopname, &loopfd) =3D=3D -=
1)
>                 return -1;
>             source =3D loopname;
>         }
>         mkdir(target, 0777);
>         char opts[256];
>         memset(opts, 0, sizeof(opts));
>         if (strlen(mount_opts) > (sizeof(opts) - 32)) {
>         }
>         strncpy(opts, mount_opts, sizeof(opts) - 32);
>         if (strcmp(fs, "iso9660") =3D=3D 0) {
>             flags |=3D MS_RDONLY;
>         } else if (strncmp(fs, "ext", 3) =3D=3D 0) {
>             bool has_remount_ro =3D false;
>             char* remount_ro_start =3D strstr(opts, "errors=3Dremount-ro"=
);
>             if (remount_ro_start !=3D NULL) {
>                 char after =3D *(remount_ro_start + strlen("errors=3Dremo=
unt-ro"));
>                 char before =3D remount_ro_start =3D=3D opts ? '\0' : *(r=
emount_ro_start - 1);
>                 has_remount_ro =3D ((before =3D=3D '\0' || before =3D=3D =
',') &&
>                                                     (after =3D=3D '\0' ||=
 after =3D=3D ','));
>             }
>             if (strstr(opts, "errors=3Dpanic") || !has_remount_ro)
>                 strcat(opts, ",errors=3Dcontinue");
>         } else if (strcmp(fs, "xfs") =3D=3D 0) {
>             strcat(opts, ",nouuid");
>         }
>         res =3D mount(source, target, fs, flags, opts);
>         if (res =3D=3D -1) {
>             err =3D errno;
>             goto error_clear_loop;
>         }
>         res =3D open(target, O_RDONLY | O_DIRECTORY);
>         if (res =3D=3D -1) {
>             err =3D errno;
>             goto error_clear_loop;
>         }
>         if (change_dir) {
>             res =3D chdir(target);
>             if (res =3D=3D -1) {
>                 err =3D errno;
>             }
>         }
>
>     error_clear_loop:
>         if (need_loop_device) {
>             ioctl(loopfd, LOOP_CLR_FD, 0);
>             close(loopfd);
>         }
>         errno =3D err;
>         return res;
>     }
>
>     static void kill_and_wait(int pid, int* status) {
>         kill(-pid, SIGKILL);
>         kill(pid, SIGKILL);
>         for (int i =3D 0; i < 100; i++) {
>             if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
>                 return;
>             usleep(1000);
>         }
>         DIR* dir =3D opendir("/sys/fs/fuse/connections");
>         if (dir) {
>             for (;;) {
>                 struct dirent* ent =3D readdir(dir);
>                 if (!ent)
>                     break;
>                 if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_na=
me, "..") =3D=3D 0)
>                     continue;
>                 char abort[300];
>                 snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/=
%s/abort",
>                                  ent->d_name);
>                 int fd =3D open(abort, O_WRONLY);
>                 if (fd =3D=3D -1) {
>                     continue;
>                 }
>                 if (write(fd, abort, 1) < 0) {
>                 }
>                 close(fd);
>             }
>             closedir(dir);
>         } else {
>         }
>         while (waitpid(-1, status, __WALL) !=3D pid) {
>         }
>     }
>
>     static void reset_loop() {
>         char buf[64];
>         snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
>         int loopfd =3D open(buf, O_RDWR);
>         if (loopfd !=3D -1) {
>             ioctl(loopfd, LOOP_CLR_FD, 0);
>             close(loopfd);
>         }
>     }
>
>     static void setup_test() {
>         prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>         setpgrp();
>         write_file("/proc/self/oom_score_adj", "1000");
>     }
>
>     static void execute_one(void);
>
>     #define WAIT_FLAGS __WALL
>
>     static void loop(void) {
>         int iter =3D 0;
>         for (;; iter++) {
>             reset_loop();
>             int pid =3D fork();
>             if (pid < 0)
>                 exit(1);
>             if (pid =3D=3D 0) {
>                 setup_test();
>                 execute_one();
>                 exit(0);
>             }
>             int status =3D 0;
>             uint64_t start =3D current_time_ms();
>             for (;;) {
>                 if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid=
)
>                     break;
>                 sleep_ms(1);
>                 if (current_time_ms() - start < 5000)
>                     continue;
>                 kill_and_wait(pid, &status);
>                 break;
>             }
>         }
>     }
>
>     void execute_one(void) {
>         NONFAILING(memcpy((void*)0x20000040, "vfat\000", 5));
>         NONFAILING(memcpy((void*)0x20000200, "./file0\000", 8));
>         NONFAILING(syz_mount_image(/*fs=3D*/0x20000040, /*dir=3D*/0x20000=
200,
>                                                              /*flags=3D*/=
0x220e002, /*opts=3D*/0, /*chdir=3D*/1,
>                                                              /*size=3D*/0=
, /*img=3D*/0x20000100));
>         NONFAILING(memcpy((void*)0x20000040, "mtd", 3));
>         NONFAILING(sprintf((char*)0x20000043, "0x%016llx", (long long)0))=
;
>         NONFAILING(memcpy((void*)0x200000c0, "./file0\000", 8));
>         NONFAILING(memcpy((void*)0x20001200, "jffs2\000", 6));
>         syscall(__NR_mount, /*src=3D*/0x20000040ul, /*dst=3D*/0x200000c0u=
l,
>                         /*type=3D*/0x20001200ul, /*flags=3D*/0ul, /*data=
=3D*/0ul);
>         NONFAILING(memcpy((void*)0x200001c0, "./file0\000", 8));
>         NONFAILING(memcpy((void*)0x200002c0, "security.evm\000", 13));
>         NONFAILING(*(uint8_t*)0x20002040 =3D 3);
>         NONFAILING(*(uint8_t*)0x20002041 =3D 2);
>         NONFAILING(*(uint8_t*)0x20002042 =3D 0xb);
>         NONFAILING(*(uint32_t*)0x20002043 =3D htobe32(4));
>         NONFAILING(*(uint16_t*)0x20002047 =3D htobe16(0x1000));
>         NONFAILING(memcpy(
>                 (void*)0x20002049,
>                 "\x78\x8d\x9c\xb2\x99\xab\xd7\x2e\xce\x91\x3d\x53\x36\x5e=
\x16\x68\x8e\x51"
>                 "\xac\xe1\x59\x84\xab\x53\xd1\x66\x6a\xe3\xf5\xdf\xbc\x86=
\x0b\xef\x87\x38"
>                 "\x9e\x21\x28\x6b\xe2\x36\xdd\xc3\xd0\xfa\x2e\x51\xd5\xc5=
\xc7\xb3\x5c\x5d"
>                 "\x50\x3c\x5b\x2c\x3b\x6b\xe0\xfc\x56\xe9\x7d\xf8\x8f\xaa=
\x06\x35\x36\x3b"
>                 "\xa9\x2b\x82\xc4\x7a\x81\x7a\xc9\x7f\x1d\x63\x8a\x14\x61=
\x82\x12\x55\xec"
>                 "\x23\xbd\x0c\xe5\xbf\x10\x94\xe3\xa8\x98\x0d\x7e\x6d\x19=
\x76\xba\x77\x87"
>                 "\x45\x92\x0e\x17\x18\xfd\xda\xc4\xbd\x66\xb0\xa6\x06\x80=
\x1a\xae\xfd\xed"
>                 "\x29\x3c\x3f\xce\xba\xd3\xb2\xc0\x64\x03\xdb\xa9\x99\x49=
\x71\x65\x9b\x7f"
>                 "\x4a\x07\x7a\xdd\xae\xb8\xae\x3e\x5a\xca\x70\x27\xfd\xe1=
\xe4\x00\x01\xc0"
>                 "\xbd\xd8\x00\xbc\xc2\x87\xe0\x2c\x86\x7e\x27\x82\xde\xaf=
\x67\x6a\x26\x16"
>                 "\x47\xdb\x8c\x2f\x39\x45\x02\x20\x57\xde\x76\x81\x00\xa8=
\xbf\x73\xd9\xf9"
>                 "\xff\x29\x22\x9b\x46\xde\xad\x58\xb2\xdd\xf9\x64\x33\x46=
\x8e\x9e\xee\x89"
>                 "\x50\xdf\x65\x87\x11\xe4\x11\x36\x4e\x44\x14\x5e\x68\x2f=
\x3c\x05\x3c\x6f"
>                 "\x5a\x18\x61\xee\xe6\xed\xf8\x85\xa9\x7c\x54\x58\x05\xac=
\x0c\x35\xa5\xe4"
>                 "\x62\x3b\x20\x01\x86\x1c\x59\x33\x54\xb5\x70\xff\x3b\x4a=
\x45\xf1\xac\xde"
>                 "\x0a\x8d\xbd\x17\xc0\x9c\xe4\x48\xed\x5d\xfd\x9e\x74\x72=
\xe6\x89\x67\xde"
>                 "\xcb\x76\x9f\xa6\x00\xcd\x30\xbe\xb6\xc8\x03\x0e\x94\x74=
\xc7\xec\x4c\x1d"
>                 "\xaf\x3e\x00\x7b\xbc\x57\x65\xb3\x66\xd4\xa1\x76\xe3\x8b=
\xdf\xab\xed\xd2"
>                 "\xb0\x76\xa5\xed\x7d\x50\xf5\x17\x7b\x94\xa6\xa0\xf0\x00=
\xcd\x3a\xca\xdd"
>                 "\xe8\xe8\x0f\x66\xea\xda\x14\x01\x86\x20\xb1\x59\xe9\xe1=
\x4c\x25\x2d\x20"
>                 "\xc8\xdb\xb0\xfe\x36\x05\xb5\x69\x8b\x53\xe4\x21\x0b\x62=
\xfc\xbd\x00\x01"
>                 "\x7e\xaa\x01\xeb\x1f\xa5\x21\xbd\xb8\xd3\x0e\x83\x95\x1b=
\x4e\xa0\x28\x6c"
>                 "\x8f\x0d\x46\x45\x17\xa1\x1d\x79\x22\xd6\xcc\xe4\xd2\x05=
\x8e\xc8\xcd\x7b"
>                 "\x02\xb7\x3d\x82\x5d\x7e\x0a\xbb\xbd\x85\xe9\x91\x22\x0f=
\xc7\x99\x55\x34"
>                 "\xb7\xb1\x99\x8c\xa7\x52\x89\x0b\x07\x9a\x7c\xa3\xfd\xe5=
\x64\x38\xcf\x82"
>                 "\xd5\xdd\x9e\xdb\xd1\x1f\xd2\x93\xc1\x7d\x1c\xf1\x66\x57=
\xd0\xb3\x52\xa8"
>                 "\xc6\xc3\x63\x00\xad\x09\xa7\x8e\x3e\xe3\x91\x3b\x9b\x6f=
\x53\xde\xbf\xfc"
>                 "\x7e\x32\xbf\xb6\x4b\x0e\x8c\xbe\x07\xfe\x9b\x0d\xad\xb0=
\x97\xae\xb2\xc2"
>                 "\x42\x43\x0b\xec\x75\x63\x0a\x39\x21\x82\x8a\x73\x14\xde=
\x14\x04\x82\x9e"
>                 "\x7a\xfb\x3b\x84\x20\xe8\x5f\x2c\x8f\x6e\x88\xde\x04\x23=
\x14\x41\x6e\x5c"
>                 "\x00\xc5\x9b\x22\x20\x80\x04\xbe\xc1\x61\xf8\x45\x7c\x7f=
\x8e\x3a\x8c\xa4"
>                 "\x17\x4a\x4b\x78\xdf\x6e\x46\x0d\x56\xd2\x4e\x01\xae\x1a=
\x24\x11\x27\x0f"
>                 "\x79\xd0\x20\xa6\xba\xc8\x55\xf1\xa3\xef\x7b\x3d\x09\x91=
\x88\x26\x56\xb4"
>                 "\x08\xdc\xda\xf0\x2d\xb4\x6a\xc8\xfc\xab\x0c\x87\x5d\x1f=
\x2e\x8d\xb3\x66"
>                 "\xe6\xa2\x0c\xb6\x7a\x4d\xb9\x20\x38\x2a\x69\x15\x71\x5d=
\x3b\x42\x66\xf7"
>                 "\x79\xfe\x86\x33\xbe\xa6\xde\xf2\x8c\xc1\x59\x13\x8b\x83=
\x43\x34\xce\xde"
>                 "\xf3\xde\xc5\x4e\xa5\x30\x3d\xf5\x6b\xe8\x71\x15\x31\x5e=
\xc0\xf1\x47\x8a"
>                 "\x0c\x08\x69\xe5\xf7\xc3\x3d\xa6\x4b\x23\xaf\x58\x11\x75=
\x10\x55\xc9\x08"
>                 "\x49\x48\x44\x81\xd5\xa1\x0d\x72\xe0\x8c\xcd\x12\x71\x0c=
\x4f\x2f\xf5\x86"
>                 "\xa9\xea\x17\x5f\x4a\xa7\x0b\x15\x6c\x00\xc5\x7e\x22\xc1=
\x36\x0b\xfc\x7d"
>                 "\x36\xaa\x47\x92\x44\x4f\x81\xd8\xa0\xed\x41\xbf\x6a\x45=
\x2e\xa5\x26\x8b"
>                 "\x86\x05\x68\x2a\xc6\x3e\xaa\x46\x52\x18\xf4\xd9\x62\xdb=
\x42\x15\x4d\x01"
>                 "\x96\x6d\x3a\xd8\xfc\x2f\xde\x48\xef\x71\xbe\x08\xbe\x58=
\xe5\xad\x6d\x5a"
>                 "\x35\x93\xef\xc9\xc1\x33\x6e\x54\x13\x72\xa3\x47\x99\xd2=
\x4e\xa0\x0d\x4d"
>                 "\x49\x85\xbe\xd1\xda\xb1\x06\x20\x91\x1e\x9f\x69\x67\x88=
\x08\x26\xbe\x5a"
>                 "\x1f\x1b\xb4\xb2\xa3\x94\x86\x54\xc6\x93\x5c\xaf\xeb\x49=
\x25\xe1\x07\xa0"
>                 "\x1f\x9d\xda\x66\x8e\x5f\xd7\x48\x9e\x82\x13\x92\x41\xa9=
\x19\x0f\x09\x0a"
>                 "\xfe\x20\x94\x23\x4c\x75\xfe\xc0\x74\x62\x27\x48\xd4\xdd=
\x78\x2a\x93\x0f"
>                 "\x42\xb0\xe7\x5d\x92\x4b\xef\x68\xff\xaf\xba\xa9\x89\x16=
\x15\x1a\x36\xef"
>                 "\x29\x98\xaf\xd3\x00\x09\x55\xef\xbf\xa0\xa9\xa0\x08\x35=
\x8c\x11\x04\x3c"
>                 "\x0f\x96\xb5\x2f\xc7\x8a\x42\x53\x1a\xa5\xdf\xd8\xde\x09=
\x51\x8c\xff\x00"
>                 "\x8b\x33\x92\x59\xb2\x66\xc4\x88\xbb\x1d\xa0\x58\xba\x21=
\x8c\xd6\x4b\x3e"
>                 "\x41\x3c\xa2\x88\x9d\x10\x86\xe8\xc4\x0a\xe1\x15\x01\x98=
\x41\x21\xdc\xfa"
>                 "\x2f\xde\x09\xd0\x68\xf6\xdb\xbe\x83\x59\x98\x0d\xad\x96=
\xed\x22\x0b\x85"
>                 "\x34\xaa\xef\x35\x3d\xfc\x81\x56\x09\x07\xd2\x6c\x02\x44=
\x29\x24\xad\x55"
>                 "\xb1\x1d\x3a\xee\x7e\x55\x16\xd9\x6a\xd0\x78\xc8\x5a\xd1=
\xcd\xb1\x8a\x45"
>                 "\x47\x43\x05\xa8\xdb\x35\x0f\x98\x44\x38\x0e\x20\x94\xf6=
\x91\xa0\x5e\xa0"
>                 "\x94\x58\xbc\x53\xf3\x23\x6a\x1f\x3f\xa5\xe1\x44\xa5\x75=
\xba\x57\xe5\x8d"
>                 "\x00\xf7\x65\x3d\x2e\x6b\x6c\xbe\x18\xd2\x8c\xe3\xf5\x79=
\x25\x38\xad\x20"
>                 "\xc0\xe0\xe1\x0b\x03\xda\xc3\x40\x09\xd6\xd3\xe4\xc7\x66=
\x2c\xca\x88\xb5"
>                 "\x30\x66\xe9\x5e\xfe\x45\xee\x3e\x04\xda\x32\x86\x90\xda=
\xe1\xaa\x00\x70"
>                 "\xf0\x94\x5e\x26\x9b\x75\x73\x3b\x10\x6f\xf6\x51\x45\x55=
\xd5\x4d\x95\x8f"
>                 "\x73\x13\x44\x1f\xa2\x1f\x97\x61\x53\x12\xc4\xf6\x00\xa1=
\x43\x0f\x62\x98"
>                 "\x12\xf2\x3c\xd2\x1e\x70\x3b\x96\x6e\x04\xaa\x6d\x0b\xba=
\x6f\x25\x39\x36"
>                 "\x9a\x3b\xad\xeb\xfa\xa8\x19\x7d\x89\xe3\x29\x4b\x44\xc0=
\xea\x54\xae\x6b"
>                 "\x7f\x4a\x49\x65\x68\x04\x31\x75\xa5\x66\x65\x41\xb5\x59=
\xa9\xfe\xaf\x0c"
>                 "\x54\x54\xf1\x2f\x23\x0e\x97\xbc\xf8\x4d\xae\x11\xd1\xa8=
\x35\x94\x11\xb9"
>                 "\x8b\xb6\x06\x3e\xe8\xae\x0f\xfa\x30\xb5\x75\x77\x71\xc7=
\xb7\x0e\x4f\xbb"
>                 "\x6e\x95\x1a\x68\x08\x73\xe6\xda\x53\x16\x00\xe9\x51\x11=
\x0c\x34\xca\xac"
>                 "\xc8\xe9\x78\xc0\x6b\x48\x48\xc8\x80\xc4\x8a\xd8\xe6\xc5=
\x4b\xc7\x92\xce"
>                 "\x54\xea\x4b\x1c\x05\xab\x04\xaf\xb4\xd6\xca\xb2\x5b\x85=
\xd1\xc4\xb6\xc4"
>                 "\x74\xc7\xec\x92\x67\xb5\x01\xed\xaa\x20\xee\x0e\x41\x58=
\x68\xd8\x78\x66"
>                 "\x42\x6b\x13\x74\xe5\x8a\x66\x65\x30\xb9\x4e\x34\x2c\x8b=
\x2e\xbd\xd4\x05"
>                 "\xfe\xf0\xa2\x6d\xf8\x2b\xbc\x50\x2d\xa2\xca\x15\x50\xc2=
\x8d\x3c\x0b\x69"
>                 "\x87\x2f\xf8\x61\xcd\x23\xcb\x6e\x1f\xf1\xe6\x2f\x62\x5a=
\xe9\x2f\x90\xf3"
>                 "\x09\x33\xfc\x82\x7e\xdd\x38\x61\x21\x31\x53\x52\xdb\xc9=
\xf4\xca\xb3\xdd"
>                 "\xda\xde\xb8\xdf\x05\x1d\x2f\x59\xcd\x59\xe9\x7d\xc9\x2c=
\xe4\x34\x1f\x97"
>                 "\x80\x03\xe4\x86\x85\xe7\x67\x3c\xf1\xe6\x02\x60\x60\x0e=
\x7c\xbf\x73\x1d"
>                 "\xc1\x68\xb9\xa4\x11\xdc\x3c\x85\xf8\x43\xbd\x2c\x5f\xca=
\x89\xc0\x6d\x12"
>                 "\xba\xc0\x8a\x61\xcf\x09\x9a\xe5\xf2\x3e\x5e\x90\x84\x48=
\xe8\x1f\x27\x79"
>                 "\xb3\x85\xb3\x1d\xcd\x5c\xf8\xaa\xad\x4b\x85\xae\x70\x63=
\x62\x4a\x7d\xf5"
>                 "\x73\xae\xcc\xc8\xb6\x19\x77\xf8\xec\x10\xe6\x8b\x5d\xf1=
\xc1\xb8\x05\xc7"
>                 "\xe0\x01\x22\x8a\x65\xc0\xe7\x72\xc5\x25\x14\x66\xa4\x9f=
\x10\x21\x9b\xb7"
>                 "\x18\xa4\xaa\x2e\x35\xc4\x08\x11\xa9\x72\xeb\x58\x53\x0f=
\x7f\x07\x41\xd3"
>                 "\xbe\x0c\x00\xe3\x8f\x58\x99\x4a\x51\x99\x54\x7f\xc5\x15=
\x0c\x78\x1f\xfe"
>                 "\x2e\x56\x56\x0f\x08\xeb\x75\xbf\xcd\x90\x85\xff\x14\x0c=
\xee\xfd\x0d\x6e"
>                 "\xd4\x3d\xad\x39\xd2\xcd\xa8\x69\x4d\x42\x0e\x86\x1a\x1d=
\xec\x4a\x28\xd1"
>                 "\xcf\x53\x24\xc5\xc5\xab\x81\x92\x21\x54\x87\x3b\x3f\x82=
\xdf\x1b\xc0\x6c"
>                 "\xb9\x56\x5c\x08\xf7\x74\xd9\xfa\x6f\xe5\x75\xda\xf8\x7b=
\x32\x8a\xb1\x0b"
>                 "\x91\x22\x43\xf1\x00\x71\x2a\x27\xf4\x98\x1f\xaa\x37\x2d=
\x73\x67\x02\xc5"
>                 "\x65\xa0\x8c\x4d\x6b\x0a\xa3\x12\xd3\xc9\x01\x7f\xd1\xe7=
\xab\x98\x1d\xe7"
>                 "\xee\x1d\xfc\x1a\x84\x99\x24\xaa\x92\xea\xb1\xb3\xe6\xe9=
\x74\x2f\x69\x13"
>                 "\xa0\x8b\x56\x99\xd6\x70\x69\x7a\x60\x8d\x74\x9e\x06\xc3=
\x41\x42\x1a\x80"
>                 "\x9a\x36\x5d\xca\x3f\x8d\x88\xd8\x42\x68\x50\x80\xf8\xed=
\x93\x48\x28\x88"
>                 "\x06\x5b\x50\xbf\x9a\xbd\xe7\x5f\xe3\x7c\x8f\xf2\xae\x4f=
\x24\xe2\x6f\x83"
>                 "\x94\x9a\xb5\xc4\xf4\xa9\x6e\x13\xb2\xcd\xf7\x42\xda\xf9=
\xc1\xb5\x83\x05"
>                 "\x69\x14\x56\xc6\xc1\x90\xbf\xb7\xbb\xbb\x08\x4e\xa9\xf9=
\x7e\x99\xc3\xe0"
>                 "\x28\x41\x5d\x4e\x05\xcc\xf7\x71\x7b\x57\x97\xff\x5b\xaf=
\xa2\x51\x8a\x0a"
>                 "\xca\xb4\x34\xa1\x88\xd4\x79\x7a\x85\xf3\x65\x57\xdd\x6a=
\xa3\x9c\x75\xe8"
>                 "\x0b\x72\x49\x63\x72\x65\x25\x44\xb1\x42\x49\x01\xa6\xa9=
\xd4\xb7\x45\x30"
>                 "\x86\xb6\xba\x26\xa4\x05\x21\xda\x94\xab\x54\xde\x4a\x11=
\xb5\x1b\x4a\xd7"
>                 "\xab\x1d\x68\x05\xf3\x23\xb0\x44\x95\x5f\x77\x9c\xfe\x7c=
\x1c\x35\x86\xf4"
>                 "\xbe\x0e\xab\x22\x6a\x25\xae\x16\xbd\x8d\xc7\xeb\x01\x50=
\x24\xb7\x43\x4b"
>                 "\x64\x08\x34\x3a\x1b\xe6\xe1\xdd\x39\x25\xc1\x02\xb4\xc9=
\xc5\x43\x98\x38"
>                 "\x35\xb6\xbb\x45\xf8\x0e\xa3\x5b\xf7\xfc\xec\xab\x5d\x94=
\x72\x24\xbf\xdb"
>                 "\x1c\x03\xb2\x0f\xc0\x7a\x5c\xac\x63\x0b\xeb\x4b\x30\x44=
\xeb\xe5\x5c\x90"
>                 "\x23\x84\x4c\x1f\xd6\x4b\x4e\xb0\x25\x53\x68\x67\xf0\xaf=
\xa3\x88\x57\x6c"
>                 "\x5b\x25\x64\xcd\x2e\x20\xae\x26\x33\xf7\xb7\x6c\xf6\xfb=
\xce\xff\x24\x0f"
>                 "\x65\xe5\xee\xba\x28\x43\xfa\xa1\xe7\x71\x08\xd3\x5c\x59=
\xb3\xf5\x70\x11"
>                 "\x26\x60\xe9\x27\x8d\xa3\x12\x76\x86\xdc\x2a\x96\x5a\x6a=
\xd1\x67\x2e\x29"
>                 "\xff\x9e\xdd\x62\xf4\x9e\x41\xbd\xd6\x53\x48\xd2\x65\x78=
\x46\xbe\x80\x47"
>                 "\x9c\xea\x41\x5b\xfb\x59\x27\x22\x9f\x3b\x77\x2e\xd9\xc9=
\xb7\x63\x9d\x8f"
>                 "\x75\xff\x66\x21\x84\x1a\x7b\x64\x97\x81\x31\xe8\x69\x52=
\xbf\xe5\x10\x71"
>                 "\x5b\x25\xef\xbc\xf3\x93\x32\x0c\x1d\x62\x99\xac\x6c\x19=
\xdd\x90\x88\x70"
>                 "\xf9\x6d\x92\xb8\xbd\xcf\x11\xe3\xc9\x87\x8f\x2e\x37\xbd=
\xaf\x72\x71\x8a"
>                 "\xd0\xbc\x28\x72\xc7\xa0\xb1\x01\xf6\xe3\x92\x99\x72\x34=
\xe0\x6c\x9b\x1b"
>                 "\xdc\x32\x49\x71\x42\x7d\x6b\x97\xc3\xc1\x65\x31\x17\x8f=
\x40\xa8\xab\x52"
>                 "\xf9\x8e\x06\x67\x80\x97\x7a\xbd\x35\x2e\x1e\xfe\x61\x85=
\xf7\x02\x33\xb3"
>                 "\x0f\xdc\x96\xb6\xa2\x89\xb9\xe0\xfc\xee\x55\x59\x23\xef=
\x59\x0b\xd9\xcd"
>                 "\x2f\x0e\xf7\x02\x46\x41\x45\x0d\x1a\x92\x58\x04\x6a\xc0=
\xe8\x0a\xcd\x44"
>                 "\xf2\x67\x44\x69\x46\xc0\x96\xdb\x98\x48\xf7\x8c\xdd\xba=
\x9f\x54\x09\xb0"
>                 "\x90\xdd\x23\x44\xd8\xd4\x5a\x16\xcd\x2e\xcc\xe5\xbf\x22=
\xbd\x4c\xb8\x9a"
>                 "\xfd\x30\x67\xcb\x0b\xd9\xa7\x27\x9b\xe1\xb1\xe5\x03\x49=
\x8f\x39\xed\xce"
>                 "\x71\x4f\x37\x59\x7d\x0e\x64\x60\x71\x6d\x09\xea\x37\x6d=
\x73\xe8\xa7\x1f"
>                 "\xff\x13\x24\xfa\x2a\xeb\xa7\x5e\x8b\xbd\x0e\xa4\xc4\x18=
\xb4\x57\x84\x55"
>                 "\x01\x53\xd4\x92\x89\x8e\x15\xda\x88\xb6\xed\x3f\x67\xe8=
\x5d\xbb\x11\x1c"
>                 "\x2f\xea\xc2\xfd\x78\xb6\xf9\x01\x1c\x68\x64\xb9\xbb\x11=
\x65\x36\x94\xf7"
>                 "\xf0\x25\x68\xb7\x68\xb6\xa2\x7d\x08\x0e\xad\xc0\x09\x37=
\x44\xb9\x11\x5a"
>                 "\xa2\xf8\xd0\x3f\xa2\x7f\xae\xa2\xe3\x56\xef\x8c\xe6\x2e=
\x47\x22\xdd\xd1"
>                 "\x39\xf7\x84\xac\x3b\x8a\xfb\x98\xc8\xd3\x98\x4c\x8c\xf9=
\x43\x8e\x83\x71"
>                 "\x03\x30\x42\x8b\x78\x30\xc1\x70\x9a\x30\x9b\xba\xc3\xbb=
\xdb\xd0\x83\xe5"
>                 "\x39\x93\x8c\x57\x89\xe1\x70\x9d\x2c\x0e\xe9\x4d\xcb\x2f=
\xe6\x4c\x31\xc8"
>                 "\x7d\x25\xcc\x7f\x82\x6b\xbf\x5e\x02\x1d\x5a\xaa\x17\x29=
\x70\xaa\xe9\x6a"
>                 "\x68\x58\xf8\xc1\x1f\xdf\xb7\x48\x32\x8d\x97\x41\x1e\xdc=
\x10\xdd\x16\xfd"
>                 "\x10\xfa\xa7\xc3\xb9\x4c\xe1\x91\x52\xfb\x29\x65\x69\x04=
\x21\xd3\xc6\xdb"
>                 "\x2e\x7e\x88\x88\xc7\xbb\x06\x44\x3d\xb3\x11\x1e\x3d\xb6=
\x9a\x88\xdd\x09"
>                 "\x7a\xb8\xc6\x4d\x6b\xea\x30\xda\x24\x7f\xcd\x11\x7a\x30=
\xee\xf4\x5c\xd9"
>                 "\x33\x9a\x78\x37\x56\x28\xcd\xbf\xa2\x6d\x6b\x34\x19\xe6=
\x9b\xbe\x8e\x88"
>                 "\x47\x91\x29\x68\x4b\x23\x04\xda\xa2\xd6\x84\x30\x48\x26=
\xee\xe9\x7d\x34"
>                 "\x63\x03\xcc\x63\x1e\x10\x46\x5a\x2f\x92\x43\xe8\x4d\x32=
\x28\x10\x38\x8b"
>                 "\xa2\xd3\x06\x26\xa6\x3d\xf9\x79\x3e\xb9\x63\xdf\x23\x48=
\x65\xcb\xb6\x8c"
>                 "\xdb\xc0\x43\x63\xe1\x7a\x6a\x6e\xb1\xc8\x01\x41\x77\xc9=
\x9f\xaa\xcb\x8d"
>                 "\x7a\x8e\x99\xd8\x97\x71\x8b\xc5\x10\x55\x72\x78\x20\xd3=
\x21\xf2\x5f\xd1"
>                 "\x5d\x24\xd0\x29\xd4\xfa\xd6\xfd\xe9\x7f\x09\x11\x80\xef=
\x2b\xc3\x91\x3b"
>                 "\xc1\x1f\x8f\x10\x4b\xcc\x7e\xa0\x02\x41\x57\x48\x1b\x35=
\x37\xce\x54\x3f"
>                 "\xe8\xab\x93\xa2\x6c\xb9\xba\x51\xfa\x78\xd3\x37\xbf\x10=
\xba\x29\xdc\x5f"
>                 "\xeb\xfe\x4a\xd0\x14\xbd\x40\xf3\x33\x30\x82\x3d\x7f\x45=
\x73\xba\xeb\xd9"
>                 "\xe0\x63\xd5\x9a\x87\x66\x2b\xef\x85\x9c\xee\x8a\x8e\x53=
\x18\xaa\xe2\x2e"
>                 "\x79\xfb\x4d\x31\xe0\x88\xf0\x56\x9c\x67\xbb\xa4\x18\x68=
\xfe\x46\x4e\xd7"
>                 "\x7e\xc7\xfe\x07\xdd\x3a\x5c\x2c\x81\xc1\xfd\xed\x16\x05=
\x98\xb3\x75\x64"
>                 "\x51\x31\x73\xf1\x3f\xee\xb9\xdf\x4b\x47\xed\xe8\x05\x0a=
\xac\x43\x1e\x1b"
>                 "\x20\x58\xc6\xaf\xe7\xe4\x4b\xcc\x6f\x28\xdc\x58\x33\xdd=
\xed\x10\xe6\x91"
>                 "\x7e\x15\xb9\x30\x88\xcd\x90\x79\x18\x26\xca\x7c\x3b\x9a=
\x42\x11\xe9\xe2"
>                 "\xff\xd4\x96\x62\x23\x81\x6d\xb6\xe4\xed\xe5\x70\x1b\x76=
\x98\x8d\x8f\x34"
>                 "\xaa\x14\x0f\xfb\x4b\xc3\xef\xfc\xcb\xe5\xaf\x39\x42\xd4=
\xc5\x71\x77\x00"
>                 "\xe5\x92\xa1\x70\x01\xd2\x0b\x66\x5f\xb7\xc6\xf6\x53\x61=
\x10\x8a\x13\x70"
>                 "\xa4\x5d\xb4\x77\xa1\xf4\x49\xe5\xc3\xf9\xa8\x9f\x96\x72=
\x90\xaf\x23\x1d"
>                 "\xb8\x2f\xed\xec\xfc\xa2\xc3\xce\xdf\xfe\xad\xb7\x75\x72=
\x8b\x45\xce\x4b"
>                 "\xde\x06\x30\xe9\xe1\xdf\xcd\x98\x13\x8a\x55\x6d\xd4\x0b=
\x65\x55\x81\xb4"
>                 "\x51\xa7\x16\x4a\xd5\x7c\x4f\xb2\xb5\xdc\x5b\x14\x5e\x87=
\x33\xde\x33\xaf"
>                 "\x84\x4e\x40\x04\x14\xf8\x5c\x28\xca\x1f\x88\x8e\x70\xc4=
\x5d\x28\xc8\x23"
>                 "\xe0\x7e\xdd\xf3\x0d\xf7\x91\x1d\xf5\x84\xad\x45\x8a\x25=
\x35\x50\x84\x16"
>                 "\x3a\x9a\x7c\xc3\xba\xc4\x27\x6e\x95\x72\x11\x62\x6e\x28=
\x82\x12\x00\x53"
>                 "\x34\xde\xc7\x42\xcf\xe5\x7e\x6c\x82\x34\xe5\x20\xd8\xbe=
\xd4\x5a\xf4\x76"
>                 "\x77\x0f\x47\x18\xf7\x99\xc1\xa1\xf6\x37\xfc\x04\xa7\x37=
\x80\xa3\x5d\x21"
>                 "\x94\xe6\x01\x7e\x40\x5d\x3e\x0b\x1e\x9f\x2c\x7c\x0f\x6a=
\x0e\xd2\x8a\x2e"
>                 "\xaf\xdd\x79\x22\x76\x20\x59\xfe\x0e\xbc\x77\x59\x92\x45=
\xb1\x2c\x9f\x0c"
>                 "\xef\x9e\xda\xb1\xa2\x51\x71\xa6\xa9\xa0\x56\x2e\x24\xdb=
\x76\xe2\x5d\xfb"
>                 "\x5e\xcb\x73\x52\xd0\xbf\xc7\x8d\x85\x8e\x8a\xaa\xc9\x13=
\xef\xa4\xff\x60"
>                 "\x48\x96\x79\xe8\xc7\x20\x19\x89\x7a\x8a\x85\xa9\xee\x29=
\xf1\x09\x22\x31"
>                 "\x5b\xa7\xdb\x0a\x12\x6f\x82\x7c\x03\xfa\x5b\xbb\x90\xf9=
\x91\xcb\x98\x66"
>                 "\xb3\xe0\x30\x47\xcb\x1f\xab\xbb\xdb\xe5\xa3\x52\x82\xf0=
\x30\xc0\xdb\xdb"
>                 "\xd2\x27\xf8\x5b\x05\x72\x1c\x45\xc8\xb2\xb8\x5d\x33\x10=
\xbb\x41\xd6\xaa"
>                 "\x56\x14\xa6\x0d\x98\x74\xd1\x2f\x11\xf5\xa9\x4b\x15\xf7=
\x41\xdb\x31\x0c"
>                 "\x92\x7b\x2e\x90\x60\x7a\x2a\xf8\xc4\xb5\x7d\x6b\x69\x37=
\xd5\xa1\xeb\x14"
>                 "\x58\x9d\x1e\x36\x16\x42\x45\x8c\xc2\xfb\xd2\x96\xac\x03=
\x1d\x09\x9d\xf4"
>                 "\x9a\x53\xe8\xf0\xd4\x50\x6b\x2d\xcb\xb2\x0f\x54\x56\x0b=
\x69\x5a\x4e\x0a"
>                 "\x4a\x5a\x13\x23\x19\x85\xd5\x3b\xb3\x53\x31\x26\xad\xd2=
\x81\xfd\x38\xcd"
>                 "\xdf\x7e\xf4\x37\x20\x1e\x8a\xea\x1a\xb6\x3a\xd6\x73\xcd=
\xcc\x6c\x60\x41"
>                 "\x14\xae\xc7\x71\x88\x1b\x4f\xb7\xaa\x7c\xcb\xd3\x97\xe7=
\x03\xf1\x08\x95"
>                 "\x61\x9e\x15\xc7\x16\x84\xbb\xbf\xa2\xb2\xc6\x0a\x79\x0d=
\xe0\xe5\x05\x95"
>                 "\x38\xb5\x1d\x34\x7a\x68\xad\x05\x74\x72\xa9\xf1\xea\xf0=
\x54\xdf\x77\x91"
>                 "\xb5\x8f\x63\x8c\x05\x95\x55\xbb\xb9\x70\xed\xf8\x77\xd5=
\xf6\x23\xe2\x54"
>                 "\x1d\xba\x27\xdf\x8d\x71\x3f\xe7\xc5\x5f\x40\xfb\xf3\xdb=
\xdc\x3d\x04\x2e"
>                 "\x92\xb8\x3f\x94\xdd\x66\xd1\xcd\x2b\xc5\xcc\x98\xa6\xa5=
\x02\xb5\xd8\xd8"
>                 "\xee\x6e\xfe\xca\xcf\xb7\x62\x46\x4c\x6f\x8c\xea\x8b\xda=
\xd1\x4a\x29\x19"
>                 "\x99\x28\xe0\xcb\x07\xfb\xc3\x06\xb9\xee\xcc\xc4\xc7\xa3=
\x26\x18\x52\x54"
>                 "\x41\x48\x92\xb6\x14\xdd\xcc\x20\xe9\xb5\xd2\x58\xe6\x62=
\x71\x43\x0c\x07"
>                 "\x05\xc5\xa6\x22\xfa\x56\x46\xda\x48\x97\xa0\x88\xf6\x8f=
\xde\xb6\x68\x42"
>                 "\xad\x3d\x72\xf2\x32\xf4\x87\xb3\xdb\x3b\x83\xd8\x26\x22=
\xc9\x1d\xaf\x77"
>                 "\x96\x34\xfa\x1b\x97\xc7\xd5\xad\xb5\xd5\x3b\xe5\x19\x8b=
\xc5\x9a\xef\x1a"
>                 "\xab\x60\xc3\x79\x52\x96\xa8\x4a\xc3\xf7\x73\x99\xfe\xed=
\x5b\x86\xf4\x4b"
>                 "\x3a\x1c\xa3\x5e\xe4\x68\x91\xee\x90\x3a\x90\x34\x08\x83=
\xce\xc4\x1d\x57"
>                 "\x7a\x88\x80\x94\x5b\x50\x4c\x7e\xa5\xbd\xc9\x4d\x66\xbf=
\x25\xb4\xd2\xe0"
>                 "\x64\xbd\x69\xdf\xce\x4f\x00\xf8\xdf\xad\xe0\x73\x9f\xab=
\x52\x75\xdb\x11"
>                 "\xe9\x99\xb2\x56\x22\xc2\x0c\xa0\xa9\xf1\x0f\x27\xc8\x00=
\xa4\xf5\xd1\x9a"
>                 "\xa9\x2d\x04\xcd\x28\x2f\x96\xe9\x90\x30\x18\x74\xc5\xdd=
\xcf\xb1\x32\x23"
>                 "\xc4\xf5\xfd\x37\xc4\x49\xad\xde\x53\x2a\x16\xae\xe6\x64=
\x07\xbf\xee\xee"
>                 "\xbd\xa4\xf5\x13\xf2\x24\xe4\x34\xa9\xc0\x8a\x22\x81\xd5=
\xe1\xf4\x59\x1c"
>                 "\x9a\x43\x3a\xb1\x57\x6c\x11\xed\xd0\xdf\x9f\xb6\xf4\x7b=
\x76\x1f\xc8\x78"
>                 "\xd5\x32\xd7\xfc\x2a\x76\x24\x61\xfd\x14\x73\xeb\x7c\x7c=
\x88\x66\x8b\x74"
>                 "\x9b\x9b\xbf\x43\xc9\x37\xfa\x2b\xd7\x3a\xe9\x17\xea\x2a=
\x90\x3b\xf5\xf7"
>                 "\xd7\x1a\xe1\xc7\xd7\x1c\x60\xde\xf1\xbb\xc4\xe8\x15\x1b=
\xee\x5f\x4a\x39"
>                 "\x63\x25\x90\x7f\x4f\x2b\xcb\xe9\x80\x38\xe4\x6b\xc9\xfb=
\x30\xd1\x99\xf0"
>                 "\x25\xea\xbe\xb0\x37\xce\xae\xc3\xee\x18\x7f\x73\xa1\x36=
\xb8\x56\x6a\x94"
>                 "\x3d\x5b\x32\x71\x19\x9e\x6d\x19\xb7\x06\x6d\x90\xb1\x0d=
\x0c\x11\xe7\xcb"
>                 "\x0c\x0b\x5f\x73\x12\x7c\xd6\x85\xa7\x63\x8b\x99\xa1\xc9=
\xae\xa4\xfb\xf3"
>                 "\xfa\xc6\x7a\x4b\x11\x4c\xa9\xfa\x60\xd2\xc9\xc2\x47\x23=
\xb0\x37\x14\x2e"
>                 "\x3e\x47\x50\x3f\x3d\xfd\xff\xc4\x87\x21\x20\x90\xd2\x21=
\xeb\x85\xf5\x3c"
>                 "\xf6\x17\x6c\x26\xb9\x3c\x75\x7b\x52\x1d\x01\x7c\xa1\x7a=
\xc7\x88\x9c\x26"
>                 "\xc6\x47\x3f\xb4\x4c\xc2\xab\x79\xcd\x76\xfb\xf8\xfc\x5a=
\x81\xdc\x24\xbd"
>                 "\x7b\xa6\xd5\x5d\x80\x36\xf4\xd6\x02\x18\xe7\xc8\xfd\xf7=
\xf3\xb9\x15\xef"
>                 "\xd0\xbd\x0e\xdf\xac\x38\x0e\x37\x17\x79\x4a\xb4\x6b\x2a=
\x5d\xae\xd5\x8f"
>                 "\xdb\x3e\xa6\x67\x20\xc0\xe7\x8a\x0c\xe8\x25\xb1\x55\xeb=
\xc0\x97\x9c\xf7"
>                 "\x79\x15\xdb\x3d\xf6\x00\xbb\xd1\x79\xf1\xd2\xd6\x74\xd7=
\x6b\x12\xaf\xf0"
>                 "\x87\x75\x7d\x4a\xa4\x80\xee\x15\x66\x78\x40\x74\xa5\x28=
\x7b\xe0\x08\x8e"
>                 "\xfb\xe1\x2f\x55\x0b\xad\x3b\x41\x0c\xf0\x4f\xba\x8f\x06=
\xd1\x12\x0a\x1d"
>                 "\xad\x35\xde\x9c\x7a\x22\xc3\xca\xf8\x3c\x1b\xf6\xea\x57=
\xa0\x55\xaf\xcb"
>                 "\xc6\x1b\x06\x8f\xeb\x5d\x17\xf5\xd0\xcd\x9e\x59\x11\xd2=
\xd9\xc8\xc6\xff"
>                 "\x89\xfc\x37\x72\x5a\x4b\x9a\xc3\xa8\x80\x0d\x17\x31\x19=
\x9c\x82\x01\xc0"
>                 "\x52\x2e\x9a\xf7\x49\xfe\x36\xe1\x41\x94\x31\x0a\x5a\xaf=
\xd9\x44\xc3\x21"
>                 "\xef\xb4\xec\xf5\xc1\x31\xcc\xf9\xde\x48\xc8\xb3\x6a\x90=
\x5f\x47\xeb\xa8"
>                 "\xfb\x42\xce\x43\x5d\x1b\xd4\x08\xdc\x87\xb1\xc9\x15\x77=
\xff\xba\x16\xe3"
>                 "\x2b\x9b\xe2\x19\x82\xd3\x17\x63\x20\xc8\xe2\x37\x99\xb6=
\xc5\xcc\x3d\x83"
>                 "\x4c\xcb\xe9\xac\xed\xa7\x0b\xd2\xc7\x3a\x15\x41\x37\xac=
\xdd\x65\xf4\x19"
>                 "\x1e\x44\x70\x89\x3e\xb2\x4e\x4a\xb0\x07\x00\xc2\xc1\x35=
\x14\x9f\xb8\x66"
>                 "\x44\xb5\xac\x0b\xe1\x66\x92\x88\xb9\xc2\x9a\x1f\x6f\x61=
\x51\x7d\x8b\x4f"
>                 "\x09\x61\x6e\x76\x7b\xd7\x2d\x13\xf8\x33",
>                 4096));
>         syscall(__NR_lsetxattr, /*path=3D*/0x200001c0ul, /*name=3D*/0x200=
002c0ul,
>                         /*val=3D*/0x20002040ul, /*size=3D*/0x1009ul, /*fl=
ags=3D*/3ul);
>     }
>     int main(void) {
>         syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /=
*prot=3D*/0ul,
>                         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul=
);
>         syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul=
, /*prot=3D*/7ul,
>                         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul=
);
>         syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /=
*prot=3D*/0ul,
>                         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul=
);
>         install_segv_handler();
>         for (procid =3D 0; procid < 4; procid++) {
>             if (fork() =3D=3D 0) {
>                 loop();
>             }
>         }
>         sleep(1000000);
>         return 0;
>     }
>
>
> =3D* repro.txt =3D*
> syz_mount_image$vfat(&(0x7f0000000040), &(0x7f0000000200)=3D'./file0\x00'=
, 0x220e002, 0x0, 0x1, 0x0, &(0x7f0000000100))
> mount(&(0x7f0000000040)=3DANY=3D[@ANYBLOB=3D'mtd', @ANYRESHEX=3D0x0], &(0=
x7f00000000c0)=3D'./file0\x00', &(0x7f0000001200)=3D'jffs2\x00', 0x0, 0x0)
> lsetxattr$security_evm(&(0x7f00000001c0)=3D'./file0\x00', &(0x7f00000002c=
0), &(0x7f0000002040)=3D@v2=3D{0x3, 0x2, 0xb, 0x4, 0x1000, "788d9cb299abd72=
ece913d53365e16688e51ace15984ab53d1666ae3f5dfbc860bef87389e21286be236ddc3d0=
fa2e51d5c5c7b35c5d503c5b2c3b6be0fc56e97df88faa0635363ba92b82c47a817ac97f1d6=
38a1461821255ec23bd0ce5bf1094e3a8980d7e6d1976ba778745920e1718fddac4bd66b0a6=
06801aaefded293c3fcebad3b2c06403dba9994971659b7f4a077addaeb8ae3e5aca7027fde=
1e40001c0bdd800bcc287e02c867e2782deaf676a261647db8c2f3945022057de768100a8bf=
73d9f9ff29229b46dead58b2ddf96433468e9eee8950df658711e411364e44145e682f3c053=
c6f5a1861eee6edf885a97c545805ac0c35a5e4623b2001861c593354b570ff3b4a45f1acde=
0a8dbd17c09ce448ed5dfd9e7472e68967decb769fa600cd30beb6c8030e9474c7ec4c1daf3=
e007bbc5765b366d4a176e38bdfabedd2b076a5ed7d50f5177b94a6a0f000cd3acadde8e80f=
66eada14018620b159e9e14c252d20c8dbb0fe3605b5698b53e4210b62fcbd00017eaa01eb1=
fa521bdb8d30e83951b4ea0286c8f0d464517a11d7922d6cce4d2058ec8cd7b02b73d825d7e=
0abbbd85e991220fc7995534b7b1998ca752890b079a7ca3fde56438cf82d5dd9edbd11fd29=
3c17d1cf16657d0b352a8c6c36300ad09a78e3ee3913b9b6f53debffc7e32bfb64b0e8cbe07=
fe9b0dadb097aeb2c242430bec75630a3921828a7314de1404829e7afb3b8420e85f2c8f6e8=
8de042314416e5c00c59b22208004bec161f8457c7f8e3a8ca4174a4b78df6e460d56d24e01=
ae1a2411270f79d020a6bac855f1a3ef7b3d0991882656b408dcdaf02db46ac8fcab0c875d1=
f2e8db366e6a20cb67a4db920382a6915715d3b4266f779fe8633bea6def28cc159138b8343=
34cedef3dec54ea5303df56be87115315ec0f1478a0c0869e5f7c33da64b23af5811751055c=
90849484481d5a10d72e08ccd12710c4f2ff586a9ea175f4aa70b156c00c57e22c1360bfc7d=
36aa4792444f81d8a0ed41bf6a452ea5268b8605682ac63eaa465218f4d962db42154d01966=
d3ad8fc2fde48ef71be08be58e5ad6d5a3593efc9c1336e541372a34799d24ea00d4d4985be=
d1dab10620911e9f6967880826be5a1f1bb4b2a3948654c6935cafeb4925e107a01f9dda668=
e5fd7489e82139241a9190f090afe2094234c75fec074622748d4dd782a930f42b0e75d924b=
ef68ffafbaa98916151a36ef2998afd3000955efbfa0a9a008358c11043c0f96b52fc78a425=
31aa5dfd8de09518cff008b339259b266c488bb1da058ba218cd64b3e413ca2889d1086e8c4=
0ae11501984121dcfa2fde09d068f6dbbe8359980dad96ed220b8534aaef353dfc81560907d=
26c02442924ad55b11d3aee7e5516d96ad078c85ad1cdb18a45474305a8db350f9844380e20=
94f691a05ea09458bc53f3236a1f3fa5e144a575ba57e58d00f7653d2e6b6cbe18d28ce3f57=
92538ad20c0e0e10b03dac34009d6d3e4c7662cca88b53066e95efe45ee3e04da328690dae1=
aa0070f0945e269b75733b106ff6514555d54d958f7313441fa21f97615312c4f600a1430f6=
29812f23cd21e703b966e04aa6d0bba6f2539369a3badebfaa8197d89e3294b44c0ea54ae6b=
7f4a496568043175a5666541b559a9feaf0c5454f12f230e97bcf84dae11d1a8359411b98bb=
6063ee8ae0ffa30b5757771c7b70e4fbb6e951a680873e6da531600e951110c34caacc8e978=
c06b4848c880c48ad8e6c54bc792ce54ea4b1c05ab04afb4d6cab25b85d1c4b6c474c7ec926=
7b501edaa20ee0e415868d87866426b1374e58a666530b94e342c8b2ebdd405fef0a26df82b=
bc502da2ca1550c28d3c0b69872ff861cd23cb6e1ff1e62f625ae92f90f30933fc827edd386=
121315352dbc9f4cab3dddadeb8df051d2f59cd59e97dc92ce4341f978003e48685e7673cf1=
e60260600e7cbf731dc168b9a411dc3c85f843bd2c5fca89c06d12bac08a61cf099ae5f23e5=
e908448e81f2779b385b31dcd5cf8aaad4b85ae7063624a7df573aeccc8b61977f8ec10e68b=
5df1c1b805c7e001228a65c0e772c5251466a49f10219bb718a4aa2e35c40811a972eb58530=
f7f0741d3be0c00e38f58994a5199547fc5150c781ffe2e56560f08eb75bfcd9085ff140cee=
fd0d6ed43dad39d2cda8694d420e861a1dec4a28d1cf5324c5c5ab81922154873b3f82df1bc=
06cb9565c08f774d9fa6fe575daf87b328ab10b912243f100712a27f4981faa372d736702c5=
65a08c4d6b0aa312d3c9017fd1e7ab981de7ee1dfc1a849924aa92eab1b3e6e9742f6913a08=
b5699d670697a608d749e06c341421a809a365dca3f8d88d842685080f8ed93482888065b50=
bf9abde75fe37c8ff2ae4f24e26f83949ab5c4f4a96e13b2cdf742daf9c1b58305691456c6c=
190bfb7bbbb084ea9f97e99c3e028415d4e05ccf7717b5797ff5bafa2518a0acab434a188d4=
797a85f36557dd6aa39c75e80b72496372652544b1424901a6a9d4b7453086b6ba26a40521d=
a94ab54de4a11b51b4ad7ab1d6805f323b044955f779cfe7c1c3586f4be0eab226a25ae16bd=
8dc7eb015024b7434b6408343a1be6e1dd3925c102b4c9c543983835b6bb45f80ea35bf7fce=
cab5d947224bfdb1c03b20fc07a5cac630beb4b3044ebe55c9023844c1fd64b4eb025536867=
f0afa388576c5b2564cd2e20ae2633f7b76cf6fbceff240f65e5eeba2843faa1e77108d35c5=
9b3f570112660e9278da3127686dc2a965a6ad1672e29ff9edd62f49e41bdd65348d2657846=
be80479cea415bfb5927229f3b772ed9c9b7639d8f75ff6621841a7b64978131e86952bfe51=
0715b25efbcf393320c1d6299ac6c19dd908870f96d92b8bdcf11e3c9878f2e37bdaf72718a=
d0bc2872c7a0b101f6e392997234e06c9b1bdc324971427d6b97c3c16531178f40a8ab52f98=
e066780977abd352e1efe6185f70233b30fdc96b6a289b9e0fcee555923ef590bd9cd2f0ef7=
024641450d1a9258046ac0e80acd44f267446946c096db9848f78cddba9f5409b090dd2344d=
8d45a16cd2ecce5bf22bd4cb89afd3067cb0bd9a7279be1b1e503498f39edce714f37597d0e=
6460716d09ea376d73e8a71fff1324fa2aeba75e8bbd0ea4c418b45784550153d492898e15d=
a88b6ed3f67e85dbb111c2feac2fd78b6f9011c6864b9bb11653694f7f02568b768b6a27d08=
0eadc0093744b9115aa2f8d03fa27faea2e356ef8ce62e4722ddd139f784ac3b8afb98c8d39=
84c8cf9438e83710330428b7830c1709a309bbac3bbdbd083e539938c5789e1709d2c0ee94d=
cb2fe64c31c87d25cc7f826bbf5e021d5aaa172970aae96a6858f8c11fdfb748328d97411ed=
c10dd16fd10faa7c3b94ce19152fb2965690421d3c6db2e7e8888c7bb06443db3111e3db69a=
88dd097ab8c64d6bea30da247fcd117a30eef45cd9339a78375628cdbfa26d6b3419e69bbe8=
e88479129684b2304daa2d684304826eee97d346303cc631e10465a2f9243e84d322810388b=
a2d30626a63df9793eb963df234865cbb68cdbc04363e17a6a6eb1c8014177c99faacb8d7a8=
e99d897718bc51055727820d321f25fd15d24d029d4fad6fde97f091180ef2bc3913bc11f8f=
104bcc7ea0024157481b3537ce543fe8ab93a26cb9ba51fa78d337bf10ba29dc5febfe4ad01=
4bd40f33330823d7f4573baebd9e063d59a87662bef859cee8a8e5318aae22e79fb4d31e088=
f0569c67bba41868fe464ed77ec7fe07dd3a5c2c81c1fded160598b37564513173f13feeb9d=
f4b47ede8050aac431e1b2058c6afe7e44bcc6f28dc5833dded10e6917e15b93088cd907918=
26ca7c3b9a4211e9e2ffd4966223816db6e4ede5701b76988d8f34aa140ffb4bc3effccbe5a=
f3942d4c5717700e592a17001d20b665fb7c6f65361108a1370a45db477a1f449e5c3f9a89f=
967290af231db82fedecfca2c3cedffeadb775728b45ce4bde0630e9e1dfcd98138a556dd40=
b655581b451a7164ad57c4fb2b5dc5b145e8733de33af844e400414f85c28ca1f888e70c45d=
28c823e07eddf30df7911df584ad458a25355084163a9a7cc3bac4276e957211626e2882120=
05334dec742cfe57e6c8234e520d8bed45af476770f4718f799c1a1f637fc04a73780a35d21=
94e6017e405d3e0b1e9f2c7c0f6a0ed28a2eafdd7922762059fe0ebc77599245b12c9f0cef9=
edab1a25171a6a9a0562e24db76e25dfb5ecb7352d0bfc78d858e8aaac913efa4ff60489679=
e8c72019897a8a85a9ee29f10922315ba7db0a126f827c03fa5bbb90f991cb9866b3e03047c=
b1fabbbdbe5a35282f030c0dbdbd227f85b05721c45c8b2b85d3310bb41d6aa5614a60d9874=
d12f11f5a94b15f741db310c927b2e90607a2af8c4b57d6b6937d5a1eb14589d1e361642458=
cc2fbd296ac031d099df49a53e8f0d4506b2dcbb20f54560b695a4e0a4a5a13231985d53bb3=
533126add281fd38cddf7ef437201e8aea1ab63ad673cdcc6c604114aec771881b4fb7aa7cc=
bd397e703f10895619e15c71684bbbfa2b2c60a790de0e5059538b51d347a68ad057472a9f1=
eaf054df7791b58f638c059555bbb970edf877d5f623e2541dba27df8d713fe7c55f40fbf3d=
bdc3d042e92b83f94dd66d1cd2bc5cc98a6a502b5d8d8ee6efecacfb762464c6f8cea8bdad1=
4a29199928e0cb07fbc306b9eeccc4c7a326185254414892b614ddcc20e9b5d258e66271430=
c0705c5a622fa5646da4897a088f68fdeb66842ad3d72f232f487b3db3b83d82622c91daf77=
9634fa1b97c7d5adb5d53be5198bc59aef1aab60c3795296a84ac3f77399feed5b86f44b3a1=
ca35ee46891ee903a90340883cec41d577a8880945b504c7ea5bdc94d66bf25b4d2e064bd69=
dfce4f00f8dfade0739fab5275db11e999b25622c20ca0a9f10f27c800a4f5d19aa92d04cd2=
82f96e990301874c5ddcfb13223c4f5fd37c449adde532a16aee66407bfeeeebda4f513f224=
e434a9c08a2281d5e1f4591c9a433ab1576c11edd0df9fb6f47b761fc878d532d7fc2a76246=
1fd1473eb7c7c88668b749b9bbf43c937fa2bd73ae917ea2a903bf5f7d71ae1c7d71c60def1=
bbc4e8151bee5f4a396325907f4f2bcbe98038e46bc9fb30d199f025eabeb037ceaec3ee187=
f73a136b8566a943d5b3271199e6d19b7066d90b10d0c11e7cb0c0b5f73127cd685a7638b99=
a1c9aea4fbf3fac67a4b114ca9fa60d2c9c24723b037142e3e47503f3dfdffc487212090d22=
1eb85f53cf6176c26b93c757b521d017ca17ac7889c26c6473fb44cc2ab79cd76fbf8fc5a81=
dc24bd7ba6d55d8036f4d60218e7c8fdf7f3b915efd0bd0edfac380e3717794ab46b2a5daed=
58fdb3ea66720c0e78a0ce825b155ebc0979cf77915db3df600bbd179f1d2d674d76b12aff0=
87757d4aa480ee1566784074a5287be0088efbe12f550bad3b410cf04fba8f06d1120a1dad3=
5de9c7a22c3caf83c1bf6ea57a055afcbc61b068feb5d17f5d0cd9e5911d2d9c8c6ff89fc37=
725a4b9ac3a8800d1731199c8201c0522e9af749fe36e14194310a5aafd944c321efb4ecf5c=
131ccf9de48c8b36a905f47eba8fb42ce435d1bd408dc87b1c91577ffba16e32b9be21982d3=
176320c8e23799b6c5cc3d834ccbe9aceda70bd2c73a154137acdd65f4191e4470893eb24e4=
ab00700c2c135149fb86644b5ac0be1669288b9c29a1f6f61517d8b4f09616e767bd72d13f8=
33"}, 0x1009, 0x3)
>
> and see also in https://gist.github.com/xrivendell7/fdc7fa3a7b55a91746669=
44c07732eec
>
> I hope it helps.
> Best regards

