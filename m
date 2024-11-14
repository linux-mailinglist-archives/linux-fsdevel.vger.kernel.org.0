Return-Path: <linux-fsdevel+bounces-34850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF49C94E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 22:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABF31F23CEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1F1B0F34;
	Thu, 14 Nov 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="g6h+vv89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSZGizTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BD1AF0C4;
	Thu, 14 Nov 2024 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621154; cv=none; b=e2uK9on002Wf2XSpsvUtD0Bwsa/ZxmwtTKMzGfKbKxWs4ONoq3C6X79oylGxsrszo621ugcTAlIy7NyfstfVQHRZKPGM9R+v5bYjHZmJXJj6cwJznjcmBbh7rRMBTkDqA2rXeIocJRi1leaFkp/KPm0lD9F1/Nc8Nro68TBKNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621154; c=relaxed/simple;
	bh=rmTQu8WzdBCz/XQ9uBUiql50LeaKz0AbTMPZF1YSXYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vf21AISsyMCirxjViyHZEvvodd1n88UGG/8nuCu3p5oZ6yXydLOTq1XsSSeEeni27lIoqEm55NsZ9CYlaHTtR7IbtOnmaie90keyZR+W6W98sax+oMMznMR1bZBQOZzle1rqC9mSqdDsCn07cZRlpTdYzdvjKhNqcbX15yGfRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=g6h+vv89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSZGizTQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C853C254013D;
	Thu, 14 Nov 2024 16:52:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 16:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731621150;
	 x=1731707550; bh=rmTQu8WzdBCz/XQ9uBUiql50LeaKz0AbTMPZF1YSXYQ=; b=
	g6h+vv892W4q6icoOfoZZxoLES5vAeou+9Ydf7FJztvwfHMenx1yJEY+Hhi/RVkl
	Ao40ztod5upMKd78NHTM5RkAlLq5visfD4ZsrNUZKQiQTKH0lrQd1LJiUnMALE7j
	8k7fCIvRxy2TyXkHxmPjO6XSlvW4E0Nsreg36CtX3iSHBLrnQ64okrI59CpNYXXS
	dSrInzjF1kBmECZ5td6f60RF9LEccMq+iGe4ClOf6lM7g6Z6B/GctgQknSka1eoq
	3ToHKzm8QExnZzDmA8kWsBdQ49DfI6Fu7hgUEFX7vn3rJUCAYyKVYflgldusoD0G
	shw1uypEtiBrnJ7P/K0n3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731621150; x=
	1731707550; bh=rmTQu8WzdBCz/XQ9uBUiql50LeaKz0AbTMPZF1YSXYQ=; b=k
	SZGizTQrkMTyR2l1Aep92FhMfLjov5ZCiToTRQ0i5q1uQQjhc2XOuSuc8SfPEKmQ
	z8BtVR9DO5YifT7T4StmMk5+d90otR5JjRkesYAVDrlx/FMlBD5N3uVZfcv1wQ5X
	Zmzv2klT0MTx2zaqQs8vJIkfaLnJST/jz1rtiwMRMKtjnstqAEznc032I6MoViQ3
	gfBwaUqsXsr7n1MHZa4403371ReKqNPP7XNGXlEMc+pmosCgpnRKaiBqQ0/1eih+
	cDpn7MM9o68196SGr1uZT8o5sM1C1+Y1FmBCw8i4VhEHx1PrNde0SUX5vuN+MWs2
	t9ftdSrgF16pzvrbjG9SQ==
X-ME-Sender: <xms:HnE2Z2oFfV0igJZ8v0zVkSpLfgk8lprvY--toIW6gXiw3B-UwIkhow>
    <xme:HnE2Z0qmxlKEwyxzTpO0oAmdiawdG5EnUlc_AuiwjQyb5-T6lA2u2BCUw9AB7FPeL
    rLEr5MM9hm2almfV9U>
X-ME-Received: <xmr:HnE2Z7OhkyeD4WHW5ceRJVTpazYGQHlz41FexvJS4gmaQRzRQncIqWbgIbg-QD6zjeMDEC-Hc3C7bf2X0PV1_cjRaO2i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefgrhhinhcuufhhvghphhgvrhguuceovghrihhnrdhshhgvphhhvghrug
    esvgegfedrvghuqeenucggtffrrghtthgvrhhnpeeggefhjeejgedtgfefhfdthfeuvdej
    udelfeelhfejteelieekjeeggeeggfegudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrshhhvghphhgvrhgusegvgeefrdgvuhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrrg
    hunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhl
    ihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtph
    htthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HnE2Z14XCg2F-7lhsYgDKmDg0aCXgXQZgMcJFgqXHJgQN0MuWWu2XA>
    <xmx:HnE2Z14rNun-ljF2Mhc9gUptKi1ntY4QzuyDaU5a9LXBq90g43FrjA>
    <xmx:HnE2Z1iHlfaXLnWVxo5_wm9-JGw8Gd-YXi9DNmaqdKm3yPtYwYPokg>
    <xmx:HnE2Z_5BAd3pjZB0N1bzkixzO2xclAXVKvRHoOJRW7A8upN_XUY9xw>
    <xmx:HnE2Z6HLa1cXNHBvV5A7c6HVqRuC5hcuTDrdQEpRWqaMwWtQCU8MG__A>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 16:52:28 -0500 (EST)
