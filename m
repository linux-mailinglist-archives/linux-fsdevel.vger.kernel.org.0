Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4EC3828FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhEQJ6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 05:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhEQJ5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 05:57:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ABC06134D
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 02:56:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n3so2840113plf.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oY/2Hu7faZQbXhD/6Y+q2bi+BTQyO9MF7tf5wnhwEM=;
        b=Zr7zQjnhmh2FAhUa9rmPnf5ODWeo9mfG0g8KYDfYo1vHHSW+0b1J74HuKjmzIOOBU4
         MqfuWNJ1bTzRiEZ1V3TwZrUhqAfJBEMFzZPA9DSFrCTvBIZkGSRjWb2q/e0BBjLqSppa
         5Zce5PPRF5ac7ZtU+itBZvGpFs/wprOb0sNTwDzl36go+fm7cAhNe/wxVf2JhKtXj56r
         yiGFWZz6FKe2rZui0JOCNL2+Galoh1OmD2yJcFOftpyopKehjJAOUCgIYVlNApckbMAJ
         uphq7nGhHp59OmNObnFyBmuPhvecdcz3QJcwIy3Jmcl/rfSSA9IjJwoBC78tMXumW1v9
         Qa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oY/2Hu7faZQbXhD/6Y+q2bi+BTQyO9MF7tf5wnhwEM=;
        b=BTGRZmRgMi6xFrRwwSojMerPdXonEX/Urqiu8XCl/YAXyFruUx35U+AqzBBLWp0RzB
         X8cGWChWTVkX0oYykmF2UKs0gQqJsz3Rbx+ViuU/wQTRGvr0HfSNp9l9pRwmOIL41UAf
         xDdCr/eZ0X3ZCoBtEWPMtrDwz4aCKP9saDkRf+989zAn7fju1A6YSe/nqHc8jVat/0hz
         200nwq5sgdBJ6LBo+i5qI1Qr7nKRpRJbGpn0BK9TEio22l1LeqX/AoFTBOuYaw52XPtc
         F9Z+tjJu7uAZvfwH2TVQ8YLPk24Q091hOC9ChXrcE9loyc/pTVfriCVKeFB28/fYHuCH
         QcmA==
X-Gm-Message-State: AOAM530rYqVn+L87Mrn3XJ/9eMcxkZrDp9C7IXBNExW8VgOCiPOdK3N+
        YKdE2Z4ww53HbEVZjVyDsJeT
X-Google-Smtp-Source: ABdhPJyr0oLXUpe02GaMYvuu9U2bSdT6Fnn+ZvfM/JYWqVCyuitHZoVVty5uBBvPClQSteFkfpVjOQ==
X-Received: by 2002:a17:902:904a:b029:ef:9058:7314 with SMTP id w10-20020a170902904ab02900ef90587314mr25640485plz.12.1621245384212;
        Mon, 17 May 2021 02:56:24 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id m6sm6616904pfc.133.2021.05.17.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:56:23 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/12] vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
Date:   Mon, 17 May 2021 17:55:08 +0800
Message-Id: <20210517095513.850-8-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
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
index 98f793bc9376..efd0cb3d964d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -542,14 +542,14 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
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
index a1496c596120..1dd8e07554f8 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -565,7 +565,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f311d227aa1b..281f768cb597 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -245,7 +245,7 @@ struct vdpa_config_ops {
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
 	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
-		       u64 pa, u32 perm);
+		       u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, u64 iova, u64 size);
 
 	/* Free device resources */
-- 
2.11.0

