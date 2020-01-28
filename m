Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5877514C37E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgA1XTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33847 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgA1XTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so7458760pfc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6Stw5XLuw1I+mUTM2ZMnaa8NrTgZtVImtXCq57YVRU=;
        b=RFgyhC5Uwml2GvUyl4zHP5bprSEvv8VdlsTBaqiy+fSmEb5op2vLsDqlPjEI0MD5r1
         ahUwDSwBppg8UvT32kIafVYeeb+BPVaYTIGbGTZ9ButSfBDSB7rJxktWnhOXULWZhU91
         vtiY5nv9m56nsdF4daRLrL99BV8u8mdUxqSu7AE2JkNcklilDA9sTMSdmN0SFlkEXHKz
         9fV5/QRZR3rOg1vauuHX0NWZrb8xPFUgKKPqR6gaNfsAsgXdrVEdebTyOfhma125wcFz
         PSrhmxYvidrcz3Ml+DT7DlOzFbbqsmhIApVIhswNDBw0IJTp5v3ysEQ7lkymcrY2TJ1d
         mOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6Stw5XLuw1I+mUTM2ZMnaa8NrTgZtVImtXCq57YVRU=;
        b=idG11Pkrloc7vG02K5CD2/RmDSJ/SQ7tx7wFaJzjogME51rDz3ec20iZXG/oABhd70
         YzI5BYx/q+o+weRFkPxOeAFVJps8v0/LsgrCr3FY1n60fmD4enNwg8+ctnTwJRJUaJdT
         Tn//oi1LOJA8um5nBhsJ/2pPjuxwH+WNMhzXL+PQbXEZrS7MIzOr6HdDSwS6a+yMWa31
         VmdR72MoMwGGChtW0buj5HUJbrEcHMm43no33VoygJrPNNWz5bWKzfF02ahV512v+r6d
         5l3COxT4brvHdAQI/kF33QFN4sPDpefzXUKo4QcgxeiJxsikuF4HZb5uWYFHkFDwwBeq
         THYg==
X-Gm-Message-State: APjAAAWxGJos9Som48zWpk5MdOkX8Rbi0Z9E4QS0N/HRsFXYo2CvBuTl
        lNKdCmDBPT2FOTv9EEu+IYhnjLzMIzY=
X-Google-Smtp-Source: APXvYqy0046n0TvTbyNHFlnK51YBnlDLjq2SU/8lHTvT0zs0UNl1J2DKZUv26G8Wo/r9bZOzfNnQnQ==
X-Received: by 2002:a63:584:: with SMTP id 126mr26906962pgf.100.1580253557351;
        Tue, 28 Jan 2020 15:19:17 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:16 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com
Subject: [RFC PATCH v4 4/4] Btrfs: add support for linkat() AT_REPLACE
Date:   Tue, 28 Jan 2020 15:19:03 -0800
Message-Id: <55e3795a385177f13cde7041fe7a5e1644994879.1580251857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The implementation is fairly straightforward and looks a lot like
btrfs_rename(). The only tricky bit is that instead of playing games
with the dcache, we simply drop the dentry for it to be instantiated on
the next lookup. This can be improved in the future.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8c9a114f48f6..b489671d1b5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6762,14 +6762,16 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 		      struct dentry *dentry, int flags)
 {
 	struct btrfs_trans_handle *trans = NULL;
+	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = d_inode(old_dentry);
+	struct inode *new_inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 index;
 	int err;
 	int drop_inode = 0;
 
-	if (flags)
+	if (flags & ~AT_LINK_REPLACE)
 		return -EINVAL;
 
 	/* do not allow sys_link's with other subvols of the same device */
@@ -6779,17 +6781,50 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink >= BTRFS_LINK_MAX)
 		return -EMLINK;
 
+	/* check for collisions, even if the name isn't there */
+	err = btrfs_check_dir_item_collision(root, dir->i_ino,
+					     dentry->d_name.name,
+					     dentry->d_name.len);
+	if (err) {
+		if (err == -EEXIST) {
+			if (WARN_ON(!new_inode))
+				return err;
+		} else {
+			return err;
+		}
+	}
+
+	/*
+	 * we're using link to replace one file with another. Start IO on it now
+	 * so we don't add too much work to the end of the transaction
+	 */
+	if (new_inode && S_ISREG(inode->i_mode) && new_inode->i_size)
+		filemap_flush(inode->i_mapping);
+
 	err = btrfs_set_inode_index(BTRFS_I(dir), &index);
 	if (err)
 		goto fail;
 
 	/*
+	 * For the source:
 	 * 2 items for inode and inode ref
 	 * 2 items for dir items
 	 * 1 item for parent inode
 	 * 1 item for orphan item deletion if O_TMPFILE
+	 *
+	 * For the target:
+	 * 1 for the possible orphan item
+	 * 1 for the dir item
+	 * 1 for the dir index
+	 * 1 for the inode ref
+	 * 1 for the inode
 	 */
-	trans = btrfs_start_transaction(root, inode->i_nlink ? 5 : 6);
+	trans_num_items = 5;
+	if (!inode->i_nlink)
+		trans_num_items++;
+	if (new_inode)
+		trans_num_items += 5;
+	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		trans = NULL;
@@ -6801,6 +6836,22 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	inc_nlink(inode);
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
+
+	if (new_inode) {
+		inode_inc_iversion(new_inode);
+		new_inode->i_ctime = current_time(new_inode);
+		err = btrfs_unlink_inode(trans, root, BTRFS_I(dir),
+					 BTRFS_I(new_inode),
+					 dentry->d_name.name,
+					 dentry->d_name.len);
+		if (!err && new_inode->i_nlink == 0)
+			err = btrfs_orphan_add(trans, BTRFS_I(new_inode));
+		if (err) {
+			btrfs_abort_transaction(trans, err);
+			goto fail;
+		}
+	}
+
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
@@ -6824,8 +6875,12 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 			if (err)
 				goto fail;
 		}
-		ihold(inode);
-		d_instantiate(dentry, inode);
+		if (new_inode) {
+			d_drop(dentry);
+		} else {
+			ihold(inode);
+			d_instantiate(dentry, inode);
+		}
 		ret = btrfs_log_new_name(trans, BTRFS_I(inode), NULL, parent,
 					 true, NULL);
 		if (ret == BTRFS_NEED_TRANS_COMMIT) {
-- 
2.25.0

