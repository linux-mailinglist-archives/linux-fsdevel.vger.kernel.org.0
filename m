Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE01331578
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 19:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhCHSHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 13:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhCHSG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:06:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87014C061760
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 10:06:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s16so5230501plr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FCoQQe6qSwrfqgd3qEOzXrTKGrS+9FdkbkwaZQjnWyA=;
        b=EImqdiUBJ+tprda7YfqaWhFRqDVz9ryw95HyqpXC0QRJ4ftaPtJxP8os21xT2W2TQZ
         V2j8GSarAekfSwUNCFK789tuU7oip9UPXlsiNTQ4xvMy/qIYJhDBTY7sRsIt2753feRw
         L8vVCms/mHMOg0yZQ9FDiarWQJcqPNQD7jOE/CiVvxOXtmc2M770kj3WIy8IQlWjbPmM
         Wkhb9Nvf5idJEVxtm4JLgxyDdtRuTwvPF7XjXr4jxkIN7w6ANq4YXouEQy8Azb+tHorr
         buNi3nasxHrRRyQzrDf4maTsMx4EHSvtFfmPsO3j8b3wRiK+4EMkw/cRN3G4e8SD9Hid
         znZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FCoQQe6qSwrfqgd3qEOzXrTKGrS+9FdkbkwaZQjnWyA=;
        b=soRtiji6p5BzYrysDHrkrz6pjCESqv3ZyLM+fJw3vUD736XfLxgtR81CZliS2pwbyH
         /6pOFfND+OaXywdzrn4VJM4C9tmoImCcZBQ38d1GaJRLMlOGHfbGoByDXw9IZGFCkQmt
         KwcasBeHk4S5a5eMoqC5PYSE8mDwQbcEhKg3GOSk4mHvodaX7yI2RLRkANJaJggeqNsi
         V1eZIzYNCSmiocumPEZ07jvoASkd7YB/h5DQeubsf69y2YFA+Zbjm/B0kq92epTM0itI
         c0KnrCjFE9B34p51IXP4hXP2Fpi5V/xQxhWIed2MmoW1uGvShNCruEXr30+fUtcgPvrA
         +phw==
X-Gm-Message-State: AOAM5305loAPjrAvivNDeCJDrHxufdlax9M/R7YNnQnbeuhbZ/UOhvZc
        5jZAZWrNy/R6tFS896Y0cH6WTMr2uqk1S46t+urOKQ==
X-Google-Smtp-Source: ABdhPJwe1qAb01loXOzfjJCGx8c9J7P5S+jvM49t5+56HOWkG3JPGL9lKnVzP5Un8wfNpsZg0qMqUcFs4j5Vsyjgdk8=
X-Received: by 2002:a17:90a:c918:: with SMTP id v24mr82113pjt.182.1615226817785;
 Mon, 08 Mar 2021 10:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20210308170651.919148-1-kaleshsingh@google.com> <a51dfd94-185a-63f1-3dba-84dcbe94cb56@amd.com>
In-Reply-To: <a51dfd94-185a-63f1-3dba-84dcbe94cb56@amd.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 8 Mar 2021 13:06:46 -0500
Message-ID: <CAC_TJvefj4COgvT=1JCfRCF-dP5k8kXE-n8A-oEFKH_CKnGusA@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, Helge Deller <deller@gmx.de>,
        James Morris <jamorris@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 8, 2021 at 12:54 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 08.03.21 um 18:06 schrieb Kalesh Singh:
> > Android captures per-process system memory state when certain low memor=
y
> > events (e.g a foreground app kill) occur, to identify potential memory
> > hoggers. In order to measure how much memory a process actually consume=
s,
> > it is necessary to include the DMA buffer sizes for that process in the
> > memory accounting. Since the handle to DMA buffers are raw FDs, it is
> > important to be able to identify which processes have FD references to
> > a DMA buffer.
> >
> > Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> > /proc/<pid>/fdinfo -- both are only readable by the process owner,
> > as follows:
> >    1. Do a readlink on each FD.
> >    2. If the target path begins with "/dmabuf", then the FD is a dmabuf=
 FD.
