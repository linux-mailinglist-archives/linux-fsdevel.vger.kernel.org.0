Return-Path: <linux-fsdevel+bounces-37491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E2A9F319A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 14:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDC7A2F52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649B2054E6;
	Mon, 16 Dec 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+0Xy04L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95262204F9D;
	Mon, 16 Dec 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356084; cv=none; b=uAGhf3uX648s8pQyewAe6utCApazp4B2J8/1pMLvBpcdsiz+57soPN4f9rtwBRT1GWNzOhrqnGOZP1tIlX2he/1Z5k1dhIkCspzD+fx5g/FPyyjKIm4X9bpAXPWqepRzZQNF08iruwb7DAtzSJQam+OdrCwZU9bndcJhf3vE2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356084; c=relaxed/simple;
	bh=bY20enhKMPdcj6oWFMzCK/M0TP4e1CqqRI/zqvA9mB8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CnwnfMozOp5xt1fBlVnHNwWo5NOp+S3pPRWWag53k3d4sAaA5h0HEPoQa4Rc7ffT1+DVU9kNt14VCvU0Q4AGi5NSvjDHapHrpp66E5ktqaxjFz7KFXmwOxOt6I3HYJJQgcj3X2RtTRCl2x751bZ5tdK+GvTWKZwfDwPEdplYyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+0Xy04L; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6eb531e13so172760985a.0;
        Mon, 16 Dec 2024 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734356081; x=1734960881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILJaSAjaG1IblCmaudS8cApx6aMUXt4jADLU281ARgI=;
        b=l+0Xy04LKwzanrsAoMq3LgntbuplNpAbCHiAUbliHNzts9GgkFtW19byyceKvX4GHK
         BIFwV5rVdW0z24LgoMsaZAwLEUsOvdLgZIUqjcq8tec4IAlPm8mAiSmakp82di+2oxRC
         C6B/3rGujJ04u9Sp/gi0T77JCLrR2BOol4rxakOEGIYREWgvboo9Aa11IoDfk85yUOZx
         Z9eV6M2xAY/QQ5P63jdB8JuCfvCsh8NGb+fTL8he+MJjuqGyBSAxH5iQeSewbFsBKJg5
         Ssxsi0DGnGq2njdBHXL+a+a1VT2KoM8he537z9tOVXNYFAxroLwrwnt9XFhWS7rsJjPb
         cK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734356081; x=1734960881;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILJaSAjaG1IblCmaudS8cApx6aMUXt4jADLU281ARgI=;
        b=lmMWvYiyL91pYVo0ufX6Z3r1C63zhFU0uFhM0dHPV6I4FfW2JNVHLp41FLlA1W+Mzx
         jMdZ8JMXK1R0pKwtpujoYuVbC97mHIws7GyCrxVlrAxfYMgAuvhfCoA4J6l9qcbIyARX
         PtWyj/mfeKqvFgxzBVMO9n1rqbmwU7enUb+RGXZdEOFiyfZlCArE3KPivrQ8EukzizyY
         f4+Eg8E4m5F75gj1Wx1h0EfVfscq9+pDP1lA63/2h4X26OyteJtjE+pWykk2mOTCF0jZ
         Ed9N613lI1GB2fKl85nOJOr3iOrOXa5ok26l6hQpAbvigej3uwm0T9nYm38yUPt+kCfv
         +XhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8qGT7fRJjd1imx1sUW34k7w7OMxMfwQ4cVi9hGUDSwm7H5zvoA72gtgCj+rcSysXOpPjyNXDpO/w4IYqi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+P7ANDFCgxx4hiS16HSW0LP6Rpt8EInovio8wRqhyWSIeNgF
	edI+BpCYwubHJxWrSDF+IvFxsqw8nJFHXeK0f8IGo2C+l9iuqPRTV+MjI2beEdGqrRE9Ngk035j
	8Qi8UyqFAcs8MfoI4ZIAYoUq11/hzVzwL8QWWG2Ck
X-Gm-Gg: ASbGnctmamCGnr9AXJUz4AfhEp8aD9Jn/Z11GF8f57CeWipdWTe1gdI822xs6mU06hG
	sYimmu/ozpCTkx+XAhYYlKoOziwv68Nzpz0PxppU=
