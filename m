Return-Path: <linux-fsdevel+bounces-13391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F986F4DC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 13:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55501C209E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FABC126;
	Sun,  3 Mar 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcnGmOvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FEB673;
	Sun,  3 Mar 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709469967; cv=none; b=aqlXRQ838f7gSQcaf9/2u+Cy1SadtjKljhlOYweB+kBdudqsJzCJWEVtRt9aldy5FekOofvp2LAyDwB7rWsQiWVgabe+6YdvjBb1HBy9PsY2DY+kGjo7apgGuSgKYraD2rZiEcwRABmjG8hQ6eiU7PU6vndTfuBSMKLVDVyZnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709469967; c=relaxed/simple;
	bh=hKWv1KKiQAWdhYrnuYl6wIaxmrLQFHBKHcc16kLTK0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJugRurPXcBiCOrIRjYtav7zd5vglNnuIz29CKnmrQDokiYNZSyuzBFrMvsOeskDrpmMjiWNIh5U3xMYbbHTKjJ0uRXnDY++zRPUssJGQCHwwLHhji5AucA7KBd/JsLF47AbdiXWbYDbBANiM65fYC8VbDxAFaJvtvHvwYo//30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcnGmOvS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51323dfce59so2970607e87.3;
        Sun, 03 Mar 2024 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709469963; x=1710074763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njJtaw7fZc5MD51GPH6nl4AATiJ39bEmqc+0wePymdY=;
        b=HcnGmOvS81+xbXr+iHP6PL6BhUB3OWWn9dM4Q8/uCXihXMwKCmxPUqwneSlEGQ9oq/
         Cn0SV1SFt5lcYjdfC+DGXiFrUqKSpo0nbMzc/0HUdUcP5lteWY0N9yMa8pZyg+R+1Wq4
         +a9GsH1Lx/CNgJGjBc8AmM9wxMypELtGJPbDot29ALw2KBI0MZqk1bqedEpRqaSPeSN6
         LUB8+5uDicMhI8NBtQpBmCTag6sB2frjYowaxfIgy+kLkK7RnLkxOkz1griM6C/5OpFm
         b9PUymKbF55lKZg3c4zVl1wVMrgkuUy3BvmLFFs4XuzCX2UfOvJapXxnYvmmrU4N0RWl
         tCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709469963; x=1710074763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njJtaw7fZc5MD51GPH6nl4AATiJ39bEmqc+0wePymdY=;
        b=dP7tgA14HuSOlG9Mc8awkry39lOh8oJSdycTD0egesrpvla7h1sdCr8O+D5ykxrqN/
         c8RLROnyKz28gCzy0Ae8DmNTu9e2sGpmExEM3Rag2zkGuLb4uxTbpuqUmefiUwPKQlVo
         GjoDhlqja/nuOzoM81skQATW7s+WNTBI5NvalV9ruRTpusqLkQc4HXYpF9RYLXKeR5K8
         C+62VaXGzVpxWOdE6fjvy5xBMGIXrRCbOmwFGAF+eJUw6qSh5XimozXqaH+IHC4G7ec5
         DdI/aq8ET28yNAMSUirAR2iwS7RHAtyR0TFWQQEgwPp/KrI6MjT6KcB9vhft0lS2aH/d
         IuXA==
X-Forwarded-Encrypted: i=1; AJvYcCVWYThleDDS1uTFjheQdNbif3NP+4evdw39gXI4F7GzVCNk8UjXYjPU+MpY/K7/5ps/vYRlOaQk+j9fIpeM6MImjVEFouIp7zNXJKZFlAgtoexNKrPra00T+2KZf2GWx74wkk5tF/3obU8uffzFDspG2/ZGWe4YJSXzSyPKEbF1UI3LuQr9ZcBM
X-Gm-Message-State: AOJu0YwbSmQB7FDKCoc4jTFqv+kl0BvKDEsiastvra0xwllO9oiggogC
	2nKyJTmeAUBYYH2iJvYYZUhfea44eTFvJeRVafGJN+xSNRPn+OqTShU2uMdfB++J0WzjoFqGswv
	0zw745X6f2+3Ox2H/8IrXB7mUMO8=
X-Google-Smtp-Source: AGHT+IEHi1Ic+aigkFI7sQHD0WHozpTeOgdSGxUoXt6lsi4ZQ90QcKeyWAPdgcB3mQ1YrkKpCE29MnOeTVMFa1ELYYQ=
X-Received: by 2002:a05:6512:2fb:b0:512:99a3:62eb with SMTP id
 m27-20020a05651202fb00b0051299a362ebmr4239688lfq.54.1709469962514; Sun, 03
 Mar 2024 04:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLz8V-CMiZK0Gzz=eXf2G3E-psemp2pMZwZ_XJG53GawgA@mail.gmail.com>
