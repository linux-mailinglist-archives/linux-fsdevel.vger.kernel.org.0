Return-Path: <linux-fsdevel+bounces-45465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7CEA780DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4273A859D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2520D503;
	Tue,  1 Apr 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbCcIStI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B33194C96;
	Tue,  1 Apr 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526397; cv=none; b=lHa5MDUWc7kn4KzGDpwPKYfgpPLynP25+h1ZYE2uBJG6xNNNKVfi4KuIRTT1fOUU+tgf0mtPGJ903pvcx+UZxPWut5Er6//mGPnI7MYR90KKkwXOiTt+0IsGH/TD8L/D63qHkGIi3GVF+pXemB4bJOvhSfjQGgPRZwHzFu/hg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526397; c=relaxed/simple;
	bh=wry4Ntdt9WLx3hUbeFpnRHWZCyGnvXM8LuWSpa9I9AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRXeviP6Z0Nk14JK6stWf4HFCZg4RyjsDdsqKUlHb6j65ckT2+nx3VLED+S4yCjnw6HMaxEh4T3yOMAKSHvjyB5n7v3Is9ydvEuvUXJQI6nJEMQRMzqk78pgvxA7bQ6cR8RBJS9DjJuWIcHvrGbpdOpSs0S6AcSR3krCoS4oCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbCcIStI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso42482915e9.1;
        Tue, 01 Apr 2025 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526394; x=1744131194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEhBookynFiDE+Bfy7pUPsUm353VzzV7ED0Kjv5pN+4=;
        b=XbCcIStI6YEsykvHwup2HW3rJhWgYRV4ia4XsHDUFlhvol0Uun+feykCFJ+PHEoV+4
         Uxu1KbiM31BckQVYHtQgf7v3w96aKBvXhCZ3pb7yqQMnwMV6SJroEzjRJyEQ+kpOZke/
         e0l55avXe2vPLEiwepzfEcntniDeelrr88TaiFkKT2yogZ5BCRf0XY/sRTVcEw2fInLL
         7PoldWXHwBy7tPtD17h9PFvgnqqL+rpEmgGjToY5Od/YOJlP9KO1UruFZK6DRsEzB6TJ
         U0qp7rYdw+thZeBa0icAna5FS9x09kWG54j3It36EFgvH3iYoXlkkVndTirXG1dI/G2l
         QO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526394; x=1744131194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEhBookynFiDE+Bfy7pUPsUm353VzzV7ED0Kjv5pN+4=;
        b=smlxBp0lupK/U+mWDGZYGiyYPIci7AafpEb0mHv8JBwL+1w3vUREdyl/7jNnvnejp9
         aZA2cpvaoeX2z0hm1h14w7TuoGCiHUoH8PzwU0UIoqUTp4NFiS2M+6UzydhAkt2P3AJl
         7jeB2M6a18JjGJFO5VI5osj1ZFxzuvKAxy5eZKDQo2Dv41obnQsW/utlW/V4SrP9aLQ7
         J84DTSPggAUkEBTnazyYXK+XJg5xpNAN8zzihXVSsfC+qo/A4Tjo9LE1+wH/lB64v5uR
         ewh2gQ6MT7hz4s7l5mGROmZBTS3Y7apxbdlSZpNVQXAMZXXe9yl97MXrqhim/1x2FHIo
         +S8g==
X-Forwarded-Encrypted: i=1; AJvYcCWqgv40qDCPiwyB/sFZlPGSaRqWqFvInqKD9Gyly/sLIbXVcRBSxONr/Wr7i5Y4rI8p4kFhp9GUNAYGnqTM@vger.kernel.org, AJvYcCXdqmxjqxfhrc6P/1w53EX9vhgE+np8r4dQV27RSAg2jS91wdPg7Bg4nKkAIHid22KPvLF7Wv9oxi8XKWBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiK1LVxaNyk4G5/onoD7lx+3PAeB5AJ8Utu1mF6dqq5fEWSYG
	uLeB04RsCFtCu375VZXFaS1ma4WLjhUnmx0lYCUnqX38YdjvBMVl
X-Gm-Gg: ASbGncvb+4VdVkTXSAgiTDNGyr9U0zR8pExtD1njR58BD0PKXoTo6h4YLLwrcjSYM/S
	aG/oPZLmoF4r6dEWFvYvHrhGfwmPRA+Ms37cnH93HXcsBCzuyCml+lQqcn39YJvtHmcQKZk2Pvx
	dAqja7Bs5dJi4MwZTc97/aS87SmRku3/HKtYOM1U8PaKzzwImMDkIm1EXlhxbX9AQmlhe1pelTp
	lw18hkoEwd137kit7PPjCRVGGhslVa0eVu8fQ5vYeOVH+RUe6t7HvD0aNtmRgI5XC0K27N3JA5I
	OSJRK7IDj4jvpyXXW/gIVDIou33i3PkUh0BLdqG0e7OnAqtFniFsa1GRSHrp
