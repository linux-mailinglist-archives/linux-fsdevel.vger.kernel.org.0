Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6D6118F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJ1RKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiJ1RKC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:10:02 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280496314;
        Fri, 28 Oct 2022 10:07:49 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 95935218D;
        Fri, 28 Oct 2022 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976708;
        bh=oLKpvX91YG+jy/JoBXU81k3iJpiW5DBSQzEq361ASJE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=MEvLIcJf4AQfUWH6jf+sxNEzkH4yi9p5kEuz5PMu5Ji3q5MBr29NIGaz4+2orzMyF
         W4MHeS7QMuTQ0tQRRWeBLC/HoBIUn/hry5fz22c9CCJca5mtNOcBhV6c7FS/R/bbwF
         kq3W0wsE5QIJK2IxchV2P/Vog3yfIHZMuCvDoi9I=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:07:47 +0300
Message-ID: <009f0b29-cc50-f162-9e23-27517c76cae6@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:07:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 13/14] fs/ntfs3: Improve checking of bad clusters
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added new function wnd_set_used_safe.
Load $BadClus before $AttrDef instead of before $Bitmap.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/bitmap.c  | 38 +++++++++++++++++++++++++++
  fs/ntfs3/ntfs_fs.h |  2 ++
  fs/ntfs3/run.c     | 21 ++-------------
  fs/ntfs3/super.c   | 64 ++++++++++++++++++++++++++++------------------
  4 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 6e68887597ac..c86a76dd44b9 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -800,6 +800,44 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
  	return err;
  }
  
+/*
+ * wnd_set_used_safe - Mark the bits range from bit to bit + bits as used.
+ *
+ * Unlikely wnd_set_used/wnd_set_free this function is not full trusted.
+ * It scans every bit in bitmap and marks free bit as used.
+ * @done - how many bits were marked as used.
+ *
+ * NOTE: normally *done should be 0.
+ */
+int wnd_set_used_safe(struct wnd_bitmap *wnd, size_t bit, size_t bits,
+		      size_t *done)
+{
+	size_t i, from = 0, len = 0;
+	int err = 0;
+
+	*done = 0;
+	for (i = 0; i < bits; i++) {
+		if (wnd_is_free(wnd, bit + i, 1)) {
+			if (!len)
+				from = bit + i;
+			len += 1;
+		} else if (len) {
+			err = wnd_set_used(wnd, from, len);
+			*done += len;
+			len = 0;
+			if (err)
+				break;
+		}
+	}
+
+	if (len) {
+		/* last fragment. */
+		err = wnd_set_used(wnd, from, len);
+		*done += len;
+	}
+	return err;
+}
+
  /*
   * wnd_is_free_hlp
   *
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index bc02cfb344f9..2f55993a716c 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -826,6 +826,8 @@ static inline size_t wnd_zeroes(const struct wnd_bitmap *wnd)
  int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits);
  int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits);
  int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits);
+int wnd_set_used_safe(struct wnd_bitmap *wnd, size_t bit, size_t bits,
+		      size_t *done);
  bool wnd_is_free(struct wnd_bitmap *wnd, size_t bit, size_t bits);
  bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits);
  
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 12d8682f33b5..a5af71cd8d14 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1096,25 +1096,8 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
  
  		if (down_write_trylock(&wnd->rw_lock)) {
  			/* Mark all zero bits as used in range [lcn, lcn+len). */
-			CLST i, lcn_f = 0, len_f = 0;
-
-			err = 0;
-			for (i = 0; i < len; i++) {
-				if (wnd_is_free(wnd, lcn + i, 1)) {
-					if (!len_f)
-						lcn_f = lcn + i;
-					len_f += 1;
-				} else if (len_f) {
-					err = wnd_set_used(wnd, lcn_f, len_f);
-					len_f = 0;
-					if (err)
-						break;
-				}
-			}
-
-			if (len_f)
-				err = wnd_set_used(wnd, lcn_f, len_f);
-
+			size_t done;
+			err = wnd_set_used_safe(wnd, lcn, len, &done);
  			up_write(&wnd->rw_lock);
  			if (err)
  				return err;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 1e2c04e48f98..d8ba6724adf1 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -921,7 +921,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
  	struct block_device *bdev = sb->s_bdev;
  	struct inode *inode;
  	struct ntfs_inode *ni;
-	size_t i, tt;
+	size_t i, tt, bad_len, bad_frags;
  	CLST vcn, lcn, len;
  	struct ATTRIB *attr;
  	const struct VOLUME_INFO *info;
@@ -1091,30 +1091,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
  
  	sbi->mft.ni = ni;
  
-	/* Load $BadClus. */
-	ref.low = cpu_to_le32(MFT_REC_BADCLUST);
-	ref.seq = cpu_to_le16(MFT_REC_BADCLUST);
-	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
-	if (IS_ERR(inode)) {
-		ntfs_err(sb, "Failed to load $BadClus.");
-		err = PTR_ERR(inode);
-		goto out;
-	}
-
-	ni = ntfs_i(inode);
-
-	for (i = 0; run_get_entry(&ni->file.run, i, &vcn, &lcn, &len); i++) {
-		if (lcn == SPARSE_LCN)
-			continue;
-
-		if (!sbi->bad_clusters)
-			ntfs_notice(sb, "Volume contains bad blocks");
-
-		sbi->bad_clusters += len;
-	}
-
-	iput(inode);
-
  	/* Load $Bitmap. */
  	ref.low = cpu_to_le32(MFT_REC_BITMAP);
  	ref.seq = cpu_to_le16(MFT_REC_BITMAP);
@@ -1152,6 +1128,44 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
  	if (err)
  		goto out;
  
+	/* Load $BadClus. */
+	ref.low = cpu_to_le32(MFT_REC_BADCLUST);
+	ref.seq = cpu_to_le16(MFT_REC_BADCLUST);
+	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		ntfs_err(sb, "Failed to load $BadClus (%d).", err);
+		goto out;
+	}
+
+	ni = ntfs_i(inode);
+	bad_len = bad_frags = 0;
+	for (i = 0; run_get_entry(&ni->file.run, i, &vcn, &lcn, &len); i++) {
+		if (lcn == SPARSE_LCN)
+			continue;
+
+		bad_len += len;
+		bad_frags += 1;
+		if (sb_rdonly(sb))
+			continue;
+
+		if (wnd_set_used_safe(&sbi->used.bitmap, lcn, len, &tt) || tt) {
+			/* Bad blocks marked as free in bitmap. */
+			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		}
+	}
+	if (bad_len) {
+		/*
+		 * Notice about bad blocks.
+		 * In normal cases these blocks are marked as used in bitmap.
+		 * And we never allocate space in it.
+		 */
+		ntfs_notice(sb,
+			    "Volume contains %zu bad blocks in %zu fragments.",
+			    bad_len, bad_frags);
+	}
+	iput(inode);
+
  	/* Load $AttrDef. */
  	ref.low = cpu_to_le32(MFT_REC_ATTR);
  	ref.seq = cpu_to_le16(MFT_REC_ATTR);
-- 
2.37.0


