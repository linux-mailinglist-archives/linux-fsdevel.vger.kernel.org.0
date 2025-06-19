Return-Path: <linux-fsdevel+bounces-52272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A8DAE0F6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DF61893F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751F2BDC04;
	Thu, 19 Jun 2025 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/7siiah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DAA29CB40;
	Thu, 19 Jun 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370534; cv=none; b=rQpJ+YWIMNKipIyAwfL3TJMvXp3KHoSdRP454hlFtsPUvTDmBiD4azrKLA8mlt9VDelLc65Sn9epOA2RBwjoph4mJjbtRKyf5kuDACyR3jPmEqWtIIi/PmHQEkOM8stjca6wLXPOrjBLCFc9Y5cPi4Mp25TRwkWQ5HOu2YDuI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370534; c=relaxed/simple;
	bh=puTnRa7DG1Y2PCVVgbCIuZlS5MYTdTwFeWDN6MNVDzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TINgn3FSbiNZlQButuLgN/HHezOf7lfFgJo9OH25uslnye7q9HVxZvt1+GeWCnRSVtMg/ZN7rTsw1JWlOL6wNK5iAtQvsOkI5BbJGjFHTpVIPD5C/PUlmLSiVrbudsaYiCk0JM5x/EwT2GTj+rkAXPxsJLD9Qp5vZiduEgHA1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/7siiah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04170C4CEEE;
	Thu, 19 Jun 2025 22:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370533;
	bh=puTnRa7DG1Y2PCVVgbCIuZlS5MYTdTwFeWDN6MNVDzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/7siiahIm2+vZA2wm1AFxzo5pqkamDp6sKxQ9Vmz62HlRZ2iwBJEj9va2lWHpWFt
	 HzRkvbJTJOBKMKlNXsI4zgUC/z3UnXa9eyxdVC8p0kt5GcPqrEt+fRYTUOqZ/+T/p9
	 2V2GLD0wmBChNu81p44UA/T7Hl8ONPHFIVN1pKSMOjFk7l5u1iT0tpJY/P+MtYlgG3
	 oyrZkcd3I0dQhTIQcxl/WGfyET25Q0pQiFInDTtr6vSh1guqGyhFUYj1p2VR7Di6Ah
	 cz/F6tgeXiPl6tyvG7UpF92wxJOX+8Zx1Cy/j3tZ3umrjKwBAtITwfztifQGG4aevM
	 krBu93NfV+KXg==
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
Subject: [PATCH v2 bpf-next 5/5] bpf: Make bpf_cgroup_read_xattr available to cgroup and struct_ops progs
Date: Thu, 19 Jun 2025 15:01:14 -0700
Message-ID: <20250619220114.3956120-6-song@kernel.org>
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

cgroup BPF programs and struct_ops BPF programs (such as sched_ext), need
bpf_cgroup_read_xattr. Make bpf_cgroup_read_xattr available to these prog
types.

Rename bpf_fs_kfunc_* variables as bpf_lsm_fs_kfunc_*, as these are only
available to BPF LSM programs. Then, reuse bpf_fs_kfunc_* name for cgroup
and struct_ops prog typs.

Also add a selftest with program of "cgroup/sendmsg4" type.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c                            | 53 +++++++++++++++++--
 .../selftests/bpf/progs/cgroup_read_xattr.c   | 22 ++++++++
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 9f3f9bd0f6f7..8e02e09e092e 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -356,7 +356,7 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
+BTF_KFUNCS_START(bpf_lsm_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
@@ -366,11 +366,11 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
-BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
+BTF_KFUNCS_END(bpf_lsm_fs_kfunc_set_ids)
 
-static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int bpf_lsm_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
+	if (!btf_id_set8_contains(&bpf_lsm_fs_kfunc_set_ids, kfunc_id) ||
 	    prog->type == BPF_PROG_TYPE_LSM)
 		return 0;
 	return -EACCES;
@@ -407,6 +407,40 @@ bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
 	return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->attach_btf_id);
 }
 
+static const struct btf_kfunc_id_set bpf_lsm_fs_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_lsm_fs_kfunc_set_ids,
+	.filter = bpf_lsm_fs_kfuncs_filter,
+};
+
+/*
+ * This set contains kfuncs available to BPF programs of cgroup type and
+ * struct_ops type.
+ */
+BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
+BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
+
+static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id))
+		return 0;
+	switch (prog->type) {
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_DEVICE:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		return 0;
+	default:
+		break;
+	}
+	return -EACCES;
+}
+
 static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &bpf_fs_kfunc_set_ids,
@@ -415,7 +449,16 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_lsm_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEVICE, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYSCTL, &bpf_fs_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &bpf_fs_kfunc_set);
 }
 
 late_initcall(bpf_fs_kfuncs_init);
diff --git a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
index b50ccb3aebcf..0995fb2ac9ff 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
@@ -134,3 +134,25 @@ int BPF_PROG(use_bpf_cgroup_ancestor)
 	bpf_cgroup_release(cgrp);
 	return 0;
 }
+
+SEC("cgroup/sendmsg4")
+__success
+int BPF_PROG(cgroup_skb)
+{
+	u64 cgrp_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp, *ancestor;
+
+	cgrp = bpf_cgroup_from_id(cgrp_id);
+	if (!cgrp)
+		return 0;
+
+	ancestor = bpf_cgroup_ancestor(cgrp, 1);
+	if (!ancestor)
+		goto out;
+
+	read_xattr(cgrp);
+	bpf_cgroup_release(ancestor);
+out:
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
-- 
2.47.1


