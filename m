Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6051F140
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiEHUed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiEHUdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38870E08C
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z232WyiFLUOa7PdfqmUYaKDHKWp0ty7SoxNoS8Kk2s0=; b=MWzsq7Inth8YVhXeR8j9FFde1m
        E7wRmvd8NuaS11q5qj2sctttW3voirDf0vYEWwbC+gViX52+lJb3VLw7NKd8Jm/cvAlX/uCsLzLAn
        l9B7Y2MUyUx0GAh0uLQghkLiZK5FPMkqk+RriEIDOblVTo+OUqNlNczGm5FhRpT8V9lBj91danTpQ
        ePjYnagqQ4JgMNAv7xtwT9HpQ6c1KCDaBTy2W4/VIhHupUFpmu6t0Tg801orjZ13lx6nZ2VmCFi/m
        8FEHZeH3kAUd4BVrpGr+IAgrfCpK82lFwLtzh29ZyaQAZtQaCuQSgLuZMHCpo/2/LX5UinIseEv7D
        Rbcj3ljA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXU-002nZl-5e; Sun, 08 May 2022 20:30:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 22/25] ext4: Call aops write_begin() and write_end() directly
Date:   Sun,  8 May 2022 21:29:38 +0100
Message-Id: <20220508202941.667024-23-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pagecache_write_begin() and pagecache_write_end() are now trivial
wrappers, so call the aops directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/verity.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index eacbd489e3bf..b051d19b5c8a 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -69,6 +69,9 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 			   loff_t pos)
 {
+	struct address_space *mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
+
 	if (pos + count > inode->i_sb->s_maxbytes)
 		return -EFBIG;
 
@@ -79,15 +82,13 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		void *fsdata;
 		int res;
 
-		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
-					    &page, &fsdata);
+		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
 		if (res)
 			return res;
 
 		memcpy_to_page(page, offset_in_page(pos), buf, n);
 
-		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
-					  page, fsdata);
+		res = aops->write_end(NULL, mapping, pos, n, n, page, fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
-- 
2.34.1

