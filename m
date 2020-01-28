Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74E14C37C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgA1XTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33947 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so7835588pgf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=reRZ27o860Jv4T3ywX/rAzqX7TYE/u2uK3SOSUVyejw=;
        b=k7VP/rublHHD1ZcKcCqFqjLNukGtmMxMUSabaKVQ1Fwz1AluQTI3ayFYmv2MkoF8sF
         KTnrpMybeItuOdPPq8QNM8hAZKGcMERONy66EiZ6sgIOlU9Ht/eHzyoRCcVxAmGrKtoH
         eXdXweTv2a9FwCljg7C9XtUIIPlFp9yUk9fVNEFGe2b+FIL+/MbH+dtov51wmF2oTTXn
         LOYUvY97j74rE084/4VDRjjc23mXQnX89NTJ9rSPvixJX9iPq7+pCFshPzOIAwqV4361
         nVL8ac5ons437JDTQda5WWraX7VZTjVK06CyTy1JZeArXIv8ruU8X6qcNALUObs/XedA
         7LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reRZ27o860Jv4T3ywX/rAzqX7TYE/u2uK3SOSUVyejw=;
        b=YBozDTX2fezS6eU+mqOc5NPdmJBCoLezwRLKloU89Y5tjsjucqgHhDeB1Zf7TkIy+j
         qY+Mk6wuaw8DFbgjImiFtnLO5JNXl7lly1j21KW3zwYQV7KPNw/+bXV1K4TL/JtGMIAP
         wCR343hZovhRTIxRQ1xMcSSHBLaSnKErvbVy7nl/fDEjWXpeWpjU+KB0r6Y7ClmowLBO
         CHbjJfNpeXLzFZFf6tyxnoiCWNjzUICqZh5wj4RMO4LL0wtAED0WSQsfR1oIgMfqsjsV
         bbxbeR9k3ojn91LJ2VohbDsiL30AYIE3VmEuXd/qUPus6rAJ2RjwL06n7x/IkoSqcQOO
         0dEA==
X-Gm-Message-State: APjAAAVs0GSGYqsww1jITZyHz/8C98e4Q6YFuL87lybCor0atV0tXk1K
        QCUMZYaW0YmJ5S+6xSjdMzui2Y0aIGc=
X-Google-Smtp-Source: APXvYqyLrtk0AAf0tz/DjYLGdjS0KGKKZ1P60pGJXzi0fJBMwOkOU2/a7LcF5zo8zm0wSPvnVAwbtw==
X-Received: by 2002:a63:e609:: with SMTP id g9mr9889417pgh.75.1580253556349;
        Tue, 28 Jan 2020 15:19:16 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:15 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com
Subject: [RFC PATCH v4 3/4] Btrfs: fix inode reference count leak in btrfs_link() error path
Date:   Tue, 28 Jan 2020 15:19:02 -0800
Message-Id: <885829e37b0cdf75e26f4605e34110a7b23fe162.1580251857.git.osandov@fb.com>
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

If btrfs_update_inode() or btrfs_orphan_del() fails in btrfs_link(),
then we don't drop the reference we got with ihold(). This results in
the "VFS: Busy inodes after unmount" crash.

The reference is needed for the new dentry, so get it right before we
instantiate the dentry.

Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error handling")
[Although d_instantiate() was moved further from ihold() before that, in
commit 08c422c27f85 ("Btrfs: call d_instantiate after all ops are setup")]
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bc7709c4f6eb..8c9a114f48f6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6801,7 +6801,6 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	inc_nlink(inode);
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
-	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
@@ -6825,6 +6824,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 			if (err)
 				goto fail;
 		}
+		ihold(inode);
 		d_instantiate(dentry, inode);
 		ret = btrfs_log_new_name(trans, BTRFS_I(inode), NULL, parent,
 					 true, NULL);
@@ -6837,10 +6837,8 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 fail:
 	if (trans)
 		btrfs_end_transaction(trans);
-	if (drop_inode) {
+	if (drop_inode)
 		inode_dec_link_count(inode);
-		iput(inode);
-	}
 	btrfs_btree_balance_dirty(fs_info);
 	return err;
 }
-- 
2.25.0

