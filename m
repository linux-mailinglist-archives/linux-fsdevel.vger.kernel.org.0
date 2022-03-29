Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61164EAF6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiC2Omm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 10:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiC2Omi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7B326CB;
        Tue, 29 Mar 2022 07:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF14861683;
        Tue, 29 Mar 2022 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E13C2BBE4;
        Tue, 29 Mar 2022 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648564853;
        bh=sZGUojoPs/GEyEYJCPamM2iGY2MhjJiDhSxUee8WS/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K31zj4qIYdxG9O/YqYztWwtZRwtAsLfeYTYKtv9JEJCnoClSrP80hhU86TuzuiLlr
         Da1X+4NAvtEvZwW1rhmxH0jgdc/L75fHKZjc5jpeVWPAoFGd7AXlNpWd3QkNwfT7bR
         uPC1KJc5pOLU7zSvlfF6Yu3JPLWqfQO7gUikccJg9QvU9jPRLZMUskM7f81Hzp9oZT
         VrdklI2Bmz8GZ8lNy/7uQf6cTXJm2GoDHK7JFfUyPu13ERk6J1yLVxpDGkgbP0mnb7
         XlVtJrtZBTuLeGuP8vJwp9OXjfdCqYRHd3N5P9r6b6ZNnF1wBMg8fn8LzfAoGWZxyJ
         4nTz5qmwrnOaw==
Date:   Tue, 29 Mar 2022 16:40:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Message-ID: <20220329144047.35zsrw24p2t2ggmg@wittgenstein>
References: <20220326114009.1690-1-aissur0002@gmail.com>
 <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
 <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
 <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <20220329102347.iu6mlbv5c76ci3j7@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220329102347.iu6mlbv5c76ci3j7@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 12:23:47PM +0200, Christian Brauner wrote:
