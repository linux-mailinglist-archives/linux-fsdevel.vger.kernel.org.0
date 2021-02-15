Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790F431BE06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 17:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhBOP6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232195AbhBOPwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613404275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1Aj9+tG4VEgGGH9o80WvrEBEq+uLnBg7oguv+L08lE=;
        b=G4lzaKJ7zJ3LUAlEiyHnKuaOxCzz/iUAu9cAP51JrfoJaMLPdcp5pg4u8EHv4c6pv69WU/
        lO0vPd9X28fFvCdeZVZugSJqLVuIlYA6ex41nqk0Wz/8mi8NzDXN7gWibY3Ketg4bx8jRL
        Tg9JBAfhot+scwW5FCLEirDR07njQ8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-F69PHfOcO8GF8t1OZR35Bw-1; Mon, 15 Feb 2021 10:51:11 -0500
X-MC-Unique: F69PHfOcO8GF8t1OZR35Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302748030D6;
        Mon, 15 Feb 2021 15:51:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB1B919C99;
        Mon, 15 Feb 2021 15:51:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 33/33] ceph: convert ceph_readpages to ceph_readahead
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Feb 2021 15:51:01 +0000
Message-ID: <161340426195.1303470.14717135788428630282.stgit@warthog.procyon.org.uk>
In-Reply-To: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

Convert ceph_readpages to ceph_readahead and make it use
netfs_readahead. With this we can rip out a lot of the old
readpage/readpages infrastructure.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: ceph-devel@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---

 fs/ceph/addr.c |  229 ++++++++------------------------------------------------
 1 file changed, 34 insertions(+), 195 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 18f660611ba1..0dd64d31eff6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -322,214 +322,53 @@ static int ceph_readpage(struct file *file, struct page *page)
 	return netfs_readpage(file, page, &ceph_readpage_netfs_ops, NULL);
 }
 
-/*
- * Finish an async read(ahead) op.
- */
-static void finish_read(struct ceph_osd_request *req)
+static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
 {
-	struct inode *inode = req->r_inode;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
-	struct ceph_osd_data *osd_data;
-	int rc = req->r_result <= 0 ? req->r_result : 0;
-	int bytes = req->r_result >= 0 ? req->r_result : 0;
-	int num_pages;
-	int i;
-
-	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);
-	if (rc == -EBLOCKLISTED)
-		ceph_inode_to_client(inode)->blocklisted = true;
-
-	/* unlock all pages, zeroing any data we didn't read */
-	osd_data = osd_req_op_extent_osd_data(req, 0);
-	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
-	num_pages = calc_pages_for((u64)osd_data->alignment,
-					(u64)osd_data->length);
-	for (i = 0; i < num_pages; i++) {
-		struct page *page = osd_data->pages[i];
-
-		if (rc < 0 && rc != -ENOENT)
-			goto unlock;
-		if (bytes < (int)PAGE_SIZE) {
-			/* zero (remainder of) page */
-			int s = bytes < 0 ? 0 : bytes;
-			zero_user_segment(page, s, PAGE_SIZE);
-		}
- 		dout("finish_read %p uptodate %p idx %lu\n", inode, page,
-		     page->index);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-unlock:
-		unlock_page(page);
-		put_page(page);
-		bytes -= PAGE_SIZE;
-	}
-
-	ceph_update_read_latency(&fsc->mdsc->metric, req->r_start_latency,
-				 req->r_end_latency, rc);
-
-	kfree(osd_data->pages);
-}
-
-/*
- * start an async read(ahead) operation.  return nr_pages we submitted
- * a read for on success, or negative error code.
- */
-static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
-		      struct list_head *page_list, int max)
-{
-	struct ceph_osd_client *osdc =
-		&ceph_inode_to_client(inode)->client->osdc;
+	struct inode *inode = mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct page *page = lru_to_page(page_list);
-	struct ceph_vino vino;
-	struct ceph_osd_request *req;
-	u64 off;
-	u64 len;
-	int i;
-	struct page **pages;
-	pgoff_t next_index;
-	int nr_pages = 0;
-	int got = 0;
-	int ret = 0;
-
-	if (!rw_ctx) {
-		/* caller of readpages does not hold buffer and read caps
-		 * (fadvise, madvise and readahead cases) */
-		int want = CEPH_CAP_FILE_CACHE;
-		ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want,
-					true, &got);
-		if (ret < 0) {
-			dout("start_read %p, error getting cap\n", inode);
-		} else if (!(got & want)) {
-			dout("start_read %p, no cache cap\n", inode);
-			ret = 0;
-		}
-		if (ret <= 0) {
-			if (got)
-				ceph_put_cap_refs(ci, got);
-			while (!list_empty(page_list)) {
-				page = lru_to_page(page_list);
-				list_del(&page->lru);
-				put_page(page);
-			}
-			return ret;
-		}
-	}
-
-	off = (u64) page_offset(page);
-
-	/* count pages */
-	next_index = page->index;
-	list_for_each_entry_reverse(page, page_list, lru) {
-		if (page->index != next_index)
-			break;
-		nr_pages++;
-		next_index++;
-		if (max && nr_pages == max)
-			break;
-	}
-	len = nr_pages << PAGE_SHIFT;
-	dout("start_read %p nr_pages %d is %lld~%lld\n", inode, nr_pages,
-	     off, len);
-	vino = ceph_vino(inode);
-	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len,
-				    0, 1, CEPH_OSD_OP_READ,
-				    CEPH_OSD_FLAG_READ, NULL,
-				    ci->i_truncate_seq, ci->i_truncate_size,
-				    false);
-	if (IS_ERR(req)) {
-		ret = PTR_ERR(req);
-		goto out;
-	}
-
-	/* build page vector */
-	nr_pages = calc_pages_for(0, len);
-	pages = kmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		goto out_put;
-	}
-	for (i = 0; i < nr_pages; ++i) {
-		page = list_entry(page_list->prev, struct page, lru);
-		BUG_ON(PageLocked(page));
-		list_del(&page->lru);
-
- 		dout("start_read %p adding %p idx %lu\n", inode, page,
-		     page->index);
-		if (add_to_page_cache_lru(page, &inode->i_data, page->index,
-					  GFP_KERNEL)) {
-			put_page(page);
-			dout("start_read %p add_to_page_cache failed %p\n",
-			     inode, page);
-			nr_pages = i;
-			if (nr_pages > 0) {
-				len = nr_pages << PAGE_SHIFT;
-				osd_req_op_extent_update(req, 0, len);
-				break;
-			}
-			goto out_pages;
-		}
-		pages[i] = page;
-	}
-	osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false, false);
-	req->r_callback = finish_read;
-	req->r_inode = inode;
-
-	dout("start_read %p starting %p %lld~%lld\n", inode, req, off, len);
-	ret = ceph_osdc_start_request(osdc, req, false);
-	if (ret < 0)
-		goto out_pages;
-	ceph_osdc_put_request(req);
+	int got = (int)(uintptr_t)priv;
 
