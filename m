Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A71B6E25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDXG0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbgDXG0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:26:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85025C09B045
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 23:26:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ms17so3572783pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILlNwQ7IYNn33LRxFCAi5oYlzntM/30JEoLe+sVzVCg=;
        b=bCK/J8SWnJEv/4om3fKbfMX03oFef6Um4Z4bT+Wb0xOqocFNWWaSFw/R/5JB/myuMH
         PDQRuFN1K5bGSMli5b6UOEB+FdKQL3J4MeE7pd6+ZgL0nxDRiSImpqn+tqwl0UAit/Vl
         gBR18/OAc+Oate+v29u8eEdZDTvvXKEzhKJPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILlNwQ7IYNn33LRxFCAi5oYlzntM/30JEoLe+sVzVCg=;
        b=eKsfVG7q70+xboIjUcfqbfY35n5KYGH2vUjXR9/DCsKr1UyyKapKhZeiCphPxtoUBQ
         +ACDlSEFsqHNLgvtd6ZB+iH1oC1yHrXHtC7uSpOr4GXttRd1qohaSvW87a30SyeTTZEr
         dpDQvXAl+iGWJPNBJp8aLLn59ib7mXao4QTuIOXE7iaLoJdpi3OR0xhmQHGNIVAbYTNu
         BZW5FGgO7YuuHoJqhK/lqeFeXDoux+T0k8Dhb5Szj4m8eYD1wUXxUnFtjgmqT2uAbzO7
         v1K+lxPSwE13FZiJB39F6HQicJP1ort33n6hlbLaJhzMsLnkUuyqvDW+jE+WMW/u+Vre
         LPbQ==
X-Gm-Message-State: AGi0Pua10UPtfuMqLnZDnCJwQqYgtd/XRX7gYsxLE8FIIhKYvuPZC5Jz
        yZAb15/W7VTvSZtRF4lHkD/ff/FS40HXsg==
X-Google-Smtp-Source: APiQypI3RSHLnfLFCiblw59wOL7Mdi44PgHmc0+JFHwEJif+N8ckhS1qRufYSIePwi0wPkahbZDkrA==
X-Received: by 2002:a17:90a:7486:: with SMTP id p6mr4721190pjk.62.1587709580099;
        Thu, 23 Apr 2020 23:26:20 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:1c5:cb1a:7c95:326])
        by smtp.gmail.com with ESMTPSA id c28sm4603644pfp.200.2020.04.23.23.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 23:26:19 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 2/2] fuse: virtiofs: Add basic multiqueue support
Date:   Fri, 24 Apr 2020 15:25:40 +0900
Message-Id: <20200424062540.23679-2-chirantan@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200424062540.23679-1-chirantan@chromium.org>
References: <20200424062540.23679-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use simple round-robin scheduling based on the `unique` field of the
fuse request to spread requests across multiple queues, if supported by
the device.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 fs/fuse/dev.c       | 4 ----
 fs/fuse/fuse_i.h    | 4 ++++
 fs/fuse/virtio_fs.c | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 97eec7522bf20..cad9f76c2519c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -25,10 +25,6 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
-/* Ordinary requests have even IDs, while interrupts IDs are odd */
-#define FUSE_INT_REQ_BIT (1ULL << 0)
-#define FUSE_REQ_ID_STEP (1ULL << 1)
-
 static struct kmem_cache *fuse_req_cachep;
 
 static struct fuse_dev *fuse_get_dev(struct file *file)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ca344bf714045..110b917d950a8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,6 +47,10 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/* Ordinary requests have even IDs, while interrupts IDs are odd */
+#define FUSE_INT_REQ_BIT (1ULL << 0)
+#define FUSE_REQ_ID_STEP (1ULL << 1)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d3c38222a7e4e..c5129fd27930c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -980,7 +980,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
+	unsigned int queue_id;
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -994,6 +994,8 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 
 	fs = fiq->priv;
+	queue_id = ((req->in.h.unique / FUSE_REQ_ID_STEP) %
+		    (uint64_t)fs->num_request_queues) + VQ_REQUEST;
 
 	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
 		  __func__, req->in.h.opcode, req->in.h.unique,
-- 
2.26.2.303.gf8c07b1a785-goog

