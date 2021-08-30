Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896193FB804
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 16:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhH3OXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 10:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhH3OXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:23:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E2C061292
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 07:22:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so130354pjt.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
        b=dTsAhtQq0wA+bieSGEDhFMrmBS/2eabwLraiL/FPpYegbrEJYy8SPUl32+FEZA8XPa
         GPzu6BH5ZUc0aGLJSj2InZ9rOImL7p0Z17+KZtU77QqhNDsul6JaCQGjYDdkzteIg6dY
         A62QHOr3RDnu2yPmfoD33iAgUfhLuIdDhZVkILskgC/KWD4gnibrlbu9NLxd+C+19mrp
         G7rSYf4k15oZRsKBY20xXZJErD9GYCVpKtdd53re59ym5GgcTXtcKvn7KVKI2RZWXQ4t
         EW4CzI/NkZ9FSf0lEhr76H5Fn/2sgHktT8riiAHOtBkdW/RPyTy6rDwWYP9n/zLItfC7
         0D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
        b=P8vYylnQwuVqhCOccke+cWfxv31mEY0L4PSJUnNTTGXzmAqrSZwREW0AwkLFDnbbmH
         6wGElKbwOLiPldPteqSbDoShsdDM0xV7eHtQGovBxIs9Pd3Nhj1HtzAidwRyRXe6f+MY
         KtrDut7cw8y2ckBztocUzbCe7azANSf/+yKv4PEJPnZ3tanv3zlTsLtF6M8nXj0MCrox
         qL0BlQ3GdUATTE8Tjy1JJ5LTKr0usl8vzuDAdFqGThMVEtzqjNFbCYC4e002QcKr+MFQ
         sGvhLVKr5YuALf0oSnBDTtf2Hy9EwfxZ26jXEPNzHdHTf64bIkpCqaFW3DEnBxSVu9yu
         s+Vg==
X-Gm-Message-State: AOAM533ZYXplV4nGw+BGIqJCPNB08egjPjbgvHFDGVLFPMBpv5VsNR/U
        o/aGChB5ClDfEA4uL6fPYjim
X-Google-Smtp-Source: ABdhPJwcArvmL0XfQpt3ieNfkp/kbYdcp3OEUwLqP357sEnbfZBLKdUOi3puK46BTRD2uiQCxs3oYA==
X-Received: by 2002:a17:90a:19da:: with SMTP id 26mr32350111pjj.198.1630333328548;
        Mon, 30 Aug 2021 07:22:08 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id gc20sm10539889pjb.17.2021.08.30.07.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:22:08 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        will@kernel.org, john.garry@huawei.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 04/13] vdpa: Fix some coding style issues
Date:   Mon, 30 Aug 2021 22:17:28 +0800
Message-Id: <20210830141737.181-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830141737.181-1-xieyongji@bytedance.com>
References: <20210830141737.181-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix some code indent issues and following checkpatch warning:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
371: FILE: include/linux/vdpa.h:371:
+static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vdpa.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8cfe49d201dd..8ae1134070eb 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
  * @last_used_idx: used index
  */
 struct vdpa_vq_state_packed {
-        u16	last_avail_counter:1;
-        u16	last_avail_idx:15;
-        u16	last_used_counter:1;
-        u16	last_used_idx:15;
+	u16	last_avail_counter:1;
+	u16	last_avail_idx:15;
+	u16	last_used_counter:1;
+	u16	last_used_idx:15;
 };
 
 struct vdpa_vq_state {
-     union {
-          struct vdpa_vq_state_split split;
-          struct vdpa_vq_state_packed packed;
-     };
+	union {
+		struct vdpa_vq_state_split split;
+		struct vdpa_vq_state_packed packed;
+	};
 };
 
 struct vdpa_mgmt_dev;
@@ -131,7 +131,7 @@ struct vdpa_iova_range {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				@state: pointer to returned state (last_avail_idx)
- * @get_vq_notification: 	Get the notification area for a virtqueue
+ * @get_vq_notification:	Get the notification area for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns the notifcation area
@@ -350,25 +350,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 
 static inline void vdpa_reset(struct vdpa_device *vdev)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = false;
-        ops->set_status(vdev, 0);
+	ops->set_status(vdev, 0);
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = true;
-        return ops->set_features(vdev, features);
+	return ops->set_features(vdev, features);
 }
 
-
-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
-				   void *buf, unsigned int len)
+static inline void vdpa_get_config(struct vdpa_device *vdev,
+				   unsigned int offset, void *buf,
+				   unsigned int len)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.
-- 
2.11.0

