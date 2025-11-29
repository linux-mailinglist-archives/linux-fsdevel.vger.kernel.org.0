Return-Path: <linux-fsdevel+bounces-70240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E086C941A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79970346FAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775752253EB;
	Sat, 29 Nov 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9KG+5dL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B91F8723
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764431712; cv=none; b=aVRJyEyPUjlSFG5/2CkPBOZjsDNYmBksVKHuvvhlVV/vO1FBvmmT/VCSoa58lvkng1FxpYtfZNHU+VYICxHWqQC5wpdp6h+Li5m1xSSYgh9JdJtcof0DRqTvSw3DH8HL7fYUN1HVgvTwUTZaJS22PxvD9A0vW/3tS9anLhHAxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764431712; c=relaxed/simple;
	bh=gegZGqXA1lQbjgAIgRfxxClC9l/ycrOqbI88gF9ufyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kybR4+KyHIirh131IrSoPZ3aHzGSKR47cP4mrnHoPAkJAiThq9dlkV2aIVmk92jIKDr0bvS/hkH0MR4qXhswGELGTXiSKy8e0o9M8/LUla33762Y1VOnIbouM/XGid0ErM8dAlXen5TxV01GqKIULprEk8F8xr7sWCwgDgMW920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9KG+5dL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so4258245a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764431710; x=1765036510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhCNIy0D0SRdxJhzjFTGAJqVSQJS+0jdQCu4h9SuzuY=;
        b=F9KG+5dLlZWZZ7mr6u6TIzYB7xmHuljKkGGQ6+DAyUh6+Asa7OnmfMJu3Buy/8rmDb
         3hgejF7QMuSt8V6eTpj3Y5TshLAjLXqnH8IQLSRgn1YqkksKYUcfAmtVkcB1VH70sCt5
         MJNMPVExPzAe/sWwqvxaOLJZEhPtInrZTiWVMn1pc2n/1GGmgsxor+sn7QwYHOXRJM8i
         A2BFAz9NZDeQ8qaBR4Z4y/tZL6h5rrweuDkT6oOKym8O43IVekEKZdLGxphej7PYi1hE
         3cfnOgJi7xxeegPV75ibjnLd2mnye8slrPPlSpF4Tbcz8XNpHZbR53dEoYaOxEP3UrFp
         /Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764431710; x=1765036510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jhCNIy0D0SRdxJhzjFTGAJqVSQJS+0jdQCu4h9SuzuY=;
        b=UdGa3hIB0NgEfCFZOXYYF0DZyGggrGGXeADb15v++fOlrmr4HASiRvDYj2LGyHNmty
         T0JL5WCTu1y0JJZlHBUQfvh576YLPtlISoLPbq1QTy0KgWII9R+J7x2YFZlDN7EFl0FR
         sWlOrwjkOqt1+zUoJpECb1BAdE+agRU8aeRzJl4/ToqtsTaLP6Sx/a4cy5FlkajQZwPy
         CR/jIVLyb27hOtMzNeHWmuVnk3VSTVF1CROcX7AJKDBb9D/iAga1KxnNapl/Bho1jHm4
         DifxreO2wp5o17912bnDEsfUDzIShTDPwhtclHdNFNT/g1wrOPfcv5PExuI8N+M2acqe
         niiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzV0KoIBRo7zm3wor0ofzRqF58BMiiNtHlfWuwycjDKsF2xnexwSWd3xVWZOywrUDlb5xWzGQQN8jYrITK@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHfV1bTqzKyuRSkunlqaRqk6aFdf9zCmfakIgDoMotQc20+LN
	/AG74qEBfaTvxJFjVoY+1vkWs1ZdS3KVaONLUvy2VrXVbiYuOcu4H7y5
