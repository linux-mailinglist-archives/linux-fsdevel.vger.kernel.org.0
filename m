Return-Path: <linux-fsdevel+bounces-34744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE079C850D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39392854BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4B1F8907;
	Thu, 14 Nov 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+OaYKzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A21F76D5;
	Thu, 14 Nov 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573875; cv=none; b=QuVZNdJ2JgF8NWDcp4YKMEMztE0hC3mKBk5prKDSJWeuajVqA6cZ0qI5v7LHnGA32sZrDW1gOAWJv9koTgMbzapHDfgfb/sE+teNIA6KaxaCLzybTaUGwUURx+oFjR7NSmwbt39NcM+o5YaMabpKBmWTg1E4LHW4CdFSUefsAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573875; c=relaxed/simple;
	bh=1ovS1bjpZU/Le8HjGKou5cNnZ+kNg/ks1kxh0OmdiCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIXMnRk+EFjqGmRynZ4KrlFP8Mk8ar0eGdSuI8MxBzbuuNyJxh4DJ/Te0SAuJcriSt6n5gSHtqHnJ66RSbXyWvGk4U75W9cz1K9q651SxxoMoT8empJUU3IsghsBuVraTF/ytpahuc0PqTZp9Re+1hjl363aTFSwJZi+b8aB7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+OaYKzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B5BC4CECD;
	Thu, 14 Nov 2024 08:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573874;
	bh=1ovS1bjpZU/Le8HjGKou5cNnZ+kNg/ks1kxh0OmdiCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+OaYKzYiTQ6uglk//x3iQAkbheec6Y3WdJ2Ifzb/jmzMupLSUvWvQSjkqJo1Ov4Y
	 X7+6Dlp0QL9sOGXzw0sQSVWTvqBUtuUsspYE8Da0IrzIifhefeEgGDMJlLDeidj348
	 kIq91Cx8nJFofyR+HNWs8uJxdy6gQVB8aM5cVVDJHjuabtjLDAm00EBpmta178/Ee7
	 ktuaBpvuwBg+LgpN01eHqDy4vwX9hhzEAKJvCqclIdc07AIesknLmqABYAzr6Tzd/R
	 1l3ZSxJ57qWVl9bdnUtRQ/IQCcYU9IQOxswJ0xKGR+ceEnOdnWKAmtwKdBS5jkHIoa
	 6Qxk6u4hhLH4A==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
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
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [RFC/PATCH v2 bpf-next fanotify 4/7] bpf: fs: Add three kfuncs
Date: Thu, 14 Nov 2024 00:43:42 -0800
Message-ID: <20241114084345.1564165-5-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114084345.1564165-1-song@kernel.org>
References: <20241114084345.1564165-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following kfuncs:

- bpf_iput
- bpf_dput
- bpf_is_subdir

These kfuncs can be used by bpf fanotify fastpath.

Both bpf_iput and bpf_dput are marked as KF_SLEEPABLE | KF_RELEASE.
They will be used to release reference on inode and dentry.

bpf_is_subdir is marked as KF_RCU. It will be used to take rcu protected
pointers, for example, kptr saved to a bpf map.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  1 +
 2 files changed, 42 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..03ad3a2faec8 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -152,6 +152,44 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+/**
+ * bpf_iput - Drop a reference on the inode
+ *
+ * @inode: inode to drop reference.
+ *
+ * Drop a refcount on inode.
+ */
+__bpf_kfunc void bpf_iput(struct inode *inode)
+{
+	iput(inode);
+}
+
+/**
+ * bpf_dput - Drop a reference on the dentry
+ *
+ * @dentry: dentry to drop reference.
+ *
+ * Drop a refcount on dentry.
+ */
+__bpf_kfunc void bpf_dput(struct dentry *dentry)
+{
+	dput(dentry);
+}
+
+/**
+ * bpf_is_subdir - is new dentry a subdirectory of old_dentry
+ * @new_dentry: new dentry
+ * @old_dentry: old dentry
+ *
+ * Returns true if new_dentry is a subdirectory of the parent (at any depth).
+ * Returns false otherwise.
+ * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
+ */
+__bpf_kfunc bool bpf_is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
+{
+	return is_subdir(new_dentry, old_dentry);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -161,6 +199,9 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iput, KF_SLEEPABLE | KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_dput, KF_SLEEPABLE | KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_is_subdir, KF_RCU)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a7ed527e47e..65abb2d74ee5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5432,6 +5432,7 @@ BTF_ID(struct, bpf_cpumask)
 #endif
 BTF_ID(struct, task_struct)
 BTF_ID(struct, bpf_crypto_ctx)
+BTF_ID(struct, dentry)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
-- 
2.43.5


