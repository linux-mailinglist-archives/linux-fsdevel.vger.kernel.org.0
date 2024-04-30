Return-Path: <linux-fsdevel+bounces-18350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75A8B78F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EBC1F226B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D68174EC8;
	Tue, 30 Apr 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HroxOCct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99300174EE2
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486187; cv=none; b=HIHSPZgdShVj7GhKhZmbMUAphIuiqs5g4/aW9ZHaXH5nywVNQLRGxuF9vF2ltWlszLMhLrAeKoLlfpp3Q4jgdfEVjultPqevj2hbgaKwursOdTtbMlQOvhXVNfOQvpn9+VSI9H5YvxUP/Bzb1slE9InS4IrXBti359WNyzVBSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486187; c=relaxed/simple;
	bh=SO7nT67DlPyeqBObOjnmqethjMqL00KKO+YN4Hs+sEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4E6psWLN+HzqqB9rJm1Y61ohlihcaPBf372jZxkM5gvKHvcTOj1AnR+vYUQfBYInq2xUnrvWyBOGYIGXFeSGOhjj2Sen+6bS5KzAPL9Js5saLDF/KpXqSJnwPmLUiwfZRc/81q6u2qngPtKYyElByaOl7qhR3FSD3XEwG40t+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HroxOCct; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714486184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MS2u9Vl1Wr5O2IG4qIESjKG2m7ZOU7q+LX05Un/i6jQ=;
	b=HroxOCctXQvH/+nJuTMe1dCWyyeCvIzzOSK7eURgWl5oxII7FA7QeRJ60GlRLvIUk+IcWT
	HZ1XXXGgU/VhJn8go2Vx8NVLtTmaRxAIBOnd4wdl2D4cTjd4mj+30KduSkuEmmEqoTcTe5
	ZO7Ppvj8Hat4ifzhh7f+kqCwD/z1Vh4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-nhQJqu5nPSyIA_DdmFX5DA-1; Tue, 30 Apr 2024 10:09:38 -0400
X-MC-Unique: nhQJqu5nPSyIA_DdmFX5DA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C35280021A;
	Tue, 30 Apr 2024 14:09:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7A7492BC7;
	Tue, 30 Apr 2024 14:09:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v7 01/16] cifs: Use alternative invalidation to using launder_folio
Date: Tue, 30 Apr 2024 15:09:13 +0100
Message-ID: <20240430140930.262762-2-dhowells@redhat.com>
In-Reply-To: <20240430140930.262762-1-dhowells@redhat.com>
References: <20240430140930.262762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Use writepages-based flushing invalidation instead of
invalidate_inode_pages2() and ->launder_folio().  This will allow
->launder_folio() to be removed eventually.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.h |   1 -
 fs/smb/client/file.c   | 122 -----------------------------------------
 fs/smb/client/inode.c  |  25 ++-------
 3 files changed, 5 insertions(+), 143 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index ca55d01117c8..1ab7e5998c58 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -69,7 +69,6 @@ extern int cifs_revalidate_file_attr(struct file *filp);
 extern int cifs_revalidate_dentry_attr(struct dentry *);
 extern int cifs_revalidate_file(struct file *filp);
 extern int cifs_revalidate_dentry(struct dentry *);
-extern int cifs_invalidate_mapping(struct inode *inode);
 extern int cifs_revalidate_mapping(struct inode *inode);
 extern int cifs_zap_mapping(struct inode *inode);
 extern int cifs_getattr(struct mnt_idmap *, const struct path *,
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b39caae652f6..2d5488a67965 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2655,64 +2655,6 @@ struct cifs_writedata *cifs_writedata_alloc(work_func_t complete)
 	return wdata;
 }
 
