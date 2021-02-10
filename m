Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0A2316B66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 17:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhBJQgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 11:36:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232870AbhBJQeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612974794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PklF3nSZ/EJMTni4by1KfsYciMRMpxQyU+kaNTIdR3w=;
        b=BaHhRjZ7t0kQ156fLtz0nsuKbZRHOzM4FgPSMAk3q0s6jzRR22OPFvtMdxBEu0fL4NuAGV
        xQraRccTf8kb3K4T/hLgovU7fdzJ8X686efod+tGixjg0cc0mBO+nAoCEfRF3es1jd9Xv7
        4+yh5IzPApkQYkIVtABxpU0Uaavyvec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-GYcYjc_NNYOV-MOwVxC_Hg-1; Wed, 10 Feb 2021 11:33:12 -0500
X-MC-Unique: GYcYjc_NNYOV-MOwVxC_Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 753EC801962;
        Wed, 10 Feb 2021 16:33:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05DA760622;
        Wed, 10 Feb 2021 16:33:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1330473.1612974547@warthog.procyon.org.uk>
References: <1330473.1612974547@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com> <591237.1612886997@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1330750.1612974783.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Feb 2021 16:33:03 +0000
Message-ID: <1330751.1612974783@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> =

> > The PG_fscache bit waiting functions are completely crazy. The comment
> > about "this will wake up others" is actively wrong, and the waiting
> > function looks insane, because you're mixing the two names for
> > "fscache" which makes the code look totally incomprehensible. Why
> > would we wait for PF_fscache, when PG_private_2 was set? Yes, I know
> > why, but the code looks entirely nonsensical.
> =

> How about the attached change to make it more coherent and fix the doc
> comment?

Then I could follow it up with this patch here, moving towards dropping th=
e
PG_fscache alias for the new API.

David
---
commit b415fafb07166732933242e938626fc6cdbdbc5b
Author: David Howells <dhowells@redhat.com>
Date:   Wed Feb 10 11:22:59 2021 +0000

    netfs: Move towards dropping the PG_fscache alias for PG_private_2
    =

    Move towards dropping the PG_fscache alias for PG_private_2 with the n=
ew
    fscache I/O API and netfs helper lib (this does not alter the old API)=
.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8f28d4f4cfd7..bb8c6d501292 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -438,7 +438,7 @@ static void afs_invalidatepage(struct page *page, unsi=
gned int offset,
 	if (PagePrivate(page))
 		afs_invalidate_dirty(page, offset, length);
 =

-	wait_on_page_fscache(page);
+	wait_on_page_private_2(page);
 	_leave("");
 }
 =

@@ -457,10 +457,10 @@ static int afs_releasepage(struct page *page, gfp_t =
gfp_flags)
 	/* deny if page is being written to the cache and the caller hasn't
 	 * elected to wait */
 #ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page)) {
+	if (PagePrivate2(page)) {
 		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
 			return false;
-		wait_on_page_fscache(page);
+		wait_on_page_private_2(page);
 	}
 #endif
 =

diff --git a/fs/afs/write.c b/fs/afs/write.c
index e672833c99bc..9c554981f53b 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -118,7 +118,7 @@ int afs_write_begin(struct file *file, struct address_=
space *mapping,
 	}
 =

 #ifdef CONFIG_AFS_FSCACHE
-	wait_on_page_fscache(page);
+	wait_on_page_private_2(page);
 #endif
 =

 	index =3D page->index;
@@ -929,8 +929,8 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
 #ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page) &&
-	    wait_on_page_bit_killable(page, PG_fscache) < 0)
+	if (PagePrivate2(page) &&
+	    wait_on_page_bit_killable(page, PG_private_2) < 0)
 		return VM_FAULT_RETRY;
 #endif
 =

@@ -1026,6 +1026,6 @@ int afs_launder_page(struct page *page)
 =

 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);
 	detach_page_private(page);
-	wait_on_page_fscache(page);
+	wait_on_page_private_2(page);
 	return ret;
 }
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0dd64d31eff6..fd2498567b49 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -147,7 +147,7 @@ static void ceph_invalidatepage(struct page *page, uns=
igned int offset,
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc =3D page_snap_context(page);
 =

-	wait_on_page_fscache(page);
+	wait_on_page_private_2(page);
 =

 	inode =3D page->mapping->host;
 	ci =3D ceph_inode(inode);
@@ -176,10 +176,10 @@ static int ceph_releasepage(struct page *page, gfp_t=
 gfp_flags)
 	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
 	     page, page->index, PageDirty(page) ? "" : "not ");
 =

-	if (PageFsCache(page)) {
+	if (PagePrivate2(page)) {
 		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
 			return 0;
-		wait_on_page_fscache(page);
+		wait_on_page_private_2(page);
 	}
 	return !PagePrivate(page);
 }
