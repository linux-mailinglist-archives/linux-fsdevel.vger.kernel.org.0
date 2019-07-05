Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86F460C24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfGEUQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:16:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59856 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbfGEUQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:16:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C04938EE1F7;
        Fri,  5 Jul 2019 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357773;
        bh=hNezlm+tKjjepRRbkeWDFhPSjiQu4G01He97mHiT0ro=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=OQ06i1uWPuEJ5oLc9OUFAqyL/vWeAvkbOXkgB4UsEeLMLhvjia3HBUYwV3wKCQWzS
         evdBib1go28KInyz5hrneiPnoLjDhhPcZY79dJJlUT2Uk1Af5WL79ai4WsjMo5jFOL
         qaN4j0/JTGnn2ZwvnPgk1W+UeG380S6hmSb34itY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lpEWYRgZOQ7U; Fri,  5 Jul 2019 13:16:13 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5B9458EE0CF;
        Fri,  5 Jul 2019 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357773;
        bh=hNezlm+tKjjepRRbkeWDFhPSjiQu4G01He97mHiT0ro=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=OQ06i1uWPuEJ5oLc9OUFAqyL/vWeAvkbOXkgB4UsEeLMLhvjia3HBUYwV3wKCQWzS
         evdBib1go28KInyz5hrneiPnoLjDhhPcZY79dJJlUT2Uk1Af5WL79ai4WsjMo5jFOL
         qaN4j0/JTGnn2ZwvnPgk1W+UeG380S6hmSb34itY=
Message-ID: <1562357772.10899.7.camel@HansenPartnership.com>
Subject: [PATCH 2/4] iplboot: update the ext2_fs.h header
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Fri, 05 Jul 2019 13:16:12 -0700
In-Reply-To: <1562357231.10899.5.camel@HansenPartnership.com>
References: <1562357231.10899.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A lot has changed in libext2fs since this header was last imported,
but most of it is irrelevant to simply reading files from ext2/3, so
only import the additional changes absolutely necessary for reading
from an ext4 filesystem.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 ipl/ext2_fs.h | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/ipl/ext2_fs.h b/ipl/ext2_fs.h
index 2d1db8f..f104880 100644
--- a/ipl/ext2_fs.h
+++ b/ipl/ext2_fs.h
@@ -504,7 +504,7 @@ struct ext2_super_block {
 	__u32	s_hash_seed[4];		/* HTREE hash seed */
 	__u8	s_def_hash_version;	/* Default hash version to use */
 	__u8	s_jnl_backup_type; 	/* Default type of journal backup */
-	__u16	s_reserved_word_pad;
+	__u16	s_desc_size;
 	__u32	s_default_mount_opts;
 	__u32	s_first_meta_bg;	/* First metablock group */
 	__u32	s_mkfs_time;		/* When the filesystem was created */
@@ -565,6 +565,8 @@ struct ext2_super_block {
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 #define EXT2_FEATURE_INCOMPAT_META_BG		0x0010
 #define EXT3_FEATURE_INCOMPAT_EXTENTS		0x0040
+#define EXT4_FEATURE_INCOMPAT_64BIT		0x0080
+
 
 
 #define EXT2_FEATURE_COMPAT_SUPP	0
@@ -643,4 +645,42 @@ struct ext2_dir_entry_2 {
 #define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
 					 ~EXT2_DIR_ROUND)
 
+/* from here we have additional structures from ext3_extents.h */
+
+/*
+ * this is extent on-disk structure
+ * it's used at the bottom of the tree
+ */
+struct ext3_extent {
+	__le32	ee_block;	/* first logical block extent covers */
+	__le16	ee_len;		/* number of blocks covered by extent */
+	__le16	ee_start_hi;	/* high 16 bits of physical block */
+	__le32	ee_start;	/* low 32 bigs of physical block */
+};
+
+/*
+ * this is index on-disk structure
+ * it's used at all the levels, but the bottom
+ */
+struct ext3_extent_idx {
+	__le32	ei_block;	/* index covers logical blocks from 'block' */
+	__le32	ei_leaf;	/* pointer to the physical block of the next *
+				 * level. leaf or next index could bet here */
+	__le16	ei_leaf_hi;	/* high 16 bits of physical block */
+	__le16	ei_unused;
+};
+
+/*
+ * each block (leaves and indexes), even inode-stored has header
+ */
+struct ext3_extent_header {
+	__le16	eh_magic;	/* probably will support different formats */
+	__le16	eh_entries;	/* number of valid entries */
+	__le16	eh_max;		/* capacity of store in entries */
+	__le16	eh_depth;	/* has tree real underlying blocks? */
+	__le32	eh_generation;	/* generation of the tree */
+};
+
+#define EXT3_EXT_MAGIC		0xf30a
+
 #endif	/* _LINUX_EXT2_FS_H */
-- 
2.16.4

