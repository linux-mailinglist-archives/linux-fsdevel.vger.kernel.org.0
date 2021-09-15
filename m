Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAE540C000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhIOHDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhIOHDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:03:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE98C061574;
        Wed, 15 Sep 2021 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BkB2SpdezulujHBf3WGhiV0+MkMtRlb+AsprXrCWmm8=; b=CEhy2KIoeV8zhbWw1mDQI8WkVj
        CLnhwX3BIb339QkhSMZ9AmSm9Hkn5xabmVdK1kd5SdjcNHrGujJtM3g1lpzHY+NY9mzHhcyeFoaaH
        hijYksPxsw336/qLWjnYBYVQRwMdHfraDnoi/utI17oE6OsiZWm6bB4hIdOkH9871U1e0r4aHJeHk
        7pzBnpB9XzmJlX4PDcY0xnm5VYhQPRWm8AfEeFyeT7hi17Rgs93CsruOtbDPxs1BCk3lyRg8nxIvT
        ekiab8MaiFlItSV/aLpeIfOHPvaH3bWtDW3nDvkatE93WEDenz2GOQWxIuHC2WiGlcXv1EBzxY+E5
        AsElWuFQ==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOv7-00FRW5-DA; Wed, 15 Sep 2021 07:01:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
Subject: [PATCH 02/11] f2fs: simplify f2fs_sb_read_encoding
Date:   Wed, 15 Sep 2021 08:59:57 +0200
Message-Id: <20210915070006.954653-3-hch@lst.de>
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
Reviewed-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78ebc306ee2b5..4c457100f18ea 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -264,24 +264,17 @@ static const struct f2fs_sb_encodings {
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
@@ -3843,13 +3836,14 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
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

