Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C128933440A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 17:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhCJQ4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233599AbhCJQ4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615395374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RkMaKS84Erw5iqrERot0PwU2wMGkYNCFnxXlts7pQU=;
        b=GUpgdfdctGwsja7oEt4hyJu24NTietRN9yTY3M4KbYlfUINAhU/Jbd2YZ4hTtzOexsXvc6
        GaOgO4JM1iTU76xfOzO9ux38kBNiXyNAGe53Dp9iAl8AVYqhR7KSL0WPahn9fp1lC7n7ub
        x9XPmkDtACvUEKrQ7ecZ87PKbWO8Eaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-w3Zuq-KbOdGbIIgAEsl6Sg-1; Wed, 10 Mar 2021 11:56:10 -0500
X-MC-Unique: w3Zuq-KbOdGbIIgAEsl6Sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A101934106;
        Wed, 10 Mar 2021 16:56:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 537A010013C1;
        Wed, 10 Mar 2021 16:56:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 07/28] netfs,
 mm: Add unlock_page_fscache() and wait_on_page_fscache()
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
Date:   Wed, 10 Mar 2021 16:56:00 +0000
Message-ID: <161539536093.286939.5076448803512118764.stgit@warthog.procyon.org.uk>
In-Reply-To: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add unlock_page_fscache() as an alias of unlock_page_private_2().  This
allows a page 'locked' with PG_fscache to be unlocked.

Add wait_on_page_fscache() to wait for PG_fscache to be unlocked.

[Linus suggested putting the fscache-themed functions into the
 caching-specific headers rather than pagemap.h[1]]

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
---

 include/linux/netfs.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index cc1102040488..5ed8c6dc7453 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -26,4 +26,33 @@
 #define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
 #define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
 
+/**
+ * unlock_page_fscache - Unlock a page that's locked with PG_fscache
+ * @page: The page
+ *
+ * Unlocks a page that's locked with PG_fscache and wakes up sleepers in
+ * wait_on_page_fscache().  This page bit is used by the netfs helpers when a
+ * netfs page is being written to a local disk cache, thereby allowing writes
+ * to the cache for the same page to be serialised.
+ */
+static inline void unlock_page_fscache(struct page *page)
+{
+	unlock_page_private_2(page);
+}
+
+/**
+ * wait_on_page_fscache - Wait for PG_fscache to be cleared on a page
+ * @page: The page
+ *
+ * Wait for the PG_fscache (PG_private_2) page bit to be removed from a page.
+ * This is, for example, used to handle a netfs page being written to a local
+ * disk cache, thereby allowing writes to the cache for the same page to be
+ * serialised.
+ */
+static inline void wait_on_page_fscache(struct page *page)
+{
+	if (PageFsCache(page))
+		wait_on_page_bit(compound_head(page), PG_fscache);
+}
+
 #endif /* _LINUX_NETFS_H */


