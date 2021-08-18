Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A973F036A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhHRMJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 08:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbhHRMJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:09:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC0C0611C6
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:08:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y23so2008672pgi.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmTErZoHuljLWy5ftQQYPa0Y5andptGPajJ0BViKZSc=;
        b=E3gyfzX3p6VBgxg4pWT29QlWqOVlMy2BbTsKDlOSqzh+60rUYJOYzZg/a/5H3opHzL
         saLXHrsiT1qdodUTrFNAgvKbawgYE3Zbm7sn9ZpSgO/ujOQBcpFtfGY4XwBjUDn6GNal
         EhHyVOkhOeoCKu7mzikuQ1LEvOCr0QP3Ui1owbajYTEZ06+xgudTTGigvPrJ2d4x58EY
         MmNck5Ubt3Ii6BQ75nMino2+g6g1YOBh3xKoyB6i659GtUm1nXhgpamk38ax4ZDs77eC
         LhhnoMrfcRaaR3SJ/oWEsIHbg5n7LcIB7PTvdS74RYTDsSB0MVlf2hh+yaU9DqxCtMbV
         WlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmTErZoHuljLWy5ftQQYPa0Y5andptGPajJ0BViKZSc=;
        b=ZZxFlR/UJEdYS5ZuhYalwye27FQ+V+bF+GSncx1vGfkxebrDH1Ii2bYudkOD/x3VQq
         RwPnxCC2cK6siOvsdeLdeQ7V6vNgOsXse74e6BkSE3u1ZY+fGWosY4Xhc87ChC4s/gTq
         NZwKY1nkUv7cgDsSEu53RzhXHbhdWTfddZ/fvGcBKuye6vtfck7+AO2v48+Xi5l2WJvb
         RQzlEaci0GRENF/0l1fF0dCCsfiTmlNlNgQSW3jhkJw9fhdLpz6TVEqL5otoXCw2uofa
         HzA2jwJg9fGufrEqxRhDWaZZyzU7vQmOs9HaBPCNYZwdIWD7yyJTEnSmlQCYaqj7+adv
         CZVg==
X-Gm-Message-State: AOAM530gGKF98wkj9Ibb1EGA1cebzPj+YZSGXE4UYfhOpfR7F+aZ/fwr
        MNAUBJwhbTdHJwd+FsaAh20m
X-Google-Smtp-Source: ABdhPJxmHpTevC3n4Gyq6WE+y24vE0c1i9BWHhgK52+NypaaWeKzW65MHbptj1Q4rFojFfdr/JykVQ==
X-Received: by 2002:a62:8f86:0:b029:32e:33d7:998b with SMTP id n128-20020a628f860000b029032e33d7998bmr9257363pfd.64.1629288491854;
        Wed, 18 Aug 2021 05:08:11 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id u24sm6642220pfm.81.2021.08.18.05.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:08:11 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 07/12] vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
Date:   Wed, 18 Aug 2021 20:06:37 +0800
Message-Id: <20210818120642.165-8-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818120642.165-1-xieyongji@bytedance.com>
References: <20210818120642.165-1-xieyongji@bytedance.com>
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
index e30d89b399d9..827d613c4eb6 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -544,14 +544,14 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
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
index d99d75ad30cc..87ab104792fb 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -574,7 +574,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index af7ea5ad795f..18f81612217e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -271,7 +271,7 @@ struct vdpa_config_ops {
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
 	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
-		       u64 pa, u32 perm);
+		       u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, u64 iova, u64 size);
 
 	/* Free device resources */
-- 
2.11.0

