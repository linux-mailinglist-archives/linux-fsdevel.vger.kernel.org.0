Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5BFDF523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfJUScX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 14:32:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38960 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUScW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:32:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so3665264edr.6;
        Mon, 21 Oct 2019 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1++5t6Rwb9pxiPNFI76VzqQJsccXygwdwhbPrCaOi10=;
        b=bZwx7VqF7KAKqK1AgogKMy4az7kJS1cZVA24tqrO7E1/kVPFRqVVmob0big0BZfIcB
         5hq4mDUVQkM8WuZNqlVdBJJSXniBaWkDmXROw2l31wasGy6zXZivEjpycsCQHNb/uDfC
         sSh5GubSh7AAudrw4KRm+ZRTYvP5BKTMorbU/HHVdLt+sUpDf2y+4KSEt5AojjG64/vf
         172dFnx8Xa+AJ5+D+aQri1wnyTr4x155mQrzJj7qOlVz3nMbguknHoEsTK2WvMGxkWoC
         iJe2M/FCnGryusmcF2qhe30vFnA72e2aDINYNHXMJp6pysFb0hCahWzHKwQkccYWzvaR
         1VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1++5t6Rwb9pxiPNFI76VzqQJsccXygwdwhbPrCaOi10=;
        b=OpaNVQIZnMjOk1DRiMfeKwYfwAfzSRZigE4umrz6XsnFZCv7Jwp+So87yFCd/NTJcx
         iu/a/il85kFnxulS2F05jpGeakDzLDUQlCHQkAMHEJDxvBpC0ANeGZEfSAClk1UPANq/
         LEMezaTc+W26XMyZaYe2m8zClefdEulI713r2/ISLhneq1gRdtOISpYwonhnVkcKmhBg
         HCGS56SftencRDBp+SBfiGdUUYFr6nx/0WdKyrgT5qatmydU7PrK6uJ03w6n7WLFTzg6
         bfhM7amxAJ8kLLRW/s4RZ3HmDwKYMHZpCs/p4GtaoT3DazpQ6M/JiKcNBy3Jl+xlWbOM
         5VjA==
X-Gm-Message-State: APjAAAUU/vAU7Ekr791BdjT1ZdeAGSTa451PfEDsLexYyyjdSW+s9Wc3
        shF/dapzNBLz4pzt4n1F1Q==
X-Google-Smtp-Source: APXvYqyq2hdU928PrcaQNRr8In3w1tDREj3YiIaZE2Zvw66g5TgaonYT6fDOEPbe+w/YhNflMcay9Q==
X-Received: by 2002:aa7:c612:: with SMTP id h18mr26735238edq.245.1571682739304;
        Mon, 21 Oct 2019 11:32:19 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id s8sm124078edj.6.2019.10.21.11.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:32:18 -0700 (PDT)
Date:   Mon, 21 Oct 2019 21:32:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Marco Elver <elver@google.com>, dhowells@redhat.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: fix inode uid/gid writeback race
Message-ID: <20191021183216.GA28801@avx2>
References: <20191020173010.GA14744@avx2>
 <CANpmjNPzkYQjQ1mtJ6-h+6-=igD=GSnN9Sr6B6jpXrH9UJEUxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPzkYQjQ1mtJ6-h+6-=igD=GSnN9Sr6B6jpXrH9UJEUxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:24:27AM +0200, Marco Elver wrote:
> On Sun, 20 Oct 2019 at 19:30, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > (euid, egid) pair is snapshotted correctly from task under RCU,
> > but writeback to inode can be done in any order.
> >
> > Fix by doing writeback under inode->i_lock where necessary
> > (/proc/* , /proc/*/fd/* , /proc/*/map_files/* revalidate).
> >
> > Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> 
> Thanks!
> 
> This certainly fixes the problem of inconsistent uid/gid pair due to
> racing writebacks, as well as the data-race. If that is the only
> purpose of this patch, then from what I see this is fine:
> 
> Acked-by: Marco Elver <elver@google.com>
> 
> However, there is probably still a more fundamental problem as outlined below.
> 
> >  fs/proc/base.c     |   25 +++++++++++++++++++++++--
> >  fs/proc/fd.c       |    2 +-
> >  fs/proc/internal.h |    2 ++
> >  3 files changed, 26 insertions(+), 3 deletions(-)
> >
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1743,6 +1743,25 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
> >         *rgid = gid;
> >  }
> >
> > +/* use if inode is live */
> > +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> > +                             struct inode *inode)
> > +{
> > +       kuid_t uid;
> > +       kgid_t gid;
> > +
> > +       task_dump_owner(task, mode, &uid, &gid);
> > +       /*
> > +        * There is no atomic "change all credentials at once" system call,
> > +        * guaranteeing more than _some_ snapshot from "struct cred" ends up
> > +        * in inode is not possible.
> > +        */
> > +       spin_lock(&inode->i_lock);
> > +       inode->i_uid = uid;
> > +       inode->i_gid = gid;
> > +       spin_unlock(&inode->i_lock);
> 
> 2 tasks can still race here, and the inconsistent scenario I outlined in
> https://lore.kernel.org/linux-fsdevel/000000000000328b2905951a7667@google.com/
> could still happen I think (although extremely unlikely). Mainly,
> causality may still be violated -- but I may be wrong as I don't know
> the rest of the code (so please be critical of my suggestion).
> 
> The problem is that if 2 threads race here, one has snapshotted old
> uid/gid, and the other the new uid/gid. Then it is still possible for
> the old uid/gid to be written back after new uid/gid, which would
> result in this bad scenario:
> 
> === TASK 1 ===
> | seteuid(1000);
> | seteuid(0);
> | stat("/proc/<pid-of-task-1>", &fstat);
> | assert(fstat.st_uid == 0);  // fails
> === TASK 2 ===
> | stat("/proc/<pid-of-task-1>", ...);
> 
> AFAIK it's not something that can easily be fixed without some
> timestamp on the uid/gid pair (timestamp updated after setuid/seteuid
> etc) obtained in the RCU reader critical section. Then in this
> critical section, uid/gid should only be written if the current pair
> in inode is older according to snapshot timestamp.

This probably requires bloating "struct cred" with generation number.
I'm not sure what to do other than cc our credential overlords.

> > +}
> > +
> >  struct inode *proc_pid_make_inode(struct super_block * sb,
> >                                   struct task_struct *task, umode_t mode)
> >  {
> > @@ -1769,6 +1788,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
> >         if (!ei->pid)
> >                 goto out_unlock;
> >
> > +       /* fresh inode -- no races */
> >         task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> >         security_task_to_inode(task, inode);
> >
> > @@ -1802,6 +1822,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
> >                          */
> >                         return -ENOENT;
> >                 }
> > +               /* "struct kstat" is thread local, atomic snapshot is enough */
> >                 task_dump_owner(task, inode->i_mode, &stat->uid, &stat->gid);
> >         }
> >         rcu_read_unlock();
> > @@ -1815,7 +1836,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
> >   */
> >  void pid_update_inode(struct task_struct *task, struct inode *inode)
> >  {
> > -       task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
> > +       task_dump_owner_to_inode(task, inode->i_mode, inode);
> >
> >         inode->i_mode &= ~(S_ISUID | S_ISGID);
> >         security_task_to_inode(task, inode);
> > @@ -1990,7 +2011,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
> >         mmput(mm);
> >
> >         if (exact_vma_exists) {
> > -               task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > +               task_dump_owner_to_inode(task, 0, inode);
> >
> >                 security_task_to_inode(task, inode);
> >                 status = 1;
> > --- a/fs/proc/fd.c
> > +++ b/fs/proc/fd.c
> > @@ -101,7 +101,7 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
> >  static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
> >                                 fmode_t f_mode)
> >  {
> > -       task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > +       task_dump_owner_to_inode(task, 0, inode);
> >
> >         if (S_ISLNK(inode->i_mode)) {
> >                 unsigned i_mode = S_IFLNK;
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -123,6 +123,8 @@ static inline struct task_struct *get_proc_task(const struct inode *inode)
> >
> >  void task_dump_owner(struct task_struct *task, umode_t mode,
> >                      kuid_t *ruid, kgid_t *rgid);
> > +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> > +                             struct inode *inode);
> >
> >  unsigned name_to_int(const struct qstr *qstr);
> >  /*
