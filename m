Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0183D344D94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhCVRkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhCVRjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:39:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C94C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:39:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso11597234wmi.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhDovsOUztueBlDzsvkjQSENTLDV2bIw0lCcNwGN9MM=;
        b=mXZa5IXIj1yILENXDaqZbz4VOaYV8uPjHXfeO856PIn6cAHHk2fTzWkihBwfZJB0sx
         kH3yZmTZ6gvNF1vmGsf4m8lgByYQZD/GEq5+yNIZYw3j+mfPDnzOy34qa5LrpKKRufLt
         JugMPwsZskp72j+htbDpVWvJj7X3tEWsdO0KQ/01sHidBiqF9G65PPoDX1LnQWNuc8Ia
         FwCgyAG+lCiNABEz00nnFMz7WqLRgPu39if5oAr/MuKc8Xk1MBjgRG4Xzjtx0NGthBe/
         jkHUE6oO2hw5Kum/0iKfqWLtSCsEIZ8e7MQsCVO3sx0UOEp+a4S+odlSnNhKuJkpza28
         aPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhDovsOUztueBlDzsvkjQSENTLDV2bIw0lCcNwGN9MM=;
        b=d4rpKimzs7f/4/4Usu9ASmz0x/TOLpQxjeoG0HRCCCQ8fVHJSB8LHWN2KKDrqzsfFx
         Ju6MqaHGb+RINKS6p7NXtwyl91OWJpBcqLrTrfmODHjNNuvVqtBvkrMH0cbTibTwgMOc
         RunjBK9ay8SqMzChTgL7Yu4r2J5HxW7M/Z0F7wh0joFpbcI6TgZvcQEBXJLXAV7HPz2w
         uwBDbYqdtNBkTXoocCAXeJXrPAwE1hnPoUX5/jqpw9OWz2JaKunpLrrPOBPYGn/8LBl1
         i6RLgvOa8i3N0z9phUhjLMQCOz8Re59ESSSBI1fdRSZPqJCQ02hBB0doHZ2VpRZkgdLs
         Zb5A==
X-Gm-Message-State: AOAM532RQksqbRR0t7lwEZPX7DXgmsTDiyCw/+IhZxIoR4O2MJeM5qx4
        vQtEWiTe208zHWkwNFfQAM6eoZOxZow=
X-Google-Smtp-Source: ABdhPJxuukNfW5JRkCXkaL5zI66q+QrA8f+L3GSDp0QqAZ1ULdA0IyEaYswPl77peFus+DBnvtYsPw==
X-Received: by 2002:a7b:cdef:: with SMTP id p15mr185911wmj.0.1616434789354;
        Mon, 22 Mar 2021 10:39:49 -0700 (PDT)
Received: from localhost.localdomain ([141.226.241.101])
        by smtp.gmail.com with ESMTPSA id p27sm138790wmi.12.2021.03.22.10.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:39:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: introduce a wrapper uuid_to_fsid()
Date:   Mon, 22 Mar 2021 19:39:43 +0200
Message-Id: <20210322173944.449469-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322173944.449469-1-amir73il@gmail.com>
References: <20210322173944.449469-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystem's use a digest of their uuid for f_fsid.
Create a simple wrapper for this open coded folding.

Filesystems that have a non null uuid but use the block device
number for f_fsid may also consider using this helper.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ext2/super.c        | 5 +----
 fs/ext4/super.c        | 5 +----
 fs/zonefs/super.c      | 5 +----
 include/linux/statfs.h | 7 +++++++
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 6c4753277916..0d679451657c 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1399,7 +1399,6 @@ static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
 	struct super_block *sb = dentry->d_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
-	u64 fsid;
 
 	spin_lock(&sbi->s_lock);
 
@@ -1453,9 +1452,7 @@ static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
 	buf->f_ffree = ext2_count_free_inodes(sb);
 	es->s_free_inodes_count = cpu_to_le32(buf->f_ffree);
 	buf->f_namelen = EXT2_NAME_LEN;
-	fsid = le64_to_cpup((void *)es->s_uuid) ^
-	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
-	buf->f_fsid = u64_to_fsid(fsid);
+	buf->f_fsid = uuid_to_fsid(es->s_uuid);
 	spin_unlock(&sbi->s_lock);
 	return 0;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ad34a37278cd..3581c1cdc19e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6148,7 +6148,6 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	ext4_fsblk_t overhead = 0, resv_blocks;
-	u64 fsid;
 	s64 bfree;
 	resv_blocks = EXT4_C2B(sbi, atomic64_read(&sbi->s_resv_clusters));
 
@@ -6169,9 +6168,7 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = percpu_counter_sum_positive(&sbi->s_freeinodes_counter);
 	buf->f_namelen = EXT4_NAME_LEN;
-	fsid = le64_to_cpup((void *)es->s_uuid) ^
-	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
-	buf->f_fsid = u64_to_fsid(fsid);
+	buf->f_fsid = uuid_to_fsid(es->s_uuid);
 
 #ifdef CONFIG_QUOTA
 	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 0fe76f376dee..e09810311162 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1104,7 +1104,6 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct super_block *sb = dentry->d_sb;
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	enum zonefs_ztype t;
-	u64 fsid;
 
 	buf->f_type = ZONEFS_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
@@ -1127,9 +1126,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	spin_unlock(&sbi->s_lock);
 
-	fsid = le64_to_cpup((void *)sbi->s_uuid.b) ^
-		le64_to_cpup((void *)sbi->s_uuid.b + sizeof(u64));
-	buf->f_fsid = u64_to_fsid(fsid);
+	buf->f_fsid = uuid_to_fsid(sbi->s_uuid.b);
 
 	return 0;
 }
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 20f695b90aab..ed86ac090a1b 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -50,4 +50,11 @@ static inline __kernel_fsid_t u64_to_fsid(u64 v)
 	return (__kernel_fsid_t){.val = {(u32)v, (u32)(v>>32)}};
 }
 
+/* Fold 16 bytes uuid to 64 bit fsid */
+static inline __kernel_fsid_t uuid_to_fsid(__u8 *uuid)
+{
+	return u64_to_fsid(le64_to_cpup((void *)uuid) ^
+		le64_to_cpup((void *)(uuid + sizeof(u64))));
+}
+
 #endif
-- 
2.25.1

