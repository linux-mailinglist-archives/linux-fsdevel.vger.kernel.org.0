Return-Path: <linux-fsdevel+bounces-58821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F1B31B43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2806C188E6E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956E311C12;
	Fri, 22 Aug 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fWu6ZXZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AA30F551;
	Fri, 22 Aug 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872258; cv=none; b=mANRTRacRWmI2AuMFu2Af1U9/hiXihr36maYHa8RfdOeSePpEG0OoSQoA+Wv3hhHpFzsBBWMi08d5Lx/PF46uc3INEYav9kLy2ezf6PlqyX6F7I2i3ix/Yia299x2FU56GN+Wzt/eyE5fhLPrgie96+Q5aClteTh13hEVtyc/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872258; c=relaxed/simple;
	bh=hECWb/SERDorPXgabvxcc+uYSN/GSAgZZcIW7GZ6Oag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIQcb0ZL47IuvKB7aiYkyKT2C3rJuniBr0SapgDLFFKPYQTGtk4ZJ5zpY3lR6uqEOeM/bzKYw/Og9BenFmxVCYGc9NfoFyh4aGOLK50v/PviP6CNSNr489U1PAtw8tSayZHIhh1iHO5BWl4RAbuKMHudN4BXyJ+xHaMAVfZJsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fWu6ZXZB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o4/WKEhn09FDxpqBem5yM+hq2cKap2yn1U90gr5j3g4=; b=fWu6ZXZBVdVzB6haHBeIMspRcZ
	Trznkn0oU058HoBB/d3UMH//4ctrAJKm4i8g/GvsM9xjtekpc3GIfieHIR5dqQgH8JMIKYCirV7pv
	4u4geRnW8SkF9zAJp4yiUpNS/R/h1UuJjNANoESG37ii0BsDzD267oBNCBQdSclycXSI4RKsLINho
	YgD6HKQTBNVcDbUimwy4pJu8DGhfYg0mz5etMALqaTm3IydfwAMzDkirz0spc1xi0mFuEYAC/beT0
	tq/OsUl2dsiGnzrP5bsIp6JNk/SmuYWRtq4Rn/uROSk3R0rjUTW/09s4BaIrTF1X93voFVPUD3XVs
	03Y7O60w==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSaC-0008Fn-IJ; Fri, 22 Aug 2025 16:17:32 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:09 -0300
Subject: [PATCH v6 6/9] ovl: Set case-insensitive dentry operations for ovl
 sb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-6-8b6e9e604fa2@igalia.com>
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes in v6:
- Fix kernel bot warning: unused variable 'ofs'
---
 fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b1dbd3c79961094d00c7f99cc622e515d544d22f..8db4e55d5027cb975fec9b92251f62fe5924af4f 100644
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
+#if IS_ENABLED(CONFIG_UNICODE)
+	struct ovl_fs *ofs = sb->s_fs_info;
+
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


