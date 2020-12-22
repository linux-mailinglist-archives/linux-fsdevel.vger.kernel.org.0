Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55F2E0C39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgLVOzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgLVOzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:55:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDAC0619D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:58 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i5so425953pgo.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHvQD7OkJ4lGDapgVipEOlFAJokuqf9tiHbhgrtKHnQ=;
        b=RbF6t1URx0NXuDx34sfOQmiHT5wyMt7HcQz7xB3j7UlRJJ8qn6zNpUxhzqnhTkabhw
         cHNm5bWTktHQwlrssm1Bxy/zV5HBtRdwVWm7PD7miDmOEaj4RsheZ0pjhsoJHl9MtAck
         lRaz1T0kLTHs57YosK4erxKVciURD2nNzv+vy2/cLa8RhC57RP/v9FvpucBxRXTT+END
         rR9hlo8x0zAOGHsD97fDtU/+26SncIQFJorfgouF6bmMg+0LaV5JZ0Vh+2CbP+J4jyRD
         rDOz+XsvnhvnpjA8QO5lxzQLeshKdzqd6/G/oGoCHCm4ilN6Z9nDrUF33KtTgyvOgxox
         dFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHvQD7OkJ4lGDapgVipEOlFAJokuqf9tiHbhgrtKHnQ=;
        b=JkcWGM0Lh+Lbeqe2OH2zUzr79jkdza1pEyfY81WosgSEehS3jwMqd3Ba3gu97/OgGM
         54DYzHwOdTK9iGJrfh+xDVuA9eV6UZiqjSHbnmFiyWwJH6P7YdGw9k79PO7tKaj0QJGZ
         zgIa+fuE+NidI/afiOGubMNIqON+kwjz9KimCLAxr8w9KWP4O0wzzgavnKOPrvswXa1s
         EpK384mQG9u4bDqYFn6X9tx2RQYqfBM5HhmLuBBzzFX2U6idl1h0JjC1vVXAFyWRQxcW
         eZSfFxobaXkS9uGfdP8yq8ZZWt7X53LX8bPeRdxq3v1pCjUAFJPQ513/bUOb9GrxfFz8
         UDxg==
X-Gm-Message-State: AOAM531AJRfXYROH6BYEID6Qp67D/OHNwPAG5Ia1IfnJ0eIFnZix2ehv
        DOg0pMURqInquaskAotCoTQU
X-Google-Smtp-Source: ABdhPJxHgVEI1a5PZz0mJOg/L7ZcxPgkg0e49rxJy8/9ZVyVLaCF/QiD5aZkOXPawm0UVGFmRu0uqQ==
X-Received: by 2002:a63:1c1d:: with SMTP id c29mr13018708pgc.94.1608648838484;
        Tue, 22 Dec 2020 06:53:58 -0800 (PST)
Received: from localhost ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id u12sm20339420pfh.98.2020.12.22.06.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:53:57 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC v2 08/13] vdpa: Introduce process_iotlb_msg() in vdpa_config_ops
Date:   Tue, 22 Dec 2020 22:52:16 +0800
Message-Id: <20201222145221.711-9-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222145221.711-1-xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new method in the vdpa_config_ops to
support processing the raw vhost memory mapping message in the
vDPA device driver.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 5 ++++-
 include/linux/vdpa.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 448be7875b6d..ccbb391e38be 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -728,6 +728,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	if (r)
 		return r;
 
+	if (ops->process_iotlb_msg)
+		return ops->process_iotlb_msg(vdpa, msg);
+
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
 		r = vhost_vdpa_process_iotlb_update(v, msg);
@@ -770,7 +773,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	int ret;
 
 	/* Device want to do DMA by itself */
-	if (ops->set_map || ops->dma_map)
+	if (ops->set_map || ops->dma_map || ops->process_iotlb_msg)
 		return 0;
 
 	bus = dma_dev->bus;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 656fe264234e..7bccedf22f4b 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/vhost_types.h>
 #include <linux/vhost_iotlb.h>
 #include <net/genetlink.h>
 
@@ -172,6 +173,10 @@ struct vdpa_iova_range {
  *				@vdev: vdpa device
  *				Returns the iova range supported by
  *				the device.
+ * @process_iotlb_msg:		Process vhost memory mapping message (optional)
+ *				Only used for VDUSE device now
+ *				@vdev: vdpa device
+ *				@msg: vhost memory mapping message
  * @set_map:			Set device memory mapping (optional)
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
@@ -240,6 +245,8 @@ struct vdpa_config_ops {
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
 	/* DMA ops */
+	int (*process_iotlb_msg)(struct vdpa_device *vdev,
+				 struct vhost_iotlb_msg *msg);
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
 	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
 		       u64 pa, u32 perm);
-- 
2.11.0

