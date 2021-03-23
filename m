Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C726345D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCWLx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 07:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhCWLxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616500427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lumMgAdwXyhnl+R2Z3fSylhLVHDsECYsMOyRTYA/Iy0=;
        b=dVYJd2QcfRvAAZczMU/MIQjZ2zTICCgtmfnKRSse6xYT4Pxk6+UzCCNE+bhbOTqamRnqmF
        YGQyI2GJKt5rscVE9QTtRc1ynauwjY1IIURLrKMJm/lOASZUreu+vwe40TWpqD4tsLtsIS
        2pBipW0UDgtTjhmSerr6vgEPKvWvzXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-qlWy5tDFOXCL1jNjWhjiMA-1; Tue, 23 Mar 2021 07:53:43 -0400
X-MC-Unique: qlWy5tDFOXCL1jNjWhjiMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4C42190B2A5;
        Tue, 23 Mar 2021 11:53:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 123875D6AD;
        Tue, 23 Mar 2021 11:53:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/3] fs/cachefiles: Remove wait_bit_key layout dependency
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 11:53:36 +0000
Message-ID: <161650041625.2445805.664163782892781172.stgit@warthog.procyon.org.uk>
In-Reply-To: <161650040278.2445805.7652115256944270457.stgit@warthog.procyon.org.uk>
References: <161650040278.2445805.7652115256944270457.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

Cachefiles was relying on wait_page_key and wait_bit_key being the
same layout, which is fragile.  Now that wait_page_key is exposed in
the pagemap.h header, we can remove that fragility

A comment on the need to maintain structure layout equivalence was added by
Linus[1] and that is no longer applicable.

Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20210320054104.1300774-2-willy@infradead.org/
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3510ca20ece0150af6b10c77a74ff1b5c198e3e2 [1]
---

 fs/cachefiles/rdwr.c    |    7 +++----
 include/linux/pagemap.h |    1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index e027c718ca01..8ffc40e84a59 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -24,17 +24,16 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 		container_of(wait, struct cachefiles_one_read, monitor);
 	struct cachefiles_object *object;
 	struct fscache_retrieval *op = monitor->op;
-	struct wait_bit_key *key = _key;
+	struct wait_page_key *key = _key;
 	struct page *page = wait->private;
 
 	ASSERT(key);
 
 	_enter("{%lu},%u,%d,{%p,%u}",
 	       monitor->netfs_page->index, mode, sync,
-	       key->flags, key->bit_nr);
+	       key->page, key->bit_nr);
 
-	if (key->flags != &page->flags ||
-	    key->bit_nr != PG_locked)
+	if (key->page != page || key->bit_nr != PG_locked)
 		return 0;
 
 	_debug("--- monitor %p %lx ---", page, page->flags);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 20225b067583..8f4daac6eb4b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -559,7 +559,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 	return pgoff;
 }
 
-/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
 struct wait_page_key {
 	struct page *page;
 	int bit_nr;