X-Google-Smtp-Source: AGHT+IHMcBSy3Tf5kAJvQgr66QZoqhD+CQ9t341JflPTqp1SVQbA9+GS8iyePy2rHAMXlntgAfocw3ROPQN1Yl+9RvU=
X-Received: by 2002:a05:6214:20a3:b0:6d8:899e:c3bf with SMTP id
 6a1803df08f44-6dc9032067bmr221515486d6.34.1734356080446; Mon, 16 Dec 2024
 05:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 16 Dec 2024 21:34:28 +0800
Message-ID: <CAEkJfYM-wj1wYjCPTCWs2GGkmp0W4z2VEMoL8qEH_9trB1PZkQ@mail.gmail.com>
Subject: [Bug] BUG: soft lockup in oom_score_adj_write
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, 
	peterz@infradead.org, viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, 
	felix.moessbauer@siemens.com, adrian.ratiu@collabora.com, 
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear developers and maintainers,

We encountered a kernel bug while using our modified
syzkaller. It was tested against the latest upstream kernel.
Kernel crash log is listed below.

```
Syzkaller hit 'BUG: soft lockup in oom_score_adj_write' bug.

watchdog: BUG: soft lockup - CPU#0 stuck for 290s! [syz-executor434:52600]
Modules linked in:
irq event stamp: 220
hardirqs last  enabled at (219): [<ffffffff8b122621>]
syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
hardirqs last  enabled at (219): [<ffffffff8b122621>]
do_syscall_64+0x91/0x250 arch/x86/entry/common.c:79
hardirqs last disabled at (220): [<ffffffff8b128c0f>]
sysvec_apic_timer_interrupt+0xf/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (0): [<ffffffff814dc1b2>]
copy_process+0x1f22/0x8960 kernel/fork.c:2321
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 52600 Comm: syz-executor434 Tainted: G S
     6.12.0-09435-g2c22dc1ee3a1 #11
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:564 [inline]
RIP: 0010:__mutex_lock+0x122/0xa50 kernel/locking/mutex.c:735
Code: 0f 85 c6 06 00 00 8b 35 7c d1 50 0f 85 f6 75 2b 49 8d 7c 24 60
48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 <0f> 85
ad 06 00 00 4d 3b 64 24 60 0f 85 96 01 00 00 bf 01 00 00 00
RSP: 0018:ffffc900114bfab0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffffffff1c1c5c4 RSI: 0000000000000000 RDI: ffffffff8e0e2e20
RBP: ffffc900114bfbf0 R08: ffffffff82279e78 R09: fffffbfff208021a
R10: ffffc900114bfc10 R11: 0000000000000000 R12: ffffffff8e0e2dc0
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc900114bfb30
FS:  00005555771343c0(0000) GS:ffff88802b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc345f1a01d CR3: 0000000025910000 CR4: 00000000003506b0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 __set_oom_adj.isra.0+0x68/0xfd0 fs/proc/base.c:1129
 oom_score_adj_write+0x1b4/0x1f0 fs/proc/base.c:1294
 vfs_write+0x2b6/0x10d0 fs/read_write.c:677
 ksys_write+0x122/0x240 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc345ec68d7
Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f
1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffd2e307948 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc345ec68d7
RDX: 0000000000000004 RSI: 00007ffd2e307970 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffd2e3078c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd2e307970
R13: 0000000000000000 R14: 00007ffd2e307e8c R15: 431bde82d7b634db
 </TASK>
```

