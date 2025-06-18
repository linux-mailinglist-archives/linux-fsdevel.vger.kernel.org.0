Return-Path: <linux-fsdevel+bounces-52138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F2ADF9D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FC57A81E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 23:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75F2EE96F;
	Wed, 18 Jun 2025 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klAHhgdx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB328466C;
	Wed, 18 Jun 2025 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289880; cv=none; b=fiepiC3Gu/sN893f4U9CbuMElRFVTq829fA0fReP+Y5gqjPEv4IHq8+vR0GhYR0z/6FFYmoL1erSPEn/B7JOESGV3nxiPfH5lU1anGYJh9QwM2qOv20yxBHE7n6HvpnlbPV6heQDRj8WrRMZztZ9Tt04YZM53hRty0KrYw+FV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289880; c=relaxed/simple;
	bh=ZsxNKP/5L7kax4tFNOKGSX/EsEcy4YWBATqLLzfkmoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5dNqNWBrpPsEmX/lBBORqOnyek7qPjUEGDYyzf9u+vCcdvlOuAiCnDgY5pykxXQGMBVGOMHBCeMEB5RL192QUaO76j1HSe5bm8EgBSrwDWuKQ2BZ7IodaY84qyWDFCd/b45fvJGnx4I7h1s8VTi5W1sUipKbGeAI5KnV7lu8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klAHhgdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476FCC4CEE7;
	Wed, 18 Jun 2025 23:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750289880;
	bh=ZsxNKP/5L7kax4tFNOKGSX/EsEcy4YWBATqLLzfkmoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klAHhgdx1mhHargsK8Gda2XXGuzU+NPLzSU++tI9EjnQTWy8sSe6Ay2LitA9ZpvSF
	 +tRugWS7paLH/pa+XrZupYNJleWR87/1yIN/4b4S9oZPsDX5td9W4OztkRIDjVkb4n
	 +XIxjlE5bmm54OpKGeOyAk45sMo9DXsF49uQXN/JH5tftF0iZXX0AFHhR9JYqf9H/e
	 wH/J36sRFJVUi3BCnTV90cCIbWWAAj0lSmtr86AmlYbv3A0YFlKDjq6ptaUIv6aqs/
	 d7qmrP4SL4UP5dhZPtPfQhn1yqeZg7Bn2YOfMJFYTVA15eLmDLtDklthIh0BZySeEz
	 tweiWRcH8oXkA==
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
Subject: [PATCH bpf-next 2/4] bpf: Introduce bpf_kernfs_read_xattr to read xattr of kernfs nodes
Date: Wed, 18 Jun 2025 16:37:37 -0700
Message-ID: <20250618233739.189106-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618233739.189106-1-song@kernel.org>
References: <20250618233739.189106-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs, such as LSM and sched_ext, would benefit from tags on
cgroups. One common practice to apply such tags is to set xattrs on
cgroupfs files and folders.

Introduce kfunc bpf_kernfs_read_xattr, which allows reading kernfs
xattr under RCU read lock.

Note that, we already have bpf_get_[file|dentry]_xattr. However, these
two APIs are not ideal for reading cgroupfs xattrs, because:

  1) These two APIs only works in sleepable contexts;
  2) There is no kfunc that matches current cgroup to cgroupfs dentry.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08412532db1b..7576dbc9b340 100644
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
+ * bpf_kernfs_read_xattr - get xattr of a kernfs node
+ * @kn: kernfs_node to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *kn* and store the output in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: length of the xattr value on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_kernfs_read_xattr(struct kernfs_node *kn, const char *name__str,
+				      struct bpf_dynptr *value_p)
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
+	return __kernfs_xattr_get(kn, name__str, value, value_len);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -333,6 +365,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kernfs_read_xattr, KF_RCU | KF_RCU_PROTECTED)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.47.1


