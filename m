Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446AF6724F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjARRba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjARRbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:31:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C5D577F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 09:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IK5go+LYlZzyyL0UG1E7ybATwbkUdMWL1x4AyvlHUwI=; b=22EHDJ091Mc3KuCstacxTn+6U1
        TtnzRBznDgrz0So3oaYkMeFGRgj57zvpXYFUDSdqIZCgYRkHBvwHfNjsXzrP/xQqOVenmai+nAW05
        fAdQseByMb+clpStiSc1jaAggo5QN6wpqlWBa4LFiuGeCZQTwywEGcNFv57TECBX0jtat3EobXTs3
        AAuTXZlnaD8uWKiY541D53Z2S5GCsZPQrhEooQxpEasFeFqVjWXpIG4T+M4rZXyBOYzvSLrlcDucJ
        OM2qASNW5swyWRdm0BMqklqdwx4TTiiRsUbp0AvE/p/fb51scw/1RLWSo3a+Nh0FNvVDREyxuYrqN
        vC+yzHTQ==;
Received: from [2001:4bb8:19a:2039:cce7:a1cd:f61c:a80d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICGk-002298-Oz; Wed, 18 Jan 2023 17:30:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 3/7] minix: fix error handling in minix_set_link
Date:   Wed, 18 Jan 2023 18:30:23 +0100
Message-Id: <20230118173027.294869-4-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173027.294869-1-hch@lst.de>
References: <20230118173027.294869-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If minix_prepare_chunk fails, updating c/mtime and marking the
dir inode dirty is wrong, as the inode hasn't been modified.  Also
propagate the error to the caller.

Note that this moves the dir_put_page call later, but that matches
other uses of this helper in the directory code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/minix/dir.c   | 22 ++++++++++++----------
 fs/minix/minix.h |  3 ++-
 fs/minix/namei.c | 10 ++++++----
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 242e179aa1fbeb..34c1cdb5dc7d47 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -410,8 +410,8 @@ int minix_empty_dir(struct inode * inode)
 }
 
 /* Releases the page */
-void minix_set_link(struct minix_dir_entry *de, struct page *page,
-	struct inode *inode)
+int minix_set_link(struct minix_dir_entry *de, struct page *page,
+		struct inode *inode)
 {
 	struct inode *dir = page->mapping->host;
 	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
@@ -420,19 +420,21 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
 	int err;
 
 	lock_page(page);
-
 	err = minix_prepare_chunk(page, pos, sbi->s_dirsize);
-	if (err == 0) {
-		if (sbi->s_version == MINIX_V3)
-			((minix3_dirent *) de)->inode = inode->i_ino;
-		else
-			de->inode = inode->i_ino;
-		err = dir_commit_chunk(page, pos, sbi->s_dirsize);
-	} else {
+	if (err) {
 		unlock_page(page);
+		return err;
 	}
+	if (sbi->s_version == MINIX_V3)
+		((minix3_dirent *)de)->inode = inode->i_ino;
+	else
+		de->inode = inode->i_ino;
+	err = dir_commit_chunk(page, pos, sbi->s_dirsize);
+	if (err)
+		return err;
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
+	return 0;
 }
 
 struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 20217336802570..8f7a636bd1b241 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -69,7 +69,8 @@ extern int minix_add_link(struct dentry*, struct inode*);
 extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
 extern int minix_make_empty(struct inode*, struct inode*);
 extern int minix_empty_dir(struct inode*);
-extern void minix_set_link(struct minix_dir_entry*, struct page*, struct inode*);
+int minix_set_link(struct minix_dir_entry *de, struct page *page,
+		struct inode *inode);
 extern struct minix_dir_entry *minix_dotdot(struct inode*, struct page**);
 extern ino_t minix_inode_by_name(struct dentry*);
 
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 5fc696e032c543..bfbadd85d01032 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -223,10 +223,11 @@ static int minix_rename(struct user_namespace *mnt_userns,
 		new_de = minix_find_entry(new_dentry, &new_page);
 		if (!new_de)
 			goto out_dir;
-		err = 0;
-		minix_set_link(new_de, new_page, old_inode);
+		err = minix_set_link(new_de, new_page, old_inode);
 		kunmap(new_page);
 		put_page(new_page);
+		if (err)
+			goto out_dir;
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -243,8 +244,9 @@ static int minix_rename(struct user_namespace *mnt_userns,
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
-		minix_set_link(dir_de, dir_page, new_dir);
-		inode_dec_link_count(old_dir);
+		err = minix_set_link(dir_de, dir_page, new_dir);
+		if (!err)
+			inode_dec_link_count(old_dir);
 	}
 out_dir:
 	if (dir_de) {
-- 
2.39.0

