Return-Path: <linux-fsdevel+bounces-56690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BFAB1AA4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 23:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B59D1624A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411CA23AE9B;
	Mon,  4 Aug 2025 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8XxtCfS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E07238159
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754341847; cv=none; b=TyVeLXUbDdIGqq1sPg56/v41Ri7T8KDNRf8udbq3VylVlqSgXqbDI8ZkJtzrSICZZTiHOaPs52tPPWoJEbtufA/9pLycNK9m67r8Xz4h52UMagveriNqM0SfVoGYYcY53fgau5YCI73WsESZYfGM/2HeVK+oTUntBNBNbLBUYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754341847; c=relaxed/simple;
	bh=PChoEdmh+pl/HWX0fwA6qQV9RqEwSlDXRnuQXOkYAOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxSd30uG8O4aPC9A/mGrG8flITnRrUlIq5Z2nxECyCfGsweZS3fthPtoS2D8DzlEOrVVqziH6dsnNXxOsHcvRdGlHKmKVD7z6Nz0rc8WhsGNq1RjidWU5A0jk0wnKisShJTsW7urUIa4KCv1/fRzJzcpc4zZckb6X8apUPATH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8XxtCfS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23aeac7d77aso42921025ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754341845; x=1754946645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q/wH5sn8GsZjPrexvWiAEbhmjZevmbQCPYDU3/UWsU=;
        b=D8XxtCfS7KGYK4uXJwGvvdCOGRR5nNTITxTJGQm0nb383iVcWiQpioDPdta1cAQ3YR
         Evl3/JC7QbXlR6OwR8Fz9w03R9mPHzjg1UpPgGMUNhMZSQqQJ4HIyiNLB5UjIPqS7TbG
         cH3ci4WOxNf2ULjniaJAERgZhXwxVo5670bZjiNiBC3Pbph+bSonrmEYx/Sf5rMz3hPC
         K69ZeHpaNOwFi8xAzh0dSsTaF/kCIYSwPBgQpUkkUkhIAMnZbR/tltIkwRZjILfJXxLB
         Xim7uyYEmMPvBEi+t7mSOGtoi2dogx5Sx7qOMES2WoRpu1Cv9U4jITwBdpFA1QuvKWZR
         lGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754341845; x=1754946645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q/wH5sn8GsZjPrexvWiAEbhmjZevmbQCPYDU3/UWsU=;
        b=psdLWJWqspTA+08tt7717xvuSIBtrFmS8CRBhm+NbAZzIeoUO7nlX3ECZbO8vT8bCV
         yaRmWQkazG/BtzfAGN3hFwsAXnTXnC1pjpeXrKmIan1+ihwii546r4uaqDDsnuEiAbG3
         6ghrsarZl6evcj2PYtInCDl4A3wh0Y8k15OeSRrUAnRVSah7FWVtN5qii5VCnYcd8eT8
         HxfaoPEEpOvfW2Du88c7KSbFgfsPOegeMJK0B5BFCUjvat6aDIt/542Mjer2JW4Yj9tI
         tRYNlzgLJZNuVFNJExNjSx0XjvJMVlyzdY27eQNgrbnjSeS0eTLdtt13FRo1W6YTx4im
         PfgA==
X-Forwarded-Encrypted: i=1; AJvYcCWYoADuJ7u1CM8BaqTanalZeCAmJyNEAenLjMVDPZb5ZG4ci8G+mkYCC3HSciO8KXMG54idG5G91JNKPgmu@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhzMgVZ/Z1CixGrB9Ur/WvfI5bkuFZzeeZikPp2VdrzLSiADa
	MYa8lJz5iVwWseNzWKrxus/G5xaFLNxkfDXYWF8FnileRF912/klr84ywUu6sw==
