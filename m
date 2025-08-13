Return-Path: <linux-fsdevel+bounces-57800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1851B256A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B58A9A2BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A902F0C66;
	Wed, 13 Aug 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLGoIjGq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4D2E92D5
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124538; cv=none; b=sJr62xEkM9vMnGVoFSp0Kh0Zj9K+7Mb2v0GKxovVd8Psb2RbTuGGgrrzLd+kgdJDirHsiXsWmOcQ5ke1NV7ICWK1nrGPQrVZBSSe4Gf2UjLgcm3qf+RuJSqRy40Ar0fSuIef8S57R3uXAyw33s76ETKm/gtLevudzztJhcdOrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124538; c=relaxed/simple;
	bh=/fP3V0Xvv9XQO6KAXkBeYIUJq6GrwxclhJF37tK/PXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqgPPL9AzB3EPzf9scATfMOn0+sPxjFdDvVK3LUtmMMPcMGdLOeKm56RvKaVwYhcMgNQnYVCL3yu3LDvaz8+dLu+VTtl8jYg1+KhqIXvxcfi+aZltQCz6ASXMF2qmptuuQ0kYALpyRFvHftIDuRKoVDwOtq1kt1Q6SAIBFeaygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLGoIjGq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323266d38c2so541537a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755124536; x=1755729336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD0TvCX2OXUfTDwjZvoV+/LdtASxsdmn9NLkiHFv0kw=;
        b=jLGoIjGqTwHl/MSs8O/mn7W82iANz6OniCGfjWIkZOgEgwwIpoCvzNe6t+8t7a0pg6
         SMjMhAYkPknmdmnLez1BMTxzrVTMSZJD3hL9zNZF8FyScBDAsgqxGdam+8tLaax4/b8o
         U/XagNcBjGmgQKnb75e25aWGEcJd5TLY4IKSFhh096uNWWvIwONwfFfZgCDk8vI1J/mw
         hEwQ7kY218XdzEVxFrVaCrKL+2wnC4Na5rW1cS9IsLLHLfSnIlF8bV74aUg7sAXKehAX
         7yGWptlFtp2dglbl/2qaT4RquW+D4IJi9YNBcrrsZE8nNhivdAlCAY7JuOsSGbU0r+UA
         c4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755124536; x=1755729336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD0TvCX2OXUfTDwjZvoV+/LdtASxsdmn9NLkiHFv0kw=;
        b=dACiSArLNgs5gjlw024IS6neFW4iXx1botxby7qmZC/qlygCJ2um0DavR2oFkmtLq1
         +QnRUNX380syA5OnDEZMzUAG1FBpR4ng4MqyZuHkVgi0mp8xkvlZHF6EuA9AwIk0yfOt
         PNFeXdpPnTZcu9UNQ0ztPKKbGnHH4RZzRWUoqnMv8GzCxt9tZYoqxcWPlKHyu6JbPQeZ
         FRdEC7esjLrezGH8RaE9+IRsP1V3bOxVR1qlF3lTUpG2whwvqDf8ou/dtI/+xM8HfvAr
         WCvVl111beEnr2p08dbBdGCyEGbBjKIq67RD9pPivbRDEmG8th3HtMdSPh6p+PbD60cm
         +RCg==
X-Forwarded-Encrypted: i=1; AJvYcCWt6ADKdzxkDa9Z2JsC/bT0Lm5mztHfxj8oh5TVd8t6kE4oR4xDiN3ZdYrc1G2ZAEGfki+pDvvMD1d4UxiY@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+qlxjwSge6A17YLfhPX8TARCj9GrxinPyIdD0jcXBr+9JkiO
	OLeu8QaokUBFLvmH01pPtUXqXKLRHuEuhTcXkAj+5EZ42Gg9A3scj8q6