Message-ID: <b4353823-16ef-4a14-9222-acbe819fdce8@e43.eu>
Date: Thu, 14 Nov 2024 22:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pidfs: implement file handle support
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
 <20241114-erhielten-mitziehen-68c7df0a2fa2@brauner>
 <1128f3cd-38de-43a0-981e-ec1485ec9e3b@e43.eu>
 <20241114-monat-zehnkampf-2b1277d5252d@brauner>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <20241114-monat-zehnkampf-2b1277d5252d@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/11/2024 15:13, Christian Brauner wrote:

> On Thu, Nov 14, 2024 at 02:13:06PM +0100, Erin Shepherd wrote:
>> These two concerns combined with the special flag make me wonder if pidfs
>> is so much of a special snowflake we should just special case it up front
>> and skip all of the shared handle decode logic?
> Care to try a patch and see what it looks like?

The following is a completely untested sketch on top of the existing patch series.
Some notes:

- I made heavy use of the cleanup macros. I'm happy to convert things back to
  goto out_xx style if preferred - writing things this way just made bashing out
  the code without dropping resources on the floor easier
- If you don't implement fh_to_dentry then name_to_handle_at will just return an error
  unless called with AT_HANDLE_FID. We need to decide what to do about that
- The GET_PATH_FD_IS_NORMAL/etc constants don't match (what I see as) usual kernel style
  but I'm not sure how to conventionally express something like that

Otherwise, I'm fairly happy with how it came out in the end. Maybe handle_to_path and
do_handle_to_path could be collapsed into each other at this point.

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 056116e58f43..697246085b69 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -11,6 +11,7 @@
 #include <linux/personality.h>
 #include <linux/uaccess.h>
 #include <linux/compat.h>
+#include <linux/pidfs.h>
 #include "internal.h"
 #include "mount.h"

@@ -130,6 +131,11 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
     return err;
 }

+enum {
+    GET_PATH_FD_IS_NORMAL = 0,
+    GET_PATH_FD_IS_PIDFD  = 1,
+};
+
 static int get_path_from_fd(int fd, struct path *root)
 {
     if (fd == AT_FDCWD) {
@@ -139,15 +145,16 @@ static int get_path_from_fd(int fd, struct path *root)
         path_get(root);
         spin_unlock(&fs->lock);
     } else {
-        struct fd f = fdget(fd);
+        CLASS(fd, f)(fd);
         if (!fd_file(f))
             return -EBADF;
+        if (pidfd_pid(fd_file(f)))
+            return GET_PATH_FD_IS_PIDFD;
         *root = fd_file(f)->f_path;
         path_get(root);
-        fdput(f);
     }

-    return 0;
+    return GET_PATH_FD_IS_NORMAL;
 }

 enum handle_to_path_flags {
@@ -287,84 +294,94 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
     return true;
 }

-static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
-           struct path *path, unsigned int o_flags)
+static int copy_handle_from_user(struct file_handle __user *ufh, struct file_handle **ret)
 {
-    int retval = 0;
-    struct file_handle f_handle;
-    struct file_handle *handle = NULL;
-    struct handle_to_path_ctx ctx = {};
-
-    retval = get_path_from_fd(mountdirfd, &ctx.root);
-    if (retval)
-        goto out_err;
-
-    if (!may_decode_fh(&ctx, o_flags)) {
-        retval = -EPERM;
-        goto out_path;
-    }
-
+    struct file_handle f_handle, *handle;
     if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
-        retval = -EFAULT;
-        goto out_path;
+        return -EFAULT;
     }
     if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
         (f_handle.handle_bytes == 0)) {
-        retval = -EINVAL;
-        goto out_path;
+        return -EINVAL;
     }
     handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
              GFP_KERNEL);
     if (!handle) {
-        retval = -ENOMEM;
-        goto out_path;
+        return -ENOMEM;
     }
+
     /* copy the full handle */
     *handle = f_handle;
     if (copy_from_user(&handle->f_handle,
                &ufh->f_handle,
                f_handle.handle_bytes)) {
-        retval = -EFAULT;
-        goto out_handle;
+        kfree(handle);
+        return -EFAULT;
     }

-    retval = do_handle_to_path(handle, path, &ctx);
+    *ret = handle;
+    return 0;
+}

