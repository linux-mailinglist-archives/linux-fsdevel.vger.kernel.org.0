Return-Path: <linux-fsdevel+bounces-52484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176BFAE35DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF483AFF25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29D1F09B3;
	Mon, 23 Jun 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLuuMss4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE9136348;
	Mon, 23 Jun 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660753; cv=none; b=m2MDFWlNuFVBDhd7Anlo0v6FkbUjKs+uEiSOXl/vxO/euLHNJzqIGZEefQfTJQW6XYj0YpkBd1T6YQxnwvS4FKEMjQu9U4Z4IaHw/dKsLpdkeQHcuShUTp8L78Mc4uvj3Kv34ndhfXSyHWMrSSqX2Y0hdkaOFUcbSnDKKWTj4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660753; c=relaxed/simple;
	bh=0Jo3+klb7sn+Ci+xFRJd1JpVX2+HyuPav+mXSbeFpyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuDadEBo064G75Lza65Yb7a/IGRSnyZZ9x86FG7K9jgV+Iv5jo+BcwGvkJo5+kf2Uq4j7o+/4DiHp0HMVqIRDG5b9xarjSXJn2mnxhJtoO0Nyaf436PwU0TLj55CQYIo8SVymTi93RalPungYBOlUeawxpP5mFR7F+TJ4r3Fzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLuuMss4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B5C4CEED;
	Mon, 23 Jun 2025 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750660753;
	bh=0Jo3+klb7sn+Ci+xFRJd1JpVX2+HyuPav+mXSbeFpyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLuuMss4M9D4QRBc7/VWf6NGL+3i7HiOgDoJxTM02s54Z1DxwcPzujdwTg15qjA2E
	 EJHg/UuRL3X2JBYUNyhVSTqDUxzrdTuUwE09KZFixpnBy0Bxn7iY59iLo0kbpbZjGp
	 ljSngmZWE+Om3hkNE7/zMnvuJN5dPiR8hM4UeL4cX0cBSX6v2jiL/R3SuFYkHflpfN
	 +1TJXx7LEYUj2RNIDov++fvdIfRcKDGDuowbmh1uTqoS9EDDdqpjZSG1CP4sfDjCwu
	 WGwPQSv2/0GfNbuqyr5W0IN668U/V89TgZxzXWCfzOocEKqapFcotfFa2NKZNpQYRe
	 t+qpQYvK2oHug==
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
Subject: [PATCH v3 bpf-next 2/4] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
Date: Sun, 22 Jun 2025 23:38:52 -0700
Message-ID: <20250623063854.1896364-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250623063854.1896364-1-song@kernel.org>
References: <20250623063854.1896364-1-song@kernel.org>
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

bpf_cgroup_read_xattr is generic and can be useful for many program
types. It is also safe, because it requires trusted or rcu protected
argument (KF_RCU). Therefore, we make it available to all program types.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/bpf_fs_kfuncs.c   | 34 ++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08412532db1b..1e36a12b88f7 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/fsnotify.h>
 #include <linux/file.h>
+#include <linux/kernfs.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
 
@@ -322,6 +323,39 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
 	return ret;
 }
 
+#ifdef CONFIG_CGROUPS
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
+#endif /* CONFIG_CGROUPS */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..9ff1b4090289 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
+#ifdef CONFIG_CGROUPS
+BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.47.1


