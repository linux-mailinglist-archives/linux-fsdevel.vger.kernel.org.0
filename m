Return-Path: <linux-fsdevel+bounces-71250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543DCBB0A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 16:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6BB930715C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975F25A642;
	Sat, 13 Dec 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4oE8dI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C571E0083;
	Sat, 13 Dec 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765638477; cv=none; b=b9Vg6Qn3mVAQ+4vuJ3Ltei9jLabZKo/we3v5Fxol9JorGHTit7MKVSVLweCEV+O42KpIhgno4CcmDK87owuXDx+MRqYWhXMq2LC7pd/wYWPOXf16aa9drclroFfSF2DrwdjBVMnzZMU/MtEj8QF5wYOsqz9bhzdGYtdXU2N7Nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765638477; c=relaxed/simple;
	bh=hV+fVAkXx21bnBJnafUl9T+Z2pT+w60bVs64/hSiUBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cChDmJcK7yaWodSl8+U8/kwJNWo2PGUJk10JAr+d2QyWJ5uJOrwAeJ/UtzYhS043HpQhL4omqF/w6a2QadkBCMoJT+KH5Pl3Na9N3ZR6tOttXlinWu405JS7qPJz2DFBEQmgXLmqv2wTg6OeLGCR8Cl9eG+/ghyslUf/46M74Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4oE8dI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D26CC4CEF7;
	Sat, 13 Dec 2025 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765638477;
	bh=hV+fVAkXx21bnBJnafUl9T+Z2pT+w60bVs64/hSiUBs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=m4oE8dI6u1MR5csVMHHmwtPvWFXm8VUGTEYaWf9PW8W2qGnfxBylvsdjfrnP01Az6
	 5+fNn7yFT9LsGzWC9JYQunJcImOk6f5ohEoS+gCWoSbf1DDQ7P6p3PLH9BuC4liWRJ
	 SfdN9q+Pp8yDh3/dxhA66Mwf5wJseK0GL25kJy0UcZqNQKe7YP7/xEMVOUmartkqdB
	 YUkhs9fIDKricCrYjuS9cZOmx7KE9MY5z1nS31kILKlebE2VcEE35hB97uUwJSYIxd
	 Qi4uU5kDlDYrm4ARtpTG6Gcyak7Ia8xCRTwguzEr+UbGc7yG3JGE7Z1ZdC1PwJ/Bhd
	 3R9cDiS9tJmCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF5D59F76;
	Sat, 13 Dec 2025 15:07:57 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Sun, 14 Dec 2025 00:07:40 +0900
Subject: [PATCH RFC v2] 9p/virtio: convert to extract_iter_to_sg()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQqDMBBFryKzbooZ0WpXhUIP0G0RUTPVQTBlE
 tIWyd0bPECX73/++xs4EiYH52wDocCO7ZoADxmMc79OpNgkBsyx1KhzFVg8285Lv7qOPYkqm1N
 RN2gGpALS7iX05M/ufMD9doU2hTM7b+W7/wS9V3+UQSutGiSiytRDZYbLaA29hcblaGWCNsb4A
 yXYfvy7AAAA
X-Change-ID: 20251210-virtio_trans_iter-5973892db2e3
To: Christoph Hellwig <hch@infradead.org>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
 linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12124;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=GwOvHPpLIJFE+1G5vCiZ0kWzpIXlClpZQCUB71qyD8A=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBpPYFLk6qfs8VDrqffJItsdf6/f5+3mhoYVCOZS
 FfpyASI4q+JAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaT2BSwAKCRCrTpvsapjm
 cHDnEACHONf9k9QdEOYGqnmfVpGES5RWau3Pv03IKASAOej4OvxxYjjZ2vMGJehpYaHSDRHcDlM
 5RdYmCNBNZ9QAjSyMAtSKjmi5Hz6X7g4SBjt1xOtm/xNnZh1AYbelS40Knc43zquI5JaVMa0F5K
 d2R7ENroWmS/DY77UlfaZNUHYhfao8HmgU0IiLr/eyAXyugYpSQkU0RKEJqaiKYIc/SKwQ7BKLC
 tBX7knnOrbJ4vY/AQqjdmRWRvzwoi5NCLnI9LTmmOD+DJCI5AMiPVZb+IHedSKjL3CQrSvuNpxF
 91XL/AclnT08aSzCQlinPQMDuVpXWZbJx4GZBIFT+RYKi+7ANA1jrRfdvMmZekZIb7CXX5l2T9b
 2QkWcSxWoEPBnY1geYvOirm5hkw6UiUsTg4i67mXn4GAqIWV2i85S3QnyocBzHPk+TgyPGjwweE
 p1Ss81CWKpxQXFIqb823MPkkziHP/YIFJ4oUm6uoxv5jP6UCvRI3TgCyAh0e0+Zdl7t2D5f2BIT
 /jZ8guKwgAEoSPn7l2GgE8eoWCuAvOncUdlQja0aGfyifAxDLRjbdzos8CVpjhjmIkaIvuGN9RZ
 uReIxyWw/CJukCJehZTEY8+UL7QFVib2vVTrDvSglFWfp9SV5G24Di8PRozmV5k5k9SOCjebEy9
 mqm9edJfrXbOHmA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

