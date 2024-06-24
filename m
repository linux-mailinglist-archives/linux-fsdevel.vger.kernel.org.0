Return-Path: <linux-fsdevel+bounces-22226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F7C914555
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3251C20B15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C178C61;
	Mon, 24 Jun 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Akb8+ceI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC645A4D5;
	Mon, 24 Jun 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219084; cv=none; b=gKWOgz28y646bIx1jRn4W0hZOdKpzniZYio9uBRiEhdVJmmhDdTZxxn20AwvlUbesF6epOn2rNSNd8qcFAfI5utsbajQLf5RF6F2DHuxTR2CB9nlQgcH8I5DBa2TdUU3vbDbunmQqUoVPLN0eAXfez9dlMdhoNE0u3eMAtSPbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219084; c=relaxed/simple;
	bh=bR/D0cZcNZxtUGrIbt3MJF86EwDDVoIYS//ABn9SvEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDL+rUcQuMgn/CT2OTZ56ARrWL6CVh643CSRlkHPC/k+5nl5iJ3/U5oLDXgwl6doltlWJXh3sUyPBNFGCwUtbnEeTpyDtcPr725ChH1Sa+Ma46sfEmy8UhvYNZSUWbMRBC6PyoAy/r/8i35V0NPKxhqL97j3HpfA1udxhNqUolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Akb8+ceI; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719219079;
	bh=bR/D0cZcNZxtUGrIbt3MJF86EwDDVoIYS//ABn9SvEw=;
	h=From:To:Cc:Subject:Date:From;
	b=Akb8+ceIjRPVLHXpOLTM5LSCrQTmXTpw0nD49ABxNEauFXmwyzS4SkmRwYHyFiIdb
	 Uu0qNuhH/DOtGHnmTWO+xa8IO0XG/Aa7c4uIm9P/V2ODNJKgX7ottPvOxR6yvm7ZWS
	 hOChv+on3LwOFg/7P8cVm5kdFTnXdgT1aulVqxsw=
Received: from stargazer.. (unknown [113.200.174.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8FC5666BF9;
	Mon, 24 Jun 2024 04:51:13 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Alejandro Colomar <alx@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vfs: Shortcut AT_EMPTY_PATH early for statx, and add AT_NO_PATH for statx and fstatat
Date: Mon, 24 Jun 2024 16:50:26 +0800
Message-ID: <20240624085037.33442-2-xry111@xry111.site>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's cheap to check if the path is empty in the userspace, but expensive
to check if a userspace string is empty from the kernel.  So it seems a
waste to delay the check into the kernel, and using statx(AT_EMPTY_PATH)
to implement fstat is slower than a "native" fstat call.

In the past there was a similar performance issue with several Glibc
releases using fstatat(AT_EMPTY_PATH) for fstat.  That issue was fixed
by Glibc with reverting back to plain fstat, and worked around by the
kernel with a special fast code path for fstatat(AT_EMPTY_PATH) at
commit 9013c51c630a ("vfs: mostly undo glibc turning 'fstat()' into
'fstatat(AT_EMPTY_PATH)'").

But for arch/loongarch fstat does not exist, so we have to use statx.
And on all 32-bit architectures we must use statx for fstat after 2037
since the plain fstat call uses 32-bit timestamp.  Thus Glibc uses statx
for fstat on LoongArch and all 32-bit platforms, and these platforms
still suffer the performance issue.

So port the fstatat(AT_EMPTY_PATH) fast path to statx(AT_EMPTY_PATH) as
well, and add AT_NO_PATH (the name is suggested by Mateusz) which makes
statx and fstatat completely skip the path check and assume the path is
empty.

Benchmark on LoongArch Loongson 3A6000:

1. Unpatched kernel, Glibc fstat, actually statx(AT_EMPTY_PATH):
   2575328 ops/s
2. Patched kernel, Glibc fstat, actually statx(AT_EMPTY_PATH):
   5434782 ops/s, +111% from 1
3. Patched kernel, statx(AT_NO_PATH): 5773672 ops/s, +124% from 1,
   +6.2% from 2.

Seccomp sandboxes can also green light fstatat/statx(AT_NO_PATH) easier
than fstatat/statx(AT_EMPTY_PATH) for which the audition needs to check
5434782543478254347825434782the path but seccomp BPF program cannot do that now.

Link: https://sourceware.org/pipermail/libc-alpha/2023-September/151364.html
Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=e6547d635b99
Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=551101e8240b
Link: https://lore.kernel.org/loongarch/599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name/
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Xuerui Wang <kernel@xen0n.name>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---

Superseds
https://lore.kernel.org/all/20240622105621.7922-1-xry111@xry111.site/.

 fs/stat.c                  | 103 +++++++++++++++++++++++++------------
 include/uapi/linux/fcntl.h |   3 ++
 2 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 70bd3e888cfa..2b7d4a22f971 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -208,7 +208,7 @@ int getname_statx_lookup_flags(int flags)
 		lookup_flags |= LOOKUP_FOLLOW;
 	if (!(flags & AT_NO_AUTOMOUNT))
 		lookup_flags |= LOOKUP_AUTOMOUNT;
-	if (flags & AT_EMPTY_PATH)
+	if (flags & (AT_EMPTY_PATH | AT_NO_PATH))
 		lookup_flags |= LOOKUP_EMPTY;
 
 	return lookup_flags;
@@ -217,7 +217,8 @@ int getname_statx_lookup_flags(int flags)
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative filename
- * @filename: The name of the file of interest
+ * @filename: The name of the file of interest, or NULL if the file of
+	      interest is dfd itself and dfd isn't AT_FDCWD
  * @flags: Flags to control the query
  * @stat: The result structure to fill in.
  * @request_mask: STATX_xxx flags indicating what the caller wants
@@ -232,42 +233,56 @@ int getname_statx_lookup_flags(int flags)
 static int vfs_statx(int dfd, struct filename *filename, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
-	struct path path;
+	struct path path, *p;
+	struct fd f;
 	unsigned int lookup_flags = getname_statx_lookup_flags(flags);
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
-		      AT_STATX_SYNC_TYPE))
+		      AT_STATX_SYNC_TYPE | AT_NO_PATH))
 		return -EINVAL;
 
 retry:
-	error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
-	if (error)
-		goto out;
+	if (filename) {
+		p = &path;
+		error = filename_lookup(dfd, filename, lookup_flags, p,
+					NULL);
+		if (error)
+			goto out;
+	} else {
+		f = fdget_raw(dfd);
+		if (!f.file)
+			return -EBADF;
+		p = &f.file->f_path;
+	}
 
-	error = vfs_getattr(&path, stat, request_mask, flags);
+	error = vfs_getattr(p, stat, request_mask, flags);
 
 	if (request_mask & STATX_MNT_ID_UNIQUE) {
-		stat->mnt_id = real_mount(path.mnt)->mnt_id_unique;
+		stat->mnt_id = real_mount(p->mnt)->mnt_id_unique;
 		stat->result_mask |= STATX_MNT_ID_UNIQUE;
 	} else {
-		stat->mnt_id = real_mount(path.mnt)->mnt_id;
+		stat->mnt_id = real_mount(p->mnt)->mnt_id;
 		stat->result_mask |= STATX_MNT_ID;
 	}
 
-	if (path.mnt->mnt_root == path.dentry)
+	if (p->mnt->mnt_root == p->dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
 
 	/* Handle STATX_DIOALIGN for block devices. */
 	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
+		struct inode *inode = d_backing_inode(p->dentry);
 
 		if (S_ISBLK(inode->i_mode))
 			bdev_statx_dioalign(inode, stat);
 	}
 
-	path_put(&path);
+	if (filename)
+		path_put(p);
+	else
+		fdput(f);
+
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -276,33 +291,53 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 	return error;
 }
 
-int vfs_fstatat(int dfd, const char __user *filename,
-			      struct kstat *stat, int flags)
+static struct filename *getname_statx(int dfd, const char __user *filename,
+				      int flags)
 {
-	int ret;
-	int statx_flags = flags | AT_NO_AUTOMOUNT;
-	struct filename *name;
+	int r;
+	char c;
+	bool no_path = false;
+
+	if (dfd < 0 && dfd != AT_FDCWD)
+		return ERR_PTR(-EBADF);
 
 	/*
-	 * Work around glibc turning fstat() into fstatat(AT_EMPTY_PATH)
+	 * Work around glibc turning fstat() into fstatat(AT_EMPTY_PATH) or
+	 * statx(AT_EMPTY_PATH)
 	 *
 	 * If AT_EMPTY_PATH is set, we expect the common case to be that
 	 * empty path, and avoid doing all the extra pathname work.
 	 */
-	if (dfd >= 0 && flags == AT_EMPTY_PATH) {
-		char c;
+	if (flags & AT_NO_PATH)
+		no_path = true;
+	else if (flags & AT_EMPTY_PATH) {
+		r = get_user(c, filename);
+		if (unlikely(r))
+			return ERR_PTR(r);
+		no_path = likely(!c);
+	}
 
-		ret = get_user(c, filename);
-		if (unlikely(ret))
-			return ret;
+	if (no_path)
+		return dfd == AT_FDCWD ? getname_kernel("") : NULL;
 
-		if (likely(!c))
-			return vfs_fstat(dfd, stat);
-	}
+	return getname_flags(filename, getname_statx_lookup_flags(flags),
+			     NULL);
+}
+
+int vfs_fstatat(int dfd, const char __user *filename,
+			      struct kstat *stat, int flags)
+{
+	int ret;
+	int statx_flags = flags | AT_NO_AUTOMOUNT;
+	struct filename *name = getname_statx(dfd, filename, flags);
+
+	if (IS_ERR(name))
+		return PTR_ERR(name);
 
-	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags), NULL);
 	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
-	putname(name);
+
+	if (name)
+		putname(name);
 
 	return ret;
 }
@@ -703,11 +738,15 @@ SYSCALL_DEFINE5(statx,
 		struct statx __user *, buffer)
 {
 	int ret;
-	struct filename *name;
+	struct filename *name = getname_statx(dfd, filename, flags);
+
+	if (IS_ERR(name))
+		return PTR_ERR(name);
 
-	name = getname_flags(filename, getname_statx_lookup_flags(flags), NULL);
 	ret = do_statx(dfd, name, flags, mask, buffer);
-	putname(name);
+
+	if (name)
+		putname(name);
 
 	return ret;
 }
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..470b5c77000c 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -113,6 +113,9 @@
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+#define AT_NO_PATH		0x10000	/* Ignore relative pathname,
+					   behave as if AT_EMPTY_PATH and
+					   the relative pathname is empty */
 
 /* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
-- 
2.45.2


