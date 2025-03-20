Return-Path: <linux-fsdevel+bounces-44644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5367DA6AF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1A418954E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE1228C9D;
	Thu, 20 Mar 2025 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr9U5Xe0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166F212FB3
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503353; cv=none; b=ENHlmfNtkB9nydPiIPZP3EcxJfL94sKhnW3IT6M3liMrSG/fu7eEQqEElxrHNsIDqNpylrHaaaBvyw2VJUqbqacV44448x4ea3nQA25nU6USpfSUWFwaxNGBg8p/l4E5Y8fkXISdRx4R/xRC8souL6y0tjtFszNZ95FXRm02Lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503353; c=relaxed/simple;
	bh=6OjAdgWPP+dKAAVlmLesiSacftbQP4PyxLTS1Jxnc9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVTiY+2xnu/SCv+FOHjTdaXh4l0colglydEt8PeEO/aZM/CeLHTxkqMHdX2e4GrivkaeWeQ6nSQWGruEjAr1GGfVM8UHV8+EM3LFPhCfUtgU1Bs0WwSdJvvld+WCojIyl0CUXSW/7XYmnNSOSWuQ7wccm2EB9Wn+E/QFPTFJNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr9U5Xe0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742503350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KOw7c5Tf+SeDsGyNpIhH2aL5qudRwHH/tGXEBVgXAus=;
	b=Gr9U5Xe05hOWY09vqety9W6XCxI/Nnryu4Ngzo/cIdxZcZPcAEpDlVUb6UzVEWIYEIJxpu
	EJgu1pQfl2LvMO+6vVa+sVikOsUNJHJ7SnpWjQKN8r8/K2KzjSD3xvFwXB/60ftTcg2jHJ
	omeTxm9D1sMqZ8gCmtdTaM8+SqTSpn0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-0RMxb4XWMlKOzByg0mvXqw-1; Thu, 20 Mar 2025 16:42:29 -0400
X-MC-Unique: 0RMxb4XWMlKOzByg0mvXqw-1
X-Mimecast-MFC-AGG-ID: 0RMxb4XWMlKOzByg0mvXqw_1742503348
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso7468605e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503346; x=1743108146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOw7c5Tf+SeDsGyNpIhH2aL5qudRwHH/tGXEBVgXAus=;
        b=chm2MbQkQC15LOXEoJxWAZFnPG2Ss/wpHJp2qjyUFe+xHGqKjbbU5o8YO2Nqnjtje9
         GLc4vkAcbvG7RfUqWK0CI3B+Ily3FXNYby07+ZSehJBfvGme/WOk1/aQBOkiZcBmogvu
         gG0M5RXBGDI/S2tA1eU/RayqTex3ai2sLYQ5fnGCsFg2y5nqhp2m7EKCJu4Y3j5ZuyzC
         b9fA0dTnGwd3gLMRkx4u/e1/ta+UCRlrGMWV4POSyuPKM2xZ7WQbevcr2NZEBBD2usxU
         oxFdNwt8TwYvh9a8Uv5G8GduFhzXccfM7eAA+v58WPlBINgjUJpZ0FbTpq20zmd45Tui
         u6YQ==
X-Gm-Message-State: AOJu0YxO38XxGJrPLfX72mkwcUQO92OVrK1sUyruu+B1RazoKabRdy58
	qGTWj8EN1+YE8aD1GJFeP/rMCUeKAXbGrpI+log11xBaWGoIufwLLZq/ZoM07jxJnf3LO7R1EK6
	zCEqLvxOtWpgiwG3DCkT7UlHQYV/wAEKBGFgFpzkkAKN3Hf3bIAm7cD4AF8DSE4nNWpzoQrwqB0
	YYu9XxKQMkgsulTTC5GatIcE68qNg1k8PMIeI76Gvz7f8uKg==
X-Gm-Gg: ASbGncs/S0sbKt1ZUmaC/xv1ovDmNAOlhcyWRFYbHYNI9v2wObuoGXy6g67txGyVH3u
	Tlk51KiLsQ4rlihcVIPieaHPQHKcnj8TEDcRNs33NporHNMbqJB9MGQNnQFGw43uCLOhBSYu4PN
	INFHboubwfqtPE6irrCuwWD2NA79CT9GCvwYPZy4FZIhIPiTwsT1pdi+NjUJ/B3TGrFPv/XgGey
	iOamapzCCFdI/g+ct3Ix/l/p3gofbfvWT2POvYUyLQa7ZC6TMSWF54VAls+u32S5tT7luRvGIus
	oCzIIPrOqtfdCxyMbX/S3zSzebdPDBl0oYNgUdAU7kr7b45eOHTq
X-Received: by 2002:a5d:588b:0:b0:391:4684:dbef with SMTP id ffacd0b85a97d-3997f8f9fc4mr683333f8f.17.1742503346488;
        Thu, 20 Mar 2025 13:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnsJIjPMHNCYM+iqpFqNMvjeV12Qh3w4FXef1vblgl3bS/b1dosTCoPid8UgaMyD+AIuRAKA==
X-Received: by 2002:a5d:588b:0:b0:391:4684:dbef with SMTP id ffacd0b85a97d-3997f8f9fc4mr683320f8f.17.1742503345918;
        Thu, 20 Mar 2025 13:42:25 -0700 (PDT)
Received: from fedora.redhat.com (gw20-pha-stl-mmo-2.avonet.cz. [131.117.213.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a325csm520581f8f.22.2025.03.20.13.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:42:25 -0700 (PDT)
From: Pavel Reichl <preichl@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: aivazian.tigran@gmail.com,
	sandeen@redhat.com
Subject: [PATCH] bfs: convert bfs to use the new mount api
Date: Thu, 20 Mar 2025 21:42:24 +0100
Message-ID: <20250320204224.181403-1-preichl@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the bfs filesystem to use the new mount API.

Tested using mount and simple writes & reads on ro/rw bfs devices.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 fs/bfs/inode.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index db81570c9637..1d41ce477df5 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -17,6 +17,7 @@
 #include <linux/writeback.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
+#include <linux/fs_context.h>
 #include "bfs.h"
 
 MODULE_AUTHOR("Tigran Aivazian <aivazian.tigran@gmail.com>");
@@ -305,7 +306,7 @@ void bfs_dump_imap(const char *prefix, struct super_block *s)
 #endif
 }
 
-static int bfs_fill_super(struct super_block *s, void *data, int silent)
+static int bfs_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct buffer_head *bh, *sbh;
 	struct bfs_super_block *bfs_sb;
@@ -314,6 +315,7 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
 	struct bfs_sb_info *info;
 	int ret = -EINVAL;
 	unsigned long i_sblock, i_eblock, i_eoff, s_size;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -446,18 +448,28 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
 	return ret;
 }
 
-static struct dentry *bfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int bfs_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, bfs_fill_super);
+	return get_tree_bdev(fc, bfs_fill_super);
+}
+
+static const struct fs_context_operations bfs_context_ops = {
+	.get_tree = bfs_get_tree,
+};
+
+static int bfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &bfs_context_ops;
+
+	return 0;
 }
 
 static struct file_system_type bfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "bfs",
-	.mount		= bfs_mount,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "bfs",
+	.init_fs_context	= bfs_init_fs_context,
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("bfs");
 
-- 
2.49.0


