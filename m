Return-Path: <linux-fsdevel+bounces-57158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AAB1F00B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF2017EDE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F0272817;
	Fri,  8 Aug 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EIFLRqdK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64C26158B;
	Fri,  8 Aug 2025 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686772; cv=none; b=P2M845m+zRCGj+uXv6JCkJU0E4bWRtFOyRK7IG/6bmPPiG8KC79nTIPO7g/z9exOw2/5CX9lg2UCfiSzQR3HXqcNHr3I20WZgYTB6Mfr76fl0e5oCpzQ7fG03xG221SkXq3QHbWHifCSFT/x+/ZVfwtajWH4TYC2mtMk/u9PREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686772; c=relaxed/simple;
	bh=fy8xsI1SEtvN4pr6TFHlkqqIM9qnDZghXCr72Z2ASO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIz6/w0rug6TDavW66FOs8xv23nBzM6RitWcMo1tt/e4KokolH7SFZuOdKDpsatmozL2j/Far85zMaZ4QmO9h6TNk7Q/fNnvfxopbFm9u5cqAsGp5e4wBJfJgbAnlbG4BDs9HhTf3Awetc+74ManhqtKPVX0U780UlAdx/IUtTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EIFLRqdK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m++wzPv9esK/TfLsYxA34OVU87Ffj0HBY/IuPLEhzOA=; b=EIFLRqdKLC0X4u2jlzEDwW1JVm
	lkgluv+Um/0JpXRCsxBlo7XJ6YTsN1Nq6VysYPvISunpoKI45jfEcKZrU0J5+14QSew5GFe7nOMg1
	7PpwkuYZPkWSuHNlNXofwm7yL5dQ8S/cQprs0YAjKeC8vnUPJM4uEhqjgUoA60q5PhssCKZwvszc2
	as9FvfDUppJFa62lVv8FmR1zAJ+QXQcIoWdT6qqN6d67/wgVif9qYsnrz9XYfVgq5dUUaU9zWI396
	5zUM2tjqg1r6XaG+uILGFivpAyKK0IGNnGz1Wsle2O4YEuPUG2lj+d1GhUL/t9qQ9y8x81jXkRhCq
	z1KD8vZQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBR-00BiQh-Vf; Fri, 08 Aug 2025 22:59:26 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 08 Aug 2025 17:58:47 -0300
Subject: [PATCH RFC v3 5/7] ovl: Set case-insensitive dentry operations for
 ovl sb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-tonyk-overlayfs-v3-5-30f9be426ba8@igalia.com>
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
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
Also, use the first layer encoding as the ovl super block encoding.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v2:
- Create ovl_dentry_ci_operations to not override dentry ops set by
  ovl_dentry_operations
- Create a new function for this
- Instead of setting encoding just when there's a upper layer, set it
  for any first layer (ofs->fs[0].sb), regardless of it being upper or
  not.
---
 fs/overlayfs/super.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bcb7f5dbf9a32e4aa09bc41596be443851e21200..68091bf8368a880d62d9425552613497d6e90b6b 100644
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
@@ -1318,6 +1328,21 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	return root;
 }
 
+/*
+ * Set the ovl sb encoding as the same one used by the first layer
+ */
+static void ovl_set_sb_ci_ops(struct super_block *ovl_sb, struct super_block *fs_sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb_has_encoding(fs_sb)) {
+		ovl_sb->s_encoding = fs_sb->s_encoding;
+		ovl_sb->s_encoding_flags = fs_sb->s_encoding_flags;
+	}
+
+	set_default_d_op(ovl_sb, &ovl_dentry_ci_operations);
+#endif
+}
+
 int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
@@ -1423,12 +1448,15 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
+
 	}
 	oe = ovl_get_lowerstack(sb, ctx, ofs, layers);
 	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
 		goto out_err;
 
+	ovl_set_sb_ci_ops(sb, ofs->fs[0].sb);
+
 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
 	if (!ovl_upper_mnt(ofs))
 		sb->s_flags |= SB_RDONLY;

-- 
2.50.1


