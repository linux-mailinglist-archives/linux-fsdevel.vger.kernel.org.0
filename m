Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521DA743ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjF3P20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjF3P1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A584207
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvuuosyDox1jyrnioRFOxuFzcr1YzhZJrvdziq8YYeo=;
        b=iBVm5BIW/0PO04q+0fiu7L2WH+gUO/4Wtovo/13kDQVQgF0vqe6cccnpcVY28E8+0d2Fv2
        AWq/wdH0w3OnU8QrYKg7sM8HkCNUQbfaen5565fSLRqngExTvFqoruNN01Mhq/0eyRI5iV
        x7h+LAVDyVvtNYYaNHWtLR/mt9dXxQU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-n-OmuebeNTmap1grquelDQ-1; Fri, 30 Jun 2023 11:26:00 -0400
X-MC-Unique: n-OmuebeNTmap1grquelDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5340229AA2CC;
        Fri, 30 Jun 2023 15:25:59 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7DBB14682FA;
        Fri, 30 Jun 2023 15:25:56 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net
Subject: [RFC PATCH 10/11] 9p: Pin pages rather than ref'ing if appropriate
Date:   Fri, 30 Jun 2023 16:25:23 +0100
Message-ID: <20230630152524.661208-11-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the 9p filesystem to use iov_iter_extract_pages() instead of
iov_iter_get_pages().  This will pin pages or leave them unaltered rather
than getting a ref on them as appropriate to the iterator.

The pages need to be pinned for DIO-read rather than having refs taken on
them to prevent VM copy-on-write from malfunctioning during a concurrent
fork() (the result of the I/O would otherwise end up only visible to the
child process and not the parent).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Eric Van Hensbergen <ericvh@gmail.com>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs-developer@lists.sourceforge.net
---
 net/9p/trans_common.c |  8 ++--
 net/9p/trans_common.h |  2 +-
 net/9p/trans_virtio.c | 92 ++++++++++++++-----------------------------
 3 files changed, 34 insertions(+), 68 deletions(-)

diff --git a/net/9p/trans_common.c b/net/9p/trans_common.c
index c827f694551c..4342de18f08b 100644
--- a/net/9p/trans_common.c
+++ b/net/9p/trans_common.c
@@ -9,16 +9,16 @@
 #include "trans_common.h"
 
 /**
- * p9_release_pages - Release pages after the transaction.
+ * p9_unpin_pages - Unpin pages after the transaction.
  * @pages: array of pages to be put
  * @nr_pages: size of array
  */
-void p9_release_pages(struct page **pages, int nr_pages)
+void p9_unpin_pages(struct page **pages, int nr_pages)
 {
 	int i;
 
 	for (i = 0; i < nr_pages; i++)
 		if (pages[i])
-			put_page(pages[i]);
+			unpin_user_page(pages[i]);
 }
-EXPORT_SYMBOL(p9_release_pages);
+EXPORT_SYMBOL(p9_unpin_pages);
diff --git a/net/9p/trans_common.h b/net/9p/trans_common.h
index 32134db6abf3..fd94c48aba5b 100644
--- a/net/9p/trans_common.h
+++ b/net/9p/trans_common.h
@@ -4,4 +4,4 @@
  * Author Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>
  */
 
-void p9_release_pages(struct page **pages, int nr_pages);
+void p9_unpin_pages(struct page **pages, int nr_pages);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 3c27ffb781e3..93569de2bdba 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -310,71 +310,35 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 			       struct iov_iter *data,
 			       int count,
 			       size_t *offs,
-			       int *need_drop)
+			       bool *need_unpin,
+			       iov_iter_extraction_t extraction_flags)
 {
 	int nr_pages;
 	int err;
+	int n;
 
 	if (!iov_iter_count(data))
 		return 0;
 
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
+	/*
+	 * We allow only p9_max_pages pinned. We wait for the
+	 * Other zc request to finish here
+	 */
+	if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
+		err = wait_event_killable(vp_wq,
+					  (atomic_read(&vp_pinned) < chan->p9_max_pages));
+		if (err == -ERESTARTSYS)
+			return err;
 	}
+
+	n = iov_iter_extract_pages(data, pages, count, INT_MAX,
+				   extraction_flags, offs);
+	if (n < 0)
+		return n;
+	*need_unpin = iov_iter_extract_will_pin(data);
+	nr_pages = DIV_ROUND_UP(n + *offs, PAGE_SIZE);
+	atomic_add(nr_pages, &vp_pinned);
+	return n;
 }
 
 static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
@@ -429,7 +393,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
 	size_t offs;
-	int need_drop = 0;
+	bool need_unpin;
 	int kicked = 0;
 
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
@@ -437,7 +401,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	if (uodata) {
 		__le32 sz;
 		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
-					    outlen, &offs, &need_drop);
+					    outlen, &offs, &need_unpin,
+					    WRITE_FROM_ITER);
 		if (n < 0) {
 			err = n;
 			goto err_out;
@@ -456,7 +421,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		memcpy(&req->tc.sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
 		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
-					    inlen, &offs, &need_drop);
+					    inlen, &offs, &need_unpin,
+					    READ_INTO_ITER);
 		if (n < 0) {
 			err = n;
 			goto err_out;
@@ -542,13 +508,13 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	 * Non kernel buffers are pinned, unpin them
 	 */
 err_out:
-	if (need_drop) {
+	if (need_unpin) {
 		if (in_pages) {
-			p9_release_pages(in_pages, in_nr_pages);
+			p9_unpin_pages(in_pages, in_nr_pages);
 			atomic_sub(in_nr_pages, &vp_pinned);
 		}
 		if (out_pages) {
-			p9_release_pages(out_pages, out_nr_pages);
+			p9_unpin_pages(out_pages, out_nr_pages);
 			atomic_sub(out_nr_pages, &vp_pinned);
 		}
 		/* wakeup anybody waiting for slots to pin pages */

