Return-Path: <linux-fsdevel+bounces-40988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A39A29BEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2C318888E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370E21519C;
	Wed,  5 Feb 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn1onQR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCF214A96
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791617; cv=none; b=OdsTSpx1YjMBQz9iQtpSuYlz04+9FFISo7siKz/tUr2nLeTxEnPUUCe68FeAFm+NFHne9PktR2jUwdWOOlH0gj40/83Th5mG2J23J6uvNGUlRqO2LlISizmUs5gFZhVplesv9bCFQJE+ThlG/fkGAeG0KFoTnRUY1pAGmd3aFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791617; c=relaxed/simple;
	bh=sSrYFfOhLyhgLswpDNw4BVLeeV6aNKVWuPSzH1t+vV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyLcXwZvzM3NuOLthWwpe4oqMOmiYO4KQFeHRVC1kfGBWNqSjYolW7qJVPLH2nRImXqLNYhr6q0LN9DnsL5lZ0k0ndX6Rnzo5aY8CwP+47Yjsmy5UqJcKkskKDfMa0X1FKXChjRzDM05XRsRJRcLQfifJaAfgxKKg60fKUVfn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dn1onQR/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738791614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G0iVSw8SBWJ0wcY4q6/toDyxAMHsZs8PPRhCFBftE8=;
	b=Dn1onQR/xRwcwJbsv519OUNqkho/ZgiTDhn5dFt1dDQOTZODkl7Y23kgO6C9h8StFsiHJz
	LJNw2ivnVc0TjqN0rlSBYs6zfKNqveviXTrHTK0rbKPyLTInMwkcIOmGowrL9tQWzIOpPx
	Igdx2FWaisqCRPia/wouz49NjzxsJG4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-lCw05xhoNWaKhAaiBwVs_w-1; Wed, 05 Feb 2025 16:40:12 -0500
X-MC-Unique: lCw05xhoNWaKhAaiBwVs_w-1
X-Mimecast-MFC-AGG-ID: lCw05xhoNWaKhAaiBwVs_w
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-847500c9b9aso65314639f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 13:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791611; x=1739396411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G0iVSw8SBWJ0wcY4q6/toDyxAMHsZs8PPRhCFBftE8=;
        b=Qatdr18mihaf7azJbqKt1mbOx50M0TvYVIPiKFi+8aNLHZ54u1zuXrVQgXfEPqD4pj
         MWs2h530HNsDe+D8dk9lQDUpfT1LDgUHr+arwkwL6dE5z6fD348b1+wi6Lrb1dJpZBte
         SsgDtxSTI9bPzlADshfdKKFvibkXcVaiaJx7wjJBkNPe5EWbhEIcMvrElPJkWl9uuHgY
         +B9sivpoEeR+Xp5km9ari/icDx8CZ4l3arDXC03M9BNAY+k+ng+UEq/au2KTR5xkCmgF
         vJFpO87p/4fL8LLVtD0Cn1Hswauv/ByEJzIzSGpvV7V+ICBfj533/4dfa5cZDC88yu7e
         CZWw==
X-Gm-Message-State: AOJu0YxuDniHmHuuCFNhr1OwEXK8X0cl6lVMJnzE76cBmPMQ2gT3ueGY
	NRKIfQchL4mFe8r2uFbwcgN4O+eFSvWzby4p+r6IjgW98IQH/l/kDVcniXZbAyUGTHuLDD42bo0
	OAz2kh6WDd7ceGyj7RBta8/12w1APUsanFkEF2A7gKZQAqlzTa0bFZh9fUm6raENcrhXdcRyk4D
	jtR5o6b95KNXP61C+0PinBgclll2Sb2TEH2eUNCrSWpODDquUo
X-Gm-Gg: ASbGnctZ6k+UPZrmkaiHwa449ySQ455qKdcgssNh4SpOSdhZ7EcOJEzaogjoyA9n2FZ
	l6i+GtG+8ZevOWPRPqBndvYCs5hvYh55kdVv2XWKDnuNFd/93SI74dyO0vQjDE0gZimggEJSc0c
	lLueGsrDcJTW9yXdn94GVMFZN1BW9Ms4W0s40A5KvHyKbSjUq/KR5odr/qwebZcDKf9KSeEgX/C
	nc0QIWRq+gULAomsX2o1KGx50CWM0EiBX4Q0JjjNObLPuapzj6I2+/tTPwHaHVC+5r1HUOMutWm
	MzezDXqowaYpfYYei9+s13Leq9+839DTLYaKAEpGBnqCRjn/90Kz1w==
X-Received: by 2002:a05:6602:3689:b0:84f:5547:8398 with SMTP id ca18e2360f4ac-854ea50fbfdmr467507339f.11.1738791611541;
        Wed, 05 Feb 2025 13:40:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUHF0VDp7Qm6cVIkWkSMceysX5ZCmPtM+2EEVinjNLvwfx/Qh8+E2z1pt9VxHoO9bPWMbw3Q==
