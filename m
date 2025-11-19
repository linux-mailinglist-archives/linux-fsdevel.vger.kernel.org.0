Return-Path: <linux-fsdevel+bounces-69133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6402C70AE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 591954E3DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CCD34EEE6;
	Wed, 19 Nov 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQHh6Z1S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A73191C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577616; cv=none; b=N86V3vf/5J/zjZXs56tXoahh5hbH08g4wxYhyye6acHSbEm4kA9A7sKZDemH7yVlcqzFfN5MB+nmKSJGFgKlS3Uuec2w6xVkvUcIKmejFyWqBrV+Gmpv4/4uBGo3c/Ev7F2jjrCHNvQjHEErDUEsLk5X3ttM9L03o/slHDGAcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577616; c=relaxed/simple;
	bh=9EIeDEydB6V74iOvMt7NO4QnUQQ2j03U3VNILSFp+FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHFunyk+MCSeY+a1fcWugsOvyAQLkPYB5+CGLrsdbRXWgrcpZ6LwDfzpnEh1niCyk7xLncmieGM2XY2+NjETmBmergUfOxAEAZNeEvmI6W/ERC1ZfhAegL7ViIJJ8dnIC6p1yxZQFTY87BY3c/VNfUjJ7A5KMri5/DvCVtm8UDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQHh6Z1S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47118259fd8so675125e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 10:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763577607; x=1764182407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGizJych6kV8iur5Ufl2UtECyoJMz9Q2qTRmjFJNznc=;
        b=PQHh6Z1SLGlle5qEaZrv9j8GLUOtOK1e1RFVeWCKm0izWJ6HcRvUAaMB5Z6I7UsmRl
         tzlgmtm4gSm+wf+Izi5sU4zvIe1PE58JO4Gvl/rgU0lyCoQ1x6RewV1/5Mb/o7x4mhn2
         ab6RThZLJMi0B7cBXAwmT1Ibo5vID+AEf0LwKJ/UTHK0VrManWPYw/EHo+dpmTfW043I
         kkQ7Hu5k7LOjzSfZlI4EMxLIN/Fy5OkjHp2AWoCE2mxFCc3kNcSttjyOW80Hs0WcNmBv
         3BbZT4xjyEwU75SQWQ9csXWE0C7Tto2b4s5QMSKLQAJS7bkeo7QWcjbKUgdWi0ce9yfo
         gMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763577607; x=1764182407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGizJych6kV8iur5Ufl2UtECyoJMz9Q2qTRmjFJNznc=;
        b=rHC7U4Tl+FSDOSdA/4yBUDjE6uUREHrjFvLyCP111YMUvXm5/2U/Ex3fJCf/9f5a7l
         J655QC8n48BYzuO1hDL4Hoxn3GbVHyCLVazj62t2Bq4eZwsdw7Coz9pFw0JbEQqMsNMl
         CPXYLJ52433zaSrXvP0DnF4LOe/m5WW/7T5JlgQuHEl5CFIsqD0NWxgNQEYz+jklehJF
         hKZSpXV4wjqBDpxTv3uVHGJuVALOv7fpgbQ9/uE4gPqIkv0ZwZuiPAYCcNgxEwsANQuy
         PtjZYYwgLRytkSuFOulxFYroaLEnccsprNBQI7KJUo75IDteAl5ghJzPI7iejjPeRaE6
         0VQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1w9oajB+C3+5aYPmpB/CswaC66Ka4IGsOYtZnR8TRqay0qJI74qfVE70WwZ00zNLmBBJf/FYZ3XBZQRlX@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDcxDqS2me0yP/BK1kdNoPgnKQv5oafSRweSlsfwUfDFIwtOF
	E8oE+s4lLOVKI9dzjdhIKnSDDm+xFJbWjedrZ8ZJv2LeHw4iWNbIfrxkwKYhmw==
X-Gm-Gg: ASbGncu0gMmzrg1NJsTzw42pYrgFuS4fvC7S6T3pBmJxYcjHZJvXmKTqnX3VwZ1ogLo
	fHmqquBoA8t1UOJ96FiWiYp6t1FAxBB8v94H78O4lxJCG4JTG8kn8DutchcPIvKDD9cDWFnFm/i
	AATb+7/KFOzXjAUWP1ipIATKnKiIF8ayP+25aI12bcmGIzmH6hEX3SpJdmXvs178t6TXZj9IFds
	/POvBbdNb3CrBQfSqUJ6lZ/dv4oJ5BuPSPsWQaUnhBJrtfzAWlabWXvMRh1BGEdSV8Yy+cbjXV9
	F0X/Yfx/l1/jUcNpD0wZK8jHOChxwLZke8VtkDbtPFCKWsXHRS0SoyRaNZG3VSo9A9smgp4xjL4
	NX3yLLPnuiBbSCkdp8DGGVybsD301x1pK1nK29/dDSgW1LwAE090q0zOhK/Q5FQ4OHOyYdkG+9e
	KT+7wXW6DuAYMIqPTL49CynKIqmeR7J/h1RabVEJecHP3zUDDX8MPvqRHnDIYzewxnyDghgA==
