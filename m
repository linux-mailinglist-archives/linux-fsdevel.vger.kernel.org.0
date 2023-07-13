Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA697522ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjGMNGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjGMNFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:05:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3513A8D;
        Thu, 13 Jul 2023 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jJH67TsCbAy/M81eao+hE7f2jfjbJTpCc7Wu7+KlLQ4=; b=pJznxCPQ1Kxg1MFAnXOcYYXtPB
        vGBFi2/fjZl+fC+RbBF/bRL2IPQkjh8uiJ/gH17r+y8vmHv9g4NH0OH0EJ8f5SINzoiY00obZdbT9
        9nPcZB91Ef7iNXXwMr9jnTcjg7bzjLBS4kJ6s8EY+n0quGAh7TzPsMVh/hOqEjqidIiIk3wgaZKMC
        fralsoSp4ZgvNGyk06hjZOquZoTGcWVcDhG9tW/g9oicr1aO2ORZT0Re/+jkVJ6hM7v5eOKrcPntj
        goDolu4nQTwf0tbryH5xd+oKQ+TLQVB/FBVw9xaeFn2nAXuJEZwrcOBwJ1ocVs6KlCnYUYPVZi1R8
        JshwB0oQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJvzr-003LTW-34;
        Thu, 13 Jul 2023 13:04:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] btrfs: don't wait for writeback on clean pages in extent_write_cache_pages
Date:   Thu, 13 Jul 2023 15:04:24 +0200
Message-Id: <20230713130431.4798-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713130431.4798-1-hch@lst.de>
References: <20230713130431.4798-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__extent_writepage can have started on more pages than the one it was
called for.  This happens regularly for zoned file systems, and in theory
could happen for compressed I/O if the worker thread was executed very
quicky. For such pages extent_write_cache_pages waits for writeback
to complete before moving on to the next page, which is highly inefficient
as it blocks the flusher thread

Port over the PageDirty check that was added to write_cache_pages in
commit 515f4a037fb ("mm: write_cache_pages optimise page cleaning") to
fix this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cb8c5d06fe2304..2ae3badaf36df6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2075,6 +2075,12 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
+			if (!folio_test_dirty(folio)) {
+				/* someone wrote it for us */
+				folio_unlock(folio);
+				continue;
+			}
+
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				if (folio_test_writeback(folio))
 					submit_write_bio(bio_ctrl, 0);
-- 
2.39.2

