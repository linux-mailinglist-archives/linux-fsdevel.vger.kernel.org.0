Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963B343A4F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhJYUuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233868AbhJYUuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635194865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoIdcwosAkCnXZvWpbO9ATCMth0aiYA3TrQNYkjP5Zc=;
        b=SQrDk60CCxIe7t8361OdoZk6bYS9jo8wz0HPF/juHa7xtl/KHZBCHqenlkG84cfbbJyw0c
        /T4Jd5j5novsBYKwmnWpANNR+byfAQLcCBmROseOeuaYeriVuOV2BsHb7QCZmJlw28es53
        RoLWYgiGyHVybj3CRAOLLyXA6B2JhQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-OAfQa_xPPMOrvhPLCASUew-1; Mon, 25 Oct 2021 16:47:42 -0400
X-MC-Unique: OAfQa_xPPMOrvhPLCASUew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B0CA362F8;
        Mon, 25 Oct 2021 20:47:41 +0000 (UTC)
Received: from iangelak.redhat.com (unknown [10.22.32.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 357E560CA1;
        Mon, 25 Oct 2021 20:47:40 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>
Subject: [RFC PATCH 7/7] virtiofs: Add support for handling the remote fsnotify notifications
Date:   Mon, 25 Oct 2021 16:46:34 -0400
Message-Id: <20211025204634.2517-8-iangelak@redhat.com>
In-Reply-To: <20211025204634.2517-1-iangelak@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FUSE and specifically virtiofs should be able to handle the asynchronous
event notifications originating from the FUSE server. To this end we add
the FUSE_NOTIFY_FSNOTIFY switch case to the "virtio_fs_handle_notify" in
fs/fuse/virtio_fs.c to handle these specific notifications.

The event notification contains the information that a user space
application would receive when monitoring an inode for events. The
information is the mask of the inode watch, a file name corresponding to
the inode the remote event was generated for and finally, the inotify
cookie.

Then a new event should be generated corresponding to the event
notification received from the FUSE server. Specifically, FUSE in the guest
kernel will call the "__fsnotify" function in fs/notify/fsnotify.c to send
the event to user space.

Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/virtio_fs.c | 64 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d3dba9e3a07e..4c48c2812caa 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -16,6 +16,7 @@
 #include <linux/fs_parser.h>
 #include <linux/highmem.h>
 #include <linux/uio.h>
+#include <linux/fsnotify_backend.h>
 #include "fuse_i.h"
 
 /* Used to help calculate the FUSE connection's max_pages limit for a request's
@@ -655,14 +656,69 @@ static void notify_node_reuse(struct virtio_fs_vq *notify_fsvq,
 	spin_unlock(&notify_fsvq->lock);
 }
 
+static int fsnotify_remote_event(struct inode *inode, uint32_t mask,
+				 struct qstr *filename, uint32_t cookie)
+{
+	return __fsnotify(mask, NULL, 0, NULL,
+			  (const struct qstr *)filename, inode, cookie);
+}
+
+/*
+ * Function to generate a new event when a fsnotify notification comes from the
+ * fuse server
+ */
+static int generate_fsnotify_event(struct fuse_conn *fc,
+			struct fuse_notify_fsnotify_out *fsnotify_out)
+{
+	struct inode *inode;
+	uint32_t mask, cookie;
+	struct fuse_mount *fm;
+	int ret = -1;
+	struct qstr name;
+
+	down_read(&fc->killsb);
+	inode = fuse_ilookup(fc, fsnotify_out->inode, &fm);
+	/*
+	 * The inode that corresponds to the event does not exist in this case
+	 * so do not generate any new event and just return an error
+	 */
+	if (!inode)
+		goto out;
+
+	mask = fsnotify_out->mask;
+	cookie = fsnotify_out->cookie;
+
+	/*
+	 * If the notification contained the name of the file/dir the event
+	 * occurred for, it will be placed after the fsnotify_out struct in the
+	 * notification message
+	 */
+	if (fsnotify_out->namelen > 0) {
+		name.len = fsnotify_out->namelen;
+		name.name = (char *)fsnotify_out + sizeof(struct fuse_notify_fsnotify_out);
+		ret = fsnotify_remote_event(inode, mask, &name, cookie);
+	} else {
+		ret = fsnotify_remote_event(inode, mask, NULL, cookie);
+	}
+
+	up_read(&fc->killsb);
+out:
+	if (ret < 0)
+		return -EINVAL;
+
+	return ret;
+}
+
 static int virtio_fs_handle_notify(struct virtio_fs *vfs,
-				   struct virtio_fs_notify_node *notifyn)
+				   struct virtio_fs_notify_node *notifyn,
+				   struct fuse_conn *fc)
 {
 	int ret = 0, no_reuse = 0;
 	struct virtio_fs_notify *notify = &notifyn->notify;
 	struct virtio_fs_vq *notify_fsvq = &vfs->vqs[VQ_NOTIFY_IDX];
 	struct fuse_out_header *oh = &notify->out_hdr;
 	struct fuse_notify_lock_out *lo;
+	struct fuse_notify_fsnotify_out *fsnotify_out;
 
 	/*
 	 * For notifications, oh.unique is 0 and oh->error contains code
@@ -673,6 +729,10 @@ static int virtio_fs_handle_notify(struct virtio_fs *vfs,
 		lo = (struct fuse_notify_lock_out *) &notify->outarg;
 		no_reuse = notify_complete_waiting_req(vfs, lo);
 		break;
+	case FUSE_NOTIFY_FSNOTIFY:
+		fsnotify_out = (struct fuse_notify_fsnotify_out *) &notify->outarg;
+		generate_fsnotify_event(fc, fsnotify_out);
+		break;
 	default:
 		pr_err("virtio-fs: Unexpected notification %d\n", oh->error);
 	}
@@ -711,7 +771,7 @@ static void virtio_fs_notify_done_work(struct work_struct *work)
 		WARN_ON(oh->unique);
 		list_del_init(&notifyn->list);
 		/* Handle notification */
-		virtio_fs_handle_notify(vfs, notifyn);
+		virtio_fs_handle_notify(vfs, notifyn, fsvq->fud->fc);
 		spin_lock(&fsvq->lock);
 		dec_in_flight_req(fsvq);
 		spin_unlock(&fsvq->lock);
-- 
2.33.0

