Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B366D346C47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhCWWU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233913AbhCWWTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u10f6m68wj1IT012S8kFBCF+80WgNRA2rBPk1Qb/XNA=;
        b=OdvljxPsknIUGI8/jSJIgNerpymLSE6iCqFgZJaWJsrVbx1KLZ5Br8UhbMiuf2ZpwCuSEM
        +2TB0vqs4ECW9HpcDqZMObxBtuKYVv//nh81wU5D5wbCTjef65AvwkXaqLOn49nAmcL/dp
        AhQIxkEj8KTBq2KNNlSZWNB141Y7p8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-eTw9cYKeO5-IMLdrcNt2YA-1; Tue, 23 Mar 2021 18:19:11 -0400
X-MC-Unique: eTw9cYKeO5-IMLdrcNt2YA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1828981425A;
        Tue, 23 Mar 2021 22:19:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D27D60BE5;
        Tue, 23 Mar 2021 22:18:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 08/28] netfs,
 mm: Add set/end/wait_on_page_fscache() aliases
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
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
Date:   Tue, 23 Mar 2021 22:18:58 +0000
Message-ID: <161653793873.2770958.12157243390965814502.stgit@warthog.procyon.org.uk>
In-Reply-To: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
References: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add set/end/wait_on_page_fscache() as aliases of
set/end/wait_page_private_2().  These allow a page to marked with
PG_fscache, the flag to be removed and waiters woken and waiting for the
flag to be cleared.  A ref on the page is also taken and dropped.

[Linus suggested putting the fscache-themed functions into the
 caching-specific headers rather than pagemap.h[1]]

Changes:
v5:
- Mirror the changes to the core routines[2].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/1330473.1612974547@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com/ [1]
Link: https://lore.kernel.org/r/161340393568.1303470.4997526899111310530.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539536093.286939.5076448803512118764.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/2499407.1616505440@warthog.procyon.org.uk/ [2]
---

 include/linux/netfs.h |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index cc1102040488..8479d63406f7 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -26,4 +26,61 @@
 #define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
 #define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
 
+/**
+ * set_page_fscache - Set PG_fscache on a page and take a ref
+ * @page: The page.
+ *
+ * Set the PG_fscache (PG_private_2) flag on a page and take the reference
+ * needed for the VM to handle its lifetime correctly.  This sets the flag and
+ * takes the reference unconditionally, so care must be taken not to set the
+ * flag again if it's already set.
+ */
+static inline void set_page_fscache(struct page *page)
+{
+	set_page_private_2(page);
+}
+
+/**
+ * end_page_fscache - Clear PG_fscache and release any waiters
+ * @page: The page
+ *
+ * Clear the PG_fscache (PG_private_2) bit on a page and wake up any sleepers
+ * waiting for this.  The page ref held for PG_private_2 being set is released.
+ *
+ * This is, for example, used when a netfs page is being written to a local
+ * disk cache, thereby allowing writes to the cache for the same page to be
+ * serialised.
+ */
+static inline void end_page_fscache(struct page *page)
+{
+	end_page_private_2(page);
+}
+
+/**
+ * wait_on_page_fscache - Wait for PG_fscache to be cleared on a page
+ * @page: The page to wait on
+ *
+ * Wait for PG_fscache (aka PG_private_2) to be cleared on a page.
+ */
+static inline void wait_on_page_fscache(struct page *page)
+{
+	wait_on_page_private_2(page);
+}
+
+/**
+ * wait_on_page_fscache_killable - Wait for PG_fscache to be cleared on a page
+ * @page: The page to wait on
+ *
+ * Wait for PG_fscache (aka PG_private_2) to be cleared on a page or until a
+ * fatal signal is received by the calling task.
+ *
+ * Return:
+ * - 0 if successful.
+ * - -EINTR if a fatal signal was encountered.
+ */
+static inline int wait_on_page_fscache_killable(struct page *page)
+{
+	return wait_on_page_private_2_killable(page);
+}
+
 #endif /* _LINUX_NETFS_H */