-out_handle:
-    kfree(handle);
-out_path:
-    path_put(&ctx.root);
-out_err:
-    return retval;
+static int handle_to_path(struct path root, struct file_handle __user *ufh,
+           struct path *path, unsigned int o_flags)
+{
+    struct file_handle *handle = NULL;
+    struct handle_to_path_ctx ctx = {
+        .root = root,
+    };
+
+    if (!may_decode_fh(&ctx, o_flags)) {
+        return -EPERM;
+    }
+
+    return do_handle_to_path(handle, path, &ctx);
 }

 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
                int open_flag)
 {
     long retval = 0;
-    struct path path;
-    struct file *file;
-    int fd;
+    struct file_handle *handle __free(kfree) = NULL;
+    struct path __free(path_put) root = {};
+    struct path __free(path_put) path = {};
+    struct file *file = NULL;
+    int root_type;

-    retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
+    root_type = get_path_from_fd(mountdirfd, &root);
+    if (root_type < 0)
+        return root_type;
+
+    retval = copy_handle_from_user(ufh, &handle);
     if (retval)
         return retval;

-    fd = get_unused_fd_flags(open_flag);
-    if (fd < 0) {
-        path_put(&path);
+    CLASS(get_unused_fd, fd)(open_flag);
+    if (fd < 0)
         return fd;
+
+    switch (root_type) {
+    case GET_PATH_FD_IS_NORMAL:
+        retval = handle_to_path(root, handle, &path, open_flag);
+        if (retval)
+            return retval;
+        file = file_open_root(&path, "", open_flag, 0);
+        if (IS_ERR(file)) {
+            return PTR_ERR(file);
+        }
+        break;
+
+    case GET_PATH_FD_IS_PIDFD:
+        file = pidfd_open_by_handle(
+            handle->f_handle, handle->handle_bytes >> 2, handle->handle_type,
+            open_flag);
+        if (IS_ERR(file))
+            return retval;
+        break;
     }
-    file = file_open_root(&path, "", open_flag, 0);
-    if (IS_ERR(file)) {
-        put_unused_fd(fd);
-        retval =  PTR_ERR(file);
-    } else {
-        retval = fd;
-        fd_install(fd, file);
-    }
-    path_put(&path);
-    return retval;
+
+    fd_install(fd, file);
+    return take_fd(fd);
 }

 /**
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0684a9b8fe71..65b72dc05380 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -453,22 +453,53 @@ static struct file_system_type pidfs_type = {
     .kill_sb        = kill_anon_super,
 };

-struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
+static struct file *__pidfs_alloc_file(struct pid *pid, unsigned int flags)
 {
-
     struct file *pidfd_file;
     struct path path;
     int ret;

-    ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
+    ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
     if (ret < 0)
         return ERR_PTR(ret);

     pidfd_file = dentry_open(&path, flags, current_cred());
+    if (!IS_ERR(pidfd_file))
+        pidfd_file->f_flags |= (flags & PIDFD_THREAD);
     path_put(&path);
     return pidfd_file;
 }

+struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
+{
+    return __pidfs_alloc_file(get_pid(pid), flags);
+}
+
+struct file *pidfd_open_by_handle(void *gen_fid, int fh_len, int fh_type,
+                  unsigned int flags)
+{
+    bool thread = flags & PIDFD_THREAD;
+    struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
+    struct pid *pid;
+
+    if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
+        return ERR_PTR(-ESTALE);
+
+    scoped_guard(rcu) {
+        pid = find_pid_ns(fid->pid, &init_pid_ns);
+        if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0)
+            return ERR_PTR(-ESTALE);
+        if(!pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
+            return ERR_PTR(-ESTALE);
+            /* Something better? EINVAL like pidfd_open wouldn't be
+               very obvious... */
+
+        pid = get_pid(pid);
+    }
+
+    return __pidfs_alloc_file(pid, flags);
+}
+
 void __init pidfs_init(void)
 {
     pidfs_mnt = kern_mount(&pidfs_type);
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 75bdf9807802..fba2654ae60f 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -3,6 +3,8 @@
 #define _LINUX_PID_FS_H

 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
+struct file *pidfd_open_by_handle(void *gen_fid, int fh_len, int fh_type,
+                  unsigned int flags);
 void __init pidfs_init(void);

 #endif /* _LINUX_PID_FS_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 22f43721d031..fc47c76e4ff4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2015,11 +2015,6 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
         put_unused_fd(pidfd);
         return PTR_ERR(pidfd_file);
     }
-    /*
-     * anon_inode_getfile() ignores everything outside of the
-     * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
-     */
-    pidfd_file->f_flags |= (flags & PIDFD_THREAD);
     *ret = pidfd_file;
     return pidfd;
 }