This simplifies the code quite a bit and should fix issues with
blowing up when iov_iter points at kmalloc data

RFC - Not really tested yet!!

This brings two major changes to how we've always done things with
virtio 9p though:
- We no longer fill in "chan->sg" with user data, but instead allocate a
  scatterlist; this should not be a problem nor a slowdown as previous
  code would allocate a page list instead, the main difference is that
  this might eventually lead to lifting the 512KB msize limit if
  compatible with virtio?
- we no longer keep track of how many pages have been pinned, so no
  longer block on p9_max_pages pages pinned -- the limit was
  `nr_free_buffer_pages()/4;` at the time of driver probe which is
  rather arbitrary, it might not really be required? A user could try to
  lock memory by issuing IO faster than virtio can handle...
  We could just assume all requests come from users and count everything
  if that turned out to be useful...

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Changes in v2:
- Full rewrite to use extract_iter_to_sg(), marked as RFC as not really
  tested. This appears to work under basic IO, but I really didn't test
  anything that might stress the limits at all...
  Please have a look and yell if I did anything that looks too unholy
  here!
- Link to v1: https://lore.kernel.org/r/20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org
---
 net/9p/trans_virtio.c | 211 +++++++++++++-------------------------------------
 1 file changed, 52 insertions(+), 159 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 10c2dd48643818907f4370243eb971fceba4d40b..37b5cf30f8b6b4347ca47b9e840945c838234ecd 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -39,8 +39,6 @@
 
 /* a single mutex to manage channel initialization and attachment */
 static DEFINE_MUTEX(virtio_9p_lock);
