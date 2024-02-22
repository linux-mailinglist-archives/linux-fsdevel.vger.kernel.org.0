Return-Path: <linux-fsdevel+bounces-12446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4E085F6A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C010128309A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1C405E6;
	Thu, 22 Feb 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC7jGYPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF103FE47
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600839; cv=none; b=CJdHeqBkFdmCaRSNyezXMMzZikfr54+TpzmJihA2yjEOLGhYXv/ldOxA9SNocSGarlYsd+/ZQLv3wXI5jSyXaTRx0VZyRqCzK0MM89t4bO67aHZ3kP8DBYDkTve/pebp3k7lfKv7WB6JeVyeNyukTEvFAXPoCPb4jectwZsxnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600839; c=relaxed/simple;
	bh=uOxzPBYt/P48bNbB+8JM7JJxg6nLL3TYmXadjeE9yqo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=K97BIToFql0aJ+xUHxZB2k1P2FJgyE875XRCWLkPv6vs/4YODDkoIaK/hzN8mG7neljUtZ3sni8EeRqqwNEHVDuecph2kr6BBwgKTPznE8Gp4NFBIlhzmx6NkDjidZkGUDaH42ax1euVSgkKjMmoT9DHYHCoiW5gbLayiq65fcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC7jGYPj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708600836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LPoBMnsb3gS4Rs9L9OAxvvlN8RkZUtTPsWd7Jd+IW8k=;
	b=AC7jGYPj4hBvLzhBU68S0NvugArPZE/ItbHXzK1aHu/T9y9j3lfOvZxIt7zlm3pW3q6iE6
	Og8qUzjMuQKRsdOw4TIcoWKzL0nxeEWg2zZqAcZXHX1A8aaB68oNICwz0LcmicuU8lOAbR
	1BMOq9jhrX83lcgOrlbAvrULaEfZwtM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-cin_vBNFPfKUDo38Szi26A-1; Thu,
 22 Feb 2024 06:20:30 -0500
X-MC-Unique: cin_vBNFPfKUDo38Szi26A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 489D2282476C;
	Thu, 22 Feb 2024 11:20:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF17E492BD7;
	Thu, 22 Feb 2024 11:20:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Ronnie Sahlberg <ronniesahlberg@gmail.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org,
    samba-technical@lists.samba.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cifs: Fix writeback data corruption
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <652316.1708600826.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Feb 2024 11:20:26 +0000
Message-ID: <652317.1708600826@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

cifs writeback doesn't correctly handle the case where
cifs_extend_writeback() hits a point where it is considering an additional
folio, but this would overrun the wsize - at which point it drops out of
the xarray scanning loop and calls xas_pause().  The problem is that
xas_pause() advances the loop counter - thereby skipping that page.

What needs to happen is for xas_reset() to be called any time we decide we
don't want to process the page we're looking at, but rather send the
request we are building and start a new one.

Fix this by copying and adapting the netfslib writepages code as a
temporary measure, with cifs writeback intending to be offloaded to
netfslib in the near future.

This also fixes the issue with the use of filemap_get_folios_tag() causing
retry of a bunch of pages which the extender already dealt with.

This can be tested by creating, say, a 64K file somewhere not on cifs
(otherwise copy-offload may get underfoot), mounting a cifs share with a
wsize of 64000, copying the file to it and then comparing the original fil=
e
and the copy:

        dd if=3D/dev/urandom of=3D/tmp/64K bs=3D64k count=3D1
        mount //192.168.6.1/test /mnt -o user=3D...,pass=3D...,wsize=3D640=
00
        cp /tmp/64K /mnt/64K
        cmp /tmp/64K /mnt/64K

Without the fix, the cmp fails at position 64000 (or shortly thereafter).

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather=
 than a page list")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: samba-technical@lists.samba.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/file.c |  284 ++++++++++++++++++++++++++++-----------------=