@@ -1258,7 +1258,7 @@ static int ceph_write_begin(struct file *file, struc=
t address_space *mapping,
 			      &ceph_netfs_write_begin_ops, NULL);
 out:
 	if (r =3D=3D 0)
-		wait_on_page_fscache(page);
+		wait_on_page_private_2(page);
 	if (r < 0) {
 		if (page)
 			put_page(page);
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 156941e0de61..9018224693e9 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -223,7 +223,7 @@ static void netfs_rreq_completed(struct netfs_read_req=
uest *rreq)
 =

 /*
  * Deal with the completion of writing the data to the cache.  We have to=
 clear
- * the PG_fscache bits on the pages involved and release the caller's ref=
.
+ * the PG_private_2 bits on the pages involved and release the caller's r=
ef.
  *
  * May be called in softirq mode and we inherit a ref from the caller.
  */
@@ -246,7 +246,7 @@ static void netfs_rreq_unmark_after_write(struct netfs=
_read_request *rreq)
 			if (have_unlocked && page->index <=3D unlocked)
 				continue;
 			unlocked =3D page->index;
-			unlock_page_fscache(page);
+			unlock_page_private_2(page);
 			have_unlocked =3D true;
 		}
 	}
@@ -357,7 +357,7 @@ static void netfs_rreq_write_to_cache(struct netfs_rea=
d_request *rreq)
 }
 =

 /*
- * Unlock the pages in a read operation.  We need to set PG_fscache on an=
y
+ * Unlock the pages in a read operation.  We need to set PG_private_2 on =
any
  * pages we're going to write back before we unlock them.
  */
 static void netfs_rreq_unlock(struct netfs_read_request *rreq)
@@ -404,7 +404,7 @@ static void netfs_rreq_unlock(struct netfs_read_reques=
t *rreq)
 				break;
 			}
 			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
-				SetPageFsCache(page);
+				SetPagePrivate2(page);
 			pg_failed |=3D subreq_failed;
 			if (pgend < iopos + subreq->len)
 				break;
@@ -1142,7 +1142,7 @@ int netfs_write_begin(struct file *file, struct addr=
ess_space *mapping,
 		goto error;
 =

 have_page:
-	wait_on_page_fscache(page);
+	wait_on_page_private_2(page);
 have_page_no_wait:
 	if (netfs_priv)
 		ops->cleanup(netfs_priv, mapping);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 3f177faa0ac2..ccf533288291 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -29,6 +29,17 @@
 #define fscache_cookie_valid(cookie) (0)
 #endif
 =

+#ifndef FSCACHE_USE_NEW_IO_API
+/*
+ * Overload PG_private_2 to give us PG_fscache - this is used to indicate=
 that
+ * a page is currently backed by a local disk cache
+ */
+#define PageFsCache(page)		PagePrivate2((page))
+#define SetPageFsCache(page)		SetPagePrivate2((page))
+#define ClearPageFsCache(page)		ClearPagePrivate2((page))
+#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
+#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
+#endif
 =

 /* pattern used to fill dead space in an index entry */
 #define FSCACHE_INDEX_DEADFILL_PATTERN 0x79
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index d4cb6e6f704c..be03c3b6f0dc 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -15,18 +15,6 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 =

-/*
- * Overload PG_private_2 to give us PG_fscache - this is used to indicate=
 that
- * a page is currently backed by a local disk cache
- */
-#define PageFsCache(page)		PagePrivate2((page))
-#define SetPageFsCache(page)		SetPagePrivate2((page))
-#define ClearPageFsCache(page)		ClearPagePrivate2((page))
-#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
-#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
-#define wait_on_page_fscache(page)	wait_on_page_private_2((page))
-#define unlock_page_fscache(page)	unlock_page_private_2((page))
-
 enum netfs_read_source {
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
diff --git a/mm/filemap.c b/mm/filemap.c
index 7d321152d579..e7b2a1e2c40b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3604,7 +3604,7 @@ EXPORT_SYMBOL(generic_file_write_iter);
  * The address_space is to try to release any data against the page
  * (presumably at page->private).
  *
- * This may also be called if PG_fscache is set on a page, indicating tha=
t the
+ * This may also be called if PG_private_2 is set on a page, indicating t=
hat the
  * page is known to the local caching routines.
  *
  * The @gfp_mask argument specifies whether I/O may be performed to relea=
se
diff --git a/mm/readahead.c b/mm/readahead.c
index 4446dada0bc2..01209a46e834 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -40,7 +40,7 @@ EXPORT_SYMBOL_GPL(file_ra_state_init);
 =

 /*
  * see if a page needs releasing upon read_cache_pages() failure
- * - the caller of read_cache_pages() may have set PG_private or PG_fscac=
he
+ * - the caller of read_cache_pages() may have set PG_private or PG_priva=
te_2
  *   before calling, such as the NFS fs marking pages that are cached loc=
ally
  *   on disk, thus we need to give the fs a chance to clean up in the eve=
nt of
  *   an error

