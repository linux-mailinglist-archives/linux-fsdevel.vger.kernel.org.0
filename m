Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B69770115
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjHDNQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjHDNQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2A04C1C
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jKmn/KofriHujnRpuGNKBfCX7li0O6mIH1pn2l1gSE=;
        b=F276QsRA3ke7IMVAGhNW5nElSskXjvzlO42SdjefemG4QnX9XSCFltGG0euXWCI180BnDs
        IgCOisRPywNh4oPx2EgVuHGsv6pOT8F0xGOU+JJrQIXB0cMqyL0cRN26h2/Q8j4Vnv397n
        RecoO9RC+uXUBX0/RA2kP18b4cepnsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-WoH87iAKO3KrXTwUsjIBeQ-1; Fri, 04 Aug 2023 09:13:52 -0400
X-MC-Unique: WoH87iAKO3KrXTwUsjIBeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4650805951;
        Fri,  4 Aug 2023 13:13:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51BD31121325;
        Fri,  4 Aug 2023 13:13:50 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/18] rbd: Switch from using bvec_iter to iov_iter
Date:   Fri,  4 Aug 2023 14:13:19 +0100
Message-ID: <20230804131327.2574082-11-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 drivers/block/rbd.c | 421 +++++++++-----------------------------------
 fs/ceph/file.c      | 111 +++++-------
 2 files changed, 127 insertions(+), 405 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 971fa4a581cf..1756973b696f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -214,13 +214,6 @@ struct pending_result {
 
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
@@ -295,18 +288,12 @@ struct rbd_obj_request {
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
+	struct bio		*bio;
+	struct bio_vec		*bvec;
+	struct iov_iter		iter;
 
 	enum rbd_obj_copyup_state copyup_state;
-	struct bio_vec		*copyup_bvecs;
-	u32			copyup_bvec_count;
+	struct ceph_databuf	*copyup_buf;
 
 	struct list_head	osd_reqs;	/* w/ r_private_item */
 
@@ -329,8 +316,8 @@ enum rbd_img_state {
 
 struct rbd_img_request {
 	struct rbd_device	*rbd_dev;
+	bool			need_free_bvecs;
 	enum obj_operation_type	op_type;
-	enum obj_request_type	data_type;
 	unsigned long		flags;
 	enum rbd_img_state	state;
 	union {
@@ -1218,26 +1205,6 @@ static void rbd_dev_mapping_clear(struct rbd_device *rbd_dev)
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
@@ -1249,17 +1216,9 @@ static void rbd_obj_zero_range(struct rbd_obj_request *obj_req, u32 off,
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
+	iov_iter_advance(&obj_req->iter, off);
+	iov_iter_zero(bytes, &obj_req->iter);
+	iov_iter_revert(&obj_req->iter, off);
 }
 
 static void rbd_obj_request_destroy(struct kref *kref);
@@ -1484,7 +1443,6 @@ static void rbd_obj_request_destroy(struct kref *kref)
 {
 	struct rbd_obj_request *obj_request;
 	struct ceph_osd_request *osd_req;
-	u32 i;
 
 	obj_request = container_of(kref, struct rbd_obj_request, kref);
 
@@ -1497,27 +1455,10 @@ static void rbd_obj_request_destroy(struct kref *kref)
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
+	if (obj_request->img_request->need_free_bvecs)
+		kfree(obj_request->bvec);
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
 
@@ -2165,29 +2106,6 @@ static int rbd_obj_calc_img_extents(struct rbd_obj_request *obj_req,
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
@@ -2221,8 +2139,7 @@ static int rbd_osd_setup_copyup(struct ceph_osd_request *osd_req, int which,
 	if (ret)
 		return ret;
 
-	osd_req_op_cls_request_data_bvecs(osd_req, which, obj_req->copyup_bvecs,
-					  obj_req->copyup_bvec_count, bytes);
+	osd_req_op_cls_request_databuf(osd_req, which, obj_req->copyup_buf);
 	return 0;
 }
 
@@ -2254,7 +2171,7 @@ static void __rbd_osd_setup_write_ops(struct ceph_osd_request *osd_req,
 
 	osd_req_op_extent_init(osd_req, which, opcode,
 			       obj_req->ex.oe_off, obj_req->ex.oe_len, 0, 0);
-	rbd_osd_setup_data(osd_req, which);
+	osd_req_op_extent_osd_iter(osd_req, which, &obj_req->iter);
 }
 
 static int rbd_obj_init_write(struct rbd_obj_request *obj_req)
@@ -2464,20 +2381,6 @@ static int __rbd_img_fill_request(struct rbd_img_request *img_req)
 	return 0;
 }
 
-union rbd_img_fill_iter {
-	struct ceph_bio_iter	bio_iter;
-	struct ceph_bvec_iter	bvec_iter;
-};
-
-struct rbd_img_fill_ctx {
-	enum obj_request_type	pos_type;
-	union rbd_img_fill_iter	*pos;
-	union rbd_img_fill_iter	iter;
-	ceph_object_extent_fn_t	set_pos_fn;
-	ceph_object_extent_fn_t	count_fn;
-	ceph_object_extent_fn_t	copy_fn;
-};
-
 static struct ceph_object_extent *alloc_object_extent(void *arg)
 {
 	struct rbd_img_request *img_req = arg;
@@ -2491,6 +2394,19 @@ static struct ceph_object_extent *alloc_object_extent(void *arg)
 	return &obj_req->ex;
 }
 
+static void set_iter_pos(struct ceph_object_extent *ex, u32 bytes, void *arg)
+{
+	struct rbd_obj_request *obj_req =
+	    container_of(ex, struct rbd_obj_request, ex);
+	struct iov_iter *iter = arg;
+
+	dout("%s objno %llu bytes %u\n", __func__, ex->oe_objno, bytes);
+	obj_req->iter = *iter;
+	iov_iter_truncate(&obj_req->iter, bytes);
+	obj_req->iter.nr_segs = iov_iter_npages(&obj_req->iter, INT_MAX);
+	iov_iter_advance(iter, bytes);
+}
+
 /*
  * While su != os && sc == 1 is technically not fancy (it's the same
  * layout as su == os && sc == 1), we can't use the nocopy path for it
@@ -2506,25 +2422,22 @@ static bool rbd_layout_is_fancy(struct ceph_file_layout *l)
 static int rbd_img_fill_request_nocopy(struct rbd_img_request *img_req,
 				       struct ceph_file_extent *img_extents,
 				       u32 num_img_extents,
-				       struct rbd_img_fill_ctx *fctx)
+				       struct iov_iter *iter)
 {
 	u32 i;
 	int ret;
 
-	img_req->data_type = fctx->pos_type;
-
 	/*
 	 * Create object requests and set each object request's starting
-	 * position in the provided bio (list) or bio_vec array.
+	 * position in the provided iterator.
 	 */
-	fctx->iter = *fctx->pos;
 	for (i = 0; i < num_img_extents; i++) {
 		ret = ceph_file_to_extents(&img_req->rbd_dev->layout,
 					   img_extents[i].fe_off,
 					   img_extents[i].fe_len,
 					   &img_req->object_extents,
 					   alloc_object_extent, img_req,
-					   fctx->set_pos_fn, &fctx->iter);
+					   set_iter_pos, iter);
 		if (ret)
 			return ret;
 	}
@@ -2537,30 +2450,27 @@ static int rbd_img_fill_request_nocopy(struct rbd_img_request *img_req,
  * corresponding object requests (normally each to a different object,
  * but not always) and add them to @img_req.  For each object request,
  * set up its data descriptor to point to the corresponding chunk(s) of
- * @fctx->pos data buffer.
+ * @iter data buffer.
  *
  * Because ceph_file_to_extents() will merge adjacent object extents
  * together, each object request's data descriptor may point to multiple
- * different chunks of @fctx->pos data buffer.
+ * different chunks of @iter data buffer.
  *
- * @fctx->pos data buffer is assumed to be large enough.
+ * @iter data buffer is assumed to be large enough.
  */
 static int rbd_img_fill_request(struct rbd_img_request *img_req,
 				struct ceph_file_extent *img_extents,
 				u32 num_img_extents,
-				struct rbd_img_fill_ctx *fctx)
+				struct iov_iter *iter)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	struct rbd_obj_request *obj_req;
-	u32 i;
-	int ret;
 
-	if (fctx->pos_type == OBJ_REQUEST_NODATA ||
-	    !rbd_layout_is_fancy(&rbd_dev->layout))
+	if (!rbd_layout_is_fancy(&rbd_dev->layout))
 		return rbd_img_fill_request_nocopy(img_req, img_extents,
-						   num_img_extents, fctx);
+						   num_img_extents, iter);
 
-	img_req->data_type = OBJ_REQUEST_OWN_BVECS;
+	img_req->need_free_bvecs = true;
 
 	/*
 	 * Create object requests and determine ->bvec_count for each object
@@ -2569,184 +2479,48 @@ static int rbd_img_fill_request(struct rbd_img_request *img_req,
 	 * or bio_vec array because when mapped, those bio_vecs can straddle
 	 * stripe unit boundaries.
 	 */
-	fctx->iter = *fctx->pos;
-	for (i = 0; i < num_img_extents; i++) {
-		ret = ceph_file_to_extents(&rbd_dev->layout,
-					   img_extents[i].fe_off,
-					   img_extents[i].fe_len,
-					   &img_req->object_extents,
-					   alloc_object_extent, img_req,
-					   fctx->count_fn, &fctx->iter);
-		if (ret)
-			return ret;
-	}
-
 	for_each_obj_request(img_req, obj_req) {
-		obj_req->bvec_pos.bvecs = kmalloc_array(obj_req->bvec_count,
-					      sizeof(*obj_req->bvec_pos.bvecs),
-					      GFP_NOIO);
-		if (!obj_req->bvec_pos.bvecs)
+		struct iov_iter iter = obj_req->iter;
+		obj_req->bvec = (struct bio_vec *)dup_iter(&obj_req->iter, &iter, GFP_NOIO);
+		if (!obj_req->bvec)
 			return -ENOMEM;
 	}
 
-	/*
-	 * Fill in each object request's private bio_vec array, splitting and
-	 * rearranging the provided bio_vecs in stripe unit chunks as needed.
-	 */
-	fctx->iter = *fctx->pos;
-	for (i = 0; i < num_img_extents; i++) {
-		ret = ceph_iterate_extents(&rbd_dev->layout,
-					   img_extents[i].fe_off,
-					   img_extents[i].fe_len,
-					   &img_req->object_extents,
-					   fctx->copy_fn, &fctx->iter);
-		if (ret)
-			return ret;
-	}
-
 	return __rbd_img_fill_request(img_req);
 }
 
+/*
+ * Handle ranged, but dataless ops such as DISCARD and ZEROOUT.
+ */
 static int rbd_img_fill_nodata(struct rbd_img_request *img_req,
 			       u64 off, u64 len)
 {
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
+	int ret;
 
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
+	ret = ceph_file_to_extents(&img_req->rbd_dev->layout, off, len,
+				   &img_req->object_extents,
+				   alloc_object_extent, img_req,
+				   NULL, NULL);
+	if (ret)
+		return ret;
 
-	return rbd_img_fill_request(img_req, img_extents, num_img_extents,
-				    &fctx);
+	return __rbd_img_fill_request(img_req);
 }
 
+/*
+ * Set up an iterator to access the data/buffer supplied through a bio.
+ */
 static int rbd_img_fill_from_bio(struct rbd_img_request *img_req,
 				 u64 off, u64 len, struct bio *bio)
 {
 	struct ceph_file_extent ex = { off, len };
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
+	struct iov_iter iter;
 
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
+	iov_iter_bvec(&iter, READ, bio->bi_io_vec, bio->bi_vcnt,
+		      bio->bi_iter.bi_size + bio->bi_iter.bi_bvec_done);
+	iov_iter_advance(&iter, bio->bi_iter.bi_bvec_done);
 
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
+	return rbd_img_fill_request(img_req, &ex, 1, &iter);
 }
 
 static void rbd_img_handle_request_work(struct work_struct *work)
@@ -2789,7 +2563,7 @@ static int rbd_obj_read_object(struct rbd_obj_request *obj_req)
 
 	osd_req_op_extent_init(osd_req, 0, CEPH_OSD_OP_READ,
 			       obj_req->ex.oe_off, obj_req->ex.oe_len, 0, 0);
-	rbd_osd_setup_data(osd_req, 0);
+	osd_req_op_extent_osd_iter(osd_req, 0, &obj_req->iter);
 	rbd_osd_format_read(osd_req);
 
 	ret = ceph_osdc_alloc_messages(osd_req, GFP_NOIO);
@@ -2823,28 +2597,15 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
 	     obj_req);
 
 	if (!rbd_img_is_write(img_req)) {
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
+		ret = rbd_img_fill_request(child_img_req,
+					   obj_req->img_extents,
+					   obj_req->num_img_extents,
+					   &obj_req->iter);
 	} else {
-		ret = rbd_img_fill_from_bvecs(child_img_req,
-					      obj_req->img_extents,
-					      obj_req->num_img_extents,
-					      obj_req->copyup_bvecs);
+		ret = rbd_img_fill_request(img_req,
+					   obj_req->img_extents,
+					   obj_req->num_img_extents,
+					   &obj_req->copyup_buf->iter);
 	}
 	if (ret) {
 		rbd_img_request_destroy(child_img_req);
@@ -3002,21 +2763,9 @@ static int rbd_obj_write_object(struct rbd_obj_request *obj_req)
 	return 0;
 }
 
-/*
- * copyup_bvecs pages are never highmem pages
- */
-static bool is_zero_bvecs(struct bio_vec *bvecs, u32 bytes)
+static bool is_zero_bvecs(struct ceph_databuf *dbuf, size_t count)
 {
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
+	return iov_iter_is_zero(&dbuf->iter, count);
 }
 
 #define MODS_ONLY	U32_MAX
@@ -3082,30 +2831,18 @@ static int rbd_obj_copyup_current_snapc(struct rbd_obj_request *obj_req,
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
+	struct ceph_databuf *dbuf;
 
-	for (i = 0; i < obj_req->copyup_bvec_count; i++) {
-		unsigned int len = min(obj_overlap, (u64)PAGE_SIZE);
-		struct page *page = alloc_page(GFP_NOIO);
+	rbd_assert(!obj_req->copyup_buf);
 
-		if (!page)
-			return -ENOMEM;
-
-		bvec_set_page(&obj_req->copyup_bvecs[i], page, len, 0);
-		obj_overlap -= len;
-	}
+	dbuf = ceph_databuf_alloc(calc_pages_for(0, obj_overlap),
+				  obj_overlap, GFP_NOIO);
+	if (!dbuf)
+		return -ENOMEM;
 
-	rbd_assert(!obj_overlap);
+	obj_req->copyup_buf = dbuf;
 	return 0;
 }
 
@@ -3132,7 +2869,7 @@ static int rbd_obj_copyup_read_parent(struct rbd_obj_request *obj_req)
 		return rbd_obj_copyup_current_snapc(obj_req, MODS_ONLY);
 	}
 
-	ret = setup_copyup_bvecs(obj_req, rbd_obj_img_extents_bytes(obj_req));
+	ret = setup_copyup_buf(obj_req, rbd_obj_img_extents_bytes(obj_req));
 	if (ret)
 		return ret;
 
@@ -3239,7 +2976,7 @@ static bool rbd_obj_advance_copyup(struct rbd_obj_request *obj_req, int *result)
 		if (*result)
 			return true;
 
-		if (is_zero_bvecs(obj_req->copyup_bvecs,
+		if (is_zero_bvecs(obj_req->copyup_buf,
 				  rbd_obj_img_extents_bytes(obj_req))) {
 			dout("%s %p detected zeros\n", __func__, obj_req);
 			obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ZEROS;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 323e7631c7d8..5d16469a3690 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -81,11 +81,11 @@ static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flags)
  */
 #define ITER_GET_BVECS_PAGES	64
 
-static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
-				struct bio_vec *bvecs)
+static int __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
+			    struct ceph_databuf *dbuf)
 {
+	struct bio_vec *bvecs = dbuf->bvec;
 	size_t size = 0;
-	int bvec_idx = 0;
 
 	if (maxsize > iov_iter_count(iter))
 		maxsize = iov_iter_count(iter);
@@ -97,22 +97,25 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
 		int idx = 0;
 
 		bytes = iov_iter_get_pages2(iter, pages, maxsize - size,
-					   ITER_GET_BVECS_PAGES, &start);
-		if (bytes < 0)
-			return size ?: bytes;
+					    ITER_GET_BVECS_PAGES, &start);
+		if (bytes < 0) {
+			if (size == 0)
+				return bytes;
+			break;
+		}
 
-		size += bytes;
+		dbuf->length += bytes;
 
-		for ( ; bytes; idx++, bvec_idx++) {
+		while (bytes) {
 			int len = min_t(int, bytes, PAGE_SIZE - start);
 
-			bvec_set_page(&bvecs[bvec_idx], pages[idx], len, start);
+			bvec_set_page(&bvecs[dbuf->nr_bvec++], pages[idx++], len, start);
 			bytes -= len;
 			start = 0;
 		}
 	}
 
-	return size;
+	return 0;
 }
 
 /*
@@ -123,52 +126,43 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
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
+	dbuf = ceph_databuf_alloc(npages, 0, GFP_KERNEL);
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
+	iov_iter_bvec(&dbuf->iter, write ? ITER_SOURCE : ITER_DEST,
+		      dbuf->bvec, dbuf->nr_bvec, dbuf->length);
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
@@ -1262,14 +1256,11 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct ceph_osd_req_op *op = &req->r_ops[0];
 	struct ceph_client_metric *metric = &ceph_sb_to_mdsc(inode->i_sb)->metric;
-	unsigned int len = osd_data->bvec_pos.iter.bi_size;
-	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
+	size_t len = osd_data->iter.count;
+	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
 
-	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_BVECS);
-	BUG_ON(!osd_data->num_bvecs);
-
-	doutc(cl, "req %p inode %p %llx.%llx, rc %d bytes %u\n", req,
+	doutc(cl, "req %p inode %p %llx.%llx, rc %d bytes %zu\n", req,
 	      inode, ceph_vinop(inode), rc, len);
 
 	if (rc == -EOLDSNAPC) {
@@ -1291,7 +1282,6 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 		if (rc == -ENOENT)
 			rc = 0;
 		if (rc >= 0 && len > rc) {
-			struct iov_iter i;
 			int zlen = len - rc;
 
 			/*
@@ -1308,10 +1298,8 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
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
 
@@ -1325,8 +1313,8 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 						 req->r_end_latency, len, rc);
 	}
 
-	put_bvecs(osd_data->bvec_pos.bvecs, osd_data->num_bvecs,
-		  aio_req->should_dirty);
+	if (aio_req->should_dirty)
+		ceph_dirty_pages(osd_data->dbuf);
 	ceph_osdc_put_request(req);
 
 	if (rc < 0)
@@ -1415,9 +1403,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -1453,8 +1440,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 
 	while (iov_iter_count(iter) > 0) {
 		u64 size = iov_iter_count(iter);
-		ssize_t len;
 		struct ceph_osd_req_op *op;
+		size_t len;
 		int readop = sparse ?  CEPH_OSD_OP_SPARSE_READ : CEPH_OSD_OP_READ;
 
 		if (write)
@@ -1476,12 +1463,13 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			break;
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
+		len = dbuf->length;
 		if (len != size)
 			osd_req_op_extent_update(req, 0, len);
 
@@ -1516,7 +1504,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			req->r_mtime = mtime;
 		}
 
-		osd_req_op_extent_osd_data_bvecs(req, 0, bvecs, num_pages, len);
+		osd_req_op_extent_osd_databuf(req, 0, dbuf);
 		op = &req->r_ops[0];
 		if (sparse) {
 			ret = ceph_alloc_sparse_ext_map(op);
@@ -1558,20 +1546,17 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
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

