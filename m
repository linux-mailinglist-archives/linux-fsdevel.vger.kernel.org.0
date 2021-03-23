Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9E345F7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhCWNSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 09:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231683AbhCWNRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616505453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRkjTtb93YUNeVAd/BbXfvOHeWrSjEm57bE3N3KyVfI=;
        b=bSy/ibn8PkCE2CT1ODyrxtK69kdy8r0H8P1hL6Sv2VESg6PopstIDnlyc7NglzsZQg17U7
        FFXgixpV7k2JdB7LUh1bnSl/DjlPdxZ3Gd6JK1wbTTzChEztoeyyxZO6FrN8W6iVHtQgOp
        ktl/l9m81nN5KnU8eOJPa1VVNnPzHOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-bJPnASvjNIq86k_X6wklsg-1; Tue, 23 Mar 2021 09:17:31 -0400
X-MC-Unique: bJPnASvjNIq86k_X6wklsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1F8764151;
        Tue, 23 Mar 2021 13:17:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF8A610AF;
        Tue, 23 Mar 2021 13:17:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1885296.1616410586@warthog.procyon.org.uk>
References: <1885296.1616410586@warthog.procyon.org.uk> <20210321105309.GG3420@casper.infradead.org> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2499406.1616505440.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 23 Mar 2021 13:17:20 +0000
Message-ID: <2499407.1616505440@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Matthew Wilcox <willy@infradead.org> wrote:
> =

> > That also brings up that there is no set_page_private_2().  I think
> > that's OK -- you only set PageFsCache() immediately after reading the
> > page from the server.  But I feel this "unlock_page_private_2" is actu=
ally
> > "clear_page_private_2" -- ie it's equivalent to writeback, not to lock=
.
> =

> How about I do the following:
> =

>  (1) Add set_page_private_2() or mark_page_private_2() to set the PG_fsc=
ache_2
>      bit.  It could take a ref on the page here.
> =

>  (2) Rename unlock_page_private_2() to end_page_private_2().  It could d=
rop
>      the ref on the page here, but that then means I can't use
>      pagevec_release().
> =

>  (3) Add wait_on_page_private_2() an analogue of wait_on_page_writeback(=
)
>      rather than wait_on_page_locked().
> =

>  (4) Provide fscache synonyms of the above.

Perhaps something like the attached changes (they'll need merging back int=
o
the other patches).

David
---
 include/linux/pagemap.h |   21 +++++++++++++++++-
 include/linux/netfs.h   |   54 ++++++++++++++++++++++++++++++++++++------=
------
 fs/afs/write.c          |    5 ++--
 fs/netfs/read_helper.c  |   17 +++++----------
 mm/filemap.c            |   49 +++++++++++++++++++++++++++++++++++++++---=
-
 mm/page-writeback.c     |   25 ++++++++++++++++++++++
 6 files changed, 139 insertions(+), 32 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bf05e99ce588..5c14a9365aae 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -591,7 +591,6 @@ extern int __lock_page_async(struct page *page, struct=
 wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 extern void unlock_page(struct page *page);
-void unlock_page_private_2(struct page *page);
 =

 /*
  * Return true if the page was successfully locked
@@ -684,11 +683,31 @@ static inline int wait_on_page_locked_killable(struc=
t page *page)
 =

 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
+int wait_on_page_writeback_killable(struct page *page);
 extern void end_page_writeback(struct page *page);
 void wait_for_stable_page(struct page *page);
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
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9d3fbed4e30a..2299e7662ff0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -29,32 +29,60 @@
 #define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
 =

 /**
- * unlock_page_fscache - Unlock a page that's locked with PG_fscache
- * @page: The page
+ * set_page_fscache - Set PG_fscache on a page and take a ref
+ * @page: The page.
  *
- * Unlocks a page that's locked with PG_fscache and wakes up sleepers in
- * wait_on_page_fscache().  This page bit is used by the netfs helpers wh=
en a
- * netfs page is being written to a local disk cache, thereby allowing wr=
ites
- * to the cache for the same page to be serialised.
+ * Set the PG_fscache (PG_private_2) flag on a page and take the referenc=
e
+ * needed for the VM to handle its lifetime correctly.  This sets the fla=
g and
+ * takes the reference unconditionally, so care must be taken not to set =
the
+ * flag again if it's already set.
  */
-static inline void unlock_page_fscache(struct page *page)
+static inline void set_page_fscache(struct page *page)
 {
-	unlock_page_private_2(page);
+	set_page_private_2(page);
 }
 =

 /**
- * wait_on_page_fscache - Wait for PG_fscache to be cleared on a page
+ * end_page_fscache - Clear PG_fscache and release any waiters
  * @page: The page
  *
- * Wait for the PG_fscache (PG_private_2) page bit to be removed from a p=
age.
- * This is, for example, used to handle a netfs page being written to a l=
ocal
+ * Clear the PG_fscache (PG_private_2) bit on a page and wake up any slee=
pers
+ * waiting for this.  The page ref held for PG_private_2 being set is rel=
eased.
+ *
+ * This is, for example, used when a netfs page is being written to a loc=
al
  * disk cache, thereby allowing writes to the cache for the same page to =
be
  * serialised.
  */
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
 static inline void wait_on_page_fscache(struct page *page)
 {
-	if (PageFsCache(page))
-		wait_on_page_bit(compound_head(page), PG_fscache);
+	wait_on_page_private_2(page);
+}
+
+/**
+ * wait_on_page_fscache_killable - Wait for PG_fscache to be cleared on a=
 page
+ * @page: The page to wait on
+ *
+ * Wait for PG_fscache (aka PG_private_2) to be cleared on a page or unti=
l a
+ * fatal signal is received by the calling task.
+ *
+ * Return:
+ * - 0 if successful.
+ * - -EINTR if a fatal signal was encountered.
+ */
+static inline int wait_on_page_fscache_killable(struct page *page)
+{
+	return wait_on_page_private_2_killable(page);
 }
 =

 enum netfs_read_source {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index b2e03de09c24..9f82e2bb463e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -846,7 +846,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 */
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page) &&
-	    wait_on_page_bit_killable(page, PG_fscache) < 0)
+	    wait_on_page_fscache_killable(page) < 0)
 		return VM_FAULT_RETRY;
 #endif
 =