X-Gm-Gg: ASbGncuxJLCeRaa94QrNw6Bqh4/sRUAZKsFIlcgyag04GFiZrkZdLoKJRVYeyKLN1yb
	9pMGDEYeJGNfwcy4Pvr4LKHPsfglb10OJJWooYwi595iIPy+B6ZC5MQpAcpVnLQ/9mWtOa16f72
	/uKsh80EsQanZjQlYNLZ8BnxOaYoV8atuEri5c+LSAGsruZSUs2qak1WYjGU4yJMrdtQyN++e2P
	73g9982bzJWIGb9OR2NjJDVIrkTY2Z0PcHUUIsxBmfUHffVf3GHA6sn3akPa8AqxA9iwtezHLiu
	i7qVrNyw288aW49tY9bt1bxdNeBE8/eF+91oustgiR0afDD7/ZAQXQYDIndzzLdlTLFVLUs99lz
	Wx9imXh8XFZARaUFsZ3qgHX6rCoxkNPQtl1MG2rHwjOfSuGoKxOFV9W8DiPAVbiUNtZW6wm9Jht
	x+bLVcj9vOmoDAWXI9zcfjqJfKdmFDFzYQxgvYsJRuqAwG5HOv1H+W898m/m0Gtt6a8/+6sw==
X-Google-Smtp-Source: AGHT+IFhLylm23z4EC9kbKlPmCLt9IYn3gMNvxGhOHgGAs6cCQq5gpcDrVIiFz69fb4dKLmwIwZ+Ig==
X-Received: by 2002:a17:907:3c90:b0:b76:beac:ed1 with SMTP id a640c23a62f3a-b76c558b02bmr2174301066b.54.1764431709280;
        Sat, 29 Nov 2025 07:55:09 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162c5csm746364766b.6.2025.11.29.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 07:55:08 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] fs: hide namei_cachep behind runtime const machinery
Date: Sat, 29 Nov 2025 16:55:00 +0100
Message-ID: <20251129155500.43116-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129155500.43116-1-mjguzik@gmail.com>
References: <20251129155500.43116-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c                       |  7 ++++---
 include/asm-generic/vmlinux.lds.h |  4 +++-
 include/linux/namei.h             | 11 ++++++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 23d1752c29e6..5cdcb3d0ee3b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3282,8 +3282,8 @@ static void __init dcache_init(void)
 }
 
 /* SLAB cache for __getname() consumers */
-struct kmem_cache *names_cachep __ro_after_init;
-EXPORT_SYMBOL(names_cachep);
+struct kmem_cache *__names_cachep __ro_after_init;
+EXPORT_SYMBOL(__names_cachep);
 
 void __init vfs_caches_init_early(void)
 {
@@ -3298,8 +3298,9 @@ void __init vfs_caches_init_early(void)
 
 void __init vfs_caches_init(void)
 {
-	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
+	__names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
+	runtime_const_init(ptr, __names_cachep);
 
 	dcache_init();
 	inode_init();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8ca130af301f..890250fffbe0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -972,7 +972,9 @@
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
 		RUNTIME_CONST(ptr, dentry_hashtable)			\
-		RUNTIME_CONST(ptr, __dentry_cache)
+		RUNTIME_CONST(ptr, __dentry_cache)			\
+		RUNTIME_CONST(ptr, __names_cachep)
+
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/include/linux/namei.h b/include/linux/namei.h
index bd4a7b058f97..c167f3a852e2 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -9,6 +9,10 @@
 #include <linux/errno.h>
 #include <linux/fs_struct.h>
 
+#ifndef MODULE
+#include <asm/runtime-const.h>
+#endif
+
 enum { MAX_NESTED_LINKS = 8 };
 
 #define MAXSYMLINKS 40
@@ -88,7 +92,12 @@ static inline struct filename *refname(struct filename *name)
 	return name;
 }
 
-extern struct kmem_cache *names_cachep;
+extern struct kmem_cache *__names_cachep;
+#ifdef MODULE
+#define names_cachep __names_cachep
+#else
+#define names_cachep runtime_const_ptr(__names_cachep)
+#endif
 
 #define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
 #define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
-- 
2.48.1


