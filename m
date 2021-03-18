Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0885E34073D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCRNwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhCRNwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qopB9y1x5EWojgQ3TD0iEI7yb51KrfAHtn13P+oXggA=;
        b=dQ3C0UOUf6rJFuOf+F1j79ZET+cx5sfS7gEvM34CZih18uGI9KqqShQ+RbYVr2TcaapBpf
        oYlmabKx8HVCVMuEk/tDGYzhsc0oKbwbRLZttWTox1+k1a/3V4IEMM9Xq3mdxedyszfWUt
        BY/nQxexDTf+9WRW/R99OXB4Nb1mkXg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-2TwP7KZHPA-hZSW_u7GdnQ-1; Thu, 18 Mar 2021 09:52:27 -0400
X-MC-Unique: 2TwP7KZHPA-hZSW_u7GdnQ-1
Received: by mail-ot1-f70.google.com with SMTP id o17so18721920otj.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 06:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qopB9y1x5EWojgQ3TD0iEI7yb51KrfAHtn13P+oXggA=;
        b=JEuHNYHvGWNlEUIULZ2UQ6M1faGcWAod9vz474g063Bi4R5N69GMZYFLeDBN72j95B
         zyWkD+ZbaulxNyLoxGz5Cqh3gTuood6hvp7DIBrmXBlHlUetWJovusRE1aSfXYtngjIK
         6soipsUQ9cwXV9EBqhCDPLBs7lKFn1KarkIl8MPi+0IZrKCLp9ceQy5hhUYO5UyZJpC4
         8tJjyLKO1qDT9mX1SKhbm0w0xid478brHTVvnvnOx2uonbFpNXBeJW4tSWke15Hn2r62
         CCiC0L2qHqis0RFoPIJu1V90WbUNPeyBk2dYtQRG6zqJbrWgnyqjBIxbjEsFVD8Lu/Vg
         WnUQ==
X-Gm-Message-State: AOAM5332MvYzvGcoOy81YmIdCzbMJXp86PxL2ArK/uDELJvhPJe/Fc8c
        ABoD8+NJnYWTcD4de8gRObvae7I0FvbdbmcgnaiyS/0SUr5ozjF244Amxyjx1jxYNjgamhCeLzX
        HV1MdqtKPYvyWD7reeVWF5nspcg==
X-Received: by 2002:aca:f13:: with SMTP id 19mr3149425oip.56.1616075546701;
        Thu, 18 Mar 2021 06:52:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0rO00UdTXyPF5zXNwwHCPpWqYU3MgdrqOZTr0U3aiYCj6dg9lwTJ4zuH0WjLin9eIDwm4JQ==
X-Received: by 2002:aca:f13:: with SMTP id 19mr3149414oip.56.1616075546551;
        Thu, 18 Mar 2021 06:52:26 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id i11sm465342otp.76.2021.03.18.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:52:26 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jasowang@redhat.com,
        mst@redhat.com
Subject: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Date:   Thu, 18 Mar 2021 08:52:22 -0500
Message-Id: <20210318135223.1342795-3-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318135223.1342795-1-ckuehl@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an incoming FUSE request can't fit on the virtqueue, the request is
placed onto a workqueue so a worker can try to resubmit it later where
there will (hopefully) be space for it next time.

This is fine for requests that aren't larger than a virtqueue's maximum
capacity. However, if a request's size exceeds the maximum capacity of
the virtqueue (even if the virtqueue is empty), it will be doomed to a
life of being placed on the workqueue, removed, discovered it won't fit,
and placed on the workqueue yet again.

Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
Descriptors) of the virtio spec:

  "A driver MUST NOT create a descriptor chain longer than the Queue
  Size of the device."

To fix this, limit the number of pages FUSE will use for an overall
request. This way, each request can realistically fit on the virtqueue
when it is decomposed into a scattergather list and avoid violating
section 2.6.5.3.1 of the virtio spec.

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/fuse_i.h    |  5 +++++
 fs/fuse/inode.c     |  7 +++++++
 fs/fuse/virtio_fs.c | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 68cca8d4db6e..f0e4ee906464 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -555,6 +555,11 @@ struct fuse_conn {
 	/** Maxmum number of pages that can be used in a single request */
 	unsigned int max_pages;
 
+#if IS_ENABLED(CONFIG_VIRTIO_FS)
+	/** Constrain ->max_pages to this value during feature negotiation */
+	unsigned int transport_capacity;
+#endif
+
 	/** Input queue */
 	struct fuse_iqueue iq;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..42cc72ba13d9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1058,6 +1058,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			fc->no_flock = 1;
 		}
 
+#if IS_ENABLED(CONFIG_VIRTIO_FS)
+		/* fuse_conn_init() sets this to zero for all others, this is
+		 * explicitly set by virtio_fs.
+		 */
+		if (fc->transport_capacity)
+			fc->max_pages = min_t(unsigned int, fc->max_pages, fc->transport_capacity);
+#endif
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8868ac31a3c0..a6ffba85d59a 100644
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
@@ -1408,6 +1414,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	struct super_block *sb;
 	struct fuse_conn *fc;
 	struct fuse_mount *fm;
+	unsigned int virtqueue_size;
 	int err;
 
 	/* This gets a reference on virtio_fs object. This ptr gets installed
@@ -1435,6 +1442,13 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
 
+	/* Tell FUSE to split requests that exceed the virtqueue's size */
+	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
+	WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD);
+	fc->transport_capacity = min_t(unsigned int,
+			virtqueue_size - FUSE_HEADER_OVERHEAD,
+			FUSE_MAX_MAX_PAGES);
+
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
 	if (fsc->s_fs_info) {
-- 
2.30.2

