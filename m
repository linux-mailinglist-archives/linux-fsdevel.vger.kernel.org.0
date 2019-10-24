Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253CAE3715
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409825AbfJXPyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:21 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42794 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409820AbfJXPyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:21 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsJ3k010120
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:19 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsEF9021242
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:19 -0400
Received: by mail-qt1-f200.google.com with SMTP id i25so18529536qtm.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HC8F6K721XcrFfe6PL9r+w9DRvlfMBW1HH2bOAKZbBk=;
        b=tAFoQNH/Ow0KBKCUgcPq61AEvNH/xeBa3TK4kgZntKzRMmBxLIB8taLU8WRx3puTuQ
         U27bssdwRPsLyK46T8fpbbIIM0IR5tXWaE+0pvVWdlN0z+eZtPiy6nE/uMkUMQq7YHV7
         a0AAbWUXwDfPauNfnd4KiwjgROZ+rNt/rRmLs36GzOQqzX1P0Y4NaZZSQJn1C3bpCJes
         SXuDOhcuaTSvzATg6wiYh3QZEa5jwuLscaOv62kIKkimqK0H53JBbovsUKJ3hXdHcIja
         zvAfJwNJj6klfwXj3QDDQ+T47RZ6HNj0qJh6CAkQIJVkoAxJU+jZ54pPY8uQ7xnWYRhl
         CuMw==
X-Gm-Message-State: APjAAAVKKm909Zra1wz3/s3h/aEwEay/JFIVytqI4UDvlq1TU6xMrN/E
        czmJLqMuOCkaQnkkkmHkrgalVv9cY681yx4crEGPKknpdCjq2sisGS3csmZI4bTc1iuILki6HLc
        PVgDzQLqkDUfsiFVparLkanr1GjSLekfyxmED
X-Received: by 2002:a05:620a:a8d:: with SMTP id v13mr2276822qkg.113.1571932453733;
        Thu, 24 Oct 2019 08:54:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzXZCBzmmQ+hEAhyBvlB5KizY+kshvHx0pXuyB03RkLB5Z9bOBJFYlqXoD+NPrxM3nFlZCkw==
X-Received: by 2002:a05:620a:a8d:: with SMTP id v13mr2276794qkg.113.1571932453397;
        Thu, 24 Oct 2019 08:54:13 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:12 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] staging: exfat: Clean up return codes - FFS_PERMISSIONERR
Date:   Thu, 24 Oct 2019 11:53:15 -0400
Message-Id: <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_PERMISSIONERR to -EPERM

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index ec52237b01cd..86bdcf222a5a 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -217,7 +217,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_INVALIDPATH         7
 #define FFS_INVALIDFID          8
 #define FFS_FILEEXIST           10
-#define FFS_PERMISSIONERR       11
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 566cfba0a522..fd5d8ba0d8bc 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -702,7 +702,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 
@@ -832,7 +832,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 
@@ -1079,7 +1079,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 
@@ -1246,7 +1246,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	/* check if the old file is "." or ".." */
 	if (p_fs->vol_type != EXFAT) {
 		if ((olddir.dir != p_fs->root_dir) && (dentry < 2)) {
-			ret = FFS_PERMISSIONERR;
+			ret = -EPERM;
 			goto out2;
 		}
 	}
@@ -1258,7 +1258,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	}
 
 	if (p_fs->fs_func->get_entry_attr(ep) & ATTR_READONLY) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out2;
 	}
 
@@ -1365,7 +1365,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 	}
 
 	if (p_fs->fs_func->get_entry_attr(ep) & ATTR_READONLY) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 	fs_set_vol_flags(sb, VOL_DIRTY);
@@ -1947,7 +1947,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_DIR)
-		return FFS_PERMISSIONERR;
+		return -EPERM;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -2145,7 +2145,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	/* check if the file is "." or ".." */
 	if (p_fs->vol_type != EXFAT) {
 		if ((dir.dir != p_fs->root_dir) && (dentry < 2))
-			return FFS_PERMISSIONERR;
+			return -EPERM;
 	}
 
 	/* acquire the lock for file system critical section */
@@ -2526,7 +2526,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
 	if (err) {
-		if (err == FFS_PERMISSIONERR)
+		if (err == -EPERM)
 			err = -EPERM;
 		else
 			err = -EIO;
@@ -2746,7 +2746,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
 			  new_dentry);
 	if (err) {
-		if (err == FFS_PERMISSIONERR)
+		if (err == -EPERM)
 			err = -EPERM;
 		else if (err == FFS_INVALIDPATH)
 			err = -EINVAL;
-- 
2.23.0

