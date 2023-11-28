Return-Path: <linux-fsdevel+bounces-4071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713807FC379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948611C20A69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037BA3D0BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL+QBZcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B95B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701193808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Y799twHekt/GgWBkSL5N9lUQou5nD0zXqSUc2yV/jQ=;
	b=RL+QBZcz6YvnuzQXszWT+9Gt0gsVatNuuDmkEkf1YsCVcPlzvdM+Y+1V9lfMXjuqevpOQB
	Lmbx2hkM7CKb0Oo6JUHXonjF/s3ZRzzqIU4cGj6yTVUhLTzYiRmSz71RRGJZeeFndBTBkM
	hcFHlYWWb2PBv5GOLGsNIjp6XsVxWNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-cS_t7oo0P5e-QzF-jWT-KA-1; Tue, 28 Nov 2023 12:50:05 -0500
X-MC-Unique: cS_t7oo0P5e-QzF-jWT-KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ADEC101A53B;
	Tue, 28 Nov 2023 17:50:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34BFB2166B26;
	Tue, 28 Nov 2023 17:50:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org,
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix issues with copy_file_range and FALLOC_FL_INSERT/ZERO_RANGE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2056122.1701193802.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Nov 2023 17:50:02 +0000
Message-ID: <2056123.1701193802@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

    =

Fix a number of issues in the cifs filesystem implementations of
copy_file_range(), FALLOC_FL_INSERT_RANGE and FALLOC_FL_ZERO_RANGE:

 (1) In cifs_file_copychunk_range(), set i_size after doing the
     copychunk_range operation as this value may be used by various things
     internally.  stat() hides the issue because setting ->time to 0 cause=
s
     cifs_getatr() to revalidate the attributes.

 (2) In smb3_zero_range(), set i_size after extending the file on the
     server.

 (3) In smb3_insert_range(), set i_size after extending the file on the
     server and before we do the copy to open the gap (as we don't clean u=
p
     the EOF marker if the copy fails).

 (4) Add a new MM function, discard_inode_pages_range(), which is
     equivalent to truncate_inode_pages_range(), but rounds out the range
     to include the entire folio at each end.

     [!] This might be better done by adding a flag to
         truncate_inode_pages_range().

 (5) In cifs_file_copychunk_range(), fix the invalidation of the
     destination range.

     We shouldn't just invalidate the whole file as dirty data in the file
     may get lost and we can't just call truncate_inode_pages_range() as
     that will simply partially clear a partial folio at each end whilst
     invalidating and discarding all the folios in the middle.  We need to
     force all the folios covering the range to be reloaded.

     Further, we shouldn't simply round out the range to PAGE_SIZE at each
     end as cifs should move to support multipage folios.

     So change the invalidation to flush the folio at each end of the rang=
