Return-Path: <linux-fsdevel+bounces-14953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B5885530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE981F2104E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF685820A;
	Thu, 21 Mar 2024 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtK8LtCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9156B8B;
	Thu, 21 Mar 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007561; cv=none; b=ghMDWv0JmU7FIj0ibxvo5TBm3qDIMbsXU+kmrVselAH/cJGI4pEJdk3ntPANZ5ffb/KgAiMcTMlB07PKOQFrguYyvBFP7SUqv89yU3mfXoD4d9+UAHukjn7BkR0UEXNkpXlrOOC+9FvRZbCAWgAHkFJ6fNR1RGDsdxavGWuAP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007561; c=relaxed/simple;
	bh=ikyLJhFNSfpTPQwmoghzzzs78xD98IsmzrkOBMplNss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QRxtAYJzfqHskZKI+IJHVPKQHMb5ApoPL4pEEafUEwVyDGNecv/aPF8qR2muQDvlZ6xbvGOzyn/lZFBsaAbwLOhHRo/MR8fM4xPHLKHiwqWOlCK/L5nhXjct6hV2Pw11ubzLK+VlhZrMuatyzyVl4s+map0Amf7NYJ336VR7hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtK8LtCx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e704078860so575806b3a.0;
        Thu, 21 Mar 2024 00:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007559; x=1711612359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rgEl/WsFIni8VjXWeady1tpoD9wZSmpZIdYRdj57m+E=;
        b=jtK8LtCxqm8HJRBMVYBmahobM3cl0Ze4alHokCepEsJRwFWWZsAjJ9Iuy4Vo1+07Qx
         jgnAgmLFcFhMYF1vbHJ+M8XjwKoMPVP1baBIQgMgc8CTIqxlNwr5N5CXbhptc3ds0vs0
         tsZ7M+mdThUQBM41nNRxL4tkpe9rWHomhyPZGj9Lc/GIm7bmFQY0XoV7jguicBa0rsxg
         dIVZ18ijUYd3obdcVgrsBeiw0BxzT/v4JqwovDOolg2/pd4/Yx68NraA/CrkG2dtwnWH
         WXms1SJ8+FCXn9duDhJZG2Csxqsw0MUP9LhhoFk+vVZ8uoiW8DHe9Fu6QEXbXpeSulYZ
         LYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007559; x=1711612359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgEl/WsFIni8VjXWeady1tpoD9wZSmpZIdYRdj57m+E=;
        b=YduxjagYAa3hFiFmzz6moWv5WeVYOI5ZOTMRp2uoaegonrwB+3ZNIwJPRu24eLSRgB
         TO26s8E2gLKVdPpzIAzR2LA941KeJW1QGiki2O5DurzLgE+Hs7JdaLNN0rofsGvSSgAh
         TD6E2IqIferTmlKvoxUxsLY8anjCG6kK3L1WdHK0eBub6Rz5GC3oV8kfZr70iNAisdHP
         kCkD8PC47Q1DD/3t39kGrQNP29zqp7G4BXRadmZLL453QY/eYNvS1k1DJ6YRylfu1MfI
         Vm/wi1lvFoAEiNW5JxgfoDFhMfHEx3f3GdhT5ZKhtBQqW/UdrE4hj5229HfcgPLyKZQW
         VV2Q==
X-Gm-Message-State: AOJu0YwJ8hISN5VYOPhVk2m0hhpU3Gce0kM/KNZSTHqZpbnJUP8pi/6s
	8UI3STJkWwHxEUCRul9pa7mD/NtfyqJi+gS2QkOFZrzSp1UOdfRoAueuoWkLaYNMFZ8gYbkjBMH
	aAO0s7Nktbc0kfnv+lJOdz233tpx6vXRFS88qlw==
X-Google-Smtp-Source: AGHT+IF/e5/abMI/HQIGf4yjarIFARE1eh8E6vikXCABiZ3vlA0RFcc6/93a68CZXfefysRSzffMskQLW5HRTMbABiU=
X-Received: by 2002:a17:90a:f697:b0:29c:75c6:450c with SMTP id
 cl23-20020a17090af69700b0029c75c6450cmr16386925pjb.49.1711007558563; Thu, 21
 Mar 2024 00:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Thu, 21 Mar 2024 15:52:27 +0800
Message-ID: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in fuse_copy_do
To: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc: linux-kernel@vger.kernel.org, samsun1006219@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello I found a bug titled "BUG: unable to handle kernel paging
request in fuse_copy_do=E2=80=9D with modified syzkaller, and maybe it is
related to fs/fuse.
I also confirmed in the latest upstream.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

kernel: upstream 23956900041d968f9ad0f30db6dede4daccd7aa9
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D9f=
47e8dfa53b0b11
with KASAN enabled
compiler: gcc (Debian 12.2.0-14) 12.2.0

BUG: unable to handle kernel paging request in fuse_copy_do
UDPLite: UDP-Lite is deprecated and scheduled to be removed in 2025,
please contact the netdev mailing list
BUG: unable to handle page fault for address: ffff88802c29c000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 13001067 P4D 13001067 PUD 13002067 PMD 24c8d063 PTE 800fffffd3d63060
Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 8221 Comm: 1e9 Not tainted 6.8.0-05202-g9187210eee7d-dirty #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f80
RSP: 0018:ffffc9001065f9c8 EFLAGS: 00010246
RAX: ffffc9001065fb10 RBX: ffffc9001065fc78 RCX: 0000000000000010
RDX: 0000000000000010 RSI: ffff88802c29c000 RDI: ffffc9001065fb10
RBP: 0000000000000010 R08: ffff88802c29c000 R09: 0000000000000001
R10: ffffffff8ea82ed7 R11: ffffc9001065fd98 R12: ffffc9001065fac0
R13: 0000000000000010 R14: ffffc9001065faf0 R15: ffffc9001065fcbc
FS: 000000000f82d480(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88802c29c000 CR3: 000000002dd7c000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
fuse_copy_do+0x152/0x340 fs/fuse/dev.c:758
fuse_copy_one fs/fuse/dev.c:1007 [inline]
fuse_dev_do_write+0x1df/0x26a0 fs/fuse/dev.c:1863
fuse_dev_write+0x129/0x1b0 fs/fuse/dev.c:1960
call_write_iter include/linux/fs.h:2108 [inline]
new_sync_write fs/read_write.c:497 [inline]
vfs_write+0x62e/0x10a0 fs/read_write.c:590
ksys_write+0xf6/0x1d0 fs/read_write.c:643
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x7c/0x1d0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x6c/0x74

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
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#ifndef __NR_memfd_secret
#define __NR_memfd_secret 447
#endif

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
     if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=
=3D 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
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

uint64_t r[3] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffff=
ff};

void execute_one(void) {
 intptr_t res =3D 0;
 NONFAILING(memcpy((void*)0x20002040, "./file0\000", 8));
 syscall(__NR_mkdirat, /*fd=3D*/0xffffff9c, /*path=3D*/0x20002040ul, /*mode=
=3D*/0ul);
 NONFAILING(memcpy((void*)0x20002080, "/dev/fuse\000", 10));
 res =3D syscall(__NR_openat, /*fd=3D*/0xffffffffffffff9cul, /*file=3D*/0x2=
0002080ul,
               /*flags=3D*/2ul, /*mode=3D*/0ul);
 if (res !=3D -1)
   r[0] =3D res;
 NONFAILING(memcpy((void*)0x200020c0, "./file0\000", 8));
 NONFAILING(memcpy((void*)0x20002100, "fuse\000", 5));
 NONFAILING(memcpy((void*)0x20002140, "fd", 2));
 NONFAILING(*(uint8_t*)0x20002142 =3D 0x3d);
 NONFAILING(sprintf((char*)0x20002143, "0x%016llx", (long long)r[0]));
 NONFAILING(*(uint8_t*)0x20002155 =3D 0x2c);
 NONFAILING(memcpy((void*)0x20002156, "rootmode", 8));
 NONFAILING(*(uint8_t*)0x2000215e =3D 0x3d);
 NONFAILING(sprintf((char*)0x2000215f, "%023llo", (long long)0x4000));
 NONFAILING(*(uint8_t*)0x20002176 =3D 0x2c);
 NONFAILING(memcpy((void*)0x20002177, "user_id", 7));
 NONFAILING(*(uint8_t*)0x2000217e =3D 0x3d);
 NONFAILING(sprintf((char*)0x2000217f, "%020llu", (long long)0));
 NONFAILING(*(uint8_t*)0x20002193 =3D 0x2c);
 NONFAILING(memcpy((void*)0x20002194, "group_id", 8));
 NONFAILING(*(uint8_t*)0x2000219c =3D 0x3d);
 NONFAILING(sprintf((char*)0x2000219d, "%020llu", (long long)0));
 NONFAILING(*(uint8_t*)0x200021b1 =3D 0x2c);
 NONFAILING(*(uint8_t*)0x200021b2 =3D 0);
 syscall(__NR_mount, /*src=3D*/0ul, /*dst=3D*/0x200020c0ul, /*type=3D*/0x20=
002100ul,
         /*flags=3D*/0ul, /*opts=3D*/0x20002140ul);
 res =3D syscall(__NR_memfd_secret, /*flags=3D*/0ul);
 if (res !=3D -1)
   r[1] =3D res;
 syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0xb36000ul,
         /*prot=3DPROT_GROWSUP|PROT_READ*/ 0x2000001ul,
         /*flags=3DMAP_STACK|MAP_POPULATE|MAP_FIXED|MAP_SHARED*/ 0x28011ul,
         /*fd=3D*/r[1], /*offset=3D*/0ul);
 syscall(__NR_ftruncate, /*fd=3D*/r[1], /*len=3D*/7ul);
 res =3D syscall(__NR_socket, /*domain=3D*/2ul, /*type=3D*/2ul, /*proto=3D*=
/0x88);
 if (res !=3D -1)
   r[2] =3D res;
 NONFAILING(*(uint32_t*)0x20000280 =3D 0);
 syscall(__NR_getsockopt, /*fd=3D*/r[2], /*level=3D*/1, /*optname=3D*/0x11,
         /*optval=3D*/0ul, /*optlen=3D*/0x20000280ul);
 NONFAILING(*(uint32_t*)0x20000000 =3D 0x50);
 NONFAILING(*(uint32_t*)0x20000004 =3D 0);
 NONFAILING(*(uint64_t*)0x20000008 =3D 0);
 NONFAILING(*(uint32_t*)0x20000010 =3D 7);
 NONFAILING(*(uint32_t*)0x20000014 =3D 0x27);
 NONFAILING(*(uint32_t*)0x20000018 =3D 0);
 NONFAILING(*(uint32_t*)0x2000001c =3D 0);
 NONFAILING(*(uint16_t*)0x20000020 =3D 0);
 NONFAILING(*(uint16_t*)0x20000022 =3D 0);
 NONFAILING(*(uint32_t*)0x20000024 =3D 0);
 NONFAILING(*(uint32_t*)0x20000028 =3D 0);
 NONFAILING(*(uint16_t*)0x2000002c =3D 0);
 NONFAILING(*(uint16_t*)0x2000002e =3D 0);
 NONFAILING(memset((void*)0x20000030, 0, 32));
 syscall(__NR_write, /*fd=3D*/r[0], /*arg=3D*/0x20000000ul, /*len=3D*/0x50u=
l);
}
int main(void) {
 syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-=
1,
         /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
         /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
         /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-=
1,
         /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-=
1,
         /*offset=3D*/0ul);
 install_segv_handler();
 loop();
 return 0;
}

=3D* repro.txt =3D*
mkdirat(0xffffffffffffff9c, &(0x7f0000002040)=3D'./file0\x00', 0x0)
r0 =3D openat$fuse(0xffffffffffffff9c, &(0x7f0000002080), 0x2, 0x0)
mount$fuse(0x0, &(0x7f00000020c0)=3D'./file0\x00', &(0x7f0000002100),
0x0, &(0x7f0000002140)=3D{{'fd', 0x3d, r0}, 0x2c, {'rootmode', 0x3d,
0x4000}})
r1 =3D memfd_secret(0x0)
mmap(&(0x7f0000000000/0xb36000)=3Dnil, 0xb36000, 0x2000001, 0x28011, r1, 0x=
0)
ftruncate(r1, 0x7)
r2 =3D socket$inet_udplite(0x2, 0x2, 0x88)
getsockopt$sock_cred(r2, 0x1, 0x11, 0x0, &(0x7f0000000280))
write$FUSE_INIT(r0, &(0x7f0000000000)=3D{0x50}, 0x50)


see aslo https://gist.github.com/xrivendell7/961be96ae091c9671bb56efea902ce=
c4.

I hope it helps.
best regards.
xingwei Lee

