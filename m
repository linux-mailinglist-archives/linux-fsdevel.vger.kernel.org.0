Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E203229D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 13:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhBWLzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 06:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhBWLxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:53:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF89DC06121C
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 03:51:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t9so1637512pjl.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=giO5D64d7Kk8o8yeL+fv9W81NZBJ5G7R64+VKGm+1hc=;
        b=nfgKVWfjpimepezffp7YeVMqjPpQuQiv7NPgbRbM0xTw+5x13dYSJhK4EB+m9p7LkT
         1wVgY2Xvp+TIWCD7r2b+pnktIDSaSphelJWNHJyybvleOehuKMErJWW1o2lYW0Q6v8SE
         f4LUvA+Hl3TiCr6Qf8Jvnhx4TcppHcH3NURuPZmfLlkqX4/wLmps/jZoy5hK3j/CKvfJ
         8Tf+7dtjfis+bnsypb5QhmYmOUacW6SMnM3vN9EO+/OOsUKKFXG/c7/zwyFQbLwyJC5G
         Y5H1QfsKjTo5mq519pnBemW6LZv1ekTNBnMrrdps0XCNnTGL96exHdFyItOgf621jN67
         5g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=giO5D64d7Kk8o8yeL+fv9W81NZBJ5G7R64+VKGm+1hc=;
        b=Jh9AvIC0GbaO6QVKJRvU/iwE2afOiFc1HJmpXeqyL8pSSBPgRq0tRZ9hyNavnBKTi+
         tIXc/1jpybaaiaYsizKF9RsngUNFYCABgAypePB9W3VgkPfbmwrtHaRwODuMciiDT/w2
         k0oCkrp+vEjghYSOqknCCHadk/WdLIbAtJpxvxVCk0wpvreaL/tjsyoWKIsaffdVE5iz
         CRdrzwpjkcZdF/r8vfvfQ+xeKPQ+gIuUh+XFVfup3d8HcG+QqEvllyT7qJcD7qBd+z/9
         YfKC+tcUHv8/AzyVBSba54DwbS/PmBeusB+Y01t5m663z+s1l9wmWgFAG1yoKbM/X5Pu
         K3iQ==
X-Gm-Message-State: AOAM531+xup2lf1h+tKmemUp/ONvLUN1tHLGMaOn6xJmzvaTAA/C1fJC
        pkVbvf+EJDBzubpIGB6jXsDA
X-Google-Smtp-Source: ABdhPJyi7LkIVDRMXFCcBzP5s5ZBZ1gaIkDSkHERNZYMl41UlyV4GQjbz8zPtKSlM3a0M+Z0vCoXCg==
X-Received: by 2002:a17:902:d694:b029:e3:906a:61f8 with SMTP id v20-20020a170902d694b02900e3906a61f8mr27542582ply.36.1614081119392;
        Tue, 23 Feb 2021 03:51:59 -0800 (PST)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id y72sm10247421pfg.126.2021.02.23.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:51:59 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 04/11] vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
Date:   Tue, 23 Feb 2021 19:50:41 +0800
Message-Id: <20210223115048.435-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223115048.435-1-xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an opaque pointer for DMA mapping.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 6 +++---
 drivers/vhost/vdpa.c             | 2 +-
 include/linux/vdpa.h             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d5942842432d..5cfc262ce055 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -512,14 +512,14 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 }
 
 static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
-			   u64 pa, u32 perm)
+			   u64 pa, u32 perm, void *opaque)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int ret;
 
 	spin_lock(&vdpasim->iommu_lock);
-	ret = vhost_iotlb_add_range(vdpasim->iommu, iova, iova + size - 1, pa,
-				    perm);
+	ret = vhost_iotlb_add_range_ctx(vdpasim->iommu, iova, iova + size - 1,
+					pa, perm, opaque);
 	spin_unlock(&vdpasim->iommu_lock);
 
 	return ret;
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5500e3bf05c1..70857fe3263c 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -544,7 +544,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 4ab5494503a8..93dca2c328ae 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -241,7 +241,7 @@ struct vdpa_config_ops {
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
 	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
-		       u64 pa, u32 perm);
+		       u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, u64 iova, u64 size);
 
 	/* Free device resources */
-- 
2.11.0

