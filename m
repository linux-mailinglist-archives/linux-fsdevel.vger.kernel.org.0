Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FE3D9E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhG2HgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhG2HgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:36:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37445C06179F
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t3so3845201plg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIBGZakN9k8BoO8YLMnCoI0EQ62bM67Edlzhv2usKjY=;
        b=YB4ZBkJ2UbGmacd15CUj5610iSRVIyAVm76CETlhwePaAGMy1nP4wVboLGC4DJ45kw
         wS034hRrqM5JbLcfYkHr4l64Vo3/J7EvtnF4ZFGz4XKOPCmyEorUa6O2v/DEV3nMMEBS
         u61bKP+sFu957CxpAsLhY0E5+ZnndnrsVtCqI36OjNoRLVQnERyMUuw0KViH6f22atFV
         UXjKMFPdgNpgcD4LFCaQHABx2iEsyXCpIIxTpPuUla8nJAobGV+MuufDJkoSesH1Nm60
         n0AnQe+Eu0XBc/6JOLDRrzfVdrvAKRjfv4rTmabJC9d1ZMzG1tTMB2NX42dPf7u6CP2o
         +Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIBGZakN9k8BoO8YLMnCoI0EQ62bM67Edlzhv2usKjY=;
        b=bXDLN3DyGwfl/bajZE7We2cr4EfIhzErk6Gpr58RSdALp8608uSvP2t7cklJ/bjXq9
         PETaoR7+P6S3mglnF93BPoSNPx8lDbpEQIAE7W860Cs59k1vwsVNpovp/7OU0oQl5oeQ
         GQEjtTtu/g8XBqgbpXvLnkD3F8Znnfp0q5zbR1IhEp3Sf3cj4PXuiLavAM07UXbXD8Sd
         8FtVFENKk5YPMg6o2aFhkuVUswDjf2c18PdM0ksaseVl8b3NrDMONo/v52BYgKelkm/N
         GeLQxZ3aJdFW8OUYtCoet5mSrlFDV44beId7B6fG7HP6+wRykGb3GtiMhS77T/WGBiaZ
         YHbw==
X-Gm-Message-State: AOAM530DgcgUEcMJoJf61jSgUbKMMb59szL1FmkoLzEXVXEoalSkv2DC
        0pUKO7eZzjTOoRHKC3fI/YlY
X-Google-Smtp-Source: ABdhPJxTWwlUeqHVaW44eybtOYtbAcCrpe+XMQRRaXjatyWL8/OnDv5TWZQAFglLde0iZkvroMKDbQ==
X-Received: by 2002:aa7:87cd:0:b029:32e:7954:2872 with SMTP id i13-20020aa787cd0000b029032e79542872mr3825545pfo.0.1627544179762;
        Thu, 29 Jul 2021 00:36:19 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id v15sm2469337pff.105.2021.07.29.00.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:36:19 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 04/17] vdpa: Fail the vdpa_reset() if fail to set device status to zero
Date:   Thu, 29 Jul 2021 15:34:50 +0800
Message-Id: <20210729073503.187-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
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
index 406d53a606ac..d1a80ef05089 100644
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

