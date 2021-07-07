Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B223BE779
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhGGL6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 07:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231429AbhGGL6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625658938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmZDH/DEXLKzetTFHJTrnle9t5h1vn/VXibFPU+EECg=;
        b=XcaNQ0emKYhDM5hieO+AbVW80hG5WqVjeko2AvqSDvpzColHrLtuiuZ9rYWS4aJpEWpj93
        vlbruzFchiPiqlUDMpVkNxzCbem1tZbXDkZ0Ay6LedYpAcMqS8NrmE2gIZVU3l0S0GCt5x
        buUH2Hh4IiDJno94uITbnrJmt7vlegI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-MKwmJq3kOySQVW3Oj-LRrw-1; Wed, 07 Jul 2021 07:55:37 -0400
X-MC-Unique: MKwmJq3kOySQVW3Oj-LRrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3825B100C676;
        Wed,  7 Jul 2021 11:55:36 +0000 (UTC)
Received: from max.com (unknown [10.40.192.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 786B45D6AB;
        Wed,  7 Jul 2021 11:55:34 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 2/3] iomap: Don't create iomap_page objects for inline files
Date:   Wed,  7 Jul 2021 13:55:23 +0200
Message-Id: <20210707115524.2242151-3-agruenba@redhat.com>
In-Reply-To: <20210707115524.2242151-1-agruenba@redhat.com>
References: <20210707115524.2242151-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In iomap_readpage_actor, don't create iop objects for inline inodes.
Otherwise, iomap_read_inline_data will set PageUptodate without setting
iop->uptodate, and iomap_page_release will eventually complain.

To prevent this kind of bug from occurring in the future, make sure the
page doesn't have private data attached in iomap_read_inline_data.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 598fcfabc337..6330dabc451e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -215,6 +215,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	if (PageUptodate(page))
 		return;
 
+	BUG_ON(page_has_private(page));
 	BUG_ON(page->index);
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
@@ -239,7 +240,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
-	struct iomap_page *iop = iomap_page_create(inode, page);
+	struct iomap_page *iop;
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
@@ -252,6 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
+	iop = iomap_page_create(inode, page);
 	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
-- 
2.26.3

