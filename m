Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2166A8CF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCBXYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCBXY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC43166FC
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677799425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnx3/NVhevje7xRs6jQfMiw8eOmAu/z4kjbV7YxLpFU=;
        b=N3b/QmQulqTm7Lp+83sLSOTEDXBU/mt3I25g4QmGUi8q/YKCFv4nletEt+XFwpetJXIRO+
        jjLvnn3SX0gkCST9+ePLCefM2bOnTpHdnLgKDJMHjymNG22zRSCWzapdckTFEEwmYGqaIP
        EmM51FFXPceJ7xZh2DZjVh6SqihN66w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-LSj61p7LPEmXn6HCBRDYYg-1; Thu, 02 Mar 2023 18:23:44 -0500
X-MC-Unique: LSj61p7LPEmXn6HCBRDYYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2CE3811E6E;
        Thu,  2 Mar 2023 23:23:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E03432166B26;
        Thu,  2 Mar 2023 23:23:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230302231638.521280-1-dhowells@redhat.com>
References: <20230302231638.521280-1-dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Vishal Moola <vishal.moola@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Paulo Alcantara <pc@cjr.nz>, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Test patch to remove per-page dirty region tracking from afs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <521670.1677799421.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 02 Mar 2023 23:23:41 +0000
Message-ID: <521671.1677799421@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> AFS firstly. ...
> =

>   Base + Page-dirty-region removed:
> 	WRITE: bw=3D301MiB/s (315MB/s), 70.4MiB/s-80.2MiB/s (73.8MB/s-84.1MB/s)
> 	WRITE: bw=3D325MiB/s (341MB/s), 78.5MiB/s-87.1MiB/s (82.3MB/s-91.3MB/s)
> 	WRITE: bw=3D320MiB/s (335MB/s), 71.6MiB/s-88.6MiB/s (75.0MB/s-92.9MB/s)

Here's a patch to remove the use of page->private data to track the dirty =
part
of a page from afs.

David
---
 fs/afs/file.c              |   68 ----------------
 fs/afs/internal.h          |   56 -------------
 fs/afs/write.c             |  187 +++++++++------------------------------=
------
 fs/cifs/file.c             |    1 =

 include/trace/events/afs.h |   14 ---
 5 files changed, 45 insertions(+), 281 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 68d6d5dc608d..a2f3316fa174 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -402,80 +402,18 @@ int afs_write_inode(struct inode *inode, struct writ=
eback_control *wbc)
 	return 0;
 }
 =

