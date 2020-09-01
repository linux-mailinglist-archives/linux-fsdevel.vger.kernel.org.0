Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090CA2598A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgIAQ3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:29:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730930AbgIAQ3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FL08+vWWj3quE65ajNi5b46OkqhFrRGb41bV5AnZLQw=;
        b=GAxyAwIXi5xXc/v9x/+loUBGLj2R1JmAG5iF2xNwpD4YLLPveKkxGkSpF/t/WTF8A5/gPk
        U9nBi/r+0FfwOljrhnnYruu3NEa8Mp5yiXpy+21D2XKO0a0NDK5Oz6f07z9msHdM/C3G7p
        2wDES8mnvZA1ZWh1xJOExB8cXAwb/0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-dCtNfjpfN_W8gxPWXNEBUg-1; Tue, 01 Sep 2020 12:29:02 -0400
X-MC-Unique: dCtNfjpfN_W8gxPWXNEBUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EABB8014D9;
        Tue,  1 Sep 2020 16:29:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E1D11002D6F;
        Tue,  1 Sep 2020 16:29:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 6/7] mm: Fold ra_submit() into do_sync_mmap_readahead()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:59 +0100
Message-ID: <159897773980.405783.13680099265521545037.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold ra_submit() into its last remaining user and pass the previously added
readahead_control struct down into __do_page_cache_readahead().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/filemap.c  |    6 +++---
 mm/internal.h |   11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9f2f99db7318..c22bb01e8ba6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2502,10 +2502,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 * mmap read-around
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
+	ra->start = rac._index    = max_t(long, 0, offset - ra->ra_pages / 2);
+	ra->size  = rac._nr_pages = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
-	ra_submit(ra, mapping, file);
+	__do_page_cache_readahead(&rac, ra->async_size);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index e1d296e76fb0..de3b2ce2743a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -52,17 +52,6 @@ void unmap_page_range(struct mmu_gather *tlb,
 void force_page_cache_readahead(struct readahead_control *);
 void __do_page_cache_readahead(struct readahead_control *, unsigned long);
 
-/*
- * Submit IO for the read-ahead request in file_ra_state.
- */
-static inline void ra_submit(struct file_ra_state *ra,
-		struct address_space *mapping, struct file *file)
-{
-	DEFINE_READAHEAD(rac, file, mapping, ra->start);
-	rac._nr_pages = ra->size;
-	__do_page_cache_readahead(&rac, ra->async_size);
-}
-
 /**
  * page_evictable - test whether a page is evictable
  * @page: the page to test