In-Reply-To: <CABOYnLz8V-CMiZK0Gzz=eXf2G3E-psemp2pMZwZ_XJG53GawgA@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 3 Mar 2024 21:45:45 +0900
Message-ID: <CAKFNMomdU5RHVMt2CCXYMAb5oyjDwOVRitNM+XGGC65TQs1ECQ@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs
 (2)
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 2:46=E2=80=AFPM xingwei lee wrote:
>
> Hello, I reproduced this bug.
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
>
> Notice: I use the same config with syzbot dashboard.
> kernel version: e326df53af0021f48a481ce9d489efda636c2dc6
> kernel config: https://syzkaller.appspot.com/x/.config?x=3De0c7078a6b901a=
a3
> with KMSAN enabled
> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2=
.40
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
> BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
> BUG: KMSAN: uninit-value in crc32_le_base+0x475/0xe70 lib/crc32.c:197
> crc32_body lib/crc32.c:110 [inline]
> crc32_le_generic lib/crc32.c:179 [inline]
> crc32_le_base+0x475/0xe70 lib/crc32.c:197
> nilfs_segbuf_fill_in_data_crc fs/nilfs2/segbuf.c:224 [inline]
> nilfs_add_checksums_on_logs+0xcb2/0x10a0 fs/nilfs2/segbuf.c:327
> nilfs_segctor_do_construct+0xad1d/0xf640 fs/nilfs2/segment.c:2112
> nilfs_segctor_construct+0x1fd/0xf30 fs/nilfs2/segment.c:2415
> nilfs_segctor_thread_construct fs/nilfs2/segment.c:2523 [inline]
> nilfs_segctor_thread+0x551/0x1350 fs/nilfs2/segment.c:2606
> kthread+0x422/0x5a0 kernel/kthread.c:388
> ret_from_fork+0x7f/0xa0 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> Uninit was created at:
> __alloc_pages+0x9a8/0xe00 mm/page_alloc.c:4591
> alloc_pages_mpol+0x6b3/0xaa0 mm/mempolicy.c:2133
> alloc_pages mm/mempolicy.c:2204 [inline]
> folio_alloc+0x218/0x3f0 mm/mempolicy.c:2211
> filemap_alloc_folio+0xb8/0x4b0 mm/filemap.c:974
> __filemap_get_folio+0xa8a/0x1910 mm/filemap.c:1918
> pagecache_get_page+0x56/0x1d0 mm/folio-compat.c:99
> grab_cache_page_write_begin+0x61/0x80 mm/folio-compat.c:109
> block_write_begin+0x5a/0x4a0 fs/buffer.c:2223
> nilfs_write_begin+0x107/0x220 fs/nilfs2/inode.c:261
> generic_perform_write+0x417/0xce0 mm/filemap.c:3927
> __generic_file_write_iter+0x233/0x4b0 mm/filemap.c:4022
> generic_file_write_iter+0x10e/0x600 mm/filemap.c:4048
> __kernel_write_iter+0x365/0xa00 fs/read_write.c:523
> dump_emit_page fs/coredump.c:888 [inline]
> dump_user_range+0x5d7/0xe00 fs/coredump.c:915
> elf_core_dump+0x5847/0x5fa0 fs/binfmt_elf.c:2077
> do_coredump+0x3bb6/0x4e60 fs/coredump.c:764
> get_signal+0x28f7/0x30b0 kernel/signal.c:2890
> arch_do_signal_or_restart+0x5e/0xda0 arch/x86/kernel/signal.c:309
> exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
> exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> irqentry_exit_to_user_mode+0xaa/0x160 kernel/entry/common.c:225
> irqentry_exit+0x16/0x40 kernel/entry/common.c:328
> exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1566
> asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570
> CPU: 1 PID: 11178 Comm: segctord Not tainted 6.7.0-00562-g9f8413c4a66f-di=
rty #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.2-debian-1.16.2-1 04/01/2014
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> =3D* repro.c =3D*
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <sched.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/resource.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>
> #include <linux/capability.h>
>
> static void sleep_ms(uint64_t ms)
> {
>  usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void)
> {
>  struct timespec ts;
>  if (clock_gettime(CLOCK_MONOTONIC, &ts))
>    exit(1);
>  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>
> static bool write_file(const char* file, const char* what, ...)
> {
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
> #define MAX_FDS 30
>
> static void setup_common()
> {
>  if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
>  }
> }
>
> static void setup_binderfs()
> {
>  if (mkdir("/dev/binderfs", 0777)) {
>  }
>  if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
>  }
>  if (symlink("/dev/binderfs", "./binderfs")) {
>  }
> }
>
> static void loop();
>
> static void sandbox_common()
> {
>  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>  setsid();
>  struct rlimit rlim;
>  rlim.rlim_cur =3D rlim.rlim_max =3D (200 << 20);
>  setrlimit(RLIMIT_AS, &rlim);
>  rlim.rlim_cur =3D rlim.rlim_max =3D 32 << 20;
>  setrlimit(RLIMIT_MEMLOCK, &rlim);
>  rlim.rlim_cur =3D rlim.rlim_max =3D 136 << 20;
>  setrlimit(RLIMIT_FSIZE, &rlim);
>  rlim.rlim_cur =3D rlim.rlim_max =3D 1 << 20;
>  setrlimit(RLIMIT_STACK, &rlim);
>  rlim.rlim_cur =3D rlim.rlim_max =3D 128 << 20;
>  setrlimit(RLIMIT_CORE, &rlim);
>  rlim.rlim_cur =3D rlim.rlim_max =3D 256;
>  setrlimit(RLIMIT_NOFILE, &rlim);
>  if (unshare(CLONE_NEWNS)) {
>  }
>  if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
>  }
>  if (unshare(CLONE_NEWIPC)) {
>  }
>  if (unshare(0x02000000)) {
>  }
>  if (unshare(CLONE_NEWUTS)) {
>  }
>  if (unshare(CLONE_SYSVSEM)) {
>  }
>  typedef struct {
>    const char* name;
>    const char* value;
>  } sysctl_t;
>  static const sysctl_t sysctls[] =3D {
>      {"/proc/sys/kernel/shmmax", "16777216"},
>      {"/proc/sys/kernel/shmall", "536870912"},
>      {"/proc/sys/kernel/shmmni", "1024"},
>      {"/proc/sys/kernel/msgmax", "8192"},
>      {"/proc/sys/kernel/msgmni", "1024"},
>      {"/proc/sys/kernel/msgmnb", "1024"},
>      {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
>  };
>  unsigned i;
>  for (i =3D 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
>    write_file(sysctls[i].name, sysctls[i].value);
> }
>
> static int wait_for_loop(int pid)
> {
>  if (pid < 0)
>    exit(1);
>  int status =3D 0;
>  while (waitpid(-1, &status, __WALL) !=3D pid) {
>  }
>  return WEXITSTATUS(status);
> }
>
> static void drop_caps(void)
> {
>  struct __user_cap_header_struct cap_hdr =3D {};
>  struct __user_cap_data_struct cap_data[2] =3D {};
>  cap_hdr.version =3D _LINUX_CAPABILITY_VERSION_3;
>  cap_hdr.pid =3D getpid();
>  if (syscall(SYS_capget, &cap_hdr, &cap_data))
>    exit(1);
>  const int drop =3D (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
>  cap_data[0].effective &=3D ~drop;
>  cap_data[0].permitted &=3D ~drop;
>  cap_data[0].inheritable &=3D ~drop;
>  if (syscall(SYS_capset, &cap_hdr, &cap_data))
>    exit(1);
> }
>
> static int do_sandbox_none(void)
> {
>  if (unshare(CLONE_NEWPID)) {
>  }
>  int pid =3D fork();
>  if (pid !=3D 0)
>    return wait_for_loop(pid);
>  setup_common();
>  sandbox_common();
>  drop_caps();
>  if (unshare(CLONE_NEWNET)) {
>  }
>  write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
>  setup_binderfs();
>  loop();
>  exit(1);
> }
>
> static void kill_and_wait(int pid, int* status)
> {
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
> static void setup_test()
> {
>  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>  setpgrp();
>  write_file("/proc/self/oom_score_adj", "1000");
> }
>
> static void close_fds()
> {
>  for (int fd =3D 3; fd < MAX_FDS; fd++)
>    close(fd);
> }
>
> #define USLEEP_FORKED_CHILD (3 * 50 * 1000)
>
> static long handle_clone_ret(long ret)
> {
>  if (ret !=3D 0) {
>    return ret;
>  }
>  usleep(USLEEP_FORKED_CHILD);
>  syscall(__NR_exit, 0);
>  while (1) {
>  }
> }
>
> static long syz_clone(volatile long flags, volatile long stack,
>                      volatile long stack_len, volatile long ptid,
>                      volatile long ctid, volatile long tls)
> {
>  long sp =3D (stack + stack_len) & ~15;
>  long ret =3D (long)syscall(__NR_clone, flags & ~CLONE_VM, sp, ptid, ctid=
, tls);
>  return handle_clone_ret(ret);
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void)
> {
>  int iter =3D 0;
>  for (;; iter++) {
>    int pid =3D fork();
>    if (pid < 0)
>      exit(1);
>    if (pid =3D=3D 0) {
>      setup_test();
>      execute_one();
>      close_fds();
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
> void execute_one(void)
> {
>  syz_clone(/*flags=3DCLONE_IO*/ 0x80000000, /*stack=3D*/0x20000140,
>            /*stack_len=3D*/0, /*parentid=3D*/0, /*childtid=3D*/0, /*tls=
=3D*/0);
> }
> int main(void)
> {
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
>  do_sandbox_none();
>  return 0;
> }
>
>
> Remember to run this repro.txt with the command: syz-execprog -repeat
> 0 ./repro.txt and wait for about 1minus, the bug triggered very
> steady.
>
> =3D* repro.txt =3D*
> syz_mount_image$nilfs2(&(0x7f0000000000),
> &(0x7f0000000a80)=3D'./file0\x00', 0x808, &(0x7f00000000c0)=3DANY=3D[], 0=
x1,
> 0xa4a, &(0x7f0000001540)=3D"$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
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAYmonm34WFmVpKl956/ejTx0/P3VxyuFWi0fw71Zaqt56X0mM5nszxL/K=
D6x++crI9vpHjWppPtVRrLU9PXWvVtDWldD7tTZdTI+2+dOW1d+afPH7h2MV9775x6OqdewcAAA=
Bg4/t/AAAA//+wuA6E")
> r0 =3D open(&(0x7f0000000000)=3D'./bus\x00', 0x0, 0x0) (async)
> r1 =3D open(&(0x7f0000007f80)=3D'./bus\x00', 0x145142, 0x0)
> cachestat(r1, &(0x7f00000002c0)=3D{0x6}, &(0x7f0000000300), 0x0) (async)
> r2 =3D syz_open_procfs(0xffffffffffffffff,
> &(0x7f0000000100)=3D'mountinfo\x00') (async)
> r3 =3D open(&(0x7f0000000a40)=3D'./bus\x00', 0x141a42, 0x0)
> r4 =3D openat$adsp1(0xffffffffffffff9c, &(0x7f0000000040), 0x20000, 0x0) =
(async)
> ptrace(0x10, 0x0) (async)
> r5 =3D syz_clone(0x80000000,
> &(0x7f0000000140)=3D"1d7f3ef3f0b0129f8d083226510ecc0713b2af6e7901a607532f=
a2a7176fefdd7e66e6402ef8b579a00dd83d555182afa044f65b0ac668c2063ac33b34bb484=
11c11d456d584ec4140aebe97e1950ad7c4bd2bffcef175625a27a11f559e8ddb031d27c2be=
3a2216a1e9f87f5d68b8b0b690e67bfcc8a8ec9af998c1a8eaef215c771e45eee015e8ce9b1=
7015da79c48a7b87459c4a88781ffd9d1ec6870c4d7220ffc6a66f7828db1297aa12e00503d=
de7a5c",
> 0xb3, &(0x7f0000000080), &(0x7f00000000c0),
> &(0x7f0000000200)=3D"994665d2b9d5239b789d65f6ec184c1ea67003ce8f474755e439=
f58560c42a241a31e540479e0752cad17884d9024cb854dc6798ada62550c8264b5488daff5=
387419b22f01fa57630317e8c24ac37d892d70e380b7164dfaa886b72a17f08df76c1057a22=
68b39aad4e0e759eef1abc6e5e664e7f3057c1d70d897ba5104664e96d92c1d8bd420f78368=
f522169f713ed03315d69de28d77af27ec8881f54633a5dd5d54635e74ad8c896918c")
> fcntl$setown(r4, 0x8, r5) (async)
> sendfile(r3, r2, 0x0, 0x100800001) (async)
> sendfile(r0, r1, 0x0, 0x1000000201003)
>
>
> and see also in
> https://gist.github.com/xrivendell7/744812c87156085e12c7f617ef237875.
> BTW, found in my personal observation, the syzlang reproducer can
> trigger the bug more stably, so try to use the syz-execprog -repeat 0
> ./repro.txt to trigger this bug.
>
> I hope it helps.
> Best regards!
> xingwei Lee

Hi,

Please let me know if you can test one.

Does this issue still appear on 6.8-rc4 or later?

I'd like to isolate that the issue is still not fixed with the latest
fixes, but I need to do some trial and error to reestablish a testable
(bootable) KMSAN-enabled kernel config.

Thanks,
Ryusuke Konishi

