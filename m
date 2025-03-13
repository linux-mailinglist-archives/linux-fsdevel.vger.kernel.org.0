Return-Path: <linux-fsdevel+bounces-43960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F7A60592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05083B0B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8F1FF7A0;
	Thu, 13 Mar 2025 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7L/WaSG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09C1F9F73
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908877; cv=none; b=gzwLqbVWtRSW8Uq8SRYlfYZyzyC3JN/2cVJpQOxGnZwdXC7xpQMGsRiKshchtFDUw4F6jlNM5StyLjBropk4lhP7mdPGUWjom/wYhkDTnXmyqYwYfc7CigUZ0R5HFrQFikzyDv5FhR8j30UvC41CHpkbFDkICdn4dtSznFFAFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908877; c=relaxed/simple;
	bh=PCGKE94dgKsYUob0Vzun+pXaZU/9aL7QAnFrX30bHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHQ7rUz+dYjMlU85hM10gFo8uvzLpIdsZf+Vj7sA+jkMKcdEbdLsLFObc60jpZoKc3UVYepKefFHj1jkhbC6VkEVM4X+ZJh9irhb+2fQnBu8dmGlqexoyXcqUiGWAOGpypS3yJrxp+lDHM3BprZZIKuxrw4r93wKsoCPVAvrQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7L/WaSG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3o0+rtD0ocRw1P10cTGKXFQGnE8YrSB/y3t2jOjxOM=;
	b=K7L/WaSGoFL6dkgPuYrPQyBkGAWRSIKxN4cCVoH8ie0ut20eeiZu6UWkHiEjiPTmTvdMXV
	JiaCFFKQ1O0SeqOtrS2nn/TWRc2dt2EkNojBu3b2I9OQnwqglDWESG8DD5RPKKFnGsByqB
	ZYh3pMe+XtBKqug4+yx2lgqFQkV3jm8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-8x87g4PeOlG9B_EVVAIkNQ-1; Thu,
 13 Mar 2025 19:34:33 -0400
X-MC-Unique: 8x87g4PeOlG9B_EVVAIkNQ-1
X-Mimecast-MFC-AGG-ID: 8x87g4PeOlG9B_EVVAIkNQ_1741908872
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03CC519560AB;
	Thu, 13 Mar 2025 23:34:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 809E0300376F;
	Thu, 13 Mar 2025 23:34:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/35] ceph: Use ceph_databuf in DIO
Date: Thu, 13 Mar 2025 23:33:03 +0000
Message-ID: <20250313233341.1675324-12-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stash the list of pages to be read into/written from during a ceph fs
direct read/write in a ceph_databuf struct rather than using a bvec array.
Eventually this will be replaced with just an iterator supplied by
netfslib.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/file.c | 110 +++++++++++++++++++++----------------------------
 1 file changed, 47 insertions(+), 63 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 9de2960748b9..fb4024bc8274 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -82,11 +82,10 @@ static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flags)
  */
 #define ITER_GET_BVECS_PAGES	64
 
-static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
-				struct bio_vec *bvecs)
+static int __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
+			    struct ceph_databuf *dbuf)
 {
 	size_t size = 0;
-	int bvec_idx = 0;
 
 	if (maxsize > iov_iter_count(iter))
 		maxsize = iov_iter_count(iter);
@@ -98,22 +97,24 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
 		int idx = 0;
 
 		bytes = iov_iter_get_pages2(iter, pages, maxsize - size,
-					   ITER_GET_BVECS_PAGES, &start);
-		if (bytes < 0)
-			return size ?: bytes;
-
-		size += bytes;
+					    ITER_GET_BVECS_PAGES, &start);
+		if (bytes < 0) {
+			if (size == 0)
+				return bytes;
+			break;
+		}
 
-		for ( ; bytes; idx++, bvec_idx++) {
+		while (bytes) {
 			int len = min_t(int, bytes, PAGE_SIZE - start);
 
-			bvec_set_page(&bvecs[bvec_idx], pages[idx], len, start);
+			ceph_databuf_append_page(dbuf, pages[idx++], start, len);
 			bytes -= len;
+			size += len;
 			start = 0;
 		}
 	}
 
-	return size;
+	return 0;
 }
 
 /*
@@ -124,52 +125,44 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
  * Attempt to get up to @maxsize bytes worth of pages from @iter.
  * Return the number of bytes in the created bio_vec array, or an error.
  */
