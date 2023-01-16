Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FED66B975
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 09:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjAPIz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 03:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjAPIzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:55:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D98F777
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 00:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NG71ox6jr7uM23QDAMDsMfdxiN0WqWQj6pY4BZkkyg4=; b=ax/Y5gnTZrhv4w+jf2OeQVm0tO
        ApYJIKsK4ZXfMVwKWlqPdLSJGP7kZIKwE+8CcUbfwwIAFByrMjNSd07pUOBcF66nJ5xWCREc2zMkU
        6mQdASNdx+VRTkGlDR6nv34V1Gyn0I0mgWr5vC6NPNwqutc4UvBh0Fclq2irNimI4eewwgg36uQdO
        fLLkCZXLsoD2eFF6L1iPPsq0srwwA50/WBOJGtJgd6NxY3jjsggeAISiUmyxXvl/WudhRuyFHtfm1
        mUmQWnGtNpkbvWi694jhOU5G5hCEQcsB1/CbOSDSPOS+AuNO46i3WVwUrCXrGG3oKZbpzYuFdcpMd
        vHS2daEQ==;
Received: from [2001:4bb8:19a:2039:c63c:c37c:1cda:3fb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHLH8-009EfR-M6; Mon, 16 Jan 2023 08:55:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/6] minix: fix error handling in minix_set_link
Date:   Mon, 16 Jan 2023 09:55:19 +0100
Message-Id: <20230116085523.2343176-3-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116085523.2343176-1-hch@lst.de>
References: <20230116085523.2343176-1-hch@lst.de>
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
 fs/minix/dir.c   | 23 ++++++++++++-----------
 fs/minix/minix.h |  3 ++-
 fs/minix/namei.c |  8 +++++---
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index a8e76284cb71ec..c9a3d520b72671 100644
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
@@ -420,20 +420,21 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
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
+		goto out_put_page;
 	}
-	dir_put_page(page);
+	if (sbi->s_version == MINIX_V3)
+		((minix3_dirent *)de)->inode = inode->i_ino;
+	else
+		de->inode = inode->i_ino;
+	err = dir_commit_chunk(page, pos, sbi->s_dirsize);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
+out_put_page:
+	dir_put_page(page);
+	return err;
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
index 8afdc408ca4fd5..82d46c28f01b01 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -223,7 +223,9 @@ static int minix_rename(struct user_namespace *mnt_userns,
 		new_de = minix_find_entry(new_dentry, &new_page);
 		if (!new_de)
 			goto out_dir;
-		minix_set_link(new_de, new_page, old_inode);
+		err = minix_set_link(new_de, new_page, old_inode);
+		if (err)
+			goto out_dir;
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -240,10 +242,10 @@ static int minix_rename(struct user_namespace *mnt_userns,
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
-		minix_set_link(dir_de, dir_page, new_dir);
+		err = minix_set_link(dir_de, dir_page, new_dir);
 		inode_dec_link_count(old_dir);
 	}
-	return 0;
+	return err;
 
 out_dir:
 	if (dir_de) {
-- 
2.39.0

