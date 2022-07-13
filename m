Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF61573B73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiGMQpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGMQpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:45:13 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA382B26E;
        Wed, 13 Jul 2022 09:45:12 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 39B091DDC;
        Wed, 13 Jul 2022 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730643;
        bh=L+N1YQLxZSNOsY+ZLvv3WxM9jkJMltqbqcRgSyaQKcE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=oUXRP02QL5X0gYL7Mt37SMuSDpE7gFXc0lDlyzAYj7ASKwVOAxk7TObiRjTnGHnJZ
         JdAIZ1Z1zvFdXe+ktrGoStnnrpOTm55VFMC9hr8qHLPSHX72il835+NMN1sJmbz1Zo
         VhGpcwqfsP9JNB/3hHQtY1aJtMF59y9xxCqY/HnY=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:45:10 +0300
Message-ID: <38433695-c21c-6b94-4b03-a9394a7c4ad0@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:45:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 1/6] fs/ntfs3: New function ntfs_bad_inode
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
In-Reply-To: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are repetitive steps in case of bad inode
This commit wraps them in function

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 10 ++++------
  fs/ntfs3/frecord.c |  6 ++----
  fs/ntfs3/fsntfs.c  | 14 ++++++++++++++
  fs/ntfs3/inode.c   |  6 ++----
  fs/ntfs3/namei.c   |  4 +---
  fs/ntfs3/ntfs_fs.h |  2 ++
  6 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 68a210bb54fe..d096d77ea042 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1912,7 +1912,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  out:
  	up_write(&ni->file.run_lock);
  	if (err)
-		make_bad_inode(&ni->vfs_inode);
+		_ntfs_bad_inode(&ni->vfs_inode);
  
  	return err;
  }
@@ -2092,10 +2092,8 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  
  out:
  	up_write(&ni->file.run_lock);
-	if (err) {
-		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
-		make_bad_inode(&ni->vfs_inode);
-	}
+	if (err)
+		_ntfs_bad_inode(&ni->vfs_inode);
  
  	return err;
  }
@@ -2280,7 +2278,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  
  	up_write(&ni->file.run_lock);
  	if (err)
-		make_bad_inode(&ni->vfs_inode);
+		_ntfs_bad_inode(&ni->vfs_inode);
  
  	return err;
  }
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index bc48923693a9..bdc568053fae 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2328,10 +2328,8 @@ int ni_decompress_file(struct ntfs_inode *ni)
  
  out:
  	kfree(pages);
-	if (err) {
-		make_bad_inode(inode);
-		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
-	}
+	if (err)
+		_ntfs_bad_inode(inode);
  
  	return err;
  }
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index ed9a1b851ce9..e6f5bf684da4 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -878,6 +878,20 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
  	return err;
  }
  
+/*
+ * ntfs_bad_inode
+ *
+ * Marks inode as bad and marks fs as 'dirty'
+ */
+void ntfs_bad_inode(struct inode *inode, const char *hint)
+{
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+
+	ntfs_inode_err(inode, "%s", hint);
+	make_bad_inode(inode);
+	ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+}
+
  /*
   * ntfs_set_state
   *
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3ed319663747..cd48687127c1 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -501,7 +501,7 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
  		inode = ntfs_read_mft(inode, name, ref);
  	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
  		/* Inode overlaps? */
-		make_bad_inode(inode);
+		_ntfs_bad_inode(inode);
  	}
  
  	return inode;
@@ -1725,9 +1725,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
  		if (inode->i_nlink)
  			mark_inode_dirty(inode);
  	} else if (!ni_remove_name_undo(dir_ni, ni, de, de2, undo_remove)) {
-		make_bad_inode(inode);
-		ntfs_inode_err(inode, "failed to undo unlink");
-		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(inode);
  	} else {
  		if (ni_is_dirty(dir))
  			mark_inode_dirty(dir);
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 1cc700760c7e..bc22cc321a74 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -308,9 +308,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *dir,
  	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de, &is_bad);
  	if (is_bad) {
  		/* Restore after failed rename failed too. */
-		make_bad_inode(inode);
-		ntfs_inode_err(inode, "failed to undo rename");
-		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(inode);
  	} else if (!err) {
  		inode->i_ctime = dir->i_ctime = dir->i_mtime =
  			current_time(dir);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 54c20700afd3..c3e17090effc 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -593,6 +593,8 @@ void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno, bool is_mft);
  int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to);
  int ntfs_refresh_zone(struct ntfs_sb_info *sbi);
  int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait);
+void ntfs_bad_inode(struct inode *inode, const char *hint);
+#define _ntfs_bad_inode(i) ntfs_bad_inode(i, __func__)
  enum NTFS_DIRTY_FLAGS {
  	NTFS_DIRTY_CLEAR = 0,
  	NTFS_DIRTY_DIRTY = 1,
-- 
2.37.0


