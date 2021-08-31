Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB24C3FC60F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhHaKjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 06:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbhHaKi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:38:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C621C06129D
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so2044529pjx.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
        b=IyT/NoploiLL1m73R8JnOX8d0hJVoSoHJLHHsR0hVN4P3tyO//LrM1hHo9MZ9I7dJm
         tbYpBKj4x1li4TYGN1YxbeFtkIngXwdO5YUG0b0t/Ly/YLJV55OII0nScsA9ToHRAER6
         jzCZdTL7N+kRIr1SSlMfn5zmQWZsKKENdbS4gC6iZ3LOfjt6+T5HwZe2PN0PEBUoDMSK
         BEh4YBpcIWrqSSFEOSHzOzRlYEuzu4eEh+nXX7FGJRE1xLCkS5isJSdLfXKOJpC+JCPY
         8LTEwKM15Y1SJh4NtNOZ8eD9nQ3tvkn0ZhHqzIExgXiyEhr/mkdIU47uFDSf0kk1uFD+
         nIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOb5vmojDqQCbnIcWiSlBRwm7/pGzlrCLVRi/6lo5DU=;
        b=aDPualxy8QFqo53IT1yXSqst+oG72hRB8sAmpgbUNYwWicc2liuxr5+C2t7niBIwkv
         T52LpAOCmX0+CcV4OHxWW3F1hLcomsE0aAooI8UceNK692jXlmLCADKu58yid6pU0XGu
         xE+v74ZqY1GI2qHCTt6C+HHP3uxAQsBmar0wf3pJ+C721rvjKkAO/FzImCoCIAo/m1JC
         vYtycTnoAJsLjyiA/lMj/mty+vt4L8KW7YBqIPBgqzoc3ymi3tsLerS1VM4OXreEMEz7
         vFQqBPN9ze2ddMoK5a7hha0ul/ti2Cd1IMEGdhl6xqh0o/L27Qbj0yQNmHEre9V3HVjR
         K92A==
X-Gm-Message-State: AOAM5313ippbDAQnYP+8+K4liQtSirFZ5JGVmawqcg0Y3fSKu9SRvMem
        dQV0VSF6MC+pPOhwHHf8JuUF
X-Google-Smtp-Source: ABdhPJwsEb0F2LDGXnZMhPPIEKLwUW/eoF35j5kV7o83UkOC/ix7knMX7fPB6WYft1GoDjlF8pdFCA==
X-Received: by 2002:a17:902:ba81:b0:132:3a70:c16 with SMTP id k1-20020a170902ba8100b001323a700c16mr4051866pls.60.1630406238599;
        Tue, 31 Aug 2021 03:37:18 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id m18sm2555499pjq.32.2021.08.31.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:37:18 -0700 (PDT)
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
Subject: [PATCH v13 04/13] vdpa: Fix some coding style issues
Date:   Tue, 31 Aug 2021 18:36:25 +0800
Message-Id: <20210831103634.33-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
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

