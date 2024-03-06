Return-Path: <linux-fsdevel+bounces-13831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50428742E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 23:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BC3285715
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91AC1CD20;
	Wed,  6 Mar 2024 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcFwOd9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A451CAB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764790; cv=none; b=jjvpr3r1ibge1fF/7ofKFOWcTa3hVcvLMUuElidp05hV1GzG6K2Lq8B7XBEQDcPIj+BDluGDsT0Mfc76PxzPVrBktM4Mi7IYrYCgm6Kc8bOi1mefvFU0o4Qp3ulnwYleoFTcXQsRBMjYmVzsRV3GipeQWH4jft15qwNVwjEBFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764790; c=relaxed/simple;
	bh=qufHCtFusJJJxZd4PbPONLjM4Ikhqt19eKZn1UE7gb8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=pS2C1DcJFc39rNeZ2p2fhg10JOYTxhnEcsy59KcQBjbj9vNh8xUuTzoA/mvUZM0tqjsi89QPTSWxdr2YHXy1Wjo5JjlWVVRIWEldJl4fGvLZVqqu0BhiRTl7jbRfwa4+jkOuJvJ/hLgh6h1BvN9Zl6c2j95EZ9GaU1HCZhek0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcFwOd9S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709764787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDP3EJMVLQHfCuzda2hObBpANfqkgEpN6vZzonFm8bY=;
	b=bcFwOd9S6z/AFBYtSN/KECZWopkULlfjGsAKh0roBBLO07xazOQiyTz6kiZBpkJ+qWsTGc
	jZIAXP6PW9F+S6EnlmfVyKDlj9zJ9ljhUd0xcjXNZIPkovOmk4yIUA+j7zsNX8FPB4AY7v
	FhwGVoAR0KdFhRavD9ONnf0PnJGPiZ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-ZvAokr5yO86t8o-0aYvYkw-1; Wed,
 06 Mar 2024 17:39:41 -0500
X-MC-Unique: ZvAokr5yO86t8o-0aYvYkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5151E441D7;
	Wed,  6 Mar 2024 22:39:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 258C7111D785;
	Wed,  6 Mar 2024 22:39:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1668171.1709764777.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Mar 2024 22:39:37 +0000
Message-ID: <1668172.1709764777@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Here's a patch to have a go at getting rid of ->launder_folio().  Since it=
's
failable and cannot guarantee that pages in the range are removed, I've tr=
ied
to replace laundering with just flush-and-wait, dropping the folio lock ar=
ound
the I/O.

Are there any tests for launder_folio as triggering it is tricky?

David
---
mm: Replace ->launder_folio() with flush and wait

invalidate_inode_pages2_range() and its wrappers are frequently used to
invalidate overlapping folios prior to and after doing direct I/O.  This
calls ->launder_folio() to flush dirty folios out to the backing store,
keeping the folio lock across the I/O - presumably to prevent the folio
from being redirtied and thereby prevent it from being removed.

However...  If we're doing this prior to doing DIO on a file, there may be
nothing preventing an mmapped write from recreating and redirtying the
folio the moment it is removed from the mapping lest the kernel deadlock o=
n
doing DIO to/from a buffer mmapped from the target file.

Further, invalidate_inode_pages2_range() is permitted to fail - and half
the callers don't even check to see if it *did* fail, probably not
unreasonably.