-static ssize_t iter_get_bvecs_alloc(struct iov_iter *iter, size_t maxsize,
-				    struct bio_vec **bvecs, int *num_bvecs)
+static struct ceph_databuf *iter_get_bvecs_alloc(struct iov_iter *iter,
+						 size_t maxsize, bool write)
 {
-	struct bio_vec *bv;
+	struct ceph_databuf *dbuf;
 	size_t orig_count = iov_iter_count(iter);
-	ssize_t bytes;
-	int npages;
+	int npages, ret;
 
 	iov_iter_truncate(iter, maxsize);
 	npages = iov_iter_npages(iter, INT_MAX);
 	iov_iter_reexpand(iter, orig_count);
 
-	/*
-	 * __iter_get_bvecs() may populate only part of the array -- zero it
-	 * out.
-	 */
-	bv = kvmalloc_array(npages, sizeof(*bv), GFP_KERNEL | __GFP_ZERO);
-	if (!bv)
-		return -ENOMEM;
+	if (write)
+		dbuf = ceph_databuf_req_alloc(npages, 0, GFP_KERNEL);
+	else
+		dbuf = ceph_databuf_reply_alloc(npages, 0, GFP_KERNEL);
+	if (!dbuf)
+		return ERR_PTR(-ENOMEM);
 
-	bytes = __iter_get_bvecs(iter, maxsize, bv);
-	if (bytes < 0) {
+	ret = __iter_get_bvecs(iter, maxsize, dbuf);
+	if (ret < 0) {
 		/*
 		 * No pages were pinned -- just free the array.
 		 */
-		kvfree(bv);
-		return bytes;
+		ceph_databuf_release(dbuf);
+		return ERR_PTR(ret);
 	}
 
-	*bvecs = bv;
-	*num_bvecs = npages;
-	return bytes;
+	return dbuf;
 }
 
-static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
+static void ceph_dirty_pages(struct ceph_databuf *dbuf)
 {
+	struct bio_vec *bvec = dbuf->bvec;
 	int i;
 
-	for (i = 0; i < num_bvecs; i++) {
-		if (bvecs[i].bv_page) {
-			if (should_dirty)
-				set_page_dirty_lock(bvecs[i].bv_page);
-			put_page(bvecs[i].bv_page);
-		}
-	}
-	kvfree(bvecs);
+	for (i = 0; i < dbuf->nr_bvec; i++)
+		if (bvec[i].bv_page)
+			set_page_dirty_lock(bvec[i].bv_page);
 }
 
 /*
@@ -1338,14 +1331,11 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct ceph_osd_req_op *op = &req->r_ops[0];
 	struct ceph_client_metric *metric = &ceph_sb_to_mdsc(inode->i_sb)->metric;
-	unsigned int len = osd_data->bvec_pos.iter.bi_size;
+	size_t len = osd_data->iter.count;
 	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_BVECS);
-	BUG_ON(!osd_data->num_bvecs);
-
-	doutc(cl, "req %p inode %p %llx.%llx, rc %d bytes %u\n", req,
+	doutc(cl, "req %p inode %p %llx.%llx, rc %d bytes %zu\n", req,
 	      inode, ceph_vinop(inode), rc, len);
 
 	if (rc == -EOLDSNAPC) {
@@ -1367,7 +1357,6 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 		if (rc == -ENOENT)
 			rc = 0;
 		if (rc >= 0 && len > rc) {
-			struct iov_iter i;
 			int zlen = len - rc;
 
 			/*
@@ -1384,10 +1373,8 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 				aio_req->total_len = rc + zlen;
 			}
 
-			iov_iter_bvec(&i, ITER_DEST, osd_data->bvec_pos.bvecs,
-				      osd_data->num_bvecs, len);
-			iov_iter_advance(&i, rc);
-			iov_iter_zero(zlen, &i);
+			iov_iter_advance(&osd_data->iter, rc);
+			iov_iter_zero(zlen, &osd_data->iter);
 		}
 	}
 
@@ -1401,8 +1388,8 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 						 req->r_end_latency, len, rc);
 	}
 
-	put_bvecs(osd_data->bvec_pos.bvecs, osd_data->num_bvecs,
-		  aio_req->should_dirty);
+	if (aio_req->should_dirty)
+		ceph_dirty_pages(osd_data->dbuf);
 	ceph_osdc_put_request(req);
 
 	if (rc < 0)
@@ -1491,9 +1478,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct ceph_client_metric *metric = &fsc->mdsc->metric;
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
-	struct bio_vec *bvecs;
 	struct ceph_aio_request *aio_req = NULL;
-	int num_pages = 0;
+	struct ceph_databuf *dbuf = NULL;
 	int flags;
 	int ret = 0;
 	struct timespec64 mtime = current_time(inode);
@@ -1529,8 +1515,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 
 	while (iov_iter_count(iter) > 0) {
 		u64 size = iov_iter_count(iter);
-		ssize_t len;
 		struct ceph_osd_req_op *op;
+		size_t len;
 		int readop = sparse ? CEPH_OSD_OP_SPARSE_READ : CEPH_OSD_OP_READ;
 		int extent_cnt;
 
@@ -1563,16 +1549,17 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 
-		len = iter_get_bvecs_alloc(iter, size, &bvecs, &num_pages);
-		if (len < 0) {
+		dbuf = iter_get_bvecs_alloc(iter, size, write);
+		if (IS_ERR(dbuf)) {
 			ceph_osdc_put_request(req);
-			ret = len;
+			ret = PTR_ERR(dbuf);
 			break;
 		}
+		len = ceph_databuf_len(dbuf);
 		if (len != size)
 			osd_req_op_extent_update(req, 0, len);
 
-		osd_req_op_extent_osd_data_bvecs(req, 0, bvecs, num_pages, len);
+		osd_req_op_extent_osd_databuf(req, 0, dbuf);
 
 		/*
 		 * To simplify error handling, allow AIO when IO within i_size
@@ -1637,20 +1624,17 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				ret = 0;
 
 			if (ret >= 0 && ret < len && pos + ret < size) {
-				struct iov_iter i;
 				int zlen = min_t(size_t, len - ret,
 						 size - pos - ret);
 
-				iov_iter_bvec(&i, ITER_DEST, bvecs, num_pages, len);
-				iov_iter_advance(&i, ret);
-				iov_iter_zero(zlen, &i);
+				iov_iter_advance(&dbuf->iter, ret);
+				iov_iter_zero(zlen, &dbuf->iter);
 				ret += zlen;
 			}
 			if (ret >= 0)
 				len = ret;
 		}
 
-		put_bvecs(bvecs, num_pages, should_dirty);
 		ceph_osdc_put_request(req);
 		if (ret < 0)
 			break;


