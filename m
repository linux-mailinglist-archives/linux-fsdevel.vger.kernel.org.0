Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19C03B6FED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhF2JPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 05:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232518AbhF2JPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624957969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHZgHYoqkuHfQKxJGSGyXpK6idsQjVIfFQP8/BqbJfw=;
        b=du7laYdzGTR9al9vHQg6aiz2Qg9JHi3qr/WveFyY8t/dDAm2CmGpDd6uPKPmeCVw23R8nL
        aUnHMWdWP3IkWymzLnMy9hLApp9vBpk17d2woykVKI0P1UBA3W37/1eON/sSRTxE8Vvhqu
        Rf3r1UjuFu8fqnvk+j3MWgnStWZqL0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-w2qftOcXNfuJ9dfmiIFRZA-1; Tue, 29 Jun 2021 05:12:48 -0400
X-MC-Unique: w2qftOcXNfuJ9dfmiIFRZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC3A28015D0;
        Tue, 29 Jun 2021 09:12:46 +0000 (UTC)
Received: from max.com (unknown [10.40.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B030A10016F7;
        Tue, 29 Jun 2021 09:12:41 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 0/2] iomap: small block problems
Date:   Tue, 29 Jun 2021 11:12:39 +0200
Message-Id: <20210629091239.1930040-1-agruenba@redhat.com>
In-Reply-To: <YNoJPZ4NWiqok/by@casper.infradead.org>
References: <YNoJPZ4NWiqok/by@casper.infradead.org> <20210628172727.1894503-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Below is a version of your patch on top of v5.13 which has passed some
local testing here.

Thanks,
Andreas

--

iomap: Permit pages without an iop to enter writeback

Permit pages without an iop to enter writeback and create an iop *then*.  This
allows filesystems to mark pages dirty without having to worry about how the
iop block tracking is implemented.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 03537ecb2a94..6330dabc451e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1336,14 +1336,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct page *page, u64 end_offset)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = iomap_page_create(inode, page);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
 	/*
-- 
2.26.3

