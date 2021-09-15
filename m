Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3808B40BFFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhIOHCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhIOHCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:02:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49AC061574;
        Wed, 15 Sep 2021 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nsp5N75MotLePoJobS9ZhodRN6ezBtzkmBOnAPp7UHg=; b=koHYfJhi0kCowMyVCGjauAU5cB
        3Ya1uhzNq+8fHnDU/raPWU0wmVfgHzoC6THMGYOBkO96qnQGi9yTzT57Ls/mvBXhiqQTiwez8wfI4
        8sd0GsVp4XWh1ty9nUoHP4WBDryS6Z5f5oJm6hFd+iaXN4ZrRJQ0bRc+lF0mHENbDTp2PZOVB46N0
        Fj1HO7Y9OSCdUAjsWmNNSmyd33jmrcWa5CSQNnVvMMCBVv3W0uDjemvCwo4apSHF6kvSTqwLPZIva
        OGxBz/xUj2zd6kZA57Sve/gjjs5eUN59hAUdUv86QiKVhkUy5NbgilN7pklHgP9Lb6gvRmn0sAzuY
        m9pATu7Q==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOuO-00FRV2-G5; Wed, 15 Sep 2021 07:00:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 01/11] ext4: simplify ext4_sb_read_encoding
Date:   Wed, 15 Sep 2021 08:59:56 +0200
Message-Id: <20210915070006.954653-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
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
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0775950ee84e3..7401a181878e5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2017,24 +2017,17 @@ static const struct ext4_sb_encodings {
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
 
@@ -4155,10 +4148,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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

