Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A264563422
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiGANLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiGANL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:11:28 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEAA564F4;
        Fri,  1 Jul 2022 06:11:12 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 213BD21B4;
        Fri,  1 Jul 2022 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656680993;
        bh=EjlWxm79lVaiCmeyrgDYpsSvzCOyXg3FUYILHL91If0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Mf0etTJWXkZEsLpA50TR3ZaEOPTOXYLSdR+opcdH/02tvEa7CtfOnRmb/wmVB/zTr
         f3UwElSgjMFwecLnPk1AjXV5cr6sw3ivv1wLqUIBkvB20mIuNeH5zMiHTiOzl2Hk8a
         YLuSAIanH9qEB9nWkLBiNaCbupoVr5Tk+6LACdYk=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Jul 2022 16:10:50 +0300
Message-ID: <653b1628-074c-82a6-9926-d793bbcb031b@paragon-software.com>
Date:   Fri, 1 Jul 2022 16:10:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH 3/5] fs/ntfs3: Add new argument is_mft to ntfs_mark_rec_free
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
In-Reply-To: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This argument helps in avoiding double locking

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c | 12 ++++++------
  fs/ntfs3/fsntfs.c  |  9 ++++++---
  fs/ntfs3/inode.c   |  2 +-
  fs/ntfs3/ntfs_fs.h |  2 +-
  4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 64041152fd98..756d9a18fa00 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1048,7 +1048,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
  	err = -EINVAL;
  
  out1:
-	ntfs_mark_rec_free(sbi, rno);
+	ntfs_mark_rec_free(sbi, rno, is_mft);
  
  out:
  	return err;
@@ -1243,7 +1243,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
  		mft_min = mft_new;
  		mi_min = mi_new;
  	} else {
-		ntfs_mark_rec_free(sbi, mft_new);
+		ntfs_mark_rec_free(sbi, mft_new, true);
  		mft_new = 0;
  		ni_remove_mi(ni, mi_new);
  	}
@@ -1326,7 +1326,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
  
  out:
  	if (mft_new) {
-		ntfs_mark_rec_free(sbi, mft_new);
+		ntfs_mark_rec_free(sbi, mft_new, true);
  		ni_remove_mi(ni, mi_new);
  	}
  
@@ -1585,7 +1585,7 @@ int ni_delete_all(struct ntfs_inode *ni)
  		mi->dirty = true;
  		mi_write(mi, 0);
  
-		ntfs_mark_rec_free(sbi, mi->rno);
+		ntfs_mark_rec_free(sbi, mi->rno, false);
  		ni_remove_mi(ni, mi);
  		mi_put(mi);
  		node = next;
@@ -1596,7 +1596,7 @@ int ni_delete_all(struct ntfs_inode *ni)
  	ni->mi.dirty = true;
  	err = mi_write(&ni->mi, 0);
  
-	ntfs_mark_rec_free(sbi, ni->mi.rno);
+	ntfs_mark_rec_free(sbi, ni->mi.rno, false);
  
  	return err;
  }
@@ -3286,7 +3286,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
  			err = err2;
  
  		if (is_empty) {
-			ntfs_mark_rec_free(sbi, mi->rno);
+			ntfs_mark_rec_free(sbi, mi->rno, false);
  			rb_erase(node, &ni->mi_tree);
  			mi_put(mi);
  		}
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 3de5700a9b83..c53dd4c9e47b 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -703,12 +703,14 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
  
  /*
   * ntfs_mark_rec_free - Mark record as free.
+ * is_mft - true if we are changing MFT
   */
-void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno)
+void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno, bool is_mft)
  {
  	struct wnd_bitmap *wnd = &sbi->mft.bitmap;
  
-	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_MFT);
+	if (!is_mft)
+		down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_MFT);
  	if (rno >= wnd->nbits)
  		goto out;
  
@@ -727,7 +729,8 @@ void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno)
  		sbi->mft.next_free = rno;
  
  out:
-	up_write(&wnd->rw_lock);
+	if (!is_mft)
+		up_write(&wnd->rw_lock);
  }
  
  /*
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 6c78930be035..a49da4ec6dc3 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1636,7 +1636,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  	ni->mi.dirty = false;
  	discard_new_inode(inode);
  out3:
-	ntfs_mark_rec_free(sbi, ino);
+	ntfs_mark_rec_free(sbi, ino, false);
  
  out2:
  	__putname(new_de);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index ebe4a8ecc20d..5472cde2aa5f 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -590,7 +590,7 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
  			     enum ALLOCATE_OPT opt);
  int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
  		       struct ntfs_inode *ni, struct mft_inode **mi);
-void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno);
+void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno, bool is_mft);
  int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to);
  int ntfs_refresh_zone(struct ntfs_sb_info *sbi);
  int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait);
-- 
2.37.0


