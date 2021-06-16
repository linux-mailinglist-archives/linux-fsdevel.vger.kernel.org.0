Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1263AA0F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhFPQMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhFPQMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623859796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5f3Huc8TFfv6LTD/1n6dlJvxektJCv9a3PsOjVGr8E=;
        b=A/RE6hzRmLGr1CtKQBPDVOVfiERx4MaU2gLQDXguOTfsx6JmbmzF2hYsJXtyVFUH7864nA
        zSEYtXoq4HzXqDL+e93r8guLhs2UBXfcOMyCnvvk1IgQfxLVBYfGuJZ2ik8tPMz76X3XmF
        eUrN55xiAen1liP2L/lIrVVhBpf+Vqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-zFHSeNHrMCmc-H9WGaoueg-1; Wed, 16 Jun 2021 12:09:52 -0400
X-MC-Unique: zFHSeNHrMCmc-H9WGaoueg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB3E8192CC7A;
        Wed, 16 Jun 2021 16:09:50 +0000 (UTC)
Received: from iangelak.remote.csb (ovpn-113-44.rdu2.redhat.com [10.10.113.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BB0F5C233;
        Wed, 16 Jun 2021 16:09:29 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com
Subject: [PATCH 3/3] virtiofs: Support blocking posix locks (fcntl(F_SETLKW))
Date:   Wed, 16 Jun 2021 12:08:36 -0400
Message-Id: <20210616160836.590206-4-iangelak@redhat.com>
In-Reply-To: <20210616160836.590206-1-iangelak@redhat.com>
References: <20210616160836.590206-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

As of now we don't support blocking variant of posix locks and daemon
returns -EOPNOTSUPP. Reason being that it can lead to deadlocks.
Virtqueue size is limited and it is possible we fill virtqueue with
all the requests of fcntl(F_SETLKW) and wait for reply. And later a
subsequent unlock request can't make progress because virtqueue is full.
And that means F_SETLKW can't make progress and we are deadlocked.

Use notification queue to solve this problem. After submitting lock
request device will send a reply asking requester to wait. Once lock is
available, requester will get a notification saying locking is available.
That way we don't keep the request virtueue busy while we are waiting for
lock and further unlock requests can make progress.

When we get a reply in response to lock request, we need a way to know
if we need to wait for notification or not. I have overloaded the
fuse_out_header->error field. If value is ->error is 1, that's a signal
to caller to wait for lock notification.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/virtio_fs.c       | 75 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  7 ++++
 2 files changed, 82 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f9a6a7252218..c85334543a29 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -45,6 +45,7 @@ struct virtio_fs_vq {
 	struct virtqueue *vq;     /* protected by ->lock */
 	struct work_struct done_work;
 	struct list_head queued_reqs;
+	struct list_head wait_reqs;     /* Requests waiting for notification  */
 	struct list_head end_reqs;	/* End these requests */
 	struct virtio_fs_notify_node *notify_nodes;
 	struct list_head notify_reqs;	/* List for queuing notify requests */
@@ -566,13 +567,74 @@ static int virtio_fs_enqueue_all_notify(struct virtio_fs_vq *fsvq)
 	return 0;
 }
 
+static int notify_complete_waiting_req(struct virtio_fs *vfs,
+				       struct fuse_notify_lock_out *out_args)
+{
+	struct virtio_fs_vq *fsvq = &vfs->vqs[VQ_REQUEST];
+	struct fuse_req *req, *next;
+	bool found = false;
+
+	/* Find waiting request with the unique number and end it */
+	spin_lock(&fsvq->lock);
+		list_for_each_entry_safe(req, next, &fsvq->wait_reqs, list) {
+			if (req->in.h.unique == out_args->unique) {
+				list_del_init(&req->list);
+				clear_bit(FR_SENT, &req->flags);
+				/* Transfer error code from notify */
+				req->out.h.error = out_args->error;
+				found = true;
+				break;
+			}
+		}
+	spin_unlock(&fsvq->lock);
+
+	/*
+	 * TODO: It is possible that some re-ordering happens in notify
+	 * comes before request is complete. Deal with it.
+	 */
+	if (found) {
+		fuse_request_end(req);
+		spin_lock(&fsvq->lock);
+		dec_in_flight_req(fsvq);
+		spin_unlock(&fsvq->lock);
+	} else
+		pr_debug("virtio-fs: Did not find waiting request"
+				" with unique=0x%llx\n", out_args->unique);
+
+	return 0;
+}
+
+static int virtio_fs_handle_notify(struct virtio_fs *vfs,
+				   struct virtio_fs_notify *notify)
+{
+	int ret = 0;
+	struct fuse_out_header *oh = &notify->out_hdr;
+	struct fuse_notify_lock_out *lo;
+
+	/*
+	 * For notifications, oh.unique is 0 and oh->error contains code
+	 * for which notification as arrived.
+	 */
+	switch (oh->error) {
+	case FUSE_NOTIFY_LOCK:
+		lo = (struct fuse_notify_lock_out *) &notify->outarg;
+		notify_complete_waiting_req(vfs, lo);
+		break;
+	default:
+		pr_err("virtio-fs: Unexpected notification %d\n", oh->error);
+	}
+	return ret;
+}
+
 static void virtio_fs_notify_done_work(struct work_struct *work)
 {
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 done_work);
 	struct virtqueue *vq = fsvq->vq;
+	struct virtio_fs *vfs = vq->vdev->priv;
 	LIST_HEAD(reqs);
 	struct virtio_fs_notify_node *notify, *next;
+	struct fuse_out_header *oh;
 
 	spin_lock(&fsvq->lock);
 	do {
@@ -588,6 +650,10 @@ static void virtio_fs_notify_done_work(struct work_struct *work)
 
 	/* Process notify */
 	list_for_each_entry_safe(notify, next, &reqs, list) {
+		oh = &notify->notify.out_hdr;
+		WARN_ON(oh->unique);
+		/* Handle notification */
+		virtio_fs_handle_notify(vfs, &notify->notify);
 		spin_lock(&fsvq->lock);
 		dec_in_flight_req(fsvq);
 		list_del_init(&notify->list);
@@ -688,6 +754,14 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	 * TODO verify that server properly follows FUSE protocol
 	 * (oh.uniq, oh.len)
 	 */
+	if (req->out.h.error == 1) {
+		/* Wait for notification to complete request */
+		spin_lock(&fsvq->lock);
+		list_add_tail(&req->list, &fsvq->wait_reqs);
+		spin_unlock(&fsvq->lock);
+		return;
+	}
+
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -787,6 +861,7 @@ static int virtio_fs_init_vq(struct virtio_fs *fs, struct virtio_fs_vq *fsvq,
 	strncpy(fsvq->name, name, VQ_NAME_LEN);
 	spin_lock_init(&fsvq->lock);
 	INIT_LIST_HEAD(&fsvq->queued_reqs);
+	INIT_LIST_HEAD(&fsvq->wait_reqs);
 	INIT_LIST_HEAD(&fsvq->end_reqs);
 	INIT_LIST_HEAD(&fsvq->notify_reqs);
 	init_completion(&fsvq->in_flight_zero);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 271ae90a9bb7..ae6b3fcd1fa7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -525,6 +525,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_STORE = 4,
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
+	FUSE_NOTIFY_LOCK = 7,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -916,6 +917,12 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_notify_lock_out {
+	uint64_t	unique;
+	int32_t		error;
+	int32_t		padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
-- 
2.27.0

