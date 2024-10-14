Return-Path: <linux-fsdevel+bounces-31868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595899C600
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E161C22CD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE3C158DD4;
	Mon, 14 Oct 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+Ah6Dei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D0156C5F;
	Mon, 14 Oct 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898869; cv=none; b=V57w4ntQWQgBP+rEEkCuM6diTybrIhQVCZL+uyn0p8gdZsgP8KIuD/BknX7ODaMr3WWRg4vtFH62bFMQYgWz+msp3IR1zyf3trGzBOS112PIXfX4l7JFpOJ3MoWMf/rn6HK4yp9hZisbGYWSzYQaCxIRO3wlpqYM9lMFp1EQMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898869; c=relaxed/simple;
	bh=wTAC5m5GXry4oLIxvLmVbB7YbXNsZi4/fpreoeeWhnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrltoNRmHdHzHfIgeJlhS59dIADFaXFSssqtb3hCig/I1ZPwzi0+yQKr1y4JucVMZbzSp/fUeQBX2mgG2mNWhez8QdU2sSpIPz8qRx/+q1ufSmxgqAVJ4SsssAVW40o0KFrx/9jDvOm8gUVl9tyRIE+IIhcxN/wxfJTvtcCI6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+Ah6Dei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D309EC4CED0;
	Mon, 14 Oct 2024 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898869;
	bh=wTAC5m5GXry4oLIxvLmVbB7YbXNsZi4/fpreoeeWhnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F+Ah6Dei6saguIP9hjagPM12w2Gz5pt+t3UdNy1qYKZbC+ZdbasdnFZ5iRTdc3mNB
	 OBfvlQxOq6b5gVcD4ebctAGAvJn6y+x2s4daeO9mKtGLq3hkPkO9PiyGrmoEF52vxm
	 2b7e5QWeosa7MJsjYxhd39Y4ja9c7SqzpBcyamaONtoKSHZECGF1fnKzMmAUOCn/Ur
	 YyKEK4XGxCD67MR1J49rQ6KBcW0X+XRx7Q20vxRH+3Ni1xRg9CR07mwtS+u5sB2zlO
	 MR+EtqExa/kiGMVj/9HMU7cJgrEoKky0Gxc1Vf5eRZ2Ck53tYOPMtY5D+Jew/GGkMX
	 4+rjbCtV4iPSA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Oct 2024 11:40:56 +0200
Subject: [PATCH v3 1/5] fs: add helper to use mount option as path or fd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-work-overlayfs-v3-1-32b3fed1286e@kernel.org>
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
In-Reply-To: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=2607; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wTAC5m5GXry4oLIxvLmVbB7YbXNsZi4/fpreoeeWhnM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzPDc8ntm63vhk2K6O966bVSJe5L0PE+5cw7DtsFruw
 pxpu94bdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEzp6R4YlT+Y7d9qdFvacd
 12xewV6qt/cCp6OMfgn/I1P+yZZS1xj+8GSy/WJwlpzk2Xzql4zCXgubm9+m3/N4dlXyh+KBi0f
 E2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow filesystems to use a mount option either as a
file or path.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_parser.c            | 20 ++++++++++++++++++++
 include/linux/fs_parser.h |  5 ++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 24727ec34e5aa434364e87879cccf9fe1ec19d37..8f583b814e6e4377cf0611c11abbf24168a58d74 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -308,6 +308,26 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_fd);
 
+int fs_param_is_file_or_string(struct p_log *log,
+			       const struct fs_parameter_spec *p,
+			       struct fs_parameter *param,
+			       struct fs_parse_result *result)
+{
+	switch (param->type) {
+	case fs_value_is_string:
+		return fs_param_is_string(log, p, param, result);
+	case fs_value_is_file:
+		result->uint_32 = param->dirfd;
+		if (result->uint_32 <= INT_MAX)
+			return 0;
+		break;
+	default:
+		break;
+	}
+	return fs_param_bad_value(log, param);
+}
+EXPORT_SYMBOL(fs_param_is_file_or_string);
+
 int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 6cf713a7e6c6fc2402a68c87036264eaed921432..3cef566088fcf7e04c569acd849a785462c33f17 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -28,7 +28,8 @@ typedef int fs_param_type(struct p_log *,
  */
 fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
 	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
-	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
+	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid,
+	fs_param_is_file_or_string;
 
 /*
  * Specification of the type of value a parameter wants.
@@ -133,6 +134,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
+#define fsparam_file_or_string(NAME, OPT) \
+				__fsparam(fs_param_is_file_or_string, NAME, OPT, 0, NULL)
 #define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, NULL)
 #define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, NULL)
 

-- 
2.45.2


