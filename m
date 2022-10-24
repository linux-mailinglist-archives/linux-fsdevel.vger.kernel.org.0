Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92760980B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 04:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJXCEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 22:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJXCEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:04:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D51F76;
        Sun, 23 Oct 2022 19:04:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f193so7599000pgc.0;
        Sun, 23 Oct 2022 19:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sELHMMSLjSFUrw3fETJ84lyP+heILNDr8LGym6JE3PY=;
        b=BI5fkkDbXG3/lwi14HhI7lex0aQYveaL9gtN5PDG82PN3MX1/RseHBDc9v8xVqRRPK
         EUumVq5K08vbRH/xW6NKrWSH+hrJxb7kArlnoqW78eHsUxPk/2Ejad/qGI4n9u7rXgQ+
         9swNFzS75rGCKeRcZJLzEEnTm1yxhSskUeVA2B6FaAUOc83Xp4g9dqOu5RI9Bukr0Fwy
         0P8Bt2cVEqshlADO4PE26nZON8aB5pBfNQAvpsaNKZicWUd6FGvMZUMTXdqdARq3271z
         fuVV7GcFSsIlGAp0HA0Jaa9Lfwvo2NGyK3c4qJCKt3ync4fe8+M7zw7nGI74EEU5etu2
         jjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sELHMMSLjSFUrw3fETJ84lyP+heILNDr8LGym6JE3PY=;
        b=oFIePzJDmJW1RLdJVPnYw2D5CX3rjx0NtzgFMkfseHIgELOh/qtngWI/E7bRddn01s
         BMXQ2UJ3jwWmg2iWc4n8heJznaOi8e4TrjXAg1TWQAw9cIcBg/2DhePeCA3E+EkhPBo8
         vfKUW5j0QDxYq4UjzzqX8PeHVo1+xPxk7IY9pi8PBe+yhKnz7b1A12bBDXtsp6MN9suK
         VLNZg4lXfIMmoBv8pL8eXWItN38+ZuGGzNZvlOyACUGnz6/4v1JkBcYiNU82FjYzOFA9
         JrEj7Kw4gX7YvGJft45ZTKrSVAuOGDZ+paBQ9bGl3DJdWMz4pWiZU4oxEtQjdPzLP8du
         pipQ==
X-Gm-Message-State: ACrzQf1yOlWDc23euVKA4eSMft2Z8mu5Yf5B5gvIaFJV+opwClzTmwRw
        Ziu+EPvEtKEoV+zo8XqvuWc=
X-Google-Smtp-Source: AMsMyM6bPi4ihUhFOpD0M5q/9WcK3TevTyh2/7ZssfQubTIoYYJnBMYqa4fhjBl9QHx/dZ4NMiHLGg==
X-Received: by 2002:a63:ed07:0:b0:442:87:3a38 with SMTP id d7-20020a63ed07000000b0044200873a38mr26692736pgi.216.1666577080381;
        Sun, 23 Oct 2022 19:04:40 -0700 (PDT)
Received: from localhost ([159.226.94.113])
        by smtp.gmail.com with ESMTPSA id z189-20020a6233c6000000b0056b969ac928sm2854691pfz.47.2022.10.23.19.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 19:04:39 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     xiubli@redhat.com
Cc:     yin31149@gmail.com, idryomov@gmail.com, jlayton@kernel.org,
        18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH -next 3/5] ceph: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 10:04:30 +0800
Message-Id: <20221024020430.15795-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aa3f35c1-1550-a322-956f-1837cb2389a9@redhat.com>
References: <aa3f35c1-1550-a322-956f-1837cb2389a9@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xiubo,
On Mon, 24 Oct 2022 at 08:55, Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 24/10/2022 00:39, Hawkins Jiawei wrote:
> > According to commit "vfs: parse: deal with zero length string value",
> > kernel will set the param->string to null pointer in vfs_parse_fs_string()
> > if fs string has zero length.
> >
> > Yet the problem is that, ceph_parse_mount_param() will dereferences the
> > param->string, without checking whether it is a null pointer, which may
> > trigger a null-ptr-deref bug.
> >
> > This patch solves it by adding sanity check on param->string
> > in ceph_parse_mount_param().
> >
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > ---
> >   fs/ceph/super.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 3fc48b43cab0..341e23fe29eb 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -417,6 +417,9 @@ static int ceph_parse_mount_param(struct fs_context *fc,
> >               param->string = NULL;
> >               break;
> >       case Opt_mds_namespace:
> > +             if (!param->string)
> > +                     return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
> > +                                    param->string, param->key);
> >               if (!namespace_equals(fsopt, param->string, strlen(param->string)))
> >                       return invalfc(fc, "Mismatching mds_namespace");
> >               kfree(fsopt->mds_namespace);
>
> BTW, did you hit any crash issue when testing this ?
>
> $ ./bin/mount.ceph :/ /mnt/kcephfs -o mds_namespace=
>
> <5>[  375.535442] ceph: module verification failed: signature and/or
> required key missing - tainting kernel
> <6>[  375.698145] ceph: loaded (mds proto 32)
> <3>[  375.801621] ceph: Bad value for 'mds_namespace'
>
>  From my test, the 'fsparam_string()' has already make sure it won't
> trigger the null-ptr-deref bug.
Did you test on linux-next tree?

