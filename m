Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FF73E696
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjFZRgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFZRf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:35:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A562738;
        Mon, 26 Jun 2023 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sd4UR031RbDntAg7Q2TtCsIA81STdESVBYZOrBi6xDM=; b=qIKh3LKNsyIKL6wn9vPVDEzZ+D
        eEqSPJa/7CQUC5xinii35WBEGVSuPYk98nQd3Rk665j4winBw8s0gcTwod5j//SI78kDfO8LiKpb2
        QxPbWsAW0AuHq/5s0VxBqJ9MT/wDfN/+rlOdpY2Fk2YtsFFIPIG9BsONHh4138hmsct/3ELFT9roh
        e0+vNhPUTa71jfAWtaK5OPKL2MmIEixL3WqzjOmsa18TETHpzf2dOygWdHq4KBAPddiWMAqpgRmR3
        ydq70lu0ywMlmKyHpMvrSv53DWf8nfN6Ya3A+O2Bn3zHyOeojHJDOD+gOEsd739ZMiyDu/U2u0Yl8
        Ak2tJitA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7Y-001vVK-58; Mon, 26 Jun 2023 17:35:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 11/12] iomap: Convert iomap_writepages() to use for_each_writeback_folio()
Date:   Mon, 26 Jun 2023 18:35:20 +0100
Message-Id: <20230626173521.459345-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
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

This removes one indirect function call per folio, and adds typesafety
by not casting through a void pointer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a4fa81af60d9..a4dd17abe244 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1711,9 +1711,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
  * regular allocated space.
  */
 static int iomap_do_writepage(struct folio *folio,
-		struct writeback_control *wbc, void *data)
+		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc)
 {
-	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = folio->mapping->host;
 	u64 end_pos, isize;
 
@@ -1810,13 +1809,16 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops)
 {
-	int			ret;
+	struct folio *folio;
+	int err;
 
 	wpc->ops = ops;
-	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
+	for_each_writeback_folio(mapping, wbc, folio, err)
+		err = iomap_do_writepage(folio, wbc, wpc);
+
 	if (!wpc->ioend)
-		return ret;
-	return iomap_submit_ioend(wpc, wpc->ioend, ret);
+		return err;
+	return iomap_submit_ioend(wpc, wpc->ioend, err);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
-- 
2.39.2

