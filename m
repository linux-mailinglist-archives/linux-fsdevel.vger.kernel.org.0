Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8273FC602
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhHaKiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbhHaKic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:38:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D1C061226
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id bg1so5059156plb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diFMdOjfYo6h4zJjyD4SVBR9esxDRufQId7nejSxKj0=;
        b=h/0vQB1GQ5kCRkKA+OKeKWhYBViHtuUvCnDIgNlp3Rl1rK6gid4kz1WccCKDBoyppj
         nW8iePM5yv+Le+/mKooLhC75EaJWOeyGbdeeejX6i8j0kFJLr8P11dLVYAJS29EOijwq
         7oq8gwD92Ky30Bn9F7GqEmNccFC68IXFEzEbIlQPOGqg20omqhEU+tdYqjMHWpcUwPE0
         ptTwep5fbN1B1d4sDCTnnJc34eUZ+aL+51grrhSIeYTmMySTVFU/QH3wKSeBK6GvLP7n
         vLt+76oCyeThSoaZ0WdNfB79ieaTNYUiDGYPlWdHhEvJNOqc25YMU+LnSJMEdvvfROki
         ClAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diFMdOjfYo6h4zJjyD4SVBR9esxDRufQId7nejSxKj0=;
        b=UDZTKujnPon4fQAKo9gKH+MbTAEMExwalIacW60hvQSRXNuBqu9EEWFBye5KOKO5vF
         HaCpid3gGpPcgDcM3dJ0QNUKIa3J5rzfF9J8HYzA6PIjCE3aK0terh5qJKpWb8XZgYfi
         v8cjIatHemDfj/NT9Pe8InDuqswUmVL22aKHfWlGf+NS+cXOqESYpUra1tcbRWjMavgi
         pXwpkZV+T9ITF7+NMJdkhYrm2ZwOzM4U7ZIE/RU2UNkWktrm2okyYECiIGT++UCSHUL4
         OzmK/dNKwAIiHtur/6JV9EzA9t6xkAHsyosgidsed+USgGrCAjQZt36K/qS0JeEN/K3r
         gmsA==
X-Gm-Message-State: AOAM531YNTLGNj8QyK1BEb09Zb38+WCSZ+r6uba5lr+x4MXLN/krIT8J
        uljd6uYJuDI4mSWxtM+Sb3Av
X-Google-Smtp-Source: ABdhPJzY7oJmp/uIPxSUZgtEg1+HAFTNWko93ZCqe+QEaeViM8cL6hRzsUg06AjLq7lUF781LAQOxg==
X-Received: by 2002:a17:90a:bc98:: with SMTP id x24mr4737740pjr.51.1630406252621;
        Tue, 31 Aug 2021 03:37:32 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id n14sm2846617pjm.5.2021.08.31.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:37:32 -0700 (PDT)
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
Subject: [PATCH v13 08/13] vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
Date:   Tue, 31 Aug 2021 18:36:29 +0800
Message-Id: <20210831103634.33-9-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
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
index f292bb05d6c9..a70fd2a08ff1 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -555,14 +555,14 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
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
index ab39805ecff1..ba030150b4b6 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -571,7 +571,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index e1eae8c7483d..f3014aaca47e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -270,7 +270,7 @@ struct vdpa_config_ops {
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
 	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
-		       u64 pa, u32 perm);
+		       u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, u64 iova, u64 size);
 
 	/* Free device resources */
-- 
2.11.0

