Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB99290942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410589AbgJPQFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410566AbgJPQEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A34C0613D5;
        Fri, 16 Oct 2020 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s32aG3TT8gSwa4wk3wTFOPbSLlkdVuiNeRF4/gWWj4Y=; b=kYJP+mEhXaySepAsFUmQIeV8kp
        kGNml2aZBoFVfYFfCNqhW0+z3COGlN3stBsKtQqVq9/5NKsLty62Y4PflaVvmkdPiPCL6hHYA6z2t
        QW/kxIDecHDrFxAvqwxMvW8c0jtOzOyuSeMlScK5lsI0ctJ2iquLYZ5m0knTCC6n7d6c9w1HPnzzS
        EWFlHJCejUJ4jKeDxyOsGwV4aj3ahhL/15+qsjkxyjzhfSwG+M9Zo4kuq4eoUO1jtFVKWFi0UUdtp
        XsI+4cusgzvSla2AGVf883MwzMe571jgIv15eSN4IvMbqSE+NAFhU5O2owBc+at6Ggsg2ZdD6f5so
        kcnLkisw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDn-0004tT-S2; Fri, 16 Oct 2020 16:04:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v3 11/18] ext4: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:36 +0100
Message-Id: <20201016160443.18685-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ext4 inline data readpage implementation was already synchronous,
so use AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 75c97bca0815..2a489243e4de 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -490,7 +490,8 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 	zero_user_segment(page, len, PAGE_SIZE);
 	SetPageUptodate(page);
 	brelse(iloc.bh);
-
+	if (ret >= 0)
+		return AOP_UPDATED_PAGE;
 out:
 	return ret;
 }
@@ -514,12 +515,14 @@ int ext4_readpage_inline(struct inode *inode, struct page *page)
 	else if (!PageUptodate(page)) {
 		zero_user_segment(page, 0, PAGE_SIZE);
 		SetPageUptodate(page);
+		ret = AOP_UPDATED_PAGE;
 	}
 
 	up_read(&EXT4_I(inode)->xattr_sem);
 
-	unlock_page(page);
-	return ret >= 0 ? 0 : ret;
+	if (ret < 0)
+		unlock_page(page);
+	return ret;
 }
 
 static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
-- 
2.28.0

