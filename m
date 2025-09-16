Return-Path: <linux-fsdevel+bounces-61854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7558B7EBC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516E83B3BD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939F2F5301;
	Tue, 16 Sep 2025 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScP8nlNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619352F49FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066652; cv=none; b=XkyCDwioEnV3mLUVgk9D3jxWDXgbpSFZiU/SvNhiII7FXCBMXcpjbH/ZItWqdIGPgztTr3w6BblcGbqS/urzfnhILBE2NyNzofC7ZCwykJA4Lr7JbXRgWXcfkvIe/QzFwTpS8adlpRLSThDAIXrT6oStxzZYM25RQAtxWok5Ezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066652; c=relaxed/simple;
	bh=X5VeKxCOzUEl3wsEDYiMdyGsEejRLZ63bJIX2+ITwds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON+Am+r1hh/LAxCSxnpic7y78Ks8TtQ4TRXWE9kDjonag9Ure6yexPYEMewWhkFMiWUMeqvav12bt0DapLxGt49EA8J0VD/6vv4nTaqeb4ViuRW9t/ZuInR/GW0gHJwXzg/p5DqHsgf39idVPyB1Rn9+CRlgyhh6JZAx6uyLn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScP8nlNS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so5182608a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066650; x=1758671450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zQULdjLrk3RHQ78+SXdGM3zZbqfDbjmRNccIhvDiRQ=;
        b=ScP8nlNS1QqvGsHjbF3ELhWgU3Vvpq1S37+8QLfIV3oHwSYAPUXzM96TfDFJLIJYFr
         t/Fa/nuw4cxS7jcShT4PuT8a2nTNs7RIx91pYu3cYsd0xYx7QkQFDyjComfLb1rTlx0+
         4tHSueOm59KHnScsGF7PVth/zVceXA/gSjkRACBTBiqUQ7JaXZDdTf/hV4azKp1bWqq7
         t/iWiuFCWk9DU6uTtRYNqEE+M75W7SeJWey66vA1S+kfgRgQta6FCNb59KP1TA5lvWJS
         yqKvY85oPQx7IGZ3RTe1cq2vae5xjhN5TJk7IULV6uEvCc/8PfBbU0xZtpzWOdt74ytB
         HI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066650; x=1758671450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zQULdjLrk3RHQ78+SXdGM3zZbqfDbjmRNccIhvDiRQ=;
        b=ky7UyzA/IKbHlJ6GMxg4KHf66hFqMTwWxI7hIkOBUdv07jHMawcQqxnuxnut+6rkdy
         DD+e0H2J9Hx+q/+SuYsneOTHoniz9kbv/cc2oL1zlrN0sqzlhlZFmeOakS7S35US/5sd
         mI896XOusy85ffETtiTF4EJwQhG5Q73b8BwYh+7L2bG1Ro51BRJdsrV01Hck3Kbb5APD
         Bae75N0htUgccbIZr62hSadb/ealkyS+C7yYippp4PN3VfuZVwnVe7N6NLbZ6jypz/hM
         Be+MCHiBwlufVoOfbJtBv938LWZVaKCdbeh7kyd/4eK1ClJeRp2Riz86FpN21HEABvKw
         XQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHElKZuwg8ZHUCt+77HIiVHmnBhnuPYzaZC2F1udEaPYanr8sY7JLP3OLpZjBn0md9BoXdFV35YqiwsBxz@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLFcDiyrezZb34cu8H5FtPXSktUx226aL6XNHVaVV8ZBnsXrd
	2jQO69NLbpJHVGCmBvONKsIiCOBEDdATgp14hFbI2OH9RzTWJMjrWXUh
X-Gm-Gg: ASbGnctA8DH9OwRWp4Tx7UBjEiKBEXSnA0IX4hDsznpW19FmD7/iSzuSu39EmOCUAQo
	JT1NePO/xb2nrvhHj9Y3u98/1TvGK1idc5lUDYwTLzJIo/9p1n6cQfT/CM74lJ0EEVKPO5QJSl1
	oMwPUB6iL9M8HUs5o+O04Aq2/w47iXme49uqGYH5tC/OWWz2w4xfvImzgQwGuTBtYVymZ8nrV4y
	OEZaAujC8gQikbwhMus2O6hVkq/0kuDqs37ycwzsx6IViZtVFf1vUiacUMsWQwYltM4mSlQdBR8
	g55UotQ0UYyXtCbHVZlye1GSCQbAqV/cOwQh2ZFLuPd8LAKILfykK2hz39Rqu1peNwnOiYYovg5
	NVQPVT2gjO6c3jaYGn+ybZNMkUmyLKui6eC1Q+fXO6TfKC7Uk0wlLP2VBi9KBuKxrRS5Myo6y6t
	bySw==
X-Google-Smtp-Source: AGHT+IF3/Qq+e6C8ki6sfdZo/ufgl6Uw/vgFAFRQyV5O6PlrdhNwHnRCfnw8PwqYcBwvdrnS//+vpA==
X-Received: by 2002:a17:90b:4c4c:b0:32e:7270:94b5 with SMTP id 98e67ed59e1d1-32ee3f141e1mr189294a91.23.1758066649702;
        Tue, 16 Sep 2025 16:50:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea3c6fefdsm1695880a91.3.2025.09.16.16.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:49 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial writes
Date: Tue, 16 Sep 2025 16:44:25 -0700
Message-ID: <20250916234425.1274735-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fuse is integrated with iomap for read/readahead, we can remove
the workaround that was added in commit bd24d2108e9c ("fuse: fix fuseblk
i_blkbits for iomap partial writes"), which was previously needed to
avoid a race condition where an iomap partial write may be overwritten
by a read if blocksize < PAGE_SIZE. Now that fuse does iomap
read/readahead, this is protected against since there is granular
uptodate tracking of blocks, which means this workaround can be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h |  8 --------
 fs/fuse/inode.c  | 13 +------------
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..ebee7e0b1cd3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = fc->blkbits;
+		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cc428d04be3e..1647eb7ca6fa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -975,14 +975,6 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
-
-	/*
-	 * This is a workaround until fuse uses iomap for reads.
-	 * For fuseblk servers, this represents the blocksize passed in at
-	 * mount time and for regular fuse servers, this is equivalent to
-	 * inode->i_blkbits.
-	 */
-	u8 blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fdecd5a90dee..5899a47faaef 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize)
 		fi->cached_i_blkbits = ilog2(attr->blksize);
 	else
-		fi->cached_i_blkbits = fc->blkbits;
+		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -1810,21 +1810,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
-		/*
-		 * This is a workaround until fuse hooks into iomap for reads.
-		 * Use PAGE_SIZE for the blocksize else if the writeback cache
-		 * is enabled, buffered writes go through iomap and a read may
-		 * overwrite partially written data if blocksize < PAGE_SIZE
-		 */
-		fc->blkbits = sb->s_blocksize_bits;
-		if (ctx->blksize != PAGE_SIZE &&
-		    !sb_set_blocksize(sb, PAGE_SIZE))
-			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
-		fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	sb->s_subtype = ctx->subtype;
-- 
2.47.3


