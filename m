Return-Path: <linux-fsdevel+bounces-72243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B6CE99E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 096403015D07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E77299931;
	Tue, 30 Dec 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8tXW/Rp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RcTjvvA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26E298CAB;
	Tue, 30 Dec 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767096675; cv=none; b=s5IOFjjrihhAQLhgYeD6GVgjy+wFghs1eq8+jzaUFemvMN+BOaCnu4phwYy4MMLGJe919VR581Qc6II1OtLJgrYPh0TV4IvD1V3FsWDHj5/PgxjxgCyjdmWsKWTAhhpuzVVio9mRmGvwG0GSDUQZI1D5uRBXLcS7xbXxguf6p08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767096675; c=relaxed/simple;
	bh=jYeOUbJePcJsXDTaWPIf3zspQYEwwsmdi8dcf2p+mcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P+Vp08XtwYLmqhTxxt6i5OGdOJQnvescOt/qNzE09SWe0A20/cpJJMs2m97M29fKHriJGWn2SX1T5I5wV7S48UAGNm1nRrV3ZxqSvm//fUkLFs05sQDMi71HDBYeg2pPxHC3vALKwc5E3SP/zFfgARXT9Oc1ULJDTgsTRxNNrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8tXW/Rp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RcTjvvA9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767096665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=226DzdC6C38tDDHXPI1xLXeDUSiR/Uwaz0Lae9D8NVg=;
	b=b8tXW/RpKaAjHNMcrY02YfqUpfvqj8urFB+ezYXy0vDclwWyT2ne8IU8OxcQ2USur2DMDx
	6nhnaz1JAfi3ZNFCt0f+Xp9i+qc+33gya9e1/h+u9qYX6pBwTDSjF+lXK+87xERA5i9gfR
	VfE9lg8D3GnbCQhh01n+7u+eoJfp0q5yrAGjCSTGgcKjcQE/cqEqkaGZd+4aCX7M3+5KY2
	Bh3Va+1w4g3mq5JJm3dFb6+eEBWqU9k97yh2kpv9DHOTQxVXzPljmwlUN5M0ng0/j9/b76
	uiYJ2EG/MX5P/w+3wwXUVkbgxsaTRDTxj4Z4YSwbQFLO0f1fpN/DrzXB0JPwHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767096665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=226DzdC6C38tDDHXPI1xLXeDUSiR/Uwaz0Lae9D8NVg=;
	b=RcTjvvA92RAGdj4uA8F11OnuNNksB1CbCSnSQwcF33nyaPkx6N0HyveUlLDL71tOONGFIw
	946k0q1CUinp6eBg==
Date: Tue, 30 Dec 2025 13:10:34 +0100
Subject: [PATCH v2] fuse: uapi: use UAPI types
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
X-B4-Tracking: v=1; b=H4sIADnBU2kC/23MQQrDIBCF4auEWdcSBWvoqvcoWYxxbAaKCRolJ
 Xj32qy7/B+P74BEkSnBvTsgUuHES2ihLh1MM4YXCXatQfVKS6WUyLiy8DmRkDg5bzVabwy0/xr
 J835az7H1zGlb4ueki/yt/5QihRSDxpu0g7GI/ePNIW9xCbxfHcFYa/0CbYL58aYAAAA=
X-Change-ID: 20251222-uapi-fuse-1acdfb5abf77
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767096662; l=19827;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jYeOUbJePcJsXDTaWPIf3zspQYEwwsmdi8dcf2p+mcI=;
 b=HQQMS7P5Gn4AasfKi/L3+BIUYZXBeMv47lRX1E+8XQW8jVXWwGywUo7RlwSiNxiUooiLkdjNf
 av8aE/G6U1zBP3KtbmfVTUiDtgJBPal5ljI2CQ0C3reVwHLE22FUdyy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Using libc types and headers from the UAPI headers is problematic as it
introduces a dependency on a full C toolchain.

