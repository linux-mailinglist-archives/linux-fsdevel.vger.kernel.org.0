Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9A543AB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 19:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiFHRlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 13:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiFHRlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:41:50 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB2366697
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TeOj6cMufxRfM72BEyadE0T4YuExPZum0C6Sd7F3BAA=; b=i28TeTTo6P1qZ/BvrrCuuPg3hs
        JQFlVr8K7FkxOantx+KeAcwQb7ARfkAerE1SiKSpsG52SsAKKFL6OcIfCqXhqO3RIM5m05V8E4ehj
        evTqK1uJ+SbIE0v+osBZOZYrD8TxQBAEMIQiJsDiQc6WeJCn7PeqjQgC6NAKe9Zc6vojDjr5sWecI
        S9l9bgoAg9HgJIUTcKW/Egg5O01RZkFtn4jb+vJDFwPMkGdF5TFk7Bw1gwMydYAoHPU4BNhU8oABI
        HGHQyIaWTDjOW0U6vAuD7CiIBLK3LRYznjDBmwHcVaYyCJSBP9ZMsTXqwkxaHdUWS6VC9OdSvObef
        1A9+2JYg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyzgg-005Bwi-QE; Wed, 08 Jun 2022 17:41:47 +0000
Date:   Wed, 8 Jun 2022 17:41:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [RFC][CFT] handling Rerror without copy_from_iter_full()
Message-ID: <YqDfWho8+f2AXPrj@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	As it is, p9_client_zc_rpc()/p9_check_zc_errors() is playing fast
and loose with copy_from_iter_full().

	Background: reading from file is done by sending Tread request.
Response consists of fixed-sized header (including the amount of data
actually read) followed by the data itself.

	For zero-copy case we arrange the things so that the first 11
bytes of reply go into the fixed-sized buffer, with the rest going
straight into the pages we want to read into.

	What makes the things inconvenient is that sglist describing
what should go where has to be set *before* the reply arrives.  As
the result, if reply is an error, the things get interesting.  Success
is
	size[4] Rread tag[2] count[4] data[count]
For error layout varies depending upon the protocol variant -
in original 9P and 9P2000 it's
	size[4] Rerror tag[2] len[2] error[len]
in 9P2000.U
	size[4] Rerror tag[2] len[2] error[len] errno[4]
in 9P2000.L
	size[4] Rlerror tag[2] errno[4]

The last case is nice and simple - we have an 11-byte response that fits
into the fixed-sized buffer we hoped to get an Rread into.  In other
two, though, we get a variable-length string spill into the pages
we'd prepared for the data to be read.

Had that been in fixed-sized buffer (which is actually 4K), we would've
dealt with that the same way we handle non-zerocopy case.  However,
for zerocopy it doesn't end up there, so we need to copy it from
those pages.

The trouble is, by the time we get around to that, the references to
pages in question are already dropped.  As the result, p9_zc_check_errors()
tries to get the data using copy_from_iter_full().  Unfortunately, the
iov_iter it's trying to read from might *NOT* be capable of that.
It is, after all, a data destination, not data source.  In particular,
if it's an ITER_PIPE one, copy_from_iter_full() will simply fail.

The thing is, in ->zc_request() itself we have those pages.  There it
would be a simple matter of memcpy_from_page() into the fixed-sized
buffer and it isn't hard to recognize the (rare) case when such
copying is needed.  That way we get rid of p9_zc_check_errors() entirely
- p9_check_errors() can be used instead both for zero-copy and non-zero-copy
cases.

Do you see any problems with the variant below?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/net/9p/client.c b/net/9p/client.c
index 8bba0d9cf975..d403085b9ef5 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -550,90 +550,6 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 	return err;
 }
 
