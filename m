Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06F26295F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIIH5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIIH5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:57:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE13C061573;
        Wed,  9 Sep 2020 00:57:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j34so1485990pgi.7;
        Wed, 09 Sep 2020 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+X4iBxVgYCfC9tgU+NvjvGBXoGYQ0oNypPZZ+t2YZzw=;
        b=p+qFEAT9Di4hET0XtKTXMae9b7CMXRiAdH6qqIy4ShH+LIwdnzBG5fZHVHOChKbl5L
         EoHhPq+nKRiyrIvVWEOABLF1jxBQoVCWd1TcFsdVF5fHMVlFp2MPMCOUa2FoP23vLpMZ
         lUd2pVVAhSm6o4cgx5EaCYdfQnN7d02SUNQrDNmXW0f4A7or65+AMTMzIkdGAvEpjHlS
         V5V2m/syGQ5yF0OCsHqjUuiccDxi6CmHLypzgNN6A2xIT+atS6j2JXIM4HF8y1dOVaXr
         M+ut7KKFL5FI/JcXecpaIYiQTC2NaW7iO43iQpnforrxQ4SNx+nFjiw7eqI3ndLa8GSb
         euCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+X4iBxVgYCfC9tgU+NvjvGBXoGYQ0oNypPZZ+t2YZzw=;
        b=ZIsvrUjpl0hQa03XMbfTVkezJU98U3BDsrmVNAsnWdBRukrXNSrK5LgcP9NfShrsR0
         FhS4WsmMPgDAWCENUKbCuelwfVnRWV+Ra4XJyRRt0IFPJ49NKzelWy9AOptoatcLoCHz
         bgY1AHzA7nkrJsns66J6PmaZxqrG3ABgJNJD0BSBmg6J/I9kGDue+WaHPL350ToiMsdj
         jpKHuqmcxlg/AxfhEiFLt0X3ZNwi079+7DaEO02EYHbmAhuWL3KaPfNC+XJFV76wjUaf
         S500PKiPYh/4SK7uSEmTdW2I5nYfhnpKS+qD2fuRHss39pOLGRqH8C6YwPCEn6K7zENN
         BPJw==
X-Gm-Message-State: AOAM530yXsHSDB93viP5GjkjMYMYdVgnbNHz88VpheVHwjusHiMURXbR
        olmIBtrThqpqpwtzq16/9afDuh2hOnU=
X-Google-Smtp-Source: ABdhPJxz+oH/DPZI3mRC38xvEqVd9RvifIcvUwXuSpWwdWJPblYVgrul0teDjiY4+OTZfYQRFfxQ4Q==
X-Received: by 2002:a65:679a:: with SMTP id e26mr2148438pgr.167.1599638229298;
        Wed, 09 Sep 2020 00:57:09 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id 138sm1804032pfu.180.2020.09.09.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:57:08 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: remove 'rwoffset' in exfat_inode_info
Date:   Wed,  9 Sep 2020 16:56:52 +0900
Message-Id: <20200909075652.11203-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove 'rwoffset' in exfat_inode_info and replace it with the parameter(cpos) of exfat_readdir.
Since rwoffset of  is referenced only by exfat_readdir, it is not necessary a exfat_inode_info's member.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c      | 16 ++++++----------
 fs/exfat/exfat_fs.h |  2 --
 fs/exfat/file.c     |  2 --
 fs/exfat/inode.c    |  3 ---
 fs/exfat/super.c    |  1 -
 5 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index a9b13ae3f325..fa5bb72aa295 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -59,7 +59,7 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 }
 
 /* read a directory entry from the opened directory */
-static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
+static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_entry *dir_entry)
 {
 	int i, dentries_per_clu, dentries_per_clu_bits = 0;
 	unsigned int type, clu_offset;
@@ -70,7 +70,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	unsigned int dentry = ei->rwoffset & 0xFFFFFFFF;
+	unsigned int dentry = EXFAT_B_TO_DEN(*cpos) & 0xFFFFFFFF;
 	struct buffer_head *bh;
 
 	/* check if the given file ID is opened */
@@ -162,7 +162,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
 			ei->hint_bmap.clu = clu.dir;
 
-			ei->rwoffset = ++dentry;
+			*cpos = EXFAT_DEN_TO_B(++dentry);
 			return 0;
 		}
 
@@ -178,7 +178,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 	}
 
 	dir_entry->namebuf.lfn[0] = '\0';
-	ei->rwoffset = dentry;
+	*cpos = EXFAT_DEN_TO_B(dentry);
 	return 0;
 }
 
@@ -242,12 +242,10 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 	if (err)
 		goto unlock;
 get_new:
-	ei->rwoffset = EXFAT_B_TO_DEN(cpos);
-
 	if (cpos >= i_size_read(inode))
 		goto end_of_dir;
 
-	err = exfat_readdir(inode, &de);
+	err = exfat_readdir(inode, &cpos, &de);
 	if (err) {
 		/*
 		 * At least we tried to read a sector.  Move cpos to next sector
@@ -262,13 +260,11 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 		goto end_of_dir;
 	}
 
-	cpos = EXFAT_DEN_TO_B(ei->rwoffset);
-
 	if (!nb->lfn[0])
 		goto end_of_dir;
 
 	i_pos = ((loff_t)ei->start_clu << 32) |
-		((ei->rwoffset - 1) & 0xffffffff);
+		(EXFAT_B_TO_DEN(cpos-1) & 0xffffffff);
 	tmp = exfat_iget(sb, i_pos);
 	if (tmp) {
 		inum = tmp->i_ino;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 44dc04520175..e586daf5a2e7 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -263,8 +263,6 @@ struct exfat_inode_info {
 	 * the validation of hint_stat.
 	 */
 	unsigned int version;
-	/* file offset or dentry index for readdir */
-	loff_t rwoffset;
 
 	/* hint for cluster last accessed */
 	struct exfat_hint hint_bmap;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 4831a39632a1..a92478eabfa4 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -208,8 +208,6 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	/* hint information */
 	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
 	ei->hint_bmap.clu = EXFAT_EOF_CLUSTER;
-	if (ei->rwoffset > new_size)
-		ei->rwoffset = new_size;
 
 	/* hint_stat will be used if this is directory. */
 	ei->hint_stat.eidx = 0;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 7f90204adef5..70a33d4807c3 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -114,8 +114,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	unsigned int local_clu_offset = clu_offset;
 	unsigned int num_to_be_allocated = 0, num_clusters = 0;
 
-	ei->rwoffset = EXFAT_CLU_TO_B(clu_offset, sbi);
-
 	if (EXFAT_I(inode)->i_size_ondisk > 0)
 		num_clusters =
 			EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk,
@@ -567,7 +565,6 @@ static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
 	ei->hint_stat.eidx = 0;
 	ei->hint_stat.clu = info->start_clu;
 	ei->hint_femp.eidx = EXFAT_HINT_NONE;
-	ei->rwoffset = 0;
 	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
 	ei->i_pos = 0;
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 3b6a1659892f..b29935a91b9b 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -342,7 +342,6 @@ static int exfat_read_root(struct inode *inode)
 	ei->flags = ALLOC_FAT_CHAIN;
 	ei->type = TYPE_DIR;
 	ei->version = 0;
-	ei->rwoffset = 0;
 	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
 	ei->hint_stat.eidx = 0;
 	ei->hint_stat.clu = sbi->root_dir;
-- 
2.25.1