Use the fixed-width integer types provided by the UAPI headers instead.
To keep compatibility with non-Linux platforms, add a stdint.h fallback.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Fix structure member alignments
- Keep compatibility with non-Linux platforms
- Link to v1: https://lore.kernel.org/r/20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de
---
 include/uapi/linux/fuse.h | 626 +++++++++++++++++++++++-----------------------
 1 file changed, 319 insertions(+), 307 deletions(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..121a1552e4cd 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -245,10 +245,22 @@
 #ifndef _LINUX_FUSE_H
 #define _LINUX_FUSE_H
 
-#ifdef __KERNEL__
+#if defined(__KERNEL__)
+#include <linux/types.h>
+#elif defined(__linux__)
 #include <linux/types.h>
 #else
 #include <stdint.h>
+
+typedef	uint8_t		__u8;
+typedef	uint16_t	__u16;
+typedef	uint32_t	__u32;
+typedef	uint64_t	__u64;
+
+typedef	int8_t		__s8;
+typedef	int16_t		__s16;
+typedef	int32_t		__s32;
+typedef	int64_t		__s64;
 #endif
 
 /*
@@ -284,22 +296,22 @@
    userspace works under 64bit kernels */
 
 struct fuse_attr {
-	uint64_t	ino;
-	uint64_t	size;
-	uint64_t	blocks;
-	uint64_t	atime;
-	uint64_t	mtime;
-	uint64_t	ctime;
-	uint32_t	atimensec;
-	uint32_t	mtimensec;
-	uint32_t	ctimensec;
-	uint32_t	mode;
-	uint32_t	nlink;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint32_t	rdev;
-	uint32_t	blksize;
-	uint32_t	flags;
+	__u64	ino;
+	__u64	size;
+	__u64	blocks;
+	__u64	atime;
+	__u64	mtime;
+	__u64	ctime;
+	__u32	atimensec;
+	__u32	mtimensec;
+	__u32	ctimensec;
+	__u32	mode;
+	__u32	nlink;
+	__u32	uid;
+	__u32	gid;
+	__u32	rdev;
+	__u32	blksize;
+	__u32	flags;
 };
 
 /*
@@ -307,53 +319,53 @@ struct fuse_attr {
  * Linux.
  */
 struct fuse_sx_time {
-	int64_t		tv_sec;
-	uint32_t	tv_nsec;
-	int32_t		__reserved;
+	__s64	tv_sec;
+	__u32	tv_nsec;
+	__s32	__reserved;
 };
 
 struct fuse_statx {
-	uint32_t	mask;
-	uint32_t	blksize;
-	uint64_t	attributes;
-	uint32_t	nlink;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint16_t	mode;
-	uint16_t	__spare0[1];
-	uint64_t	ino;
-	uint64_t	size;
-	uint64_t	blocks;
-	uint64_t	attributes_mask;
+	__u32	mask;
+	__u32	blksize;
+	__u64	attributes;
+	__u32	nlink;
+	__u32	uid;
+	__u32	gid;
+	__u16	mode;
+	__u16	__spare0[1];
+	__u64	ino;
+	__u64	size;
+	__u64	blocks;
+	__u64	attributes_mask;
 	struct fuse_sx_time	atime;
 	struct fuse_sx_time	btime;
 	struct fuse_sx_time	ctime;
 	struct fuse_sx_time	mtime;
-	uint32_t	rdev_major;
-	uint32_t	rdev_minor;
-	uint32_t	dev_major;
-	uint32_t	dev_minor;
-	uint64_t	__spare2[14];
+	__u32	rdev_major;
+	__u32	rdev_minor;
+	__u32	dev_major;
+	__u32	dev_minor;
+	__u64	__spare2[14];
 };
 
 struct fuse_kstatfs {
-	uint64_t	blocks;
-	uint64_t	bfree;
-	uint64_t	bavail;
-	uint64_t	files;
-	uint64_t	ffree;
-	uint32_t	bsize;
-	uint32_t	namelen;
-	uint32_t	frsize;
-	uint32_t	padding;
-	uint32_t	spare[6];
+	__u64	blocks;
+	__u64	bfree;
+	__u64	bavail;
+	__u64	files;
+	__u64	ffree;
+	__u32	bsize;
+	__u32	namelen;
+	__u32	frsize;
+	__u32	padding;
+	__u32	spare[6];
 };
 
 struct fuse_file_lock {
-	uint64_t	start;
-	uint64_t	end;
-	uint32_t	type;
-	uint32_t	pid; /* tgid */
+	__u64	start;
+	__u64	end;
+	__u32	type;
+	__u32	pid; /* tgid */
 };
 
 /**
@@ -690,165 +702,165 @@ enum fuse_notify_code {
 #define FUSE_COMPAT_ENTRY_OUT_SIZE 120
 
 struct fuse_entry_out {
-	uint64_t	nodeid;		/* Inode ID */
-	uint64_t	generation;	/* Inode generation: nodeid:gen must
-					   be unique for the fs's lifetime */
-	uint64_t	entry_valid;	/* Cache timeout for the name */
-	uint64_t	attr_valid;	/* Cache timeout for the attributes */
-	uint32_t	entry_valid_nsec;
-	uint32_t	attr_valid_nsec;
+	__u64	nodeid;		/* Inode ID */
+	__u64	generation;	/* Inode generation: nodeid:gen must
+				   be unique for the fs's lifetime */
+	__u64	entry_valid;	/* Cache timeout for the name */
+	__u64	attr_valid;	/* Cache timeout for the attributes */
+	__u32	entry_valid_nsec;
+	__u32	attr_valid_nsec;
 	struct fuse_attr attr;
 };
 
 struct fuse_forget_in {
-	uint64_t	nlookup;
+	__u64	nlookup;
 };
 
 struct fuse_forget_one {
-	uint64_t	nodeid;
-	uint64_t	nlookup;
+	__u64	nodeid;
+	__u64	nlookup;
 };
 
 struct fuse_batch_forget_in {
-	uint32_t	count;
-	uint32_t	dummy;
+	__u32	count;
+	__u32	dummy;
 };
 
 struct fuse_getattr_in {
-	uint32_t	getattr_flags;
-	uint32_t	dummy;
-	uint64_t	fh;
+	__u32	getattr_flags;
+	__u32	dummy;
+	__u64	fh;
 };
 
 #define FUSE_COMPAT_ATTR_OUT_SIZE 96
 
 struct fuse_attr_out {
-	uint64_t	attr_valid;	/* Cache timeout for the attributes */
-	uint32_t	attr_valid_nsec;
-	uint32_t	dummy;
+	__u64	attr_valid;	/* Cache timeout for the attributes */
+	__u32	attr_valid_nsec;
+	__u32	dummy;
 	struct fuse_attr attr;
 };
 
 struct fuse_statx_in {
-	uint32_t	getattr_flags;
-	uint32_t	reserved;
-	uint64_t	fh;
-	uint32_t	sx_flags;
-	uint32_t	sx_mask;
+	__u32	getattr_flags;
+	__u32	reserved;
+	__u64	fh;
+	__u32	sx_flags;
+	__u32	sx_mask;
 };
 
 struct fuse_statx_out {
-	uint64_t	attr_valid;	/* Cache timeout for the attributes */
-	uint32_t	attr_valid_nsec;
-	uint32_t	flags;
-	uint64_t	spare[2];
+	__u64	attr_valid;	/* Cache timeout for the attributes */
+	__u32	attr_valid_nsec;
+	__u32	flags;
+	__u64	spare[2];
 	struct fuse_statx stat;
 };
 
 #define FUSE_COMPAT_MKNOD_IN_SIZE 8
 
 struct fuse_mknod_in {
-	uint32_t	mode;
-	uint32_t	rdev;
-	uint32_t	umask;
-	uint32_t	padding;
+	__u32	mode;
+	__u32	rdev;
+	__u32	umask;
+	__u32	padding;
 };
 
 struct fuse_mkdir_in {
-	uint32_t	mode;
-	uint32_t	umask;
+	__u32	mode;
+	__u32	umask;
 };
 
 struct fuse_rename_in {
-	uint64_t	newdir;
+	__u64	newdir;
 };
 
 struct fuse_rename2_in {
-	uint64_t	newdir;
-	uint32_t	flags;
-	uint32_t	padding;
+	__u64	newdir;
+	__u32	flags;
+	__u32	padding;
 };
 
 struct fuse_link_in {
-	uint64_t	oldnodeid;
+	__u64	oldnodeid;
 };
 
 struct fuse_setattr_in {
-	uint32_t	valid;
-	uint32_t	padding;
-	uint64_t	fh;
-	uint64_t	size;
-	uint64_t	lock_owner;
-	uint64_t	atime;
-	uint64_t	mtime;
-	uint64_t	ctime;
-	uint32_t	atimensec;
-	uint32_t	mtimensec;
-	uint32_t	ctimensec;
-	uint32_t	mode;
-	uint32_t	unused4;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint32_t	unused5;
+	__u32	valid;
+	__u32	padding;
+	__u64	fh;
+	__u64	size;
+	__u64	lock_owner;
+	__u64	atime;
+	__u64	mtime;
+	__u64	ctime;
+	__u32	atimensec;
+	__u32	mtimensec;
+	__u32	ctimensec;
+	__u32	mode;
+	__u32	unused4;
+	__u32	uid;
+	__u32	gid;
+	__u32	unused5;
 };
 
 struct fuse_open_in {
-	uint32_t	flags;
-	uint32_t	open_flags;	/* FUSE_OPEN_... */
+	__u32	flags;
+	__u32	open_flags;	/* FUSE_OPEN_... */
 };
 
 struct fuse_create_in {
-	uint32_t	flags;
-	uint32_t	mode;
-	uint32_t	umask;
-	uint32_t	open_flags;	/* FUSE_OPEN_... */
+	__u32	flags;
+	__u32	mode;
+	__u32	umask;
+	__u32	open_flags;	/* FUSE_OPEN_... */
 };
 
 struct fuse_open_out {
-	uint64_t	fh;
-	uint32_t	open_flags;
-	int32_t		backing_id;
+	__u64	fh;
+	__u32	open_flags;
+	__s32	backing_id;
 };
 
 struct fuse_release_in {
-	uint64_t	fh;
-	uint32_t	flags;
-	uint32_t	release_flags;
-	uint64_t	lock_owner;
+	__u64	fh;
+	__u32	flags;
+	__u32	release_flags;
+	__u64	lock_owner;
 };
 
 struct fuse_flush_in {
-	uint64_t	fh;
-	uint32_t	unused;
-	uint32_t	padding;
-	uint64_t	lock_owner;
+	__u64	fh;
+	__u32	unused;
+	__u32	padding;
+	__u64	lock_owner;
 };
 
 struct fuse_read_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	read_flags;
