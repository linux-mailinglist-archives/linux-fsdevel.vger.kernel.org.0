Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0281C3F037B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhHRMKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 08:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhHRMIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:08:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4FAC0613A4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:07:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a5so1665716plh.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPU5oouwG2zcS8yvvUNrpx7q9K6y4xHU7Uj02CjZsZk=;
        b=UIWajj907fM0ya/crIoSMA1C7IpAGpoZSfmlQTaOLvISGvbNFliV3lOWPPV7xgNTKC
         ///b6XBGp1KvZ9CFR5EDvB+iY8XK7q5BtmHgdPSxm0is9Ir7+fd3zVC6w2DwDTEAbtrm
         aXFyY+6LngaMYmQURkXGu8bIDVf2cHUiYyOhc0AUrBN9LcQcv/0QMBHguEh1ZX+LEY7W
         Jus0jgcLotsjcZNn8zQzYSratENyXmrF5ayCDbruWXSVk6RPn6VbqirsJTRAOhiJDWUa
         INgeynj5RqY+//cZPxLAtP9nVLS3O4toWE0mSMYrs7zBsSEyJ822UYQ43/JzCCXOorjJ
         p/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPU5oouwG2zcS8yvvUNrpx7q9K6y4xHU7Uj02CjZsZk=;
        b=DQ5+6VFL7arEpzDstMDtYzj90jek0Y3KEyEwXhu9AM2WPKxnkFtzqd1JjaXCIaBiiY
         fq/dCpxM38kM8xfCO9r82/sjHQr1OGdAESwOMC6MCmcxei7w/PO81gP6ohiQf4M6+Cxz
         GBtU81K3TLXHzwsFdWp/9hUR1ecvfsjitQQwK5kPc9kMWFVn9cplAR3D/N4eJcysWggb
         aJCs+8U6Pq2w7mtXq3S9YhXX3sKrYt6Si0aqDr/w52HGyadhZqJ+yXSwF2mp9t7yCNBD
         7SxLGx5ih6cfLUKan7W1EeynfOI4hu7IXSZwrAnqxUgZdO79LRnH6ZtOPBX5ewgDxzct
         lBaw==
X-Gm-Message-State: AOAM533UqrELA4Ie6/iVY7JCBPQc9Emx36ef6CDfosrkblDUwz1yPXFU
        GzUMbxEsvxHgsB3Q8EqmtO04
X-Google-Smtp-Source: ABdhPJyML7UjoOGnuzKUl0aecwVHSiqfNHLfBBbNYh0kHidbXZ6/zSyvUYwI91BMoTSfE98d6IjB0Q==
X-Received: by 2002:a17:90a:8c05:: with SMTP id a5mr8717233pjo.95.1629288476402;
        Wed, 18 Aug 2021 05:07:56 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id w2sm5014486pjq.5.2021.08.18.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:07:55 -0700 (PDT)
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
Subject: [PATCH v11 03/12] vdpa: Fix some coding style issues
Date:   Wed, 18 Aug 2021 20:06:33 +0800
Message-Id: <20210818120642.165-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818120642.165-1-xieyongji@bytedance.com>
References: <20210818120642.165-1-xieyongji@bytedance.com>
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
---
 include/linux/vdpa.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 954b340f6c2f..8a645f8f4476 100644
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
@@ -353,25 +353,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 
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