------
 1 file changed, 158 insertions(+), 126 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f391c9b803d8..671ce6ebd203 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2624,20 +2624,20 @@ static int cifs_partialpagewrite(struct page *page=
, unsigned from, unsigned to)
  * dirty pages if possible, but don't sleep while doing so.
  */
 static void cifs_extend_writeback(struct address_space *mapping,
+				  struct xa_state *xas,
 				  long *_count,
 				  loff_t start,
 				  int max_pages,
-				  size_t max_len,
-				  unsigned int *_len)
+				  loff_t max_len,
+				  size_t *_len)
 {
 	struct folio_batch batch;
 	struct folio *folio;
-	unsigned int psize, nr_pages;
-	size_t len =3D *_len;
-	pgoff_t index =3D (start + len) / PAGE_SIZE;
+	unsigned int nr_pages;
+	pgoff_t index =3D (start + *_len) / PAGE_SIZE;
+	size_t len;
 	bool stop =3D true;
 	unsigned int i;
-	XA_STATE(xas, &mapping->i_pages, index);
 =

 	folio_batch_init(&batch);
 =

@@ -2648,54 +2648,64 @@ static void cifs_extend_writeback(struct address_s=
pace *mapping,
 		 */
 		rcu_read_lock();
 =

-		xas_for_each(&xas, folio, ULONG_MAX) {
+		xas_for_each(xas, folio, ULONG_MAX) {
 			stop =3D true;
-			if (xas_retry(&xas, folio))
+			if (xas_retry(xas, folio))
 				continue;
 			if (xa_is_value(folio))
 				break;
-			if (folio->index !=3D index)
+			if (folio->index !=3D index) {
+				xas_reset(xas);
 				break;
+			}
+
 			if (!folio_try_get_rcu(folio)) {
-				xas_reset(&xas);
+				xas_reset(xas);
 				continue;
 			}
 			nr_pages =3D folio_nr_pages(folio);
-			if (nr_pages > max_pages)
+			if (nr_pages > max_pages) {
+				xas_reset(xas);
 				break;
+			}
 =

 			/* Has the page moved or been split? */
-			if (unlikely(folio !=3D xas_reload(&xas))) {
+			if (unlikely(folio !=3D xas_reload(xas))) {
 				folio_put(folio);
+				xas_reset(xas);
 				break;
 			}
 =

 			if (!folio_trylock(folio)) {
 				folio_put(folio);
+				xas_reset(xas);
 				break;
 			}
-			if (!folio_test_dirty(folio) || folio_test_writeback(folio)) {
+			if (!folio_test_dirty(folio) ||
+			    folio_test_writeback(folio)) {
 				folio_unlock(folio);
 				folio_put(folio);
+				xas_reset(xas);
 				break;
 			}
 =

 			max_pages -=3D nr_pages;
-			psize =3D folio_size(folio);
-			len +=3D psize;
+			len =3D folio_size(folio);
 			stop =3D false;
-			if (max_pages <=3D 0 || len >=3D max_len || *_count <=3D 0)
-				stop =3D true;
 =

 			index +=3D nr_pages;
+			*_count -=3D nr_pages;
+			*_len +=3D len;
+			if (max_pages <=3D 0 || *_len >=3D max_len || *_count <=3D 0)
+				stop =3D true;
+
 			if (!folio_batch_add(&batch, folio))
 				break;
 			if (stop)
 				break;
 		}
 =

-		if (!stop)
-			xas_pause(&xas);
+		xas_pause(xas);
 		rcu_read_unlock();
 =

 		/* Now, if we obtained any pages, we can shift them to being
@@ -2712,16 +2722,12 @@ static void cifs_extend_writeback(struct address_s=
pace *mapping,
 			if (!folio_clear_dirty_for_io(folio))
 				WARN_ON(1);
 			folio_start_writeback(folio);
-
-			*_count -=3D folio_nr_pages(folio);
 			folio_unlock(folio);
 		}
 =

 		folio_batch_release(&batch);
 		cond_resched();
 	} while (!stop);
-
-	*_len =3D len;
 }
 =

 /*
@@ -2729,8 +2735,10 @@ static void cifs_extend_writeback(struct address_sp=
ace *mapping,
  */
 static ssize_t cifs_write_back_from_locked_folio(struct address_space *ma=
pping,
 						 struct writeback_control *wbc,
+						 struct xa_state *xas,
 						 struct folio *folio,
-						 loff_t start, loff_t end)
+						 unsigned long long start,
+						 unsigned long long end)
 {
 	struct inode *inode =3D mapping->host;
 	struct TCP_Server_Info *server;
@@ -2739,17 +2747,18 @@ static ssize_t cifs_write_back_from_locked_folio(s=
truct address_space *mapping,
 	struct cifs_credits credits_on_stack;
 	struct cifs_credits *credits =3D &credits_on_stack;
 	struct cifsFileInfo *cfile =3D NULL;
-	unsigned int xid, wsize, len;
-	loff_t i_size =3D i_size_read(inode);
-	size_t max_len;
+	unsigned long long i_size =3D i_size_read(inode), max_len;
+	unsigned int xid, wsize;
+	size_t len;
 	long count =3D wbc->nr_to_write;
 	int rc;
 =

 	/* The folio should be locked, dirty and not undergoing writeback. */
+	if (!folio_clear_dirty_for_io(folio))
+		BUG();
 	folio_start_writeback(folio);
 =

 	count -=3D folio_nr_pages(folio);
-	len =3D folio_size(folio);
 =

 	xid =3D get_xid();
 	server =3D cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
@@ -2779,10 +2788,12 @@ static ssize_t cifs_write_back_from_locked_folio(s=
truct address_space *mapping,
 	wdata->server =3D server;
 	cfile =3D NULL;
 =

-	/* Find all consecutive lockable dirty pages, stopping when we find a
-	 * page that is not immediately lockable, is not dirty or is missing,
-	 * or we reach the end of the range.
+	/* Find all consecutive lockable dirty pages that have contiguous
+	 * written regions, stopping when we find a page that is not
+	 * immediately lockable, is not dirty or is missing, or we reach the
+	 * end of the range.
 	 */
+	len =3D folio_size(folio);
 	if (start < i_size) {
 		/* Trim the write to the EOF; the extra data is ignored.  Also
 		 * put an upper limit on the size of a single storedata op.
@@ -2801,19 +2812,18 @@ static ssize_t cifs_write_back_from_locked_folio(s=
truct address_space *mapping,
 			max_pages -=3D folio_nr_pages(folio);
 =

 			if (max_pages > 0)
-				cifs_extend_writeback(mapping, &count, start,
+				cifs_extend_writeback(mapping, xas, &count, start,
 						      max_pages, max_len, &len);
 		}
-		len =3D min_t(loff_t, len, max_len);
 	}
-
-	wdata->bytes =3D len;
+	len =3D min_t(unsigned long long, len, i_size - start);
 =

 	/* We now have a contiguous set of dirty pages, each with writeback
 	 * set; the first page is still locked at this point, but all the rest
 	 * have been unlocked.
 	 */
 	folio_unlock(folio);
+	wdata->bytes =3D len;
 =

 	if (start < i_size) {
 		iov_iter_xarray(&wdata->iter, ITER_SOURCE, &mapping->i_pages,
@@ -2864,102 +2874,118 @@ static ssize_t cifs_write_back_from_locked_folio=
(struct address_space *mapping,
 /*
  * write a region of pages back to the server
  */
-static int cifs_writepages_region(struct address_space *mapping,
-				  struct writeback_control *wbc,
-				  loff_t start, loff_t end, loff_t *_next)
+static ssize_t cifs_writepages_begin(struct address_space *mapping,
+				     struct writeback_control *wbc,
+				     struct xa_state *xas,
+				     unsigned long long *_start,
+				     unsigned long long end)
 {
-	struct folio_batch fbatch;
+	struct folio *folio;
+	unsigned long long start =3D *_start;
+	ssize_t ret;
 	int skips =3D 0;
 =

-	folio_batch_init(&fbatch);
-	do {
-		int nr;
-		pgoff_t index =3D start / PAGE_SIZE;
+search_again:
+	/* Find the first dirty page. */
+	rcu_read_lock();
 =

-		nr =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					    PAGECACHE_TAG_DIRTY, &fbatch);
-		if (!nr)
+	for (;;) {
+		folio =3D xas_find_marked(xas, end / PAGE_SIZE, PAGECACHE_TAG_DIRTY);
+		if (xas_retry(xas, folio) || xa_is_value(folio))
+			continue;
+		if (!folio)
 			break;
 =

-		for (int i =3D 0; i < nr; i++) {
-			ssize_t ret;
-			struct folio *folio =3D fbatch.folios[i];
+		if (!folio_try_get_rcu(folio)) {
+			xas_reset(xas);
+			continue;
+		}
 =

-redo_folio:
-			start =3D folio_pos(folio); /* May regress with THPs */
+		if (unlikely(folio !=3D xas_reload(xas))) {
+			folio_put(folio);
+			xas_reset(xas);
+			continue;
+		}
 =

-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-				ret =3D folio_lock_killable(folio);
-				if (ret < 0)
-					goto write_error;
-			} else {
-				if (!folio_trylock(folio))
-					goto skip_write;
-			}
+		xas_pause(xas);
+		break;
+	}
+	rcu_read_unlock();
+	if (!folio)
+		return 0;
 =

-			if (folio->mapping !=3D mapping ||
-			    !folio_test_dirty(folio)) {
-				start +=3D folio_size(folio);
-				folio_unlock(folio);
-				continue;
-			}
+	start =3D folio_pos(folio); /* May regress with THPs */
 =

-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode =3D=3D WB_SYNC_NONE)
-					goto skip_write;
+	/* At this point we hold neither the i_pages lock nor the page lock:
+	 * the page may be truncated or invalidated (changing page->mapping to
+	 * NULL), or even swizzled back from swapper_space to tmpfs file
+	 * mapping
+	 */
+lock_again:
+	if (wbc->sync_mode !=3D WB_SYNC_NONE) {
+		ret =3D folio_lock_killable(folio);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (!folio_trylock(folio))
+			goto search_again;
+	}
 =

-				folio_wait_writeback(folio);
+	if (folio->mapping !=3D mapping ||
+	    !folio_test_dirty(folio)) {
+		start +=3D folio_size(folio);
+		folio_unlock(folio);
+		goto search_again;
+	}
+
+	if (folio_test_writeback(folio) ||
+	    folio_test_fscache(folio)) {
+		folio_unlock(folio);
+		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
+			folio_wait_writeback(folio);
 #ifdef CONFIG_CIFS_FSCACHE
-				folio_wait_fscache(folio);
+			folio_wait_fscache(folio);
 #endif
-				goto redo_folio;
-			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				/* We hold the page lock - it should've been dirty. */
-				WARN_ON(1);
-
-			ret =3D cifs_write_back_from_locked_folio(mapping, wbc, folio, start, =
end);
-			if (ret < 0)
-				goto write_error;
-
-			start +=3D ret;
-			continue;
-
-write_error:
-			folio_batch_release(&fbatch);
-			*_next =3D start;
-			return ret;
+			goto lock_again;
+		}
 =

-skip_write:
-			/*
-			 * Too many skipped writes, or need to reschedule?
-			 * Treat it as a write error without an error code.
-			 */
+		start +=3D folio_size(folio);
+		if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
 			if (skips >=3D 5 || need_resched()) {
 				ret =3D 0;
-				goto write_error;
+				goto out;
 			}
-
-			/* Otherwise, just skip that folio and go on to the next */
 			skips++;
-			start +=3D folio_size(folio);
-			continue;
 		}
+		goto search_again;
+	}
 =

-		folio_batch_release(&fbatch);		=

-		cond_resched();
-	} while (wbc->nr_to_write > 0);
+	ret =3D cifs_write_back_from_locked_folio(mapping, wbc, xas, folio, star=
t, end);
+out:
+	if (ret > 0)
+		*_start =3D start + ret;
+	return ret;
+}
 =

-	*_next =3D start;
-	return 0;
+/*
+ * Write a region of pages back to the server
+ */
+static int cifs_writepages_region(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  unsigned long long *_start,
+				  unsigned long long end)
+{
+	ssize_t ret;
+
+	XA_STATE(xas, &mapping->i_pages, *_start / PAGE_SIZE);
+
+	do {
+		ret =3D cifs_writepages_begin(mapping, wbc, &xas, _start, end);
+		if (ret > 0 && wbc->nr_to_write > 0)
+			cond_resched();
+	} while (ret > 0 && wbc->nr_to_write > 0);
+
+	return ret > 0 ? 0 : ret;
 }
 =

 /*
@@ -2968,7 +2994,7 @@ static int cifs_writepages_region(struct address_spa=
ce *mapping,
 static int cifs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
-	loff_t start, next;
+	loff_t start, end;
 	int ret;
 =

 	/* We have to be careful as we can end up racing with setattr()
@@ -2976,28 +3002,34 @@ static int cifs_writepages(struct address_space *m=
apping,
 	 * to prevent it.
 	 */
 =

-	if (wbc->range_cyclic) {
+	if (wbc->range_cyclic && mapping->writeback_index) {
 		start =3D mapping->writeback_index * PAGE_SIZE;
-		ret =3D cifs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
-		if (ret =3D=3D 0) {
-			mapping->writeback_index =3D next / PAGE_SIZE;
-			if (start > 0 && wbc->nr_to_write > 0) {
-				ret =3D cifs_writepages_region(mapping, wbc, 0,
-							     start, &next);
-				if (ret =3D=3D 0)
-					mapping->writeback_index =3D
-						next / PAGE_SIZE;
-			}
+		ret =3D cifs_writepages_region(mapping, wbc, &start, LLONG_MAX);
+		if (ret < 0)
+			goto out;
+
+		if (wbc->nr_to_write <=3D 0) {
+			mapping->writeback_index =3D start / PAGE_SIZE;
+			goto out;
 		}
+
+		start =3D 0;
+		end =3D mapping->writeback_index * PAGE_SIZE;
+		mapping->writeback_index =3D 0;
+		ret =3D cifs_writepages_region(mapping, wbc, &start, end);
+		if (ret =3D=3D 0)
+			mapping->writeback_index =3D start / PAGE_SIZE;
 	} else if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LLONG_MAX)=
 {
-		ret =3D cifs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
+		start =3D 0;
+		ret =3D cifs_writepages_region(mapping, wbc, &start, LLONG_MAX);
 		if (wbc->nr_to_write > 0 && ret =3D=3D 0)
-			mapping->writeback_index =3D next / PAGE_SIZE;
+			mapping->writeback_index =3D start / PAGE_SIZE;
 	} else {
-		ret =3D cifs_writepages_region(mapping, wbc,
-					     wbc->range_start, wbc->range_end, &next);
+		start =3D wbc->range_start;
+		ret =3D cifs_writepages_region(mapping, wbc, &start, wbc->range_end);
 	}
 =

+out:
 	return ret;
 }
 =


