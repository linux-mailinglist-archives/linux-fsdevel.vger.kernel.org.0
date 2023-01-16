Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E99266B97B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 09:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAPI4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 03:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjAPIzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:55:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C9213D5F
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 00:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jmbxaw5WGTdQC+qZyQllTG4rSUOzrNtp0wkWOB0SkzU=; b=S1YQa0jo9I3cRIkKUvmK7E0LAe
        gZA9QpBJWq/4q1yWw44YdYIyo5lTBj41So0EskMqctZHNAseMRrJiewDt8OHaWv56VCtYWSDkMM/w
        w9ki30AiFExrhcC68KG48eFoFc6lR/EH5r3SoH2VIHGXyq2Oux6Ef4eqSFbmDtn/RMWJ3tT9q01W7
        1hzO9c3PXTWZ+Jn6jZqG5P/iproorCh01i/UL1Yb4qwCDtNfv7F5qAirB3ZYt8p/CzRfUY29D8sYc
        UQ8L5Sp2s3JkHGZy4ZoyT7sXuZbUM0oSRzKF17mun/YTTCQV0TkAwQe1al7rQ1YAH2adR+oAfZlCz
        wb0LDk/g==;
Received: from [2001:4bb8:19a:2039:c63c:c37c:1cda:3fb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHLHJ-009Ei0-KJ; Mon, 16 Jan 2023 08:55:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/6] ocfs2: don't use write_one_page in ocfs2_duplicate_clusters_by_page
Date:   Mon, 16 Jan 2023 09:55:23 +0100
Message-Id: <20230116085523.2343176-7-hch@lst.de>
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

Use filemap_write_and_wait_range to write back the range of the dirty
page instead of write_one_page in preparation of removing write_one_page
and eventually ->writepage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/refcounttree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 623db358b1efa8..4a73405962ec4f 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -2952,10 +2952,11 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 		 */
 		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize) {
 			if (PageDirty(page)) {
-				/*
-				 * write_on_page will unlock the page on return
-				 */
-				ret = write_one_page(page);
+				unlock_page(page);
+				put_page(page);
+
+				ret = filemap_write_and_wait_range(mapping,
+						offset, map_end - 1);
 				goto retry;
 			}
 		}
-- 
2.39.0