> On Sun, Mar 27, 2022 at 03:21:18PM -0700, Linus Torvalds wrote:
> > On Sun, Mar 27, 2022 at 2:53 PM <aissur0002@gmail.com> wrote:
> > >
> > > I am sorry, that was my first attempt to contribute to the kernel and
> > > I messed up a little bit with the patch tag: it is actually a single,
> > > standalone patch and there has been nothing posted previously.
> > 
> > No problem, thanks for clarifying.
> > 
> > But the patch itself in that case is missing some detail, since it
> > clearly doesn't apply to upstream.
> > 
> > Anyway:
> > 
> > > In few words, an error occurs while executing close_range() call with
> > > CLOSE_RANGE_UNSHARE flag: in __close_range() the value of
> > > max_unshare_fds (later used as max_fds in dup_fd() and copy_fd_bitmaps())
> > > can be an arbitrary number.
> > >
> > >   if (max_fd >= last_fd(files_fdtable(cur_fds)))
> > >     max_unshare_fds = fd;
> > >
> > > and not be a multiple of BITS_PER_LONG or BITS_PER_BYTE.
> > 
> > Very good, that's the piece I was missing. I only looked in fs/file.c,
> > and missed how that max_unshare_fds gets passed from __close_range()
> > into fork.c for unshare_fd() and then back to file.c and dup_fd(). And
> > then affects sane_fdtable_size().
> > 
> > I _think_ it should be sufficient to just do something like
> > 
> >        max_fds = ALIGN(max_fds, BITS_PER_LONG)
> > 
> > in sane_fdtable_size(), but honestly, I haven't actually thought about
> > it all that much. That's just a gut feel without really analyzing
> > things - sane_fdtable_size() really should never return a value that
> > isn't BITS_PER_LONG aligned.
> > 
> > And that whole close_range() is why I added Christian Brauner to the
> > participant list, though, so let's see if Christian has any comments.
> > 
> > Christian?
> 
> (Sorry, I was heads-deep in some other fs work and went into airplaine
> mode. I'm back.)
> 
> So I investigated a similar report a little while back and I spent quite
> a lot of time trying to track this down but didn't find the cause.
> If you'd call:
> 
> close_range(131, -1, CLOSE_RANGE_UNSHARE);
> 
> for an fdtable that is smaller than 131 then we'd call:
> 
> unshare_fd(..., 131)
> \dup_fd(..., 131)
>   \sane_fdtable_size(..., 131)
> 
> So sane_fdtable_size() would return 131 which is not aligned. This
> couldn't happen before CLOSE_RANGE_UNSHARE afaict. I'll try to do a
> repro with this with your suggested fix applied.

Ok, I managed to repro this issue on an upstream 5.17 kernel. You'll
need kmemleak enabled:

CONFIG_MEMCG_KMEM=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y

The reproducer at [1] I'm using for this is super ugly fwiw. Compile with

gcc -pthread <bla>.c -o <bla>

The repro should trigger in about 2-3 iterations once the fdtable has
grown sufficiently for fd_start to become the upper limit instead of the
actual fdtable size when calling close_range(131, -1, CLOSE_RANGE_UNSHARE).

I don't think this actually leads to any fd leaks afaict as they should
all be properly closed after all sane_fdtable_size() does return the
number of open fds. But this is indeed triggered by the missing
BITS_PER_LONG alignment.

Your patch fixes this, Linus. I've compiled a kernel with your patch in
sane_fdtable_size() applied running with the repro for a few hours now
and no leaks. Feel free to take my ack.

I think alloc_fdtable() does everything correctly. The issue imho is
sane_fdtable_size() not aligning and then below when we do:
	for (i = open_files; i != 0; i--) {
in dup_fd() it looks to kmemleak like it's leaking (I'm not completely
sure it is actually.).

[1]:
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
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
 
#include <linux/futex.h>
 
#ifndef __NR_close_range
#define __NR_close_range 436
#endif
 
#ifndef SYS_gettid
#error "SYS_gettid unavailable on this system"
#endif
 
#define gettid() ((pid_t)syscall(SYS_gettid))
 
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
 
static void thread_start(void* (*fn)(void*), void* arg)
{
  pid_t pid = getpid();
  pid_t tid = gettid();
 
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      printf("%d %d created thread\n", pid, tid);
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
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort", ent->d_name);
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
}
 
#define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"
 
static void setup_leak()
{
  if (!write_file(KMEMLEAK_FILE, "scan"))
    exit(1);
  sleep(5);
  if (!write_file(KMEMLEAK_FILE, "scan"))
    exit(1);
  if (!write_file(KMEMLEAK_FILE, "clear"))
    exit(1);
}
 
static void check_leaks(void)
{
  int fd = open(KMEMLEAK_FILE, O_RDWR);
  if (fd == -1)
  exit(1);
  uint64_t start = current_time_ms();
  if (write(fd, "scan", 4) != 4)
  exit(1);
  sleep(1);
  while (current_time_ms() - start < 4 * 1000)
    sleep(1);
  if (write(fd, "scan", 4) != 4)
  exit(1);
  static char buf[128 << 10];
  ssize_t n = read(fd, buf, sizeof(buf) - 1);
  if (n < 0)
  exit(1);
  int nleaks = 0;
  if (n != 0) {
    sleep(1);
    if (write(fd, "scan", 4) != 4)
  exit(1);
    if (lseek(fd, 0, SEEK_SET) < 0)
  exit(1);
    n = read(fd, buf, sizeof(buf) - 1);
    if (n < 0)
  exit(1);
    buf[n] = 0;
    char* pos = buf;
    char* end = buf + n;
    while (pos < end) {
      char* next = strstr(pos + 1, "unreferenced object");
      if (!next)
        next = end;
      char prev = *next;
      *next = 0;
      fprintf(stderr, "BUG: memory leak\n%s\n", pos);
      *next = prev;
      pos = next;
      nleaks++;
    }
  }
  if (write(fd, "clear", 5) != 5)
  exit(1);
  close(fd);
  if (nleaks)
    exit(1);
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
  sleep_ms(100);
  int i, call, thread;
  for (call = 0; call < 2; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0])); thread++) {
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
  pid_t parentPID = getpid();
  pid_t parentTID = gettid();
  int iter = 0;
  for (;; iter++) {
    printf("%d %d forking\n", parentPID, parentTID);
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    printf("%d %d forked child %d\n", parentPID, parentTID, pid);
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
    printf("%d %d checking leak after executor exited\n", parentPID, parentTID);
    check_leaks();
  }
}
 
uint64_t r[1] = {0xffffffffffffffff};
 
void execute_call(int call)
{
  pid_t pid = getpid();
  pid_t tid = gettid();
 
  intptr_t res = 0;
  switch (call) {
  case 0:
    printf("%d %d pipe2\n", pid, tid);
    res = syscall(__NR_pipe2, 0x20000080ul, 0ul);
    {
      int i;
      for(i = 0; i < 64 /* 32 also triggers the bug, but 16 doesn't */; i++) {
        syscall(__NR_pipe2, 0x20000080ul, 0ul);
      }
    }
    if (res != -1)
      r[0] = *(uint32_t*)0x20000080;
    break;
  case 1:
    printf("%d %d close_range\n", pid, tid);
    syscall(__NR_close_range, r[0], -1, 2ul /* CLOSE_RANGE_UNSHARE */);
    break;
  }
 
}
 
int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  setup_leak();
  printf("%d %d starting loop\n", getpid(), gettid());
  loop();
  return 0;
}