X-Received: by 2002:a05:6602:3689:b0:84f:5547:8398 with SMTP id ca18e2360f4ac-854ea50fbfdmr467505039f.11.1738791611172;
        Wed, 05 Feb 2025 13:40:11 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a1717863sm368050839f.36.2025.02.05.13.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:40:10 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	neilb@suse.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	tony.luck@intel.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 3/4] devtmpfs: replace ->mount with ->get_tree in public instance
Date: Wed,  5 Feb 2025 15:34:31 -0600
Message-ID: <20250205213931.74614-4-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250205213931.74614-1-sandeen@redhat.com>
References: <20250205213931.74614-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To finalize mount API conversion, remove the ->mount op from the public
instance in favor of ->get_tree etc. Copy most ops from the underlying
ops vector (whether it's shmem or ramfs) and substitute our own
->get_tree which simply takes an extra reference on the existing internal
mount as before.

Thanks to Al for the fs_context_for_reconfigure() idea.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Neil Brown <neilb@suse.de>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 drivers/base/devtmpfs.c | 81 ++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b848764ef018..03a7c7902fcd 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -63,22 +63,6 @@ __setup("devtmpfs.mount=", mount_param);
 
 static struct vfsmount *mnt;
 
-static struct dentry *public_dev_mount(struct file_system_type *fs_type, int flags,
-		      const char *dev_name, void *data)
-{
-	struct super_block *s = mnt->mnt_sb;
-	int err;
-
-	atomic_inc(&s->s_active);
-	down_write(&s->s_umount);
-	err = reconfigure_single(s, flags, data);
-	if (err < 0) {
-		deactivate_locked_super(s);
-		return ERR_PTR(err);
-	}
-	return dget(s->s_root);
-}
-
 static struct file_system_type internal_fs_type = {
 	.name = "devtmpfs",
 #ifdef CONFIG_TMPFS
@@ -89,9 +73,40 @@ static struct file_system_type internal_fs_type = {
 	.kill_sb = kill_litter_super,
 };
 
+/* Simply take a ref on the existing mount */
+static int devtmpfs_get_tree(struct fs_context *fc)
+{
+	struct super_block *sb = mnt->mnt_sb;
+
+	atomic_inc(&sb->s_active);
+	down_write(&sb->s_umount);
+	fc->root = dget(sb->s_root);
+	return 0;
+}
+
+/* Ops are filled in during init depending on underlying shmem or ramfs type */
+struct fs_context_operations devtmpfs_context_ops = {};
+
+/* Call the underlying initialization and set to our ops */
+static int devtmpfs_init_fs_context(struct fs_context *fc)
+{
+	int ret;
+#ifdef CONFIG_TMPFS
+	ret = shmem_init_fs_context(fc);
+#else
+	ret = ramfs_init_fs_context(fc);
+#endif
+	if (ret < 0)
+		return ret;
+
+	fc->ops = &devtmpfs_context_ops;
+
+	return 0;
+}
+
 static struct file_system_type dev_fs_type = {
 	.name = "devtmpfs",
-	.mount = public_dev_mount,
+	.init_fs_context = devtmpfs_init_fs_context,
 };
 
 static int devtmpfs_submit_req(struct req *req, const char *tmp)
@@ -442,6 +457,31 @@ static int __ref devtmpfsd(void *p)
 	return 0;
 }
 
+/*
+ * Get the underlying (shmem/ramfs) context ops to build ours
+ */
+static int devtmpfs_configure_context(void)
+{
+	struct fs_context *fc;
+
+	fc = fs_context_for_reconfigure(mnt->mnt_root, mnt->mnt_sb->s_flags,
+					MS_RMT_MASK);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
+
+	/* Set up devtmpfs_context_ops based on underlying type */
+	devtmpfs_context_ops.free	      = fc->ops->free;
+	devtmpfs_context_ops.dup	      = fc->ops->dup;
+	devtmpfs_context_ops.parse_param      = fc->ops->parse_param;
+	devtmpfs_context_ops.parse_monolithic = fc->ops->parse_monolithic;
+	devtmpfs_context_ops.get_tree	      = &devtmpfs_get_tree;
+	devtmpfs_context_ops.reconfigure      = fc->ops->reconfigure;
+
+	put_fs_context(fc);
+
+	return 0;
+}
+
 /*
  * Create devtmpfs instance, driver-core devices will add their device
  * nodes here.
@@ -456,6 +496,13 @@ int __init devtmpfs_init(void)
 		pr_err("unable to create devtmpfs %ld\n", PTR_ERR(mnt));
 		return PTR_ERR(mnt);
 	}
+
+	err = devtmpfs_configure_context();
+	if (err) {
+		pr_err("unable to configure devtmpfs type %d\n", err);
+		return err;
+	}
+
 	err = register_filesystem(&dev_fs_type);
 	if (err) {
 		pr_err("unable to register devtmpfs type %d\n", err);
-- 
2.48.0


