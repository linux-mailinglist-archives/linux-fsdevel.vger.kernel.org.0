Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35C33AB18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 06:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCOFil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 01:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCOFiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:38:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE73C06175F
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:38:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id r16so4540825pfh.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9N6blPgH0j2SgVauFBTpGoDtqNcJPr+KXjOwv3Qbftw=;
        b=bQke1R6CukVfwAhiXr8UKtzZtlbiVip03NEyWxemdUzMcuzOuWxzjrI80WHFsHCVZj
         VgWEt2fGfjTrYEG8uMZPpMNaeaanJr+jO+D/Zi5Ou/PJ6A34JwB2gZpuuY/eHRvp8pcn
         sM41UstY2+uSemscQK7ovGhqckuZWPyPosDaEhTdL4I/pEqUWs3yc+BS8KVONE2IHJ7a
         3rnuaO6sJvFi1oUk1bvoSdN8q/7DDhtc2kLevLOOlDRve5wl3S9nDlHvtRGWG8hGZW3b
         vTJcFzqnVfVCLZLt9tk40WCW945DMIswKoLK0b6QuVhV9HPsO7fjWa+5ym4vnv9c0Elz
         +YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9N6blPgH0j2SgVauFBTpGoDtqNcJPr+KXjOwv3Qbftw=;
        b=XxlzAdtztl1WpieP8os6bAb3jZcoKzWIsT5fyYk6D8XvkvuRBUaSuIYEF4nrd7jwwQ
         wXDcSzpa/ZJFV6F55p40G7ev/xsbWls1AknNzMLbRlemDODck6XCUW91Cw0EzUrw/PCw
         +qGRqbTyg+pOcxpl7axZyMcXo+UoObXV28MjykTqKTZzn2/eDw+5cMw2W9bZ2yLwQdho
         sTa0wzhcp0Dlzv/jzxq7qSkHyjTkbBIzqluvhyFvTUVgBIFmWIbCy5fqCN3MBYd5qk+C
         Y7968k/YQTP1igpgYp/gkA+LPF2Q9I6xyep1uBsM3kGeUp6EUI3jJz8n/zA0V9siJOO5
         NWug==
X-Gm-Message-State: AOAM532cWlHrwZHSBYSUlMs0A4XS6i6mlwT/cS4xRpzEal7cGGJmtOps
        738sjdyb9nuJ1H/NBlppobZE
X-Google-Smtp-Source: ABdhPJxGHMGslrX8WILGl9BLpx9s6b9saPzqOKfAm9RjyzmW/KqylQHu/oucIhgrxvBLEkmBY14O2g==
X-Received: by 2002:a62:84d0:0:b029:1f6:77d5:b75a with SMTP id k199-20020a6284d00000b02901f677d5b75amr9025140pfd.2.1615786688813;
        Sun, 14 Mar 2021 22:38:08 -0700 (PDT)
Received: from localhost ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id m5sm12191110pfd.96.2021.03.14.22.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 22:38:08 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 05/11] vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
Date:   Mon, 15 Mar 2021 13:37:15 +0800
Message-Id: <20210315053721.189-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315053721.189-1-xieyongji@bytedance.com>
References: <20210315053721.189-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an opaque pointer for DMA mapping.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
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
index 3f7175c2ac24..b24ec69a374b 100644
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

