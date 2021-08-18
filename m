Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856B73F05CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhHROKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhHROKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:10:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A94C061764;
        Wed, 18 Aug 2021 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cibSNcvbBNy3d99J0xcybasLYRaPm2YAac4xI0ywMu8=; b=dlWPccbA45UR38UUdOxp+hXJ6w
        k6xHpfeWjanPnLTGesnuRrC3bHSxpNX/PaH/BecYbfmTwtflh1+SKGdZcgHlwoOUWnfwS+QJEWLAJ
        2UgSTJSSgmxNuzobdkYK0nSL66Q8eB8PvsYAHQfv0aMC4zwVMQ1/CuOVNrOIfkeYz2TfGj5wGB3jV
        T+xRI+oCQZB+H+vTJw0TYgFzT4yy6pSb4ScX+H8xP5achbWhvZia0Zom9WSkg0NOnclkRFfaaGAXT
        MSOQPRxTqS4K6//RXhEwyAaeum4IKnrAYqqhdz5p0InvM23dKMsNFoXwhDrvd7WdAOelONE+lX613
        KEDaOecA==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMEZ-003uKw-LT; Wed, 18 Aug 2021 14:08:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 01/11] ext4: simplify ext4_sb_read_encoding
Date:   Wed, 18 Aug 2021 16:06:41 +0200
Message-Id: <20210818140651.17181-2-hch@lst.de>
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
 fs/ext4/super.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..a68be582bba5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2021,24 +2021,17 @@ static const struct ext4_sb_encodings {
 	{EXT4_ENC_UTF8_12_1, "utf8", "12.1.0"},
 };
 
-static int ext4_sb_read_encoding(const struct ext4_super_block *es,
-				 const struct ext4_sb_encodings **encoding,
-				 __u16 *flags)
+static const struct ext4_sb_encodings *
+ext4_sb_read_encoding(const struct ext4_super_block *es)
 {
 	__u16 magic = le16_to_cpu(es->s_encoding);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ext4_sb_encoding_map); i++)
 		if (magic == ext4_sb_encoding_map[i].magic)
-			break;
-
-	if (i >= ARRAY_SIZE(ext4_sb_encoding_map))
-		return -EINVAL;
+			return &ext4_sb_encoding_map[i];
 
-	*encoding = &ext4_sb_encoding_map[i];
-	*flags = le16_to_cpu(es->s_encoding_flags);
-
-	return 0;
+	return NULL;
 }
 #endif
 
@@ -4303,10 +4296,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (ext4_has_feature_casefold(sb) && !sb->s_encoding) {
 		const struct ext4_sb_encodings *encoding_info;
 		struct unicode_map *encoding;
-		__u16 encoding_flags;
+		__u16 encoding_flags = le16_to_cpu(es->s_encoding_flags);
 
-		if (ext4_sb_read_encoding(es, &encoding_info,
-					  &encoding_flags)) {
+		encoding_info = ext4_sb_read_encoding(es);
+		if (!encoding_info) {
 			ext4_msg(sb, KERN_ERR,
 				 "Encoding requested by superblock is unknown");
 			goto failed_mount;
-- 
2.30.2

