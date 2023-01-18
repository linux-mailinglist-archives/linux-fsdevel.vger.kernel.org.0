Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB076724FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjARRcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjARRbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:31:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B8658944
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jmbxaw5WGTdQC+qZyQllTG4rSUOzrNtp0wkWOB0SkzU=; b=t/tZrpSSAGJENEbey1iuxkY4ry
        DoU5y3Z4+8vXJK7yr+FX15ymQN81I4eYh+Ld5EsZ7QFqEDndjQwJk3U4pvySdS91GPbZqgEuJzKSc
        3Hb+U6bsZh23jwkljYJIRJmeZmhtzKFA2xT/JLlfnDFLQzDCMBk0IwTSypcYjKrwmJgSb/gtP6Pxa
        vqIncS8uYulKZFlO9T7OpTj0BhbtHHGYpqhOlGXM2HT8Jx9qfzXF+bD/vDHXBFJZqpMAlFvudD4WT
        VHRCcgIEGkyXvIQnY4XTtcmPCC5sJHR2bvvK4vMMsHKgWPKo5D6SKWZhgAk4rd4Vnl+qQfpUU3NGd
        DadoCs/w==;
Received: from [2001:4bb8:19a:2039:cce7:a1cd:f61c:a80d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICGx-0022Gg-Pc; Wed, 18 Jan 2023 17:30:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/7] ocfs2: don't use write_one_page in ocfs2_duplicate_clusters_by_page
Date:   Wed, 18 Jan 2023 18:30:27 +0100
Message-Id: <20230118173027.294869-8-hch@lst.de>
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

