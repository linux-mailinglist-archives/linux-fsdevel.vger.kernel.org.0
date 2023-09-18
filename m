Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEDC7A47D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjIRLFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjIRLFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF39100;
        Mon, 18 Sep 2023 04:05:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7876321AB0;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xN6TM7GHFN0mqNZxYxxtWtFr22aM89KuuSlQeaM7rVQ=;
        b=oivGAnFiHoQC3mzve3gBbJhTW0HH2z9Ykvz/cBJoO8cE3qBvC15vlkaVeR62458BHPICXA
        0vyEYWgJ8zbFp4wEddXmdAsRZ+UvnqwlGC0WO1+QbwU585t/AlhxOEJKvm32uBRV/2dBfJ
        XhpsCs3qaXgk0Q/u6wNL0c3Tr2OB9Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xN6TM7GHFN0mqNZxYxxtWtFr22aM89KuuSlQeaM7rVQ=;
        b=3pQ/CfDScouXELAST2XLDIoiqVihUdtxb1CypSlVKmNS3qXPs2j3hZjPhAVdUe2IzSiW9G
        11xZze9zvMzyXGBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 613C22C14B;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 233A151CD14B; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/18] mm/filemap: allocate folios with mapping order preference
Date:   Mon, 18 Sep 2023 13:04:59 +0200
Message-Id: <20230918110510.66470-8-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use mapping_min_folio_order() when calling filemap_alloc_folio()
to allocate folios with the order specified by the mapping.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 mm/filemap.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 582f5317ff71..98c3737644d5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -507,9 +507,14 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 	pgoff_t end = end_byte >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	unsigned nr_folios;
+	unsigned int order = mapping_min_folio_order(mapping);
 
 	folio_batch_init(&fbatch);
 
+	if (order) {
+		index = ALIGN_DOWN(index, 1 << order);
+		end = ALIGN_DOWN(end, 1 << order);
+	}
 	while (index <= end) {
 		unsigned i;
 
@@ -2482,7 +2487,8 @@ static int filemap_create_folio(struct file *file,
 	struct folio *folio;
 	int error;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    mapping_min_folio_order(mapping));
 	if (!folio)
 		return -ENOMEM;
 
@@ -2542,9 +2548,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	pgoff_t last_index;
 	struct folio *folio;
 	int err = 0;
+	unsigned int order = mapping_min_folio_order(mapping);
 
 	/* "last_index" is the index of the page beyond the end of the read */
 	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
+	if (order) {
+		/* Align with folio order */
+		WARN_ON(index % 1 << order);
+		index = ALIGN_DOWN(index, 1 << order);
+		last_index = ALIGN(last_index, 1 << order);
+	}
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -2561,7 +2574,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
 		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+				index, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
@@ -3676,7 +3689,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+				mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
-- 
2.35.3

