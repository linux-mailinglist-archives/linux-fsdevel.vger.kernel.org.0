Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC99422C7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhJEP2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 11:28:48 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:58477 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230059AbhJEP2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:28:47 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 5B29082246;
        Tue,  5 Oct 2021 18:26:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633447614;
        bh=+ZnTe0+e6pt46xkHcMh2XLrpyQ1A7TZkhNsacRXaPuw=;
        h=Date:To:CC:From:Subject;
        b=Tc6h/L+r9Tpf6rKMF+KD13z5M8fvcGKpozzdlF519OTHlLXrdDHzMW1tOakJlmXgV
         V5talOh8SfyD1vA/ug/Vn8UMY2UZDv/FjX92a5w0FNrtucCpZUm/hFfq0uEuox5EPM
         fRH+cKE4FH1qO7qPD5gnD0behUs9bapHGmcecxz0=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 18:26:53 +0300
Message-ID: <79791816-db23-f3b4-3ea8-139add705c45@paragon-software.com>
Date:   Tue, 5 Oct 2021 18:26:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2] fs/ntfs3: Fix memory leak if fill_super failed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.181]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ntfs_init_fs_context we allocate memory in fc->s_fs_info.
In case of failed mount we must free it in ntfs_fill_super.
We can't do it in ntfs_fs_free, because ntfs_fs_free called
with fc->s_fs_info == NULL.
fc->s_fs_info became NULL in sget_fc.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
v2:
  Changed fix - now we free memory instead of restoring pointer to memory.
  Added context how we allocate and free memory.
  Many commits affected, so no fixes tag.

 fs/ntfs3/super.c | 90 ++++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 705d8b4f4894..d41d76979e12 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -908,7 +908,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (IS_ERR(sbi->options->nls)) {
 		sbi->options->nls = NULL;
 		errorf(fc, "Cannot load nls %s", sbi->options->nls_name);
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 	rq = bdev_get_queue(bdev);
@@ -922,7 +923,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
 				  bdev->bd_inode->i_size);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * Load $Volume. This should be done before $LogFile
@@ -933,7 +934,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_VOLUME);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $Volume.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	ni = ntfs_i(inode);
@@ -954,19 +956,19 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	} else {
 		/* Should we break mounting here? */
 		//err = -EINVAL;
-		//goto out;
+		//goto put_inode_out;
 	}
 
 	attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL);
 	if (!attr || is_attr_ext(attr)) {
 		err = -EINVAL;
-		goto out;
+		goto put_inode_out;
 	}
 
 	info = resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO);
 	if (!info) {
 		err = -EINVAL;
-		goto out;
+		goto put_inode_out;
 	}
 
 	sbi->volume.major_ver = info->major_ver;
@@ -980,7 +982,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_MIRROR);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $MFTMirr.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	sbi->mft.recs_mirr =
@@ -994,14 +997,15 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_LOGFILE);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load \x24LogFile.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	ni = ntfs_i(inode);
 
 	err = ntfs_loadlog_and_replay(ni, sbi);
 	if (err)
-		goto out;
+		goto put_inode_out;
 
 	iput(inode);
 
@@ -1009,14 +1013,16 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!sb_rdonly(sb)) {
 			ntfs_warn(sb,
 				  "failed to replay log file. Can't mount rw!");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
 		if (!sb_rdonly(sb) && !sbi->options->force) {
 			ntfs_warn(
 				sb,
 				"volume is dirty and \"force\" flag is not set!");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 	}
 
@@ -1027,7 +1033,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_MFT);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $MFT.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	ni = ntfs_i(inode);
@@ -1038,11 +1045,11 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	err = wnd_init(&sbi->mft.bitmap, sb, tt);
 	if (err)
-		goto out;
+		goto put_inode_out;
 
 	err = ni_load_all_mi(ni);
 	if (err)
-		goto out;
+		goto put_inode_out;
 
 	sbi->mft.ni = ni;
 
@@ -1052,7 +1059,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $BadClus.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	ni = ntfs_i(inode);
@@ -1075,13 +1083,14 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_BITMAP);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $Bitmap.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 #ifndef CONFIG_NTFS3_64BIT_CLUSTER
 	if (inode->i_size >> 32) {
 		err = -EINVAL;
-		goto out;
+		goto put_inode_out;
 	}
 #endif
 
@@ -1089,21 +1098,21 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	tt = sbi->used.bitmap.nbits;
 	if (inode->i_size < bitmap_size(tt)) {
 		err = -EINVAL;
-		goto out;
+		goto put_inode_out;
 	}
 
 	/* Not necessary. */
 	sbi->used.bitmap.set_tail = true;
 	err = wnd_init(&sbi->used.bitmap, sb, tt);
 	if (err)
-		goto out;
+		goto put_inode_out;
 
 	iput(inode);
 
 	/* Compute the MFT zone. */
 	err = ntfs_refresh_zone(sbi);
 	if (err)
-		return err;
+		goto out;
 
 	/* Load $AttrDef. */
 	ref.low = cpu_to_le32(MFT_REC_ATTR);
@@ -1111,18 +1120,19 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_ATTRDEF);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $AttrDef -> %d", err);
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	if (inode->i_size < sizeof(struct ATTR_DEF_ENTRY)) {
 		err = -EINVAL;
-		goto out;
+		goto put_inode_out;
 	}
 	bytes = inode->i_size;
 	sbi->def_table = t = kmalloc(bytes, GFP_NOFS);
 	if (!t) {
 		err = -ENOMEM;
-		goto out;
+		goto put_inode_out;
 	}
 
 	for (done = idx = 0; done < bytes; done += PAGE_SIZE, idx++) {
@@ -1131,7 +1141,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
-			goto out;
+			goto put_inode_out;
 		}
 		memcpy(Add2Ptr(t, done), page_address(page),
 		       min(PAGE_SIZE, tail));
@@ -1139,7 +1149,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 		if (!idx && ATTR_STD != t->type) {
 			err = -EINVAL;
-			goto out;
+			goto put_inode_out;
 		}
 	}
 
@@ -1173,12 +1183,13 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $UpCase.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	if (inode->i_size != 0x10000 * sizeof(short)) {
 		err = -EINVAL;
-		goto out;
+		goto put_inode_out;
 	}
 
 	for (idx = 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
@@ -1188,7 +1199,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
-			goto out;
+			goto put_inode_out;
 		}
 
 		src = page_address(page);
@@ -1214,7 +1225,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		/* Load $Secure. */
 		err = ntfs_security_init(sbi);
 		if (err)
-			return err;
+			goto out;
 
 		/* Load $Extend. */
 		err = ntfs_extend_init(sbi);
@@ -1239,19 +1250,30 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_ROOT);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load root.");
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out;
 	}
 
 	sb->s_root = d_make_root(inode);
-	if (!sb->s_root)
-		return -ENOMEM;
+	if (!sb->s_root) {
+		err = -ENOMEM;
+		goto put_inode_out;
+	}
 
 	fc->fs_private = NULL;
-	fc->s_fs_info = NULL;
 
 	return 0;
-out:
+
+put_inode_out:
 	iput(inode);
+out:
+	/*
+	 * Free resources here.
+	 * ntfs_fs_free will be called with fc->s_fs_info = NULL
+	 */
+	put_ntfs(sbi);
+	sb->s_fs_info = NULL;
+
 	return err;
 }
 
-- 
2.33.0

