Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C721757E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGGRs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgGGRse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5CC061755;
        Tue,  7 Jul 2020 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5UdxRZXTOhVUtxH21tqgR494MAXE+7aifhN/sMLl3wo=; b=VnhHfBod7FY+/0HQLHZOiY+Dsc
        waw2TdL0ExD9660hDrFgJc9uRgTQLe07nQZrOQfHpupePKLqoGOLfSakm0VrB8ootaEVdH80w6VwG
        cIu9Sp985pOpd8JAwDEID1xnj9HoWxyhHmFGgeLJhlYfAVV18za403POJvLs57cXtiv7uGaruDp6m
        T0rWal21LEl68ttv09A5vHzfn/1yoEjG1f/5UXLO5usD098OtPZK0fTO40EUum9w89s6QjekmS2u1
        UCMnffQx4ONN4lXhdhvvCd7Z34aMmEvVWXfbwzSHggxKi8QrGj//dkLlIzTETWEpm4b7p0P0Gpi/y
        NSY8+y8w==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhi-0003Kv-IY; Tue, 07 Jul 2020 17:48:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/23] proc: remove a level of indentation in proc_get_inode
Date:   Tue,  7 Jul 2020 19:47:54 +0200
Message-Id: <20200707174801.4162712-17-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
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
2.26.2