In which case, there's no need to keep the folio lock and no need for a
special op.  Instead, drop the lock and flush the range covering the page
to the end of the range to be invalidated (with a flag set in the wbc to
say what we're doing) and then wait for it to complete.

That said, there are other places that use invalidate_inode_pages2_range()
and most of those don't implement launder_page, so add a flag to only do
this in those filesystems that implemented it: 9p, afs, cifs, fuse, nfs an=
d
orangefs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
---
 Documentation/filesystems/locking.rst |    8 ---
 Documentation/filesystems/vfs.rst     |    6 --
 fs/9p/vfs_addr.c                      |    1 =

 fs/9p/vfs_inode.c                     |    1 =

 fs/afs/file.c                         |    1 =

 fs/afs/inode.c                        |    1 =

 fs/fuse/dir.c                         |    2 =

 fs/fuse/file.c                        |   17 -------
 fs/netfs/buffered_write.c             |   76 ----------------------------=
------
 fs/nfs/file.c                         |   23 ----------
 fs/nfs/inode.c                        |    1 =

 fs/nfs/nfstrace.h                     |    1 =

 fs/orangefs/inode.c                   |    2 =

 fs/smb/client/file.c                  |   23 ----------
 fs/smb/client/inode.c                 |    1 =

 include/linux/fs.h                    |    1 =

 include/linux/netfs.h                 |    1 =

 include/linux/pagemap.h               |    6 ++
 include/linux/writeback.h             |    1 =

 mm/truncate.c                         |   35 +++++++++------
 20 files changed, 36 insertions(+), 172 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesys=
tems/locking.rst
index d5bf4b6b7509..139554d1ab51 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -262,7 +262,6 @@ prototypes::
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
-	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count)=
;
 	int (*error_remove_folio)(struct address_space *, struct folio *);
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, secto=
r_t *span)
@@ -288,7 +287,6 @@ release_folio:		yes
 free_folio:		yes
 direct_IO:
 migrate_folio:		yes (both)
-launder_folio:		yes
 is_partially_uptodate:	yes
 error_remove_folio:	yes
 swap_activate:		no
@@ -394,12 +392,6 @@ try_to_free_buffers().
 ->free_folio() is called when the kernel has dropped the folio
 from the page cache.
 =

-->launder_folio() may be called prior to releasing a folio if
-it is still found to be dirty. It returns zero if the folio was successfu=
lly
-cleaned, or an error value if not. Note that in order to prevent the foli=
o
-getting mapped back in and redirtied, it needs to be kept locked
-across the entire operation.
-
 ->swap_activate() will be called to prepare the given file for swap.  It
 should perform any validation and preparation necessary to ensure that
 writes can be performed with minimal memory allocation.  It should call
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems=
/vfs.rst
index eebcc0f9e2bc..b2af9ee6515a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -818,7 +818,6 @@ cache in your filesystem.  The following members are d=
efined:
 		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 		int (*migrate_folio)(struct mapping *, struct folio *dst,
 				struct folio *src, enum migrate_mode);
-		int (*launder_folio) (struct folio *);
 =

 		bool (*is_partially_uptodate) (struct folio *, size_t from,
 					       size_t count);
@@ -1012,11 +1011,6 @@ cache in your filesystem.  The following members ar=
e defined:
 	folio to this function.  migrate_folio should transfer any private
 	data across and update any references that it has to the folio.
 =

-``launder_folio``
-	Called before freeing a folio - it writes back the dirty folio.
-	To prevent redirtying the folio, it is kept locked during the
-	whole operation.
-
 ``is_partially_uptodate``
 	Called by the VM when reading a file through the pagecache when
 	the underlying blocksize is smaller than the size of the folio.
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 047855033d32..967c81b7aa73 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -141,7 +141,6 @@ const struct address_space_operations v9fs_addr_operat=
ions =3D {
 	.dirty_folio		=3D netfs_dirty_folio,
 	.release_folio		=3D netfs_release_folio,
 	.invalidate_folio	=3D netfs_invalidate_folio,
-	.launder_folio		=3D netfs_launder_folio,
 	.direct_IO		=3D noop_direct_IO,
 	.writepages		=3D netfs_writepages,
 };
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 32572982f72e..e085e520cb12 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -263,6 +263,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	simple_inode_init_ts(inode);
 	inode->i_mapping->a_ops =3D &v9fs_addr_operations;
 	inode->i_private =3D NULL;
