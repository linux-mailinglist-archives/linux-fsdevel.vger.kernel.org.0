Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF89D24E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfHZPJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 11:09:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:42356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729623AbfHZPJB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:09:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8EBC0AEF6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2019 15:08:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 49CD81E3DA1; Mon, 26 Aug 2019 17:08:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: Use dynamic debug infrastructure
Date:   Mon, 26 Aug 2019 17:08:53 +0200
Message-Id: <20190826150853.18160-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of relying on UDFFS_DEBUG define for debug printing, just use
standard pr_debug() prints and rely on CONFIG_DYNAMIC_DEBUG
infrastructure for enabling or disabling prints.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c   |  7 -------
 fs/udf/udfdecl.h | 10 +---------
 2 files changed, 1 insertion(+), 16 deletions(-)

Unless someone objects, I plan to merge this patch.

								Honza

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 00e2d7190b52..56da1e1680ea 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -812,9 +812,7 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 	struct buffer_head *bh;
 	uint16_t ident;
 	int ret = -ENOMEM;
-#ifdef UDFFS_DEBUG
 	struct timestamp *ts;
-#endif
 
 	outstr = kmalloc(128, GFP_NOFS);
 	if (!outstr)
@@ -835,13 +833,10 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 
 	udf_disk_stamp_to_time(&UDF_SB(sb)->s_record_time,
 			      pvoldesc->recordingDateAndTime);
-#ifdef UDFFS_DEBUG
 	ts = &pvoldesc->recordingDateAndTime;
 	udf_debug("recording time %04u/%02u/%02u %02u:%02u (%x)\n",
 		  le16_to_cpu(ts->year), ts->month, ts->day, ts->hour,
 		  ts->minute, le16_to_cpu(ts->typeAndTimezone));
-#endif
-
 
 	ret = udf_dstrCS0toChar(sb, outstr, 31, pvoldesc->volIdent, 32);
 	if (ret < 0) {
@@ -1256,9 +1251,7 @@ static int udf_load_partdesc(struct super_block *sb, sector_t block)
 	 * PHYSICAL partitions are already set up
 	 */
 	type1_idx = i;
-#ifdef UDFFS_DEBUG
 	map = NULL; /* supress 'maybe used uninitialized' warning */
-#endif
 	for (i = 0; i < sbi->s_partitions; i++) {
 		map = &sbi->s_partmaps[i];
 
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d89ef71887fc..65e243ebeb9c 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -31,16 +31,8 @@ extern __printf(3, 4) void _udf_warn(struct super_block *sb,
 #define udf_info(fmt, ...)					\
 	pr_info("INFO " fmt, ##__VA_ARGS__)
 
-#undef UDFFS_DEBUG
-
-#ifdef UDFFS_DEBUG
-#define udf_debug(fmt, ...)					\
-	printk(KERN_DEBUG pr_fmt("%s:%d:%s: " fmt),		\
-	       __FILE__, __LINE__, __func__, ##__VA_ARGS__)
-#else
 #define udf_debug(fmt, ...)					\
-	no_printk(fmt, ##__VA_ARGS__)
-#endif
+	pr_debug("%s:%d:%s: " fmt, __FILE__, __LINE__, __func__, ##__VA_ARGS__)
 
 #define udf_fixed_to_variable(x) ( ( ( (x) >> 5 ) * 39 ) + ( (x) & 0x0000001F ) )
 #define udf_variable_to_fixed(x) ( ( ( (x) / 39 ) << 5 ) + ( (x) % 39 ) )
-- 
2.16.4

