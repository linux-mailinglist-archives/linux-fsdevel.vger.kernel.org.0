Return-Path: <linux-fsdevel+bounces-13863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59629874CDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A161C21E41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58278126F2A;
	Thu,  7 Mar 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3tNSS35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A628127B43
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809348; cv=none; b=HsutWs5xam7NC3V9rgv5o3tmFCzwkTPrnqwMSmDMPX9gS9YN/Muk2eDFXLeOxLiV3H43bMsO9HqhDVWS7HGrN6ajPrN1Oy9TGJ5OyViqX8NSqangHwo3RZlzk0iddSFDP8Hq4JLs+BVZIEkveAgNZsnr+g9h+FuUjsKV1psXt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809348; c=relaxed/simple;
	bh=DRvnV8HJutIaAxTKTLKjKif+ZWKH1rr59mk4v4Evgfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3kPEDSEmTAEIWuOUgjGbcY2+HMcKAOW7hgk6+opDDrX8z5kcZCA+yeg6+y0w9BvRm+fZ8o/msu3sOG+uCAvybzFiLTuxPnvK1Amwm/K1g7Up/isiRa4ws1pfdjbjWwObbSJ6k6+CBd+0a//Idm2/WAmHlOtR0xS2Dj/ngojfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3tNSS35; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709809346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jVYJDDKL/ChitY3WVDYwxzPamDrn+GtiVTQKdLJFZo=;
	b=S3tNSS35wNybZ99bXIXOCcem4KDWjiWWuqI+V5mCEnbhyp5zMM7SBHhRMTQNF40noJAsUY
	PVB/JqclLYDvigNOPXjv6BbXVcadTNdXu1P7G7eBswcwi93FBzhXzt0Q978kCQMQs3LAgO
	DY9BI5efpz0hljPsV5uRoj6zAeJowr8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-UtRXtJsxMMCldRt74tJhVw-1; Thu, 07 Mar 2024 06:02:24 -0500
X-MC-Unique: UtRXtJsxMMCldRt74tJhVw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e40126031so4823305e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 03:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809343; x=1710414143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jVYJDDKL/ChitY3WVDYwxzPamDrn+GtiVTQKdLJFZo=;
        b=eCuizvWVWGVGijmbLnt1B1kFD+Xta3X0ATDY1wqICLuCacOOL1dH3/UkttSqxzOupD
         urY9tWu1V4ENadloUAscNZvtUJ5KNSWeVUtx5JTFO32DsNL79lw4gxKhsya2x3syJq7P
         J18k3aR19C2YUDERKquOxxSAPtlF4a+yX9zm2NDomuxuiKZCioA8Yccasqmhk9zxxsDq
         BiAaDq0I1evH0VSaPfhUJsK0ZPKlfbA5HCITL+I4HDJJNz4aguWWjUoV1YlirdvyyMeV
         gpm/Vd/Ng4x+ZGiQwA9osaAcVTqxtEGz5mrmnXPFndIAPVYpfVblxpU9eGffNiizeqj5
         8xZw==
X-Forwarded-Encrypted: i=1; AJvYcCXnSDBxog2FsqlPht8bWLr4umXQNcydp72filUVOCN5lZV9CFfyh3unHLbakgXOG8KN32ZpkAOIgOPReRH0JjGgvkcZDy522JsPWeIiVA==
X-Gm-Message-State: AOJu0Yz4iQxp72UsoAaLSckAJr8fAsQKbZWsjNs5eqAmxkrqUddAcNFX
	57OPwy3aiTYn4yP5fUwL4L73OTU7mO7kHgjNfhutgOY5ECxOiofAWosV8GBG/QOp9DxMI9gzIDz
	h3CLLaqdbdVCriQ+c4PNcefX01vq7v/xQnqnFK2rq6gnZmfhMVKFTfcdmHak//Ms=
X-Received: by 2002:a05:600c:1d1c:b0:412:ed67:f948 with SMTP id l28-20020a05600c1d1c00b00412ed67f948mr5348728wms.32.1709809343520;
        Thu, 07 Mar 2024 03:02:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxkAVWIDVWcUtSzYTwdWkYYnwjVhmqktUpKpAr0gbcqOreJtyMC2g99k+fKinvzoQ13J4NzQ==
