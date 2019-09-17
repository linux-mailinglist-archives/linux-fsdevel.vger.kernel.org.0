Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67BB5797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 23:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfIQVa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 17:30:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33415 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfIQVav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:30:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id e18so4238683oii.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESCnXX2tcIZXxoYYdwBnYQ13kyLGDQXAfzDyU1IsljM=;
        b=jUgafeXoQWRROVQcTu6YfyeHgWxQgQnh4jo0vXJb9gmwfB60c9yL42Xud+pRnhazvu
         I55/SWoMFVopXjb7HLBe3ZwDp8YJ8AIZ8yE+MZ1ol1jCwWnIpfYZUGgVJMSnV8dTUt6g
         Fj+f3RqGjAClmuMaYSKTGHkK+kbzWWV2PGu8pnhEDzRe1H1j/2nUdgWnUmqKQJs9XJhD
         bcgWdPhYUHXwS43uDaRjRrlqwvcEMFzpAIgQXR+SQCsx7w3nXgWKc6kAeP7uC4P5GOpV
         geTEa7Nd78q01D+rHdE0lfUUKO0VvNzXAoY9/ESlMRu9nFZIkRllJNqARaqGkFjsJcK8
         RCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESCnXX2tcIZXxoYYdwBnYQ13kyLGDQXAfzDyU1IsljM=;
        b=YNoN3KnsXcXwgRFmB8ccmVFM2CmWlM+Ln9EvA/tBWUq9r9aWoCMbC56RvSl3EYr1io
         5q63hfEnHGVZsGayVoOMMrzNntm3JBk4LN6UymhE50Dhuy1Wx8Mc3SfUIfJDOXevKZXu
         7zLvrhS6PLJ3pCCzeb4mI+4AJr+3cetPjjBtas1dKp2dyKadLdJfMzbvIpmX/Q2xIsk8
         SUi+nmER7/nwIXISovooa486mDiJryw4gSwsPZ4LfvlVJwXAIhm0GSqFjZxz+K9cfrbX
         rqNvJfQEQLeUWUq25DFh0CXkPsCr4eDDlZZY+jy7VN38Sa+oZua+A/UrSU2HFB7Ww1D4
         +jCg==
X-Gm-Message-State: APjAAAUV6Wl6MAt5EM4SRUd2bm4zBV+8676bipprMFU3hx9eDc8fLIiQ
        jqwL87Gth+7KbBuuNuiZ7OZQo9shMwtiZQ5CV9cAkQ==
X-Google-Smtp-Source: APXvYqwxm+0NJ68SJt1aKiZMUXpTcHLshnMGNY9q+/BgS9qyQqvS1IrxODCZyEWbmarv3+IaDknKyiL8F7FGSmCNufY=
X-Received: by 2002:aca:ed52:: with SMTP id l79mr129659oih.47.1568755849487;
 Tue, 17 Sep 2019 14:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-6-cyphar@cyphar.com>
In-Reply-To: <20190904201933.10736-6-cyphar@cyphar.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Sep 2019 23:30:23 +0200
Message-ID: <CAG48ez1_64249RdX6Nj_32YS+jhuXZBAd_ZL9ozggbSQy+cc-A@mail.gmail.com>
Subject: Re: [PATCH v12 05/12] namei: obey trailing magic-link DAC permissions
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-alpha@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 4, 2019 at 10:21 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> The ability for userspace to "re-open" file descriptors through
> /proc/self/fd has been a very useful tool for all sorts of usecases
> (container runtimes are one common example). However, the current
> interface for doing this has resulted in some pretty subtle security
> holes. Userspace can re-open a file descriptor with more permissions
> than the original, which can result in cases such as /proc/$pid/exe
> being re-opened O_RDWR at a later date even though (by definition)
> /proc/$pid/exe cannot be opened for writing. When combined with O_PATH
> the results can get even more confusing.
[...]
> Instead we have to restrict it in such a way that it doesn't break
> (good) users but does block potential attackers. The solution applied in
> this patch is to restrict *re-opening* (not resolution through)
> magic-links by requiring that mode of the link be obeyed. Normal
> symlinks have modes of a+rwx but magic-links have other modes. These
> magic-link modes were historically ignored during path resolution, but
> they've now been re-purposed for more useful ends.

Thanks for dealing with this issue!

[...]
> diff --git a/fs/namei.c b/fs/namei.c
> index 209c51a5226c..54d57dad0f91 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -872,7 +872,7 @@ void nd_jump_link(struct path *path)
>
>         nd->path = *path;
>         nd->inode = nd->path.dentry->d_inode;
> -       nd->flags |= LOOKUP_JUMPED;
> +       nd->flags |= LOOKUP_JUMPED | LOOKUP_MAGICLINK_JUMPED;
>  }
[...]
> +static int trailing_magiclink(struct nameidata *nd, int acc_mode,
> +                             fmode_t *opath_mask)
> +{
> +       struct inode *inode = nd->link_inode;
> +       fmode_t upgrade_mask = 0;
> +
> +       /* Was the trailing_symlink() a magic-link? */
> +       if (!(nd->flags & LOOKUP_MAGICLINK_JUMPED))
> +               return 0;
> +
> +       /*
> +        * Figure out the upgrade-mask of the link_inode. Since these aren't
> +        * strictly POSIX semantics we don't do an acl_permission_check() here,
> +        * so we only care that at least one bit is set for each upgrade-mode.
> +        */
> +       if (inode->i_mode & S_IRUGO)
> +               upgrade_mask |= FMODE_PATH_READ;
> +       if (inode->i_mode & S_IWUGO)
> +               upgrade_mask |= FMODE_PATH_WRITE;
> +       /* Restrict the O_PATH upgrade-mask of the caller. */
> +       if (opath_mask)
> +               *opath_mask &= upgrade_mask;
> +       return may_open_magiclink(upgrade_mask, acc_mode);
>  }

