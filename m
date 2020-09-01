Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B023A2598A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgIAQ30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:29:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731539AbgIAQ3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKeTQTlHEH1DvrHRoJ98xax44gVFHErnwIJFKqA+kZE=;
        b=FSqYBgSGvi/Beco3sU89gD4Jlxm5hfh5G+oALUn28C5HKhL32Nz2kpCmFn/X1xCoYczskO
        n1jybJF3evkdMhZQPmj/6bw8TsKtr8YCHv8uhxtrlpFkGNjJqk0g0EZtukd9y1IA29hPDq
        1G3kqhokGBdOZWSrW90NVB4kpoXnYzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-zK7EKLIlO6u-8mZrVFZPSQ-1; Tue, 01 Sep 2020 12:29:10 -0400
X-MC-Unique: zK7EKLIlO6u-8mZrVFZPSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABA9680572E;
        Tue,  1 Sep 2020 16:29:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC1915D9CC;
        Tue,  1 Sep 2020 16:29:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 7/7] mm: Pass a file_ra_state struct into
 force_page_cache_readahead()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:29:06 +0100
Message-ID: <159897774687.405783.6157146299031279302.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a file_ra_state struct into force_page_cache_readahead().  One caller
has one that should be passed in and the other doesn't, but the former
needs to pass its in.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/fadvise.c   |    2 +-
 mm/internal.h  |    2 +-
 mm/readahead.c |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index b68d2f2959d5..2f1550279757 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -107,7 +107,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		{
 			DEFINE_READAHEAD(rac, file, mapping, start_index);
 			rac._nr_pages = nrpages;
-			force_page_cache_readahead(&rac);
+			force_page_cache_readahead(&rac, &rac.file->f_ra);
 		}
 		break;
 	case POSIX_FADV_NOREUSE:
diff --git a/mm/internal.h b/mm/internal.h
index de3b2ce2743a..977ad7d81b1b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,7 +49,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void force_page_cache_readahead(struct readahead_control *);
+void force_page_cache_readahead(struct readahead_control *, struct file_ra_state *);
 void __do_page_cache_readahead(struct readahead_control *, unsigned long);
 
 /**
diff --git a/mm/readahead.c b/mm/readahead.c
index 28ff80304a21..b001720c13aa 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -273,11 +273,11 @@ void __do_page_cache_readahead(struct readahead_control *rac,
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
  * memory at once.
  */
-void force_page_cache_readahead(struct readahead_control *rac)
+void force_page_cache_readahead(struct readahead_control *rac,
+				struct file_ra_state *ra)
 {
 	struct address_space *mapping = rac->mapping;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &rac->file->f_ra;
 	unsigned long max_pages, index, nr_to_read;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
@@ -657,7 +657,7 @@ void page_cache_sync_readahead(struct readahead_control *rac,
 
 	/* be dumb */
 	if (rac->file && (rac->file->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(rac);
+		force_page_cache_readahead(rac, ra);
 		return;
 	}
 


