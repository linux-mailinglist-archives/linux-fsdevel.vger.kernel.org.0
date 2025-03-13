Return-Path: <linux-fsdevel+bounces-43962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE27A6059B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC304217E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42099200BA3;
	Thu, 13 Mar 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCJOuyu7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2ED200126
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908887; cv=none; b=urAWRbzNTa49H2wnoMzUKGn8I2FtIfnhfxjqlF255qYmf+wsOinUN50FDxnmSjMCmoECJ3IfpwmVeCPivigDk8SPHjRs8WkkMFVF+2mh66A67oRObPdPKuJp1Wee4nZ+8Ns75tkhVpZMCkiCEGTZn+wSxIWplGtk+SozUsY0Tl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908887; c=relaxed/simple;
	bh=ELBwlKod9L5y2/hvpaoNXIIkZKOWGnJicHOEF5NHgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idiZKj9eWBnncziL1I/XKmriGKtBmh/DQ6UMojiWtK8uUcTtoRrLVq+wE1VZrQfvKvslZuETKAhM9wGzoXGYGQvpnOFi1oUwKSguS91YdyoV3yL+iplhec73qVxan0RdC3yx+uBl5KtmCThICtk9vLdpnb1GN3jDdTZxo5F95dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCJOuyu7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1JOhB1HV1bgbTA8oOlOZjWqLGwntHtGTw5VdSyajrw=;
	b=SCJOuyu785gB4Fd2acpG/gVdVrSVgzQwV9ybBbDNtgsCp/VN3AAr9YWFTvtFDIUMVDc2uo
	JZxj31VKOBy9wFop2VgsbHNWy58UsW3RubjGQnRQ7UqkF/pF6RgJHNGP2hYq20jBrkQcHu
	AQ30Ih1fFVQL/bpNoTphBo0IrqOvcFE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-B8NL9l25N4OAYxAkXGgHyg-1; Thu,
 13 Mar 2025 19:34:40 -0400
X-MC-Unique: B8NL9l25N4OAYxAkXGgHyg-1
X-Mimecast-MFC-AGG-ID: B8NL9l25N4OAYxAkXGgHyg_1741908879
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8423D1956059;
	Thu, 13 Mar 2025 23:34:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8FAA1955BCB;
	Thu, 13 Mar 2025 23:34:36 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH 13/35] rbd: Switch from using bvec_iter to iov_iter
Date: Thu, 13 Mar 2025 23:33:05 +0000
Message-ID: <20250313233341.1675324-14-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Switch from using a ceph_bio_iter/ceph_bvec_iter for iterating over the
bio_vecs attached to the request to using a ceph_databuf with the bio_vecs
transscribed from the bio list.  This allows the entire bio bvec[] set to
be passed down to the socket (if unencrypted).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c          | 642 ++++++++++++++---------------------
 include/linux/ceph/databuf.h |  22 ++
 include/linux/ceph/striper.h |  58 +++-
 net/ceph/striper.c           |  53 ---
 4 files changed, 331 insertions(+), 444 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 073e80d2d966..dd22cea7ae89 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -46,6 +46,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/workqueue.h>
+#include <linux/iov_iter.h>
 
 #include "rbd_types.h"
 
