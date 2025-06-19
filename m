Return-Path: <linux-fsdevel+bounces-52269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC1AE0F64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7667AF1F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F928E576;
	Thu, 19 Jun 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CstctGE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2428DF3B;
	Thu, 19 Jun 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370516; cv=none; b=uNXPIYoYpAmCfOKmaoqusWXUdSbVLxbU2nP3Haf5K7IohPdLD+Q8GbhD4tY0dP6YxSx8YEeMpchYP/K7VCh/bq1VWyAJoJlerMYq3rjKUjqWLhZsc6RE4/+mHsY47aA+a9EIlC7SeHNkeoMFiPaNuS79Ch7TJ5eMMe+deyFpltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370516; c=relaxed/simple;
	bh=NIfNoG423OkEnE3hS7qFIh07B2hsI2a8wQjaQzBrAe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw3z3IXLmVsMXj6YzkeDq/7ztSjhLLSH17sdFn46WzahWWvEqqbEkxFqPkz45vRZ7r9dHD9G9b9XOXUOOsHbz41P3JXDcgXfNZ0K5ufLosjCJtiwYWhswSUcQCKHYz4htedvUIc01qsXojbHzIpoLNeEzyR7v48MLzSDKHmyK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CstctGE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EFEC4CEEA;
	Thu, 19 Jun 2025 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370515;
	bh=NIfNoG423OkEnE3hS7qFIh07B2hsI2a8wQjaQzBrAe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CstctGE2mkzfjgLwDCnBCJVvUIHNruZUecKwRc8qHuO1aYQVIUQbXIsXeqXhusEqm
	 ezi4bJanpHyBDjtO0FH43groYjQSG+LUlFQIfAuN9ZiLBgJAAs1hZYuZha7FJ53gha
	 NT7KeXIThfw0Bv/qhjbOlu0fjsJbj7LIYzJd4rsIEUsW+ExVX82qsQyoUTx1S3K14w
	 U+mZhJ2R4BFf2nFRAKxenBYN8MRqcwv9OTdM7tFJz31qpKWV6DkVjSmUYJf60nUZbP
	 jlReBBXtg+DOq80X+XwKLmEhgeLWt0iM1AU/Nca57qQK5KXTELsYxdmVPeyfyhV34f
	 WL35akhLqVcPQ==
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
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	daan.j.demeyer@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 2/5] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
Date: Thu, 19 Jun 2025 15:01:11 -0700
Message-ID: <20250619220114.3956120-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250619220114.3956120-1-song@kernel.org>
References: <20250619220114.3956120-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs, such as LSM and sched_ext, would benefit from tags on
cgroups. One common practice to apply such tags is to set xattrs on
cgroupfs folders.

Introduce kfunc bpf_cgroup_read_xattr, which allows reading cgroup's
xattr.

Note that, we already have bpf_get_[file|dentry]_xattr. However, these
two APIs are not ideal for reading cgroupfs xattrs, because:

  1) These two APIs only works in sleepable contexts;
  2) There is no kfunc that matches current cgroup to cgroupfs dentry.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08412532db1b..9f3f9bd0f6f7 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/fsnotify.h>
 #include <linux/file.h>
+#include <linux/kernfs.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
 
@@ -322,6 +323,37 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
 	return ret;
 }
 
+/**
+ * bpf_cgroup_read_xattr - read xattr of a cgroup's node in cgroupfs
+ * @cgroup: cgroup to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *cgroup* and store the output in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: length of the xattr value on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
+					struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	u32 value_len;
+	void *value;
+
+	/* Only allow reading "user.*" xattrs */
+	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+		return -EPERM;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data_rw(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	return kernfs_xattr_get(cgroup->kn, name__str, value, value_len);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -333,6 +365,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.47.1


