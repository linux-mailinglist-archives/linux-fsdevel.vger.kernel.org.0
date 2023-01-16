Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEB066B973
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 09:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjAPIz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 03:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjAPIzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:55:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2578E13D41
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OG2B/ZSWByZRN4fMNjXk/odq7YMNkG/R7DDN5iMhUtQ=; b=Jv+WhniY9VGch/zC8+PJm+chhT
        /+rHupK5uBALMlQaZjsepoMcl0mFl8uuNrYuXeGgWwGj280ui4kquded1Op5jmigdG0CjbLd+GpKk
        XFjxxRaTMGGMYG/Opr2gTEVG87otTdyk3f8TYMf9cI3e7X5AhB4ud2Di9Ptan7y6agqCRO2RhWRsv
        Hhx+g/gzwuId7dh/3Wc8WfDcAdvNfyWswpDFfQCatswiEOV9LxxHcAHtjbj0lRK9O/lYSyK3ZTARP
        3MFPat1picSmsva4N/FL6ON2qSYkYLSo9kJf0HEAU3aCjtxxKnU9sMTH3fcrzJ3qOIfIKQjh4fQoa
        FeKc/8kQ==;
Received: from [2001:4bb8:19a:2039:c63c:c37c:1cda:3fb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHLH6-009Eea-02; Mon, 16 Jan 2023 08:55:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/6] minix: fix error handling in minix_delete_entry
Date:   Mon, 16 Jan 2023 09:55:18 +0100
Message-Id: <20230116085523.2343176-2-hch@lst.de>
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
dir inode dirty is wrong, as the inode hasn't been modified.

Note that this moves the dir_put_page call later, but that matches
other uses of this helper in the directory code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/minix/dir.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index dcfe5b25378b54..a8e76284cb71ec 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -297,18 +297,19 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 
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
+		goto out_put_page;
 	}
-	dir_put_page(page);
+	if (sbi->s_version == MINIX_V3)
+		((minix3_dirent *)de)->inode = 0;
+	else
+		de->inode = 0;
+	err = dir_commit_chunk(page, pos, len);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
+out_put_page:
+	dir_put_page(page);
 	return err;
 }
 
-- 
2.39.0

