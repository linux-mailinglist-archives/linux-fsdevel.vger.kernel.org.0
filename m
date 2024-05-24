Return-Path: <linux-fsdevel+bounces-20101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F6B8CE116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 08:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7411F221E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9580129A7B;
	Fri, 24 May 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NVgMMK21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD11292F9;
	Fri, 24 May 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532845; cv=none; b=GhtCPc1TaxndXJrPA0KHYArFmvS3GZJmcYMVJwBVAcBf0r5UzSfl171wsWqhevixD536r0GWGydo9dFLKvKm3M/ngxmyiMIECquLk53lGhlkhD7enIvGLDWzE0ZBbuhmpq6roEaB4/I93F4vfHglEwYDbmjIli0P1KMXe2aMZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532845; c=relaxed/simple;
	bh=J6/WO3s5F8GQUUVL4fPdIsMWGDnpzpRnMebb8UdB1Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdvLBmJSBHAWuSml6uSmJHOOEYEfNjDsZHWOzYBoPR8PDKdkYz7dLEiLxkhC1nWtTtBZ8X+3+s+UdKeoMvdAfXwgEpyP1qHTBhMzNM3FjVxNH8CwRKsJt1JhRaR847qas+Zv30QlNaVLnRQ6pIu1gS9BVw9FiWxQ4jv451gQRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NVgMMK21; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716532835; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cXWzUpJjQ4PNak4y+VXJdShi18hH5igzhBYCqKdRrXU=;
	b=NVgMMK21ymXTWq4k4be4BksohmCfH5oD3dKPQT72SDb4hrdTHxxizYJ7kTy0w4vXK7t5R1DK7XuvYLdxWTkMkoeUX/LXwB4+fVdnIOwAyCC0I46RC11ciQik3B4PDJjo2F5rqB6e+uonnBy+vq2qrvBxieiP0674X/DByhdm0RE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W75A0P8_1716532833;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W75A0P8_1716532833)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 14:40:34 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	winters.zc@antgroup.com
Subject: [RFC 2/2] fuse: uid-based security enhancement for the recovery mechanism
Date: Fri, 24 May 2024 14:40:30 +0800
Message-Id: <20240524064030.4944-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Offer a uid-based security enhancement for the fuse server recovery
mechanism.  Otherwise any malicious attacker could kill the fuse server
and take the filesystem service over with the recovery mechanism.

Introduce a new "rescue_uid=" mount option specifying the expected uid
of the legal process running the fuse server.  Then only the process
with the matching uid is permissible to retrieve the fuse connection
with the server recovery mechanism.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dev.c    | 12 ++++++++++++
 fs/fuse/fuse_i.h |  8 ++++++++
 fs/fuse/inode.c  | 13 ++++++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7599138baac0..9db35a2bbd85 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2376,12 +2376,24 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
+static inline bool fuse_device_attach_permissible(struct fuse_conn *fc)
+{
+	const struct cred *cred = current_cred();
+
+	return (uid_eq(cred->euid, fc->rescue_uid) &&
+		uid_eq(cred->suid, fc->rescue_uid) &&
+		uid_eq(cred->uid,  fc->rescue_uid));
+}
+
 static inline bool fuse_device_attach_match(struct fuse_conn *fc,
 					    const char *tag)
 {
 	if (!fc->recovery)
 		return false;
 
+	if (!fuse_device_attach_permissible(fc))
+		return false;
+
 	return !strncmp(fc->tag, tag, FUSE_TAG_NAME_MAX);
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e9832186f84f..c43026d7229c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -560,6 +560,7 @@ struct fuse_fs_context {
 	unsigned int rootmode;
 	kuid_t user_id;
 	kgid_t group_id;
+	kuid_t rescue_uid;
 	bool is_bdev:1;
 	bool fd_present:1;
 	bool rootmode_present:1;
@@ -571,6 +572,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool rescue_uid_present:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
@@ -616,6 +618,9 @@ struct fuse_conn {
 	/** The group id for this mount */
 	kgid_t group_id;
 
+	/* The expected user id of the fuse server */
+	kuid_t rescue_uid;
+
 	/** The pid namespace for this mount */
 	struct pid_namespace *pid_ns;
 
@@ -864,6 +869,9 @@ struct fuse_conn {
 	/** Support for fuse server recovery */
 	unsigned int recovery:1;
 
+	/** Is rescue_uid specified? */
+	unsigned int rescue_uid_present:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1ab245d6ade3..3b00482293b6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -734,6 +734,7 @@ enum {
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
 	OPT_TAG,
+	OPT_RESCUE_UID,
 	OPT_ERR
 };
 
@@ -749,6 +750,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
 	fsparam_string	("tag",			OPT_TAG),
+	fsparam_u32	("rescue_uid",		OPT_RESCUE_UID),
 	{}
 };
 
@@ -841,6 +843,13 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		param->string = NULL;
 		return 0;
 
+	case OPT_RESCUE_UID:
+		ctx->rescue_uid = make_kuid(fsc->user_ns, result.uint_32);
+		if (!uid_valid(ctx->rescue_uid))
+			return invalfc(fsc, "Invalid rescue_uid");
+		ctx->rescue_uid_present = true;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1344,7 +1353,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
-			if (flags & FUSE_HAS_RECOVERY)
+			if (flags & FUSE_HAS_RECOVERY && fc->rescue_uid_present)
 				fc->recovery = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
@@ -1753,6 +1762,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->rescue_uid = ctx->rescue_uid;
+	fc->rescue_uid_present = ctx->rescue_uid_present;
 	fc->tag = ctx->tag;
 	ctx->tag = NULL;
 
-- 
2.19.1.6.gb485710b