-/*
- * Adjust the dirty region of the page on truncation or full invalidation=
,
- * getting rid of the markers altogether if the region is entirely invali=
dated.
- */
-static void afs_invalidate_dirty(struct folio *folio, size_t offset,
-				 size_t length)
-{
-	struct afs_vnode *vnode =3D AFS_FS_I(folio_inode(folio));
-	unsigned long priv;
-	unsigned int f, t, end =3D offset + length;
-
-	priv =3D (unsigned long)folio_get_private(folio);
-
-	/* we clean up only if the entire page is being invalidated */
-	if (offset =3D=3D 0 && length =3D=3D folio_size(folio))
-		goto full_invalidate;
-
-	 /* If the page was dirtied by page_mkwrite(), the PTE stays writable
-	  * and we don't get another notification to tell us to expand it
-	  * again.
-	  */
-	if (afs_is_folio_dirty_mmapped(priv))
-		return;
-
-	/* We may need to shorten the dirty region */
-	f =3D afs_folio_dirty_from(folio, priv);
-	t =3D afs_folio_dirty_to(folio, priv);
-
-	if (t <=3D offset || f >=3D end)
-		return; /* Doesn't overlap */
-
-	if (f < offset && t > end)
-		return; /* Splits the dirty region - just absorb it */
-
-	if (f >=3D offset && t <=3D end)
-		goto undirty;
-
-	if (f < offset)
-		t =3D offset;
-	else
-		f =3D end;
-	if (f =3D=3D t)
-		goto undirty;
-
-	priv =3D afs_folio_dirty(folio, f, t);
-	folio_change_private(folio, (void *)priv);
-	trace_afs_folio_dirty(vnode, tracepoint_string("trunc"), folio);
-	return;
-
-undirty:
-	trace_afs_folio_dirty(vnode, tracepoint_string("undirty"), folio);
-	folio_clear_dirty_for_io(folio);
-full_invalidate:
-	trace_afs_folio_dirty(vnode, tracepoint_string("inval"), folio);
-	folio_detach_private(folio);
-}
-
 /*
  * invalidate part or all of a page
  * - release a page and clean up its private data if offset is 0 (indicat=
ing
  *   the entire page)
  */
 static void afs_invalidate_folio(struct folio *folio, size_t offset,
-			       size_t length)
+				 size_t length)
 {
-	_enter("{%lu},%zu,%zu", folio->index, offset, length);
-
-	BUG_ON(!folio_test_locked(folio));
-
-	if (folio_get_private(folio))
-		afs_invalidate_dirty(folio, offset, length);
+	struct afs_vnode *vnode =3D AFS_FS_I(folio_inode(folio));
 =

+	trace_afs_folio_dirty(vnode, tracepoint_string("inval"), folio);
 	folio_wait_fscache(folio);
-	_leave("");
 }
 =

 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ad8523d0d038..90d66b20ca8c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -890,62 +890,6 @@ static inline void afs_invalidate_cache(struct afs_vn=
ode *vnode, unsigned int fl
 			   i_size_read(&vnode->netfs.inode), flags);
 }
 =

-/*
- * We use folio->private to hold the amount of the folio that we've writt=
en to,
- * splitting the field into two parts.  However, we need to represent a r=
ange
- * 0...FOLIO_SIZE, so we reduce the resolution if the size of the folio
- * exceeds what we can encode.
- */
-#ifdef CONFIG_64BIT
-#define __AFS_FOLIO_PRIV_MASK		0x7fffffffUL
-#define __AFS_FOLIO_PRIV_SHIFT		32
-#define __AFS_FOLIO_PRIV_MMAPPED	0x80000000UL
-#else
-#define __AFS_FOLIO_PRIV_MASK		0x7fffUL
-#define __AFS_FOLIO_PRIV_SHIFT		16
-#define __AFS_FOLIO_PRIV_MMAPPED	0x8000UL
-#endif
-
-static inline unsigned int afs_folio_dirty_resolution(struct folio *folio=
)
-{
-	int shift =3D folio_shift(folio) - (__AFS_FOLIO_PRIV_SHIFT - 1);
-	return (shift > 0) ? shift : 0;
-}
-
-static inline size_t afs_folio_dirty_from(struct folio *folio, unsigned l=
ong priv)
-{
-	unsigned long x =3D priv & __AFS_FOLIO_PRIV_MASK;
-
-	/* The lower bound is inclusive */
-	return x << afs_folio_dirty_resolution(folio);
-}
-
-static inline size_t afs_folio_dirty_to(struct folio *folio, unsigned lon=
g priv)
-{
-	unsigned long x =3D (priv >> __AFS_FOLIO_PRIV_SHIFT) & __AFS_FOLIO_PRIV_=
MASK;
-
-	/* The upper bound is immediately beyond the region */
-	return (x + 1) << afs_folio_dirty_resolution(folio);
-}
-
-static inline unsigned long afs_folio_dirty(struct folio *folio, size_t f=
rom, size_t to)
-{
-	unsigned int res =3D afs_folio_dirty_resolution(folio);
-	from >>=3D res;
-	to =3D (to - 1) >> res;
-	return (to << __AFS_FOLIO_PRIV_SHIFT) | from;
-}
-
-static inline unsigned long afs_folio_dirty_mmapped(unsigned long priv)
-{
-	return priv | __AFS_FOLIO_PRIV_MMAPPED;
-}
-
-static inline bool afs_is_folio_dirty_mmapped(unsigned long priv)
-{
-	return priv & __AFS_FOLIO_PRIV_MMAPPED;
-}
-
 #include <trace/events/afs.h>
 =

 /************************************************************************=
*****/
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 571f3b9a417e..d2f6623c8eab 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -14,11 +14,6 @@
 #include <linux/netfs.h>
 #include "internal.h"
 =

