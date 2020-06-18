Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB31FE4D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 04:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgFRCVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 22:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgFRBSm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:18:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5658621D79;
        Thu, 18 Jun 2020 01:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443122;
        bh=y/DZ9hLMdBsskUut5fK33dyF0EPxv0N8/iguPa9VEuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgF93bG5Ygl3aAfy3TFeYCkm1PUl9XECUzP3GDk189llaWxw3DZ1g8UZOrhRYEnEl
         RnfcDq1V8G/xhBbtnEoVw5WrgH+cusp0PMLUsC3JhLtcC1yqsVIhNYB59t9lvlIR7x
         +c6+P7XnJpYOFimunydXtipVLzIKKQNifUK0AMqo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 096/266] virtiofs: schedule blocking async replies in separate worker
Date:   Wed, 17 Jun 2020 21:13:41 -0400
Message-Id: <20200618011631.604574-96-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

[ Upstream commit bb737bbe48bea9854455cb61ea1dc06e92ce586c ]

In virtiofs (unlike in regular fuse) processing of async replies is
serialized.  This can result in a deadlock in rare corner cases when
there's a circular dependency between the completion of two or more async
replies.

Such a deadlock can be reproduced with xfstests:generic/503 if TEST_DIR ==
SCRATCH_MNT (which is a misconfiguration):

 - Process A is waiting for page lock in worker thread context and blocked
   (virtio_fs_requests_done_work()).
 - Process B is holding page lock and waiting for pending writes to
   finish (fuse_wait_on_page_writeback()).
 - Write requests are waiting in virtqueue and can't complete because
   worker thread is blocked on page lock (process A).

Fix this by creating a unique work_struct for each async reply that can
block (O_DIRECT read).

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c      |   1 +
 fs/fuse/fuse_i.h    |   1 +
 fs/fuse/virtio_fs.c | 106 +++++++++++++++++++++++++++++---------------
 3 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3dd37a998ea9..713d55a61890 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -712,6 +712,7 @@ static ssize_t fuse_async_req_send(struct fuse_conn *fc,
 	spin_unlock(&io->lock);
 
 	ia->ap.args.end = fuse_aio_complete_req;
+	ia->ap.args.may_block = io->should_dirty;
 	err = fuse_simple_background(fc, &ia->ap.args, GFP_KERNEL);
 	if (err)
 		fuse_aio_complete_req(fc, &ia->ap.args, err);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ca344bf71404..d7cde216fc87 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -249,6 +249,7 @@ struct fuse_args {
 	bool out_argvar:1;
 	bool page_zeroing:1;
 	bool page_replace:1;
+	bool may_block:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_conn *fc, struct fuse_args *args, int error);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a5c86048b96e..7505f8102762 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,12 @@ struct virtio_fs_forget {
 	struct list_head list;
 };
 
+struct virtio_fs_req_work {
+	struct fuse_req *req;
+	struct virtio_fs_vq *fsvq;
+	struct work_struct done_work;
+};
+
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
@@ -443,19 +449,67 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 }
 
 /* Work function for request completion */
+static void virtio_fs_request_complete(struct fuse_req *req,
+				       struct virtio_fs_vq *fsvq)
+{
+	struct fuse_pqueue *fpq = &fsvq->fud->pq;
+	struct fuse_conn *fc = fsvq->fud->fc;
+	struct fuse_args *args;
+	struct fuse_args_pages *ap;
+	unsigned int len, i, thislen;
+	struct page *page;
+
+	/*
+	 * TODO verify that server properly follows FUSE protocol
+	 * (oh.uniq, oh.len)
+	 */
+	args = req->args;
+	copy_args_from_argbuf(args, req);
+
+	if (args->out_pages && args->page_zeroing) {
+		len = args->out_args[args->out_numargs - 1].size;
+		ap = container_of(args, typeof(*ap), args);
+		for (i = 0; i < ap->num_pages; i++) {
+			thislen = ap->descs[i].length;
+			if (len < thislen) {
+				WARN_ON(ap->descs[i].offset);
+				page = ap->pages[i];
+				zero_user_segment(page, len, thislen);
+				len = 0;
+			} else {
+				len -= thislen;
+			}
+		}
+	}
+
+	spin_lock(&fpq->lock);
+	clear_bit(FR_SENT, &req->flags);
+	spin_unlock(&fpq->lock);
+
+	fuse_request_end(fc, req);
+	spin_lock(&fsvq->lock);
+	dec_in_flight_req(fsvq);
+	spin_unlock(&fsvq->lock);
+}
+
+static void virtio_fs_complete_req_work(struct work_struct *work)
+{
+	struct virtio_fs_req_work *w =
+		container_of(work, typeof(*w), done_work);
+
+	virtio_fs_request_complete(w->req, w->fsvq);
+	kfree(w);
+}
+
 static void virtio_fs_requests_done_work(struct work_struct *work)
 {
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 done_work);
 	struct fuse_pqueue *fpq = &fsvq->fud->pq;
-	struct fuse_conn *fc = fsvq->fud->fc;
 	struct virtqueue *vq = fsvq->vq;
 	struct fuse_req *req;
-	struct fuse_args_pages *ap;
 	struct fuse_req *next;
-	struct fuse_args *args;
-	unsigned int len, i, thislen;
-	struct page *page;
+	unsigned int len;
 	LIST_HEAD(reqs);
 
 	/* Collect completed requests off the virtqueue */
@@ -473,38 +527,20 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 
 	/* End requests */
 	list_for_each_entry_safe(req, next, &reqs, list) {
-		/*
-		 * TODO verify that server properly follows FUSE protocol
-		 * (oh.uniq, oh.len)
-		 */
-		args = req->args;
-		copy_args_from_argbuf(args, req);
-
-		if (args->out_pages && args->page_zeroing) {
-			len = args->out_args[args->out_numargs - 1].size;
-			ap = container_of(args, typeof(*ap), args);
-			for (i = 0; i < ap->num_pages; i++) {
-				thislen = ap->descs[i].length;
-				if (len < thislen) {
-					WARN_ON(ap->descs[i].offset);
-					page = ap->pages[i];
-					zero_user_segment(page, len, thislen);
-					len = 0;
-				} else {
-					len -= thislen;
-				}
-			}
-		}
-
-		spin_lock(&fpq->lock);
-		clear_bit(FR_SENT, &req->flags);
 		list_del_init(&req->list);
-		spin_unlock(&fpq->lock);
 
-		fuse_request_end(fc, req);
-		spin_lock(&fsvq->lock);
-		dec_in_flight_req(fsvq);
-		spin_unlock(&fsvq->lock);
+		/* blocking async request completes in a worker context */
+		if (req->args->may_block) {
+			struct virtio_fs_req_work *w;
+
+			w = kzalloc(sizeof(*w), GFP_NOFS | __GFP_NOFAIL);
+			INIT_WORK(&w->done_work, virtio_fs_complete_req_work);
+			w->fsvq = fsvq;
+			w->req = req;
+			schedule_work(&w->done_work);
+		} else {
+			virtio_fs_request_complete(req, fsvq);
+		}
 	}
 }
 
-- 
2.25.1

