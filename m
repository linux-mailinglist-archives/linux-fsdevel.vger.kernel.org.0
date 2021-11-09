Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81B544B4C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 22:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbhKIVcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 16:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230492AbhKIVcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636493404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOSFjmze2lq+KCADzfQWnIbaZ/LmbdWfVW3/mH571yI=;
        b=gPUhKPmOmOhcigFGsBdb7sKmS08v18vI8H/3SnGZ461Dgt9L6JN/i3jrZxcXzussiU2v7B
        p3lXyAN3r+Qkt1CbLFBYgTD2EVKVOAjO0yzB+hjMMfYkV3HjD8Kd8lHNlkcki/9TsJrwXO
        /KoPb9AElu9WkWOxJIplB+1NSCb5j00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-tj2_vvt-PxSmzOnxbJoAxw-1; Tue, 09 Nov 2021 16:27:40 -0500
X-MC-Unique: tj2_vvt-PxSmzOnxbJoAxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE03787D54C;
        Tue,  9 Nov 2021 21:27:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23BB710016F4;
        Tue,  9 Nov 2021 21:27:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 2/5] folio: Add a function to get the host inode for a
 folio
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        kafs-testing@auristor.com, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Nov 2021 21:27:35 +0000
Message-ID: <163649325519.309189.15072332908703129455.stgit@warthog.procyon.org.uk>
In-Reply-To: <163649323416.309189.4637503793406396694.stgit@warthog.procyon.org.uk>
References: <163649323416.309189.4637503793406396694.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a convenience function, folio_inode() that will get the host inode from
a folio's mapping.

Changes:
 ver #3:
  - Fix mistake in function description[2].
 ver #2:
  - Fix contradiction between doc and implementation by disallowing use
    with swap caches[1].

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Dominique Martinet <asmadeus@codewreck.org>
Tested-by: kafs-testing@auristor.com
Link: https://lore.kernel.org/r/YST8OcVNy02Rivbm@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/YYKLkBwQdtn4ja+i@casper.infradead.org/ [2]
Link: https://lore.kernel.org/r/162880453171.3369675.3704943108660112470.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/162981151155.1901565.7010079316994382707.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/163005744370.2472992.18324470937328925723.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163584184628.4023316.9386282630968981869.stgit@warthog.procyon.org.uk/ # v3
---

 include/linux/pagemap.h |   14 ++++++++++++++
 mm/page-writeback.c     |    2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1f560aecd9b5..1a0c646eb6ff 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -253,6 +253,20 @@ static inline struct address_space *page_mapping_file(struct page *page)
 	return folio_mapping(folio);
 }
 
+/**
+ * folio_inode - Get the host inode for this folio.
+ * @folio: The folio.
+ *
+ * For folios which are in the page cache, return the inode that this folio
+ * belongs to.
+ *
+ * Do not call this for folios which aren't in the page cache.
+ */
+static inline struct inode *folio_inode(struct folio *folio)
+{
+	return folio->mapping->host;
+}
+
 static inline bool page_cache_add_speculative(struct page *page, int count)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2d498bb62248..a613f8ef6a02 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2967,7 +2967,7 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
  */
 void folio_wait_stable(struct folio *folio)
 {
-	if (folio->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
+	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
 		folio_wait_writeback(folio);
 }
 EXPORT_SYMBOL_GPL(folio_wait_stable);


