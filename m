Return-Path: <linux-fsdevel+bounces-31916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473DC99D6F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 21:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556DC2841E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8631C9B87;
	Mon, 14 Oct 2024 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kzevtmp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553626296
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932582; cv=none; b=UrDns9liL+3rjK4EIHjHoA0X+wan7P6yv1N25yk3FjAeEoL1z+7QpQ/vhmZ8+mqGVhxkQgi84+76YUUPm0LDiZ5bYAi4OX5+HuH/lSTSj//ULRkLdN2Vynx2KOEvCFOJm9PrPe13n/ys1oE4r3LgoHjP5ZpaGQq/iJNSudJwkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932582; c=relaxed/simple;
	bh=vuM6giDHQnqPchWEaVJdjYCTAWTFy9iX2aRerVbFtBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qj8FLlZTUC8kVTnXCeaaIEqQ2jmsmPsIr/+yb9sE7CAXZOV7hdxkOq9vQi2r4kzlvxBLRXA5DJXWCJgFYY0Mxzodc1ItiusJXMn5Q12G813kAfIpIjEXWOUEgZPTWgGhAZeQVJo35tTgBy0wL2RuNO5rYe3PGALJQ8vJD92xqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kzevtmp0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728932580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SqsWiL8acSHPEBRQ0NsndKrZE4UQGuUTL2BTNpytimw=;
	b=Kzevtmp069EtInLBZnNgYldL2n66LsgmPx6Y50o+oV6XY/Mm0jVzqCosxpQuMTkSrSXi3y
	35nvEthbB3GZn/vTl9smXHd3eX6mhizMWRSp/jJOhXP2g81zSooXysrvW4+r5CT4Ne8pAy
	M7/kV2w0yCdjj6mC7fw21IcZs0YtXDc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-BoMzE21jPYepweGCDykQng-1; Mon,
 14 Oct 2024 15:02:56 -0400
X-MC-Unique: BoMzE21jPYepweGCDykQng-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A1819560A6;
	Mon, 14 Oct 2024 19:02:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.34.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D018B1955F42;
	Mon, 14 Oct 2024 19:02:54 +0000 (UTC)
From: Bill O'Donnell <bodonnel@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	sandeen@redhat.com,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: [PATCH] efs: fix the efs new mount api implementation
Date: Mon, 14 Oct 2024 14:02:41 -0500
Message-ID: <20241014190241.4093825-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit 39a6c668e4 (efs: convert efs to use the new mount api)
did not include anything from v2 and v3 that were also submitted.
Fix this by bringing in those changes that were proposed in v2 and
v3.

Fixes: 39a6c668e4 efs: convert efs to use the new mount api.

Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
---
 fs/efs/super.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/fs/efs/super.c b/fs/efs/super.c
index e4421c10caeb..c59086b7eabf 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -15,7 +15,6 @@
 #include <linux/vfs.h>
 #include <linux/blkdev.h>
 #include <linux/fs_context.h>
-#include <linux/fs_parser.h>
 #include "efs.h"
 #include <linux/efs_vh.h>
 #include <linux/efs_fs_sb.h>
@@ -49,15 +48,6 @@ static struct pt_types sgi_pt_types[] = {
 	{0,		NULL}
 };
 
-enum {
-	Opt_explicit_open,
-};
-
-static const struct fs_parameter_spec efs_param_spec[] = {
-	fsparam_flag    ("explicit-open",       Opt_explicit_open),
-	{}
-};
-
 /*
  * File system definition and registration.
  */
@@ -67,7 +57,6 @@ static struct file_system_type efs_fs_type = {
 	.kill_sb		= efs_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV,
 	.init_fs_context	= efs_init_fs_context,
-	.parameters		= efs_param_spec,
 };
 MODULE_ALIAS_FS("efs");
 
@@ -265,7 +254,8 @@ static int efs_fill_super(struct super_block *s, struct fs_context *fc)
 	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
 		pr_err("device does not support %d byte blocks\n",
 			EFS_BLOCKSIZE);
-		return -EINVAL;
+		return invalf(fc, "device does not support %d byte blocks\n",
+			      EFS_BLOCKSIZE);
 	}
 
 	/* read the vh (volume header) block */
@@ -327,43 +317,22 @@ static int efs_fill_super(struct super_block *s, struct fs_context *fc)
 	return 0;
 }
 
-static void efs_free_fc(struct fs_context *fc)
-{
-	kfree(fc->fs_private);
-}
-
 static int efs_get_tree(struct fs_context *fc)
 {
 	return get_tree_bdev(fc, efs_fill_super);
 }
 
-static int efs_parse_param(struct fs_context *fc, struct fs_parameter *param)
-{
-	int token;
-	struct fs_parse_result result;
-
-	token = fs_parse(fc, efs_param_spec, param, &result);
-	if (token < 0)
-		return token;
-	return 0;
-}
-
 static int efs_reconfigure(struct fs_context *fc)
 {
 	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_RDONLY;
 
 	return 0;
 }
 
-struct efs_context {
-	unsigned long s_mount_opts;
-};
-
 static const struct fs_context_operations efs_context_opts = {
-	.parse_param	= efs_parse_param,
 	.get_tree	= efs_get_tree,
 	.reconfigure	= efs_reconfigure,
-	.free		= efs_free_fc,
 };
 
 /*
@@ -371,12 +340,6 @@ static const struct fs_context_operations efs_context_opts = {
  */
 static int efs_init_fs_context(struct fs_context *fc)
 {
-	struct efs_context *ctx;
-
-	ctx = kzalloc(sizeof(struct efs_context), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-	fc->fs_private = ctx;
 	fc->ops = &efs_context_opts;
 
 	return 0;
-- 
2.47.0


