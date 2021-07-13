Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9293C6C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhGMIu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhGMIu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8A9C0613F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j199so18932011pfd.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdSO+YXsywfBhdOnOREu62bNqEWlUHvrtNpQOS7MuZo=;
        b=hiimUl4DgO1Of4XGPXpdICPYnPm7+QvGfh85ne+O9YqLV4HwNaz1/3GVCexKIIR9bK
         79qC2iFIA2pLQ1nFnXPut8k1vrxiwBlzw8SE6x4BYAMbkEs5Gxh0ltQDnZC1DuhOWaXy
         Y2aq3utptKdeOlIEcc73zmkwyC0gwKsapg8k19yhxOLFoyCxe7DHgO2gP5VdDTqtHx6A
         mJhAVdE2NVFsWzib8FCLBIYmov6tjYXcaVAbydRQY1/65AASv7O0PG98TXYj+Gu12TPn
         VjG1m9HmS0VsQdytCx6vQRcAJNoY4lM6llfjwo4MI5ukWs2uwYJovIc1U/KU7Zz4NCOC
         WkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdSO+YXsywfBhdOnOREu62bNqEWlUHvrtNpQOS7MuZo=;
        b=VegjM2YR17JEIIWOVi4LoJv5794vgk3jMydIL5Ow3FXZITb4z5pBHyaBgZq0K/jpvB
         tlU/HGPLuByt7L8KJwWeQoyzwe02B5+o8oRMTAsw2FVpJQRqg1GjrQA/aIrVbF1cc6W9
         pAZ/HhRORKdU67/zDMJ4Gb5Ciky8G0NvXmMmInxTCmqV979cCTDlmEC0hwbZrFolONBg
         C09OHqHhBIP2BmXTnkT4yRpQsG6wl68NQGvlKgRjTtYvkNPgTiS1htM3EkG0HYmXg4og
         R6xcRE5/F06Em6ujRGPUsyGTxypbZxPlEKrWOWDdrWwedeeMWOPFxPFMXQvRQyeqYf2L
         UDXA==
X-Gm-Message-State: AOAM533BjhTqDrIJPp3uHJfMuFT/al6JrmDfIgdRE164XUzzVN9s+JQu
        Kp/PjYCNeqsa3vKTYfHT0+dT
X-Google-Smtp-Source: ABdhPJzmFohN6vUcKF8KLIan4JZVjJ6TYDpkl96NawoSdWhjfLM6wpCarQvAfJbCfQIvaaP5xnDdBw==
X-Received: by 2002:a05:6a00:2:b029:32e:3ef0:770a with SMTP id h2-20020a056a000002b029032e3ef0770amr810552pfk.8.1626166057836;
        Tue, 13 Jul 2021 01:47:37 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id u7sm21390626pgl.30.2021.07.13.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/17] vdpa: Fail the vdpa_reset() if fail to set device status to zero
Date:   Tue, 13 Jul 2021 16:46:43 +0800
Message-Id: <20210713084656.232-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Re-read the device status to ensure it's set to zero during
resetting. Otherwise, fail the vdpa_reset() after timeout.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/vdpa.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f822490db584..198c30e84b5d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/delay.h>
 
 /**
  * struct vdpa_calllback - vDPA callback definition.
@@ -340,12 +341,24 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 	return vdev->dma_dev;
 }
 
-static inline void vdpa_reset(struct vdpa_device *vdev)
+#define VDPA_RESET_TIMEOUT_MS 1000
+
+static inline int vdpa_reset(struct vdpa_device *vdev)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
+	int timeout = 0;
 
 	vdev->features_valid = false;
 	ops->set_status(vdev, 0);
+	while (ops->get_status(vdev)) {
+		timeout += 20;
+		if (timeout > VDPA_RESET_TIMEOUT_MS)
+			return -EIO;
+
+		msleep(20);
+	}
+
+	return 0;
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
-- 
2.11.0

