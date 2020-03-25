Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20FE192849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 13:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCYM2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 08:28:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgCYM2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=odzXVZYmd7lUAGEV7AWVw3TgYy4WB3IJY3Y6KA2lMSU=; b=Yau3b5kUjjBG9f4qwQn0pzufd1
        5Zqvc3ruUYCUg8fOAmMK1lAqY2FE/xezNNbjcgBdf+Q4WK1z7s09av07BATn0HCqwWzvJ926BtomF
        80x9nayMW2gMMEjFA5l/P3/rolns3pyvUCNhm4A0qCNkKdZNTZC442m13HrvOW+Jj+tCoSb2MMNPP
        mGc2f7OkhQyID4UzfAqqpl1UsJ7NdSe4B3GR16ej9d9bUu/Vvy0Scl6Htq6owDnm5Qne5FaOwbuB/
        btD5fblL0m9GlHCnv/EJWTtSUUaTMZnuhLEiFglECgdgUGHb7AqrK6b89uFK5i6p98VkKp29roHyd
        JqoCkGog==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH593-0003GS-NL; Wed, 25 Mar 2020 12:28:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ubifs: remove broken lazytime support
Date:   Wed, 25 Mar 2020 13:28:22 +0100
Message-Id: <20200325122825.1086872-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325122825.1086872-1-hch@lst.de>
References: <20200325122825.1086872-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When "ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs" introduces atime
support to ubifs, it also lazytime support, but that support is
terminally broken, as it causes mark_inode_dirty_sync to be called from
__writeback_single_inode, which will then trigger the locking assert
in ubifs_dirty_inode.  Just remove this broken support for now, it can
be readded later, especially as some infrastructure changes should
make that easier soon.

Fixes: 8c1c5f263833 ("ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ubifs/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 743928efffc1..49fe062ce45e 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1375,7 +1375,6 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
 			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
-	int iflags = I_DIRTY_TIME;
 	int err, release;
 
 	if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
@@ -1393,11 +1392,8 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 
-	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
-		iflags |= I_DIRTY_SYNC;
-
 	release = ui->dirty;
-	__mark_inode_dirty(inode, iflags);
+	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 	mutex_unlock(&ui->ui_mutex);
 	if (release)
 		ubifs_release_budget(c, &req);
-- 
2.25.1

