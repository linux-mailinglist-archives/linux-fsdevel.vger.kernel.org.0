Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46B6724F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjARRbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjARRbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:31:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7AD59B48
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MsUsFoYQrTDA+hFUE1VWaBiacxBoUahLt80xRKfGZMs=; b=kqj2fnr+ij0si90SGxbS9qXDce
        2JYRKEHhI08O/eeOkZ4fGkif49Gsu87pWSEM4bCYAka8wxoBOy8Zc580p2lB4mZWpTixufgfK4OWL
        QOavXNp6Asr34uSPGFg/IlFkuGxb7C9Oi725gTlRiHA/LbWnneZBscVJ9VevMC6By9zCafaIYLB2E
        AAtGIINa79oLsbuf7OKhFM5ul79N4sg8/31bpJaYz/xFON4czyRlrMVFTN7bYi0CwSZkkYVHqz2ja
        0k4Y+DBDHOLUeyjVmwWHyPJIbN7Pq7wEVKXlZb0IoaURU0TlddjqfeacFkSNiucvibBPeu9Z+lfuf
        mpMph1gA==;
Received: from [2001:4bb8:19a:2039:cce7:a1cd:f61c:a80d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICGi-00227r-3e; Wed, 18 Jan 2023 17:30:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/7] minix: fix error handling in minix_delete_entry
Date:   Wed, 18 Jan 2023 18:30:22 +0100
Message-Id: <20230118173027.294869-3-hch@lst.de>
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
dir inode dirty is wrong, as the inode hasn't been modified.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/minix/dir.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index ec462330e749af..242e179aa1fbeb 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -297,18 +297,20 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 
 	lock_page(page);
 	err = minix_prepare_chunk(page, pos, len);
-	if (err == 0) {
-		if (sbi->s_version == MINIX_V3)
-			((minix3_dirent *) de)->inode = 0;
-		else
-			de->inode = 0;
-		err = dir_commit_chunk(page, pos, len);
-	} else {
+	if (err) {
 		unlock_page(page);
+		return err;
 	}
+	if (sbi->s_version == MINIX_V3)
+		((minix3_dirent *)de)->inode = 0;
+	else
+		de->inode = 0;
+	err = dir_commit_chunk(page, pos, len);
+	if (err)
+		return err;
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
-	return err;
+	return 0;
 }
 
 int minix_make_empty(struct inode *inode, struct inode *dir)
-- 
2.39.0

