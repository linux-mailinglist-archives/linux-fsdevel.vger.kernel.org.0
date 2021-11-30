Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBAA4633F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 13:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbhK3MOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:14:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36694 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbhK3MOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:14:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC36ECE1870
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 12:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B972C53FCD;
        Tue, 30 Nov 2021 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638274271;
        bh=RgP8In7/6boca7TSVetRH1Upid8nJj238ZhJL+xxEFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MO0/pZZVSN2KVgLOhv9xLs+D3azWg985lAHAwnZ/Nz9QuQv7qCk15p4KVGd+R+n65
         lC2sIjySeKt9+fHkDgQi76sJ2xVhS/Ev+GmYfe3Em4J99R6UFpIKQ7rLUGnOqCkJSP
         533TYFDLseYEcV26M7gnq7CrOsxt92aHoP9rO9ikITkrUofU60huwdFl9Z3xurz2TI
         S6w+00NTvycUmFyB4niP+0wM/YLNxlXM9W2p633UtA7HebO9/bXWzk5u8MfLWwKkwc
         d6ZO7Crsvipo0DI2ltA+j62khF9XV7bAurEQX4gGI/udN6aGThSSdwbDPNunagmg/1
         vyISS1kesgmQA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 09/10] fs: add i_user_ns() helper
Date:   Tue, 30 Nov 2021 13:10:31 +0100
Message-Id: <20211130121032.3753852-10-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130121032.3753852-1-brauner@kernel.org>
References: <20211130121032.3753852-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; h=from:subject; bh=qAUN5/bulMtQgxwb10BJLSvtad2xJA67G4ll0OsajUg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQuE1mtl6OUsS9Vvu77VzVJkx+mf9db/fRoFPqute/Tz++P PnYJdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkVDnD/5S7L//kxDMc79p4703S0l lK5+6vjHrhLMi18bbWdFv3LGOG/57PLWI+Rlpb6VgFWF+3re6NmqD3eHbp5tl9PqemGjV5MQIA
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
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 include/linux/fs.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7c0499b63a02..c7f72b78ab7e 100644
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