-	/* After adding locked pages to page cache, the inode holds cache cap.
-	 * So we can drop our cap refs. */
 	if (got)
 		ceph_put_cap_refs(ci, got);
-
-	return nr_pages;
-
-out_pages:
-	for (i = 0; i < nr_pages; ++i)
-		unlock_page(pages[i]);
-	ceph_put_page_vector(pages, nr_pages, false);
-out_put:
-	ceph_osdc_put_request(req);
-out:
-	if (got)
-		ceph_put_cap_refs(ci, got);
-	return ret;
 }
+const struct netfs_read_request_ops ceph_readahead_netfs_ops = {
+	.init_rreq		= ceph_init_rreq,
+	.is_cache_enabled	= ceph_is_cache_enabled,
+	.begin_cache_operation	= ceph_begin_cache_operation,
+	.issue_op		= ceph_netfs_issue_op,
+	.clamp_length		= ceph_netfs_clamp_length,
+	.cleanup		= ceph_readahead_cleanup,
+};
 
-
-/*
- * Read multiple pages.  Leave pages we don't read + unlock in page_list;
- * the caller (VM) cleans them up.
- */
-static int ceph_readpages(struct file *file, struct address_space *mapping,
-			  struct list_head *page_list, unsigned nr_pages)
+static void ceph_readahead(struct readahead_control *ractl)
 {
-	struct inode *inode = file_inode(file);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
-	struct ceph_file_info *fi = file->private_data;
+	struct inode *inode = file_inode(ractl->file);
+	struct ceph_file_info *fi = ractl->file->private_data;
 	struct ceph_rw_context *rw_ctx;
-	int rc = 0;
-	int max = 0;
+	int got = 0;
+	int ret = 0;
 
 	if (ceph_inode(inode)->i_inline_version != CEPH_INLINE_NONE)
-		return -EINVAL;
+		return;
 
 	rw_ctx = ceph_find_rw_context(fi);
-	max = fsc->mount_options->rsize >> PAGE_SHIFT;
-	dout("readpages %p file %p ctx %p nr_pages %d max %d\n",
-	     inode, file, rw_ctx, nr_pages, max);
-	while (!list_empty(page_list)) {
-		rc = start_read(inode, rw_ctx, page_list, max);
-		if (rc < 0)
-			goto out;
+	if (!rw_ctx) {
+		/*
+		 * readahead callers do not necessarily hold Fcb caps
+		 * (e.g. fadvise, madvise).
+		 */
+		int want = CEPH_CAP_FILE_CACHE;
+
+		ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
+		if (ret < 0)
+			dout("start_read %p, error getting cap\n", inode);
+		else if (!(got & want))
+			dout("start_read %p, no cache cap\n", inode);
+
+		if (ret <= 0)
+			return;
 	}
-out:
-	dout("readpages %p file %p ret %d\n", inode, file, rc);
-	return rc;
+	netfs_readahead(ractl, &ceph_readahead_netfs_ops, (void *)(uintptr_t)got);
 }
 
 struct ceph_writeback_ctl
@@ -1482,7 +1321,7 @@ static ssize_t ceph_direct_io(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations ceph_aops = {
 	.readpage = ceph_readpage,
-	.readpages = ceph_readpages,
+	.readahead = ceph_readahead,
 	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,


