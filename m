Return-Path: <linux-fsdevel+bounces-15080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C621886DC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12175282B57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD845C0B;
	Fri, 22 Mar 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="poirUGmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5123FB02
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115416; cv=none; b=DOAlSvcI7ThxhE8wICSWagJtLVJ3bPYD6Q5Kb7PcvmPvV1ftPioPQAsjUiihHD8gdGTObTz6gmdixDqSjOL7swjCr4e8dq+zO88DlvRPojklBF605RC1Ratyei58c/LXptpqvikapDDMqkuOMS1MRQwpV88HJC8nC0iKbl1nwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115416; c=relaxed/simple;
	bh=3AZwCrdcIZm0qEnqncJb7rVYWnBlgbDLm6TWhzUGcYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiCMNPNfYOR/k95/GhChpBXl8VSRgCEuOM0Hri6kdBEJQY7rAEDLH0Htp9hBsnF8FyUEALmbjYBCdaFjh+nq3abZd3LIiwwzI+4a5MBBW0eMEg1RFK63cInlGnnu1T2e6vRkb5AV4EpCwUWAv1elK/UixPTC8Jst+3LitBcHYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=poirUGmF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso2530154a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1711115412; x=1711720212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkZwYW1x8hAeDEGw4dZn8NexEscs9uzCXC+/VkZnbns=;
        b=poirUGmFvkjtR+tInNDVFoYMjY+Fwmj68p8VVJM9N7LLeaYHqezhqaNTJzixCddjVP
         tFaIFtzOznXSJXwHx3jefeCYfMbOXriyKHm+n+3BXV5tS0GlWtL1tYpZBnYN4LYSAscb
         5VMyIdIx2cnJ7hSTyx+/J6bxoOQkwwWMSL1N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711115412; x=1711720212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkZwYW1x8hAeDEGw4dZn8NexEscs9uzCXC+/VkZnbns=;
        b=vSnNoNjvtLeudbql80KL3XEqxAHSHUvwwqPzME9v1zS2GrUFHJuNQJeCg+/b7yK5VX
         lK+g2YIz9MVKXVA3jlTu+6XRXJytFJPHEdRfGjr/Ged8TfvhFLtkipVtNEhcx+0TwfOs
         FboF3scAUtaQ0HzV7loFjCg/IUVgvIFeJwQVyLW0BftWoJ0M+A+cXhCLeCUgHfmpSGwr
         PSlU6d3H/GQgthjvwQ6RCOwV8tS2ygE9c15SDESfdg2Rllv9x4bHCSf97CsagiR7V8YD
         jGYFJYFDCFsL9i56ecWmEAWl1nGGxQ1gEEYMXkOxYAHgAW2EVxPTQ3plK3K4z15plgPT
         XcDA==
X-Gm-Message-State: AOJu0Ywk84ZdR2oux2Ans+77WIHc7FKcG+xUrJm5tYJaX8rGAi8an/ye
	XqDCl8pW9lnOnpybGxzsg+bSxX4BRT7q7j6y8RAhLR4MHv5x2ieyYvo1sdjrs51YJAervjNcJro
	G/vWglS+aO1N8FO4FnQV/BdsYyTEuK8G3DBA7aQ==
X-Google-Smtp-Source: AGHT+IFly4Se58rI+cpJ872lvRSexuaNURyf3sHFRMK/rOwMzHxGLYlZrlpwWbgmVRqgp1EOClkoEV/lLsFyUXLz/XU=
X-Received: by 2002:a17:906:b41:b0:a47:35d9:2efc with SMTP id
 v1-20020a1709060b4100b00a4735d92efcmr872351ejg.56.1711115411935; Fri, 22 Mar
 2024 06:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
In-Reply-To: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 22 Mar 2024 14:50:00 +0100
Message-ID: <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
To: xingwei lee <xrivendell7@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samsun1006219@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-mm <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[MM list + secretmem author CC-d]

On Thu, 21 Mar 2024 at 08:52, xingwei lee <xrivendell7@gmail.com> wrote:
>
> Hello I found a bug titled "BUG: unable to handle kernel paging
> request in fuse_copy_do=E2=80=9D with modified syzkaller, and maybe it is
> related to fs/fuse.
> I also confirmed in the latest upstream.
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>

Thanks for the report.   This looks like a secretmem vs get_user_pages issu=
e.

I reduced the syz reproducer to a minimal one that isn't dependent on fuse:

=3D=3D=3D repro.c =3D=3D=3D
#define _GNU_SOURCE

#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/socket.h>