-static DECLARE_WAIT_QUEUE_HEAD(vp_wq);
-static atomic_t vp_pinned = ATOMIC_INIT(0);
 
 /**
  * struct virtio_chan - per-instance transport information
@@ -51,7 +49,6 @@ static atomic_t vp_pinned = ATOMIC_INIT(0);
  * @vq: virtio queue associated with this channel
  * @ring_bufs_avail: flag to indicate there is some available in the ring buf
  * @vc_wq: wait queue for waiting for thing to be added to ring buf
- * @p9_max_pages: maximum number of pinned pages
  * @sg: scatter gather list which is used to pack a request (protected?)
  * @chan_list: linked list of channels
  *
@@ -71,10 +68,6 @@ struct virtio_chan {
 	struct virtqueue *vq;
 	int ring_bufs_avail;
 	wait_queue_head_t *vc_wq;
-	/* This is global limit. Since we don't have a global structure,
-	 * will be placing it in each channel.
-	 */
-	unsigned long p9_max_pages;
 	/* Scatterlist: can be too big for stack. */
 	struct scatterlist sg[VIRTQUEUE_NUM];
 	/**
@@ -202,48 +195,6 @@ static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t *req)
 	return 0;
 }
 
-/**
- * pack_sg_list_p - Just like pack_sg_list. Instead of taking a buffer,
- * this takes a list of pages.
- * @sg: scatter/gather list to pack into
- * @start: which segment of the sg_list to start at
- * @limit: maximum number of pages in sg list.
- * @pdata: a list of pages to add into sg.
- * @nr_pages: number of pages to pack into the scatter/gather list
- * @offs: amount of data in the beginning of first page _not_ to pack
- * @count: amount of data to pack into the scatter/gather list
- */
-static int
-pack_sg_list_p(struct scatterlist *sg, int start, int limit,
-	       struct page **pdata, int nr_pages, size_t offs, int count)
-{
-	int i = 0, s;
-	int data_off = offs;
-	int index = start;
-
-	BUG_ON(nr_pages > (limit - start));
-	/*
-	 * if the first page doesn't start at
-	 * page boundary find the offset
-	 */
-	while (nr_pages) {
-		s = PAGE_SIZE - data_off;
-		if (s > count)
-			s = count;
-		BUG_ON(index >= limit);
-		/* Make sure we don't terminate early. */
-		sg_unmark_end(&sg[index]);
-		sg_set_page(&sg[index++], pdata[i++], s, data_off);
-		data_off = 0;
-		count -= s;
-		nr_pages--;
-	}
-
-	if (index-start)
-		sg_mark_end(&sg[index - 1]);
-	return index - start;
-}
-
 /**
  * p9_virtio_request - issue a request
  * @client: client instance issuing the request
@@ -305,86 +256,15 @@ p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 	return 0;
 }
 
-static int p9_get_mapped_pages(struct virtio_chan *chan,
-			       struct page ***pages,
-			       struct iov_iter *data,
-			       int count,
-			       size_t *offs,
-			       int *need_drop)
-{
-	int nr_pages;
-	int err;
-
-	if (!iov_iter_count(data))
-		return 0;
-
-	if (!iov_iter_is_kvec(data)) {
-		int n;
-		/*
-		 * We allow only p9_max_pages pinned. We wait for the
-		 * Other zc request to finish here
-		 */
-		if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
-			err = wait_event_killable(vp_wq,
-			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
-			if (err == -ERESTARTSYS)
-				return err;
-		}
-		n = iov_iter_get_pages_alloc2(data, pages, count, offs);
-		if (n < 0)
-			return n;
-		*need_drop = 1;
-		nr_pages = DIV_ROUND_UP(n + *offs, PAGE_SIZE);
-		atomic_add(nr_pages, &vp_pinned);
-		return n;
-	} else {
-		/* kernel buffer, no need to pin pages */
-		int index;
-		size_t len;
-		void *p;
-
-		/* we'd already checked that it's non-empty */
-		while (1) {
-			len = iov_iter_single_seg_count(data);
-			if (likely(len)) {
-				p = data->kvec->iov_base + data->iov_offset;
-				break;
-			}
-			iov_iter_advance(data, 0);
-		}
-		if (len > count)
-			len = count;
-
-		nr_pages = DIV_ROUND_UP((unsigned long)p + len, PAGE_SIZE) -
-			   (unsigned long)p / PAGE_SIZE;
-
-		*pages = kmalloc_array(nr_pages, sizeof(struct page *),
-				       GFP_NOFS);
-		if (!*pages)
-			return -ENOMEM;
-
-		*need_drop = 0;
-		p -= (*offs = offset_in_page(p));
-		for (index = 0; index < nr_pages; index++) {
-			if (is_vmalloc_addr(p))
-				(*pages)[index] = vmalloc_to_page(p);
-			else
-				(*pages)[index] = kmap_to_page(p);
-			p += PAGE_SIZE;
-		}
-		iov_iter_advance(data, len);
-		return len;
-	}
-}
-
 static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