This looks racy because entries in the file descriptor table can be
switched out as long as task->files->file_lock isn't held. Unless I'm
missing something, something like the following (untested) would
bypass this restriction:

int readonly_fd = ...; /* some read-only fd we want to reopen as writable */
int writable_fd = open("/dev/null", O_RDWR);
int flippy_fd = dup(writable_fd);
char flippy_fd_path[100];
sprintf(flippy_fd_path, "/proc/%d/fd/%d", getpid(), flippy_fd);
if (fork() == 0) {
  while (1) {
    int reopened_fd = open(flippy_fd_path, O_RDWR);
    if (reopened_fd == -1) continue;
    char reopened_fd_path[100];
    sprintf(reopened_fd_path, "/proc/self/fd/%d", reopened_fd);
    char reopened_fd_target[1000];
    int target_len = readlink(reopened_fd_path, reopened_fd_target,
sizeof(reopened_fd_target)-1);
    reopened_fd_target[target_len] = 0;
    if (strcmp(reopened_fd_target, "/dev/null"))
      printf("managed to reopen as writable\n");
    close(reopened_fd);
  }
} else {
  while (1) {
    dup2(readonly_fd, flippy_fd);
    dup2(writable_fd, flippy_fd);
  }
}

Perhaps you could change nd_jump_link() to "void nd_jump_link(struct
path *path, umode_t link_mode)", and let proc_pid_get_link() pass the
link_mode through from an out-argument of .proc_get_link()? Then
proc_fd_link() could grab the proper mode in a race-free manner. And
nd_jump_link() could stash the mode in the nameidata.

A sketch of how I imagine that:
===============================
diff --git a/fs/namei.c b/fs/namei.c
index 6b936038319b..14c6790203c7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -506,6 +506,7 @@ struct nameidata {
        struct inode    *link_inode;
        unsigned        root_seq;
        int             dfd;
+       umode_t         last_link_mode;
 } __randomize_layout;

 static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
@@ -890,7 +891,7 @@ static int nd_jump_root(struct nameidata *nd)
  * Helper to directly jump to a known parsed path from ->get_link,
  * caller must have taken a reference to path beforehand.
  */
-void nd_jump_link(struct path *path)
+void nd_jump_link(struct path *path, umode_t link_mode)
 {
        struct nameidata *nd = current->nameidata;
        path_put(&nd->path);
@@ -898,6 +899,7 @@ void nd_jump_link(struct path *path)
        nd->path = *path;
        nd->inode = nd->path.dentry->d_inode;
        nd->flags |= LOOKUP_JUMPED | LOOKUP_MAGICLINK_JUMPED;
+       nd->last_link_mode = link_mode;
 }

 static inline void put_link(struct nameidata *nd)
@@ -3654,9 +3656,9 @@ static int trailing_magiclink(struct nameidata
*nd, int acc_mode,
         * strictly POSIX semantics we don't do an acl_permission_check() here,
         * so we only care that at least one bit is set for each upgrade-mode.
         */
-       if (inode->i_mode & S_IRUGO)
+       if (nd->last_link_mode & S_IRUGO)
                upgrade_mask |= FMODE_PATH_READ;
-       if (inode->i_mode & S_IWUGO)
+       if (nd->last_link_mode & S_IWUGO)
                upgrade_mask |= FMODE_PATH_WRITE;
        /* Restrict the O_PATH upgrade-mask of the caller. */
        if (opath_mask)
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 297242174402..af0218447571 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1614,6 +1614,7 @@ static const char *proc_pid_get_link(struct
dentry *dentry,
 {
        struct path path;
        int error = -EACCES;
+       umode_t link_mode;

        if (!dentry)
                return ERR_PTR(-ECHILD);
@@ -1622,11 +1623,11 @@ static const char *proc_pid_get_link(struct
dentry *dentry,
        if (!proc_fd_access_allowed(inode))
                goto out;

-       error = PROC_I(inode)->op.proc_get_link(dentry, &path);
+       error = PROC_I(inode)->op.proc_get_link(dentry, &path, &link_mode);
        if (error)
                goto out;

-       nd_jump_link(&path);
+       nd_jump_link(&path, link_mode);
        return NULL;
 out:
        return ERR_PTR(error);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 9b7d8becb002..9c1d247177b1 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -163,7 +163,8 @@ static const struct dentry_operations
tid_fd_dentry_operations = {
        .d_delete       = pid_delete_dentry,
 };

-static int proc_fd_link(struct dentry *dentry, struct path *path)
+static int proc_fd_link(struct dentry *dentry, struct path *path,
+                       umode_t *link_mode)
 {
        struct files_struct *files = NULL;
        struct task_struct *task;
@@ -184,6 +185,7 @@ static int proc_fd_link(struct dentry *dentry,
struct path *path)
                if (fd_file) {
                        *path = fd_file->f_path;
                        path_get(&fd_file->f_path);
+                       *link_mode = /* something based on fd_file->f_mode */;
                        ret = 0;
                }
                spin_unlock(&files->file_lock);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index cd0c8d5ce9a1..a090fff984ed 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -74,7 +74,7 @@ extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);

 union proc_op {
-       int (*proc_get_link)(struct dentry *, struct path *);
+       int (*proc_get_link)(struct dentry *, struct path *, umode_t *);
        int (*proc_show)(struct seq_file *m,
                struct pid_namespace *ns, struct pid *pid,
                struct task_struct *task);
===============================