e
     (which we can do simply by asking to flush a byte in it), then use
     discard_inode_pages_range() to fully invalidate the entire range of
     folios.

Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
Fixes: 72c419d9b073 ("cifs: fix smb3_zero_range so it can expand the file-=
size when required")
Fixes: 7fe6fe95b936 ("cifs: add FALLOC_FL_INSERT_RANGE support")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c  |   24 +++++++++++++++++++++---
 fs/smb/client/smb2ops.c |   13 +++++++++++--
 include/linux/mm.h      |    2 ++
 mm/truncate.c           |   37 +++++++++++++++++++++++++++++++++----
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ea3a7a668b45..9b6e3cfd5a59 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1267,6 +1267,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	struct cifsFileInfo *smb_file_target;
 	struct cifs_tcon *src_tcon;
 	struct cifs_tcon *target_tcon;
+	unsigned long long destend;
 	ssize_t rc;
 =

 	cifs_dbg(FYI, "copychunk range\n");
@@ -1306,13 +1307,30 @@ ssize_t cifs_file_copychunk_range(unsigned int xid=
,
 	if (rc)
 		goto unlock;
 =

-	/* should we flush first and last page first */
-	truncate_inode_pages(&target_inode->i_data, 0);
+	destend =3D destoff + len - 1;
+
+	/* Flush the folios at either end of the destination range to prevent
+	 * accidental loss of dirty data outside of the range.
+	 */
+	rc =3D filemap_write_and_wait_range(target_inode->i_mapping, destoff, de=
stoff);
+	if (rc)
+		goto unlock;
+	if (destend > destoff) {
+		rc =3D filemap_write_and_wait_range(target_inode->i_mapping, destend, d=
estend);
+		if (rc)
+			goto unlock;
+	}
+
+	/* Discard all the folios that overlap the destination region. */
+	discard_inode_pages_range(&target_inode->i_data, destoff, destend);
 =

 	rc =3D file_modified(dst_file);
-	if (!rc)
+	if (!rc) {
 		rc =3D target_tcon->ses->server->ops->copychunk_range(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
+		if (rc > 0 && destoff + rc > i_size_read(target_inode))
+			truncate_setsize(target_inode, destoff + rc);
+	}
 =

 	file_accessed(src_file);
 =

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a959ed2c9b22..65a00c8b8494 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3307,6 +3307,7 @@ static long smb3_zero_range(struct file *file, struc=
t cifs_tcon *tcon,
 	struct inode *inode =3D file_inode(file);
 	struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
 	struct cifsFileInfo *cfile =3D file->private_data;
+	unsigned long long new_size;
 	long rc;
 	unsigned int xid;
 	__le64 eof;
@@ -3337,10 +3338,15 @@ static long smb3_zero_range(struct file *file, str=
uct cifs_tcon *tcon,
 	/*
 	 * do we also need to change the size of the file?
 	 */
-	if (keep_size =3D=3D false && i_size_read(inode) < offset + len) {
-		eof =3D cpu_to_le64(offset + len);
+	new_size =3D offset + len;
+	if (keep_size =3D=3D false && (unsigned long long)i_size_read(inode) < n=
ew_size) {
+		eof =3D cpu_to_le64(new_size);
 		rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, &eof);
+		if (rc >=3D 0) {
+			truncate_setsize(inode, new_size);
+			fscache_resize_cookie(cifs_inode_cookie(inode), new_size);
+		}
 	}
 =

  zero_range_exit:
@@ -3735,6 +3741,9 @@ static long smb3_insert_range(struct file *file, str=
uct cifs_tcon *tcon,
 	if (rc < 0)
 		goto out_2;
 =

+	truncate_setsize(inode, old_eof + len);
+	fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode));
+
 	rc =3D smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
 	if (rc < 0)
 		goto out_2;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64cd1ee4aacc..e930c930e3f5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3416,6 +3416,8 @@ extern unsigned long vm_unmapped_area(struct vm_unma=
pped_area_info *info);
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
 				       loff_t lstart, loff_t lend);
+extern void discard_inode_pages_range(struct address_space *mapping,
+				      loff_t lstart, loff_t lend);
 extern void truncate_inode_pages_final(struct address_space *);
 =

 /* generic vm_area_ops exported for stackable file systems */
diff --git a/mm/truncate.c b/mm/truncate.c
index 52e3a703e7b2..b91d67de449c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -295,10 +295,11 @@ long mapping_evict_folio(struct address_space *mappi=
ng, struct folio *folio)
 }
 =

 /**
- * truncate_inode_pages_range - truncate range of pages specified by star=
t & end byte offsets
+ * __truncate_inode_pages_range - truncate range of pages specified by st=
art & end byte offsets
  * @mapping: mapping to truncate
  * @lstart: offset from which to truncate
  * @lend: offset to which to truncate (inclusive)
+ * @round_out: Discard all overlapping folios
  *
  * Truncate the page cache, removing the pages that are between
  * specified offsets (and zeroing out partial pages
@@ -318,8 +319,9 @@ long mapping_evict_folio(struct address_space *mapping=
, struct folio *folio)
  * truncate_inode_pages_range is able to handle cases where lend + 1 is n=
ot
  * page aligned properly.
  */
-void truncate_inode_pages_range(struct address_space *mapping,
-				loff_t lstart, loff_t lend)
+static void __truncate_inode_pages_range(struct address_space *mapping,
+					 loff_t lstart, loff_t lend,
+					 bool round_out)
 {
 	pgoff_t		start;		/* inclusive */
 	pgoff_t		end;		/* exclusive */
@@ -367,7 +369,15 @@ void truncate_inode_pages_range(struct address_space =
*mapping,
 	same_folio =3D (lstart >> PAGE_SHIFT) =3D=3D (lend >> PAGE_SHIFT);
 	folio =3D __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0=
);
 	if (!IS_ERR(folio)) {
-		same_folio =3D lend < folio_pos(folio) + folio_size(folio);
+		loff_t fend =3D folio_pos(folio) + folio_size(folio) - 1;
+
+		if (unlikely(round_out)) {
+			if (folio_pos(folio) < lstart)
+				lstart =3D folio_pos(folio);
+			if (lend < fend)
+				lend =3D fend;
+		}
+		same_folio =3D lend <=3D fend;
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start =3D folio_next_index(folio);
 			if (same_folio)
@@ -382,6 +392,12 @@ void truncate_inode_pages_range(struct address_space =
*mapping,
 		folio =3D __filemap_get_folio(mapping, lend >> PAGE_SHIFT,
 						FGP_LOCK, 0);
 		if (!IS_ERR(folio)) {
+			if (unlikely(round_out)) {
+				loff_t fend =3D folio_pos(folio) + folio_size(folio) - 1;
+
+				if (lend < fend)
+					lend =3D fend;
+			}
 			if (!truncate_inode_partial_folio(folio, lstart, lend))
 				end =3D folio->index;
 			folio_unlock(folio);
@@ -420,8 +436,21 @@ void truncate_inode_pages_range(struct address_space =
*mapping,
 		folio_batch_release(&fbatch);
 	}
 }
+
+void truncate_inode_pages_range(struct address_space *mapping,
+				loff_t lstart, loff_t lend)
+{
+	__truncate_inode_pages_range(mapping, lstart, lend, false);
+}
 EXPORT_SYMBOL(truncate_inode_pages_range);
 =

+void discard_inode_pages_range(struct address_space *mapping,
+			       loff_t lstart, loff_t lend)
+{
+	__truncate_inode_pages_range(mapping, lstart, lend, true);
+}
+EXPORT_SYMBOL(discard_inode_pages_range);
+
 /**
  * truncate_inode_pages - truncate *all* the pages from an offset
  * @mapping: mapping to truncate


