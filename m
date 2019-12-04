Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89E11385A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 00:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfLDXqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 18:46:34 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36759 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLDXqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:46:34 -0500
Received: by mail-pg1-f201.google.com with SMTP id v10so717979pgg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XbMDMBiURPy3ztmL5BAB2zOV5tyLvPs4cZrgza5Nb04=;
        b=vvoOr97XSjgqRQXRYI8xsRGNB6sMUmPJTH35AVLEBHzUCUIf4TKeH576HHqX2DdT0w
         DhkNeyy0KVEz2UHvNOJCElCM2pXaipK4dATie/v1T8VW/ccwD1N0GFTfowS08R32R1SI
         +apUVj/M3+8f8mDGLFFC94QGu82UmZUQrHi0cMEPAnZ9V/l7nxaNUos7BqQ8bONSu77b
         elzOYuGfWpDdmLcLjbijtSEn/4qf5nzJdt1AFxRQsf3rOyD09xoS07pye9fewtGQ/USy
         M9kZ2gfcTq7zc9Bwb/bv3Z0+6u7faqvqCb6Zr0iadYYGSy5kwc/GvSJ90Btej1GZgtnk
         2m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XbMDMBiURPy3ztmL5BAB2zOV5tyLvPs4cZrgza5Nb04=;
        b=lovsT4as2bo+HPon/kcyXssrPG1MrxAXbyS0vMY7dmD4WIk4PwxJFJRhhEYwcLHUqH
         ZBL1s2KxV10VwOAxZc/W7vcYgA+HhjP1PmKPq0l+yEWNnzcIAyJpqyiPQJUk4PrO/B2O
         D9udlxH2i91sCqQchSnYc9bC9ShWX4BCWFY4TT5qMfCTDJ2y5sIl1LXsiNKpZSjabuBv
         WIpjGBNzbosVVNxl44WN+93vy5bgxCtMBLF/814P6s6w4mkkOajAJhaaQgtK7bNu+63c
         zHdpnGKaY/QxYWm+dGXLfqpqfnSHqr9Sb4RBLBwE/qJ5MC6qEKiUcxgh4zEwo2eCVxwK
         7TkQ==
X-Gm-Message-State: APjAAAW6HQVg8AlZ+pUGWTfv8s7mmfTwjWbzTBA776GBuUvL3dR8tDZs
        vfbsSL36ahNYdVZPUiVaM/2zwb7IjLAT0kclU0ZmzA==
X-Google-Smtp-Source: APXvYqz47avrpcjXVQ+1KDiyygY87m+93a0IsuajGxXEGgl8sxMDZj0iTIaMcFs25SnHdkR0uy27q47QcmEbuf3o5rKViw==
X-Received: by 2002:a65:56c9:: with SMTP id w9mr6061182pgs.296.1575503193275;
 Wed, 04 Dec 2019 15:46:33 -0800 (PST)
Date:   Wed,  4 Dec 2019 15:45:22 -0800
Message-Id: <20191204234522.42855-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v1] staging: exfat: fix multiple definition error of `rename_file'
From:   Brendan Higgins <brendanhiggins@google.com>
To:     valdis.kletnieks@vt.edu
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

`rename_file' was exported but not properly namespaced causing a
multiple definition error because `rename_file' is already defined in
fs/hostfs/hostfs_user.c:

ld: drivers/staging/exfat/exfat_core.o: in function `rename_file':
drivers/staging/exfat/exfat_core.c:2327: multiple definition of
`rename_file'; fs/hostfs/hostfs_user.o:fs/hostfs/hostfs_user.c:350:
first defined here
make: *** [Makefile:1077: vmlinux] Error 1

This error can be reproduced on ARCH=um by selecting:

CONFIG_EXFAT_FS=y
CONFIG_HOSTFS=y

Add a namespace prefix exfat_* to fix this error.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/exfat/exfat.h       | 4 ++--
 drivers/staging/exfat/exfat_core.c  | 4 ++--
 drivers/staging/exfat/exfat_super.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2aac1e000977e..51c665a924b76 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -805,8 +805,8 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 s32 create_file(struct inode *inode, struct chain_t *p_dir,
 		struct uni_name_t *p_uniname, u8 mode, struct file_id_t *fid);
 void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry);
-s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
-		struct uni_name_t *p_uniname, struct file_id_t *fid);
+s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
+		      struct uni_name_t *p_uniname, struct file_id_t *fid);
 s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	      struct chain_t *p_newdir, struct uni_name_t *p_uniname,
 	      struct file_id_t *fid);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d2d3447083c7b..7017e22b0f7a8 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2322,8 +2322,8 @@ void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry)
 	fs_func->delete_dir_entry(sb, p_dir, entry, 0, num_entries);
 }
 
-s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
-		struct uni_name_t *p_uniname, struct file_id_t *fid)
+s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
+		      struct uni_name_t *p_uniname, struct file_id_t *fid)
 {
 	s32 ret, newentry = -1, num_old_entries, num_new_entries;
 	sector_t sector_old, sector_new;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6e481908c59f6..9f91853b189b0 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1262,8 +1262,8 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	fs_set_vol_flags(sb, VOL_DIRTY);
 
 	if (olddir.dir == newdir.dir)
-		ret = rename_file(new_parent_inode, &olddir, dentry, &uni_name,
-				  fid);
+		ret = exfat_rename_file(new_parent_inode, &olddir, dentry,
+					&uni_name, fid);
 	else
 		ret = move_file(new_parent_inode, &olddir, dentry, &newdir,
 				&uni_name, fid);
-- 
2.24.0.393.g34dc348eaf-goog

