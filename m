Return-Path: <linux-fsdevel+bounces-16438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6865189D950
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC021F23105
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247C12D772;
	Tue,  9 Apr 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk8kKTxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E0127B5A;
	Tue,  9 Apr 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666470; cv=none; b=M+snwaMySoJOiF97HK8wK9hkByTeb4Q4dxAXkPgN/9IrMq5XJY/MrSIQHS5jsZay8eB7uAcIuR/VRPmpUKhvTt7nm6ZZQuHa6zi/Hf5VMciMhx+Qx4krfQLw0LBvo9EgyJr3MeGOgY3MqGWfeE6f7d0k22Ry/Mg5xPIZH9gEZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666470; c=relaxed/simple;
	bh=PaDsjGmqUpwMR+SBldjI7yrsCquTJm6JdzTn68pSGwo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EJ/fUYmrbXcvxCNZFKZxFAnracPx6z+VQFr7p0FnVCNwW1KkgKjJNRPL4fg4BcvottvehND38zYBtJWTKeFhWt9kF756rSm3wmS1CiPFlYbX7jQDp2cms06Pj0e1uU6vbPkG18UbmAZp7BljZEwfB73PMCrDSeidwboxF4xEu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk8kKTxX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso3944641a91.0;
        Tue, 09 Apr 2024 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712666468; x=1713271268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fczrCrHlChOjIgZuQ4rgdQbC0Bo3jQJ4Cp2b4/A2Ebc=;
        b=Gk8kKTxXTB50OXY6NsrBySkbdHM9rfouRjTEZtKBo5p01hjSjBAIxTJvqOFLQjZYXP
         L+oyHhclVON6nHuuHLIcQnkojoArJx2OhMWBOCOTDlDxBElHJSxVYIR6/FFrNko7zv09
         GpfKmUwkxp/GsnZq0azbEtDwmWooD7vzyWXO4ONKazByeCXPJiL/Xv7Bk2kkOuZYLEsN
         5OSN/OHqnFLYE7v5ptlB2rmXw+Du4e4JYdXW0dNeZEuUb8jwyI8PxMYMgI69IkyOYkxj
         L62WuRUP9d8LVzlnaw/yB2WL/N6+wJnAOqa1LxymAqDUZ1ArJDTGuvcU2uJ+Cl0TLxOj
         Q0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712666468; x=1713271268;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fczrCrHlChOjIgZuQ4rgdQbC0Bo3jQJ4Cp2b4/A2Ebc=;
        b=MZxCDcH6+g2aM6mKVnbVsizkLJmyhMWG1UlElauoQ0Wh5L42Oc3OcOQKn7XAu32MiY
         zxPQxZvT5d/XzmAoxKaReP0AOt6eTVtLmXldflUdweJ90yupVYj0lj4nWaSh1N6A13UP
         fV6ndwBChGfgXm7JJm2xcWufGpTGPRBxyjJZ9/bLcvBJnrZhuxS6m5PUHLbpAr+16VSa
         o5aVozY0C8je0fURqtWN3sO1eVrqv/jqLG9qKjJ4loIp69O3xOeQuBtxIXTJDZB2A/ri
         NtE+57+PmKr5+X30OeDFSsBSKEELdQZ98fh/hsAFm/BTaOF2yH9Hr7BsKVNbOey+f7Ah
         fV2A==
X-Forwarded-Encrypted: i=1; AJvYcCWXjHpu1CKJwazqaE+iktyAEuoQb3EUDohAy7uAkhLgqk+M2p4zWnGqya/gmkh3ORB1fb0jfSwN6YSxcz7O2XRBKGpKwMfri+E3piSvK6lXCoQ4CA85Amx0rRO3sxf9sIwxgoBp4NkJPKXWaQ==
X-Gm-Message-State: AOJu0YyECdQUB0D3AKumIdREhI9WwS0iDZ0fcMgUIl8fQNyU5oGa3uYp
	eqRX0BrzFNojFmQSyGnCP/yd7yhgoN5XQgILf39suqyLeLr0nqG1LrNIZt46JWXoZII/fHsp81t
	8M2j+rLXfW/6N/g6cpo2Bta25pUU=
