Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE132FE2F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 07:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbhATXqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 18:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731508AbhATWXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611181316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDYFlUMcHb7rqZcW5EVf9/4GBcX/Hls07OkMcI3MsDw=;
        b=BziS5uQiNnagfMwiIGmyYaNWqUkW5c7707yrKrf0RzEVEjTnb6mgMaML6KwpoV3cBUtM4s
        /CMCodKXkyQierjujkLea13ByyuN4lH0vc4MNAq/B7w9YiUU79WFZtXtNQCi5ezUWO1Knq
        mhbjGToXXHJHudo9NWi82EhRskBWMkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-xFaa4qPFOFiVEU1Og4XnsQ-1; Wed, 20 Jan 2021 17:21:54 -0500
X-MC-Unique: xFaa4qPFOFiVEU1Og4XnsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5A95801817;
        Wed, 20 Jan 2021 22:21:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE53972161;
        Wed, 20 Jan 2021 22:21:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/25] vm: Add wait/unlock functions for PG_fscache
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Jan 2021 22:21:49 +0000
Message-ID: <161118130899.1232039.12854903243561277618.stgit@warthog.procyon.org.uk>
In-Reply-To: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
References: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add functions to unlock and wait for unlock of PG_fscache analogously with
those for PG_lock.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/pagemap.h |   14 ++++++++++++++
 mm/filemap.c            |   18 ++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d5570deff400..1fa160e682fa 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -591,6 +591,7 @@ extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 extern void unlock_page(struct page *page);
+extern void unlock_page_fscache(struct page *page);
 
 /*
  * Return true if the page was successfully locked
@@ -681,6 +682,19 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return wait_on_page_bit_killable(compound_head(page), PG_locked);
 }
 
+/**
+ * wait_on_page_fscache - Wait for PG_fscache to be cleared on a page
+ * @page: The page
+ *
+ * Wait for the fscache mark to be removed from a page, usually signifying the
+ * completion of a write from that page to the cache.
+ */
+static inline void wait_on_page_fscache(struct page *page)
+{
+	if (PagePrivate2(page))
+		wait_on_page_bit(compound_head(page), PG_fscache);
+}
+
 extern void put_and_wait_on_page_locked(struct page *page);
 
 void wait_on_page_writeback(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index 5c9d564317a5..91fcae006d64 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1466,6 +1466,24 @@ void unlock_page(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page);
 
+/**
+ * unlock_page_fscache - Unlock a page pinned with PG_fscache
+ * @page: The page
+ *
+ * Unlocks the page and wakes up sleepers in wait_on_page_fscache().  Also
+ * wakes those waiting for the lock and writeback bits because the wakeup
+ * mechanism is shared.  But that's OK - those sleepers will just go back to
+ * sleep.
+ */
+void unlock_page_fscache(struct page *page)
+{
+	page = compound_head(page);
+	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
+	clear_bit_unlock(PG_fscache, &page->flags);
+	wake_up_page_bit(page, PG_fscache);
+}
+EXPORT_SYMBOL(unlock_page_fscache);
+
 /**
  * end_page_writeback - end writeback against a page
  * @page: the page


