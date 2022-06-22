Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE0C55415B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356787AbiFVEQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356616AbiFVEP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053D270
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q4Xdf1aJyRzAQD48KFLYFievPt8QKiRXsjXxfb/FuAw=; b=cA/vyoooQEBOX5MxcK3uE1cy7A
        wmPTjzBjz4o0MmZxqYMp1sufEtZI90oV+gJD+KyvD4Ppjue1+1XzAbXyC8Pjl//knkajxVxEOnYz0
        jmumMexmJlwqbkluHCYy2Soxv8nOfPPX0IgHY2lxMqDYmVkTGGuALayp82x/994VwZOwBPQwuBMJZ
        lAP6RPGrSGsm9mpb5rzOOftkVJjqMmBGeyxSb4A+Lc/mA7h4lyEhDF1nYZY9073FG1QpVz2VL5tIV
        0GlDXCBdb+6oNS7zPT1Ix735ieGP8SZBMpprxXy6hFo6Fy/i/Ih2cr2nKbPMTQdeFHXoRcfQ3Yyzg
        U+Wf3ydg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmS-0035vN-Ef;
        Wed, 22 Jun 2022 04:15:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 01/44] 9p: handling Rerror without copy_from_iter_full()
Date:   Wed, 22 Jun 2022 05:15:09 +0100
Message-Id: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <YrKWRCOOWXPHRCKg@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
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

        p9_client_zc_rpc()/p9_check_zc_errors() are playing fast
and loose with copy_from_iter_full().

	Reading from file is done by sending Tread request.  Response
consists of fixed-sized header (including the amount of data actually
read) followed by the data itself.

	For zero-copy case we arrange the things so that the first
11 bytes of reply go into the fixed-sized buffer, with the rest going
straight into the pages we want to read into.

	What makes the things inconvenient is that sglist describing
what should go where has to be set *before* the reply arrives.  As
the result, if reply is an error, the things get interesting.  On success
we get
	size[4] Rread tag[2] count[4] data[count]
For error layout varies depending upon the protocol variant -
in original 9P and 9P2000 it's
	size[4] Rerror tag[2] len[2] error[len]
in 9P2000.U
	size[4] Rerror tag[2] len[2] error[len] errno[4]
in 9P2000.L
	size[4] Rlerror tag[2] errno[4]

	The last case is nice and simple - we have an 11-byte response
that fits into the fixed-sized buffer we hoped to get an Rread into.
In other two, though, we get a variable-length string spill into the
pages we'd prepared for the data to be read.

	Had that been in fixed-sized buffer (which is actually 4K),
we would've dealt with that the same way we handle non-zerocopy case.
However, for zerocopy it doesn't end up there, so we need to copy it
from those pages.

	The trouble is, by the time we get around to that, the
references to pages in question are already dropped.  As the result,
p9_zc_check_errors() tries to get the data using copy_from_iter_full().
Unfortunately, the iov_iter it's trying to read from might *NOT* be
capable of that.  It is, after all, a data destination, not data source.
In particular, if it's an ITER_PIPE one, copy_from_iter_full() will
simply fail.

	In ->zc_request() itself we do have those pages and dealing with
the problem in there would be a simple matter of memcpy_from_page()
into the fixed-sized buffer.  Moreover, it isn't hard to recognize
the (rare) case when such copying is needed.  That way we get rid of
p9_zc_check_errors() entirely - p9_check_errors() can be used instead
both for zero-copy and non-zero-copy cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/9p/client.c       | 86 +------------------------------------------
 net/9p/trans_virtio.c | 34 +++++++++++++++++
 2 files changed, 35 insertions(+), 85 deletions(-)

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
-- 
2.30.2