-static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
-{
-	struct address_space *mapping = page->mapping;
-	loff_t offset = (loff_t)page->index << PAGE_SHIFT;
-	char *write_data;
-	int rc = -EFAULT;
-	int bytes_written = 0;
-	struct inode *inode;
-	struct cifsFileInfo *open_file;
-
-	if (!mapping || !mapping->host)
-		return -EFAULT;
-
-	inode = page->mapping->host;
-
-	offset += (loff_t)from;
-	write_data = kmap(page);
-	write_data += from;
-
-	if ((to > PAGE_SIZE) || (from > to)) {
-		kunmap(page);
-		return -EIO;
-	}
-
-	/* racing with truncate? */
-	if (offset > mapping->host->i_size) {
-		kunmap(page);
-		return 0; /* don't care */
-	}
-
-	/* check to make sure that we are not extending the file */
-	if (mapping->host->i_size - offset < (loff_t)to)
-		to = (unsigned)(mapping->host->i_size - offset);
-
-	rc = cifs_get_writable_file(CIFS_I(mapping->host), FIND_WR_ANY,
-				    &open_file);
-	if (!rc) {
-		bytes_written = cifs_write(open_file, open_file->pid,
-					   write_data, to - from, &offset);
-		cifsFileInfo_put(open_file);
-		/* Does mm or vfs already set times? */
-		simple_inode_init_ts(inode);
-		if ((bytes_written > 0) && (offset))
-			rc = 0;
-		else if (bytes_written < 0)
-			rc = bytes_written;
-		else
-			rc = -EFAULT;
-	} else {
-		cifs_dbg(FYI, "No writable handle for write page rc=%d\n", rc);
-		if (!is_retryable_error(rc))
-			rc = -EIO;
-	}
-
-	kunmap(page);
-	return rc;
-}
-
 /*
  * Extend the region to be written back to include subsequent contiguously
  * dirty pages if possible, but don't sleep while doing so.
@@ -3126,47 +3068,6 @@ static int cifs_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int
-cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
-{
-	int rc;
-	unsigned int xid;
-
-	xid = get_xid();
-/* BB add check for wbc flags */
-	get_page(page);
-	if (!PageUptodate(page))
-		cifs_dbg(FYI, "ppw - page not up to date\n");
-
-	/*
-	 * Set the "writeback" flag, and clear "dirty" in the radix tree.
-	 *
-	 * A writepage() implementation always needs to do either this,
-	 * or re-dirty the page with "redirty_page_for_writepage()" in
-	 * the case of a failure.
-	 *
-	 * Just unlocking the page will cause the radix tree tag-bits
-	 * to fail to update with the state of the page correctly.
-	 */
-	set_page_writeback(page);
-retry_write:
-	rc = cifs_partialpagewrite(page, 0, PAGE_SIZE);
-	if (is_retryable_error(rc)) {
-		if (wbc->sync_mode == WB_SYNC_ALL && rc == -EAGAIN)
-			goto retry_write;
-		redirty_page_for_writepage(wbc, page);
-	} else if (rc != 0) {
-		SetPageError(page);
-		mapping_set_error(page->mapping, rc);
-	} else {
-		SetPageUptodate(page);
-	}
-	end_page_writeback(page);
-	put_page(page);
-	free_xid(xid);
-	return rc;
-}
-
 static int cifs_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
@@ -4992,27 +4893,6 @@ static void cifs_invalidate_folio(struct folio *folio, size_t offset,
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 }
 
-static int cifs_launder_folio(struct folio *folio)
-{
-	int rc = 0;
-	loff_t range_start = folio_pos(folio);
-	loff_t range_end = range_start + folio_size(folio);
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = 0,
-		.range_start = range_start,
-		.range_end = range_end,
-	};
-
-	cifs_dbg(FYI, "Launder page: %lu\n", folio->index);
-
-	if (folio_clear_dirty_for_io(folio))
-		rc = cifs_writepage_locked(&folio->page, &wbc);
-
-	folio_wait_private_2(folio); /* [DEPRECATED] */
-	return rc;
-}
-
 void cifs_oplock_break(struct work_struct *work)
 {
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
@@ -5191,7 +5071,6 @@ const struct address_space_operations cifs_addr_ops = {
 	.release_folio = cifs_release_folio,
 	.direct_IO = cifs_direct_io,
 	.invalidate_folio = cifs_invalidate_folio,
-	.launder_folio = cifs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 	/*
 	 * TODO: investigate and if useful we could add an is_dirty_writeback
@@ -5214,6 +5093,5 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.dirty_folio = netfs_dirty_folio,
 	.release_folio = cifs_release_folio,
 	.invalidate_folio = cifs_invalidate_folio,
-	.launder_folio = cifs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 };
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 60afab5c83d4..033948d34c5a 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2431,24 +2431,6 @@ cifs_dentry_needs_reval(struct dentry *dentry)
 	return false;
 }
 
-/*
- * Zap the cache. Called when invalid_mapping flag is set.
- */
-int
-cifs_invalidate_mapping(struct inode *inode)
-{
-	int rc = 0;
-
-	if (inode->i_mapping && inode->i_mapping->nrpages != 0) {
-		rc = invalidate_inode_pages2(inode->i_mapping);
-		if (rc)
-			cifs_dbg(VFS, "%s: invalidate inode %p failed with rc %d\n",
-				 __func__, inode, rc);
-	}
-
-	return rc;
-}
-
 /**
  * cifs_wait_bit_killable - helper for functions that are sleeping on bit locks
  *
@@ -2485,9 +2467,12 @@ cifs_revalidate_mapping(struct inode *inode)
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RW_CACHE)
 			goto skip_invalidate;
 
-		rc = cifs_invalidate_mapping(inode);
-		if (rc)
+		rc = filemap_invalidate_inode(inode, true, 0, LLONG_MAX);
+		if (rc) {
+			cifs_dbg(VFS, "%s: invalidate inode %p failed with rc %d\n",
+				 __func__, inode, rc);
 			set_bit(CIFS_INO_INVALID_MAPPING, flags);
+		}
 	}
 
 skip_invalidate:


