Return-Path: <linux-fsdevel+bounces-69949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE8C8C7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF233B6949
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3F26B0A9;
	Thu, 27 Nov 2025 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipS4rAwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088C25785D;
	Thu, 27 Nov 2025 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204654; cv=none; b=PdZJki+xnDo9JMUsIIlctnGLsBiZqgV5/u52K+XNLWO/vY7tSHs5mG0b2lbqlxlMQsaUUP1qmNwn2Qx9nGvwon9pSe/YXAYBvcCfLCCKbK7IPaHLxRX4LLP6CGQxsM2BIgpfXM63bemOP4ZccqUuXLaVy9QQW027xKgRkS8xpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204654; c=relaxed/simple;
	bh=CVlEyWa7D9mln5Nkxb+lXzmfTw+NPN4skxBQ+KjRPkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcRkJeITcvVW5jZhNgwZctSiSCXc8/M201TozZarPG/gFrAth4mlHFr63jW9zauU2QTBgsAszAjMZAPuWuRFlgiGwM7/HOWoCeHIhalSADz5MCGpZ3sajZ+oKD72Ur21IisIf7mfHLPM/vQ9/smNUKTQ335BlgDsRS7/orH/zgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipS4rAwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83691C4CEF7;
	Thu, 27 Nov 2025 00:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764204654;
	bh=CVlEyWa7D9mln5Nkxb+lXzmfTw+NPN4skxBQ+KjRPkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipS4rAwa0+cuaGDRa2ANTJzgyH/tcHzkjc+SOMLA/8NBV7QWBPSlTGXA0Ph3x4hlr
	 kLjxrdDevhYneuVbDMozB6E3kOE4lwyKJQnsuMqVWXOsBkuQu/O/4tqlhY9oAkuBuG
	 SDqBrT1t7LaCrhUojN+xmb2N58+Sd2BIRLBb1pAQhnG8fHFJS0iMZuX2EZoCePndQC
	 QrBSt9U4zGWfFSiBv2vZ1wzf6E8D7+xxDXXm+9nZKOisW2dCfjM0E+dIkTigPppT4b
	 +tUwQWVB5OZVyhAzyvMWxn4Gec3OTP29xgWd3mg55Ta0Sn9MyAgW5JdvjdXWkndZnN
	 AhV73oABew06Q==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel-team@meta.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 2/3] bpf: Add bpf_kern_path and bpf_path_put kfuncs
Date: Wed, 26 Nov 2025 16:50:10 -0800
Message-ID: <20251127005011.1872209-7-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127005011.1872209-1-song@kernel.org>
References: <20251127005011.1872209-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new kfuncs to fs/bpf_fs_kfuncs.c that wrap kern_path() for use
by BPF LSM programs:

bpf_kern_path():
- Resolves a pathname string to a struct path
- Allocates memory for the path structure
- Returns NULL on error or if the path doesn't exist
- Marked with KF_ACQUIRE | KF_SLEEPABLE | KF_RET_NULL

bpf_path_put():
- Releases the path reference and frees the allocated memory
- Marked with KF_RELEASE to enforce acquire/release semantics

These kfuncs enable BPF LSM programs to resolve pathnames provided by
hook arguments (e.g., dev_name from sb_mount) and validate or inspect
the resolved paths. The verifier enforces proper resource management
through acquire/release tracking.

Example usage:
  struct path *p = bpf_kern_path("/etc/passwd", LOOKUP_FOLLOW);
  if (p) {
      // Use the path...
      bpf_path_put(p);  // Must release
  }

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 5ace2511fec5..977f8dcbc208 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/kernfs.h>
 #include <linux/mm.h>
+#include <linux/namei.h>
 #include <linux/xattr.h>
 
 __bpf_kfunc_start_defs();
@@ -96,6 +97,61 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	return len;
 }
 
+/**
+ * bpf_kern_path - resolve a pathname to a struct path
+ * @pathname__str: pathname to resolve
+ * @flags: lookup flags (e.g., LOOKUP_FOLLOW)
+ *
+ * Resolve the pathname for the supplied *pathname__str* and return a pointer
+ * to a struct path. This is a wrapper around kern_path() that allocates and
+ * returns a struct path pointer on success.
+ *
+ * The returned struct path pointer must be released using bpf_path_put().
+ * Failing to call bpf_path_put() on the returned struct path pointer will
+ * result in the BPF program being rejected by the BPF verifier.
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A pointer to an allocated struct path on success, NULL on error.
+ */
+__bpf_kfunc struct path *bpf_kern_path(const char *pathname__str, unsigned int flags)
+{
+	struct path *path;
+	int ret;
+
+	path = kmalloc(sizeof(*path), GFP_KERNEL);
+	if (!path)
+		return NULL;
+
+	ret = kern_path(pathname__str, flags, path);
+	if (ret) {
+		kfree(path);
+		return NULL;
+	}
+
+	return path;
+}
+
+/**
+ * bpf_path_put - release a struct path reference
+ * @path: struct path pointer to release
+ *
+ * Release the struct path pointer that was acquired by bpf_kern_path().
+ * This BPF kfunc calls path_put() on the supplied *path* and then frees
+ * the allocated memory.
+ *
+ * Only struct path pointers acquired by bpf_kern_path() may be passed to
+ * this BPF kfunc. Attempting to pass any other pointer will result in the
+ * BPF program being rejected by the BPF verifier.
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ */
+__bpf_kfunc void bpf_path_put(struct path *path)
+{
+	path_put(path);
+	kfree(path);
+}
+
 static bool match_security_bpf_prefix(const char *name__str)
 {
 	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
@@ -363,6 +419,8 @@ BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kern_path, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_path_put, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-- 
2.47.3