X-Google-Smtp-Source: AGHT+IExIkkC/PY0LZ0o+Azw4ggYI6nNH2H9xW1NpwuJxc5dIJG8ZkOvO4zi7O4naz5/ibvSK0CrVA==
X-Received: by 2002:a05:600c:444c:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-477b8aa06c0mr2606955e9.31.1763577606607;
        Wed, 19 Nov 2025 10:40:06 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10804c8sm64220655e9.15.2025.11.19.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:40:05 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: inline step_into() and walk_component()
Date: Wed, 19 Nov 2025 19:40:01 +0100
Message-ID: <20251119184001.2942865-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary consumer is link_path_walk(), calling walk_component() every
time which in turn calls step_into().

Inlining these saves overhead of 2 function calls per path component,
along with allowing the compiler to do better job optimizing them in place.

step_into() had absolutely atrocious assembly to facilitate the
slowpath. In order to lessen the burden at the callsite all the hard
work is moved into step_into_slowpath(). This also elides some of the
branches as for example LOOKUP_RCU is only checked once.

The inline-able step_into() variant deals with the common case of
traversing a cached non-mounted on directory while in RCU mode.

Since symlink handling is already denoted as unlikely(), I took the
opportunity to also shorten step_into_slowpath() by moving parts of it
into pick_link() which further shortens assembly.

Benchmarked as follows on Sapphire Rapids:
1. the "before" was a kernel with not-yet-merged optimizations (notably
   elision of calls to security_inode_permissin() and marking ext4
   inodes as not having acls)
2. "after" is the same + this patch
3. benchmark consists of issuing 205 calls to access(2) in a loop with
   pathnames lifted out of gcc and the linker building real code, most
   of which have several path components and 118 of which fail with
   -ENOENT. Some of those do symlink traversal.

In terms of ops/s:
before:	21619
after:	22536 (+4%)

profile before:
  20.25%  [kernel]                  [k] __d_lookup_rcu
  10.54%  [kernel]                  [k] link_path_walk
  10.22%  [kernel]                  [k] entry_SYSCALL_64
   6.50%  libc.so.6                 [.] __GI___access
   6.35%  [kernel]                  [k] strncpy_from_user
   4.87%  [kernel]                  [k] step_into
   3.68%  [kernel]                  [k] kmem_cache_alloc_noprof
   2.88%  [kernel]                  [k] walk_component
   2.86%  [kernel]                  [k] kmem_cache_free
   2.14%  [kernel]                  [k] set_root
   2.08%  [kernel]                  [k] lookup_fast

after:
  23.38%  [kernel]                  [k] __d_lookup_rcu
  11.27%  [kernel]                  [k] entry_SYSCALL_64
  10.89%  [kernel]                  [k] link_path_walk
   7.00%  libc.so.6                 [.] __GI___access
   6.88%  [kernel]                  [k] strncpy_from_user
   3.50%  [kernel]                  [k] kmem_cache_alloc_noprof
   2.01%  [kernel]                  [k] kmem_cache_free
   2.00%  [kernel]                  [k] set_root
   1.99%  [kernel]                  [k] lookup_fast
   1.81%  [kernel]                  [k] do_syscall_64
   1.69%  [kernel]                  [k] entry_SYSCALL_64_safe_stack

While walk_component() and step_into() of course disappear from the
profile, the link_path_walk() barely gets more overhead despite the
inlining thanks to the fast path added and while completing more walks
per second.

I don't know why overhead grew a lot on __d_lookup_rcu().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

perhaps this could be 2-3 patches instead to do things incrementally
the other patches not listed in the commit message are:
1. mntput_not_expire slowpath (Christian took it, not present in fs-next yet)
2. nd->depth predicts.
3. lookup_slow noinline

all of those sent

you may notice step_into is quite high on the profile:
   4.87%  [kernel]                  [k] step_into

here is the routine prior to the patch:
    call   ffffffff81374630 <__fentry__>
    push   %rbp
    mov    %rsp,%rbp
    push   %r15
    push   %r14
    mov    %esi,%r14d
    push   %r13
    push   %r12
    push   %rbx
    mov    %rdi,%rbx
    sub    $0x28,%rsp
    mov    (%rdi),%rax
    mov    0x38(%rdi),%r8d
    mov    %gs:0x2e10acd(%rip),%r12        # ffffffff84551008 <__stack_chk_guard>

    mov    %r12,0x20(%rsp)
    mov    %rdx,%r12
    mov    %rdx,0x18(%rsp)
    mov    %rax,0x10(%rsp)

This is setup before it even gets to do anything which of course has
to be undone later. Also note the stackguard check. I'm not pasting
everything you can disasm yourself to check the entire monstrosity.