X-Google-Smtp-Source: AGHT+IExeLsIHxOZ+rED8iAWUoNisAX3SqgNrhhiSD3np/7D7vv9Jrw8WfYPOvijYcgiIZ+aAZe7D+4P7iBAuJs7gMQ=
X-Received: by 2002:a17:90a:e00f:b0:2a2:5876:5a74 with SMTP id
 u15-20020a17090ae00f00b002a258765a74mr10287386pjy.25.1712666468161; Tue, 09
 Apr 2024 05:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Tue, 9 Apr 2024 20:40:56 +0800
Message-ID: <CABOYnLxhiWL10EGJadN1-kQw_2-OaooW3OcZP1=OVupXmZARjQ@mail.gmail.com>
Subject: Re: [syzbot] [jffs2?] KASAN: slab-use-after-free Read in jffs2_erase_pending_blocks
To: syzbot+5a281fe8aadf8f11230d@syzkaller.appspotmail.com
Cc: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug and comfired in the latest upstream.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

I use the same kernel as syzbot instance:
https://syzkaller.appspot.com/bug?extid=5a281fe8aadf8f11230d
Kernel Commit: upstream fe46a7dd189e25604716c03576d05ac8a5209743
Kernel Config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=4d90a36f0cab495a
with KASAN enabled

root@syzkaller:~# ./84e
[  770.516785][ T8231] jffs2: notice: (8231)
jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of
xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
root@syzkaller:~# [  770.575686][ T8255]
==================================================================
[  770.576754][ T8255] BUG: KASAN: slab-use-after-free in
__mutex_lock+0xfe/0xd70
[  770.577681][ T8255] Read of size 8 at addr ffff888019ad9130 by task
jffs2_gcd_mtd0/8255
[  770.578672][ T8255]
[  770.578989][ T8255] CPU: 0 PID: 8255 Comm: jffs2_gcd_mtd0 Not
tainted 6.8.0-08951-gfe46a7dd189e-dirty #6
[  770.580190][ T8255] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  770.581476][ T8255] Call Trace:
[  770.581915][ T8255]  <TASK>
[  770.582301][ T8255]  dump_stack_lvl+0x250/0x380
[  770.582920][ T8255]  ? __pfx_dump_stack_lvl+0x10/0x10
[  770.583599][ T8255]  ? __pfx__printk+0x10/0x10
[  770.584222][ T8255]  ? _printk+0xda/0x120
[  770.584784][ T8255]  ? __virt_addr_valid+0x19b/0x580
[  770.585429][ T8255]  ? __virt_addr_valid+0x19b/0x580
[  770.586071][ T8255]  print_report+0x169/0x550
[  770.586643][ T8255]  ? __virt_addr_valid+0x19b/0x580
[  770.587298][ T8255]  ? __virt_addr_valid+0x19b/0x580
[  770.587949][ T8255]  ? __virt_addr_valid+0x4a8/0x580
[  770.588559][ T8255]  ? __phys_addr+0xc3/0x180
[  770.589036][ T8255]  ? __mutex_lock+0xfe/0xd70
[  770.589613][ T8255]  kasan_report+0x143/0x180
[  770.590214][ T8255]  ? __mutex_lock+0xfe/0xd70
[  770.590809][ T8255]  __mutex_lock+0xfe/0xd70
[  770.591384][ T8255]  ? jffs2_garbage_collect_pass+0xb3/0x2130
[  770.592122][ T8255]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  770.592812][ T8255]  ? __pfx___mutex_lock+0x10/0x10
[  770.593467][ T8255]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  770.594273][ T8255]  ? _raw_spin_lock_irq+0xdf/0x120
[  770.594917][ T8255]  jffs2_garbage_collect_pass+0xb3/0x2130
[  770.595639][ T8255]  ? lockdep_hardirqs_on+0x99/0x150
[  770.596293][ T8255]  ? _raw_spin_unlock_irq+0x2e/0x50
[  770.596938][ T8255]  ? __set_current_blocked+0x31f/0x390
[  770.597610][ T8255]  ? __pfx___set_current_blocked+0x10/0x10
[  770.598257][ T8255]  ? schedule+0x90/0x320
[  770.598705][ T8255]  ? schedule+0x155/0x320
[  770.599239][ T8255]  ? __pfx_jffs2_garbage_collect_pass+0x10/0x10
[  770.600014][ T8255]  ? schedule_timeout+0x227/0x320
[  770.600663][ T8255]  ? sigprocmask+0x231/0x290
[  770.601178][ T8255]  ? __pfx_sigprocmask+0x10/0x10
[  770.601814][ T8255]  ? do_raw_spin_unlock+0x13c/0x8b0
[  770.602473][ T8255]  jffs2_garbage_collect_thread+0x691/0x730
[  770.603218][ T8255]  ? __pfx_jffs2_garbage_collect_thread+0x10/0x10
[  770.604008][ T8255]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[  770.604758][ T8255]  ? __kthread_parkme+0x172/0x1d0
[  770.605407][ T8255]  kthread+0x310/0x3b0
[  770.605935][ T8255]  ? __pfx_jffs2_garbage_collect_thread+0x10/0x10
[  770.606720][ T8255]  ? __pfx_kthread+0x10/0x10
[  770.607223][ T8255]  ret_from_fork+0x52/0x80
[  770.607722][ T8255]  ? __pfx_kthread+0x10/0x10
[  770.608230][ T8255]  ret_from_fork_asm+0x1a/0x30
[  770.608766][ T8255]  </TASK>
[  770.609073][ T8255]
[  770.609323][ T8255] Allocated by task 8231:
[  770.609831][ T8255]  kasan_save_track+0x3f/0x80
[  770.610374][ T8255]  __kasan_kmalloc+0x98/0xb0
[  770.610915][ T8255]  kmalloc_trace+0x1db/0x360
[  770.611495][ T8255]  jffs2_init_fs_context+0x54/0xd0
[  770.612155][ T8255]  alloc_fs_context+0x6a5/0x830
[  770.612788][ T8255]  do_new_mount+0x175/0xb90
[  770.613338][ T8255]  __se_sys_mount+0x362/0x3d0
[  770.613925][ T8255]  do_syscall_64+0xfb/0x240
[  770.614522][ T8255]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[  770.615270][ T8255]
[  770.615567][ T8255] Freed by task 8231:
[  770.616053][ T8255]  kasan_save_track+0x3f/0x80
[  770.616676][ T8255]  kasan_save_free_info+0x40/0x50
[  770.617335][ T8255]  poison_slab_object+0xa6/0xe0
[  770.617968][ T8255]  __kasan_slab_free+0x37/0x60
[  770.618518][ T8255]  kfree+0x14a/0x380
[  770.619008][ T8255]  deactivate_locked_super+0xcb/0x140
[  770.619596][ T8255]  put_fs_context+0x9b/0x7b0
[  770.620158][ T8255]  fscontext_release+0x6c/0x90
[  770.620746][ T8255]  __fput+0x442/0x8d0
[  770.621247][ T8255]  task_work_run+0x25c/0x320
[  770.621835][ T8255]  do_exit+0xa46/0x28a0
[  770.622362][ T8255]  do_group_exit+0x20b/0x2c0
[  770.622951][ T8255]  __x64_sys_exit_group+0x3f/0x40
[  770.623596][ T8255]  do_syscall_64+0xfb/0x240
[  770.624167][ T8255]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[  770.624912][ T8255]
[  770.625213][ T8255] The buggy address belongs to the object at
ffff888019ad9000
[  770.625213][ T8255]  which belongs to the cache kmalloc-4k of size 4096
[  770.626916][ T8255] The buggy address is located 304 bytes inside of
[  770.626916][ T8255]  freed 4096-byte region [ffff888019ad9000,
ffff888019ada000)