-	uint64_t	lock_owner;
-	uint32_t	flags;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u32	size;
+	__u32	read_flags;
+	__u64	lock_owner;
+	__u32	flags;
+	__u32	padding;
 };
 
 #define FUSE_COMPAT_WRITE_IN_SIZE 24
 
 struct fuse_write_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	write_flags;
-	uint64_t	lock_owner;
-	uint32_t	flags;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u32	size;
+	__u32	write_flags;
+	__u64	lock_owner;
+	__u32	flags;
+	__u32	padding;
 };
 
 struct fuse_write_out {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 #define FUSE_COMPAT_STATFS_SIZE 48
@@ -858,36 +870,36 @@ struct fuse_statfs_out {
 };
 
 struct fuse_fsync_in {
-	uint64_t	fh;
-	uint32_t	fsync_flags;
-	uint32_t	padding;
+	__u64	fh;
+	__u32	fsync_flags;
+	__u32	padding;
 };
 
 #define FUSE_COMPAT_SETXATTR_IN_SIZE 8
 
 struct fuse_setxattr_in {
-	uint32_t	size;
-	uint32_t	flags;
-	uint32_t	setxattr_flags;
-	uint32_t	padding;
+	__u32	size;
+	__u32	flags;
+	__u32	setxattr_flags;
+	__u32	padding;
 };
 
 struct fuse_getxattr_in {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_getxattr_out {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_lk_in {
-	uint64_t	fh;
-	uint64_t	owner;
+	__u64	fh;
+	__u64	owner;
 	struct fuse_file_lock lk;
-	uint32_t	lk_flags;
-	uint32_t	padding;
+	__u32	lk_flags;
+	__u32	padding;
 };
 
 struct fuse_lk_out {
@@ -895,117 +907,117 @@ struct fuse_lk_out {
 };
 
 struct fuse_access_in {
-	uint32_t	mask;
-	uint32_t	padding;
+	__u32	mask;
+	__u32	padding;
 };
 
 struct fuse_init_in {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	max_readahead;
-	uint32_t	flags;
-	uint32_t	flags2;
-	uint32_t	unused[11];
+	__u32	major;
+	__u32	minor;
+	__u32	max_readahead;
+	__u32	flags;
+	__u32	flags2;
+	__u32	unused[11];
 };
 
 #define FUSE_COMPAT_INIT_OUT_SIZE 8
 #define FUSE_COMPAT_22_INIT_OUT_SIZE 24
 
 struct fuse_init_out {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	max_readahead;
-	uint32_t	flags;
-	uint16_t	max_background;
-	uint16_t	congestion_threshold;
-	uint32_t	max_write;
-	uint32_t	time_gran;
-	uint16_t	max_pages;
-	uint16_t	map_alignment;
-	uint32_t	flags2;
-	uint32_t	max_stack_depth;
-	uint16_t	request_timeout;
-	uint16_t	unused[11];
+	__u32	major;
+	__u32	minor;
+	__u32	max_readahead;
+	__u32	flags;
+	__u16	max_background;
+	__u16	congestion_threshold;
+	__u32	max_write;
+	__u32	time_gran;
+	__u16	max_pages;
+	__u16	map_alignment;
+	__u32	flags2;
+	__u32	max_stack_depth;
+	__u16	request_timeout;
+	__u16	unused[11];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
 
 struct cuse_init_in {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	unused;
-	uint32_t	flags;
+	__u32	major;
+	__u32	minor;
+	__u32	unused;
+	__u32	flags;
 };
 
 struct cuse_init_out {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	unused;
-	uint32_t	flags;
-	uint32_t	max_read;
-	uint32_t	max_write;
-	uint32_t	dev_major;		/* chardev major */
-	uint32_t	dev_minor;		/* chardev minor */
-	uint32_t	spare[10];
+	__u32	major;
+	__u32	minor;
+	__u32	unused;
+	__u32	flags;
+	__u32	max_read;
+	__u32	max_write;
+	__u32	dev_major;		/* chardev major */
+	__u32	dev_minor;		/* chardev minor */
+	__u32	spare[10];
 };
 
 struct fuse_interrupt_in {
-	uint64_t	unique;
+	__u64	unique;
 };
 
 struct fuse_bmap_in {
-	uint64_t	block;
-	uint32_t	blocksize;
-	uint32_t	padding;
+	__u64	block;
+	__u32	blocksize;
+	__u32	padding;
 };
 
 struct fuse_bmap_out {
-	uint64_t	block;
+	__u64	block;
 };
 
 struct fuse_ioctl_in {
-	uint64_t	fh;
-	uint32_t	flags;
-	uint32_t	cmd;
-	uint64_t	arg;
-	uint32_t	in_size;
-	uint32_t	out_size;
+	__u64	fh;
+	__u32	flags;
+	__u32	cmd;
+	__u64	arg;
+	__u32	in_size;
+	__u32	out_size;
 };
 
 struct fuse_ioctl_iovec {
-	uint64_t	base;
-	uint64_t	len;
+	__u64	base;
+	__u64	len;
 };
 
 struct fuse_ioctl_out {
-	int32_t		result;
-	uint32_t	flags;
-	uint32_t	in_iovs;
-	uint32_t	out_iovs;
+	__s32	result;
+	__u32	flags;
+	__u32	in_iovs;
+	__u32	out_iovs;
 };
 
 struct fuse_poll_in {
-	uint64_t	fh;
-	uint64_t	kh;
-	uint32_t	flags;
-	uint32_t	events;
+	__u64	fh;
+	__u64	kh;
+	__u32	flags;
+	__u32	events;
 };
 
 struct fuse_poll_out {
-	uint32_t	revents;
-	uint32_t	padding;
+	__u32	revents;
+	__u32	padding;
 };
 
 struct fuse_notify_poll_wakeup_out {
-	uint64_t	kh;
+	__u64	kh;
 };
 
 struct fuse_fallocate_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint64_t	length;
-	uint32_t	mode;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u64	length;
+	__u32	mode;
+	__u32	padding;
 };
 
 /**
@@ -1029,37 +1041,37 @@ struct fuse_fallocate_in {
  * FUSE_MKNOD, FUSE_SYMLINK, FUSE_MKDIR, FUSE_TMPFILE,
  * FUSE_CREATE and FUSE_RENAME2 (with RENAME_WHITEOUT).
  */
-#define FUSE_INVALID_UIDGID ((uint32_t)(-1))
+#define FUSE_INVALID_UIDGID ((__u32)(-1))
 
 struct fuse_in_header {
-	uint32_t	len;
-	uint32_t	opcode;
-	uint64_t	unique;
-	uint64_t	nodeid;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint32_t	pid;
-	uint16_t	total_extlen; /* length of extensions in 8byte units */
-	uint16_t	padding;
+	__u32	len;
+	__u32	opcode;
+	__u64	unique;
+	__u64	nodeid;
+	__u32	uid;
+	__u32	gid;
+	__u32	pid;
+	__u16	total_extlen; /* length of extensions in 8byte units */
+	__u16	padding;
 };
 
 struct fuse_out_header {
-	uint32_t	len;
-	int32_t		error;
-	uint64_t	unique;
+	__u32	len;
+	__s32	error;
+	__u64	unique;
 };
 
 struct fuse_dirent {
-	uint64_t	ino;
-	uint64_t	off;
-	uint32_t	namelen;
-	uint32_t	type;
+	__u64	ino;
+	__u64	off;
+	__u32	namelen;
+	__u32	type;
 	char name[];
 };
 
 /* Align variable length records to 64bit boundary */
 #define FUSE_REC_ALIGN(x) \
-	(((x) + sizeof(uint64_t) - 1) & ~(sizeof(uint64_t) - 1))
+	(((x) + sizeof(__u64) - 1) & ~(sizeof(__u64) - 1))
 
 #define FUSE_NAME_OFFSET offsetof(struct fuse_dirent, name)
 #define FUSE_DIRENT_ALIGN(x) FUSE_REC_ALIGN(x)
@@ -1077,127 +1089,127 @@ struct fuse_direntplus {
 	FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET_DIRENTPLUS + (d)->dirent.namelen)
 
 struct fuse_notify_inval_inode_out {
-	uint64_t	ino;
-	int64_t		off;
-	int64_t		len;
+	__u64	ino;
+	__s64	off;
+	__s64	len;
 };
 
 struct fuse_notify_inval_entry_out {
-	uint64_t	parent;
-	uint32_t	namelen;
-	uint32_t	flags;
+	__u64	parent;
+	__u32	namelen;
+	__u32	flags;
 };
 
 struct fuse_notify_delete_out {
-	uint64_t	parent;
-	uint64_t	child;
-	uint32_t	namelen;
-	uint32_t	padding;
+	__u64	parent;
+	__u64	child;
+	__u32	namelen;
+	__u32	padding;
 };
 
 struct fuse_notify_store_out {
-	uint64_t	nodeid;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	padding;
+	__u64	nodeid;
+	__u64	offset;
+	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_notify_retrieve_out {
-	uint64_t	notify_unique;
-	uint64_t	nodeid;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	padding;
+	__u64	notify_unique;
+	__u64	nodeid;
+	__u64	offset;
+	__u32	size;
+	__u32	padding;
 };
 
 /* Matches the size of fuse_write_in */
 struct fuse_notify_retrieve_in {
-	uint64_t	dummy1;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	dummy2;
-	uint64_t	dummy3;
-	uint64_t	dummy4;
+	__u64	dummy1;
+	__u64	offset;
+	__u32	size;
+	__u32	dummy2;
+	__u64	dummy3;
+	__u64	dummy4;
 };
 
 struct fuse_notify_prune_out {
-	uint32_t	count;
-	uint32_t	padding;
-	uint64_t	spare;
+	__u32	count;
+	__u32	padding;
+	__u64	spare;
 };
 
 struct fuse_backing_map {
-	int32_t		fd;
-	uint32_t	flags;
-	uint64_t	padding;
+	__s32	fd;
+	__u32	flags;
+	__u64	padding;
 };
 
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
-#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, __u32)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
-#define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, __u32)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint32_t	whence;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u32	whence;
+	__u32	padding;
 };
 
 struct fuse_lseek_out {
-	uint64_t	offset;
+	__u64	offset;
 };
 
 struct fuse_copy_file_range_in {
-	uint64_t	fh_in;
-	uint64_t	off_in;
-	uint64_t	nodeid_out;
-	uint64_t	fh_out;
-	uint64_t	off_out;
-	uint64_t	len;
-	uint64_t	flags;
+	__u64	fh_in;
+	__u64	off_in;
+	__u64	nodeid_out;
+	__u64	fh_out;
+	__u64	off_out;
+	__u64	len;
+	__u64	flags;
 };
 
 /* For FUSE_COPY_FILE_RANGE_64 */
 struct fuse_copy_file_range_out {
-	uint64_t	bytes_copied;
+	__u64	bytes_copied;
 };
 
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
 #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
 	/* An already open handle */
-	uint64_t	fh;
+	__u64	fh;
 	/* Offset into the file to start the mapping */
-	uint64_t	foffset;
+	__u64	foffset;
 	/* Length of mapping required */
-	uint64_t	len;
+	__u64	len;
 	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
-	uint64_t	flags;
+	__u64	flags;
 	/* Offset in Memory Window */
-	uint64_t	moffset;
+	__u64	moffset;
 };
 
 struct fuse_removemapping_in {
 	/* number of fuse_removemapping_one follows */
-	uint32_t        count;
+	__u32	count;
 };
 
 struct fuse_removemapping_one {
 	/* Offset into the dax window start the unmapping */
-	uint64_t        moffset;
+	__u64	moffset;
 	/* Length of mapping required */
-	uint64_t	len;
+	__u64	len;
 };
 
 #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
 		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
 
 struct fuse_syncfs_in {
-	uint64_t	padding;
+	__u64	padding;
 };
 
 /*
@@ -1207,8 +1219,8 @@ struct fuse_syncfs_in {
  * fuse_secctx, name, context
  */
 struct fuse_secctx {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 /*
@@ -1218,8 +1230,8 @@ struct fuse_secctx {
  *
  */
 struct fuse_secctx_header {
-	uint32_t	size;
-	uint32_t	nr_secctx;
+	__u32	size;
+	__u32	nr_secctx;
 };
 
 /**
@@ -1231,8 +1243,8 @@ struct fuse_secctx_header {
  * FUSE_MAX_NR_SECCTX
  */
 struct fuse_ext_header {
-	uint32_t	size;
-	uint32_t	type;
+	__u32	size;
+	__u32	type;
 };
 
 /**
@@ -1241,8 +1253,8 @@ struct fuse_ext_header {
  * @groups: flexible array of group IDs
  */
 struct fuse_supp_groups {
-	uint32_t	nr_groups;
-	uint32_t	groups[];
+	__u32	nr_groups;
+	__u32	groups[];
 };
 
 /**
@@ -1253,19 +1265,19 @@ struct fuse_supp_groups {
 
 /* Used as part of the fuse_uring_req_header */
 struct fuse_uring_ent_in_out {
-	uint64_t flags;
+	__u64 flags;
 
 	/*
 	 * commit ID to be used in a reply to a ring request (see also
 	 * struct fuse_uring_cmd_req)
 	 */
-	uint64_t commit_id;
+	__u64 commit_id;
 
 	/* size of user payload buffer */
-	uint32_t payload_sz;
-	uint32_t padding;
+	__u32 payload_sz;
+	__u32 padding;
 
-	uint64_t reserved;
+	__u64 reserved;
 };
 
 /**
@@ -1298,14 +1310,14 @@ enum fuse_uring_cmd {
  * In the 80B command area of the SQE.
  */
 struct fuse_uring_cmd_req {
-	uint64_t flags;
+	__u64	flags;
 
 	/* entry identifier for commits */
-	uint64_t commit_id;
+	__u64	commit_id;
 
 	/* queue the command is for (queue index) */
-	uint16_t qid;
-	uint8_t padding[6];
+	__u16	qid;
+	__u8	padding[6];
 };
 
 #endif /* _LINUX_FUSE_H */

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-uapi-fuse-1acdfb5abf77

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


