Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F245A1CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhKWLqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236433AbhKWLqL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:46:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A32261027;
        Tue, 23 Nov 2021 11:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667784;
        bh=T7f6WBqgp2U6M4loI06LQzaawNL0KiQoFLP49st20J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMRQ8dYZ051wxIgV/Iq9lTaFOJavMHRRB/UQhQjkakInuk6fB3PC0AtRbmOPYu3T1
         MPBEdqxEvpNUwUCPvCyLZG92sFFYhfO1BRIU0vmUt2g6Fge6CHh6iDsH1s+fxxlWui
         OucJ1KG6oqWBGdO7itG4ouNxL4ah+MDreLtzI/yVMCeIAS+IJlrjVSBvYUJREjqlOm
         GjXHxxE83CQac4XTEenhuqGmUCy26swgOmtsl9/44eWgp3rwZ1HLWDxHnP90FMZFv7
         dFzJHOErQtCQiXFM2oqxBA/C8Un5yUwmLPhYwUGghZlT2glq/LVhDEnmAPSZZPLgzb
         +7AT6PKK3FSAw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 09/10] fs: add i_user_ns() helper
Date:   Tue, 23 Nov 2021 12:42:26 +0100
Message-Id: <20211123114227.3124056-10-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; h=from:subject; bh=57H4mwOXSX3LItSH+nEABlp+xgcA/0JQxXskSPgYjuI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVzm5MTGNft698rzh9OvWMgJuv/O67m+1vOuWbHFYV57 ycfuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ8IuR4eFvVbvt/Fdtmg/vVt3281 zI/VLHpfriVWpfE6U/qvkyezEyzM2PcMuSKowVfvrsZIVx/8nlfXpT9+RN2lBmeiEhz283DwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Since we'll be passing the filesystem's idmapping in even more places in
the following patches and we do already dereference struct inode to get
to the filesystem's idmapping multiple times add a tiny helper.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/fs.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ccb0e7f8801..c1780be923fa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1600,6 +1600,11 @@ struct super_block {
 	struct list_head	s_inodes_wb;	/* writeback inodes */
 } __randomize_layout;
 
+static inline struct user_namespace *i_user_ns(const struct inode *inode)
+{
+	return inode->i_sb->s_user_ns;
+}
+
 /* Helper functions so that in most cases filesystems will
  * not need to deal directly with kuid_t and kgid_t and can
  * instead deal with the raw numeric values that are stored
@@ -1607,22 +1612,22 @@ struct super_block {
  */
 static inline uid_t i_uid_read(const struct inode *inode)
 {
-	return from_kuid(inode->i_sb->s_user_ns, inode->i_uid);
+	return from_kuid(i_user_ns(inode), inode->i_uid);
 }
 
 static inline gid_t i_gid_read(const struct inode *inode)
 {
-	return from_kgid(inode->i_sb->s_user_ns, inode->i_gid);
+	return from_kgid(i_user_ns(inode), inode->i_gid);
 }
 
 static inline void i_uid_write(struct inode *inode, uid_t uid)
 {
-	inode->i_uid = make_kuid(inode->i_sb->s_user_ns, uid);
+	inode->i_uid = make_kuid(i_user_ns(inode), uid);
 }
 
 static inline void i_gid_write(struct inode *inode, gid_t gid)
 {
-	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
+	inode->i_gid = make_kgid(i_user_ns(inode), gid);
 }
 
 /**
-- 
2.30.2

