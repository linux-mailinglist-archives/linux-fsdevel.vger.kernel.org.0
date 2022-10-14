Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3185FEB03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJNIuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJNItv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBB1F2C0;
        Fri, 14 Oct 2022 01:49:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id iv17so2671139wmb.4;
        Fri, 14 Oct 2022 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+9yJ7ltRwZDViylHimzxt5trfp3/YyMYP1DALt6daQ=;
        b=p63rFDk+7fHDtSHqdHbh5UTErR2KUpqMpgr3HkVCyL03aJpfelAlYk+zA1kvLcUK4x
         oCy0NMYDZh+H50rQcR49ml2HNBTBYxQHuyUYk2CSX54YfuXf3DWjLKdUiCPT4+EiIFSi
         nHSQMC7c9mLxjAkq4yLJ0/P9F8eN2RlUOEqc8NA2In2jz47ELklEdKHjSYs0ZELx4ixz
         5/vUWh5rIIInW9un9b84c/P8CPLnarDABeMuwBY6OaHUr8e6bA2Wo85vskn9BuK/Ho1v
         LOW3LE2S8qlC9e+TcP7T6auaCAsi9PDl3bTPIkBQTVkixT16squswDJ53Vty9EoVnl7l
         vcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+9yJ7ltRwZDViylHimzxt5trfp3/YyMYP1DALt6daQ=;
        b=dXlIpapOdYfjq/cBfLsuHJNo0YtoojAqAHaM8sZaFbBBpGE6fC/i1u6otIjy7pOMp6
         12DmG0CFo9sNnf3Z5DgKsIxJULptICGxF+znGgLgJ5RRbjjUAKPnr5lKhQ2i9NUAKrX/
         vG74OJzbBR90I+8gulLItCgA0rNqgyg1h9y0EUyUCwEjSG2UgZEmXOMyhP/u+Znxk9jq
         MLnawy9GSpFSgGpAyEVzyRpKQ/Gk1ti3snkvIfcz27N9BscF2JV7ruFNLKZFehK91/4o
         jMPcfDjcLv3bygeaso5GZ4eMJjSK9A8rtfGq5fm9i9n+UuLewccgKYHVSIb7u8S607OA
         56Fg==
X-Gm-Message-State: ACrzQf2KGSiKC5tL4dixY4AWg1RATtkrFmQPvpJqycM0ZJi1nGk7MTCl
        i38f2oa1MZay2MJcjJFNu38=
X-Google-Smtp-Source: AMsMyM45L6TdWLoWTz5aCkSDhsUhnAFVyDkdp0Ci0aBfwoR6x63gBHft59KTvo8CdK8QfpU4449Q7g==
X-Received: by 2002:a05:600c:19ce:b0:3b9:c36f:f9e2 with SMTP id u14-20020a05600c19ce00b003b9c36ff9e2mr2761365wmq.110.1665737387337;
        Fri, 14 Oct 2022 01:49:47 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:47 -0700 (PDT)
From:   Hrutvik Kanabar <hrkanabar@gmail.com>
To:     Hrutvik Kanabar <hrutvik@google.com>
Cc:     Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH RFC 2/7] fs/ext4: support `DISABLE_FS_CSUM_VERIFICATION` config option
Date:   Fri, 14 Oct 2022 08:48:32 +0000
Message-Id: <20221014084837.1787196-3-hrkanabar@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014084837.1787196-1-hrkanabar@gmail.com>
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hrutvik Kanabar <hrutvik@google.com>

When `DISABLE_FS_CSUM_VERIFICATION` is enabled, bypass checks in key
checksum verification functions.

Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
---
 fs/ext4/bitmap.c  | 6 ++++--
 fs/ext4/extents.c | 3 ++-
 fs/ext4/inode.c   | 3 ++-
 fs/ext4/ioctl.c   | 3 ++-
 fs/ext4/mmp.c     | 3 ++-
 fs/ext4/namei.c   | 6 ++++--
 fs/ext4/orphan.c  | 3 ++-
 fs/ext4/super.c   | 6 ++++--
 fs/ext4/xattr.c   | 3 ++-
 9 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index f63e028c638c..04ce8e4149ee 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -24,7 +24,8 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
 	__u32 provided, calculated;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (!ext4_has_metadata_csum(sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(sb))
 		return 1;
 
 	provided = le16_to_cpu(gdp->bg_inode_bitmap_csum_lo);
@@ -63,7 +64,8 @@ int ext4_block_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int sz = EXT4_CLUSTERS_PER_GROUP(sb) / 8;
 
-	if (!ext4_has_metadata_csum(sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(sb))
 		return 1;
 
 	provided = le16_to_cpu(gdp->bg_block_bitmap_csum_lo);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f1956288307f..c1b7c8f4862c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -63,7 +63,8 @@ static int ext4_extent_block_csum_verify(struct inode *inode,
 {
 	struct ext4_extent_tail *et;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(inode->i_sb))
 		return 1;
 
 	et = find_ext4_extent_tail(eh);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..8ec8214f1423 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -86,7 +86,8 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
 {
 	__u32 provided, calculated;
 
-	if (EXT4_SB(inode->i_sb)->s_es->s_creator_os !=
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    EXT4_SB(inode->i_sb)->s_es->s_creator_os !=
 	    cpu_to_le32(EXT4_OS_LINUX) ||
 	    !ext4_has_metadata_csum(inode->i_sb))
 		return 1;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 4d49c5cfb690..bae33cd83d05 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -142,7 +142,8 @@ static int ext4_update_backup_sb(struct super_block *sb,
 
 	es = (struct ext4_super_block *) (bh->b_data + offset);
 	lock_buffer(bh);
-	if (ext4_has_metadata_csum(sb) &&
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    ext4_has_metadata_csum(sb) &&
 	    es->s_checksum != ext4_superblock_csum(sb, es)) {
 		ext4_msg(sb, KERN_ERR, "Invalid checksum for backup "
 		"superblock %llu\n", sb_block);
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 9af68a7ecdcf..605f1867958d 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -21,7 +21,8 @@ static __le32 ext4_mmp_csum(struct super_block *sb, struct mmp_struct *mmp)
 
 static int ext4_mmp_csum_verify(struct super_block *sb, struct mmp_struct *mmp)
 {
-	if (!ext4_has_metadata_csum(sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(sb))
 		return 1;
 
 	return mmp->mmp_checksum == ext4_mmp_csum(sb, mmp);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d5daaf41e1fc..84a59052c51d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -396,7 +396,8 @@ int ext4_dirblock_csum_verify(struct inode *inode, struct buffer_head *bh)
 {
 	struct ext4_dir_entry_tail *t;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(inode->i_sb))
 		return 1;
 
 	t = get_dirent_tail(inode, bh);
@@ -491,7 +492,8 @@ static int ext4_dx_csum_verify(struct inode *inode,
 	struct dx_tail *t;
 	int count_offset, limit, count;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(inode->i_sb))
 		return 1;
 
 	c = get_dx_countlimit(inode, dirent, &count_offset);
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 69a9cf9137a6..8a488d5521cb 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -537,7 +537,8 @@ static int ext4_orphan_file_block_csum_verify(struct super_block *sb,
 	struct ext4_orphan_block_tail *ot;
 	__le64 dsk_block_nr = cpu_to_le64(bh->b_blocknr);
 
-	if (!ext4_has_metadata_csum(sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(sb))
 		return 1;
 
 	ot = ext4_orphan_block_tail(sb, bh);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d733db8a0b02..cb6e53163441 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -287,7 +287,8 @@ __le32 ext4_superblock_csum(struct super_block *sb,
 static int ext4_superblock_csum_verify(struct super_block *sb,
 				       struct ext4_super_block *es)
 {
-	if (!ext4_has_metadata_csum(sb))
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    !ext4_has_metadata_csum(sb))
 		return 1;
 
 	return es->s_checksum == ext4_superblock_csum(sb, es);
@@ -3198,7 +3199,8 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
 int ext4_group_desc_csum_verify(struct super_block *sb, __u32 block_group,
 				struct ext4_group_desc *gdp)
 {
-	if (ext4_has_group_desc_csum(sb) &&
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    ext4_has_group_desc_csum(sb) &&
 	    (gdp->bg_checksum != ext4_group_desc_csum(sb, block_group, gdp)))
 		return 0;
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 36d6ba7190b6..b22a0f282474 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -154,7 +154,8 @@ static int ext4_xattr_block_csum_verify(struct inode *inode,
 	struct ext4_xattr_header *hdr = BHDR(bh);
 	int ret = 1;
 
-	if (ext4_has_metadata_csum(inode->i_sb)) {
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    ext4_has_metadata_csum(inode->i_sb)) {
 		lock_buffer(bh);
 		ret = (hdr->h_checksum == ext4_xattr_block_csum(inode,
 							bh->b_blocknr, hdr));
-- 
2.38.0.413.g74048e4d9e-goog