X-Received: by 2002:a05:600c:1d1c:b0:412:ed67:f948 with SMTP id l28-20020a05600c1d1c00b00412ed67f948mr5348707wms.32.1709809343152;
        Thu, 07 Mar 2024 03:02:23 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (92-249-208-180.pool.digikabel.hu. [92.249.208.180])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b00412b4dca795sm2332625wmo.7.2024.03.07.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:02:20 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] ovl: only lock readdir for accessing the cache
Date: Thu,  7 Mar 2024 12:02:07 +0100
Message-ID: <20240307110217.203064-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307110217.203064-1-mszeredi@redhat.com>
References: <20240307110217.203064-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only reason parallel readdirs cannot run on the same inode is shared
access to the readdir cache.

Move lock/unlock to only protect the cache.  Exception is the refcount
which now uses atomic ops.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/readdir.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index edee9f86f469..b98e0d17f40e 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -245,8 +245,10 @@ static void ovl_cache_put(struct ovl_dir_file *od, struct inode *inode)
 	struct ovl_dir_cache *cache = od->cache;
 
 	if (refcount_dec_and_test(&cache->refcount)) {
+		ovl_inode_lock(inode);
 		if (ovl_dir_cache(inode) == cache)
 			ovl_set_dir_cache(inode, NULL);
+		ovl_inode_unlock(inode);
 
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -733,12 +735,18 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	}
 
 	if (ovl_is_impure_dir(file)) {
+		ovl_inode_lock(file_inode(file));
 		rdt.cache = ovl_cache_get_impure(&file->f_path);
-		if (IS_ERR(rdt.cache))
+		if (IS_ERR(rdt.cache)) {
+			ovl_inode_unlock(file_inode(file));
 			return PTR_ERR(rdt.cache);
+		}
 	}
 
 	err = iterate_dir(od->realfile, &rdt.ctx);
+
+	if (rdt.cache)
+		ovl_inode_unlock(file_inode(file));
 	ctx->pos = rdt.ctx.pos;
 
 	return err;
@@ -758,7 +766,6 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
-	ovl_inode_lock(file_inode(file));
 	if (od->is_real) {
 		/*
 		 * If parent is merge, then need to adjust d_ino for '..', if
@@ -773,9 +780,10 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		} else {
 			err = iterate_dir(od->realfile, ctx);
 		}
-		goto out;
+		goto out_revert;
 	}
 
+	ovl_inode_lock(file_inode(file));
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
@@ -808,6 +816,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	err = 0;
 out:
 	ovl_inode_unlock(file_inode(file));
+out_revert:
 	revert_creds(old_cred);
 	return err;
 }
@@ -817,7 +826,6 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 	loff_t res;
 	struct ovl_dir_file *od = file->private_data;
 
-	ovl_inode_lock(file_inode(file));
 	if (!file->f_pos)
 		ovl_dir_reset(file);
 
@@ -834,21 +842,22 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 		case SEEK_SET:
 			break;
 		default:
-			goto out_unlock;
+			goto out;
 		}
 		if (offset < 0)
-			goto out_unlock;
+			goto out;
 
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			if (od->cache)
+			if (od->cache) {
+				ovl_inode_lock(file_inode(file));
 				ovl_seek_cursor(od, offset);
+				ovl_inode_unlock(file_inode(file));
+			}
 		}
 		res = offset;
 	}
-out_unlock:
-	ovl_inode_unlock(file_inode(file));
-
+out:
 	return res;
 }
 
@@ -930,11 +939,8 @@ static int ovl_dir_release(struct inode *inode, struct file *file)
 {
 	struct ovl_dir_file *od = file->private_data;
 
-	if (od->cache) {
-		ovl_inode_lock(inode);
+	if (od->cache)
 		ovl_cache_put(od, inode);
-		ovl_inode_unlock(inode);
-	}
 	fput(od->realfile);
 	if (od->upperfile)
 		fput(od->upperfile);
-- 
2.44.0


