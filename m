Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46D346C19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhCWWSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233916AbhCWWSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dd3Wvg+wEHnVZubt2HljSZhhUh+SRzXvIVA09Ibt8Q=;
        b=feZsQIKLD1O1T9SbZS9sUwCXE4AD+ATrvkotaxb5l9JaocARIPPLJtOlqIjz9oYg3YDXxc
        cFl9XudOi02OqUcoTm1eDMhr0Z71iCp8TX+t5JV+ZhZPziqchj1mjtW4SSTF/2Q+rSiYV0
        127tZyRQfGi33AYrLcYW+/rMvKk8v/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-RD3RKnKKMB68RW6NO1X1hw-1; Tue, 23 Mar 2021 18:18:11 -0400
X-MC-Unique: RD3RKnKKMB68RW6NO1X1hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0862A88EF00;
        Tue, 23 Mar 2021 22:18:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9BF9196E3;
        Tue, 23 Mar 2021 22:18:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 03/28] mm: Add set/end/wait functions for PG_private_2
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:18:02 +0000
Message-ID: <161653788200.2770958.9517755716374927208.stgit@warthog.procyon.org.uk>
In-Reply-To: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
References: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add three functions to manipulate PG_private_2:

 (*) set_page_private_2() - Set the flag and take an appropriate reference
     on the flagged page.

 (*) end_page_private_2() - Clear the flag, drop the reference and wake up
     any waiters, somewhat analogously with end_page_writeback().

 (*) wait_on_page_private_2() - Wait for the flag to be cleared.

Wrappers will need to be placed in the netfs lib header in the patch that
adds that.

[This implements a suggestion by Linus[1] to not mix the terminology of
 PG_private_2 and PG_fscache in the mm core function]

Changes:
v5:
- Add set and end functions, calling the end function end rather than
  unlock[3].
- Keep a ref on the page when PG_private_2 is set[4][5].

v4:
- Remove extern from the declaration[2].

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/1330473.1612974547@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com/ [1]
Link: https://lore.kernel.org/r/20210216102659.GA27714@lst.de/ [2]
Link: https://lore.kernel.org/r/161340387944.1303470.7944159520278177652.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk # v4
Link: https://lore.kernel.org/r/20210321105309.GG3420@casper.infradead.org [3]
Link: https://lore.kernel.org/r/CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com/ [4]
Link: https://lore.kernel.org/r/CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com/ [5]
---

 include/linux/pagemap.h |   19 +++++++++++++++
 mm/filemap.c            |   59 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 444155ae56c0..da5c38864037 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -689,6 +689,25 @@ void wait_for_stable_page(struct page *page);
 
 void page_endio(struct page *page, bool is_write, int err);
 
+/**
+ * set_page_private_2 - Set PG_private_2 on a page and take a ref
+ * @page: The page.
+ *
+ * Set the PG_private_2 flag on a page and take the reference needed for the VM
+ * to handle its lifetime correctly.  This sets the flag and takes the
+ * reference unconditionally, so care must be taken not to set the flag again
+ * if it's already set.
+ */
+static inline void set_page_private_2(struct page *page)
+{
+	get_page(page);
+	SetPagePrivate2(page);
+}
+
+void end_page_private_2(struct page *page);
+void wait_on_page_private_2(struct page *page);
+int wait_on_page_private_2_killable(struct page *page);
+
 /*
  * Add an arbitrary waiter to a page's wait queue
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index 43700480d897..788b71e8a72d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1432,6 +1432,65 @@ void unlock_page(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page);
 
+/**
+ * end_page_private_2 - Clear PG_private_2 and release any waiters
+ * @page: The page
+ *
+ * Clear the PG_private_2 bit on a page and wake up any sleepers waiting for
+ * this.  The page ref held for PG_private_2 being set is released.
+ *
+ * This is, for example, used when a netfs page is being written to a local
+ * disk cache, thereby allowing writes to the cache for the same page to be
+ * serialised.
+ */
+void end_page_private_2(struct page *page)
+{
+	page = compound_head(page);
+	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
+	clear_bit_unlock(PG_private_2, &page->flags);
+	wake_up_page_bit(page, PG_private_2);
+	put_page(page);
+}
+EXPORT_SYMBOL(end_page_private_2);
+
+/**
+ * wait_on_page_private_2 - Wait for PG_private_2 to be cleared on a page
+ * @page: The page to wait on
+ *
+ * Wait for PG_private_2 (aka PG_fscache) to be cleared on a page.
+ */
+void wait_on_page_private_2(struct page *page)
+{
+	while (PagePrivate2(page))
+		wait_on_page_bit(page, PG_private_2);
+}
+EXPORT_SYMBOL(wait_on_page_private_2);
+
+/**
+ * wait_on_page_private_2_killable - Wait for PG_private_2 to be cleared on a page
+ * @page: The page to wait on
+ *
+ * Wait for PG_private_2 (aka PG_fscache) to be cleared on a page or until a
+ * fatal signal is received by the calling task.
+ *
+ * Return:
+ * - 0 if successful.
+ * - -EINTR if a fatal signal was encountered.
+ */
+int wait_on_page_private_2_killable(struct page *page)
+{
+	int ret = 0;
+
+	while (PagePrivate2(page)) {
+		ret = wait_on_page_bit_killable(page, PG_private_2);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(wait_on_page_private_2_killable);
+
 /**
  * end_page_writeback - end writeback against a page
  * @page: the page


