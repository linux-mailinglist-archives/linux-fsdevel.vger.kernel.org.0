Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0134FB1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhCaIGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 04:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbhCaIGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:06:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1165AC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l76so13633359pga.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dubzpBCF3+ulmGIlAE/3LSJUNp9rfCq5rSBOfiOcPD8=;
        b=GQx3aaHtPD0bMREP9V9WD6XCubeNAh4r70/SV9++/4RyFWtPLheSkizet3EGVbLBtY
         tCYIdA8X7eAHWfWsyPkMCEDqaDI8zbUfsTj10rxZWazA//kmK6IGKz8FR/d1OaVPBE2e
         g1Q3N0M02USDNdrukcZl5Vx6oY2nRF3paCukXHEK0tyxekUVV0UglhhSi7yaQlO0Zv7L
         L2aL9jxToNcgDyBHsuITOEjzjhF8uL9iyLbmSZrD296UA+co+l6ZLUHogS8NwmhJLYf4
         y0DEVSijhVDMQATF/o1fhG4HoIjbg4nk+8nevJwn4fIbkFy6okdw0bWRg5U780pFi6PG
         qavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dubzpBCF3+ulmGIlAE/3LSJUNp9rfCq5rSBOfiOcPD8=;
        b=XnP/Pr0/d6zMbvKz0Uyf0LuLsKrSnDYZfArSrQhc6IltOIOhDblnmQGbrw65N8dVvh
         ZnCzuQx+8BZzNdcy0q1gjf7CrPbbu3bviSJpEYPLvw8WB0+o7/dAoUKRdTzj8SvWh4UF
         YNPwmBKHV4h0khpuOqrcv/JZhlDT5j95iwZPiOLRPDm1r4eoHR3h06oK5C7MZRS4tqyY
         2cbmg+GQU5Zs3M+a1jTF4RWTLd6LVQLGPxKKhUVr23EnlwL1xHwXpUd1DN+3pudfE04a
         DCo2KtGTsSYnr317jak167n/vkUNYI+GbzLtIGV7atE8ZspVCs+ob5bzFNn6tq5ymxaK
         4Cbg==
X-Gm-Message-State: AOAM5338MxonXZ/aZ4O0dh8IghT6+hXubV4pOY7BuldMPJHQ27ECIIAu
        DnEaqOAXEjOaZ/doDaYRhcYu
X-Google-Smtp-Source: ABdhPJwHsxBRYD6NxqLEq9ZVf+mQOlWrHHFPh2fYICclZ9LBvhEjkTGJyVSqnM5dX5rgVpNieMmW9A==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr2132414pgr.119.1617177995607;
        Wed, 31 Mar 2021 01:06:35 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id f21sm1216751pfe.6.2021.03.31.01.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 01:06:35 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 05/10] vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
Date:   Wed, 31 Mar 2021 16:05:14 +0800
Message-Id: <20210331080519.172-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331080519.172-1-xieyongji@bytedance.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an opaque pointer for DMA mapping.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 6 +++---
 drivers/vhost/vdpa.c             | 2 +-
 include/linux/vdpa.h             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 5b6b2f87d40c..ff331f088baf 100644
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
index 63b28d3aee7c..22cab98610a1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -550,7 +550,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 15fa085fab05..b01f7c9096bf 100644
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

