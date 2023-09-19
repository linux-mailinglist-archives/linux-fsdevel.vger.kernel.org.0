Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB497A58C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjISEwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjISEvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8E0132;
        Mon, 18 Sep 2023 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N6ovGOYS7j9q8wOyOWu2B5Uq08RUxsjTVDWIGzX0CMc=; b=gSD3y3/0A4Cql8OnDXKyDsG0Fv
        9uPTYM++ZTTpjlvVSbjwWQXbSealfQoNsXpNk2+yC1nPtlDm2XYBVpaA8ICYBxXivHGctfLVMCF/S
        H6CDp5UXLG6U9JliMb4c7sUyywozbLxXn3gdN7RlpWMgYuYvfWoka3oJzZKC9nzW4NvUylmkovvEK
        gpggozbu5Ll4n5Mq7yQkrMVUXxrEnf2CCIY/+JT/CeSHmWaBsaCYS9SG/KwfCMwEVYfosVeKkbnbY
        opkub3P2d6AHdTtVu1T+4I5q42urpgatsRyE9F/eCAGFUAE4t6ifmEG7dtjhZ4NOGLG+Lz22GVv29
        2qKJiJwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi3-00FFlG-VI; Tue, 19 Sep 2023 04:51:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 14/26] nilfs2: Remove nilfs_page_get_nth_block
Date:   Tue, 19 Sep 2023 05:51:23 +0100
Message-Id: <20230919045135.3635437-15-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All users have now been converted to get_nth_block().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/page.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 344d71942d36..d249ea1cefff 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -52,10 +52,4 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 #define NILFS_PAGE_BUG(page, m, a...) \
 	do { nilfs_page_bug(page); BUG(); } while (0)
 
-static inline struct buffer_head *
-nilfs_page_get_nth_block(struct page *page, unsigned int count)
-{
-	return get_nth_bh(page_buffers(page), count);
-}
-
 #endif /* _NILFS_PAGE_H */
-- 
2.40.1

