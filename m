Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC03CB8D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbhGPOni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 10:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232988AbhGPOni (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:43:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC271613F5;
        Fri, 16 Jul 2021 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446443;
        bh=88spGNyluutPzDN0JI8idu1yC06Iuwa4Jxi/++a9CYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8doAhLjAan/i8YFRaUfyiowMTh/rN3RihH5HgMt25tD4ewCuPx0CuABVSX22g4VJ
         xH1aGdrzb7tpAC71QjMxpUiC9Z0G6SOihgzj4tX/F+EOMZTdGTOXRf1grUNEJEgfIj
         7dSRGWHqC/qELlDVN9pxOynwhqQCMgVZtaihiF/5b/6BbbGfjz2571fBIUbp70yH8N
         1LKcSJt4RB7Y9wioN85kJZ8tAgMKHTgFRf9byyKCLcnlpp3S3q245wplxyJGAQR5Lq
         qKIcgfBOHQs7pRiQe6HCVw8dp2Hg+JnwxuDNbEzM2hPHDbwgxOIMhpgcTGZGdnwTPg
         5vGFchRbPDU+w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 1/9] f2fs: make f2fs_write_failed() take struct inode
Date:   Fri, 16 Jul 2021 09:39:11 -0500
Message-Id: <20210716143919.44373-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716143919.44373-1-ebiggers@kernel.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make f2fs_write_failed() take a 'struct inode' directly rather than a
'struct address_space', as this simplifies it slightly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d2cf48c5a2e4..c478964a5695 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3176,9 +3176,8 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 			FS_CP_DATA_IO : FS_DATA_IO);
 }
 
-static void f2fs_write_failed(struct address_space *mapping, loff_t to)
+static void f2fs_write_failed(struct inode *inode, loff_t to)
 {
-	struct inode *inode = mapping->host;
 	loff_t i_size = i_size_read(inode);
 
 	if (IS_NOQUOTA(inode))
@@ -3410,7 +3409,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 fail:
 	f2fs_put_page(page, 1);
-	f2fs_write_failed(mapping, pos + len);
+	f2fs_write_failed(inode, pos + len);
 	if (drop_atomic)
 		f2fs_drop_inmem_pages_all(sbi, false);
 	return err;
@@ -3600,7 +3599,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
 						count - iov_iter_count(iter));
 		} else if (err < 0) {
-			f2fs_write_failed(mapping, offset + count);
+			f2fs_write_failed(inode, offset + count);
 		}
 	} else {
 		if (err > 0)
-- 
2.32.0