In contrast this is entirety of step_into() fast path with the patch + noinline:
         call   ffffffff81374630 <__fentry__>
         testb  $0x1,0x39(%rdi)
         je     ffffffff81740cbe <step_into+0x4e>
         mov    (%rdx),%eax
         test   $0x38000,%eax
         jne    ffffffff81740cbe <step_into+0x4e>
         and    $0x380000,%eax
         mov    0x30(%rdx),%rcx
         cmp    $0x300000,%eax
         je     ffffffff81740cbe <step_into+0x4e>
         mov    (%rdi),%r8
         mov    0x44(%rdi),%esi
         mov    0x4(%rdx),%eax
         cmp    %eax,%esi
         jne    ffffffff81740cc3 <step_into+0x53>
         test   %rcx,%rcx
         je     ffffffff81740ccf <step_into+0x5f>
         mov    0x44(%rdi),%eax
         mov    %r8,(%rdi)
         mov    %rdx,0x8(%rdi)
         mov    %eax,0x40(%rdi)
         xor    %eax,%eax
         mov    %rcx,0x30(%rdi)
         jmp    ffffffff8230b1f0 <__pi___x86_return_thunk>

This possibly can be shortened but I have not tried yet.

 fs/namei.c | 67 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1d1f864ad6ad..e00b9ce21536 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1668,17 +1668,17 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	bool jumped;
 	int ret;
 
-	path->mnt = nd->path.mnt;
-	path->dentry = dentry;
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned int seq = nd->next_seq;
+		if (likely(!(dentry->d_flags & DCACHE_MANAGED_DENTRY)))
+			return 0;
 		if (likely(__follow_mount_rcu(nd, path)))
 			return 0;
 		// *path and nd->next_seq might've been clobbered
 		path->mnt = nd->path.mnt;
 		path->dentry = dentry;
 		nd->next_seq = seq;
-		if (!try_to_unlazy_next(nd, dentry))
+		if (unlikely(!try_to_unlazy_next(nd, dentry)))
 			return -ECHILD;
 	}
 	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags);
@@ -1941,12 +1941,23 @@ static int reserve_stack(struct nameidata *nd, struct path *link)
 
 enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
-static const char *pick_link(struct nameidata *nd, struct path *link,
+static noinline const char *pick_link(struct nameidata *nd, struct path *link,
 		     struct inode *inode, int flags)
 {
 	struct saved *last;
 	const char *res;
-	int error = reserve_stack(nd, link);
+	int error;
+
+	if (nd->flags & LOOKUP_RCU) {
+		/* make sure that d_is_symlink above matches inode */
+		if (read_seqcount_retry(&link->dentry->d_seq, nd->next_seq))
+			return ERR_PTR(-ECHILD);
+	} else {
+		if (link->mnt == nd->path.mnt)
+			mntget(link->mnt);
+	}
+
+	error = reserve_stack(nd, link);
 
 	if (unlikely(error)) {
 		if (!(nd->flags & LOOKUP_RCU))
@@ -2021,14 +2032,17 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
  *
  * NOTE: dentry must be what nd->next_seq had been sampled from.
  */
-static const char *step_into(struct nameidata *nd, int flags,
+static noinline const char *step_into_slowpath(struct nameidata *nd, int flags,
 		     struct dentry *dentry)
 {
 	struct path path;
 	struct inode *inode;
-	int err = handle_mounts(nd, dentry, &path);
+	int err;
 
-	if (err < 0)
+	path.mnt = nd->path.mnt;
+	path.dentry = dentry;
+	err = handle_mounts(nd, dentry, &path);
+	if (unlikely(err < 0))
 		return ERR_PTR(err);
 	inode = path.dentry->d_inode;
 	if (likely(!d_is_symlink(path.dentry)) ||
@@ -2050,17 +2064,36 @@ static const char *step_into(struct nameidata *nd, int flags,
 		nd->seq = nd->next_seq;
 		return NULL;
 	}
-	if (nd->flags & LOOKUP_RCU) {
-		/* make sure that d_is_symlink above matches inode */
-		if (read_seqcount_retry(&path.dentry->d_seq, nd->next_seq))
-			return ERR_PTR(-ECHILD);
-	} else {
-		if (path.mnt == nd->path.mnt)
-			mntget(path.mnt);
-	}
 	return pick_link(nd, &path, inode, flags);
 }
 
+static __always_inline const char *step_into(struct nameidata *nd, int flags,
+		     struct dentry *dentry)
+{
+	struct path path;
+	struct inode *inode;
+
+	path.mnt = nd->path.mnt;
+	path.dentry = dentry;
+	if (!(nd->flags & LOOKUP_RCU))
+		goto slowpath;
+	if (unlikely(dentry->d_flags & DCACHE_MANAGED_DENTRY))
+		goto slowpath;
+	inode = path.dentry->d_inode;
+	if (unlikely(d_is_symlink(path.dentry)))
+		goto slowpath;
+	if (read_seqcount_retry(&path.dentry->d_seq, nd->next_seq))
+		return ERR_PTR(-ECHILD);
+	if (unlikely(!inode))
+		return ERR_PTR(-ENOENT);
+	nd->path = path;
+	nd->inode = inode;
+	nd->seq = nd->next_seq;
+	return NULL;
+slowpath:
+	return step_into_slowpath(nd, flags, dentry);
+}
+
 static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
 {
 	struct dentry *parent, *old;
@@ -2171,7 +2204,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 	return NULL;
 }
 
-static const char *walk_component(struct nameidata *nd, int flags)
+static __always_inline const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
 	/*
-- 
2.48.1


