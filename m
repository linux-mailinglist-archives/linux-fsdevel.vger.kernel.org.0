Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6235E25F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbhDMPMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 11:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241083AbhDMPMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618326714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1L1Z0ygS3hd8ceMBwgVKNrSIJsloDDgfJpTVcphdbw=;
        b=E75X6jOonNKF2JYqLWKer/hgoNzuOYjL0aRHkqEdmeXRJ5+iAGcu2W8UVP31AWI9786cuF
        WXB15lG3ZJ+g2ekGNmXc6xahpp/sEQnoGHjzISIOWfHVz5Dm4k99uH+4APG7UU4e7SLJAs
        0s45DWrL2Y7zuYuRqWBp1i2aryKk13A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Wf5oAXR-O_2gIx9CZkNfjQ-1; Tue, 13 Apr 2021 11:11:52 -0400
X-MC-Unique: Wf5oAXR-O_2gIx9CZkNfjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3BAE814336;
        Tue, 13 Apr 2021 15:11:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DBC419D9F;
        Tue, 13 Apr 2021 15:11:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210408145057.GN2531743@casper.infradead.org>
References: <20210408145057.GN2531743@casper.infradead.org> <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk> <161789066013.6155.9816857201817288382.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7] mm: Add set/end/wait functions for PG_private_2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1268563.1618326701.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Apr 2021 16:11:41 +0100
Message-ID: <1268564.1618326701@warthog.procyon.org.uk>
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
v7:
- Use compound_head() in all the functions to make them THP safe[6].

v5:
- Add set and end functions, calling the end function end rather than
  unlock[3].
- Keep a ref on the page when PG_private_2 is set[4][5].

v4:
- Remove extern from the declaration[2].

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Dave Wysochanski <dwysocha@redhat.com>
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
Link: https://lore.kernel.org/r/1330473.1612974547@warthog.procyon.org.uk/=
 # v1
Link: https://lore.kernel.org/r/CAHk-=3DwjgA-74ddehziVk=3DXAEMTKswPu1Yw4ua=
ro1R3ibs27ztw@mail.gmail.com/ [1]
Link: https://lore.kernel.org/r/20210216102659.GA27714@lst.de/ [2]
Link: https://lore.kernel.org/r/161340387944.1303470.7944159520278177652.s=
tgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539528910.286939.1252328699383291173.st=
git@warthog.procyon.org.uk # v4
Link: https://lore.kernel.org/r/20210321105309.GG3420@casper.infradead.org=
 [3]
Link: https://lore.kernel.org/r/CAHk-=3Dwh+2gbF7XEjYc=3DHV9w_2uVzVf7vs60BP=
z0gFA=3D+pUm3ww@mail.gmail.com/ [4]
Link: https://lore.kernel.org/r/CAHk-=3DwjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_W=
eTgwBBu4uqg@mail.gmail.com/ [5]
Link: https://lore.kernel.org/r/20210408145057.GN2531743@casper.infradead.=
org/ [6]
Link: https://lore.kernel.org/r/161653788200.2770958.9517755716374927208.s=
tgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/161789066013.6155.9816857201817288382.stgi=
t@warthog.procyon.org.uk/ # v6
---
 include/linux/pagemap.h |   20 +++++++++++++++
 mm/filemap.c            |   61 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 81 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8c9947fd62f3..bb4433c98d02 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -688,6 +688,26 @@ void wait_for_stable_page(struct page *page);
 =

 void page_endio(struct page *page, bool is_write, int err);
 =

+/**
+ * set_page_private_2 - Set PG_private_2 on a page and take a ref
+ * @page: The page.
+ *
+ * Set the PG_private_2 flag on a page and take the reference needed for =
the VM
+ * to handle its lifetime correctly.  This sets the flag and takes the
+ * reference unconditionally, so care must be taken not to set the flag a=
gain
+ * if it's already set.
+ */
+static inline void set_page_private_2(struct page *page)
+{
+	page =3D compound_head(page);
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
index 43700480d897..afe22f09960e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1432,6 +1432,67 @@ void unlock_page(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page);
 =

+/**
+ * end_page_private_2 - Clear PG_private_2 and release any waiters
+ * @page: The page
+ *
+ * Clear the PG_private_2 bit on a page and wake up any sleepers waiting =
for
+ * this.  The page ref held for PG_private_2 being set is released.
+ *
+ * This is, for example, used when a netfs page is being written to a loc=
al
+ * disk cache, thereby allowing writes to the cache for the same page to =
be
+ * serialised.
+ */
+void end_page_private_2(struct page *page)
+{
+	page =3D compound_head(page);
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
+	page =3D compound_head(page);
+	while (PagePrivate2(page))
+		wait_on_page_bit(page, PG_private_2);
+}
+EXPORT_SYMBOL(wait_on_page_private_2);
+
+/**
+ * wait_on_page_private_2_killable - Wait for PG_private_2 to be cleared =
on a page
+ * @page: The page to wait on
+ *
+ * Wait for PG_private_2 (aka PG_fscache) to be cleared on a page or unti=
l a
+ * fatal signal is received by the calling task.
+ *
+ * Return:
+ * - 0 if successful.
+ * - -EINTR if a fatal signal was encountered.
+ */
+int wait_on_page_private_2_killable(struct page *page)
+{
+	int ret =3D 0;
+
+	page =3D compound_head(page);
+	while (PagePrivate2(page)) {
+		ret =3D wait_on_page_bit_killable(page, PG_private_2);
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