@@ -214,13 +215,6 @@ struct pending_result {
 
 struct rbd_img_request;
 
-enum obj_request_type {
-	OBJ_REQUEST_NODATA = 1,
-	OBJ_REQUEST_BIO,	/* pointer into provided bio (list) */
-	OBJ_REQUEST_BVECS,	/* pointer into provided bio_vec array */
-	OBJ_REQUEST_OWN_BVECS,	/* private bio_vec array, doesn't own pages */
-};
-
 enum obj_operation_type {
 	OBJ_OP_READ = 1,
 	OBJ_OP_WRITE,
@@ -295,18 +289,12 @@ struct rbd_obj_request {
 	struct ceph_file_extent	*img_extents;
 	u32			num_img_extents;
 
-	union {
-		struct ceph_bio_iter	bio_pos;
-		struct {
-			struct ceph_bvec_iter	bvec_pos;
-			u32			bvec_count;
-			u32			bvec_idx;
-		};
-	};
+	unsigned int		bvec_count;
+	struct iov_iter		iter;
+	struct ceph_databuf	*dbuf;
 
 	enum rbd_obj_copyup_state copyup_state;
-	struct bio_vec		*copyup_bvecs;
-	u32			copyup_bvec_count;
+	struct ceph_databuf	*copyup_buf;
 
 	struct list_head	osd_reqs;	/* w/ r_private_item */
 
@@ -330,7 +318,6 @@ enum rbd_img_state {
 struct rbd_img_request {
 	struct rbd_device	*rbd_dev;
 	enum obj_operation_type	op_type;
-	enum obj_request_type	data_type;
 	unsigned long		flags;
 	enum rbd_img_state	state;
 	union {
@@ -1221,26 +1208,6 @@ static void rbd_dev_mapping_clear(struct rbd_device *rbd_dev)
 	rbd_dev->mapping.size = 0;
 }
 
-static void zero_bios(struct ceph_bio_iter *bio_pos, u32 off, u32 bytes)
-{
-	struct ceph_bio_iter it = *bio_pos;
-
-	ceph_bio_iter_advance(&it, off);
-	ceph_bio_iter_advance_step(&it, bytes, ({
-		memzero_bvec(&bv);
-	}));
-}
-
-static void zero_bvecs(struct ceph_bvec_iter *bvec_pos, u32 off, u32 bytes)
-{
-	struct ceph_bvec_iter it = *bvec_pos;
-
-	ceph_bvec_iter_advance(&it, off);
-	ceph_bvec_iter_advance_step(&it, bytes, ({
-		memzero_bvec(&bv);
-	}));
-}
-
 /*
  * Zero a range in @obj_req data buffer defined by a bio (list) or
  * (private) bio_vec array.
@@ -1252,17 +1219,9 @@ static void rbd_obj_zero_range(struct rbd_obj_request *obj_req, u32 off,
 {
 	dout("%s %p data buf %u~%u\n", __func__, obj_req, off, bytes);
 
-	switch (obj_req->img_request->data_type) {
-	case OBJ_REQUEST_BIO:
-		zero_bios(&obj_req->bio_pos, off, bytes);
-		break;
-	case OBJ_REQUEST_BVECS:
-	case OBJ_REQUEST_OWN_BVECS:
-		zero_bvecs(&obj_req->bvec_pos, off, bytes);
-		break;
-	default:
-		BUG();
-	}
+	iov_iter_advance(&obj_req->dbuf->iter, off);
+	iov_iter_zero(bytes, &obj_req->dbuf->iter);
+	iov_iter_revert(&obj_req->dbuf->iter, off);
 }
 
 static void rbd_obj_request_destroy(struct kref *kref);
@@ -1487,7 +1446,6 @@ static void rbd_obj_request_destroy(struct kref *kref)
 {
 	struct rbd_obj_request *obj_request;
 	struct ceph_osd_request *osd_req;
-	u32 i;
 
 	obj_request = container_of(kref, struct rbd_obj_request, kref);
 
@@ -1500,27 +1458,8 @@ static void rbd_obj_request_destroy(struct kref *kref)
 		ceph_osdc_put_request(osd_req);
 	}
 
-	switch (obj_request->img_request->data_type) {
-	case OBJ_REQUEST_NODATA:
-	case OBJ_REQUEST_BIO:
-	case OBJ_REQUEST_BVECS:
-		break;		/* Nothing to do */
-	case OBJ_REQUEST_OWN_BVECS:
-		kfree(obj_request->bvec_pos.bvecs);
-		break;
-	default:
-		BUG();
-	}
-
 	kfree(obj_request->img_extents);
-	if (obj_request->copyup_bvecs) {
-		for (i = 0; i < obj_request->copyup_bvec_count; i++) {
-			if (obj_request->copyup_bvecs[i].bv_page)
-				__free_page(obj_request->copyup_bvecs[i].bv_page);
-		}
-		kfree(obj_request->copyup_bvecs);
-	}
-
+	ceph_databuf_release(obj_request->copyup_buf);
 	kmem_cache_free(rbd_obj_request_cache, obj_request);
 }
 
@@ -1855,7 +1794,7 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 		goto out;
 
 	p = kmap_ceph_databuf_page(reply, 0);
-	end = p + min(ceph_databuf_len(reply), (size_t)PAGE_SIZE);
+	end = p + umin(ceph_databuf_len(reply), PAGE_SIZE);
 	q = p;
 	ret = decode_object_map_header(&q, end, &object_map_size);
 	if (ret)
@@ -2167,29 +2106,6 @@ static int rbd_obj_calc_img_extents(struct rbd_obj_request *obj_req,
 	return 0;
 }
 
-static void rbd_osd_setup_data(struct ceph_osd_request *osd_req, int which)
-{
-	struct rbd_obj_request *obj_req = osd_req->r_priv;
-
-	switch (obj_req->img_request->data_type) {
-	case OBJ_REQUEST_BIO:
-		osd_req_op_extent_osd_data_bio(osd_req, which,
-					       &obj_req->bio_pos,
-					       obj_req->ex.oe_len);
-		break;
-	case OBJ_REQUEST_BVECS:
-	case OBJ_REQUEST_OWN_BVECS:
-		rbd_assert(obj_req->bvec_pos.iter.bi_size ==
-							obj_req->ex.oe_len);
-		rbd_assert(obj_req->bvec_idx == obj_req->bvec_count);
-		osd_req_op_extent_osd_data_bvec_pos(osd_req, which,
-						    &obj_req->bvec_pos);
-		break;
-	default:
-		BUG();
-	}
-}
-
 static int rbd_osd_setup_stat(struct ceph_osd_request *osd_req, int which)
 {
 	struct page **pages;
@@ -2223,8 +2139,7 @@ static int rbd_osd_setup_copyup(struct ceph_osd_request *osd_req, int which,
 	if (ret)
 		return ret;
 
-	osd_req_op_cls_request_data_bvecs(osd_req, which, obj_req->copyup_bvecs,
-					  obj_req->copyup_bvec_count, bytes);
+	osd_req_op_cls_request_databuf(osd_req, which, obj_req->copyup_buf);
 	return 0;
 }
 
@@ -2256,7 +2171,7 @@ static void __rbd_osd_setup_write_ops(struct ceph_osd_request *osd_req,
 
 	osd_req_op_extent_init(osd_req, which, opcode,
 			       obj_req->ex.oe_off, obj_req->ex.oe_len, 0, 0);
-	rbd_osd_setup_data(osd_req, which);
+	osd_req_op_extent_osd_databuf(osd_req, which, obj_req->dbuf);
 }
 
 static int rbd_obj_init_write(struct rbd_obj_request *obj_req)
@@ -2427,6 +2342,19 @@ static void rbd_osd_setup_write_ops(struct ceph_osd_request *osd_req,
 	}
 }
 
+static struct ceph_object_extent *alloc_object_extent(void *arg)
+{
+	struct rbd_img_request *img_req = arg;
+	struct rbd_obj_request *obj_req;
+
+	obj_req = rbd_obj_request_create();
+	if (!obj_req)
+		return NULL;
+
+	rbd_img_obj_request_add(img_req, obj_req);
+	return &obj_req->ex;
+}
+
 /*
  * Prune the list of object requests (adjust offset and/or length, drop
  * redundant requests).  Prepare object request state machines and image
@@ -2466,104 +2394,232 @@ static int __rbd_img_fill_request(struct rbd_img_request *img_req)
 	return 0;
 }
 
-union rbd_img_fill_iter {
-	struct ceph_bio_iter	bio_iter;
-	struct ceph_bvec_iter	bvec_iter;
-};
+/*
+ * Handle ranged, but dataless ops such as DISCARD and ZEROOUT.
+ */
+static int rbd_img_fill_nodata(struct rbd_img_request *img_req,
+			       u64 off, u64 len)
+{
+	int ret;
+
+	ret = ceph_file_to_extents(&img_req->rbd_dev->layout, off, len,
+				   &img_req->object_extents,
+				   alloc_object_extent, img_req,
+				   NULL, NULL);
+	if (ret)
+		return ret;
 
-struct rbd_img_fill_ctx {
-	enum obj_request_type	pos_type;
-	union rbd_img_fill_iter	*pos;
-	union rbd_img_fill_iter	iter;
-	ceph_object_extent_fn_t	set_pos_fn;
-	ceph_object_extent_fn_t	count_fn;
-	ceph_object_extent_fn_t	copy_fn;
+	return __rbd_img_fill_request(img_req);
+}
+
+struct rbd_bio_iter {
+	const struct bio	*first_bio;
+	const struct bio	*bio;
+	size_t			skip;
+	unsigned int		bvix;
 };
 
-static struct ceph_object_extent *alloc_object_extent(void *arg)
+static void rbd_start_bio_iteration(struct rbd_bio_iter *iter, struct bio *bio)
 {
-	struct rbd_img_request *img_req = arg;
-	struct rbd_obj_request *obj_req;
+	iter->bio = bio;
+	iter->bvix = 0;
+	iter->skip = 0;
+}
 
-	obj_req = rbd_obj_request_create();
-	if (!obj_req)
-		return NULL;
+static void count_bio_bvecs(struct ceph_object_extent *ex, u32 bytes, void *arg)
+{
+	struct rbd_obj_request *obj_req = container_of(ex, struct rbd_obj_request, ex);
+	struct rbd_bio_iter *iter = arg;
+	const struct bio *bio;
+	unsigned int need_bv = obj_req->bvec_count, i = 0;
+	size_t skip;
+
+	/* Count the number of bvecs we need. */
+	skip = iter->skip;
+	bio = iter->bio;
+	while (bio) {
+		for (i = iter->bvix; i < bio->bi_vcnt; i++, skip = 0) {
+			const struct bio_vec *bv = bio->bi_io_vec + i;
+			size_t part = umin(bytes, bv->bv_len - skip);
+
+			if (!part)
+				continue;
 
-	rbd_img_obj_request_add(img_req, obj_req);
-	return &obj_req->ex;
+			need_bv++;
+			skip += part;
+			bytes -= part;
+			if (!bytes)
+				goto done;
+		}
+
+		bio = bio->bi_next;
+		iter->bvix = 0;
+		iter->skip = 0;
+	}
+
+done:
+	iter->bio = bio;
+	iter->bvix = i;
+	iter->skip = skip;
+	obj_req->bvec_count += need_bv;
 }
 
-/*
- * While su != os && sc == 1 is technically not fancy (it's the same
- * layout as su == os && sc == 1), we can't use the nocopy path for it
- * because ->set_pos_fn() should be called only once per object.
- * ceph_file_to_extents() invokes action_fn once per stripe unit, so
- * treat su != os && sc == 1 as fancy.
- */
-static bool rbd_layout_is_fancy(struct ceph_file_layout *l)
+static void copy_bio_bvecs(struct ceph_object_extent *ex, u32 bytes, void *arg)
+{
+	struct rbd_obj_request *obj_req = container_of(ex, struct rbd_obj_request, ex);
+	struct rbd_bio_iter *iter = arg;
+	struct ceph_databuf *dbuf = obj_req->dbuf;
+	const struct bio *bio;
+	unsigned int i;
+	size_t skip = iter->skip;
+
+	/* Transcribe the pages to the databuf. */
+	for (bio = iter->bio; bio; bio = bio->bi_next) {
+		for (i = iter->bvix; i < bio->bi_vcnt; i++, skip = 0) {
+			const struct bio_vec *bv = bio->bi_io_vec + i;
+			size_t part = umin(bytes, bv->bv_len - skip);
+
+			if (!part)
+				continue;
+
+			ceph_databuf_append_page(dbuf, bv->bv_page,
+						 bv->bv_offset + skip,
+						 bv->bv_len - skip);
+			skip += part;
+			bytes -= part;
+			if (!bytes)
+				goto done;
+		}
+
+		iter->bvix = 0;
+		iter->skip = 0;
+	}
+
+done:
+	iter->bio = bio;
+	iter->bvix = i;
+	iter->skip = skip;
+}
+
+static int rbd_img_alloc_databufs(struct rbd_img_request *img_req)
 {
-	return l->stripe_unit != l->object_size;
+	struct rbd_obj_request *obj_req;
+
+	for_each_obj_request(img_req, obj_req) {
+		if (img_req->op_type == OBJ_OP_READ)
+			obj_req->dbuf = ceph_databuf_reply_alloc(obj_req->bvec_count, 0,
+								 GFP_NOIO);
+		else
+			obj_req->dbuf = ceph_databuf_req_alloc(obj_req->bvec_count, 0,
+							       GFP_NOIO);
+		if (!obj_req->dbuf)
+			return -ENOMEM;
+	}
+
+	return 0;
 }
 
-static int rbd_img_fill_request_nocopy(struct rbd_img_request *img_req,
-				       struct ceph_file_extent *img_extents,
-				       u32 num_img_extents,
-				       struct rbd_img_fill_ctx *fctx)
+/*
+ * Map an image extent that is backed by a bio chain to a list of object
+ * extents, create the corresponding object requests (normally each to a
+ * different object, but not always) and add them to @img_req.  For each object
+ * request, set up its data descriptor to point to a distilled list of page
+ * fragments.
+ *
+ * Because ceph_file_to_extents() will merge adjacent object extents together,
+ * each object request's data descriptor may point to multiple different chunks
+ * of the data buffer.
+ *
+ * The data buffer is assumed to be large enough.
+ */
+static int rbd_img_fill_from_bio(struct rbd_img_request *img_req,
+				 u64 off, u64 len, struct bio *bio)
 {
-	u32 i;
+	struct rbd_bio_iter iter;
+	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
-	img_req->data_type = fctx->pos_type;
+	/*
+	 * Create object requests and determine ->bvec_count for each object
+	 * request.  Note that ->bvec_count sum over all object requests may
+	 * be greater than the number of bio_vecs in the provided bio (list)
+	 * or bio_vec array because when mapped, those bio_vecs can straddle
+	 * stripe unit boundaries.
+	 */
+	rbd_start_bio_iteration(&iter, bio);
+	ret = ceph_file_to_extents(&rbd_dev->layout, off, len,
+				   &img_req->object_extents,
+				   alloc_object_extent, img_req,
+				   count_bio_bvecs, &iter);
+	if (ret)
+		return ret;
+
+	ret = rbd_img_alloc_databufs(img_req);
+	if (ret)
+		return ret;
 
 	/*
-	 * Create object requests and set each object request's starting
-	 * position in the provided bio (list) or bio_vec array.
+	 * Fill in each object request's databuf, splitting and rearranging the
+	 * provided bio_vecs in stripe unit chunks as needed.
 	 */
-	fctx->iter = *fctx->pos;
-	for (i = 0; i < num_img_extents; i++) {
-		ret = ceph_file_to_extents(&img_req->rbd_dev->layout,
-					   img_extents[i].fe_off,
-					   img_extents[i].fe_len,
-					   &img_req->object_extents,
-					   alloc_object_extent, img_req,
-					   fctx->set_pos_fn, &fctx->iter);
-		if (ret)
-			return ret;
-	}
+	rbd_start_bio_iteration(&iter, bio);
+	ret = ceph_iterate_extents(&rbd_dev->layout, off, len,
+				   &img_req->object_extents,
+				   copy_bio_bvecs, &iter);
+	if (ret)
+		return ret;
 
 	return __rbd_img_fill_request(img_req);
 }
 
+static void rbd_count_iter(struct ceph_object_extent *ex, u32 bytes, void *arg)
+{
+	struct rbd_obj_request *obj_req = container_of(ex, struct rbd_obj_request, ex);
+	struct iov_iter *iter = arg;
+
+	obj_req->bvec_count += iov_iter_npages_cap(iter, INT_MAX, bytes);
+}
+
+static size_t rbd_copy_iter_step(void *iter_base, size_t progress, size_t len,
+				 void *priv, void *priv2)
+{
+	struct ceph_databuf *dbuf = priv;
+	struct page *page = virt_to_page(iter_base);
+
+	ceph_databuf_append_page(dbuf, page, (unsigned long)iter_base & ~PAGE_MASK, len);
+	return 0;
+}
+
+static void rbd_copy_iter(struct ceph_object_extent *ex, u32 bytes, void *arg)
+{
+	struct rbd_obj_request *obj_req = container_of(ex, struct rbd_obj_request, ex);
+	struct iov_iter *iter = arg;
+
+	iterate_bvec(iter, bytes, obj_req->dbuf, NULL, rbd_copy_iter_step);
+}
+
 /*
- * Map a list of image extents to a list of object extents, create the
- * corresponding object requests (normally each to a different object,
- * but not always) and add them to @img_req.  For each object request,
- * set up its data descriptor to point to the corresponding chunk(s) of
- * @fctx->pos data buffer.
+ * Map a list of image extents to a list of object extents, creating the
+ * corresponding object requests (normally each to a different object, but not
+ * always) and add them to @img_req.  For each object request, set up its data
+ * descriptor to point to the corresponding chunk(s) of the @dbuf data buffer.
  *
  * Because ceph_file_to_extents() will merge adjacent object extents
  * together, each object request's data descriptor may point to multiple
- * different chunks of @fctx->pos data buffer.
+ * different chunks of the data buffer.
  *
- * @fctx->pos data buffer is assumed to be large enough.
+ * The data buffer is assumed to be large enough.
  */
-static int rbd_img_fill_request(struct rbd_img_request *img_req,
-				struct ceph_file_extent *img_extents,
-				u32 num_img_extents,
-				struct rbd_img_fill_ctx *fctx)
+static int rbd_img_fill_from_dbuf(struct rbd_img_request *img_req,
+				  const struct ceph_file_extent *img_extents,
+				  u32 num_img_extents,
+				  const struct ceph_databuf *dbuf)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
-	struct rbd_obj_request *obj_req;
-	u32 i;
+	struct iov_iter iter;
+	unsigned int i;
 	int ret;
 
-	if (fctx->pos_type == OBJ_REQUEST_NODATA ||
-	    !rbd_layout_is_fancy(&rbd_dev->layout))
-		return rbd_img_fill_request_nocopy(img_req, img_extents,
-						   num_img_extents, fctx);
-
-	img_req->data_type = OBJ_REQUEST_OWN_BVECS;
-
 	/*
 	 * Create object requests and determine ->bvec_count for each object
 	 * request.  Note that ->bvec_count sum over all object requests may
@@ -2571,37 +2627,33 @@ static int rbd_img_fill_request(struct rbd_img_request *img_req,
 	 * or bio_vec array because when mapped, those bio_vecs can straddle
 	 * stripe unit boundaries.
 	 */
-	fctx->iter = *fctx->pos;
+	iter = dbuf->iter;
 	for (i = 0; i < num_img_extents; i++) {
 		ret = ceph_file_to_extents(&rbd_dev->layout,
 					   img_extents[i].fe_off,
 					   img_extents[i].fe_len,
 					   &img_req->object_extents,
 					   alloc_object_extent, img_req,
-					   fctx->count_fn, &fctx->iter);
+					   rbd_count_iter, &iter);
 		if (ret)
 			return ret;
 	}
 
-	for_each_obj_request(img_req, obj_req) {
-		obj_req->bvec_pos.bvecs = kmalloc_array(obj_req->bvec_count,
-					      sizeof(*obj_req->bvec_pos.bvecs),
-					      GFP_NOIO);
-		if (!obj_req->bvec_pos.bvecs)
-			return -ENOMEM;
-	}
+	ret = rbd_img_alloc_databufs(img_req);
+	if (ret)
+		return ret;
 
 	/*
-	 * Fill in each object request's private bio_vec array, splitting and
-	 * rearranging the provided bio_vecs in stripe unit chunks as needed.
+	 * Fill in each object request's databuf, splitting and rearranging the
+	 * provided bio_vecs in stripe unit chunks as needed.
 	 */
-	fctx->iter = *fctx->pos;
+	iter = dbuf->iter;
 	for (i = 0; i < num_img_extents; i++) {
 		ret = ceph_iterate_extents(&rbd_dev->layout,
 					   img_extents[i].fe_off,
 					   img_extents[i].fe_len,
 					   &img_req->object_extents,
-					   fctx->copy_fn, &fctx->iter);
+					   rbd_copy_iter, &iter);
 		if (ret)
 			return ret;
 	}
@@ -2609,148 +2661,6 @@ static int rbd_img_fill_request(struct rbd_img_request *img_req,
 	return __rbd_img_fill_request(img_req);
 }
 
-static int rbd_img_fill_nodata(struct rbd_img_request *img_req,
-			       u64 off, u64 len)
-{
-	struct ceph_file_extent ex = { off, len };
-	union rbd_img_fill_iter dummy = {};
-	struct rbd_img_fill_ctx fctx = {
-		.pos_type = OBJ_REQUEST_NODATA,
-		.pos = &dummy,
-	};
-
-	return rbd_img_fill_request(img_req, &ex, 1, &fctx);
-}
-
-static void set_bio_pos(struct ceph_object_extent *ex, u32 bytes, void *arg)
-{
-	struct rbd_obj_request *obj_req =
-	    container_of(ex, struct rbd_obj_request, ex);
-	struct ceph_bio_iter *it = arg;
-
-	dout("%s objno %llu bytes %u\n", __func__, ex->oe_objno, bytes);
-	obj_req->bio_pos = *it;
-	ceph_bio_iter_advance(it, bytes);
-}
-
-static void count_bio_bvecs(struct ceph_object_extent *ex, u32 bytes, void *arg)
-{
-	struct rbd_obj_request *obj_req =
-	    container_of(ex, struct rbd_obj_request, ex);
-	struct ceph_bio_iter *it = arg;
-
-	dout("%s objno %llu bytes %u\n", __func__, ex->oe_objno, bytes);
-	ceph_bio_iter_advance_step(it, bytes, ({
-		obj_req->bvec_count++;
-	}));
-
-}
-
-static void copy_bio_bvecs(struct ceph_object_extent *ex, u32 bytes, void *arg)
-{
-	struct rbd_obj_request *obj_req =
-	    container_of(ex, struct rbd_obj_request, ex);
-	struct ceph_bio_iter *it = arg;
-
-	dout("%s objno %llu bytes %u\n", __func__, ex->oe_objno, bytes);
-	ceph_bio_iter_advance_step(it, bytes, ({
-		obj_req->bvec_pos.bvecs[obj_req->bvec_idx++] = bv;
-		obj_req->bvec_pos.iter.bi_size += bv.bv_len;
-	}));
-}
-
-static int __rbd_img_fill_from_bio(struct rbd_img_request *img_req,
-				   struct ceph_file_extent *img_extents,
-				   u32 num_img_extents,
-				   struct ceph_bio_iter *bio_pos)
-{
-	struct rbd_img_fill_ctx fctx = {
-		.pos_type = OBJ_REQUEST_BIO,
-		.pos = (union rbd_img_fill_iter *)bio_pos,
-		.set_pos_fn = set_bio_pos,
-		.count_fn = count_bio_bvecs,
-		.copy_fn = copy_bio_bvecs,
-	};
-
-	return rbd_img_fill_request(img_req, img_extents, num_img_extents,
-				    &fctx);
-}
-
-static int rbd_img_fill_from_bio(struct rbd_img_request *img_req,
-				 u64 off, u64 len, struct bio *bio)
-{
-	struct ceph_file_extent ex = { off, len };
-	struct ceph_bio_iter it = { .bio = bio, .iter = bio->bi_iter };
-
-	return __rbd_img_fill_from_bio(img_req, &ex, 1, &it);
-}
-
-static void set_bvec_pos(struct ceph_object_extent *ex, u32 bytes, void *arg)
-{
-	struct rbd_obj_request *obj_req =
-	    container_of(ex, struct rbd_obj_request, ex);
-	struct ceph_bvec_iter *it = arg;
-
-	obj_req->bvec_pos = *it;
-	ceph_bvec_iter_shorten(&obj_req->bvec_pos, bytes);
-	ceph_bvec_iter_advance(it, bytes);
-}
-
-static void count_bvecs(struct ceph_object_extent *ex, u32 bytes, void *arg)
-{
-	struct rbd_obj_request *obj_req =
-	    container_of(ex, struct rbd_obj_request, ex);
-	struct ceph_bvec_iter *it = arg;
-
-	ceph_bvec_iter_advance_step(it, bytes, ({
-		obj_req->bvec_count++;
-	}));
-}
-
-static void copy_bvecs(struct ceph_object_extent *ex, u32 bytes, void *arg)
-{
-	struct rbd_obj_request *obj_req =
-	    container_of(ex, struct rbd_obj_request, ex);
-	struct ceph_bvec_iter *it = arg;
-
-	ceph_bvec_iter_advance_step(it, bytes, ({
-		obj_req->bvec_pos.bvecs[obj_req->bvec_idx++] = bv;
-		obj_req->bvec_pos.iter.bi_size += bv.bv_len;
-	}));
-}
-
-static int __rbd_img_fill_from_bvecs(struct rbd_img_request *img_req,
-				     struct ceph_file_extent *img_extents,
-				     u32 num_img_extents,
-				     struct ceph_bvec_iter *bvec_pos)
-{
-	struct rbd_img_fill_ctx fctx = {
-		.pos_type = OBJ_REQUEST_BVECS,
-		.pos = (union rbd_img_fill_iter *)bvec_pos,
-		.set_pos_fn = set_bvec_pos,
-		.count_fn = count_bvecs,
-		.copy_fn = copy_bvecs,
-	};
-
-	return rbd_img_fill_request(img_req, img_extents, num_img_extents,
-				    &fctx);
-}
-
-static int rbd_img_fill_from_bvecs(struct rbd_img_request *img_req,
-				   struct ceph_file_extent *img_extents,
-				   u32 num_img_extents,
-				   struct bio_vec *bvecs)
-{
-	struct ceph_bvec_iter it = {
-		.bvecs = bvecs,
-		.iter = { .bi_size = ceph_file_extents_bytes(img_extents,
-							     num_img_extents) },
-	};
-
-	return __rbd_img_fill_from_bvecs(img_req, img_extents, num_img_extents,
-					 &it);
-}
-
 static void rbd_img_handle_request_work(struct work_struct *work)
 {
 	struct rbd_img_request *img_req =
@@ -2791,7 +2701,7 @@ static int rbd_obj_read_object(struct rbd_obj_request *obj_req)
 
 	osd_req_op_extent_init(osd_req, 0, CEPH_OSD_OP_READ,
 			       obj_req->ex.oe_off, obj_req->ex.oe_len, 0, 0);
-	rbd_osd_setup_data(osd_req, 0);
+	osd_req_op_extent_osd_databuf(osd_req, 0, obj_req->dbuf);
 	rbd_osd_format_read(osd_req);
 
 	ret = ceph_osdc_alloc_messages(osd_req, GFP_NOIO);
@@ -2802,7 +2712,13 @@ static int rbd_obj_read_object(struct rbd_obj_request *obj_req)
 	return 0;
 }
 
-static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
+/*
+ * Redirect an I/O request to the parent device.  Note that by the time we get
+ * here, the page list from the original bio chain has been decanted into a
+ * databuf struct that we can just take slices from.
+ */
+static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req,
+				    struct ceph_databuf *dbuf)
 {
 	struct rbd_img_request *img_req = obj_req->img_request;
 	struct rbd_device *parent = img_req->rbd_dev->parent;
@@ -2824,30 +2740,10 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
 	dout("%s child_img_req %p for obj_req %p\n", __func__, child_img_req,
 	     obj_req);
 
-	if (!rbd_img_is_write(img_req)) {
-		switch (img_req->data_type) {
-		case OBJ_REQUEST_BIO:
-			ret = __rbd_img_fill_from_bio(child_img_req,
-						      obj_req->img_extents,
-						      obj_req->num_img_extents,
-						      &obj_req->bio_pos);
-			break;
-		case OBJ_REQUEST_BVECS:
-		case OBJ_REQUEST_OWN_BVECS:
-			ret = __rbd_img_fill_from_bvecs(child_img_req,
-						      obj_req->img_extents,
-						      obj_req->num_img_extents,
-						      &obj_req->bvec_pos);
-			break;
-		default:
-			BUG();
-		}
-	} else {
-		ret = rbd_img_fill_from_bvecs(child_img_req,
-					      obj_req->img_extents,
-					      obj_req->num_img_extents,
-					      obj_req->copyup_bvecs);
-	}
+	ret = rbd_img_fill_from_dbuf(child_img_req,
+				     obj_req->img_extents,
+				     obj_req->num_img_extents,
+				     dbuf);
 	if (ret) {
 		rbd_img_request_destroy(child_img_req);
 		return ret;
@@ -2890,7 +2786,8 @@ static bool rbd_obj_advance_read(struct rbd_obj_request *obj_req, int *result)
 				return true;
 			}
 			if (obj_req->num_img_extents) {
-				ret = rbd_obj_read_from_parent(obj_req);
+				ret = rbd_obj_read_from_parent(obj_req,
+							       obj_req->dbuf);
 				if (ret) {
 					*result = ret;
 					return true;
@@ -3004,23 +2901,6 @@ static int rbd_obj_write_object(struct rbd_obj_request *obj_req)
 	return 0;
 }
 
-/*
- * copyup_bvecs pages are never highmem pages
- */
-static bool is_zero_bvecs(struct bio_vec *bvecs, u32 bytes)
-{
-	struct ceph_bvec_iter it = {
-		.bvecs = bvecs,
-		.iter = { .bi_size = bytes },
-	};
-
-	ceph_bvec_iter_advance_step(&it, bytes, ({
-		if (memchr_inv(bvec_virt(&bv), 0, bv.bv_len))
-			return false;
-	}));
-	return true;
-}
-
 #define MODS_ONLY	U32_MAX
 
 static int rbd_obj_copyup_empty_snapc(struct rbd_obj_request *obj_req,
@@ -3084,30 +2964,18 @@ static int rbd_obj_copyup_current_snapc(struct rbd_obj_request *obj_req,
 	return 0;
 }
 
-static int setup_copyup_bvecs(struct rbd_obj_request *obj_req, u64 obj_overlap)
+static int setup_copyup_buf(struct rbd_obj_request *obj_req, u64 obj_overlap)
 {
-	u32 i;
-
-	rbd_assert(!obj_req->copyup_bvecs);
-	obj_req->copyup_bvec_count = calc_pages_for(0, obj_overlap);
-	obj_req->copyup_bvecs = kcalloc(obj_req->copyup_bvec_count,
-					sizeof(*obj_req->copyup_bvecs),
-					GFP_NOIO);
-	if (!obj_req->copyup_bvecs)
-		return -ENOMEM;
-
-	for (i = 0; i < obj_req->copyup_bvec_count; i++) {
-		unsigned int len = min(obj_overlap, (u64)PAGE_SIZE);
-		struct page *page = alloc_page(GFP_NOIO);
+	struct ceph_databuf *dbuf;
 
-		if (!page)
-			return -ENOMEM;
+	rbd_assert(!obj_req->copyup_buf);
 
-		bvec_set_page(&obj_req->copyup_bvecs[i], page, len, 0);
-		obj_overlap -= len;
-	}
+	dbuf = ceph_databuf_req_alloc(calc_pages_for(0, obj_overlap),
+				      obj_overlap, GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
-	rbd_assert(!obj_overlap);
+	obj_req->copyup_buf = dbuf;
 	return 0;
 }
 
@@ -3134,11 +3002,11 @@ static int rbd_obj_copyup_read_parent(struct rbd_obj_request *obj_req)
 		return rbd_obj_copyup_current_snapc(obj_req, MODS_ONLY);
 	}
 
-	ret = setup_copyup_bvecs(obj_req, rbd_obj_img_extents_bytes(obj_req));
+	ret = setup_copyup_buf(obj_req, rbd_obj_img_extents_bytes(obj_req));
 	if (ret)
 		return ret;
 
-	return rbd_obj_read_from_parent(obj_req);
+	return rbd_obj_read_from_parent(obj_req, obj_req->copyup_buf);
 }
 
 static void rbd_obj_copyup_object_maps(struct rbd_obj_request *obj_req)
@@ -3241,8 +3109,8 @@ static bool rbd_obj_advance_copyup(struct rbd_obj_request *obj_req, int *result)
 		if (*result)
 			return true;
 
-		if (is_zero_bvecs(obj_req->copyup_bvecs,
-				  rbd_obj_img_extents_bytes(obj_req))) {
+		if (ceph_databuf_is_all_zero(obj_req->copyup_buf,
+					     rbd_obj_img_extents_bytes(obj_req))) {
 			dout("%s %p detected zeros\n", __func__, obj_req);
 			obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ZEROS;
 		}
diff --git a/include/linux/ceph/databuf.h b/include/linux/ceph/databuf.h
index 14c7a6449467..54b76d0c91a0 100644
--- a/include/linux/ceph/databuf.h
+++ b/include/linux/ceph/databuf.h
@@ -5,6 +5,7 @@
 #include <asm/byteorder.h>
 #include <linux/refcount.h>
 #include <linux/blk_types.h>
+#include <linux/iov_iter.h>
 
 struct ceph_databuf {
 	struct bio_vec	*bvec;		/* List of pages */
@@ -128,4 +129,25 @@ static inline void ceph_databuf_enc_stop(struct ceph_databuf *dbuf, void *p)
 	BUG_ON(dbuf->iter.count > dbuf->limit);
 }
 
+static __always_inline
+size_t ceph_databuf_scan_for_nonzero(void *iter_from, size_t progress,
+				     size_t len, void *priv, void *priv2)
+{
+	void *p;
+
+	p = memchr_inv(iter_from, 0, len);
+	return p ? p - iter_from : 0;
+}
+
+/*
+ * Scan a buffer to see if it contains only zeros.
+ */
+static inline bool ceph_databuf_is_all_zero(struct ceph_databuf *dbuf, size_t count)
+{
+	struct iov_iter iter_copy = dbuf->iter;
+
+	return iterate_bvec(&iter_copy, count, NULL, NULL,
+			    ceph_databuf_scan_for_nonzero) == count;
+}
+
 #endif /* __FS_CEPH_DATABUF_H */
diff --git a/include/linux/ceph/striper.h b/include/linux/ceph/striper.h
index 3486636c0e6e..50bc1b88c5c4 100644
--- a/include/linux/ceph/striper.h
+++ b/include/linux/ceph/striper.h
@@ -4,6 +4,7 @@
 
 #include <linux/list.h>
 #include <linux/types.h>
+#include <linux/bug.h>
 
 struct ceph_file_layout;
 
@@ -39,10 +40,6 @@ int ceph_file_to_extents(struct ceph_file_layout *l, u64 off, u64 len,
 			 void *alloc_arg,
 			 ceph_object_extent_fn_t action_fn,
 			 void *action_arg);
-int ceph_iterate_extents(struct ceph_file_layout *l, u64 off, u64 len,
-			 struct list_head *object_extents,
-			 ceph_object_extent_fn_t action_fn,
-			 void *action_arg);
 
 struct ceph_file_extent {
 	u64 fe_off;
@@ -68,4 +65,57 @@ int ceph_extent_to_file(struct ceph_file_layout *l,
 
 u64 ceph_get_num_objects(struct ceph_file_layout *l, u64 size);
 
+static __always_inline
+struct ceph_object_extent *ceph_lookup_containing(struct list_head *object_extents,
+						  u64 objno, u64 objoff, u32 xlen)
+{
+	struct ceph_object_extent *ex;
+
+	list_for_each_entry(ex, object_extents, oe_item) {
+		if (ex->oe_objno == objno &&
+		    ex->oe_off <= objoff &&
+		    ex->oe_off + ex->oe_len >= objoff + xlen) /* paranoia */
+			return ex;
+
+		if (ex->oe_objno > objno)
+			break;
+	}
+
+	return NULL;
+}
+
+/*
+ * A stripped down, non-allocating version of ceph_file_to_extents(),
+ * for when @object_extents is already populated.
+ */
+static __always_inline
+int ceph_iterate_extents(struct ceph_file_layout *l, u64 off, u64 len,
+			 struct list_head *object_extents,
+			 ceph_object_extent_fn_t action_fn,
+			 void *action_arg)
+{
+	while (len) {
+		struct ceph_object_extent *ex;
+		u64 objno, objoff;
+		u32 xlen;
+
+		ceph_calc_file_object_mapping(l, off, len, &objno, &objoff,
+					      &xlen);
+
+		ex = ceph_lookup_containing(object_extents, objno, objoff, xlen);
+		if (!ex) {
+			WARN(1, "%s: objno %llu %llu~%u not found!\n",
+			     __func__, objno, objoff, xlen);
+			return -EINVAL;
+		}
+
+		action_fn(ex, xlen, action_arg);
+
+		off += xlen;
+		len -= xlen;
+	}
+
+	return 0;
+}
+
 #endif
diff --git a/net/ceph/striper.c b/net/ceph/striper.c
index 3b3fa75d1189..3dedbf018fa6 100644
--- a/net/ceph/striper.c
+++ b/net/ceph/striper.c
@@ -70,25 +70,6 @@ lookup_last(struct list_head *object_extents, u64 objno,
 	return NULL;
 }
 
-static struct ceph_object_extent *
-lookup_containing(struct list_head *object_extents, u64 objno,
-		  u64 objoff, u32 xlen)
-{
-	struct ceph_object_extent *ex;
-
-	list_for_each_entry(ex, object_extents, oe_item) {
-		if (ex->oe_objno == objno &&
-		    ex->oe_off <= objoff &&
-		    ex->oe_off + ex->oe_len >= objoff + xlen) /* paranoia */
-			return ex;
-
-		if (ex->oe_objno > objno)
-			break;
-	}
-
-	return NULL;
-}
-
 /*
  * Map a file extent to a sorted list of object extents.
  *
@@ -167,40 +148,6 @@ int ceph_file_to_extents(struct ceph_file_layout *l, u64 off, u64 len,
 }
 EXPORT_SYMBOL(ceph_file_to_extents);
 
-/*
- * A stripped down, non-allocating version of ceph_file_to_extents(),
- * for when @object_extents is already populated.
- */
-int ceph_iterate_extents(struct ceph_file_layout *l, u64 off, u64 len,
-			 struct list_head *object_extents,
-			 ceph_object_extent_fn_t action_fn,
-			 void *action_arg)
-{
-	while (len) {
-		struct ceph_object_extent *ex;
-		u64 objno, objoff;
-		u32 xlen;
-
-		ceph_calc_file_object_mapping(l, off, len, &objno, &objoff,
-					      &xlen);
-
-		ex = lookup_containing(object_extents, objno, objoff, xlen);
-		if (!ex) {
-			WARN(1, "%s: objno %llu %llu~%u not found!\n",
-			     __func__, objno, objoff, xlen);
-			return -EINVAL;
-		}
-
-		action_fn(ex, xlen, action_arg);
-
-		off += xlen;
-		len -= xlen;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(ceph_iterate_extents);
-
 /*
  * Reverse map an object extent to a sorted list of file extents.
  *


