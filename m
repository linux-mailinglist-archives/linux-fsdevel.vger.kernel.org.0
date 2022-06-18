Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B190355030D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiFRFgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiFRFgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:36:01 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6873E68339
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FOfPqUwHsOIPaCpLaB+QW6WYhqelX7/QZQoEcNKj3Bw=; b=Lf/nijr6RqqunmCUqlyoOcVwD3
        UnBXmPcniCGoPlhEeZ8rXq8StcV6DSY4f6iE9Uu2O9lgfr4BqcMIplrWGz8XknJNRMbYIrGVnimQg
        GJqAKmsKBSD1Hzaizj8mRepSTqR8wA1F1cx55+2vJGpPZ7HYwxvCyqft+TOIY3sK3cWK8yg2qvbrW
        2IejbH0vZdg50tdT2rfkrUcaxKqv1/EgQ3s7JKEjeEyG7gq+JkLYiYMus9p2QwgjJna+E8opU8mzm
        HU0ybvOKHWgx3eQYgUEwMz7xhP/pBnPKBuqTFDqGR4sIjj/9eudQZurNChlVeXaGileRChiN4N7LC
        8dumcaYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7X-001VRj-Bb;
        Sat, 18 Jun 2022 05:35:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 27/31] 9p: convert to advancing variant of iov_iter_get_pages_alloc()
Date:   Sat, 18 Jun 2022 06:35:34 +0100
Message-Id: <20220618053538.359065-28-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

that one is somewhat clumsier than usual and needs serious testing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/9p/client.c       | 39 +++++++++++++++++++++++----------------
 net/9p/protocol.c     |  3 +--
 net/9p/trans_virtio.c |  3 ++-
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index d403085b9ef5..cb4324211561 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1491,7 +1491,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
 	int count = iov_iter_count(to);
-	int rsize, non_zc = 0;
+	int rsize, received, non_zc = 0;
 	char *dataptr;
 
 	*err = 0;
@@ -1520,36 +1520,40 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	}
 	if (IS_ERR(req)) {
 		*err = PTR_ERR(req);
+		if (!non_zc)
+			iov_iter_revert(to, count - iov_iter_count(to));
 		return 0;
 	}
 
 	*err = p9pdu_readf(&req->rc, clnt->proto_version,
-			   "D", &count, &dataptr);
+			   "D", &received, &dataptr);
 	if (*err) {
+		if (!non_zc)
+			iov_iter_revert(to, count - iov_iter_count(to));
 		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_tag_remove(clnt, req);
 		return 0;
 	}
-	if (rsize < count) {
-		pr_err("bogus RREAD count (%d > %d)\n", count, rsize);
-		count = rsize;
+	if (rsize < received) {
+		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
+		received = rsize;
 	}
 
 	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", count);
 
 	if (non_zc) {
-		int n = copy_to_iter(dataptr, count, to);
+		int n = copy_to_iter(dataptr, received, to);
 
-		if (n != count) {
+		if (n != received) {
 			*err = -EFAULT;
 			p9_tag_remove(clnt, req);
 			return n;
 		}
 	} else {
-		iov_iter_advance(to, count);
+		iov_iter_revert(to, count - received - iov_iter_count(to));
 	}
 	p9_tag_remove(clnt, req);
-	return count;
+	return received;
 }
 EXPORT_SYMBOL(p9_client_read_once);
 
@@ -1567,6 +1571,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	while (iov_iter_count(from)) {
 		int count = iov_iter_count(from);
 		int rsize = fid->iounit;
+		int written;
 
 		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
@@ -1584,27 +1589,29 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 					    offset, rsize, from);
 		}
 		if (IS_ERR(req)) {
+			iov_iter_revert(from, count - iov_iter_count(from));
 			*err = PTR_ERR(req);
 			break;
 		}
 
-		*err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &count);
+		*err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &written);
 		if (*err) {
+			iov_iter_revert(from, count - iov_iter_count(from));
 			trace_9p_protocol_dump(clnt, &req->rc);
 			p9_tag_remove(clnt, req);
 			break;
 		}
-		if (rsize < count) {
-			pr_err("bogus RWRITE count (%d > %d)\n", count, rsize);
-			count = rsize;
+		if (rsize < written) {
+			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+			written = rsize;
 		}
 
 		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", count);
 
 		p9_tag_remove(clnt, req);
-		iov_iter_advance(from, count);
-		total += count;
-		offset += count;
+		iov_iter_revert(from, count - written - iov_iter_count(from));
+		total += written;
+		offset += written;
 	}
 	return total;
 }
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 3754c33e2974..83694c631989 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -63,9 +63,8 @@ static size_t
 pdu_write_u(struct p9_fcall *pdu, struct iov_iter *from, size_t size)
 {
 	size_t len = min(pdu->capacity - pdu->size, size);
-	struct iov_iter i = *from;
 
-	if (!copy_from_iter_full(&pdu->sdata[pdu->size], len, &i))
+	if (!copy_from_iter_full(&pdu->sdata[pdu->size], len, from))
 		len = 0;
 
 	pdu->size += len;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 2a210c2f8e40..1977d33475fe 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -331,7 +331,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 			if (err == -ERESTARTSYS)
 				return err;
 		}
-		n = iov_iter_get_pages_alloc(data, pages, count, offs);
+		n = iov_iter_get_pages_alloc2(data, pages, count, offs);
 		if (n < 0)
 			return n;
 		*need_drop = 1;
@@ -373,6 +373,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 				(*pages)[index] = kmap_to_page(p);
 			p += PAGE_SIZE;
 		}
+		iov_iter_advance(data, len);
 		return len;
 	}
 }
-- 
2.30.2

