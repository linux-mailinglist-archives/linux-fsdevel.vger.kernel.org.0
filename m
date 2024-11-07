Return-Path: <linux-fsdevel+bounces-33969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDD9C1096
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A92B1C2254A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C6227BAA;
	Thu,  7 Nov 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYq6UO4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABD227B91;
	Thu,  7 Nov 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013218; cv=none; b=hC9J+U45eICBJ2qdjb59SXeVl7bfPw3bQGEmTTd0qgmp8tvfbZ7vBErgV4ZAKnFx2O+dYMVrQjtkNRWKiUFxcHb95fUSKIrJRMh1rusdgRltF9gaXC9+R6ObL1rRdIEZ5ZAj367/ypuCqHgVs5ctS12TTwS/HMjWapOIfY8icWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013218; c=relaxed/simple;
	bh=Xk5GmckVGwbKY64HejHicOU/dRi3TybyQoiny9Ds7dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdoUvyDkpUPkOG6ZBDoq85pUvaXZ/7I/693FfgWmZUtqmjvTe80hzJfsSKI6wr2iqNJWmd0ms+VZC4NhLXM5tu9mR5BA+JxMIzr55iA2u1THg3MTkpSZGGBjQE2RcQtZ1k1ki7Qkutk/cTI11KxnjZQuvytYxdOKNvUy+lYuVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYq6UO4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5885DC4CECE;
	Thu,  7 Nov 2024 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731013218;
	bh=Xk5GmckVGwbKY64HejHicOU/dRi3TybyQoiny9Ds7dI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JYq6UO4Kr/cTMEFxLhhFbFJaDY7tFVWylaFki9TIg8xvdy6Q1sKuAOfyX5iwyAyuv
	 OmfF94E41Bkc9ZgfdAipq60QEre4QjIGFMvcYzAXt1WuTusekgJxlfIv1qfEjGqfAY
	 Fr0ChgckyYRP5o0XetclevdRdG7Nm3o+AKiClAcqJxHZCKs1s1lKJ2WTq+B+1gHcQc
	 FkPxddv8FefI3i0PK/CpJ+EnD1qoppWqbhz08nkOv1ZwP5NTWob5cJcn3SJ5ZQ3Ogf
	 3vvLvwUeLE4soPsl+dvMQHLve5y1Y2KdOogQrhJYUiOtB/ToG1ao8NGoR/qtgH2u2O
	 pPCF0wOoEBANA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 07 Nov 2024 16:00:06 -0500
Subject: [PATCH v3 1/2] fs: add the ability for statmount() to report the
 fs_subtype
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-statmount-v3-1-da5b9744c121@kernel.org>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
In-Reply-To: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4590; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Xk5GmckVGwbKY64HejHicOU/dRi3TybyQoiny9Ds7dI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnLSpfYG+d1kMK04rIn89VYAQARS0GrwjMCH5MM
 x2TIxls4GyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZy0qXwAKCRAADmhBGVaC
 FbEgD/922p3HIAQxKFePCk3K3NL5wC+/2S7ZJn55RQ1aApbsot4hgIG01JpJtwBW1TweSB2jCAr
 pdm0Dx/JcsbQsVx0S14Iz8bIHyCm1fq/NqpSQYuZ1lkeFvxWR7xEQ8u6QxwRjzUmCvwC9ZNYi8C
 P7m8S6+1YyehQyoI/g+F8f+CgdQT1lhPZ9Z29B3IssWlo8rzvKwzMF6Cu4wxGcAFIKw0dmE+KB7
 HMpKr2KBBkp3tqYWUNFHpBF2fNhs7IajppbYwjpTqNMw8lqYsi2MrTZHm97S7uq8KLfOx4StqIB
 Rz5RUJCZquiihnbKtqsygw41sKRLFe9a0mpMgS5YEaIbqxFlTEunSf/5ECU+B5zLR6NLMmGMBF6
 Lnp2Hqwhi29FeQrcuOwc9KFvm7GhkNIX1wsAlGGXg6lz4YO3bDlDHhYyOGyrX6I+aA1FDmek/Mz
 BZOFIhvIOWw/Uc6N1giLRTFkVuAgI/jOGmnNgHEtGQeyi4CPAUhpwiq/a9M3hYyppMfvb7h6E2H
 ahWyO9ioRDEBQl7HMuXmmZIaA87xZTsEZUHFO2fvauprhlWm9ClB6z8IHcYr5OLI279rnekd4Jp
 NtzbrQZEtzsrnKZAp2HzjWpCfvuwRZ8dTgWQKrV5EDnxL1ubhulJCPNGFssAuKqNp6IZyGOtVWq
 tnpiSA4okLLBYbA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