X-Gm-Gg: ASbGncutFJLU8xGtm3812img7lIHOZBGyPNnGNgTOKtfI3tvMC/5KW30ka2VL6wjiE1
	ere/OP0kGd89Bkpxjasoti7NYYUxc5ln2W6i4RcDxCfA9Fym74cOgyn7aDOEzGm+Nz3XMVdHkxK
	4j64Fgq2RXe+t2Q6crUNj07/vIUyLoc35ImDwqp98uviVWrgoP8S6QS1v5i/sQHS2OsANSlm9w6
	5VXj73xG388hxy3FF7XGb9uIjCy3mWjKZsgzk9kJsaC/p4mnBIzpbbpjaqy4HBtr2HjIuJr0cTV
	hjJqKVUac6tCeevNZ0JqIr1Cau/wPBuHXYlaH/0SNxviSiZTa4XSxEE9Cs7sYGuwTnzLKiK0JSA
	emfjKJqG9yBF9cKwSjhLifcJVJxU=
X-Google-Smtp-Source: AGHT+IF20LzjnxAiyF1ktsxzw7BWFd3pV5p40Kq/r9++2M0jqh5RGDLLs4o6Vzy5tERHnTpGI7BRwA==
X-Received: by 2002:a17:902:f252:b0:23f:ed09:f7b with SMTP id d9443c01a7336-24247063df9mr91315675ad.48.1754341845408;
        Mon, 04 Aug 2025 14:10:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e828sm117301305ad.44.2025.08.04.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:10:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 1/2] fuse: disallow dynamic inode blksize changes
Date: Mon,  4 Aug 2025 14:07:42 -0700
Message-ID: <20250804210743.1239373-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250804210743.1239373-1-joannelkoong@gmail.com>
References: <20250804210743.1239373-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fuse using iomap, which relies on inode->i_blkbits for its internal
bitmap tracking, disallow fuse servers from dynamically changing the
inode blocksize.

"attr->blksize = sx->blksize;" is retained in fuse_statx_to_attr() so
that any attempts by the server to change the blksize through the statx
reply is surfaced to dmesg.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: ef7e7cbb32 ("fuse: use iomap for writeback")
---
 fs/fuse/dir.c             | 9 +--------
 fs/fuse/inode.c           | 6 ++----
 include/uapi/linux/fuse.h | 4 ++--
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 45b4c3cc1396..df8fda289c5f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1180,7 +1180,6 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 			  struct fuse_attr *attr, struct kstat *stat)
 {
-	unsigned int blkbits;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	vfsuid_t vfsuid = make_vfsuid(idmap, fc->user_ns,
 				      make_kuid(fc->user_ns, attr->uid));
@@ -1202,13 +1201,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	stat->ctime.tv_nsec = attr->ctimensec;
 	stat->size = attr->size;
 	stat->blocks = attr->blocks;
-
-	if (attr->blksize != 0)
-		blkbits = ilog2(attr->blksize);
-	else
-		blkbits = inode->i_sb->s_blocksize_bits;
-
-	stat->blksize = 1 << blkbits;
+	stat->blksize = 1 << inode->i_sb->s_blocksize_bits;
 }
 
 static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..280896d4fd44 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -285,10 +285,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		}
 	}
 
-	if (attr->blksize != 0)
-		inode->i_blkbits = ilog2(attr->blksize);
-	else
-		inode->i_blkbits = inode->i_sb->s_blocksize_bits;
+	if (attr->blksize && attr->blksize != inode->i_sb->s_blocksize)
+		pr_warn_ratelimited("changing blksize attribute is a no-op\n");
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 122d6586e8d4..4ceb6f736f4e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -293,7 +293,7 @@ struct fuse_attr {
 	uint32_t	uid;
 	uint32_t	gid;
 	uint32_t	rdev;
-	uint32_t	blksize;
+	uint32_t	blksize; /* not used */
 	uint32_t	flags;
 };
 
@@ -309,7 +309,7 @@ struct fuse_sx_time {
 
 struct fuse_statx {
 	uint32_t	mask;
-	uint32_t	blksize;
+	uint32_t	blksize; /* not used */
 	uint64_t	attributes;
 	uint32_t	nlink;
 	uint32_t	uid;
-- 
2.47.3


