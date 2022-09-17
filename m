Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3345BB9E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIQScR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Sep 2022 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIQScP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Sep 2022 14:32:15 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6832C66C
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 11:32:14 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 125so15826347ybt.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XuJnLWdoR6SviPcUc/49at2QbmUOJmkyf0qoFnjTlRM=;
        b=jU9hKS7ygUDxtTFOXLH4RSn40IlDB7mfQJJahl+Z+Mf6mo0esTBhFpDLbs6+6r34ya
         DmDsXBkD26yaoOtLj5uiKBgyMkkefygI8tw6p38pjmT6+bwa5DXXVxZUizSV3VQfsj0s
         AkbXooeEDFa6T2D8Jt2sDWFsMRVId3YLzn8Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XuJnLWdoR6SviPcUc/49at2QbmUOJmkyf0qoFnjTlRM=;
        b=33hxSE3vbm5OMoIeokArdvH2y3zHmH7fgfbY7UqyyXvnaAZRY7EtKuNIUSdRGH7Mf6
         VQ2lspvy87kUjdgCiSk6oqEs10ourV3qDOW7ZkU3n21ZDEdfdU9N6QIIy7n9lOYF/958
         TpFJ4tytHsM8GJ3jnXoHvVIduUnAswyzFT5hpEYBuPFR+tNZmC2OfvfCPpqKN5B2EZ+J
         QIAhCP8/Vi6x+5ew96B9vpqh5cUKkRPUcqxZi4kK0F3atV+YnfijVYJZ0ExOnNaVR3L1
         lesNcXKbL1pcfosPeuogbBFbxMiQRcCE6Vm7ahf8WUnZjZHlvJZQ3QKIOFxlW+VVM7c/
         CTMQ==
X-Gm-Message-State: ACrzQf33c5soXHC8HwXxtNBCryyU72EW2gX/fSwXeEsj1J2xxAhP/iAz
        WF48zk/qMqffXUIQlXAebpQ2M0gYqObmRiA3PxQh4WUzd9Ut6A==
X-Google-Smtp-Source: AMsMyM5mAYaGVuVzPinrO1XvntIhSdFbE5ZHoHgX8xEqSzyqRQN4/JaIXf/Kfak2q23rDcCc+sdTR5TexdKj9GReMeE=
X-Received: by 2002:a05:6902:72f:b0:6b1:d9:79d2 with SMTP id
 l15-20020a056902072f00b006b100d979d2mr2026914ybt.201.1663439533294; Sat, 17
 Sep 2022 11:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220916230853.49056-1-ivan@cloudflare.com> <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
 <YyV0AZ9+Zz4aopq4@localhost.localdomain>
In-Reply-To: <YyV0AZ9+Zz4aopq4@localhost.localdomain>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Sat, 17 Sep 2022 11:32:02 -0700
Message-ID: <CABWYdi1LX5n1DdL1B7s+=TVK=5JDMVyp91d3yRDA0_GW4Xy8wg@mail.gmail.com>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > * Make fd count acces O(1) and expose it in /proc/pid/status
>
> This is doable, next to FDSize.

It feels like a better solution, but maybe I'm missing some context
here. Let me know whether this is preferred.

That said, I've tried doing it, but failed. There's a noticeable
mismatch in the numbers:

* systemd:

ivan@vm:~$ sudo ls -l /proc/1/fd | wc -l
66
ivan@vm:~$ cat /proc/1/status | fgrep FD
FDSize: 256
FDUsed: 71

* journald:

ivan@vm:~$ sudo ls -l /proc/803/fd | wc -l
29
ivan@vm:~$ cat /proc/803/status | fgrep FD
FDSize: 128
FDUsed: 37

I'll see if I can make it work next week. I'm happy to receive tips as well.

Below is my attempt (link in case gmail breaks patch formatting):

* https://gist.githubusercontent.com/bobrik/acce40881d629d8cce2e55966b31a0a2/raw/716eb4724a8fe3afeeb76fd2a7a47ee13790a9e9/fdused.patch

diff --git a/fs/file.c b/fs/file.c
index 3bcc1ecc314a..8bc0741cabf1 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -85,6 +85,8 @@ static void copy_fdtable(struct fdtable *nfdt,
struct fdtable *ofdt)
  memset((char *)nfdt->fd + cpy, 0, set);

  copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+
+ atomic_set(&nfdt->count, atomic_read(&ofdt->count));
 }

 /*
@@ -105,6 +107,7 @@ static void copy_fdtable(struct fdtable *nfdt,
struct fdtable *ofdt)
 static struct fdtable * alloc_fdtable(unsigned int nr)
 {
  struct fdtable *fdt;
+ atomic_t count = ATOMIC_INIT(0);
  void *data;

  /*
@@ -148,6 +151,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
  fdt->close_on_exec = data;
  data += nr / BITS_PER_BYTE;
  fdt->full_fds_bits = data;
+ fdt->count = count;

  return fdt;

@@ -399,6 +403,8 @@ struct files_struct *dup_fd(struct files_struct
*oldf, unsigned int max_fds, int
  /* clear the remainder */
  memset(new_fds, 0, (new_fdt->max_fds - open_files) * sizeof(struct file *));