We have a C repro which can trigger the task hung, listed below:
```

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void use_temporary_dir(void)
{
  char tmpdir_template[] = "./syzkaller.XXXXXX";
  char* tmpdir = mkdtemp(tmpdir_template);
  if (!tmpdir)
    exit(1);
  if (chmod(tmpdir, 0777))
    exit(1);
  if (chdir(tmpdir))
    exit(1);
}

static void thread_start(void* (*fn)(void*), void* arg)
{
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev)
{
  ev->state = 0;
}

static void event_reset(event_t* ev)
{
  ev->state = 0;
}

static void event_set(event_t* ev)
{
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now = current_time_ms();
    if (now - start > timeout)
      return 0;
  }
}

static bool write_file(const char* file, const char* what, ...)
{
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

static long syz_mod_param(volatile long a0, volatile long a1, volatile long a2,
                          volatile long a3, volatile long a4)
{
  int fd, sysfd;
  char buf[1024], sysbuf[1024], input[1024];
  char* hash;
  strncpy(buf, (char*)a0, sizeof(buf) - 1);
  buf[sizeof(buf) - 1] = 0;
  while ((hash = strchr(buf, '#'))) {
    *hash = '0' + (char)(a1 % 10);
    a1 /= 10;
  }
  fd = open(buf, a2, 0);
  strncpy(sysbuf, (char*)a3, sizeof(sysbuf) - 1);
  sysbuf[sizeof(sysbuf) - 1] = 0;
  sysfd = open(sysbuf, O_RDWR, 0);
  strncpy(input, (char*)a4, sizeof(input) - 1);
  hash = strchr(input, '\0');
  sysfd = write(sysfd, input, hash - input + 1);
  return fd;
}

/*
#if SYZ_EXECUTOR || __NR_syz_mod_power
static long syz_mod_power(volatile long a0, volatile long a1)
{
        int sysfd;
        char sysbuf[1024], input[1024];
        char* hash;
        strncpy(sysbuf, (char*)a0, sizeof(sysbuf) - 1);
        sysbuf[sizeof(sysbuf) - 1] = 0;
        sysfd = open(sysbuf, O_RDWR, 0);
        strncpy(input, (char*)a1, sizeof(input) - 1);
        hash = strchr(input, '\0');
        sysfd = write(sysfd, input, hash - input + 1);
        return sysfd;
}
#endif
*/

#define FS_IOC_SETFLAGS _IOW('f', 2, long)
static void remove_dir(const char* dir)
{
  int iter = 0;
  DIR* dp = 0;
retry:
  while (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
  }
  dp = opendir(dir);
  if (dp == NULL) {
    if (errno == EMFILE) {
      exit(1);
    }
    exit(1);
  }
  struct dirent* ep = 0;
  while ((ep = readdir(dp))) {
    if (strcmp(ep->d_name, ".") == 0 || strcmp(ep->d_name, "..") == 0)
      continue;
    char filename[FILENAME_MAX];
    snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
    while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
    }
    struct stat st;
    if (lstat(filename, &st))
      exit(1);
    if (S_ISDIR(st.st_mode)) {
      remove_dir(filename);
      continue;
    }
    int i;
    for (i = 0;; i++) {
      if (unlink(filename) == 0)
        break;
      if (errno == EPERM) {
        int fd = open(filename, O_RDONLY);
        if (fd != -1) {
          long flags = 0;
          if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
          }
          close(fd);
          continue;
        }
      }
      if (errno == EROFS) {
        break;
      }
      if (errno != EBUSY || i > 100)
        exit(1);
      if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW))
        exit(1);
    }
  }
  closedir(dp);
  for (int i = 0;; i++) {
    if (rmdir(dir) == 0)
      break;
    if (i < 100) {
      if (errno == EPERM) {
        int fd = open(dir, O_RDONLY);
        if (fd != -1) {
          long flags = 0;
          if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
          }
          close(fd);
          continue;
        }
      }
      if (errno == EROFS) {
        break;
      }
      if (errno == EBUSY) {
        if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW))
          exit(1);
        continue;
      }
      if (errno == ENOTEMPTY) {
        if (iter < 100) {
          iter++;
          goto retry;
        }
      }
    }
    exit(1);
  }
}

static void kill_and_wait(int pid, int* status)
{
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
  if (symlink("/dev/binderfs", "./binderfs")) {
  }
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void execute_one(void)
{
  int i, call, thread;
  for (call = 0; call < 2; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
         thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done))
        continue;
      event_reset(&th->done);
      th->call = call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      event_timedwait(&th->done, 50);
      break;
    }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
    char cwdbuf[32];
    sprintf(cwdbuf, "./%d", iter);
    if (mkdir(cwdbuf, 0777))
      exit(1);
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      if (chdir(cwdbuf))
        exit(1);
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
    remove_dir(cwdbuf);
  }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_call(int call)
{
  intptr_t res = 0;
  switch (call) {
  case 0:
    memcpy((void*)0x20000180, "/dev/cpu/#/msr\000", 15);
    memcpy((void*)0x200001c0, "/sys/module/msr/parameters/allow_writes\000",
           40);
    memcpy((void*)0x20000200, "10\000", 3);
    res = -1;
    res = syz_mod_param(/*dev=*/0x20000180, /*id=*/0, /*flags=O_WRONLY*/ 1,
                        /*file=*/0x200001c0, /*buf=*/0x20000200);
    if (res != -1)
      r[0] = res;
    break;
  case 1:
    *(uint64_t*)0x200008c0 = 0x200002c0;
    memset((void*)0x200002c0, 103, 1);
    *(uint64_t*)0x200008c8 = 0x10;
    syscall(__NR_pwritev, /*fd=*/r[0], /*vec=*/0x200008c0ul, /*vlen=*/1ul,
            /*off_low=*/0x10, /*off_high=*/0);
    break;
  }
}
int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  for (procid = 0; procid < 4; procid++) {
    if (fork() == 0) {
      use_temporary_dir();
      loop();
    }
  }
  sleep(1000000);
  return 0;
}

```
However, the crash log is sometimes different from the original one.
For example, this is the crash log of one run:
```
root@syzkaller:~# ./oom_score_adj_write
[  351.275672][    C1] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  351.277613][    C1] rcu:     0-...!: (0 ticks this GP)
idle=ab9c/1/0x4000000000000000 softirq=18614/18614 fqs=0
[  351.280856][    C1] rcu:     Tasks blocked on level-0 rcu_node
(CPUs 0-1): P7953/3:b..l
[  351.282951][    C1] rcu:     (detected by 1, t=768614301051
jiffies, g=5765, q=221 ncpus=2)
[  351.290334][    C1] rcu: rcu_preempt kthread timer wakeup didn't
happen for 768614301050 jiffies! g5765 f0x0 RCU_GP_WAIT_FQS(5)
->state=0x402
[  351.293657][    C1] rcu:     Possible timer handling issue on cpu=1
timer-softirq=6744
[  351.295684][    C1] rcu: rcu_preempt kthread starved for
768614301051 jiffies! g5765 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
->cpu=1
[  351.298718][    C1] rcu:     Unless rcu_preempt kthread gets
sufficient CPU time, OOM is now expected behavior.
[  351.301284][    C1] rcu: RCU grace-period kthread stack dump:
[  351.304248][    C1] rcu: Stack dump where RCU GP kthread last ran:
[  531.267940][    T1] systemd[1]: systemd-udevd.service: Watchdog
timeout (limit 3min)!
[  682.879881][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for
143s! [kworker/1:1:7934]
[  682.880575][    C1] CPU#1 Utilization every 22s during lockup:
[  682.880995][    C1]  #1: 100% system,          0% softirq,     1%
hardirq,     0% idle
[  682.881516][    C1]  #2: 100% system,          0% softirq,     1%
hardirq,     0% idle
[  682.882022][    C1]  #3: 100% system,          0% softirq,     1%
hardirq,     0% idle
[  682.882539][    C1]  #4: 100% system,          0% softirq,     1%
hardirq,     0% idle
[  682.883052][    C1]  #5: 100% system,          0% softirq,     0%
hardirq,     0% idle
[  682.884393][    C1] Kernel panic - not syncing: softlockup: hung tasks
[  682.884881][    C1] CPU: 1 UID: 0 PID: 7934 Comm: kworker/1:1
Tainted: G S           L     6.13.0-rc3 #5
[  682.885566][    C1] Tainted: [S]=CPU_OUT_OF_SPEC, [L]=SOFTLOCKUP
[  682.886004][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[  682.886642][    C1] Workqueue: events bpf_prog_free_deferred
[  682.887066][    C1] Call Trace:
[  682.887302][    C1]  <IRQ>
[  682.887510][    C1]  dump_stack_lvl+0x3d/0x1b0
[  682.887852][    C1]  panic+0x6fd/0x7b0
[  682.888137][    C1]  ? __pfx_panic+0x10/0x10
[  682.888468][    C1]  ? show_trace_log_lvl+0x284/0x390
[  682.888847][    C1]  ? watchdog_timer_fn+0xd9e/0x1150
[  682.889231][    C1]  ? watchdog_timer_fn+0xd91/0x1150
[  682.889609][    C1]  watchdog_timer_fn+0xdaf/0x1150
[  682.889990][    C1]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  682.890393][    C1]  ? timerqueue_del+0x83/0x150
[  682.890749][    C1]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  682.891166][    C1]  __hrtimer_run_queues+0x5ea/0xae0
[  682.891552][    C1]  ? __pfx___hrtimer_run_queues+0x10/0x10
[  682.891965][    C1]  ? ktime_get_update_offsets_now+0x2ba/0x450
[  682.892409][    C1]  hrtimer_interrupt+0x398/0x890
[  682.892760][    C1]  __sysvec_apic_timer_interrupt+0x111/0x400
[  682.893187][    C1]  sysvec_apic_timer_interrupt+0xa3/0xc0
[  682.893606][    C1]  </IRQ>
[  682.893818][    C1]  <TASK>
[  682.894035][    C1]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  682.894477][    C1] RIP: 0010:smp_call_function_many_cond+0x613/0x12e0
[  682.894956][    C1] Code: e8 22 09 0c 00 45 85 e4 74 49 48 8b 44 24
08 49 89 c5 83 e0 07 49 c1 ed 03 49 89 c4 4d 01 fd 41 83 c4 03 e8 cf
05 0c 00 f3 90 <41> 0f b6 45 01
[  682.896291][    C1] RSP: 0018:ffffc90000aef9c8 EFLAGS: 00000293
[  682.896711][    C1] RAX: 0000000000000000 RBX: 0000000000000000
RCX: ffffffff818a1aa7
[  682.897271][    C1] RDX: ffff88804231a480 RSI: ffffffff818a1a81
RDI: 0000000000000005
[  682.897831][    C1] RBP: ffff88802c4469a0 R08: 0000000000000001
R09: fffffbfff2823399
[  682.898405][    C1] R10: 0000000000000001 R11: 0000000000000000
R12: 0000000000000003
[  682.898974][    C1] R13: ffffed1005888d35 R14: 0000000000000001
R15: dffffc0000000000
[  682.899539][    C1]  ? smp_call_function_many_cond+0x637/0x12e0
[  682.899973][    C1]  ? smp_call_function_many_cond+0x611/0x12e0
[  682.900412][    C1]  ? smp_call_function_many_cond+0x611/0x12e0
[  682.900863][    C1]  ? __pfx_do_flush_tlb_all+0x10/0x10
[  682.901253][    C1]  on_each_cpu_cond_mask+0x40/0x90
[  682.901629][    C1]  __purge_vmap_area_lazy+0x4f1/0xc50
[  682.902019][    C1]  _vm_unmap_aliases+0x286/0x880
[  682.902388][    C1]  ? __pfx__vm_unmap_aliases+0x10/0x10
[  682.902787][    C1]  ? remove_vm_area+0x299/0x400
[  682.903138][    C1]  vfree+0x61d/0x890
[  682.903433][    C1]  bpf_prog_free_deferred+0x463/0x630
[  682.903826][    C1]  process_one_work+0x99f/0x1bb0
[  682.904183][    C1]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  682.904578][    C1]  ? __pfx_process_one_work+0x10/0x10
[  682.904957][    C1]  ? rcu_is_watching+0x12/0xc0
[  682.905296][    C1]  ? assign_work+0x194/0x240
[  682.905623][    C1]  worker_thread+0x677/0xe90
[  682.905951][    C1]  ? __pfx_worker_thread+0x10/0x10
[  682.906316][    C1]  kthread+0x2c7/0x3b0
[  682.906613][    C1]  ? __pfx_kthread+0x10/0x10
[  682.906950][    C1]  ret_from_fork+0x45/0x80
[  682.907270][    C1]  ? __pfx_kthread+0x10/0x10
[  682.907593][    C1]  ret_from_fork_asm+0x1a/0x30
[  682.907938][    C1]  </TASK>
[  683.989287][    C1] Shutting down cpus with NMI
[  683.989912][    C1] Kernel Offset: disabled
[  683.990244][    C1] Rebooting in 86400 seconds..
```
If you have any questions, please contact us.

Reported by Yue Sun <samsun1006219@gmail.com>

Best Regards,
Yue

