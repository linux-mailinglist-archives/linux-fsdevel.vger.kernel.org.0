Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2FED378
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 14:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfKCNUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 08:20:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42651 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfKCNUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 08:20:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so4118401qtn.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2019 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvZDTg6KgNl1RRJLKsvptgnVUd3pDUaVxrmsOG02VjE=;
        b=muXjX6EkZezEHv58wqoRy0ZDpqiHE3fYf2yWpgKEtHHZtSeOS67EAC1dFDnPwOBG1p
         su1tdgHJeeFhUPw32pEMm8FshW8CXCSa3TLituQX/LqemUCa7mRUswutyhqTnLtB8gnJ
         YTfbMDoie4ol7c1QHHTlzNJ01UVHaRtcczAGNrWFv3ZDc6wJYhY1h1OIpAmwh3p7L+jg
         LCUrjcQOszBo5RrRpaDTh864H5qHc92SPQi349h5BclEeBBuPnO/uWjY/Eq4uM576jY4
         l8mTHXBXF/bc8hF/hSb+WXSCn2ViBfMS4zybBwXnPfUfbUU8rOeIEO7cknSRmgBVWHHu
         hDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvZDTg6KgNl1RRJLKsvptgnVUd3pDUaVxrmsOG02VjE=;
        b=KMEB42Jd3SIBXtO1zG4c5ngbbFIfzzWRC55RKU418w2XG+ZVj9dk7+fx+saJNcSPmb
         BCluKvAttMqN+7EA3IdvcTBG61rS4YiIEPmAx/5gMhMrwgyotUTAGAsHiLGTZOEiIRdj
         vqcPfzmNGmhOGWIx0jj2frdC0Z0gLWcj/gpDeR/v7Wv14cK3lNxu8DeCcSSah+ybyfvb
         ZOKIaGw41QavKQ2fVNDs1Gq+0W89wBRs9zm8POIS53ZEWmfmf4JnuKFCvQwBAmDrTvO+
         58Th5j9VbBk0usplSwo3ClKLLQiBlqyjr8jiwUpvbwkDRcqltn0pHXi7hsWzt8/7dIyH
         7+Wg==
X-Gm-Message-State: APjAAAWnSZwEVB4/E4JQMzb+elH9dMT8a8KNoDAOvOPiwOiz9ZqKfhxt
        8Xq7k/V5YF3SSI8p+TegBbKAjwAjkxMCvE/U8nr0Jw==
X-Google-Smtp-Source: APXvYqy0g3Hr5wgbS0e99pI1t0rYFYpkV7KVM+rnH00eH2yx1wUc986D3sOmkMxjtt04cl411iCoHuUNzIFo7+FiCms=
X-Received: by 2002:ac8:4157:: with SMTP id e23mr8391764qtm.158.1572787232201;
 Sun, 03 Nov 2019 05:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20191020173010.GA14744@avx2> <CANpmjNPzkYQjQ1mtJ6-h+6-=igD=GSnN9Sr6B6jpXrH9UJEUxg@mail.gmail.com>
 <20191021183216.GA28801@avx2>
In-Reply-To: <20191021183216.GA28801@avx2>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 3 Nov 2019 14:20:20 +0100
Message-ID: <CACT4Y+Y2JzAZ5OJg-5Ng3ArcGD3xyjNqgg2x4QnJLoc03znbLA@mail.gmail.com>
Subject: Re: [PATCH] proc: fix inode uid/gid writeback race
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:32 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Mon, Oct 21, 2019 at 11:24:27AM +0200, Marco Elver wrote:
> > On Sun, 20 Oct 2019 at 19:30, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > (euid, egid) pair is snapshotted correctly from task under RCU,
> > > but writeback to inode can be done in any order.
> > >
> > > Fix by doing writeback under inode->i_lock where necessary
> > > (/proc/* , /proc/*/fd/* , /proc/*/map_files/* revalidate).
> > >
> > > Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> >
> > Thanks!
> >
> > This certainly fixes the problem of inconsistent uid/gid pair due to
> > racing writebacks, as well as the data-race. If that is the only
> > purpose of this patch, then from what I see this is fine:
> >
> > Acked-by: Marco Elver <elver@google.com>
> >
> > However, there is probably still a more fundamental problem as outlined below.
> >
> > >  fs/proc/base.c     |   25 +++++++++++++++++++++++--
> > >  fs/proc/fd.c       |    2 +-
> > >  fs/proc/internal.h |    2 ++
> > >  3 files changed, 26 insertions(+), 3 deletions(-)
> > >
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -1743,6 +1743,25 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
> > >         *rgid = gid;
> > >  }
> > >
> > > +/* use if inode is live */
> > > +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> > > +                             struct inode *inode)
> > > +{
> > > +       kuid_t uid;
> > > +       kgid_t gid;
> > > +
> > > +       task_dump_owner(task, mode, &uid, &gid);
> > > +       /*
> > > +        * There is no atomic "change all credentials at once" system call,
> > > +        * guaranteeing more than _some_ snapshot from "struct cred" ends up
> > > +        * in inode is not possible.
> > > +        */
> > > +       spin_lock(&inode->i_lock);
> > > +       inode->i_uid = uid;
> > > +       inode->i_gid = gid;
> > > +       spin_unlock(&inode->i_lock);
> >
> > 2 tasks can still race here, and the inconsistent scenario I outlined in
> > https://lore.kernel.org/linux-fsdevel/000000000000328b2905951a7667@google.com/
> > could still happen I think (although extremely unlikely). Mainly,
> > causality may still be violated -- but I may be wrong as I don't know
> > the rest of the code (so please be critical of my suggestion).
> >
> > The problem is that if 2 threads race here, one has snapshotted old
> > uid/gid, and the other the new uid/gid. Then it is still possible for
> > the old uid/gid to be written back after new uid/gid, which would
> > result in this bad scenario:
> >
> > === TASK 1 ===
> > | seteuid(1000);
> > | seteuid(0);
> > | stat("/proc/<pid-of-task-1>", &fstat);
> > | assert(fstat.st_uid == 0);  // fails
> > === TASK 2 ===
> > | stat("/proc/<pid-of-task-1>", ...);
> >
> > AFAIK it's not something that can easily be fixed without some
> > timestamp on the uid/gid pair (timestamp updated after setuid/seteuid
> > etc) obtained in the RCU reader critical section. Then in this
> > critical section, uid/gid should only be written if the current pair
> > in inode is older according to snapshot timestamp.
>
> This probably requires bloating "struct cred" with generation number.
> I'm not sure what to do other than cc our credential overlords.

Just in case, this bug can lead to bad observable behavior, e.g.
bypassing LSM checks (apparmor) and this patch does not fix the
underlying problem. For details see:
https://groups.google.com/d/msg/syzkaller-bugs/mzwiXt4ml68/GuAUQrWtBQAJ


> > > +}
> > > +
> > >  struct inode *proc_pid_make_inode(struct super_block * sb,
> > >                                   struct task_struct *task, umode_t mode)
> > >  {
> > > @@ -1769,6 +1788,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
> > >         if (!ei->pid)
> > >                 goto out_unlock;
> > >
> > > +       /* fresh inode -- no races */
> > >         task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > >         security_task_to_inode(task, inode);
> > >
> > > @@ -1802,6 +1822,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
> > >                          */
> > >                         return -ENOENT;
> > >                 }
> > > +               /* "struct kstat" is thread local, atomic snapshot is enough */
> > >                 task_dump_owner(task, inode->i_mode, &stat->uid, &stat->gid);
> > >         }
> > >         rcu_read_unlock();
> > > @@ -1815,7 +1836,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
> > >   */
> > >  void pid_update_inode(struct task_struct *task, struct inode *inode)
> > >  {
> > > -       task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
> > > +       task_dump_owner_to_inode(task, inode->i_mode, inode);
> > >
> > >         inode->i_mode &= ~(S_ISUID | S_ISGID);
> > >         security_task_to_inode(task, inode);
> > > @@ -1990,7 +2011,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
> > >         mmput(mm);
> > >
> > >         if (exact_vma_exists) {
> > > -               task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > > +               task_dump_owner_to_inode(task, 0, inode);
> > >
> > >                 security_task_to_inode(task, inode);
> > >                 status = 1;
> > > --- a/fs/proc/fd.c
> > > +++ b/fs/proc/fd.c
> > > @@ -101,7 +101,7 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
> > >  static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
> > >                                 fmode_t f_mode)
> > >  {
> > > -       task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> > > +       task_dump_owner_to_inode(task, 0, inode);
> > >
> > >         if (S_ISLNK(inode->i_mode)) {
> > >                 unsigned i_mode = S_IFLNK;
> > > --- a/fs/proc/internal.h
> > > +++ b/fs/proc/internal.h
> > > @@ -123,6 +123,8 @@ static inline struct task_struct *get_proc_task(const struct inode *inode)
> > >
> > >  void task_dump_owner(struct task_struct *task, umode_t mode,
> > >                      kuid_t *ruid, kgid_t *rgid);
> > > +void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
> > > +                             struct inode *inode);
> > >
> > >  unsigned name_to_int(const struct qstr *qstr);
> > >  /*