-			  size_t offs, struct page **pages)
+			  size_t offs, struct sg_table *sg_table)
 {
 	unsigned size, n;
 	void *to = req->rc.sdata + in_hdr_len;
+	struct scatterlist *sg = sg_table->sgl;
 
 	// Fits entirely into the static data?  Nothing to do.
-	if (req->rc.size < in_hdr_len || !pages)
+	if (req->rc.size < in_hdr_len)
 		return;
 
 	// Really long error message?  Tough, truncate the reply.  Might get
@@ -398,12 +278,39 @@ static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
 	size = req->rc.size - in_hdr_len;
 	n = PAGE_SIZE - offs;
 	if (size > n) {
-		memcpy_from_page(to, *pages++, offs, n);
+		memcpy_from_page(to, sg_page(sg), offs, n);
 		offs = 0;
 		to += n;
 		size -= n;
+		if (sg_table->nents < 2)
+			return;
+		sg++;
 	}
-	memcpy_from_page(to, *pages, offs, size);
+	memcpy_from_page(to, sg_page(sg), offs, size);
+}
+
+/**
+ * compute sg_max depending on length, allocate sg_table->sgl and run
+ * extract_iter_to_sg()
+ */
+static ssize_t p9_get_mapped_sg(struct iov_iter *iter, int len,
+				struct sg_table *sg_table)
+{
+	size_t sg_max;
+	ssize_t n;
+
+	sg_max = DIV_ROUND_UP(len, PAGE_SIZE);
+	sg_table->sgl = kcalloc(sg_max, sizeof(*sg_table->sgl), GFP_NOFS);
+	if (!sg_table->sgl)
+		return -ENOMEM;
+
+	n = extract_iter_to_sg(iter, len, sg_table, sg_max, 0);
+
+	WARN_ON(n < 0);
+	if (sg_table->nents > 0)
+		sg_mark_end(&sg_table->sgl[sg_table->nents - 1]);
+
+	return n;
 }
 
 /**
@@ -424,10 +331,9 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 {
 	int in, out, err, out_sgs, in_sgs;
 	unsigned long flags;
-	int in_nr_pages = 0, out_nr_pages = 0;
-	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
+	struct sg_table sg_table = { 0 };
 	size_t offs = 0;
 	int need_drop = 0;
 	int kicked = 0;
@@ -435,14 +341,15 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
 	if (uodata) {
+		ssize_t n;
 		__le32 sz;
-		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
-					    outlen, &offs, &need_drop);
+
+		n = p9_get_mapped_sg(uodata, outlen, &sg_table);
 		if (n < 0) {
 			err = n;
 			goto err_out;
 		}
-		out_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
+		need_drop = n > 0 && iov_iter_extract_will_pin(uodata);
 		if (n != outlen) {
 			__le32 v = cpu_to_le32(n);
 			memcpy(&req->tc.sdata[req->tc.size - 4], &v, 4);
@@ -455,13 +362,14 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		sz = cpu_to_le32(req->tc.size + outlen);
 		memcpy(&req->tc.sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
-		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
-					    inlen, &offs, &need_drop);
+		ssize_t n;
+
+		n = p9_get_mapped_sg(uidata, inlen, &sg_table);
 		if (n < 0) {
 			err = n;
 			goto err_out;
 		}
-		in_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
+		need_drop = n > 0 && iov_iter_extract_will_pin(uidata);
 		if (n != inlen) {
 			__le32 v = cpu_to_le32(n);
 			memcpy(&req->tc.sdata[req->tc.size - 4], &v, 4);
@@ -481,11 +389,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	if (out)
 		sgs[out_sgs++] = chan->sg;
 
-	if (out_pages) {
-		sgs[out_sgs++] = chan->sg + out;
-		out += pack_sg_list_p(chan->sg, out, VIRTQUEUE_NUM,
-				      out_pages, out_nr_pages, offs, outlen);
-	}
+	if (uodata && outlen > 0)
+		sgs[out_sgs++] = sg_table.sgl;
 
 	/*
 	 * Take care of in data
@@ -499,11 +404,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	if (in)
 		sgs[out_sgs + in_sgs++] = chan->sg + out;
 
-	if (in_pages) {
-		sgs[out_sgs + in_sgs++] = chan->sg + out + in;
-		pack_sg_list_p(chan->sg, out + in, VIRTQUEUE_NUM,
-			       in_pages, in_nr_pages, offs, inlen);
-	}
+	if (uidata && inlen > 0)
+		sgs[out_sgs + in_sgs++] = sg_table.sgl;
 
 	BUG_ON(out_sgs + in_sgs > ARRAY_SIZE(sgs));
 	err = virtqueue_add_sgs(chan->vq, sgs, out_sgs, in_sgs, req,
@@ -535,27 +437,20 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			          READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 	// RERROR needs reply (== error string) in static data
 	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
-	    unlikely(req->rc.sdata[4] == P9_RERROR))
-		handle_rerror(req, in_hdr_len, offs, in_pages);
+	    unlikely(req->rc.sdata[4] == P9_RERROR) &&
+	    uidata && inlen > 0)
+		handle_rerror(req, in_hdr_len, offs, &sg_table);
 
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
 err_out:
 	if (need_drop) {
-		if (in_pages) {
-			p9_release_pages(in_pages, in_nr_pages);
-			atomic_sub(in_nr_pages, &vp_pinned);
-		}
-		if (out_pages) {
-			p9_release_pages(out_pages, out_nr_pages);
-			atomic_sub(out_nr_pages, &vp_pinned);
-		}
-		/* wakeup anybody waiting for slots to pin pages */
-		wake_up(&vp_wq);
+		/* from extract_user_to_sg() error cleanup code */
+		while (sg_table.nents > 0)
+			unpin_user_page(sg_page(&sg_table.sgl[--sg_table.nents]));
 	}
-	kvfree(in_pages);
-	kvfree(out_pages);
+	kfree(sg_table.sgl);
 	if (!kicked) {
 		/* reply won't come */
 		p9_req_put(client, req);
@@ -649,8 +544,6 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 	}
 	init_waitqueue_head(chan->vc_wq);
 	chan->ring_bufs_avail = 1;
-	/* Ceiling limit to avoid denial of service attacks */
-	chan->p9_max_pages = nr_free_buffer_pages()/4;
 
 	virtio_device_ready(vdev);
 

---
base-commit: 3e281113f871d7f9c69ca55a4d806a72180b7e8a
change-id: 20251210-virtio_trans_iter-5973892db2e3

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>