X-Google-Smtp-Source: AGHT+IHl75hJhgNyJ1RJt/fywnYA/sERerAFghDEKA2XWLWfZ7WFTJyP3gzmLlwTGFJlr9+iHdVoDg==
X-Received: by 2002:a05:600c:468c:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43db6222f89mr134005025e9.8.1743526394062;
        Tue, 01 Apr 2025 09:53:14 -0700 (PDT)
Received: from f.. (cst-prg-92-82.cust.vodafone.cz. [46.135.92.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c1845e66esm8638141f8f.18.2025.04.01.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:53:13 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: make generic_fillattr() tail-callable and utilize it in ext2/ext4
Date: Tue,  1 Apr 2025 18:52:52 +0200
Message-ID: <20250401165252.1124215-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately the other filesystems I checked make adjustments after
their own call to generic_fillattr() and consequently can't benefit.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- also patch vfs_getattr_nosec

There are weird slowdowns on fstat, this submission is a byproduct of
trying to straighten out the fast path.

Not benchmarked, but I did confirm the compiler jmps out to the routine
instead of emitting a call which is the right thing to do here.

that said I'm not going to argue, but I like to see this out of the way.

there are nasty things which need to be addressed separately

 fs/ext2/inode.c    | 3 +--
 fs/ext4/inode.c    | 3 +--
 fs/stat.c          | 6 +++++-
 include/linux/fs.h | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 30f8201c155f..cf1f89922207 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1629,8 +1629,7 @@ int ext2_getattr(struct mnt_idmap *idmap, const struct path *path,
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
 
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	return 0;
+	return generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 }
 
 int ext2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1dc09ed5d403..3edd6e60dd9b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5687,8 +5687,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(idmap, request_mask, inode, stat);
-	return 0;
+	return generic_fillattr(idmap, request_mask, inode, stat);
 }
 
 int ext4_file_getattr(struct mnt_idmap *idmap,
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..581a95376e70 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -78,8 +78,11 @@ EXPORT_SYMBOL(fill_mg_cmtime);
  * take care to map the inode according to @idmap before filling in the
  * uid and gid filds. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
+ *
+ * The routine always succeeds. We make it return a value so that consumers can
+ * tail-call it.
  */
-void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
+int generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		      struct inode *inode, struct kstat *stat)
 {
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
@@ -110,6 +113,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		stat->change_cookie = inode_query_iversion(inode);
 	}
 
+	return 0;
 }
 EXPORT_SYMBOL(generic_fillattr);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..754893d8d2a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3471,7 +3471,7 @@ extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
-void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
+int generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-- 
2.43.0

 fs/ext2/inode.c    | 3 +--
 fs/ext4/inode.c    | 3 +--
 fs/stat.c          | 9 ++++++---
 include/linux/fs.h | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 30f8201c155f..cf1f89922207 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1629,8 +1629,7 @@ int ext2_getattr(struct mnt_idmap *idmap, const struct path *path,
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
 
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	return 0;
+	return generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 }
 
 int ext2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1dc09ed5d403..3edd6e60dd9b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5687,8 +5687,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(idmap, request_mask, inode, stat);
-	return 0;
+	return generic_fillattr(idmap, request_mask, inode, stat);
 }
 
 int ext4_file_getattr(struct mnt_idmap *idmap,
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..7d390bcd74ab 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -78,8 +78,11 @@ EXPORT_SYMBOL(fill_mg_cmtime);
  * take care to map the inode according to @idmap before filling in the
  * uid and gid filds. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
+ *
+ * The routine always succeeds. We make it return a value so that consumers can
+ * tail-call it.
  */
-void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
+int generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		      struct inode *inode, struct kstat *stat)
 {
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
@@ -110,6 +113,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		stat->change_cookie = inode_query_iversion(inode);
 	}
 
+	return 0;
 }
 EXPORT_SYMBOL(generic_fillattr);
 
@@ -209,8 +213,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 					    request_mask,
 					    query_flags);
 
-	generic_fillattr(idmap, request_mask, inode, stat);
-	return 0;
+	return generic_fillattr(idmap, request_mask, inode, stat);
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..754893d8d2a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3471,7 +3471,7 @@ extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
-void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
+int generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-- 
2.43.0


