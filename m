Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985F4F86B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKLCK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:10:59 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45752 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727226AbfKLCK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:58 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2Avrt028453
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:57 -0500
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2AqTe006382
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:57 -0500
Received: by mail-qv1-f72.google.com with SMTP id d12so7518672qvm.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mKMDzYn7O8CzU1QL2MbSfadNjjAv2gJEQl4nRG3tJ/I=;
        b=p7XnmqhTa8xkytHyCkLBRFTC5QKdrP9e3N1mV6bsRAHDuMMCVnqJXEaocr6ap7zUcu
         WD2Ri1VePd6Ak7rBR+MOf/vqx2LXK+PHmp2ZYy0YL33MNasTSX48qvLA5InObMyWU4TY
         6G/TPahQNzMBsZA1fEMdZNISCa1IDlZjYp18tXNFxgfuz0xLi3nOzAA5podMWP7VAfxB
         QNbZiAj8OnvcI2mOXjsdApY53VNVEU3LV/6Q/ydg1SFFZ+ZIvpqNs8J0IuQMdEHnOMA4
         RPGPM186iRl1qLDoBEYizsMvA1HsrZ4e5xAzIOZHjmG3x7BT3Szcx2Nnk5oUoFqN5Mij
         N/Xw==
X-Gm-Message-State: APjAAAWK2HgaIlt1jDRJB+xHwjmKpok7HZk6HwhfyKFV27slFgmiVPmM
        BmxfOJO4p4CrO55T1/UyyzoopDuzpX81SdZxCkDVVwBjXCT5V8SC5tRw3ssKONe+pRqjKtj0DcA
        OMRfrhhzkFnsbIvdav4+0O6LXS7d1WnitgBWf
X-Received: by 2002:ae9:ef0a:: with SMTP id d10mr12907174qkg.262.1573524651816;
        Mon, 11 Nov 2019 18:10:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBCHnK5zn+Y3sfl5pBsECOdz/SspzS/RWeqUG1JiE5JC74y8qvdBI3OPJ3biaNwpctsllt/w==
X-Received: by 2002:ae9:ef0a:: with SMTP id d10mr12907161qkg.262.1573524651460;
        Mon, 11 Nov 2019 18:10:51 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:50 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] staging: exfat: Collapse redundant return code translations
Date:   Mon, 11 Nov 2019 21:09:56 -0500
Message-Id: <20191112021000.42091-9-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we no longer use odd internal return codes, we can
heave the translation code over the side, and just pass the
error code back up the call chain.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat_super.c | 92 +++++------------------------
 1 file changed, 14 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5d538593b5f6..a97a61a60517 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -650,7 +650,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	struct uni_name_t uni_name;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	int ret;
+	int ret = 0;
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
@@ -2366,19 +2366,9 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	pr_debug("%s entered\n", __func__);
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else if (err == -ENAMETOOLONG)
-			err = -ENAMETOOLONG;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_ctime = curtime;
@@ -2543,13 +2533,9 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
 	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
-	if (err) {
-		if (err == -EPERM)
-			err = -EPERM;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_mtime = curtime;
@@ -2589,27 +2575,14 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 	pr_debug("%s entered\n", __func__);
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 
 	err = ffsWriteFile(dir, &fid, (char *)target, len, &ret);
 
 	if (err) {
 		ffsRemoveFile(dir, &fid);
-
-		if (err == -ENOSPC)
-			err = -ENOSPC;
-		else
-			err = -EIO;
 		goto out;
 	}
 
@@ -2666,19 +2639,9 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	pr_debug("%s entered\n", __func__);
 
 	err = ffsCreateDir(dir, (u8 *)dentry->d_name.name, &fid);
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else if (err == -ENAMETOOLONG)
-			err = -ENAMETOOLONG;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_ctime = curtime;
@@ -2727,19 +2690,9 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
 	err = ffsRemoveDir(dir, &(EXFAT_I(inode)->fid));
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -ENOTEMPTY;
-		else if (err == -ENOENT)
-			err = -ENOENT;
-		else if (err == -EBUSY)
-			err = -EBUSY;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_mtime = curtime;
@@ -2787,21 +2740,9 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
 			  new_dentry);
-	if (err) {
-		if (err == -EPERM)
-			err = -EPERM;
-		else if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOENT)
-			err = -ENOENT;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(new_dir);
 	curtime = current_time(new_dir);
 	new_dir->i_ctime = curtime;
@@ -3161,12 +3102,7 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	err = ffsMapCluster(inode, clu_offset, &cluster);
 
-	if (err) {
-		if (err == -ENOSPC)
-			return -ENOSPC;
-		else
-			return -EIO;
-	} else if (cluster != CLUSTER_32(~0)) {
+	if (!err && (cluster != CLUSTER_32(~0))) {
 		*phys = START_SECTOR(cluster) + sec_offset;
 		*mapped_blocks = p_fs->sectors_per_clu - sec_offset;
 	}
-- 
2.24.0

