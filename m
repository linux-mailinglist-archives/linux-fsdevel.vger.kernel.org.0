Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF625C344
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgICOr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgICOX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:23:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4874C061249;
        Thu,  3 Sep 2020 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a0ZdxEmc4Ya6AVRsiFgEwXG4tBh4LjkqZ1uo+PU8+e4=; b=QMX94UFc9yqTHvC0XKzCDJqHCO
        PQ2j49kyyeDnBRj5wWH5+BHFTqV0K26mV6+Nz0wDHJ6g7ucosqy0PkrqIpJf3wCRa6OziORzSMOZf
        FV8rvubo7rcjapO3kY1PJEzFoDzvuzm+DCTVtttCazTw1Q4An3/651tpb0e1AU9cGtAhkYM5ZuSed
        foP2WQfSsgBLwztr9Krp6bGrBynwZf/WlsXNs7asaSRyrsyQ9ucsMXmBQ0inrpFT4z8IDVqxvA0Oc
        YQhg6fNYg5Gg4BI6aiJ8XOThTUhhCBonzONn8NOvHqhTh5acxpUgYAy9XRP0xG1fIoGY10WP8uqND
        GwwSGXuA==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8T-0004a6-4P; Thu, 03 Sep 2020 14:22:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/14] proc: remove a level of indentation in proc_get_inode
Date:   Thu,  3 Sep 2020 16:22:29 +0200
Message-Id: <20200903142242.925828-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just return early on inode allocation failure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/inode.c | 72 +++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 28d6105e908e4c..016b1302cbabc0 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -619,42 +619,44 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 {
 	struct inode *inode = new_inode(sb);
 
-	if (inode) {
-		inode->i_ino = de->low_ino;
-		inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-		PROC_I(inode)->pde = de;
-
-		if (is_empty_pde(de)) {
-			make_empty_dir_inode(inode);
-			return inode;
-		}
-		if (de->mode) {
-			inode->i_mode = de->mode;
-			inode->i_uid = de->uid;
-			inode->i_gid = de->gid;
-		}
-		if (de->size)
-			inode->i_size = de->size;
-		if (de->nlink)
-			set_nlink(inode, de->nlink);
-
-		if (S_ISREG(inode->i_mode)) {
-			inode->i_op = de->proc_iops;
-			inode->i_fop = &proc_reg_file_ops;
+	if (!inode) {
+		pde_put(de);
+		return NULL;
+	}
+
+	inode->i_ino = de->low_ino;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	PROC_I(inode)->pde = de;
+	if (is_empty_pde(de)) {
+		make_empty_dir_inode(inode);
+		return inode;
+	}
+
+	if (de->mode) {
+		inode->i_mode = de->mode;
+		inode->i_uid = de->uid;
+		inode->i_gid = de->gid;
+	}
+	if (de->size)
+		inode->i_size = de->size;
+	if (de->nlink)
+		set_nlink(inode, de->nlink);
+
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_op = de->proc_iops;
+		inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-			if (!de->proc_ops->proc_compat_ioctl) {
-				inode->i_fop = &proc_reg_file_ops_no_compat;
-			}
+		if (!de->proc_ops->proc_compat_ioctl)
+			inode->i_fop = &proc_reg_file_ops_no_compat;
 #endif
-		} else if (S_ISDIR(inode->i_mode)) {
-			inode->i_op = de->proc_iops;
-			inode->i_fop = de->proc_dir_ops;
-		} else if (S_ISLNK(inode->i_mode)) {
-			inode->i_op = de->proc_iops;
-			inode->i_fop = NULL;
-		} else
-			BUG();
-	} else
-	       pde_put(de);
+	} else if (S_ISDIR(inode->i_mode)) {
+		inode->i_op = de->proc_iops;
+		inode->i_fop = de->proc_dir_ops;
+	} else if (S_ISLNK(inode->i_mode)) {
+		inode->i_op = de->proc_iops;
+		inode->i_fop = NULL;
+	} else {
+		BUG();
+	}
 	return inode;
 }
-- 
2.28.0

