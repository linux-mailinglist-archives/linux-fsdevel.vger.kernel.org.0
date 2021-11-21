Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3F645833A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Nov 2021 13:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhKUMPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 07:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbhKUMPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 07:15:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13226C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Nov 2021 04:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ouYiQ9fnPFu7NekPPdm7DFBi+ugK3ZRRR9rHUiq0t4k=; b=fXIE7e4hsOcVU/pG1gGnX7PW3F
        yANf8yBK3y9rtbu5JLWuhg/w+i1F3OjkJOhb29AVb6ov7JDNsfhkIYFRude51+jjkCyzQEqOzNIbN
        UlyXL+4BVqtLztNs1ZhLMTY6IXXT8LLWLyVuV/IQN0PifaSe6zcVtB1AQfMOe2wun7E0xhCU4YIu4
        HhGGfc0z39yaWyQFOfIIYcUx1iVyfPpEoBLahfyfN3nLdKLEpjmU7g9nV08QLDlnRhtKNyJForz+W
        CNpTg/k+YzuQ40spr1nzPB2+T3g7r3uryOH8QaoUeEzgrVyXL4P2fPT7xLgGDr+ZAdhbVbrce45sv
        AogJ6fWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1molhx-00C2fn-Em; Sun, 21 Nov 2021 12:12:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm,fs: Split dump_mapping() out from dump_page()
Date:   Sun, 21 Nov 2021 12:10:56 +0000
Message-Id: <20211121121056.2870061-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dump_mapping() is a big chunk of dump_page(), and it'd be handy to be
able to call it when we don't have a struct page.  Split it out and move
it to fs/inode.c.  Take the opportunity to simplify some of the debug
messages a little.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c         | 49 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 mm/debug.c         | 52 ++--------------------------------------------
 3 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bdfbd5962f2b..67758b2b702f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -522,6 +522,55 @@ void __remove_inode_hash(struct inode *inode)
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
+void dump_mapping(const struct address_space *mapping)
+{
+	struct inode *host;
+	const struct address_space_operations *a_ops;
+	struct hlist_node *dentry_first;
+	struct dentry *dentry_ptr;
+	struct dentry dentry;
+	unsigned long ino;
+
+	/*
+	 * If mapping is an invalid pointer, we don't want to crash
+	 * accessing it, so probe everything depending on it carefully.
+	 */
+	if (get_kernel_nofault(host, &mapping->host) ||
+	    get_kernel_nofault(a_ops, &mapping->a_ops)) {
+		pr_warn("invalid mapping:%px\n", mapping);
+		return;
+	}
+
+	if (!host) {
+		pr_warn("aops:%ps\n", a_ops);
+		return;
+	}
+
+	if (get_kernel_nofault(dentry_first, &host->i_dentry.first) ||
+	    get_kernel_nofault(ino, &host->i_ino)) {
+		pr_warn("aops:%ps invalid inode:%px\n", a_ops, host);
+		return;
+	}
+
+	if (!dentry_first) {
+		pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
+		return;
+	}
+
+	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
+	if (get_kernel_nofault(dentry, dentry_ptr)) {
+		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
+				a_ops, ino, dentry_ptr);
+		return;
+	}
+
+	/*
+	 * if dentry is corrupted, the %pd handler may still crash,
+	 * but it's unlikely that we reach here with a corrupt mapping
+	 */
+	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, &dentry);
+}
+
 void clear_inode(struct inode *inode)
 {
 	/*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d6a4eb6cf825..acaad2b0d5b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3149,6 +3149,7 @@ extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
+void dump_mapping(const struct address_space *);
 
 /*
  * Userspace may rely on the the inode number being non-zero. For example, glibc
diff --git a/mm/debug.c b/mm/debug.c
index fae0f81ad831..b3ebfab21cb3 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -110,56 +110,8 @@ static void __dump_page(struct page *page)
 		type = "ksm ";
 	else if (PageAnon(page))
 		type = "anon ";
-	else if (mapping) {
-		struct inode *host;
-		const struct address_space_operations *a_ops;
-		struct hlist_node *dentry_first;
-		struct dentry *dentry_ptr;
-		struct dentry dentry;
-		unsigned long ino;
-
-		/*
-		 * mapping can be invalid pointer and we don't want to crash
-		 * accessing it, so probe everything depending on it carefully
-		 */
-		if (get_kernel_nofault(host, &mapping->host) ||
-		    get_kernel_nofault(a_ops, &mapping->a_ops)) {
-			pr_warn("failed to read mapping contents, not a valid kernel address?\n");
-			goto out_mapping;
-		}
-
-		if (!host) {
-			pr_warn("aops:%ps\n", a_ops);
-			goto out_mapping;
-		}
-
-		if (get_kernel_nofault(dentry_first, &host->i_dentry.first) ||
-		    get_kernel_nofault(ino, &host->i_ino)) {
-			pr_warn("aops:%ps with invalid host inode %px\n",
-					a_ops, host);
-			goto out_mapping;
-		}
-
-		if (!dentry_first) {
-			pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
-			goto out_mapping;
-		}
-
-		dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
-		if (get_kernel_nofault(dentry, dentry_ptr)) {
-			pr_warn("aops:%ps ino:%lx with invalid dentry %px\n",
-					a_ops, ino, dentry_ptr);
-		} else {
-			/*
-			 * if dentry is corrupted, the %pd handler may still
-			 * crash, but it's unlikely that we reach here with a
-			 * corrupted struct page
-			 */
-			pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n",
-					a_ops, ino, &dentry);
-		}
-	}
-out_mapping:
+	else if (mapping)
+		dump_mapping(mapping);
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
 	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
-- 
2.33.0

