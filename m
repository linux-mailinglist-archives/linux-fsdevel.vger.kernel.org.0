Return-Path: <linux-fsdevel+bounces-24282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C3C93CB55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 01:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D18B21CFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 23:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE0149E15;
	Thu, 25 Jul 2024 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxckO7u+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787E1448EF;
	Thu, 25 Jul 2024 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951246; cv=none; b=FsO7pUNJQF4vwX3hHkEvxe9KgsOgjNqk3qERMUbM3gFmLord3K6QC4myvZM1yitW19aXOFRCHymrOZSDYjkoI1bMYEHSU1mXmV13U/q4jQ202KUUQehNh6a0JaXMyte+ZaCII1Klc+yr60PusP5tvO7SIv5bV4vPPc4Ua7ZByWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951246; c=relaxed/simple;
	bh=0UKtj6o3RWTCtZZLR5vBaT2vQGLsXGl2qOxqirhhQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfCTuZPiy4rQx3ln+tbCNufpcgSMz3Uqz7P3EsHQBaPBtI0jy5zlZSdIQ5cO/8cw6cZB5/39IF9kZQ2kvSn5ozs0bHZ3aHYsgHeRgle26BVwVtm/Fmb0mk/zeOoRQN1HehTgCSFIS7nwLckkm2IAeCeMGRjJO3fiUd9/I5kgKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxckO7u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812A0C116B1;
	Thu, 25 Jul 2024 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721951245;
	bh=0UKtj6o3RWTCtZZLR5vBaT2vQGLsXGl2qOxqirhhQiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxckO7u+VhnbKiZ5TRGo7/l/3q0LnWJxFnUx+UcuOuNLVQgRWwgq8HRnCye+Fvc71
	 1rEY0xENW7E7XBj92Qix13qJD+1Gfxnzi7s/xkjaGeLoAHcsUmcIOsnzRFqKLToXfH
	 9cYT0/c0b91blB3wRRIrEiQWbg1ps4XHaMyz+nLaucH47P2Fu9F81WN9ufaWAWK6iV
	 IooSLNHcieZ+/e4JV061cC89RcgZmOm7YlMcroYJrDCcU7jqVL8Bxn0WyUSN/WOkOm
	 nsD6jqCXMBlbVlhiGUep4fmNA8fUVaBuN9OkJxAevTbkEmekytJ+H9A9ijkeDfywTG
	 rR0Gzg+xhOaxw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
Date: Thu, 25 Jul 2024 16:47:05 -0700
Message-ID: <20240725234706.655613-2-song@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725234706.655613-1-song@kernel.org>
References: <20240725234706.655613-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary use case here is to read xattr for directories from BPF
programs. This feature enables tagging all the files in a directory
with a xattr on the directory. More specifically, starting from LSM hook
security_file_open(), we can read xattr of the file's parent directories.

To have referenced access to dentry, a few more kfuncs are added:
  - bpf_file_dentry
  - bpf_dget_parent
  - bpf_dput

Both bpf_file_dentry and bpf_dget_parent take a reference to the dentry
(KF_ACQUIRE), which has to be released by bpf_dput (KF_RELEASE). This
makes sure only trusted pointers (KF_TRUSTED_ARGS) can be used for the
dentry.

Note that, file_dentry() doesn't take reference to the dentry, but
bpf_file_dentry() does.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/trace/bpf_trace.c | 60 ++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..b8e6eeabb773 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1443,22 +1443,21 @@ late_initcall(bpf_key_sig_kfuncs_init);
 __bpf_kfunc_start_defs();
 
 /**
- * bpf_get_file_xattr - get xattr of a file
- * @file: file to get xattr from
+ * bpf_get_dentry_xattr - get xattr of a dentry
+ * @dentry: dentry to get xattr from
  * @name__str: name of the xattr
  * @value_p: output buffer of the xattr value
  *
- * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
  *
  * For security reasons, only *name__str* with prefix "user." is allowed.
  *
  * Return: 0 on success, a negative value on error.
  */
-__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
-				   struct bpf_dynptr *value_p)
+__bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
+				     struct bpf_dynptr *value_p)
 {
 	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
-	struct dentry *dentry;
 	u32 value_len;
 	void *value;
 	int ret;
@@ -1471,20 +1470,63 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	if (!value)
 		return -EINVAL;
 
-	dentry = file_dentry(file);
 	ret = inode_permission(&nop_mnt_idmap, dentry->d_inode, MAY_READ);
 	if (ret)
 		return ret;
 	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
 }
 
+/**
+ * bpf_get_file_xattr - get xattr of a file
+ * @file: file to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
+				   struct bpf_dynptr *value_p)
+{
+	struct dentry *dentry;
+
+	dentry = file_dentry(file);
+	return bpf_get_dentry_xattr(dentry, name__str, value_p);
+}
+
+__bpf_kfunc struct dentry *bpf_file_dentry(const struct file *file)
+{
+	/* file_dentry() does not hold reference to the dentry. We add a
+	 * dget() here so that we can add KF_ACQUIRE flag to
+	 * bpf_file_dentry().
+	 */
+	return dget(file_dentry(file));
+}
+
+__bpf_kfunc struct dentry *bpf_dget_parent(struct dentry *dentry)
+{
+	return dget_parent(dentry);
+}
+
+__bpf_kfunc void bpf_dput(struct dentry *dentry)
+{
+	return dput(dentry);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_file_dentry, KF_TRUSTED_ARGS | KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_dget_parent, KF_TRUSTED_ARGS | KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_dput, KF_RELEASE)
 BTF_KFUNCS_END(fs_kfunc_set_ids)
 
-static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int fs_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
 		return 0;
@@ -1496,7 +1538,7 @@ static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
 static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &fs_kfunc_set_ids,
-	.filter = bpf_get_file_xattr_filter,
+	.filter = fs_kfunc_filter,
 };
 
 static int __init bpf_fs_kfuncs_init(void)
-- 
2.43.0


