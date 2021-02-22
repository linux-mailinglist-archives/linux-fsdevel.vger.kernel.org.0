Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC23222D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 00:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhBVX4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 18:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhBVX4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:56:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE498C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 15:56:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p5so3875158plo.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=pCRKupgV6bVPqQhAPHwvcUajc+P2j/PXt//zx6xPAlk=;
        b=aMoo0kknjIPmHPXzfPjSOvGRNxRUM/3mrnpeDehO70ESbHURf0pgopTpZCMDDPElJA
         /yu/UBiOekRlpYKIqSOYPYESfWJwlipecKkGxVGpzUuWWwWhDmfVEiqvFrqzyHkPdNjo
         4Oxeq8L7k+E2R/lRrQR4bDAuDaqdEBFHosqQvnf0DxzTtehAhnKuwgkyh/GIznxE3VZ6
         Nu+2BBkEVWSRwJNkutiY6uhCynI642xx95U8Nofxymy75kecqNhJjuu4QQQlXW3ORjvD
         dmg2kUmDqcZbr1qHeF8TmLa/jb0xi0eRaTDQGDbc/rALtCMFOZvPCze3zQrkgtwnpt1p
         Mm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=pCRKupgV6bVPqQhAPHwvcUajc+P2j/PXt//zx6xPAlk=;
        b=Fo9m8agzipaMi1GjMMNeo5YlqVwzmoY/yn7fcUhIHsz3u4uOtTS9YVq7qkNf0D33Fa
         W0xTQVVkRRvxi5t6CfhBJcDMq84EAyat8A4RpcPIXOKsCOTYjje3Ooz7EP4GmWVVUk8Y
         hS5RsG7LTPhY89sAGZXCB5aJkbM0OGr1yhq/Tx8bvFkhkHSZNXQbWvE2iTR2PATQBAzd
         ttnnG2R+9fLociIp87liHNPKCA2kk4VoaR/BCV8qpHptxGtC17i1aGcAGtzqqX6XL1yI
         DEvfTzhESiaMr3mX6NNHAV2ExpQU8hHumBxfiVtIfWI9X2mdxm8oVbKhc/n0E7kb1X3H
         C9IA==
X-Gm-Message-State: AOAM533I4yI82sIBe42tl2yV+oZnJQ+o+YjtQtUAa/9lDYyNWABLXw/A
        pfAqEmIFJprZtGf0TZCMYyk0zCqpQ91OGzfml3kZIw==
X-Received: by 2002:a17:902:c14b:b029:e4:16d0:6808 with SMTP id
 11-20020a170902c14bb02900e416d06808mt215595plj.69.1614038170018; Mon, 22 Feb
 2021 15:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20210208155315.1367371-1-kaleshsingh@google.com>
In-Reply-To: <20210208155315.1367371-1-kaleshsingh@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 22 Feb 2021 18:55:59 -0500
Message-ID: <CAC_TJve-vJPHfc7k-JuueoyCkKskv6ThVkrXzDA0rX85M4A82g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
Cc:     Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 8, 2021 at 10:53 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Android captures per-process system memory state when certain low memory
> events (e.g a foreground app kill) occur, to identify potential memory
> hoggers. In order to measure how much memory a process actually consumes,
> it is necessary to include the DMA buffer sizes for that process in the
> memory accounting. Since the handle to DMA buffers are raw FDs, it is
> important to be able to identify which processes have FD references to
> a DMA buffer.
>
> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> /proc/<pid>/fdinfo -- both are only readable by the process owner,
> as follows:
>   1. Do a readlink on each FD.
>   2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
>   3. stat the file to get the dmabuf inode number.
>   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
>
> Accessing other processes' fdinfo requires root privileges. This limits
> the use of the interface to debugging environments and is not suitable
> for production builds.  Granting root privileges even to a system process
> increases the attack surface and is highly undesirable.
>
> Since fdinfo doesn't permit reading process memory and manipulating
> process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> Changes in v2:
>   - Update patch description

Hi all,

Kindly requesting maintainers to take a look at this patch set.

Thanks,
Kalesh
>
>  fs/proc/base.c |  4 ++--
>  fs/proc/fd.c   | 15 ++++++++++++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index b3422cda2a91..a37f9de7103f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3160,7 +3160,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>         DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_operations),
>         DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
>         DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
> -       DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> +       DIR("fdinfo",     S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
>         DIR("ns",         S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>  #ifdef CONFIG_NET
>         DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
> @@ -3504,7 +3504,7 @@ static const struct inode_operations proc_tid_comm_inode_operations = {
>   */
>  static const struct pid_entry tid_base_stuff[] = {
>         DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
> -       DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> +       DIR("fdinfo",    S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
>         DIR("ns",        S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>  #ifdef CONFIG_NET
>         DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index cb51763ed554..585e213301f9 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -6,6 +6,7 @@
>  #include <linux/fdtable.h>
>  #include <linux/namei.h>
>  #include <linux/pid.h>
> +#include <linux/ptrace.h>
>  #include <linux/security.h>
>  #include <linux/file.h>
>  #include <linux/seq_file.h>
> @@ -72,6 +73,18 @@ static int seq_show(struct seq_file *m, void *v)
>
>  static int seq_fdinfo_open(struct inode *inode, struct file *file)
>  {
> +       bool allowed = false;
> +       struct task_struct *task = get_proc_task(inode);
> +
> +       if (!task)
> +               return -ESRCH;
> +
> +       allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> +       put_task_struct(task);
> +
> +       if (!allowed)
> +               return -EACCES;
> +
>         return single_open(file, seq_show, inode);
>  }
>
> @@ -307,7 +320,7 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
>         struct proc_inode *ei;
>         struct inode *inode;
>
> -       inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR);
> +       inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUGO);
>         if (!inode)
>                 return ERR_PTR(-ENOENT);
>
> --
> 2.30.0.478.g8a0d178c01-goog
>
