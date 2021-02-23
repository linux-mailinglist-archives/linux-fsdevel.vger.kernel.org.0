Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0011322A2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 13:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhBWMBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 07:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhBWLz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:55:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152EC061A27
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 03:52:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a24so9654617plm.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwCQi7yMWs/lU5BLAG+88fS88MLi+x4jraZ45+lObf8=;
        b=j0R+7mVqw5YLxj0pX4GVMcICPw8VlJXDkxeUau8sr3/FVyKUGDXL8/RkmI4LWp9AuL
         D8GuHLp7BjzM9EgdTIqHutPxm0LZTOSyLSrlfsE4neFIpjV53nYwwdM52IhYHbVukKPm
         mVDOESM0pRzGuIou5h6E4bfCf1EI/wwrWCqIml1zSAnw1Yt0IlynC0yo3MnRVzhihaM/
         SNrhf37rQ1jpObxUMTAYcVh+k1iF2wQ1jsyl64IWACfC+/XIIU45nptq2cwGOHmoQ43D
         SQ0H8aT9nr21YhmPnpYq8KEdhmWv8PriFinsaJ98ifM6F07BkjoA7cU8vbYlTTWCfOtW
         iEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwCQi7yMWs/lU5BLAG+88fS88MLi+x4jraZ45+lObf8=;
        b=A/Ma34K0Az2qG/jt48S9qn3oPKkL+39tNotnqrV5IxMbVp9N7jo+gHgc6t54asAFXZ
         t9/G2PK/IXWWplbQAXJ9d7t5q5qz8wmoNY+xWSqFdErqHVEfcA46hhoTlU51F2XPNJWG
         LxBmpAcORBqyl+aT35rNdoRhv7JJY7K9emDgTeRiKZvO6AdGztYQGi/NkapYjDi8P8oy
         PG0j9VAM1ZNMoJGMQAtb+cnATgoaKhuPVD0q9Lurc7u4phmsuriDdtnxdTajk7GwaJ/s
         adPD5xpJl8PU92HzmZsAstla2tNNtfJop6pGPOOyy9iNWOY7GQEy5BrYlkbzkYYtIcxX
         h4cA==
X-Gm-Message-State: AOAM533KnDYIxNZGhZnp4phDixKZi6JO7MEiUz1KDhT9ZFB+D/Bb5pw/
        ocuCjPsQwmFHAspzA1CNrPfr
X-Google-Smtp-Source: ABdhPJzsV0VtcgAYkXPMbAyWc7SKmHiJzABN/WEEiK02xUoHnGrYxXmcwq1FMvv91HVzbcCvjxfwsw==
X-Received: by 2002:a17:902:6bca:b029:e2:c5d6:973e with SMTP id m10-20020a1709026bcab02900e2c5d6973emr26842142plt.40.1614081140553;
        Tue, 23 Feb 2021 03:52:20 -0800 (PST)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id x17sm22913877pfq.132.2021.02.23.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:52:20 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 10/11] vduse: Introduce a workqueue for irq injection
Date:   Tue, 23 Feb 2021 19:50:47 +0800
Message-Id: <20210223115048.435-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223115048.435-1-xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a workqueue to support injecting
virtqueue's interrupt asynchronously. This is mainly
for performance considerations which makes sure the push()
and pop() for used vring can be asynchronous.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 8042d3fa57f1..f5adeb9ee027 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -42,6 +42,7 @@ struct vduse_virtqueue {
 	spinlock_t irq_lock;
 	struct eventfd_ctx *kickfd;
 	struct vdpa_callback cb;
+	struct work_struct inject;
 };
 
 struct vduse_dev;
@@ -99,6 +100,7 @@ static DEFINE_IDA(vduse_ida);
 
 static dev_t vduse_major;
 static struct class *vduse_class;
+static struct workqueue_struct *vduse_irq_wq;
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
 {
@@ -852,6 +854,17 @@ static int vduse_kickfd_setup(struct vduse_dev *dev,
 	return 0;
 }
 
+static void vduse_vq_irq_inject(struct work_struct *work)
+{
+	struct vduse_virtqueue *vq = container_of(work,
+					struct vduse_virtqueue, inject);
+
+	spin_lock_irq(&vq->irq_lock);
+	if (vq->ready && vq->cb.callback)
+		vq->cb.callback(vq->cb.private);
+	spin_unlock_irq(&vq->irq_lock);
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			unsigned long arg)
 {
@@ -917,12 +930,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		vq = &dev->vqs[arg];
-		spin_lock_irq(&vq->irq_lock);
-		if (vq->ready && vq->cb.callback) {
-			vq->cb.callback(vq->cb.private);
-			ret = 0;
-		}
-		spin_unlock_irq(&vq->irq_lock);
+		queue_work(vduse_irq_wq, &vq->inject);
 		break;
 	}
 	case VDUSE_INJECT_CONFIG_IRQ:
@@ -1109,6 +1117,7 @@ static int vduse_create_dev(struct vduse_dev_config *config)
 
 	for (i = 0; i < dev->vq_num; i++) {
 		dev->vqs[i].index = i;
+		INIT_WORK(&dev->vqs[i].inject, vduse_vq_irq_inject);
 		spin_lock_init(&dev->vqs[i].kick_lock);
 		spin_lock_init(&dev->vqs[i].irq_lock);
 	}
@@ -1333,6 +1342,11 @@ static int vduse_init(void)
 	if (ret)
 		goto err_chardev;
 
+	vduse_irq_wq = alloc_workqueue("vduse-irq",
+				WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
+	if (!vduse_irq_wq)
+		goto err_wq;
+
 	ret = vduse_domain_init();
 	if (ret)
 		goto err_domain;
@@ -1344,6 +1358,8 @@ static int vduse_init(void)
 	return 0;
 err_mgmtdev:
 	vduse_domain_exit();
+err_wq:
+	destroy_workqueue(vduse_irq_wq);
 err_domain:
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
 err_chardev:
@@ -1359,6 +1375,7 @@ static void vduse_exit(void)
 	misc_deregister(&vduse_misc);
 	class_destroy(vduse_class);
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
+	destroy_workqueue(vduse_irq_wq);
 	vduse_domain_exit();
 	vduse_mgmtdev_exit();
 }
-- 
2.11.0

