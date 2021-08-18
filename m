Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568CB3F05CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbhHROLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHROLL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:11:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD0C061764;
        Wed, 18 Aug 2021 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xF37HHtJ9cCyf/tD4T3D2NA1Hm2ffytUKSp7nde/n7w=; b=h+NlzP2kBp6K9ActIGzJh8bm2k
        kYmcKNHroU3KyqP11rWLE/BCZqKWE+OcAmdszJ0q15QKN2pKxomWbQBihuxshlMKYZc2TpzY5V9B2
        qQU1e5HUaE6/y5kRj85z+QBLO/TOPFKLrazdp193mD3tFKh3NtItHTuaWQDHlIY9lOpJSKddf8SfD
        LbM4z2nIJ5weULEH+wyHBEnFwpy5CnASoEvLzYsA8J0xZFThSUXfaAH60IQ+bUe0/6XFV/eZFeNud
        tqqnpthQDt74bWvI83WdKTiw+ohwqwJqqEP0b8cutE71m+58/Mn3Umgwa04lALjYpTl5VF+sOe8W4
        glrPutdA==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMG0-003uPq-K8; Wed, 18 Aug 2021 14:09:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 02/11] f2fs: simplify f2fs_sb_read_encoding
Date:   Wed, 18 Aug 2021 16:06:42 +0200
Message-Id: <20210818140651.17181-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return the encoding table as the return value instead of as an argument,
and don't bother with the encoding flags as the caller can handle that
trivially.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/super.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fecd3050ccd..af63ae009582 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -260,24 +260,17 @@ static const struct f2fs_sb_encodings {
 	{F2FS_ENC_UTF8_12_1, "utf8", "12.1.0"},
 };
 
-static int f2fs_sb_read_encoding(const struct f2fs_super_block *sb,
-				 const struct f2fs_sb_encodings **encoding,
-				 __u16 *flags)
+static const struct f2fs_sb_encodings *
+f2fs_sb_read_encoding(const struct f2fs_super_block *sb)
 {
 	__u16 magic = le16_to_cpu(sb->s_encoding);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(f2fs_sb_encoding_map); i++)
 		if (magic == f2fs_sb_encoding_map[i].magic)
-			break;
-
-	if (i >= ARRAY_SIZE(f2fs_sb_encoding_map))
-		return -EINVAL;
+			return &f2fs_sb_encoding_map[i];
 
-	*encoding = &f2fs_sb_encoding_map[i];
-	*flags = le16_to_cpu(sb->s_encoding_flags);
-
-	return 0;
+	return NULL;
 }
 
 struct kmem_cache *f2fs_cf_name_slab;
@@ -3730,13 +3723,14 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
 
-		if (f2fs_sb_read_encoding(sbi->raw_super, &encoding_info,
-					  &encoding_flags)) {
+		encoding_info = f2fs_sb_read_encoding(sbi->raw_super);
+		if (!encoding_info) {
 			f2fs_err(sbi,
 				 "Encoding requested by superblock is unknown");
 			return -EINVAL;
 		}
 
+		encoding_flags = le16_to_cpu(sbi->raw_super->s_encoding_flags);
 		encoding = utf8_load(encoding_info->version);
 		if (IS_ERR(encoding)) {
 			f2fs_err(sbi,
-- 
2.30.2