-/**
- * p9_check_zc_errors - check 9p packet for error return and process it
- * @c: current client instance
- * @req: request to parse and check for error conditions
- * @uidata: external buffer containing error
- * @in_hdrlen: Size of response protocol buffer.
- *
- * returns error code if one is discovered, otherwise returns 0
- *
- * this will have to be more complicated if we have multiple
- * error packet types
- */
-
-static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
-			      struct iov_iter *uidata, int in_hdrlen)
-{
-	int err;
-	int ecode;
-	s8 type;
-	char *ename = NULL;
-
-	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
-	/* dump the response from server
-	 * This should be after parse_header which poplulate pdu_fcall.
-	 */
-	trace_9p_protocol_dump(c, &req->rc);
-	if (err) {
-		p9_debug(P9_DEBUG_ERROR, "couldn't parse header %d\n", err);
-		return err;
-	}
-
-	if (type != P9_RERROR && type != P9_RLERROR)
-		return 0;
-
-	if (!p9_is_proto_dotl(c)) {
-		/* Error is reported in string format */
-		int len;
-		/* 7 = header size for RERROR; */
-		int inline_len = in_hdrlen - 7;
-
-		len = req->rc.size - req->rc.offset;
-		if (len > (P9_ZC_HDR_SZ - 7)) {
-			err = -EFAULT;
-			goto out_err;
-		}
-
-		ename = &req->rc.sdata[req->rc.offset];
-		if (len > inline_len) {
-			/* We have error in external buffer */
-			if (!copy_from_iter_full(ename + inline_len,
-						 len - inline_len, uidata)) {
-				err = -EFAULT;
-				goto out_err;
-			}
-		}
-		ename = NULL;
-		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
-				  &ename, &ecode);
-		if (err)
-			goto out_err;
-
-		if (p9_is_proto_dotu(c) && ecode < 512)
-			err = -ecode;
-
-		if (!err) {
-			err = p9_errstr2errno(ename, strlen(ename));
-
-			p9_debug(P9_DEBUG_9P, "<<< RERROR (%d) %s\n",
-				 -ecode, ename);
-		}
-		kfree(ename);
-	} else {
-		err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
-		err = -ecode;
-
-		p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
-	}
-	return err;
-
-out_err:
-	p9_debug(P9_DEBUG_ERROR, "couldn't parse error%d\n", err);
-	return err;
-}
-
 static struct p9_req_t *
 p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 
@@ -874,7 +790,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	if (err < 0)
 		goto reterr;
 
-	err = p9_check_zc_errors(c, req, uidata, in_hdrlen);
+	err = p9_check_errors(c, req);
 	trace_9p_client_res(c, type, req->rc.tag, err);
 	if (!err)
 		return req;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index b24a4fb0f0a2..2a210c2f8e40 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -377,6 +377,35 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	}
 }
 
+static void handle_rerror(struct p9_req_t *req, int in_hdr_len,
+			  size_t offs, struct page **pages)
+{
+	unsigned size, n;
+	void *to = req->rc.sdata + in_hdr_len;
+
+	// Fits entirely into the static data?  Nothing to do.
+	if (req->rc.size < in_hdr_len)
+		return;
+
+	// Really long error message?  Tough, truncate the reply.  Might get
+	// rejected (we can't be arsed to adjust the size encoded in header,
+	// or string size for that matter), but it wouldn't be anything valid
+	// anyway.
+	if (unlikely(req->rc.size > P9_ZC_HDR_SZ))
+		req->rc.size = P9_ZC_HDR_SZ;
+
+	// data won't span more than two pages
+	size = req->rc.size - in_hdr_len;
+	n = PAGE_SIZE - offs;
+	if (size > n) {
+		memcpy_from_page(to, *pages++, offs, n);
+		offs = 0;
+		to += n;
+		size -= n;
+	}
+	memcpy_from_page(to, *pages, offs, size);
+}
+
 /**
  * p9_virtio_zc_request - issue a zero copy request
  * @client: client instance issuing the request
@@ -503,6 +532,11 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	kicked = 1;
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
 	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
+	// RERROR needs reply (== error string) in static data
+	if (req->status == REQ_STATUS_RCVD &&
+	    unlikely(req->rc.sdata[4] == P9_RERROR))
+		handle_rerror(req, in_hdr_len, offs, in_pages);
+
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
