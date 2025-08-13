Return-Path: <linux-fsdevel+bounces-57807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20751B256BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F761C83726
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55AE2FE078;
	Wed, 13 Aug 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oG5oPcSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DB2FE05D;
	Wed, 13 Aug 2025 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124662; cv=none; b=IKQek92tm+evc01xzO6ZGAtlU8+0RZV/l1snBezGXCRDbkCEn5eG+lJiTaBdjUMAFOfy8m7DNr/bj08ekZyDx2zOV9OprrQRUTFVsi3It0lZc2U15hqCioZt8C6hV5Ld/6Nk58IC3a5pwJhw0L26+A84nHQlctrfpZ1jgDwvuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124662; c=relaxed/simple;
	bh=XHal8X76VAPg9O8ritmQ6gu7iQPpSHGXZ27sImuSkVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYLb0GxXcUUtLt+S/SD5pCit1F/O8ihgpJJ2/rctLhSihq3kO+Y/U8sl9Fj2njzCW67a4WoywIfKRM6sChK9kY1TvCMW4ozn2/PfLHNbhsgEHp2sv1hZzlQ0RYdWWdcKA7rCQLdPpIlfgoRzJ24Hvdh8B5xUxKhINBC5i7eZ2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oG5oPcSM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xvZiGEmUn7Vs7pmSk3MFlMoqTi8sVBRINw3/B8dbAKY=; b=oG5oPcSMiaSDejoStEKfbQkQ/I
	668vgreNaPuheJCV3Qq9rpBpyiaf878vE5jZ9CxfIjEdDbacOuYF0XnHfX/uMG7J9rxaVCEcvL8pJ
	6sQsdItId9n2Nl9J5fpVwVSW2BnEGsWfskK5OyGet2ifVupnMaffiDFbZIQLo/pcS0SpIGsAus0HW
	wzEfN9QsVyFkRouU/iUBucHSFnDVEGUzSRwK0AJueg+OVUIlmxnMmyNW5uh5NzE6eVbO5wGjhVVFv
	CKSGYjEzzi8v36nqsP/nBsBSCujtEn5oWbQKpD23QLLT8YtU3pDpzSwU75V8dDmw4IYEn4wBfeOsp
	J6Rc21xg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK6B-00Ds0c-Vo; Thu, 14 Aug 2025 00:37:36 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:42 -0300
Subject: [PATCH v4 6/9] ovl: Set case-insensitive dentry operations for ovl
 sb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-6-357ccf2e12ad@igalia.com>
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

For filesystems with encoding (i.e. with case-insensitive support), set
the dentry operations for the super block as ovl_dentry_ci_operations.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- new helper ovl_set_d_op()
- encoding flags are now set in a step earlier

Changes from v2:
- Create ovl_dentry_ci_operations to not override dentry ops set by
  ovl_dentry_operations
- Create a new function for this
- Instead of setting encoding just when there's a upper layer, set it
  for any first layer (ofs->fs[0].sb), regardless of it being upper or
  not.
---
 fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b1dbd3c79961094d00c7f99cc622e515d544d22f..a99c77802efa1a6d96c43019728d3517fccdc16a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -161,6 +161,16 @@ static const struct dentry_operations ovl_dentry_operations = {
 	.d_weak_revalidate = ovl_dentry_weak_revalidate,
 };
 
+#if IS_ENABLED(CONFIG_UNICODE)
+static const struct dentry_operations ovl_dentry_ci_operations = {
+	.d_real = ovl_d_real,
+	.d_revalidate = ovl_dentry_revalidate,
+	.d_weak_revalidate = ovl_dentry_weak_revalidate,
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+};
+#endif
+
 static struct kmem_cache *ovl_inode_cachep;
 
 static struct inode *ovl_alloc_inode(struct super_block *sb)
@@ -1332,6 +1342,19 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	return root;
 }
 
+static void ovl_set_d_op(struct super_block *sb)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (ofs->casefold) {
+		set_default_d_op(sb, &ovl_dentry_ci_operations);
+		return;
+	}
+#endif
+	set_default_d_op(sb, &ovl_dentry_operations);
+}
+
 int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
@@ -1443,6 +1466,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (IS_ERR(oe))
 		goto out_err;
 
+	ovl_set_d_op(sb);
+
 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
 	if (!ovl_upper_mnt(ofs))
 		sb->s_flags |= SB_RDONLY;

-- 
2.50.1


