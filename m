Return-Path: <linux-fsdevel+bounces-45830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80082A7D139
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 01:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA353AEB38
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 23:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968822156F;
	Sun,  6 Apr 2025 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOjFwYyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FA41C7F;
	Sun,  6 Apr 2025 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743983908; cv=none; b=hpgP3bi3GywpXtdWhRsEb3LUfj4pOMbGjW2KHF897ltgyJDGfflarBy6uVYzE92wtDJgAgF3n+qCFeD8kYUQWXM60jRTpJ8qJTWqH9sJcNf6De2gKBL412KaB9Gk3UMO4ahHRxvudhVLpv6kkxcZaby4K0L4+GTzdEXcaD4ZFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743983908; c=relaxed/simple;
	bh=W2jmKWzJGnbKNZIqQNJFnaayUminjQgTtWYQc2Mgw/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moYFXjh0wvBdYggRb77dWPgP4mgm99zK9rSx7Hu8yIYXQ55tsesRl2i6xEMRzPiSOSjXJL7hf6ZGt/PfgxjWJYBAPEGtTEzM7+/EDxP0TbTkH2Cc1O+vsT7MPUpOI3xbpj2wLojIPI57Zpiiz4QXc3smPoSvuPJBDhnWxistpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOjFwYyj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ede096d73so11412215e9.2;
        Sun, 06 Apr 2025 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743983905; x=1744588705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzO9PUwG/mJnRN5vlj585CDr1XkHbzIm2uTBqVpVdiI=;
        b=YOjFwYyj27NbkfCMVAqZGLkdojRXGqfZ1qHgQtIOM/1PanIAJvtzttFe/NBEKr8i4v
         4Y8+Ox2TeIs9ep+L64DLia+IonTZodKaf4y1z8pY06BW+vSLRbhLN5LPpqqyxhnA1LIk
         uN70qwWteCfzCtIZGYvIHOdyof90uMtIOKCf/AW2JVqyPfsAcXgdBPADickqoQXpYkYM
         86U1feYf5SG6mj4iTzV7YGTAyVvUiQDqmiD2goJ6miX3UhWKHyfgKIgGfGEqvvz59sSG
         aeaFsy4Cj7McYfzXSNybeihr/NwH5gx9waZNkLOP1JrZk90gsmghyMC+ApkTraHQXwwl
         8aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743983905; x=1744588705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzO9PUwG/mJnRN5vlj585CDr1XkHbzIm2uTBqVpVdiI=;
        b=fy6zmZVX9QcbJ7WN7Yd7Rgl5oYJ0Pcnb86k4LfUFCPmTwsKruEXC8wXR1iDWtqzHAm
         A7jIn33WgZMBpkpXtA/Ek7EE0Wa45awlnidW0Llc+lcYrYEFJx7HceCoBnCVDSH5pKUJ
         brFa4QlYKsw0mFJ9YsBeYhTuofv/kcK8MrqwTvNa2MoMkwSAORkpbTJed9cO4m2ha5hS
         dBCnXeaQYrKB6lZjcX9qgZT1zaTyvhaGrsdBKgQqStam8EhYEe+sShs1QCa8g5gv7Lgj
         l83myvcTpKPMk8ExmXk80GLVxkds+MiOBzxu/wDfkRdqQ2EPU2UqqVVFdA5Lno91l1Aq
         qtPw==
X-Forwarded-Encrypted: i=1; AJvYcCVmut0zCQQ5gjEJ9orfHXZlcMiSTtZg8Hb2d5tMsz784HafNQjptEXe00ME84EKCU63Y1kHaDld4G9HPcm/@vger.kernel.org, AJvYcCW9h4zziaVbbNIXWH6jP/MRqCYGVXy00aexE71o9Eer8PwVKQMVI+OM5RkpzwutNZNgoEolQf+6aO/DUKQy@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdUrAMHqDkXoqJqL8anzMUqIDhLjDUF5PRwqIKzqPe1gDinDz
	LtfbWwKXDy5B6QVfnEb4MeOaJ+W8vt0pLWUZCxYkB8gaW32FLuMU
X-Gm-Gg: ASbGnctg/5UsjOgw2msMUEJoXK0UMf5bul8jVkQwOOibpNTWpPbs2vhWnk6vY/Y7NYc
	SUf8Dx6BqrKrkPe1V9uHmuMuCOGm3ShkEh6aZ2ioBBcUkW572aVeKwiX5YLPQ6A5crNH4gozGm4
	V3NaxJ5bkerR1345CvzKGLWAm7ZuSRSwhxUl1jeohPqOEhS5L9UePsDXwLAD5NZmacVJThJNq0Q
	Jc7FTdUy0o9hLNr+NTJ2f0PZaHSVXlrb048FgXvo5yUCWrZgBZVTq9MJOm7NRh0mXsRqqNPsvyV
	ch8+zyYRANok/RiuKt6Z6ZVziixoGePNt6vlPOiJsPCvaWlBdlGSLiceHYxxro8=
X-Google-Smtp-Source: AGHT+IGjJsd83PcO9Qw7EQ+Ms2rzAgKFYb3RtBO8QMx7sP1uHKkNOgitX51Jn+B8zr0BZe9ajhKt5Q==
X-Received: by 2002:a05:600c:4513:b0:43c:fa3f:8e5d with SMTP id 5b1f17b1804b1-43ed0b5e246mr92697545e9.2.1743983904789;
        Sun, 06 Apr 2025 16:58:24 -0700 (PDT)
Received: from f.. (cst-prg-74-157.cust.vodafone.cz. [46.135.74.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096b9csm10576598f8f.13.2025.04.06.16.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 16:58:24 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 3/3 v3] fs: make generic_fillattr() tail-callable and utilize it in ext2/ext4
Date: Mon,  7 Apr 2025 01:58:06 +0200
Message-ID: <20250406235806.1637000-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250406235806.1637000-1-mjguzik@gmail.com>
References: <20250406235806.1637000-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately the other filesystems I checked make adjustments after
their own call to generic_fillattr() and consequently can't benefit.

This is a nop for unmodified consumers.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v3:
- clarify no callers *need* to change to accmodate this patch

v2:
- also patch vfs_getattr_nosec

There are weird slowdowns on fstat, this submission is a byproduct of
trying to straighten out the fast path.

Not benchmarked, but I did confirm the compiler jmps out to the routine
instead of emitting a call which is the right thing to do here.

that said I'm not going to argue, but I like to see this out of the way.

there are nasty things which need to be addressed separately

 fs/ext2/inode.c    |  3 +--
 fs/ext4/inode.c    |  3 +--
 fs/stat.c          | 10 +++++++---
 include/linux/fs.h |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

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
index b79ddb83914b..46e10af29f4b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -78,8 +78,12 @@ EXPORT_SYMBOL(fill_mg_cmtime);
  * take care to map the inode according to @idmap before filling in the
  * uid and gid filds. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
+ *
+ * The routine always succeeds (i.e., nobody needs to check its return value).
+ * We make it return 0 so that consumers can tail-call it at the end of their
+ * own getattr function.
  */
-void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
+int generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		      struct inode *inode, struct kstat *stat)
 {
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
@@ -110,6 +114,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		stat->change_cookie = inode_query_iversion(inode);
 	}
 
+	return 0;
 }
 EXPORT_SYMBOL(generic_fillattr);
 
@@ -209,8 +214,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
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


