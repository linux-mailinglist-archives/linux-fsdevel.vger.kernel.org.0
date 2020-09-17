Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E295C26D0CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 03:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIQBsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 21:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIQBr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:47:59 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:47:59 EDT
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FEC061756;
        Wed, 16 Sep 2020 18:40:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so197576pfi.4;
        Wed, 16 Sep 2020 18:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqPbYyibnBtLglSdw8vOUWlJOpkDU98bhZmP3GMf8Os=;
        b=qqmoYxYc6VcwCfc0BqmTEcqzfwNOGjSGMso04JaPbmuw/EydDLtQVRLCtGC2jGxPvE
         VE+grz+sg14en51ypU9qVlltQn9SbmiwAQhMjQecc4L0ULFF1p57ozcu93pDwPI9c7XL
         7BjCwNc6VCjLFhpqsuO+oyQ7Bw5Ga7H821P+/2S3ZFESrHS+x98BlBFB1jByEss0Rkbn
         QK75uVLq7u4Ue4qhBg9/5QEBqX6bda1eu+qpPiBIBJuXNiIq4pw7m7ljC5PaMhZxzP3p
         Tp0ozd7mH1CtY2n3qSY11bNs0UQqypy6Cg6LzdE87yy8tToArxjE7VrgLiqheH9bieKr
         2aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqPbYyibnBtLglSdw8vOUWlJOpkDU98bhZmP3GMf8Os=;
        b=ovPygVfLPfkAIDDIhXfitTkll/6w+eDCr1jWrPVAdfi0oI7iWl6Dx/55r9MbjkmSIf
         +Yem6YoqAp4Gowz64pHUfTwFtsL4+wDOeiUSnkitU3dbpbaVWgfM7QnlAeZKhDXpguea
         6GonZMtHET1L+DW+AauC3laiDQrdZ4kse0/8JUSK5F12mMbUWWxGlbCFQBCOJBiBFf5a
         E/P4aLLY6frYnUaSFnuZnX6Wls/9lkeJRqBwTMlcoJJGwk8+bUmhe+8CUCfTmtocEEaT
         JARgMYUmTFgoJZLYo3q9qS+ttpeMpxurGKTG01E+5d+H2yCd6TnrllThAnIoTbq0xmwz
         /Olw==
X-Gm-Message-State: AOAM532qog3hMo9GCWsjoXmcJLG+AsQ9Ww5Vbiz0pQp02inSrEOCO8xT
        6hyVq1rOiJA9xqNHxzwGYQQ=
X-Google-Smtp-Source: ABdhPJyFaLqjWKbe+lIDDeWVibl2M1DKnZpbUCR7PPzkGrRtAG0dO9OdnoibRJi6DqJSH4FRnWZWeQ==
X-Received: by 2002:aa7:9583:0:b029:142:2501:396a with SMTP id z3-20020aa795830000b02901422501396amr8944858pfj.47.1600306805981;
        Wed, 16 Sep 2020 18:40:05 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id l7sm3664769pjz.56.2020.09.16.18.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 18:40:05 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] exfat: remove 'rwoffset' in exfat_inode_info
Date:   Thu, 17 Sep 2020 10:39:16 +0900
Message-Id: <20200917013916.4523-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove 'rwoffset' in exfat_inode_info and replace it with the parameter of
exfat_readdir().
Since rwoffset is referenced only by exfat_readdir(), it is not necessary
a exfat_inode_info's member.
Also, change cpos to point to the next of entry-set, and return the index
of dir-entry via dir_entry->entry.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - 'cpos' point to the next of entry-set
 - return the index of dir-entry via dir_entry->entry
 - fix commit-message

 fs/exfat/dir.c      | 21 +++++++++------------
 fs/exfat/exfat_fs.h |  2 --
 fs/exfat/file.c     |  2 --
 fs/exfat/inode.c    |  3 ---
 fs/exfat/super.c    |  1 -
 5 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index a9b13ae3f325..82bee625549d 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -59,9 +59,9 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 }
 
 /* read a directory entry from the opened directory */
-static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
+static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_entry *dir_entry)
 {
-	int i, dentries_per_clu, dentries_per_clu_bits = 0;
+	int i, dentries_per_clu, dentries_per_clu_bits = 0, num_ext;
 	unsigned int type, clu_offset;
 	sector_t sector;
 	struct exfat_chain dir, clu;
@@ -70,7 +70,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	unsigned int dentry = ei->rwoffset & 0xFFFFFFFF;
+	unsigned int dentry = EXFAT_B_TO_DEN(*cpos) & 0xFFFFFFFF;
 	struct buffer_head *bh;
 
 	/* check if the given file ID is opened */
@@ -127,6 +127,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 				continue;
 			}
 
+			num_ext = ep->dentry.file.num_ext;
 			dir_entry->attr = le16_to_cpu(ep->dentry.file.attr);
 			exfat_get_entry_time(sbi, &dir_entry->crtime,
 					ep->dentry.file.create_tz,
@@ -157,12 +158,13 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 				return -EIO;
 			dir_entry->size =
 				le64_to_cpu(ep->dentry.stream.valid_size);
+			dir_entry->entry = dentry;
 			brelse(bh);
 
 			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
 			ei->hint_bmap.clu = clu.dir;
 
-			ei->rwoffset = ++dentry;
+			*cpos = EXFAT_DEN_TO_B(dentry + 1 + num_ext);
 			return 0;
 		}
 
@@ -178,7 +180,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 	}
 
 	dir_entry->namebuf.lfn[0] = '\0';
-	ei->rwoffset = dentry;
+	*cpos = EXFAT_DEN_TO_B(dentry);
 	return 0;
 }
 
@@ -242,12 +244,10 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
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
@@ -262,13 +262,10 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 		goto end_of_dir;
 	}
 
-	cpos = EXFAT_DEN_TO_B(ei->rwoffset);
-
 	if (!nb->lfn[0])
 		goto end_of_dir;
 
-	i_pos = ((loff_t)ei->start_clu << 32) |
-		((ei->rwoffset - 1) & 0xffffffff);
+	i_pos = ((loff_t)ei->start_clu << 32) |	(de.entry & 0xffffffff);
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