X-Gm-Gg: ASbGncv0Oqg5o0s+TJfhxHaGGzjFm9a9KWWFyyDI0nfpWptorLefVdDEmlLvnozXK1+
	pKBzGYU8we8dqpcaHk3rO7Z69EZD0Tzx6YasBmmopmL/cs6tTI0HRPya9NJssIGSLEi3sT29J7a
	yM+GHoQY6YcDAU6xoZTzy9OJ0PvFoB3Dha6XyVcrWos/dEbgWdkdIJyOhD20eK/8SyOsY/rssVN
	g866W4pClhKDhm0dQW1aB0Wc0XoTwgL3cSSvenJ4Zu1FdMc9NVSW8mno/sjDj+pECl1kEo7wo/k
	wyl4JMO052fCj51KagtuyYLOmuW6UNzW89eJ/5F4IYPa3BGg3TsKvtbmCsepp7mUrgzQkX9QeBO
	7V3dhxD27pXu6XzkJnQ==
X-Google-Smtp-Source: AGHT+IE0KAv7g10PfNlmAILd9VL+osRxk0aMCMtNqTyGUdqx2BvyrEyL3kICEQsIBYQO0+Kis2xxbg==
X-Received: by 2002:a17:90b:3dc7:b0:31e:c630:ec93 with SMTP id 98e67ed59e1d1-32327a4e18cmr1504456a91.16.1755124535964;
        Wed, 13 Aug 2025 15:35:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325763419sm1095954a91.9.2025.08.13.15.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:35:35 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 2/2] fuse: fix fuseblk i_blkbits for iomap partial writes
Date: Wed, 13 Aug 2025 15:35:21 -0700
Message-ID: <20250813223521.734817-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813223521.734817-1-joannelkoong@gmail.com>
References: <20250813223521.734817-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT which means
any iomap partial writes will mark the entire folio as uptodate. However
fuseblk filesystems work differently and allow the blocksize to be less
than the page size. As such, this may lead to data corruption if fuseblk
sets its blocksize to less than the page size, uses the writeback cache,
and does a partial write, then a read and the read happens before the
write has undergone writeback, since the folio will not be marked
uptodate from the partial write so the read will read in the entire
folio from disk, which will overwrite the partial write.

The long-term solution for this, which will also be needed for fuse to
enable large folios with the writeback cache on, is to have fuse also
use iomap for folio reads, but until that is done, the cleanest
workaround is to use the page size for fuseblk's internal kernel inode
blksize/blkbits values while maintaining current behavior for stat().

This was verified using ntfs-3g:
$ sudo mkfs.ntfs -f -c 512 /dev/vdd1
$ sudo ntfs-3g /dev/vdd1 ~/fuseblk
$ stat ~/fuseblk/hi.txt
IO Block: 512

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: a4c9ab1d4975 ("fuse: use iomap for buffered writes")
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h |  8 ++++++++
 fs/fuse/inode.c  | 13 ++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ebee7e0b1cd3..5c569c3cb53f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = inode->i_sb->s_blocksize_bits;
+		blkbits = fc->blkbits;
 
 	stat->blksize = 1 << blkbits;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index db44d05c8d02..a6aa16422c30 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -975,6 +975,14 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
+
+	/*
+	 * This is a workaround until fuse uses iomap for reads.
+	 * For fuseblk servers, this represents the blocksize passed in at
+	 * mount time and for regular fuse servers, this is equivalent to
+	 * inode->i_blkbits.
+	 */
+	unsigned char blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3bfd83469d9f..7ddfd2b3cc9c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize)
 		fi->cached_i_blkbits = ilog2(attr->blksize);
 	else
-		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
+		fi->cached_i_blkbits = fc->blkbits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -1810,10 +1810,21 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
+		/*
+		 * This is a workaround until fuse hooks into iomap for reads.
+		 * Use PAGE_SIZE for the blocksize else if the writeback cache
+		 * is enabled, buffered writes go through iomap and a read may
+		 * overwrite partially written data if blocksize < PAGE_SIZE
+		 */
+		fc->blkbits = sb->s_blocksize_bits;
+		if (ctx->blksize != PAGE_SIZE &&
+		    !sb_set_blocksize(sb, PAGE_SIZE))
+			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
+		fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	sb->s_subtype = ctx->subtype;
-- 
2.47.3