> >    3. stat the file to get the dmabuf inode number.
> >    4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
> >
> > Accessing other processes' fdinfo requires root privileges. This limits
> > the use of the interface to debugging environments and is not suitable
> > for production builds.  Granting root privileges even to a system proce=
ss
> > increases the attack surface and is highly undesirable.
> >
> > Since fdinfo doesn't permit reading process memory and manipulating
> > process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Both patches are Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com=
>

Thanks Christian.

>
> > ---
> > Hi everyone,
> >
> > The initial posting of this patch can be found at [1].
> > I didn't receive any feedback last time, so resending here.
> > Would really appreciate any constructive comments/suggestions.
> >
> > Thanks,
> > Kalesh
> >
> > [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flore.kernel.org%2Fr%2F20210208155315.1367371-1-kaleshsingh%40google.com%2F=
&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C38c98420f0564e15117f08d8=
e2549ff5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508200431130855%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;sdata=3DdeJBlAk6%2BEQkfAC8iRK95xhV1%2FiO9Si%2Bylc5=
Z0QzzrM%3D&amp;reserved=3D0
> >
> > Changes in v2:
> >    - Update patch description
> >   fs/proc/base.c |  4 ++--
> >   fs/proc/fd.c   | 15 ++++++++++++++-
> >   2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 3851bfcdba56..fd46d8dd0cf4 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3159,7 +3159,7 @@ static const struct pid_entry tgid_base_stuff[] =
=3D {
> >       DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, pr=
oc_task_operations),
> >       DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc=
_fd_operations),
> >       DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operation=
s, proc_map_files_operations),
> > -     DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, =
proc_fdinfo_operations),
> > +     DIR("fdinfo",     S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, =
proc_fdinfo_operations),
> >       DIR("ns",         S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, =
proc_ns_dir_operations),
> >   #ifdef CONFIG_NET
> >       DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, pro=
c_net_operations),
> > @@ -3504,7 +3504,7 @@ static const struct inode_operations proc_tid_com=
m_inode_operations =3D {
> >    */
> >   static const struct pid_entry tid_base_stuff[] =3D {
> >       DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_=
fd_operations),
> > -     DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, p=
roc_fdinfo_operations),
> > +     DIR("fdinfo",    S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, p=
roc_fdinfo_operations),
> >       DIR("ns",        S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, p=
roc_ns_dir_operations),
> >   #ifdef CONFIG_NET
> >       DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, pro=
c_net_operations),
> > diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> > index 07fc4fad2602..6a80b40fd2fe 100644
> > --- a/fs/proc/fd.c
> > +++ b/fs/proc/fd.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/fdtable.h>
> >   #include <linux/namei.h>
> >   #include <linux/pid.h>
> > +#include <linux/ptrace.h>
> >   #include <linux/security.h>
> >   #include <linux/file.h>
> >   #include <linux/seq_file.h>
> > @@ -72,6 +73,18 @@ static int seq_show(struct seq_file *m, void *v)
> >
> >   static int seq_fdinfo_open(struct inode *inode, struct file *file)
> >   {
> > +     bool allowed =3D false;
> > +     struct task_struct *task =3D get_proc_task(inode);
> > +
> > +     if (!task)
> > +             return -ESRCH;
> > +
> > +     allowed =3D ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> > +     put_task_struct(task);
> > +
> > +     if (!allowed)
> > +             return -EACCES;
> > +
> >       return single_open(file, seq_show, inode);
> >   }
> >
> > @@ -308,7 +321,7 @@ static struct dentry *proc_fdinfo_instantiate(struc=
t dentry *dentry,
> >       struct proc_inode *ei;
> >       struct inode *inode;
> >
> > -     inode =3D proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRU=
SR);
> > +     inode =3D proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRU=
GO);
> >       if (!inode)
> >               return ERR_PTR(-ENOENT);
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
