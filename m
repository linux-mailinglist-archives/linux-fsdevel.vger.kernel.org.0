Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD98467610
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380347AbhLCLVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:21:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38616 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380345AbhLCLVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:21:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB4462A26
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D5FC53FD1;
        Fri,  3 Dec 2021 11:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530273;
        bh=hJRX4yYgdHf7g/RAfNld3g6K6yjW/0pDCsyKaJiELng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiNlqAk9raWLFJmf8JqArcjAQmp/A5Lt70qhoWExFSOSqfD1gX9LEqDTbW6GtqWoI
         nZzUVyrNoRg9AO7EJcWvdfjEYJzqhECqim4blK/KUO7ryYLly67T5oPtsfBh0WHuxz
         b4GzRAku6+yVVljK/KYvj1cdjZs7CNBVItcRyyujio7vrG6s+dMv/DZFqqftSqflxO
         AFdH0DENbRVJOeadenJQZ5MkDdzF3aa4a8PBbw40TO3TAAJXXZgiCP4Jf5eyvALYAf
         2ZUzJQH6y0Khk+ToL7VQyveVJhzMBqAvYukp72Oeo2mEcPo1EA77228vYvBQo0BAM2
         fmnNFo+lqXmwQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 09/10] fs: add i_user_ns() helper
Date:   Fri,  3 Dec 2021 12:17:06 +0100
Message-Id: <20211203111707.3901969-10-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242; h=from:subject; bh=ZWHnZsq46NldAzTatnBYYucvlzPx581yvfUzGUEIcFw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DNjm+VnBf/QkM6I+3ekLOIUprOx/jjVqMcrmiNW1xCV nd7fUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGvdxkZpl7++CFZ7wqPW9crf6eais 8hd0qkemfHxigU/eE/9PyFAMP/2KaXky4bhla9ED2oIVDBKfdFi+OKRlTjxC+CQcWRuqe4AQ==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Since we'll be passing the filesystem's idmapping in even more places in
the following patches and we do already dereference struct inode to get
to the filesystem's idmapping multiple times add a tiny helper.

Link: https://lore.kernel.org/r/20211123114227.3124056-10-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-10-brauner@kernel.org (v2)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 include/linux/fs.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e1f28f757f1b..3d6d514943ab 100644
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

