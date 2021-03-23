Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA4346C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhCWWSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233853AbhCWWSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wc1tHYEycG0FRmZQbIWHGSriJOssCKvxl09WyfLRD2g=;
        b=h8dv70+4B0gyucjZ5A/ieDHgUWGbx9riuFJssaupopCPC1mAUKoUQv6TFpUMS6Sf0X/URp
        CxnUC7N3EPgW8OJet5AMhAgAAr8nOnEQLqnK2RDzn7ccntI3ZlfYR6IJgHp5r6Uvf54COk
        uYEwWs64/q03h/YC0uNlU5V7+dz++QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-UFUoV2jjOZ-xgD2r8roNeA-1; Tue, 23 Mar 2021 18:17:58 -0400
X-MC-Unique: UFUoV2jjOZ-xgD2r8roNeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47A71084D68;
        Tue, 23 Mar 2021 22:17:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADF4460243;
        Tue, 23 Mar 2021 22:17:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 02/28] mm: Add wait_on_page_writeback_killable()
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Date:   Tue, 23 Mar 2021 22:17:52 +0000
Message-ID: <161653787287.2770958.17679186162121211209.stgit@warthog.procyon.org.uk>
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

Add a function to wait killably on the PG_writeback page flag.

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
---

 include/linux/pagemap.h |    1 +
 mm/page-writeback.c     |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 20225b067583..444155ae56c0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -683,6 +683,7 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
+int wait_on_page_writeback_killable(struct page *page);
 extern void end_page_writeback(struct page *page);
 void wait_for_stable_page(struct page *page);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb34d204d4ee..b8bad275f94b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2833,6 +2833,31 @@ void wait_on_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
 
+/**
+ * Wait for a page to complete writeback
+ * @page: The page to wait on
+ *
+ * Wait for the writeback status of a page to clear or a fatal signal to occur.
+ *
+ * Return:
+ * - 0 on success.
+ * - -EINTR if a fatal signal was encountered.
+ */
+int wait_on_page_writeback_killable(struct page *page)
+{
+	int ret = 0;
+
+	while (PageWriteback(page)) {
+		trace_wait_on_page_writeback(page, page_mapping(page));
+		ret = wait_on_page_bit_killable(page, PG_writeback);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(wait_on_page_writeback_killable);
+
 /**
  * wait_for_stable_page() - wait for writeback to finish, if necessary.
  * @page:	The page to wait on.