+	mapping_set_launder_folios(inode->i_mapping);
 =

 	switch (mode & S_IFMT) {
 	case S_IFIFO:
diff --git a/fs/afs/file.c b/fs/afs/file.c
index ef2cc8f565d2..dfd8f60f5e1f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -54,7 +54,6 @@ const struct address_space_operations afs_file_aops =3D =
{
 	.read_folio	=3D netfs_read_folio,
 	.readahead	=3D netfs_readahead,
 	.dirty_folio	=3D netfs_dirty_folio,
-	.launder_folio	=3D netfs_launder_folio,
 	.release_folio	=3D netfs_release_folio,
 	.invalidate_folio =3D netfs_invalidate_folio,
 	.migrate_folio	=3D filemap_migrate_folio,
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 94fc049aff58..4041d9a4dae8 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -104,6 +104,7 @@ static int afs_inode_init_from_status(struct afs_opera=
tion *op,
 		inode->i_fop	=3D &afs_file_operations;
 		inode->i_mapping->a_ops	=3D &afs_file_aops;
 		mapping_set_large_folios(inode->i_mapping);
+		mapping_set_launder_folios(inode->i_mapping);
 		break;
 	case AFS_FTYPE_DIR:
 		inode->i_mode	=3D S_IFDIR |  (status->mode & S_IALLUGO);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..d87ee76bc578 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1978,7 +1978,7 @@ int fuse_do_setattr(struct dentry *dentry, struct ia=
ttr *attr,
 =

 	/*
 	 * Only call invalidate_inode_pages2() after removing
-	 * FUSE_NOWRITE, otherwise fuse_launder_folio() would deadlock.
+	 * FUSE_NOWRITE, otherwise writeback would deadlock.
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize !=3D outarg.attr.size) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0..4933fe0b3269 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2393,21 +2393,6 @@ static int fuse_write_end(struct file *file, struct=
 address_space *mapping,
 	return copied;
 }
 =

-static int fuse_launder_folio(struct folio *folio)
-{
-	int err =3D 0;
-	if (folio_clear_dirty_for_io(folio)) {
-		struct inode *inode =3D folio->mapping->host;
-
-		/* Serialize with pending writeback for the same page */
-		fuse_wait_on_page_writeback(inode, folio->index);
-		err =3D fuse_writepage_locked(&folio->page);
-		if (!err)
-			fuse_wait_on_page_writeback(inode, folio->index);
-	}
-	return err;
-}
-
 /*
  * Write back dirty data/metadata now (there may not be any suitable
  * open files later for data)
@@ -3227,7 +3212,6 @@ static const struct address_space_operations fuse_fi=
le_aops  =3D {
 	.readahead	=3D fuse_readahead,
 	.writepage	=3D fuse_writepage,
 	.writepages	=3D fuse_writepages,
-	.launder_folio	=3D fuse_launder_folio,
 	.dirty_folio	=3D filemap_dirty_folio,
 	.bmap		=3D fuse_bmap,
 	.direct_IO	=3D fuse_direct_IO,
@@ -3241,6 +3225,7 @@ void fuse_init_file_inode(struct inode *inode, unsig=
ned int flags)
 =

 	inode->i_fop =3D &fuse_file_operations;
 	inode->i_data.a_ops =3D &fuse_file_aops;
+	mapping_set_launder_folios(inode->i_mapping);
 =

 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 9a0d32e4b422..56aeb7e70bc8 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -908,7 +908,7 @@ static ssize_t netfs_write_back_from_locked_folio(stru=
ct address_space *mapping,
 	_enter(",%lx,%llx-%llx,%u", folio->index, start, end, caching);
 =

 	wreq =3D netfs_alloc_request(mapping, NULL, start, folio_size(folio),
-				   NETFS_WRITEBACK);
+				   wbc->for_launder ? NETFS_LAUNDER_WRITE : NETFS_WRITEBACK);
 	if (IS_ERR(wreq)) {
 		folio_unlock(folio);
 		return PTR_ERR(wreq);
@@ -1181,77 +1181,3 @@ int netfs_writepages(struct address_space *mapping,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_writepages);
-
-/*
- * Deal with the disposition of a laundered folio.
- */
-static void netfs_cleanup_launder_folio(struct netfs_io_request *wreq)
-{
-	if (wreq->error) {
-		pr_notice("R=3D%08x Laundering error %d\n", wreq->debug_id, wreq->error=
);
-		mapping_set_error(wreq->mapping, wreq->error);
-	}
-}
-
-/**
- * netfs_launder_folio - Clean up a dirty folio that's being invalidated
- * @folio: The folio to clean
- *
- * This is called to write back a folio that's being invalidated when an =
inode
- * is getting torn down.  Ideally, writepages would be used instead.
- */
-int netfs_launder_folio(struct folio *folio)
-{
-	struct netfs_io_request *wreq;
-	struct address_space *mapping =3D folio->mapping;
-	struct netfs_folio *finfo =3D netfs_folio_info(folio);
-	struct netfs_group *group =3D netfs_folio_group(folio);
-	struct bio_vec bvec;
-	unsigned long long i_size =3D i_size_read(mapping->host);
-	unsigned long long start =3D folio_pos(folio);
-	size_t offset =3D 0, len;
-	int ret =3D 0;
-
-	if (finfo) {
-		offset =3D finfo->dirty_offset;
-		start +=3D offset;
-		len =3D finfo->dirty_len;
-	} else {
-		len =3D folio_size(folio);
-	}
-	len =3D min_t(unsigned long long, len, i_size - start);
-
-	wreq =3D netfs_alloc_request(mapping, NULL, start, len, NETFS_LAUNDER_WR=
ITE);
-	if (IS_ERR(wreq)) {
-		ret =3D PTR_ERR(wreq);
-		goto out;
-	}
-
-	if (!folio_clear_dirty_for_io(folio))
-		goto out_put;
-
-	trace_netfs_folio(folio, netfs_folio_trace_launder);
-
-	_debug("launder %llx-%llx", start, start + len - 1);
-
-	/* Speculatively write to the cache.  We have to fix this up later if
-	 * the store fails.
-	 */
-	wreq->cleanup =3D netfs_cleanup_launder_folio;
-
-	bvec_set_folio(&bvec, folio, len, offset);
-	iov_iter_bvec(&wreq->iter, ITER_SOURCE, &bvec, 1, len);
-	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-	ret =3D netfs_begin_write(wreq, true, netfs_write_trace_launder);
-
-out_put:
-	folio_detach_private(folio);
-	netfs_put_group(group);
-	kfree(finfo);
-	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-out:
-	folio_wait_fscache(folio);
-	_leave(" =3D %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(netfs_launder_folio);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8577ccf621f5..6efe0af3ba80 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -484,28 +484,6 @@ static void nfs_check_dirty_writeback(struct folio *f=
olio,
 		*dirty =3D true;
 }
 =

-/*
- * Attempt to clear the private state associated with a page when an erro=
r
- * occurs that requires the cached contents of an inode to be written bac=
k or
- * destroyed
- * - Called if either PG_private or fscache is set on the page
- * - Caller holds page lock
- * - Return 0 if successful, -error otherwise
- */
-static int nfs_launder_folio(struct folio *folio)
-{
-	struct inode *inode =3D folio->mapping->host;
-	int ret;
-
-	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
-		inode->i_ino, folio_pos(folio));
-
-	folio_wait_fscache(folio);
-	ret =3D nfs_wb_folio(inode, folio);
-	trace_nfs_launder_folio_done(inode, folio, ret);
-	return ret;
-}
-
 static int nfs_swap_activate(struct swap_info_struct *sis, struct file *f=
ile,
 						sector_t *span)
 {
@@ -564,7 +542,6 @@ const struct address_space_operations nfs_file_aops =3D=
 {
 	.invalidate_folio =3D nfs_invalidate_folio,
 	.release_folio =3D nfs_release_folio,
 	.migrate_folio =3D nfs_migrate_folio,
-	.launder_folio =3D nfs_launder_folio,
 	.is_dirty_writeback =3D nfs_check_dirty_writeback,
 	.error_remove_folio =3D generic_error_remove_folio,
 	.swap_activate =3D nfs_swap_activate,
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ebb8d60e1152..f2f8cf00a442 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -491,6 +491,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, s=
truct nfs_fattr *fattr)
 			inode->i_fop =3D NFS_SB(sb)->nfs_client->rpc_ops->file_ops;
 			inode->i_data.a_ops =3D &nfs_file_aops;
 			nfs_inode_init_regular(nfsi);
+			mapping_set_launder_folios(inode->i_mapping);
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op =3D NFS_SB(sb)->nfs_client->rpc_ops->dir_inode_ops;
 			inode->i_fop =3D &nfs_dir_operations;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index afedb449b54f..f0e8c0fb9447 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1039,7 +1039,6 @@ DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
 =

 DEFINE_NFS_FOLIO_EVENT(nfs_invalidate_folio);
-DEFINE_NFS_FOLIO_EVENT_DONE(nfs_launder_folio_done);
 =

 TRACE_EVENT(nfs_aop_readahead,
 		TP_PROTO(
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 085912268442..a9ea40261832 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -626,7 +626,6 @@ static const struct address_space_operations orangefs_=
address_operations =3D {
 	.invalidate_folio =3D orangefs_invalidate_folio,
 	.release_folio =3D orangefs_release_folio,
 	.free_folio =3D orangefs_free_folio,
-	.launder_folio =3D orangefs_launder_folio,
 	.direct_IO =3D orangefs_direct_IO,
 };
 =

@@ -980,6 +979,7 @@ static const struct inode_operations orangefs_file_ino=
de_operations =3D {
 static int orangefs_init_iops(struct inode *inode)
 {
 	inode->i_mapping->a_ops =3D &orangefs_address_operations;
+	mapping_set_launder_folios(inode->i_mapping);
 =

 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f391c9b803d8..4fd871ba00f9 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4858,27 +4858,6 @@ static void cifs_invalidate_folio(struct folio *fol=
io, size_t offset,
 	folio_wait_fscache(folio);
 }
 =

-static int cifs_launder_folio(struct folio *folio)
-{
-	int rc =3D 0;
-	loff_t range_start =3D folio_pos(folio);
-	loff_t range_end =3D range_start + folio_size(folio);
-	struct writeback_control wbc =3D {
-		.sync_mode =3D WB_SYNC_ALL,
-		.nr_to_write =3D 0,
-		.range_start =3D range_start,
-		.range_end =3D range_end,
-	};
-
-	cifs_dbg(FYI, "Launder page: %lu\n", folio->index);
-
-	if (folio_clear_dirty_for_io(folio))
-		rc =3D cifs_writepage_locked(&folio->page, &wbc);
-
-	folio_wait_fscache(folio);
-	return rc;
-}
-
 void cifs_oplock_break(struct work_struct *work)
 {
 	struct cifsFileInfo *cfile =3D container_of(work, struct cifsFileInfo,
@@ -5057,7 +5036,6 @@ const struct address_space_operations cifs_addr_ops =
=3D {
 	.release_folio =3D cifs_release_folio,
 	.direct_IO =3D cifs_direct_io,
 	.invalidate_folio =3D cifs_invalidate_folio,
-	.launder_folio =3D cifs_launder_folio,
 	.migrate_folio =3D filemap_migrate_folio,
 	/*
 	 * TODO: investigate and if useful we could add an is_dirty_writeback
@@ -5080,6 +5058,5 @@ const struct address_space_operations cifs_addr_ops_=
smallbuf =3D {
 	.dirty_folio =3D netfs_dirty_folio,
 	.release_folio =3D cifs_release_folio,
 	.invalidate_folio =3D cifs_invalidate_folio,
-	.launder_folio =3D cifs_launder_folio,
 	.migrate_folio =3D filemap_migrate_folio,
 };
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d02f8ba29cb5..24c1c2610e04 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -56,6 +56,7 @@ static void cifs_set_ops(struct inode *inode)
 			inode->i_data.a_ops =3D &cifs_addr_ops_smallbuf;
 		else
 			inode->i_data.a_ops =3D &cifs_addr_ops;
+		mapping_set_launder_folios(inode->i_mapping);
 		break;
 	case S_IFDIR:
 		if (IS_AUTOMOUNT(inode)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fbc72c5f112..ded54555ab30 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -432,7 +432,6 @@ struct address_space_operations {
 	 */
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
-	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
 	void (*is_dirty_writeback) (struct folio *, bool *dirty, bool *wb);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 100cbb261269..e566d31afb04 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -410,7 +410,6 @@ int netfs_unpin_writeback(struct inode *inode, struct =
writeback_control *wbc);
 void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t le=
ngth);
 bool netfs_release_folio(struct folio *folio, gfp_t gfp);
-int netfs_launder_folio(struct folio *folio);
 =

 /* VMA operations API. */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *n=
etfs_group);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..27ea8b9139a3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -207,6 +207,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
+	AS_LAUNDER_FOLIOS,	/* Use laundering in invalidate_inode_pages2*() */
 };
 =

 /**
@@ -323,6 +324,11 @@ static inline bool mapping_unmovable(struct address_s=
pace *mapping)
 	return test_bit(AS_UNMOVABLE, &mapping->flags);
 }
 =

+static inline void mapping_set_launder_folios(struct address_space *mappi=
ng)
+{
+	set_bit(AS_LAUNDER_FOLIOS, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9845cb62e40b..7a1b79b344fa 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -62,6 +62,7 @@ struct writeback_control {
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
+	unsigned for_launder:1;		/* Called from invalidate_inode_pages2_range() =
*/
 	unsigned unpinned_netfs_wb:1;	/* Cleared I_PINNING_NETFS_WB */
 =

 	/*
diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..cb92759c4d8d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -586,15 +586,6 @@ static int invalidate_complete_folio2(struct address_=
space *mapping,
 	return 0;
 }
 =

-static int folio_launder(struct address_space *mapping, struct folio *fol=
io)
-{
-	if (!folio_test_dirty(folio))
-		return 0;
-	if (folio->mapping !=3D mapping || mapping->a_ops->launder_folio =3D=3D =
NULL)
-		return 0;
-	return mapping->a_ops->launder_folio(folio);
-}
-
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_=
space
  * @mapping: the address_space
@@ -657,13 +648,29 @@ int invalidate_inode_pages2_range(struct address_spa=
ce *mapping,
 				unmap_mapping_folio(folio);
 			BUG_ON(folio_mapped(folio));
 =

-			ret2 =3D folio_launder(mapping, folio);
-			if (ret2 =3D=3D 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
+			if (folio_test_dirty(folio) &&
+			    test_bit(AS_LAUNDER_FOLIOS, &mapping->flags)) {
+				struct writeback_control wbc =3D {
+					.sync_mode   =3D WB_SYNC_ALL,
+					.nr_to_write =3D LLONG_MAX,
+					.range_start =3D folio_pos(folio),
+					.range_end   =3D (end + 1ULL) * PAGE_SIZE - 1,
+					.for_launder =3D true,
+				};
+
+				folio_unlock(folio);
+				ret2 =3D filemap_fdatawrite_wbc(mapping, &wbc);
+				folio_lock(folio);
+				if (ret2 < 0)
+					ret =3D ret2;
+				else if (!invalidate_complete_folio2(mapping, folio) &&
+					 ret =3D=3D 0)
+					ret2 =3D -EBUSY;
+			} else {
+				if (!invalidate_complete_folio2(mapping, folio) &&
+				    ret =3D=3D 0)
 					ret2 =3D -EBUSY;
 			}
-			if (ret2 < 0)
-				ret =3D ret2;
 			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);


