Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8467B35D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjAYNev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjAYNet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:34:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2C366B1;
        Wed, 25 Jan 2023 05:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eatZ3C2tdEkdvrb64DPJf57lpiFsGds2EGzrS1xbOrI=; b=nDXFh8LWA1LGc5RQsEKZ0eXn4y
        OPVffqBjS24TQGQz3FdPT3r1QlObRWw1zBGgczQcuqrM0hVwHR1p0QQkfDBgl5PyOJyUC8uSlN6Wf
        BoqxcuHsf364qZ/DO7d/ayY38C4qDJBWDh+4mXV9yD9aEAhXVFcAw2z3K9tZvszL7qIpdy+dKJTYQ
        QOSZLn9G7dp+lkYy6obFD//bxcg0YVpfoFLdrw51es6H1n+EPKRp3mzEUMLp8a61KTfEmYnJBhZKf
        4t0GUiY15/ca16Qlgzfa0UHylFIR51q2529/y2EoCY9/qv3XSmxpru60Gd0vznQCPMOXZAtAR4o/b
        gJyUIuNw==;
Received: from [2001:4bb8:19a:27af:c78f:9b0d:b95c:d248] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKfvH-007P1T-Eg; Wed, 25 Jan 2023 13:34:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/7] mpage: stop using bdev_{read,write}_page
Date:   Wed, 25 Jan 2023 14:34:30 +0100
Message-Id: <20230125133436.447864-2-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125133436.447864-1-hch@lst.de>
References: <20230125133436.447864-1-hch@lst.de>
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

These are micro-optimizations for synchronous I/O, which do not matter
compared to all the other inefficiencies in the legacy buffer_head
based mpage code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0f8ae954a57903..124550cfac4a70 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -269,11 +269,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 alloc_new:
 	if (args->bio == NULL) {
-		if (first_hole == blocks_per_page) {
-			if (!bdev_read_page(bdev, blocks[0] << (blkbits - 9),
-								&folio->page))
-				goto out;
-		}
 		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), opf,
 				      gfp);
 		if (args->bio == NULL)
@@ -579,11 +574,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 
 alloc_new:
 	if (bio == NULL) {
-		if (first_unmapped == blocks_per_page) {
-			if (!bdev_write_page(bdev, blocks[0] << (blkbits - 9),
-								page, wbc))
-				goto out;
-		}
 		bio = bio_alloc(bdev, BIO_MAX_VECS,
 				REQ_OP_WRITE | wbc_to_write_flags(wbc),
 				GFP_NOFS);
-- 
2.39.0

