Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67298E2166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfJWRG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 13:06:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40104 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfJWRG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:06:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id y81so16552332qkb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmJlh4WyBNl5ujqJykwBJPqFEruvIfpYSLEoPjqEaF0=;
        b=a9kbrGD0VSKrvdNU25RKScBnDnByLA4+uj/kwwXdk+N2049BF3bn/9X8wxg/ptPAMI
         QrwmPUCoCr2vlIwbMjD0s94a5ZRtq3UnE85Ty+T7aavcI8LsBUT41tSH+WWsIq3UgEd9
         3stFaNvJhzE3ykEPC/vWgsyEBZ2BKeKLnlI9tFn/8TyLFcC6n3qMFwmu/pPEtuOzY4ft
         9PkZkf7Lfy0jsAx2AvV9MKrTU6R2S8hbY86LznBATQx6OVkQO6r5czyyjHCFiL/pKDeL
         SicEgj+Bq+Kcf5GVp4U+jUi/zO5wIaG7p9Tr5ZJyKdxmp7HFKjaftYR7S0h767gjdxry
         0z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmJlh4WyBNl5ujqJykwBJPqFEruvIfpYSLEoPjqEaF0=;
        b=KsiqVwe95aWE9zbAhozWF5PFU1NA3579+mA3QhZ6XNnt87WTCUsYlBNtTwFM6nE8qN
         6cT+DaOcxzbYnrsxGKCK95v21NHCPUGpooFXWJt3qISjwtN7Rv7OLQZVJLlBaic2yWUi
         +Gcy5XAGpjdZ6HBlvDxRMhBvi9oXN/RKoookRacgdon1ow4eqy7FL0Ghy+ZbJLq4qJLr
         uVgmxRaPp/xf9wsObcxXL6uet+Nsz5BTYhuzNpdVCfeQBSm1i9ePp6WhiprHUg0UiS6y
         9XTaVMosNeLS8AraZ3lnLIZTXsvlEjWSkXjSWtazs6LGsSz+BegQ6PHOZqECGSRbHY1A
         brQg==
X-Gm-Message-State: APjAAAV/ECLWmAVveA/36ix+3xxH4GtNd8B9h4cICV3IKa6ws66YmlY6
        aqhgxOXSt/7QBp3fY1q5H/QOpc6BxAL7Iug29zlbdg==
X-Google-Smtp-Source: APXvYqwsGOSD5flrnTSltEbjBX/WuFFbqInKkFlUr30Uh1BYrK/uT2f+/aOtrvvxfmcptN3z6ecpULr0sPMFQuf+GTE=
X-Received: by 2002:a05:620a:16a6:: with SMTP id s6mr8708369qkj.407.1571850414641;
 Wed, 23 Oct 2019 10:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000328b2905951a7667@google.com> <CANpmjNPoBBJgMKLEAXs+bPhitF+WygseHgTkSJsuiK8WcsB==g@mail.gmail.com>
 <20191017181709.GA5312@avx2> <CANpmjNOkpOQsmQKYLAJ1iuj6UYJqyY6PRaYXSyWbF=omfnj6Uw@mail.gmail.com>