@@ -861,7 +861,8 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 * details the portion of the page we need to write back and we might
 	 * need to redirty the page if there's a problem.
 	 */
-	wait_on_page_writeback(page);
+	if (wait_on_page_writeback_killable(page) < 0)
+		return VM_FAULT_RETRY | VM_FAULT_LOCKED;
 =

 	priv =3D afs_page_dirty(page, 0, thp_size(page));
 	priv =3D afs_page_dirty_mmapped(priv);
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 56e90e0388f2..2b23584499b2 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -239,13 +239,10 @@ static void netfs_rreq_unmark_after_write(struct net=
fs_read_request *rreq,
 					  bool was_async)
 {
 	struct netfs_read_subrequest *subreq;
-	struct pagevec pvec;
 	struct page *page;
 	pgoff_t unlocked =3D 0;
 	bool have_unlocked =3D false;
 =

-	pagevec_init(&pvec);
-
 	rcu_read_lock();
 =

 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
@@ -258,9 +255,7 @@ static void netfs_rreq_unmark_after_write(struct netfs=
_read_request *rreq,
 			if (have_unlocked && page->index <=3D unlocked)
 				continue;
 			unlocked =3D page->index;
-			unlock_page_fscache(page);
-			if (pagevec_add(&pvec, page) =3D=3D 0)
-				pagevec_release(&pvec);
+			end_page_fscache(page);
 			have_unlocked =3D true;
 		}
 	}
@@ -419,10 +414,8 @@ static void netfs_rreq_unlock(struct netfs_read_reque=
st *rreq)
 				pg_failed =3D true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
-				get_page(page);
-				SetPageFsCache(page);
-			}
+			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
+				set_page_fscache(page);
 			pg_failed |=3D subreq_failed;
 			if (pgend < iopos + subreq->len)
 				break;
@@ -1167,7 +1160,9 @@ int netfs_write_begin(struct file *file, struct addr=
ess_space *mapping,
 		goto error;
 =

 have_page:
-	wait_on_page_fscache(page);
+	ret =3D wait_on_page_fscache_killable(page);
+	if (ret < 0)
+		goto error;
 have_page_no_wait:
 	if (netfs_priv)
 		ops->cleanup(netfs_priv, mapping);
diff --git a/mm/filemap.c b/mm/filemap.c
index 925964b67583..788b71e8a72d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1433,24 +1433,63 @@ void unlock_page(struct page *page)
 EXPORT_SYMBOL(unlock_page);
 =

 /**
- * unlock_page_private_2 - Unlock a page that's locked with PG_private_2
+ * end_page_private_2 - Clear PG_private_2 and release any waiters
  * @page: The page
  *
- * Unlocks a page that's locked with PG_private_2 and wakes up sleepers i=
n
- * wait_on_page_private_2().
+ * Clear the PG_private_2 bit on a page and wake up any sleepers waiting =
for
+ * this.  The page ref held for PG_private_2 being set is released.
  *
  * This is, for example, used when a netfs page is being written to a loc=
al
  * disk cache, thereby allowing writes to the cache for the same page to =
be
  * serialised.
  */
-void unlock_page_private_2(struct page *page)
+void end_page_private_2(struct page *page)
 {
 	page =3D compound_head(page);
 	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
 	clear_bit_unlock(PG_private_2, &page->flags);
 	wake_up_page_bit(page, PG_private_2);
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
+	while (PagePrivate2(page)) {
+		ret =3D wait_on_page_bit_killable(page, PG_private_2);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
 }
-EXPORT_SYMBOL(unlock_page_private_2);
+EXPORT_SYMBOL(wait_on_page_private_2_killable);
 =

 /**
  * end_page_writeback - end writeback against a page
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb34d204d4ee..b8bad275f94b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2833,6 +2833,31 @@ void wait_on_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
 =

+/**
+ * Wait for a page to complete writeback
+ * @page: The page to wait on
+ *
+ * Wait for the writeback status of a page to clear or a fatal signal to =
occur.
+ *
+ * Return:
+ * - 0 on success.
+ * - -EINTR if a fatal signal was encountered.
+ */
+int wait_on_page_writeback_killable(struct page *page)
+{
+	int ret =3D 0;
+
+	while (PageWriteback(page)) {
+		trace_wait_on_page_writeback(page, page_mapping(page));
+		ret =3D wait_on_page_bit_killable(page, PG_writeback);
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