=* repro.c =*
#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <linux/capability.h>

#ifndef __NR_fsconfig
#define __NR_fsconfig 431
#endif
#ifndef __NR_fspick
#define __NR_fspick 433
#endif

static bool write_file(const char* file, const char* what, ...) {
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static void setup_common() {
  if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
  }
}

static void setup_binderfs() {
  if (mkdir("/dev/binderfs", 0777)) {
  }
  if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
  }
  if (symlink("/dev/binderfs", "./binderfs")) {
  }
}

static void loop();

static void sandbox_common() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setsid();
  struct rlimit rlim;
  rlim.rlim_cur = rlim.rlim_max = (200 << 20);
  setrlimit(RLIMIT_AS, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 32 << 20;
  setrlimit(RLIMIT_MEMLOCK, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 136 << 20;
  setrlimit(RLIMIT_FSIZE, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 1 << 20;
  setrlimit(RLIMIT_STACK, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 128 << 20;
  setrlimit(RLIMIT_CORE, &rlim);
  rlim.rlim_cur = rlim.rlim_max = 256;
  setrlimit(RLIMIT_NOFILE, &rlim);
  if (unshare(CLONE_NEWNS)) {
  }
  if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
  }
  if (unshare(CLONE_NEWIPC)) {
  }
  if (unshare(0x02000000)) {
  }
  if (unshare(CLONE_NEWUTS)) {
  }
  if (unshare(CLONE_SYSVSEM)) {
  }
  typedef struct {
    const char* name;
    const char* value;
  } sysctl_t;
  static const sysctl_t sysctls[] = {
      {"/proc/sys/kernel/shmmax", "16777216"},
      {"/proc/sys/kernel/shmall", "536870912"},
      {"/proc/sys/kernel/shmmni", "1024"},
      {"/proc/sys/kernel/msgmax", "8192"},
      {"/proc/sys/kernel/msgmni", "1024"},
      {"/proc/sys/kernel/msgmnb", "1024"},
      {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
  };
  unsigned i;
  for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
    write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid) {
  if (pid < 0)
    exit(1);
  int status = 0;
  while (waitpid(-1, &status, __WALL) != pid) {
  }
  return WEXITSTATUS(status);
}

static void drop_caps(void) {
  struct __user_cap_header_struct cap_hdr = {};
  struct __user_cap_data_struct cap_data[2] = {};
  cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
  cap_hdr.pid = getpid();
  if (syscall(SYS_capget, &cap_hdr, &cap_data))
    exit(1);
  const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
  cap_data[0].effective &= ~drop;
  cap_data[0].permitted &= ~drop;
  cap_data[0].inheritable &= ~drop;
  if (syscall(SYS_capset, &cap_hdr, &cap_data))
    exit(1);
}

static int do_sandbox_none(void) {
  if (unshare(CLONE_NEWPID)) {
  }
  int pid = fork();
  if (pid != 0)
    return wait_for_loop(pid);
  setup_common();
  sandbox_common();
  drop_caps();
  if (unshare(CLONE_NEWNET)) {
  }
  write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
  setup_binderfs();
  loop();
  exit(1);
}

static void setup_binfmt_misc() {
  if (mount(0, "/proc/sys/fs/binfmt_misc", "binfmt_misc", 0, 0)) {
  }
  write_file("/proc/sys/fs/binfmt_misc/register", ":syz0:M:0:\x01::./file0:");
  write_file("/proc/sys/fs/binfmt_misc/register",
             ":syz1:M:1:\x02::./file0:POC");
}

uint64_t r[1] = {0xffffffffffffffff};

void loop(void) {
  intptr_t res = 0;
  memcpy((void*)0x200000c0, "./file0\000", 8);
  syscall(__NR_mkdirat, /*fd=*/0xffffff9c, /*path=*/0x200000c0ul, /*mode=*/0ul);
  memcpy((void*)0x20000040, "mtd", 3);
  sprintf((char*)0x20000043, "0x%016llx", (long long)0);
  memcpy((void*)0x200000c0, "./file0\000", 8);
  memcpy((void*)0x20001200, "jffs2\000", 6);
  syscall(__NR_mount, /*src=*/0x20000040ul, /*dst=*/0x200000c0ul,
          /*type=*/0x20001200ul, /*flags=*/3ul, /*data=*/0ul);
  memcpy((void*)0x20000380, "./file0/../file0\000", 17);
  res = syscall(__NR_fspick, /*dfd=*/0xffffff9c, /*path=*/0x20000380ul,
                /*flags=*/0ul);
  if (res != -1)
    r[0] = res;
  syscall(__NR_fsconfig, /*fd=*/r[0], /*cmd=*/7ul, /*key=*/0ul, /*value=*/0ul,
          /*aux=*/0ul);
}
int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  setup_binfmt_misc();
  do_sandbox_none();
  return 0;
}


=* repro.txt =*
mkdirat(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00', 0x0)
mount(&(0x7f0000000040)=ANY=[@ANYBLOB='mtd', @ANYRESHEX=0x0],
&(0x7f00000000c0)='./file0\x00', &(0x7f0000001200)='jffs2\x00', 0x3,
0x0)
r0 = fspick(0xffffffffffffff9c, &(0x7f0000000380)='./file0/../file0\x00', 0x0)
fsconfig$FSCONFIG_CMD_RECONFIGURE(r0, 0x7, 0x0, 0x0, 0x0)

and see also in
https://gist.github.com/xrivendell7/2832a318a4c3bbad0bdeae8d268c4883

I hope it helps.
Best regards

