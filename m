Return-Path: <linux-fsdevel+bounces-31783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE299AE3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D0D1F2543C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057E1D1753;
	Fri, 11 Oct 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR6eXZ7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF651D1721;
	Fri, 11 Oct 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683175; cv=none; b=sHIlq+dFjLKjLi8x+DnjeDemgHuwgCep8z9Ko20IVYGmHSx1l1rQ+DyjiF2YINBDk1TuqztOCH4FP3Yy43mKyxgkWBvM3GE7jv7fxLs10/+UWYOD7NC2qAjXvqCX9PBaVVfjwyH9PX5XEi58uKo+emEDa9Rp4M9Ks53adBkBBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683175; c=relaxed/simple;
	bh=u1eDTasujqFqnJhY0XPvafSE03WRfY8oAIQszSM6PEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7GK/Uk+GK9HPAAQiskIhOXkfIHXrZxGIlnlqGcWNeoS54pau6PhAzc72vpuug8JMcFiQsICc/P0XupI6+uHMCqKfnos+g5JU23zA+J80WS+kShbDcVQiEYbvA3zGCOFiY/EnOjP+fCEWLsFHJ8XxGc0CEsyRlDSfUH5/wBhXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR6eXZ7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1FCC4CECE;
	Fri, 11 Oct 2024 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683174;
	bh=u1eDTasujqFqnJhY0XPvafSE03WRfY8oAIQszSM6PEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HR6eXZ7E92TqvXFI4evcEgKrQfH5P6QVECTOJBjcdST/MzfCVXw44hv2oiKiLIRUM
	 ID+M+jKZJxyDLeyWzpOBYj8o7Ex605XCoU/AduB2qq/RGiNMLIwzlSApAk1YHzQtwo
	 Hwf9ABPrAgflIpzr1vJ1W+7FGaWDRQm4QmgCbuJJ7fEFXsc83tud/xeuFJATUDyCU1
	 yzb1G83tv1KiPIhRXQf3Se0dUt6BFG2wIUWTDxqX/yLzuZWBd+8VgKySHVRR2/gxxl
	 ivb/U4O/gA3RmrQTYbhFsVAzWkJIJitEdJj9XKEY0XyvimRqbdB4Vk2YH1PTYxrzKm
	 z5sglrH0CU4mA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Oct 2024 23:45:50 +0200
Subject: [PATCH RFC v2 1/4] fs: add helper to use mount option as path or
 fd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-work-overlayfs-v2-1-1b43328c5a31@kernel.org>
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u1eDTasujqFqnJhY0XPvafSE03WRfY8oAIQszSM6PEc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzzll8YK7hJNWv80oPK/fsPDJn9vXnvWnZYtXLmjtuX
 /x+n6utqaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiv+4xMpx2t3ztLP//0D2D
 mg2TP5s6uLR43LrgkfVRrNwpzrG5LIbhn/WqeomyGBlb9RuXtUWfz2L8U+lp/THUf3ZY0/Om5c7
 P+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow filesystems to use a mount option either as a
path or a file descriptor.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_parser.c            | 19 +++++++++++++++++++
 include/linux/fs_parser.h |  5 ++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 24727ec34e5aa434364e87879cccf9fe1ec19d37..a017415d8d6bc91608ece5d42fa4bea26e47456b 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -308,6 +308,25 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_fd);
 
+int fs_param_is_fd_or_path(struct p_log *log, const struct fs_parameter_spec *p,
+			   struct fs_parameter *param,
+			   struct fs_parse_result *result)
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
+EXPORT_SYMBOL(fs_param_is_fd_or_path);
+
 int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 6cf713a7e6c6fc2402a68c87036264eaed921432..73fe4e119ee24b3bed1f0cf2bc23d6b31811cb69 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -28,7 +28,8 @@ typedef int fs_param_type(struct p_log *,
  */
 fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
 	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
-	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
+	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid,
+	fs_param_is_fd_or_path;
 
 /*
  * Specification of the type of value a parameter wants.
@@ -133,6 +134,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
+#define fsparam_fd_or_path(NAME, OPT) \
+				__fsparam(fs_param_is_fd_or_path, NAME, OPT, 0, NULL)
 #define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, NULL)
 #define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, NULL)
 

-- 
2.45.2