In-Reply-To: <CANpmjNOkpOQsmQKYLAJ1iuj6UYJqyY6PRaYXSyWbF=omfnj6Uw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Oct 2019 19:06:43 +0200
Message-ID: <CACT4Y+YE8BtDJvbPfgDQq-HVwiPkg-7CTD1x8xCzeQTPuNG65Q@mail.gmail.com>
Subject: Re: KCSAN: data-race in task_dump_owner / task_dump_owner
To:     Marco Elver <elver@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        syzbot <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 8:33 PM 'Marco Elver' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Thu, 17 Oct 2019 at 20:17, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > On Thu, Oct 17, 2019 at 02:56:47PM +0200, Marco Elver wrote:
> > > Hi,
> > >
> > > On Thu, 17 Oct 2019 at 14:36, syzbot
> > > <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    d724f94f x86, kcsan: Enable KCSAN for x86
> > > > git tree:       https://github.com/google/ktsan.git kcsan
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17884db3600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e392f8008a294fdf8891
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KCSAN: data-race in task_dump_owner / task_dump_owner
> > > >
> > > > write to 0xffff8881255bb7fc of 4 bytes by task 7804 on cpu 0:
> > > >   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
> > > >   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
> > > >   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
> > > >   d_revalidate fs/namei.c:765 [inline]
> > > >   d_revalidate fs/namei.c:762 [inline]
> > > >   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
> > > >   walk_component+0x6d/0xe80 fs/namei.c:1804
> > > >   link_path_walk.part.0+0x5d3/0xa90 fs/namei.c:2139
> > > >   link_path_walk fs/namei.c:2070 [inline]
> > > >   path_openat+0x14f/0x3530 fs/namei.c:3532
> > > >   do_filp_open+0x11e/0x1b0 fs/namei.c:3563
> > > >   do_sys_open+0x3b3/0x4f0 fs/open.c:1089
> > > >   __do_sys_open fs/open.c:1107 [inline]
> > > >   __se_sys_open fs/open.c:1102 [inline]
> > > >   __x64_sys_open+0x55/0x70 fs/open.c:1102
> > > >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> > > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >
> > > > write to 0xffff8881255bb7fc of 4 bytes by task 7813 on cpu 1:
> > > >   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
> > > >   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
> > > >   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
> > > >   d_revalidate fs/namei.c:765 [inline]
> > > >   d_revalidate fs/namei.c:762 [inline]
> > > >   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
> > > >   walk_component+0x6d/0xe80 fs/namei.c:1804
> > > >   lookup_last fs/namei.c:2271 [inline]
> > > >   path_lookupat.isra.0+0x13a/0x5a0 fs/namei.c:2316
> > > >   filename_lookup+0x145/0x2d0 fs/namei.c:2346
> > > >   user_path_at_empty+0x4c/0x70 fs/namei.c:2606
> > > >   user_path_at include/linux/namei.h:60 [inline]
> > > >   vfs_statx+0xd9/0x190 fs/stat.c:187
> > > >   vfs_stat include/linux/fs.h:3188 [inline]
> > > >   __do_sys_newstat+0x51/0xb0 fs/stat.c:341
> > > >   __se_sys_newstat fs/stat.c:337 [inline]
> > > >   __x64_sys_newstat+0x3a/0x50 fs/stat.c:337
> > > >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> > > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >
> > > > Reported by Kernel Concurrency Sanitizer on:
> > > > CPU: 1 PID: 7813 Comm: ps Not tainted 5.3.0+ #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > ==================================================================
> > >
> > > My understanding is, that for every access to /proc/<pid>,
> > > d_revalidate is called, and /proc-fs implementation simply says that
> > > pid_revalidate always revalidates by rewriting uid/gid because "owning
> > > task may have performed a setuid(), etc." presumably so every access
> > > to a /proc/<pid> entry always has the right uid/gid (in effect
> > > updating /proc/<pid> lazily via d_revalidate).
> > >
> > > Is it possible that one of the tasks above could be preempted after
> > > doing its writes to *ruid/*rgid, another thread writing some other
> > > values (after setuid / seteuid), and then the preempted thread seeing
> > > the other values? Assertion here should never fail:
> > > === TASK 1 ===
> > > | seteuid(1000);
> > > | seteuid(0);
> > > | stat("/proc/<pid-of-task-1>", &fstat);
> > > | assert(fstat.st_uid == 0);
> > > === TASK 2 ===
> > > | stat("/proc/<pid-of-task-1>", ...);
> >
> > Is it the same as
> > pid_revalidate() snapshots (uid,gid) correctly
> > but writeback is done in any order?
>
> Yes, I think so. Snapshot is done in RCU reader critical section, but
> the writes can race with another thread. Is there logic that ensures
> this doesn't lead to the observable outcome above?


I found the case where this leads to an observable bug.
common_perm_cond() in security/apparmor/lsm.c reads the inode uid and
uses it for the security check:

static int common_perm_cond(const char *op, const struct path *path, u32 mask)
{
      struct path_cond cond = { d_backing_inode(path->dentry)->i_uid,

d_backing_inode(path->dentry)->i_mode
      };

Now consider the following test program:

#define _GNU_SOURCE
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>

void *thr(void *arg)
{
        for (;;) {
                struct stat file_stat;
                stat((char*)arg, &file_stat);
        }
        return 0;
}

int main(int argc, char *argv[])
{
        char proc[32];
        sprintf(proc, "/proc/%d", getpid());
        printf("%s\n", proc);
        pthread_t th;
        pthread_create(&th, 0, thr, proc);
        for (;;) {
                seteuid(1000);
                usleep(1);
                seteuid(0);
                struct stat file_stat;
                stat(proc, &file_stat);
        }
        return 0;
}

Whenever the main thread does stat, it must observe inode.uid == 0 in
common_perm_cond().

But since task_dump_owner() does writeback out of order, it can lead
to non-linearizable executions and main thread observing inode.uid ==
1000.
This in turn can lead to both false negatives and false positives from
AppArmour (false denying access and falsely permitting access).

I don't know how to setup actual AppArmour profile to do this, but I
see this guide mentions "owner @{PROC}/[0-9]*" in a policy, so I
assume it's possible:
https://gitlab.com/apparmor/apparmor/wikis/Profiling_by_hand

Instead, I added the following check to common_perm_cond() (it's
dirty, but you get the idea):

@@ -218,6 +218,15 @@ static int common_perm_cond(const char *op, const
struct path *path, u32 mask)
                                  d_backing_inode(path->dentry)->i_mode
        };
+       if (op == OP_GETATTR && mask == AA_MAY_GETATTR && cond.uid.val != 0) {
+               char buf1[64], buf2[64];
+               char *str = d_path(path, buf1, sizeof(buf1));
+               sprintf(buf2, "/proc/%d", current->pid);
+               if (!strcmp(str, buf2))
+                       pr_err("common_perm_cond: path=%s pid=%d uid=%d\n",
+                               str, current->pid, cond.uid.val);
+       }

Now when I run the program, I see how it fires every few seconds:

# ./a.out
/proc/1548
[  123.233107] common_perm_cond: path=/proc/1548 pid=1548 uid=1000
[  126.142869] common_perm_cond: path=/proc/1548 pid=1548 uid=1000
[  127.048353] common_perm_cond: path=/proc/1548 pid=1548 uid=1000
[  128.181873] common_perm_cond: path=/proc/1548 pid=1548 uid=1000
[  128.557104] common_perm_cond: path=/proc/1548 pid=1548 uid=1000
[  144.690774] common_perm_cond: path=/proc/1548 pid=1548 uid=1000

Which means AppArmour acts based on the wrong UID. Obviously can lead
to falsely denying access, but also falsely permitting access.
Consider the following scenario.
A process sets owner UID on a file so that a child process won't be
able to access it, after that it starts the child process.
common_perm_cond() in the child process should observe the new owner
UID. However, if there a random other process simply doing stat() or
something similar on the file, now the common_perm_cond() in the child
can suddenly observe the old UID, which will be permitted by
AppArmour. Boom!

I've tried to apply "proc: fix inode uid/gid writeback race":
https://lore.kernel.org/lkml/20191020173010.GA14744@avx2/
but it does _not_ help because it does not really resolve the
non-atomic snapshot and writeback of UID.
