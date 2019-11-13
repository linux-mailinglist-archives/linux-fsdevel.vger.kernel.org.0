Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD26EFA04D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 02:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKMBhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 20:37:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38890 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKMBhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:37:03 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUhaA-0007L8-8i; Wed, 13 Nov 2019 01:36:30 +0000
Date:   Wed, 13 Nov 2019 01:36:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 3/9] namei: LOOKUP_NO_XDEV: block mountpoint crossing
Message-ID: <20191113013630.GZ26530@ZenIV.linux.org.uk>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-4-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105090553.6350-4-cyphar@cyphar.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 08:05:47PM +1100, Aleksa Sarai wrote:

> @@ -862,6 +870,8 @@ static int nd_jump_root(struct nameidata *nd)
>  void nd_jump_link(struct path *path)
>  {
>  	struct nameidata *nd = current->nameidata;
> +
> +	nd->last_magiclink.same_mnt = (nd->path.mnt == path->mnt);
>  	path_put(&nd->path);
>  
>  	nd->path = *path;
> @@ -1082,6 +1092,10 @@ const char *get_link(struct nameidata *nd)
>  		if (nd->flags & LOOKUP_MAGICLINK_JUMPED) {
>  			if (unlikely(nd->flags & LOOKUP_NO_MAGICLINKS))
>  				return ERR_PTR(-ELOOP);
> +			if (unlikely(nd->flags & LOOKUP_NO_XDEV)) {
> +				if (!nd->last_magiclink.same_mnt)
> +					return ERR_PTR(-EXDEV);
> +			}
>  		}

Ugh...  Wouldn't it be better to take that logics (some equivalent thereof)
into nd_jump_link()?  Or just have nd_jump_link() return an error...

I mean, look at the callers of nd_jump_link().
static const char *policy_get_link(struct dentry *dentry,
                                   struct inode *inode,
                                   struct delayed_call *done)
{
        struct aa_ns *ns;
        struct path path;  

        if (!dentry)   
                return ERR_PTR(-ECHILD);
        ns = aa_get_current_ns();
        path.mnt = mntget(aafs_mnt);
        path.dentry = dget(ns_dir(ns));
        nd_jump_link(&path); 
        aa_put_ns(ns);

        return NULL;
}
- very close to the end of ->get_link() instance.

static const char *proc_pid_get_link(struct dentry *dentry,
                                     struct inode *inode,
                                     struct delayed_call *done)
{ 
        struct path path;
        int error = -EACCES;

        if (!dentry)
                return ERR_PTR(-ECHILD);

        /* Are we allowed to snoop on the tasks file descriptors? */
        if (!proc_fd_access_allowed(inode))
                goto out;

        error = PROC_I(inode)->op.proc_get_link(dentry, &path);
        if (error)
                goto out;

        nd_jump_link(&path);
        return NULL;
out:   
        return ERR_PTR(error);
}
Ditto.

static const char *proc_ns_get_link(struct dentry *dentry,
                                    struct inode *inode,
                                    struct delayed_call *done)
{
        const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
        struct task_struct *task;
        struct path ns_path;
        void *error = ERR_PTR(-EACCES);

        if (!dentry)
                return ERR_PTR(-ECHILD);

        task = get_proc_task(inode);
        if (!task)
                return error;

        if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
                error = ns_get_path(&ns_path, task, ns_ops);
                if (!error)
                        nd_jump_link(&ns_path);
        }
        put_task_struct(task);
        return error;
}

The same.  And that's it - there's no more of them.  So how about
this in the beginning of the series, then having your magiclink
error handling done in nd_jump_link()?

diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..8ec924813c30 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -859,7 +859,7 @@ static int nd_jump_root(struct nameidata *nd)
  * Helper to directly jump to a known parsed path from ->get_link,
  * caller must have taken a reference to path beforehand.
  */
-void nd_jump_link(struct path *path)
+const char *nd_jump_link(struct path *path)
 {
 	struct nameidata *nd = current->nameidata;
 	path_put(&nd->path);
@@ -867,6 +867,7 @@ void nd_jump_link(struct path *path)
 	nd->path = *path;
 	nd->inode = nd->path.dentry->d_inode;
 	nd->flags |= LOOKUP_JUMPED;
+	return NULL;
 }
 
 static inline void put_link(struct nameidata *nd)
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..ac4e57a3dfa5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1626,8 +1626,7 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 	if (error)
 		goto out;
 
-	nd_jump_link(&path);
-	return NULL;
+	return nd_jump_link(&path);
 out:
 	return ERR_PTR(error);
 }
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index dd2b35f78b09..dde0c501b2f3 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -54,7 +54,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		error = ns_get_path(&ns_path, task, ns_ops);
 		if (!error)
-			nd_jump_link(&ns_path);
+			error = nd_jump_link(&ns_path);
 	}
 	put_task_struct(task);
 	return error;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 397a08ade6a2..f3e8438e5631 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -68,7 +68,7 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
-extern void nd_jump_link(struct path *path);
+extern const char *nd_jump_link(struct path *path);
 
 static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)
 {
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 45d13b6462aa..98aef94b4777 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2453,18 +2453,16 @@ static const char *policy_get_link(struct dentry *dentry,
 				   struct inode *inode,
 				   struct delayed_call *done)
 {
-	struct aa_ns *ns;
-	struct path path;
-
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
-	ns = aa_get_current_ns();
-	path.mnt = mntget(aafs_mnt);
-	path.dentry = dget(ns_dir(ns));
-	nd_jump_link(&path);
-	aa_put_ns(ns);
-
-	return NULL;
+	const char *err = ERR_PTR(-ECHILD);
+
+	if (dentry) {
+		struct aa_ns *ns = aa_get_current_ns();
+		struct path path = {.mnt = mntget(aafs_mnt),
+				    .dentry = ns_dir(ns)};
+		err = nd_jump_link(&path);
+		aa_put_ns(ns);
+	}
+	return err;
 }
 
 static int policy_readlink(struct dentry *dentry, char __user *buffer,