/proc/self/mountinfo prints out the sb->s_subtype after the type. This
is particularly useful for disambiguating FUSE mounts (at least when the
userland driver bothers to set it).

Add STATMOUNT_FS_SUBTYPE and claim one of the __spare2 fields to point
to the offset into the str[] array.

Handle the case where there is no subtype by not setting
STATMOUNT_FS_SUBTYPE in the returned mask. Check whether the function
emitted anything and just return immediately if not.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ian Kent <raven@themaw.net>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c             | 34 ++++++++++++++++++++++++++++------
 include/uapi/linux/mount.h |  5 ++++-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..fc4f81891d544305caf863904c0a6e16562fab49 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5006,6 +5006,14 @@ static int statmount_fs_type(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
+{
+	struct super_block *sb = s->mnt->mnt_sb;
+
+	if (sb->s_subtype)
+		seq_puts(seq, sb->s_subtype);
+}
+
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
@@ -5042,33 +5050,44 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 
 static int statmount_string(struct kstatmount *s, u64 flag)
 {
-	int ret;
+	int ret = 0;
 	size_t kbufsize;
 	struct seq_file *seq = &s->seq;
 	struct statmount *sm = &s->sm;
+	u32 start = seq->count;
 
 	switch (flag) {
 	case STATMOUNT_FS_TYPE:
-		sm->fs_type = seq->count;
+		sm->fs_type = start;
 		ret = statmount_fs_type(s, seq);
 		break;
 	case STATMOUNT_MNT_ROOT:
-		sm->mnt_root = seq->count;
+		sm->mnt_root = start;
 		ret = statmount_mnt_root(s, seq);
 		break;
 	case STATMOUNT_MNT_POINT:
-		sm->mnt_point = seq->count;
+		sm->mnt_point = start;
 		ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
-		sm->mnt_opts = seq->count;
+		sm->mnt_opts = start;
 		ret = statmount_mnt_opts(s, seq);
 		break;
+	case STATMOUNT_FS_SUBTYPE:
+		sm->fs_subtype = start;
+		statmount_fs_subtype(s, seq);
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
 	}
 
+	/*
+	 * If nothing was emitted, return to avoid setting the flag
+	 * and terminating the buffer.
+	 */
+	if (seq->count == start)
+		return ret;
 	if (unlikely(check_add_overflow(sizeof(*sm), seq->count, &kbufsize)))
 		return -EOVERFLOW;
 	if (kbufsize >= s->bufsize)
@@ -5203,6 +5222,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_OPTS)
 		err = statmount_string(s, STATMOUNT_MNT_OPTS);
 
+	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
+		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5224,7 +5246,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 }
 
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
-			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS)
+			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 225bc366ffcbf0319929e2f55f1fbea88e4d7b81..2e939dddf9cbabe574dafdb6cff9ad4cf9298a74 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -173,7 +173,9 @@ struct statmount {
 	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
-	__u64 __spare2[49];
+	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
+	__u32 __spare1[1];
+	__u64 __spare2[48];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -207,6 +209,7 @@ struct mnt_id_req {
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
+#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
 
 /*
  * Special @mnt_id values that can be passed to listmount

-- 
2.47.0


