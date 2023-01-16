Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C366D2E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjAPXP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjAPXPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0976B30291
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ca3YM5+ZDMsvf+3X9heZWXQBMUIpoxlz5ebJhHm9RTk=;
        b=KlzW+pwSV+5h8RTTmeXeVrKhYRBr5PmtIp7cV3vmeaD9RtuIP6ANSAS0QmLudp1MUfPj+I
        u1evxV15xxYaj9OUDGSCcjnQVXR0uLdpNHlf1DN+wQKmA3pEBpxxTEvH9D2ANJ3sV2lg9C
        LP9Bzq6uiwMcPNUNEP9El0amQZYqA4E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-t5zTBbIRNZmpiJVxDWfEjg-1; Mon, 16 Jan 2023 18:10:35 -0500
X-MC-Unique: t5zTBbIRNZmpiJVxDWfEjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9D3F3C0F42B;
        Mon, 16 Jan 2023 23:10:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE0491121315;
        Mon, 16 Jan 2023 23:10:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 21/34] 9p: Pin pages rather than ref'ing if appropriate
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:10:32 +0000
Message-ID: <167391063242.2311931.3275290816918213423.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

 net/9p/trans_common.c |    6 ++-
 net/9p/trans_common.h |    3 +-
 net/9p/trans_virtio.c |   89 ++++++++++++++-----------------------------------
 3 files changed, 31 insertions(+), 67 deletions(-)

diff --git a/net/9p/trans_common.c b/net/9p/trans_common.c
index c827f694551c..31d133412677 100644
--- a/net/9p/trans_common.c
+++ b/net/9p/trans_common.c
@@ -12,13 +12,15 @@
  * p9_release_pages - Release pages after the transaction.
  * @pages: array of pages to be put
  * @nr_pages: size of array
+ * @cleanup_mode: How to clean up the pages.
  */
-void p9_release_pages(struct page **pages, int nr_pages)
+void p9_release_pages(struct page **pages, int nr_pages,
+		      unsigned int cleanup_mode)
 {
 	int i;
 
 	for (i = 0; i < nr_pages; i++)
 		if (pages[i])
-			put_page(pages[i]);
+			page_put_unpin(pages[i], cleanup_mode);
 }
 EXPORT_SYMBOL(p9_release_pages);
diff --git a/net/9p/trans_common.h b/net/9p/trans_common.h
index 32134db6abf3..9b20eb4f2359 100644
--- a/net/9p/trans_common.h
+++ b/net/9p/trans_common.h
@@ -4,4 +4,5 @@
  * Author Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>
  */
 
-void p9_release_pages(struct page **pages, int nr_pages);
+void p9_release_pages(struct page **pages, int nr_pages,
+		      unsigned int cleanup_mode);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index eb28b54fe5f6..561f7cbd79da 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -310,73 +310,34 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 			       struct iov_iter *data,
 			       int count,
 			       size_t *offs,
-			       int *need_drop,
+			       int *cleanup_mode,
 			       unsigned int gup_flags)
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
-		n = iov_iter_get_pages_alloc(data, pages, count, offs,
-					     gup_flags);
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
+	n = iov_iter_extract_pages(data, pages, count, offs, gup_flags);
+	if (n < 0)
+		return n;
+	*cleanup_mode = iov_iter_extract_mode(data, gup_flags);
+	nr_pages = DIV_ROUND_UP(n + *offs, PAGE_SIZE);
+	atomic_add(nr_pages, &vp_pinned);
+	return n;
 }
 
 static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
@@ -431,7 +392,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
 	size_t offs;
-	int need_drop = 0;
+	int cleanup_mode = 0;
 	int kicked = 0;
 
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
@@ -439,7 +400,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	if (uodata) {
 		__le32 sz;
 		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
-					    outlen, &offs, &need_drop,
+					    outlen, &offs, &cleanup_mode,
 					    FOLL_DEST_BUF);
 		if (n < 0) {
 			err = n;
@@ -459,7 +420,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		memcpy(&req->tc.sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
 		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
-					    inlen, &offs, &need_drop,
+					    inlen, &offs, &cleanup_mode,
 					    FOLL_SOURCE_BUF);
 		if (n < 0) {
 			err = n;
@@ -546,14 +507,14 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	 * Non kernel buffers are pinned, unpin them
 	 */
 err_out:
-	if (need_drop) {
+	if (cleanup_mode) {
 		if (in_pages) {
 			p9_release_pages(in_pages, in_nr_pages);
-			atomic_sub(in_nr_pages, &vp_pinned);
+			atomic_sub(in_nr_pages, &vp_pinned, cleanup_mode);
 		}
 		if (out_pages) {
 			p9_release_pages(out_pages, out_nr_pages);
-			atomic_sub(out_nr_pages, &vp_pinned);
+			atomic_sub(out_nr_pages, &vp_pinned, cleanup_mode);
 		}
 		/* wakeup anybody waiting for slots to pin pages */
 		wake_up(&vp_wq);