+ atomic_set(&new_fdt->count, atomic_read(&old_fdt->count));
+
  rcu_assign_pointer(newf->fdt, new_fdt);

  return newf;
@@ -474,6 +480,7 @@ struct files_struct init_files = {
  .close_on_exec = init_files.close_on_exec_init,
  .open_fds = init_files.open_fds_init,
  .full_fds_bits = init_files.full_fds_bits_init,
+ .count = ATOMIC_INIT(0),
  },
  .file_lock = __SPIN_LOCK_UNLOCKED(init_files.file_lock),
  .resize_wait = __WAIT_QUEUE_HEAD_INITIALIZER(init_files.resize_wait),
@@ -613,6 +620,7 @@ void fd_install(unsigned int fd, struct file *file)
  BUG_ON(fdt->fd[fd] != NULL);
  rcu_assign_pointer(fdt->fd[fd], file);
  spin_unlock(&files->file_lock);
+ atomic_inc(&fdt->count);
  return;
  }
  /* coupled with smp_wmb() in expand_fdtable() */
@@ -621,6 +629,7 @@ void fd_install(unsigned int fd, struct file *file)
  BUG_ON(fdt->fd[fd] != NULL);
  rcu_assign_pointer(fdt->fd[fd], file);
  rcu_read_unlock_sched();
+ atomic_inc(&fdt->count);
 }

 EXPORT_SYMBOL(fd_install);
@@ -646,6 +655,7 @@ static struct file *pick_file(struct files_struct
*files, unsigned fd)
  if (file) {
  rcu_assign_pointer(fdt->fd[fd], NULL);
  __put_unused_fd(files, fd);
+ atomic_dec(&fdt->count);
  }
  return file;
 }
@@ -844,6 +854,7 @@ void do_close_on_exec(struct files_struct *files)
  filp_close(file, files);
  cond_resched();
  spin_lock(&files->file_lock);
+ atomic_dec(&fdt->count);
  }

  }
@@ -1108,6 +1119,7 @@ __releases(&files->file_lock)
  else
  __clear_close_on_exec(fd, fdt);
  spin_unlock(&files->file_lock);
+ atomic_inc(&fdt->count);

  if (tofree)
  filp_close(tofree, files);
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 99fcbfda8e25..5847f077bfc3 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -153,7 +153,8 @@ static inline void task_state(struct seq_file *m,
struct pid_namespace *ns,
  struct task_struct *tracer;
  const struct cred *cred;
  pid_t ppid, tpid = 0, tgid, ngid;
- unsigned int max_fds = 0;
+ struct fdtable *fdt;
+ unsigned int max_fds = 0, open_fds = 0;

  rcu_read_lock();
  ppid = pid_alive(p) ?
@@ -170,8 +171,11 @@ static inline void task_state(struct seq_file *m,
struct pid_namespace *ns,
  task_lock(p);
  if (p->fs)
  umask = p->fs->umask;
- if (p->files)
- max_fds = files_fdtable(p->files)->max_fds;
+ if (p->files) {
+ fdt = files_fdtable(p->files);
+ max_fds = fdt->max_fds;
+ open_fds = atomic_read(&fdt->count);
+ }
  task_unlock(p);
  rcu_read_unlock();

@@ -194,6 +198,7 @@ static inline void task_state(struct seq_file *m,
struct pid_namespace *ns,
  seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->sgid));
  seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->fsgid));
  seq_put_decimal_ull(m, "\nFDSize:\t", max_fds);
+ seq_put_decimal_ull(m, "\nFDUsed:\t", open_fds);

  seq_puts(m, "\nGroups:\t");
  group_info = cred->group_info;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..59aceb1e4bc6 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -31,6 +31,7 @@ struct fdtable {
  unsigned long *open_fds;
  unsigned long *full_fds_bits;
  struct rcu_head rcu;
+ atomic_t count;
 };

 static inline bool close_on_exec(unsigned int fd, const struct fdtable *fdt)


> > > +
> > > +   generic_fillattr(&init_user_ns, inode, stat);
>                          ^^^^^^^^^^^^^
>
> Is this correct? I'm not userns guy at all.

I mostly copied from here:

* https://elixir.bootlin.com/linux/v6.0-rc5/source/fs/proc/generic.c#L150

Maybe it can be simplified even further to match this one:

* https://elixir.bootlin.com/linux/v6.0-rc5/source/fs/proc/root.c#L317
