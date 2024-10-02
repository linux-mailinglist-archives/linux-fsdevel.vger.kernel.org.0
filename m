Return-Path: <linux-fsdevel+bounces-30801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0398E57B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A81F21A03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A819CC2A;
	Wed,  2 Oct 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBmcNDia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF51991AC;
	Wed,  2 Oct 2024 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905628; cv=none; b=Gv7+wHNp4JxJ8IGPJoIG+9Tj4DedbNaT8J7SFtsQtxNEO8UTVxSOaQSVVWld00R6pXuryBx/abWuWuFEu3UekJb/MHlZ7/MHt9wr/Jvaw8qvTpqr579UTfIBcXMbYFjOHMlgFopnzb9TZcIPLOrMsaGLnAWHG8p+jqea324HogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905628; c=relaxed/simple;
	bh=5OO2e8riHYsiYPAxdTwaBWJnh4LSIC1/XlliHp2xt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUAT5MWBGCN9meLoLC+kHi7uyuT7lYGjnTryQFS4WnmnhoIMAU1urohvMmE0p6Cn7lCoCx+n9P2xEvnBmLGXZx8zp/IhTonMqYGRnRJgeRwPFH5OjPdXu/utYof4kYfqC9XVGgIt/F81dxyh9jtedXE08znlncGIBNxkP0lHv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBmcNDia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA84C4CEC2;
	Wed,  2 Oct 2024 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727905628;
	bh=5OO2e8riHYsiYPAxdTwaBWJnh4LSIC1/XlliHp2xt/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBmcNDiagiUTvhOWDOQdWzuq5a9avTMuwALdIyCSpMT0gT2Bbfvrc6rAAfzM2Scu0
	 3pmO3IqGUaZaOKiz2MVpjMzLKb3hPvxRzaDmi/tVcsyVU0q7YnZ8tLDX/SFKUUzm0t
	 x7m6NGVtp2asg3ZixE+eahnyITrJfvxvPeA65AwsoJ/doQpNTzcNr3ocNZDI9qz26o
	 uhdd1WYIctTU7v0zFKmH9TWYBIbgEpD/MjEy1mCOyaZcnCZENPVc/wDoZn9zGWxWKW
	 OP/cQrBgv3Ly3rAM3XgQcOnkeHg318P1jxPYYeeQtHa/EiUcA+CSZjLnBRrmQZjOba
	 5F5X4R0I40m5w==
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
Subject: [PATCH bpf-next 1/2] fs/xattr: bpf: Introduce security.bpf xattr name prefix
Date: Wed,  2 Oct 2024 14:46:36 -0700
Message-ID: <20241002214637.3625277-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002214637.3625277-1-song@kernel.org>
References: <20241002214637.3625277-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduct new xattr name prefix security.bpf, and enable reading these
xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr(). Note that
"security.bpf" could be the name of the xattr or the prefix of the
name. For example, both "security.bpf" and "security.bpf.xxx" are
valid xattr name; while "security.bpfxxx" is not valid.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++++++-
 include/uapi/linux/xattr.h |  4 ++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..339c4fef8f6e 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -93,6 +93,23 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
 	return len;
 }
 
+static bool bpf_xattr_name_allowed(const char *name__str)
+{
+	/* Allow xattr names with user. prefix */
+	if (!strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+		return true;
+
+	/* Allow security.bpf. prefix or just security.bpf */
+	if (!strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN) &&
+	    (name__str[XATTR_NAME_BPF_LSM_LEN] == '\0' ||
+	     name__str[XATTR_NAME_BPF_LSM_LEN] == '.')) {
+		return true;
+	}
+
+	/* Disallow anything else */
+	return false;
+}
+
 /**
  * bpf_get_dentry_xattr - get xattr of a dentry
  * @dentry: dentry to get xattr from
@@ -117,7 +134,7 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
 	if (WARN_ON(!inode))
 		return -EINVAL;
 
-	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+	if (!bpf_xattr_name_allowed(name__str))
 		return -EPERM;
 
 	value_len = __bpf_dynptr_size(value_ptr);
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..166ef2f1f1b3 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -76,6 +76,10 @@
 #define XATTR_CAPS_SUFFIX "capability"
 #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
 
+#define XATTR_BPF_LSM_SUFFIX "bpf"
+#define XATTR_NAME_BPF_LSM (XATTR_SECURITY_PREFIX XATTR_BPF_LSM_SUFFIX)
+#define XATTR_NAME_BPF_LSM_LEN (sizeof(XATTR_NAME_BPF_LSM) - 1)
+
 #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
 #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_ACCESS
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
-- 
2.43.5


