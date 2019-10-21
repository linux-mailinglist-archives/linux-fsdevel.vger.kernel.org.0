Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCADE805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJUJYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:24:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44970 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUJYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:24:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so10344385otj.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DELCu3OlSAGY6ULseg5/HJriVPHZSLSqlAmQPI5GeFw=;
        b=Hxap7ljDfVD81M07heYfSLFD2HS9D/dLrnN25mV7jWYSebOfff61JKzGDM8Kdi6RSZ
         NCWz8mpSzbUXPhRWgG5iphJ5VxhrqD53tLFlf1ZV/fJIMSv/wSuUEjDhZSMeytpGyJ/s
         LcHGzAfhtsjzFexpxiqtJrbBIKU6B0exOK8QlLKiHB9DM86NGOOZghhCKwhIw+Hs4QGa
         THkRqd/j+3QcGEmRTpvaUzZf8Vy7fk0/Kg+7G0dhhYUCR9tKordqCFG/22fEdf3lKn4x
         Km5EonpBbBn0BdpHq9BFLtkOzPgnSwSJtRDLgHBxcshRXtrVfacb3PJqLsIT0N/aE4RU
         sIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DELCu3OlSAGY6ULseg5/HJriVPHZSLSqlAmQPI5GeFw=;
        b=V5U021X74JrcZyLajjzwIv/yuXlHC6VsrKgf5aEVxxrpFX/TOCrX0wgMVAX90n9pBX
         nx1lmHOW7zPDgJG6OtwefQ+BwYh16iiBx2jhqtgzqV7rN3seT7CGjiJorZaPBHWgkwM3
         5k+pkC2rGz4XnGCSrqDD1/PqPhQCZ1GLS4Q4yzTW7JLZsPnVBIHg5nSRhT4wb5N+tCQR
         P9OqHbJA2feZoD269L0Mo6VMoJAkDwHMFlduprEtYiDtB9IZcwOlA4r/oHW0sMWfG7SX
         hW/UFPMH3QLTy96Bb6pR3HAXFk4nWGRs4KfPVRjNqQ9mTXZMLvFZII+r+EtPOqQFZ8w7
         jbbA==
X-Gm-Message-State: APjAAAUjxTmS2hNHBZDcG9Cy/seftuObftoY5G6B+Ts7ZadUzoWhkhDu
        3MCGx8iYJY/6z4Q9LmnFUJd6+Qq7F19IvDBHXFXPSw==
X-Google-Smtp-Source: APXvYqyNe6uu8LVMvmDZSgGvrWnt+hJcoNmoQaGw4YBSrU/2RhEEdK8PfPuRGqpe6mRLNzkgLhwlByZ7gQD0m5eBKGo=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr17338841otk.2.1571649878890;
 Mon, 21 Oct 2019 02:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191020173010.GA14744@avx2>
In-Reply-To: <20191020173010.GA14744@avx2>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Oct 2019 11:24:27 +0200
Message-ID: <CANpmjNPzkYQjQ1mtJ6-h+6-=igD=GSnN9Sr6B6jpXrH9UJEUxg@mail.gmail.com>
Subject: Re: [PATCH] proc: fix inode uid/gid writeback race
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 20 Oct 2019 at 19:30, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> (euid, egid) pair is snapshotted correctly from task under RCU,
> but writeback to inode can be done in any order.
>
> Fix by doing writeback under inode->i_lock where necessary
> (/proc/* , /proc/*/fd/* , /proc/*/map_files/* revalidate).
>
> Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---

Thanks!

This certainly fixes the problem of inconsistent uid/gid pair due to
racing writebacks, as well as the data-race. If that is the only
purpose of this patch, then from what I see this is fine:

Acked-by: Marco Elver <elver@google.com>

However, there is probably still a more fundamental problem as outlined below.

>  fs/proc/base.c     |   25 +++++++++++++++++++++++--
>  fs/proc/fd.c       |    2 +-
>  fs/proc/internal.h |    2 ++
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1743,6 +1743,25 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
>         *rgid = gid;
>  }
>
> +/* use if inode is live */
> +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> +                             struct inode *inode)
> +{
> +       kuid_t uid;
> +       kgid_t gid;
> +
> +       task_dump_owner(task, mode, &uid, &gid);
> +       /*
> +        * There is no atomic "change all credentials at once" system call,
> +        * guaranteeing more than _some_ snapshot from "struct cred" ends up
> +        * in inode is not possible.
> +        */
> +       spin_lock(&inode->i_lock);
> +       inode->i_uid = uid;
> +       inode->i_gid = gid;
> +       spin_unlock(&inode->i_lock);

2 tasks can still race here, and the inconsistent scenario I outlined in
https://lore.kernel.org/linux-fsdevel/000000000000328b2905951a7667@google.com/
could still happen I think (although extremely unlikely). Mainly,
causality may still be violated -- but I may be wrong as I don't know
the rest of the code (so please be critical of my suggestion).

The problem is that if 2 threads race here, one has snapshotted old
uid/gid, and the other the new uid/gid. Then it is still possible for
the old uid/gid to be written back after new uid/gid, which would
result in this bad scenario:

=== TASK 1 ===
| seteuid(1000);
| seteuid(0);
| stat("/proc/<pid-of-task-1>", &fstat);
| assert(fstat.st_uid == 0);  // fails
=== TASK 2 ===
| stat("/proc/<pid-of-task-1>", ...);

AFAIK it's not something that can easily be fixed without some
timestamp on the uid/gid pair (timestamp updated after setuid/seteuid
etc) obtained in the RCU reader critical section. Then in this
critical section, uid/gid should only be written if the current pair
in inode is older according to snapshot timestamp.

> +}
> +
>  struct inode *proc_pid_make_inode(struct super_block * sb,
>                                   struct task_struct *task, umode_t mode)
>  {
> @@ -1769,6 +1788,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>         if (!ei->pid)
>                 goto out_unlock;
>
> +       /* fresh inode -- no races */
>         task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
>         security_task_to_inode(task, inode);
>
> @@ -1802,6 +1822,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
>                          */
>                         return -ENOENT;
>                 }
> +               /* "struct kstat" is thread local, atomic snapshot is enough */
>                 task_dump_owner(task, inode->i_mode, &stat->uid, &stat->gid);
>         }
>         rcu_read_unlock();
> @@ -1815,7 +1836,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
>   */
>  void pid_update_inode(struct task_struct *task, struct inode *inode)
>  {
> -       task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
> +       task_dump_owner_to_inode(task, inode->i_mode, inode);
>
>         inode->i_mode &= ~(S_ISUID | S_ISGID);
>         security_task_to_inode(task, inode);
> @@ -1990,7 +2011,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
>         mmput(mm);
>
>         if (exact_vma_exists) {
> -               task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> +               task_dump_owner_to_inode(task, 0, inode);
>
>                 security_task_to_inode(task, inode);
>                 status = 1;
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -101,7 +101,7 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
>  static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
>                                 fmode_t f_mode)
>  {
> -       task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> +       task_dump_owner_to_inode(task, 0, inode);
>
>         if (S_ISLNK(inode->i_mode)) {
>                 unsigned i_mode = S_IFLNK;
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -123,6 +123,8 @@ static inline struct task_struct *get_proc_task(const struct inode *inode)
>
>  void task_dump_owner(struct task_struct *task, umode_t mode,
>                      kuid_t *ruid, kgid_t *rgid);
> +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> +                             struct inode *inode);
>
>  unsigned name_to_int(const struct qstr *qstr);
>  /*