I just write a reproducer based on syzkaller's template(So please
forgive me if it is too ugly to read)

===========================================================
// https://syzkaller.appspot.com/bug?id=76bbdfd28722f0160325e4350b57e33aa95b0bbe
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
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

unsigned long long procid;

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
  int i;
  for (i = 0; i < 100; i++) {
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
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter;
  for (iter = 0;; iter++) {
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
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
      if (current_time_ms() - start < 5 * 1000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

void execute_one(void)
{
  char opt[] = "mds_namespace=,\x00";
  memcpy((void*)0x20000080, "./file0\000", 8);
  syscall(__NR_mknod, 0x20000080ul, 0ul, 0x700ul + procid * 2);
  memcpy((void*)0x20000040, "[d::]:/8:", 9);
  memcpy((void*)0x200000c0, "./file0\000", 8);
  memcpy((void*)0x20000140, "ceph\000", 5);
  memcpy((void*)0x20000150, opt, sizeof(opt));
  syscall(__NR_mount, 0x20000040ul, 0x200000c0ul, 0x20000140ul, 0ul, 0x20000150);
}
int main(void)
{
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
  for (procid = 0; procid < 6; procid++) {
    if (fork() == 0) {
      loop();
    }
  }
  sleep(1000000);
  return 0;
}
===========================================================

And it triggers the null-ptr-deref bug described above,
its log is shown as below:
===========================================================
[   90.779695][ T6513] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   90.782502][ T6513] RIP: 0010:strlen+0x1a/0x90
[ ... ]
[   90.782502][ T6513] Call Trace:
[   90.782502][ T6513]  <TASK>
[   90.782502][ T6513]  ceph_parse_mount_param+0x89a/0x21e0
[   90.782502][ T6513]  ? __kasan_unpoison_range-0xf/0x10
[   90.782502][ T6513]  ? kasan_addr_to_slab-0xf/0x90
[   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[   90.782502][ T6513]  ? ceph_parse_mount_param+0x0/0x21e0
[   90.782502][ T6513]  ? audit_kill_trees+0x2b0/0x300
[   90.782502][ T6513]  ? lock_release+0x0/0x760
[   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[   90.782502][ T6513]  ? security_fs_context_parse_param+0x99/0xd0
[   90.782502][ T6513]  ? ceph_parse_mount_param+0x0/0x21e0
[   90.782502][ T6513]  vfs_parse_fs_param+0x20f/0x3d0
[   90.782502][ T6513]  vfs_parse_fs_string+0xe4/0x180
[   90.782502][ T6513]  ? vfs_parse_fs_string+0x0/0x180
[   90.782502][ T6513]  ? rcu_read_lock_sched_held+0x0/0xd0
[   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[   90.782502][ T6513]  ? kfree+0x129/0x1a0
[   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[   90.782502][ T6513]  generic_parse_monolithic+0x16f/0x1f0
[   90.782502][ T6513]  ? generic_parse_monolithic+0x0/0x1f0
[   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[   90.782502][ T6513]  ? alloc_fs_context+0x5cb/0xa00
[   90.782502][ T6513]  path_mount+0x11d3/0x1cb0
[   90.782502][ T6513]  ? path_mount+0x0/0x1cb0
[   90.782502][ T6513]  ? putname+0xfe/0x140
[   90.782502][ T6513]  do_mount+0xf3/0x110
[   90.782502][ T6513]  ? do_mount+0x0/0x110
[   90.782502][ T6513]  ? _copy_from_user+0xf7/0x170
[   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
[   90.782502][ T6513]  __x64_sys_mount+0x18f/0x230
[   90.782502][ T6513]  do_syscall_64+0x35/0xb0
[   90.782502][ T6513]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ ... ]
[   90.782502][ T6513]  </TASK>
===========================================================

By the way, commit "vfs: parse: deal with zero length string value"
is still in discussion as below, so maybe this patchset is not
needed.
https://lore.kernel.org/all/17a1fdc-14a0-cf3c-784f-baa939895aef@google.com/
>
> But it will always make sense to fix it in ceph code with your patch.
>
> - Xiubo
>
>
>
