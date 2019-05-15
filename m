Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3D1FAEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfEOTb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEOT1c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62695300174D;
        Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D50411001DE1;
        Wed, 15 May 2019 19:27:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6FE5E225478; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 04/30] fuse: export fuse_end_request()
Date:   Wed, 15 May 2019 15:26:49 -0400
Message-Id: <20190515192715.18000-5-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 15 May 2019 19:27:32 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio-fs will need to complete requests from outside fs/fuse/dev.c.
Make the symbol visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/dev.c    | 19 ++++++++++---------
 fs/fuse/fuse_i.h |  5 +++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9971a35cf1ef..46d1aecd7506 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -427,7 +427,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
  * the 'end' callback is called if given, else the reference to the
  * request is released
  */
-static void request_end(struct fuse_conn *fc, struct fuse_req *req)
+void fuse_request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
@@ -480,6 +480,7 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 put_request:
 	fuse_put_request(fc, req);
 }
+EXPORT_SYMBOL_GPL(fuse_request_end);
 
 static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
@@ -567,12 +568,12 @@ static void __fuse_request_send(struct fuse_conn *fc, struct fuse_req *req)
 		req->in.h.unique = fuse_get_unique(fiq);
 		queue_request(fiq, req);
 		/* acquire extra reference, since request is still needed
-		   after request_end() */
+		   after fuse_request_end() */
 		__fuse_get_request(req);
 		spin_unlock(&fiq->waitq.lock);
 
 		request_wait_answer(fc, req);
-		/* Pairs with smp_wmb() in request_end() */
+		/* Pairs with smp_wmb() in fuse_request_end() */
 		smp_rmb();
 	}
 }
@@ -1302,7 +1303,7 @@ __releases(fiq->waitq.lock)
  * the pending list and copies request data to userspace buffer.  If
  * no reply is needed (FORGET) or request has been aborted or there
  * was an error during the copying then it's finished by calling
- * request_end().  Otherwise add it to the processing list, and set
+ * fuse_request_end().  Otherwise add it to the processing list, and set
  * the 'sent' flag.
  */
 static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
@@ -1362,7 +1363,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		/* SETXATTR is special, since it may contain too large data */
 		if (in->h.opcode == FUSE_SETXATTR)
 			req->out.h.error = -E2BIG;
-		request_end(fc, req);
+		fuse_request_end(fc, req);
 		goto restart;
 	}
 	spin_lock(&fpq->lock);
@@ -1405,7 +1406,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	if (!test_bit(FR_PRIVATE, &req->flags))
 		list_del_init(&req->list);
 	spin_unlock(&fpq->lock);
-	request_end(fc, req);
+	fuse_request_end(fc, req);
 	return err;
 
  err_unlock:
@@ -1913,7 +1914,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
  * the write buffer.  The request is then searched on the processing
  * list by the unique ID found in the header.  If found, then remove
  * it from the list and copy the rest of the buffer to the request.
- * The request is finished by calling request_end()
+ * The request is finished by calling fuse_request_end().
  */
 static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 				 struct fuse_copy_state *cs, size_t nbytes)
@@ -2000,7 +2001,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		list_del_init(&req->list);
 	spin_unlock(&fpq->lock);
 
-	request_end(fc, req);
+	fuse_request_end(fc, req);
 out:
 	return err ? err : nbytes;
 
@@ -2140,7 +2141,7 @@ static void end_requests(struct fuse_conn *fc, struct list_head *head)
 		req->out.h.error = -ECONNABORTED;
 		clear_bit(FR_SENT, &req->flags);
 		list_del_init(&req->list);
-		request_end(fc, req);
+		fuse_request_end(fc, req);
 	}
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0920c0c032a0..c4584c873b87 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -949,6 +949,11 @@ ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *args);
 void fuse_request_send_background(struct fuse_conn *fc, struct fuse_req *req);
 bool fuse_request_queue_background(struct fuse_conn *fc, struct fuse_req *req);
 
+/**
+ * End a finished request
+ */
+void fuse_request_end(struct fuse_conn *fc, struct fuse_req *req);
+
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
-- 
2.20.1