int main(void)
{
        int fd1, fd2, fd3;
        int pip[2];
        struct iovec iov;
        void *addr;

        fd1 =3D syscall(__NR_memfd_secret, 0);
        addr =3D mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd1, 0);
        ftruncate(fd1, 7);
        fd2 =3D socket(AF_INET, SOCK_DGRAM, 0);
        getsockopt(fd2, 0, 0, NULL, addr);

        pipe(pip);
        iov.iov_base =3D addr;
        iov.iov_len =3D 0x50;
        vmsplice(pip[1], &iov, 1, 0);

        fd3 =3D open("/tmp/repro-secretmem.test", O_RDWR | O_CREAT, 0x600);
        splice(pip[0], NULL, fd3, NULL, 0x50, 0);

        return 0;
}
=3D=3D=3D=3D=3D=3D=3D

Thanks,
Miklos

>
> kernel: upstream 23956900041d968f9ad0f30db6dede4daccd7aa9
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
9f47e8dfa53b0b11
> with KASAN enabled
> compiler: gcc (Debian 12.2.0-14) 12.2.0
>
> BUG: unable to handle kernel paging request in fuse_copy_do
> UDPLite: UDP-Lite is deprecated and scheduled to be removed in 2025,
> please contact the netdev mailing list
> BUG: unable to handle page fault for address: ffff88802c29c000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 13001067 P4D 13001067 PUD 13002067 PMD 24c8d063 PTE 800fffffd3d63060
> Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 8221 Comm: 1e9 Not tainted 6.8.0-05202-g9187210eee7d-dirty #2=
1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.2-1.fc38 04/01/2014
> RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
> Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f80
> RSP: 0018:ffffc9001065f9c8 EFLAGS: 00010246
> RAX: ffffc9001065fb10 RBX: ffffc9001065fc78 RCX: 0000000000000010
> RDX: 0000000000000010 RSI: ffff88802c29c000 RDI: ffffc9001065fb10
> RBP: 0000000000000010 R08: ffff88802c29c000 R09: 0000000000000001
> R10: ffffffff8ea82ed7 R11: ffffc9001065fd98 R12: ffffc9001065fac0
> R13: 0000000000000010 R14: ffffc9001065faf0 R15: ffffc9001065fcbc
> FS: 000000000f82d480(0000) GS:ffff88823bc00000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88802c29c000 CR3: 000000002dd7c000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
> <TASK>
> fuse_copy_do+0x152/0x340 fs/fuse/dev.c:758
> fuse_copy_one fs/fuse/dev.c:1007 [inline]
> fuse_dev_do_write+0x1df/0x26a0 fs/fuse/dev.c:1863
> fuse_dev_write+0x129/0x1b0 fs/fuse/dev.c:1960
> call_write_iter include/linux/fs.h:2108 [inline]
> new_sync_write fs/read_write.c:497 [inline]
> vfs_write+0x62e/0x10a0 fs/read_write.c:590
> ksys_write+0xf6/0x1d0 fs/read_write.c:643
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x7c/0x1d0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x6c/0x74
>
> =3D* repro.c =3D*
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <setjmp.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>
> #ifndef __NR_memfd_secret
> #define __NR_memfd_secret 447
> #endif
>
> static __thread int clone_ongoing;
> static __thread int skip_segv;
> static __thread jmp_buf segv_env;
>
> static void segv_handler(int sig, siginfo_t* info, void* ctx) {
>  if (__atomic_load_n(&clone_ongoing, __ATOMIC_RELAXED) !=3D 0) {
>    exit(sig);
>  }
>  uintptr_t addr =3D (uintptr_t)info->si_addr;
>  const uintptr_t prog_start =3D 1 << 20;
>  const uintptr_t prog_end =3D 100 << 20;
>  int skip =3D __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) !=3D 0;
>  int valid =3D addr < prog_start || addr > prog_end;
>  if (skip && valid) {
>    _longjmp(segv_env, 1);
>  }
>  exit(sig);
> }
>
> static void install_segv_handler(void) {
>  struct sigaction sa;
>  memset(&sa, 0, sizeof(sa));
>  sa.sa_handler =3D SIG_IGN;
>  syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
>  syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
>  memset(&sa, 0, sizeof(sa));
>  sa.sa_sigaction =3D segv_handler;
>  sa.sa_flags =3D SA_NODEFER | SA_SIGINFO;
>  sigaction(SIGSEGV, &sa, NULL);
>  sigaction(SIGBUS, &sa, NULL);
> }
>
> #define NONFAILING(...)                                  \
>  ({                                                     \
>    int ok =3D 1;                                          \
>    __atomic_fetch_add(&skip_segv, 1, __ATOMIC_SEQ_CST); \
>    if (_setjmp(segv_env) =3D=3D 0) {                        \
>      __VA_ARGS__;                                       \
>    } else                                               \
>      ok =3D 0;                                            \
>    __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST); \
>    ok;                                                  \
>  })
>
> static void sleep_ms(uint64_t ms) {
>  usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void) {
>  struct timespec ts;
>  if (clock_gettime(CLOCK_MONOTONIC, &ts))
>    exit(1);
>  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>
> static bool write_file(const char* file, const char* what, ...) {
>  char buf[1024];
>  va_list args;
>  va_start(args, what);
>  vsnprintf(buf, sizeof(buf), what, args);
>  va_end(args);
>  buf[sizeof(buf) - 1] =3D 0;
>  int len =3D strlen(buf);
>  int fd =3D open(file, O_WRONLY | O_CLOEXEC);
>  if (fd =3D=3D -1)
>    return false;
>  if (write(fd, buf, len) !=3D len) {
>    int err =3D errno;
>    close(fd);
>    errno =3D err;
>    return false;
>  }
>  close(fd);
>  return true;
> }
>
> static void kill_and_wait(int pid, int* status) {
>  kill(-pid, SIGKILL);
>  kill(pid, SIGKILL);
>  for (int i =3D 0; i < 100; i++) {
>    if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
>      return;
>    usleep(1000);
>  }
>  DIR* dir =3D opendir("/sys/fs/fuse/connections");
>  if (dir) {
>    for (;;) {
>      struct dirent* ent =3D readdir(dir);
>      if (!ent)
>        break;
>      if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =
=3D=3D 0)
>        continue;
>      char abort[300];
>      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>               ent->d_name);
>      int fd =3D open(abort, O_WRONLY);
>      if (fd =3D=3D -1) {
>        continue;
>      }
>      if (write(fd, abort, 1) < 0) {
>      }
>      close(fd);
>    }
>    closedir(dir);
>  } else {
>  }
>  while (waitpid(-1, status, __WALL) !=3D pid) {
>  }
> }
>
> static void setup_test() {
>  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>  setpgrp();
>  write_file("/proc/self/oom_score_adj", "1000");
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void) {
>  int iter =3D 0;
>  for (;; iter++) {
>    int pid =3D fork();
>    if (pid < 0)
>      exit(1);
>    if (pid =3D=3D 0) {
>      setup_test();
>      execute_one();
>      exit(0);
>    }
>    int status =3D 0;
>    uint64_t start =3D current_time_ms();
>    for (;;) {
>      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
>        break;
>      sleep_ms(1);
>      if (current_time_ms() - start < 5000)
>        continue;
>      kill_and_wait(pid, &status);
>      break;
>    }
>  }
> }
>
> uint64_t r[3] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffff=
ffff};
>
> void execute_one(void) {
>  intptr_t res =3D 0;
>  NONFAILING(memcpy((void*)0x20002040, "./file0\000", 8));
>  syscall(__NR_mkdirat, /*fd=3D*/0xffffff9c, /*path=3D*/0x20002040ul, /*mo=
de=3D*/0ul);
>  NONFAILING(memcpy((void*)0x20002080, "/dev/fuse\000", 10));
>  res =3D syscall(__NR_openat, /*fd=3D*/0xffffffffffffff9cul, /*file=3D*/0=
x20002080ul,
>                /*flags=3D*/2ul, /*mode=3D*/0ul);
>  if (res !=3D -1)
>    r[0] =3D res;
>  NONFAILING(memcpy((void*)0x200020c0, "./file0\000", 8));
>  NONFAILING(memcpy((void*)0x20002100, "fuse\000", 5));
>  NONFAILING(memcpy((void*)0x20002140, "fd", 2));
>  NONFAILING(*(uint8_t*)0x20002142 =3D 0x3d);
>  NONFAILING(sprintf((char*)0x20002143, "0x%016llx", (long long)r[0]));
>  NONFAILING(*(uint8_t*)0x20002155 =3D 0x2c);
>  NONFAILING(memcpy((void*)0x20002156, "rootmode", 8));
>  NONFAILING(*(uint8_t*)0x2000215e =3D 0x3d);
>  NONFAILING(sprintf((char*)0x2000215f, "%023llo", (long long)0x4000));
>  NONFAILING(*(uint8_t*)0x20002176 =3D 0x2c);
>  NONFAILING(memcpy((void*)0x20002177, "user_id", 7));
>  NONFAILING(*(uint8_t*)0x2000217e =3D 0x3d);
>  NONFAILING(sprintf((char*)0x2000217f, "%020llu", (long long)0));
>  NONFAILING(*(uint8_t*)0x20002193 =3D 0x2c);
>  NONFAILING(memcpy((void*)0x20002194, "group_id", 8));
>  NONFAILING(*(uint8_t*)0x2000219c =3D 0x3d);
>  NONFAILING(sprintf((char*)0x2000219d, "%020llu", (long long)0));
>  NONFAILING(*(uint8_t*)0x200021b1 =3D 0x2c);
>  NONFAILING(*(uint8_t*)0x200021b2 =3D 0);
>  syscall(__NR_mount, /*src=3D*/0ul, /*dst=3D*/0x200020c0ul, /*type=3D*/0x=
20002100ul,
>          /*flags=3D*/0ul, /*opts=3D*/0x20002140ul);
>  res =3D syscall(__NR_memfd_secret, /*flags=3D*/0ul);
>  if (res !=3D -1)
>    r[1] =3D res;
>  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0xb36000ul,
>          /*prot=3DPROT_GROWSUP|PROT_READ*/ 0x2000001ul,
>          /*flags=3DMAP_STACK|MAP_POPULATE|MAP_FIXED|MAP_SHARED*/ 0x28011u=
l,
>          /*fd=3D*/r[1], /*offset=3D*/0ul);
>  syscall(__NR_ftruncate, /*fd=3D*/r[1], /*len=3D*/7ul);
>  res =3D syscall(__NR_socket, /*domain=3D*/2ul, /*type=3D*/2ul, /*proto=
=3D*/0x88);
>  if (res !=3D -1)
>    r[2] =3D res;
>  NONFAILING(*(uint32_t*)0x20000280 =3D 0);
>  syscall(__NR_getsockopt, /*fd=3D*/r[2], /*level=3D*/1, /*optname=3D*/0x1=
1,
>          /*optval=3D*/0ul, /*optlen=3D*/0x20000280ul);
>  NONFAILING(*(uint32_t*)0x20000000 =3D 0x50);
>  NONFAILING(*(uint32_t*)0x20000004 =3D 0);
>  NONFAILING(*(uint64_t*)0x20000008 =3D 0);
>  NONFAILING(*(uint32_t*)0x20000010 =3D 7);
>  NONFAILING(*(uint32_t*)0x20000014 =3D 0x27);
>  NONFAILING(*(uint32_t*)0x20000018 =3D 0);
>  NONFAILING(*(uint32_t*)0x2000001c =3D 0);
>  NONFAILING(*(uint16_t*)0x20000020 =3D 0);
>  NONFAILING(*(uint16_t*)0x20000022 =3D 0);
>  NONFAILING(*(uint32_t*)0x20000024 =3D 0);
>  NONFAILING(*(uint32_t*)0x20000028 =3D 0);
>  NONFAILING(*(uint16_t*)0x2000002c =3D 0);
>  NONFAILING(*(uint16_t*)0x2000002e =3D 0);
>  NONFAILING(memset((void*)0x20000030, 0, 32));
>  syscall(__NR_write, /*fd=3D*/r[0], /*arg=3D*/0x20000000ul, /*len=3D*/0x5=
0ul);
> }
> int main(void) {
>  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=
=3D*/0ul,
>          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*=
/-1,
>          /*offset=3D*/0ul);
>  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
>          /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*=
/-1,
>          /*offset=3D*/0ul);
>  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=
=3D*/0ul,
>          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*=
/-1,
>          /*offset=3D*/0ul);
>  install_segv_handler();
>  loop();
>  return 0;
> }
>
> =3D* repro.txt =3D*
> mkdirat(0xffffffffffffff9c, &(0x7f0000002040)=3D'./file0\x00', 0x0)
> r0 =3D openat$fuse(0xffffffffffffff9c, &(0x7f0000002080), 0x2, 0x0)
> mount$fuse(0x0, &(0x7f00000020c0)=3D'./file0\x00', &(0x7f0000002100),
> 0x0, &(0x7f0000002140)=3D{{'fd', 0x3d, r0}, 0x2c, {'rootmode', 0x3d,
> 0x4000}})
> r1 =3D memfd_secret(0x0)
> mmap(&(0x7f0000000000/0xb36000)=3Dnil, 0xb36000, 0x2000001, 0x28011, r1, =
0x0)
> ftruncate(r1, 0x7)
> r2 =3D socket$inet_udplite(0x2, 0x2, 0x88)
> getsockopt$sock_cred(r2, 0x1, 0x11, 0x0, &(0x7f0000000280))
> write$FUSE_INIT(r0, &(0x7f0000000000)=3D{0x50}, 0x50)
>
>
> see aslo https://gist.github.com/xrivendell7/961be96ae091c9671bb56efea902=
cec4.
>
> I hope it helps.
> best regards.
> xingwei Lee

