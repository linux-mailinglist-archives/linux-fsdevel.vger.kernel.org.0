Return-Path: <linux-fsdevel+bounces-66657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE435C27966
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 09:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 533C54E48CF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFC928313D;
	Sat,  1 Nov 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjVbovxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77787213E9F
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984574; cv=none; b=UviJFv4+++sMiBt1qvklKJDgHYtTRhuJuaP4bOS1RrqLnEoqTPd3D5TMBDDGNGSPHFd/SsK/x20btrv6Gw2Q6GSvV7QSJlAjGSdHeHbaPkx52OCsEfyDyJijQQDOV9WGCGP0zg4M4pNbftcy29FG8EO09tD2bjf+QITPYd/aF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984574; c=relaxed/simple;
	bh=aMbyWcQR166mxxVYyBkPLZbbpil/RysWQ5GrkvrySPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbTdddi2trPcKam29tBmC3uZTMJN6YRz8iot3LjDONF9dbhVkgQn5n0UR5Wiq2xlXVC+LKurWNP7Os0195Gq9y5hkaH15fKcCUruY8DVqMcMlLz3IgLt9e51+7KYHaNzpmss9ZW4aL2EuqBY3UEf+7dgcE+dqf4D52ebJynTJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjVbovxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761984570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6hpXW7Xu1BcIgDOam4VbqDYhHQu1pji8J6Y/XEr4Bo=;
	b=KjVbovxm1El7jTvBg76Y5mQErid/TlZw9WVzhSWcEIzTFve25UNKNoKB+ZVRFf8lrnzY7D
	Q0XWbJugiK2SjeNKFP3tLR9KmPXnuqdLUGdXm75lGtnwadwlBAIRT+LPNJY9CJyhv61doC
	rX9Tdhp7EFDpBWcurAh5RzyTZZzf1CU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-5sAaT9kdOxa8K8hes91X4Q-1; Sat,
 01 Nov 2025 04:09:26 -0400
X-MC-Unique: 5sAaT9kdOxa8K8hes91X4Q-1
X-Mimecast-MFC-AGG-ID: 5sAaT9kdOxa8K8hes91X4Q_1761984565
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0E901800378;
	Sat,  1 Nov 2025 08:09:24 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BA3A19560A2;
	Sat,  1 Nov 2025 08:09:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/5] gfs2: No d_revalidate op for "lock_nolock" mounts
Date: Sat,  1 Nov 2025 08:09:15 +0000
Message-ID: <20251101080919.1290117-2-agruenba@redhat.com>
In-Reply-To: <20251101080919.1290117-1-agruenba@redhat.com>
References: <20251101080919.1290117-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Local mounts (with the "lock_nolock" lock protocol) don't need a
d_revalidate dentry operation, so leave it undefined for them.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c     | 9 +++++----
 fs/gfs2/ops_fstype.c | 6 +++++-
 fs/gfs2/super.h      | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 95050e719233..fc2be386d3f0 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -35,7 +35,6 @@
 static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 			    struct dentry *dentry, unsigned int flags)
 {
-	struct gfs2_sbd *sdp = GFS2_SB(dir);
 	struct gfs2_inode *dip = GFS2_I(dir);
 	struct inode *inode;
 	struct gfs2_holder d_gh;
@@ -54,9 +53,6 @@ static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 		ip = GFS2_I(inode);
 	}
 
-	if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL)
-		return 1;
-
 	had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
 	if (!had_lock) {
 		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
@@ -95,6 +91,11 @@ static int gfs2_dentry_delete(const struct dentry *dentry)
 	return 0;
 }
 
+const struct dentry_operations gfs2_nolock_dops = {
+	.d_hash = gfs2_dhash,
+	.d_delete = gfs2_dentry_delete,
+};
+
 const struct dentry_operations gfs2_dops = {
 	.d_revalidate = gfs2_drevalidate,
 	.d_hash = gfs2_dhash,
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index acd9eefd4ff3..3d3033a75e3b 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1138,7 +1138,6 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_magic = GFS2_MAGIC;
 	sb->s_op = &gfs2_super_ops;
 
-	set_default_d_op(sb, &gfs2_dops);
 	sb->s_export_op = &gfs2_export_ops;
 	sb->s_qcop = &gfs2_quotactl_ops;
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
@@ -1207,6 +1206,11 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	error = gfs2_lm_mount(sdp, silent);
 	if (error)
 		goto fail_debug;
+	if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL)
+		set_default_d_op(sb, &gfs2_nolock_dops);
+	else
+		set_default_d_op(sb, &gfs2_dops);
+
 
 	INIT_WORK(&sdp->sd_withdraw_work, gfs2_withdraw_func);
 
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index 173f1e74c2a9..d4ce3fe1835d 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -57,6 +57,7 @@ extern struct file_system_type gfs2_fs_type;
 extern struct file_system_type gfs2meta_fs_type;
 extern const struct export_operations gfs2_export_ops;
 extern const struct super_operations gfs2_super_ops;
+extern const struct dentry_operations gfs2_nolock_dops;
 extern const struct dentry_operations gfs2_dops;
 
 extern const struct xattr_handler * const gfs2_xattr_handlers_max[];
-- 
2.51.0