-static int afs_writepages_region(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 loff_t start, loff_t end, loff_t *_next,
-				 bool max_one_loop);
-
 static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, siz=
e_t len,
 			       loff_t i_size, bool caching);
 =

@@ -43,25 +38,6 @@ static void afs_folio_start_fscache(bool caching, struc=
t folio *folio)
 }
 #endif
 =

-/*
- * Flush out a conflicting write.  This may extend the write to the surro=
unding
- * pages if also dirty and contiguous to the conflicting region..
- */
-static int afs_flush_conflicting_write(struct address_space *mapping,
-				       struct folio *folio)
-{
-	struct writeback_control wbc =3D {
-		.sync_mode	=3D WB_SYNC_ALL,
-		.nr_to_write	=3D LONG_MAX,
-		.range_start	=3D folio_pos(folio),
-		.range_end	=3D LLONG_MAX,
-	};
-	loff_t next;
-
-	return afs_writepages_region(mapping, &wbc, folio_pos(folio), LLONG_MAX,
-				     &next, true);
-}
-
 /*
  * prepare to perform part of a write to a page
  */
@@ -71,10 +47,6 @@ int afs_write_begin(struct file *file, struct address_s=
pace *mapping,
 {
 	struct afs_vnode *vnode =3D AFS_FS_I(file_inode(file));
 	struct folio *folio;
-	unsigned long priv;
-	unsigned f, from;
-	unsigned t, to;
-	pgoff_t index;
 	int ret;
 =

 	_enter("{%llx:%llu},%llx,%x",
@@ -88,49 +60,17 @@ int afs_write_begin(struct file *file, struct address_=
space *mapping,
 	if (ret < 0)
 		return ret;
 =

-	index =3D folio_index(folio);
-	from =3D pos - index * PAGE_SIZE;
-	to =3D from + len;
-
 try_again:
-	/* See if this page is already partially written in a way that we can
-	 * merge the new write with.
-	 */
-	if (folio_test_private(folio)) {
-		priv =3D (unsigned long)folio_get_private(folio);
-		f =3D afs_folio_dirty_from(folio, priv);
-		t =3D afs_folio_dirty_to(folio, priv);
-		ASSERTCMP(f, <=3D, t);
-
-		if (folio_test_writeback(folio)) {
-			trace_afs_folio_dirty(vnode, tracepoint_string("alrdy"), folio);
-			folio_unlock(folio);
-			goto wait_for_writeback;
-		}
-		/* If the file is being filled locally, allow inter-write
-		 * spaces to be merged into writes.  If it's not, only write
-		 * back what the user gives us.
-		 */
-		if (!test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags) &&
-		    (to < f || from > t))
-			goto flush_conflicting_write;
+	if (folio_test_writeback(folio)) {
+		trace_afs_folio_dirty(vnode, tracepoint_string("alrdy"), folio);
+		folio_unlock(folio);
+		goto wait_for_writeback;
 	}
 =

 	*_page =3D folio_file_page(folio, pos / PAGE_SIZE);
 	_leave(" =3D 0");
 	return 0;
 =

-	/* The previous write and this write aren't adjacent or overlapping, so
-	 * flush the page out.
-	 */
-flush_conflicting_write:
-	trace_afs_folio_dirty(vnode, tracepoint_string("confl"), folio);
-	folio_unlock(folio);
-
-	ret =3D afs_flush_conflicting_write(mapping, folio);
-	if (ret < 0)
-		goto error;
-
 wait_for_writeback:
 	ret =3D folio_wait_writeback_killable(folio);
 	if (ret < 0)
@@ -156,9 +96,6 @@ int afs_write_end(struct file *file, struct address_spa=
ce *mapping,
 {
 	struct folio *folio =3D page_folio(subpage);
 	struct afs_vnode *vnode =3D AFS_FS_I(file_inode(file));
-	unsigned long priv;
-	unsigned int f, from =3D offset_in_folio(folio, pos);
-	unsigned int t, to =3D from + copied;
 	loff_t i_size, write_end_pos;
 =

 	_enter("{%llx:%llu},{%lx}",
@@ -188,25 +125,10 @@ int afs_write_end(struct file *file, struct address_=
space *mapping,
 		fscache_update_cookie(afs_vnode_cache(vnode), NULL, &write_end_pos);
 	}
 =

-	if (folio_test_private(folio)) {
-		priv =3D (unsigned long)folio_get_private(folio);
-		f =3D afs_folio_dirty_from(folio, priv);
-		t =3D afs_folio_dirty_to(folio, priv);
-		if (from < f)
-			f =3D from;
-		if (to > t)
-			t =3D to;
-		priv =3D afs_folio_dirty(folio, f, t);
-		folio_change_private(folio, (void *)priv);
-		trace_afs_folio_dirty(vnode, tracepoint_string("dirty+"), folio);
-	} else {
-		priv =3D afs_folio_dirty(folio, from, to);
-		folio_attach_private(folio, (void *)priv);
-		trace_afs_folio_dirty(vnode, tracepoint_string("dirty"), folio);
-	}
-
 	if (folio_mark_dirty(folio))
-		_debug("dirtied %lx", folio_index(folio));
+		trace_afs_folio_dirty(vnode, tracepoint_string("dirty"), folio);
+	else
+		trace_afs_folio_dirty(vnode, tracepoint_string("dirty+"), folio);
 =

 out:
 	folio_unlock(folio);
@@ -465,18 +387,16 @@ static void afs_extend_writeback(struct address_spac=
e *mapping,
 				 bool caching,
 				 unsigned int *_len)
 {
-	struct pagevec pvec;
+	struct folio_batch batch;
 	struct folio *folio;
-	unsigned long priv;
-	unsigned int psize, filler =3D 0;
-	unsigned int f, t;
+	size_t psize;
 	loff_t len =3D *_len;
 	pgoff_t index =3D (start + len) / PAGE_SIZE;
 	bool stop =3D true;
 	unsigned int i;
-
 	XA_STATE(xas, &mapping->i_pages, index);
-	pagevec_init(&pvec);
+
+	folio_batch_init(&batch);
 =

 	do {
 		/* Firstly, we gather up a batch of contiguous dirty pages
@@ -493,7 +413,6 @@ static void afs_extend_writeback(struct address_space =
*mapping,
 				break;
 			if (folio_index(folio) !=3D index)
 				break;
-
 			if (!folio_try_get_rcu(folio)) {
 				xas_reset(&xas);
 				continue;
@@ -518,24 +437,13 @@ static void afs_extend_writeback(struct address_spac=
e *mapping,
 			}
 =

 			psize =3D folio_size(folio);
-			priv =3D (unsigned long)folio_get_private(folio);
-			f =3D afs_folio_dirty_from(folio, priv);
-			t =3D afs_folio_dirty_to(folio, priv);
-			if (f !=3D 0 && !new_content) {
-				folio_unlock(folio);
-				folio_put(folio);
-				break;
-			}
-
-			len +=3D filler + t;
-			filler =3D psize - t;
+			len +=3D psize;
+			stop =3D false;
 			if (len >=3D max_len || *_count <=3D 0)
 				stop =3D true;
-			else if (t =3D=3D psize || new_content)
-				stop =3D false;
 =

 			index +=3D folio_nr_pages(folio);
-			if (!pagevec_add(&pvec, &folio->page))
+			if (!folio_batch_add(&batch, folio))
 				break;
 			if (stop)
 				break;
@@ -548,11 +456,11 @@ static void afs_extend_writeback(struct address_spac=
e *mapping,
 		/* Now, if we obtained any pages, we can shift them to being
 		 * writable and mark them for caching.
 		 */
-		if (!pagevec_count(&pvec))
+		if (!folio_batch_count(&batch))
 			break;
 =

-		for (i =3D 0; i < pagevec_count(&pvec); i++) {
-			folio =3D page_folio(pvec.pages[i]);
+		for (i =3D 0; i < folio_batch_count(&batch); i++) {
+			folio =3D batch.folios[i];
 			trace_afs_folio_dirty(vnode, tracepoint_string("store+"), folio);
 =

 			if (!folio_clear_dirty_for_io(folio))
@@ -565,7 +473,7 @@ static void afs_extend_writeback(struct address_space =
*mapping,
 			folio_unlock(folio);
 		}
 =

-		pagevec_release(&pvec);
+		folio_batch_release(&batch);
 		cond_resched();
 	} while (!stop);
 =

@@ -583,8 +491,7 @@ static ssize_t afs_write_back_from_locked_folio(struct=
 address_space *mapping,
 {
 	struct afs_vnode *vnode =3D AFS_FS_I(mapping->host);
 	struct iov_iter iter;
-	unsigned long priv;
-	unsigned int offset, to, len, max_len;
+	unsigned int len, max_len;
 	loff_t i_size =3D i_size_read(&vnode->netfs.inode);
 	bool new_content =3D test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	bool caching =3D fscache_cookie_enabled(afs_vnode_cache(vnode));
@@ -599,18 +506,14 @@ static ssize_t afs_write_back_from_locked_folio(stru=
ct address_space *mapping,
 =

 	count -=3D folio_nr_pages(folio);
 =

-	/* Find all consecutive lockable dirty pages that have contiguous
-	 * written regions, stopping when we find a page that is not
-	 * immediately lockable, is not dirty or is missing, or we reach the
-	 * end of the range.
+	/* Find all consecutive lockable dirty pages, stopping when we find a
+	 * page that is not immediately lockable, is not dirty or is missing,
+	 * or we reach the end of the range.
 	 */
-	priv =3D (unsigned long)folio_get_private(folio);
-	offset =3D afs_folio_dirty_from(folio, priv);
-	to =3D afs_folio_dirty_to(folio, priv);
 	trace_afs_folio_dirty(vnode, tracepoint_string("store"), folio);
 =

-	len =3D to - offset;
-	start +=3D offset;
+	len =3D folio_size(folio);
+	start =3D folio_pos(folio);
 	if (start < i_size) {
 		/* Trim the write to the EOF; the extra data is ignored.  Also
 		 * put an upper limit on the size of a single storedata op.
@@ -619,8 +522,7 @@ static ssize_t afs_write_back_from_locked_folio(struct=
 address_space *mapping,
 		max_len =3D min_t(unsigned long long, max_len, end - start + 1);
 		max_len =3D min_t(unsigned long long, max_len, i_size - start);
 =

-		if (len < max_len &&
-		    (to =3D=3D folio_size(folio) || new_content))
+		if (len < max_len)
 			afs_extend_writeback(mapping, vnode, &count,
 					     start, max_len, new_content,
 					     caching, &len);
@@ -909,7 +811,6 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode =3D file_inode(file);
 	struct afs_vnode *vnode =3D AFS_FS_I(inode);
 	struct afs_file *af =3D file->private_data;
-	unsigned long priv;
 	vm_fault_t ret =3D VM_FAULT_RETRY;
 =

 	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode, folio_in=
dex(folio));
@@ -942,15 +843,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 		goto out;
 	}
 =

-	priv =3D afs_folio_dirty(folio, 0, folio_size(folio));
-	priv =3D afs_folio_dirty_mmapped(priv);
-	if (folio_test_private(folio)) {
-		folio_change_private(folio, (void *)priv);
-		trace_afs_folio_dirty(vnode, tracepoint_string("mkwrite+"), folio);
-	} else {
-		folio_attach_private(folio, (void *)priv);
-		trace_afs_folio_dirty(vnode, tracepoint_string("mkwrite"), folio);
-	}
+	trace_afs_folio_dirty(vnode, tracepoint_string("mkwrite"), folio);
 	file_update_time(file);
 =

 	ret =3D VM_FAULT_LOCKED;
@@ -992,33 +885,33 @@ void afs_prune_wb_keys(struct afs_vnode *vnode)
  */
 int afs_launder_folio(struct folio *folio)
 {
-	struct afs_vnode *vnode =3D AFS_FS_I(folio_inode(folio));
+	struct inode *inode =3D folio_inode(folio);
+	struct afs_vnode *vnode =3D AFS_FS_I(inode);
 	struct iov_iter iter;
 	struct bio_vec bv;
-	unsigned long priv;
-	unsigned int f, t;
 	int ret =3D 0;
 =

 	_enter("{%lx}", folio->index);
 =

-	priv =3D (unsigned long)folio_get_private(folio);
 	if (folio_clear_dirty_for_io(folio)) {
-		f =3D 0;
-		t =3D folio_size(folio);
-		if (folio_test_private(folio)) {
-			f =3D afs_folio_dirty_from(folio, priv);
-			t =3D afs_folio_dirty_to(folio, priv);
-		}
+		unsigned long long i_size =3D i_size_read(inode);
+		unsigned long long pos =3D folio_pos(folio);
+		size_t size =3D folio_size(folio);
 =

-		bvec_set_folio(&bv, folio, t - f, f);
-		iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, bv.bv_len);
+		if (pos >=3D i_size)
+			goto out;
+		if (i_size - pos < size)
+			size =3D i_size - pos;
+		=

+		bvec_set_folio(&bv, folio, size, 0);
+		iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, size);
 =

 		trace_afs_folio_dirty(vnode, tracepoint_string("launder"), folio);
-		ret =3D afs_store_data(vnode, &iter, folio_pos(folio) + f, true);
+		ret =3D afs_store_data(vnode, &iter, pos, true);
 	}
 =

+out:
 	trace_afs_folio_dirty(vnode, tracepoint_string("laundered"), folio);
-	folio_detach_private(folio);
 	folio_wait_fscache(folio);
 	return ret;
 }
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 4d4a2d82636d..3d304d4a54d6 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2674,7 +2674,6 @@ static void cifs_extend_writeback(struct address_spa=
ce *mapping,
 				break;
 			}
 =

-			max_pages -=3D nr_pages;
 			psize =3D folio_size(folio);
 			len +=3D psize;
 			stop =3D false;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index e9d412d19dbb..4540aa801edd 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1025,26 +1025,16 @@ TRACE_EVENT(afs_folio_dirty,
 		    __field(struct afs_vnode *,		vnode		)
 		    __field(const char *,		where		)
 		    __field(pgoff_t,			index		)
-		    __field(unsigned long,		from		)
-		    __field(unsigned long,		to		)
 			     ),
 =

 	    TP_fast_assign(
-		    unsigned long priv =3D (unsigned long)folio_get_private(folio);
 		    __entry->vnode =3D vnode;
 		    __entry->where =3D where;
 		    __entry->index =3D folio_index(folio);
-		    __entry->from  =3D afs_folio_dirty_from(folio, priv);
-		    __entry->to    =3D afs_folio_dirty_to(folio, priv);
-		    __entry->to   |=3D (afs_is_folio_dirty_mmapped(priv) ?
-				      (1UL << (BITS_PER_LONG - 1)) : 0);
 			   ),
 =

-	    TP_printk("vn=3D%p %lx %s %lx-%lx%s",
-		      __entry->vnode, __entry->index, __entry->where,
-		      __entry->from,
-		      __entry->to & ~(1UL << (BITS_PER_LONG - 1)),
-		      __entry->to & (1UL << (BITS_PER_LONG - 1)) ? " M" : "")
+	    TP_printk("vn=3D%p %lx %s",
+		      __entry->vnode, __entry->index, __entry->where)
 	    );
 =

 TRACE_EVENT(afs_call_state,

