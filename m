Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7834089F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCRPSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhCRPSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:18:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A91FC06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 08:17:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u4so7106670edv.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mDhtpthkra5FR1QobgMI7rXBQ3u37AScVadxTXIiiws=;
        b=rfi6ZFrFzWHRwJNIj9d3b2TY9HCj2RsBMVq0iA0Ht1giyZMnvTXWk4CMUScdkfEUke
         uOVuuATQfXXLxvXpqW7IudzlolIvUpcYDmMJFmoQOKCVtaH+kTxNVBS7t5uiHz0uXI66
         fMqEwdB0Q92SRiYcwTLMq49s8ayFSEwmIF/hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mDhtpthkra5FR1QobgMI7rXBQ3u37AScVadxTXIiiws=;
        b=Vqwmj9nk+kXnWofdl8HcWjImeGKJLFUwMXp0CvXjoJdfIbeCsy/VQPT+hqwhbKgNnr
         W1+cDnOgh/3h44x0DaoG9Z3aacRfWuPqCi58CNULuoNOVRmxJRVVaEBCXEJz7fbR/8/A
         qByadxs99CNeDAK8KFLMlD76qD4lfzVOaWR/IhzK1RmIXog8uAkCBNvl8jwJZKmDwANP
         GBCTUzCsR/Vj5ReQUWkjXDBuVr19zL2B4ocjSxoc8j/yzzzrqE1hpPjLd1iizDDKAA7p
         3EcZbAjEUNQ9OkP1f7HxYuuPCrhCj2nn3fC8mtWJQUgn4YiGp8EIhpFJziDw3u0VpCV5
         Oa5Q==
X-Gm-Message-State: AOAM532nTCbTU9BbicsW9NX+LeUEPxO7hDMbc/tYcbHipyWYlnyGwKA4
        5VyeFQPCkrOEJh9qcJh3Ljsz4A==
X-Google-Smtp-Source: ABdhPJzewXSYi5Px+OEXUMHBXkvYYUInFfzJGS4KRUsXTsFjGv691EuGz7X5Eq3Y/ufhjYWj0Y5bmg==
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr4284769edd.313.1616080678409;
        Thu, 18 Mar 2021 08:17:58 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id e26sm2652728edj.29.2021.03.18.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:17:57 -0700 (PDT)
Date:   Thu, 18 Mar 2021 16:17:51 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Message-ID: <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318135223.1342795-3-ckuehl@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:52:22AM -0500, Connor Kuehl wrote:
> If an incoming FUSE request can't fit on the virtqueue, the request is
> placed onto a workqueue so a worker can try to resubmit it later where
> there will (hopefully) be space for it next time.
> 
> This is fine for requests that aren't larger than a virtqueue's maximum
> capacity. However, if a request's size exceeds the maximum capacity of
> the virtqueue (even if the virtqueue is empty), it will be doomed to a
> life of being placed on the workqueue, removed, discovered it won't fit,
> and placed on the workqueue yet again.
> 
> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> Descriptors) of the virtio spec:
> 
>   "A driver MUST NOT create a descriptor chain longer than the Queue
>   Size of the device."
> 
> To fix this, limit the number of pages FUSE will use for an overall
> request. This way, each request can realistically fit on the virtqueue
> when it is decomposed into a scattergather list and avoid violating
> section 2.6.5.3.1 of the virtio spec.

I removed the conditional compilation and renamed the limit.  Also made
virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.

The virtio_ring patch in this series should probably go through the respective
subsystem tree.


Thanks,
Miklos

---
From: Connor Kuehl <ckuehl@redhat.com>
Subject: virtiofs: split requests that exceed virtqueue size
Date: Thu, 18 Mar 2021 08:52:22 -0500

If an incoming FUSE request can't fit on the virtqueue, the request is
placed onto a workqueue so a worker can try to resubmit it later where
there will (hopefully) be space for it next time.

This is fine for requests that aren't larger than a virtqueue's maximum
capacity.  However, if a request's size exceeds the maximum capacity of the
virtqueue (even if the virtqueue is empty), it will be doomed to a life of
being placed on the workqueue, removed, discovered it won't fit, and placed
on the workqueue yet again.

Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
Descriptors) of the virtio spec:

  "A driver MUST NOT create a descriptor chain longer than the Queue
  Size of the device."

To fix this, limit the number of pages FUSE will use for an overall
request.  This way, each request can realistically fit on the virtqueue
when it is decomposed into a scattergather list and avoid violating section
2.6.5.3.1 of the virtio spec.

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h    |    3 +++
 fs/fuse/inode.c     |    3 ++-
 fs/fuse/virtio_fs.c |   19 +++++++++++++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -555,6 +555,9 @@ struct fuse_conn {
 	/** Maxmum number of pages that can be used in a single request */
 	unsigned int max_pages;
 
+	/** Constrain ->max_pages to this value during feature negotiation */
+	unsigned int max_pages_limit;
+
 	/** Input queue */
 	struct fuse_iqueue iq;
 
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -712,6 +712,7 @@ void fuse_conn_init(struct fuse_conn *fc
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
+	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
 
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
@@ -1040,7 +1041,7 @@ static void process_init_reply(struct fu
 				fc->abort_err = 1;
 			if (arg->flags & FUSE_MAX_PAGES) {
 				fc->max_pages =
-					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
+					min_t(unsigned int, fc->max_pages_limit,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
 			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -18,6 +18,12 @@
 #include <linux/uio.h>
 #include "fuse_i.h"
 
+/* Used to help calculate the FUSE connection's max_pages limit for a request's
+ * size. Parts of the struct fuse_req are sliced into scattergather lists in
+ * addition to the pages used, so this can help account for that overhead.
+ */
+#define FUSE_HEADER_OVERHEAD    4
+
 /* List of virtio-fs device instances and a lock for the list. Also provides
  * mutual exclusion in device removal and mounting path
  */
@@ -1413,9 +1419,10 @@ static int virtio_fs_get_tree(struct fs_
 {
 	struct virtio_fs *fs;
 	struct super_block *sb;
-	struct fuse_conn *fc;
+	struct fuse_conn *fc = NULL;
 	struct fuse_mount *fm;
-	int err;
+	unsigned int virtqueue_size;
+	int err = -EIO;
 
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
@@ -1427,6 +1434,10 @@ static int virtio_fs_get_tree(struct fs_
 		return -EINVAL;
 	}
 
+	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
+	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
+		goto out_err;
+
 	err = -ENOMEM;
 	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
 	if (!fc)
@@ -1442,6 +1453,10 @@ static int virtio_fs_get_tree(struct fs_
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
 
+	/* Tell FUSE to split requests that exceed the virtqueue's size */
+	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
+				    virtqueue_size - FUSE_HEADER_OVERHEAD);
+
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
 	if (fsc->s_fs_info) {
