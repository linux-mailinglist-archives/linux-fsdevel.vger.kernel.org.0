Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31692E0C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgLVOyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgLVOym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:54:42 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505FC0611CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t8so8600333pfg.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+KX9u3Abf2VaAB0ChYfsiTC4EA7A/XVpJpOtaXLZNg=;
        b=RGHRZjZIVayz9n2bH+s5VxcphoRNB6EjtioSPm3q9zqR5I5BqVtwnrV8pgYKqeqHnm
         43mgXLR4pAMh9CrRztma2Te5gSb5r4gA3yJOIXaUQ5kHiQ/K7KwFA3vieZRkbZL/S59j
         lnBjSLqJJViqRGqArWEAmBOTmQw5Aq019qO8dPIGbijaAQ7zM8lUi5IStIOHJc6wLFF7
         RKNaCixCROQer93r12yM78PLhxtltjTuaDk+YIJkrJMpgz/eyAfDVT9IZL/CNmara2t1
         CAUuLUQqtp+VLCtSvtL1rEERVZzBSRCPBmF4bFAsNYMlG4RaX+xexzSS9EkQgKUYfBkE
         okBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+KX9u3Abf2VaAB0ChYfsiTC4EA7A/XVpJpOtaXLZNg=;
        b=IucAIS5IKfasPHvZnr8mr9hg/H3vIpAgClmEFoY9mbOsLiyuOppMsdzWkmisjxRFeJ
         XGz867+uZkskc6YKK9ptoix4b7IqxlnaG6g/3dgzG4CG3/XDeprUKYGsRWS02ijXjOlP
         t+n2FBlAXuujrPR7eHPgmsmVS/X093wIYH1hJGumMK5RaUnztiHkz2xQJ5LCA0ioiMJh
         I3/AcsfQfy4tMppxiLM7Zp+xaccrCjuEI7X1t50CvhlPUcXM3X9M0N723EdxDuKXGRZz
         wXuVrxFFrLDQeygcJoWyqVWsZcCvaFdAH6E6NR7PEh3tM0avrY1ER5tJf3LJLMVJsUW1
         QEbw==
X-Gm-Message-State: AOAM530DppUmRTOEjIG23nPgkPDRHPkM0tT9dLkikbOgdFNTW41W3owK
        FIXyLkZYK/kxmaYU8XVe3bxQ
X-Google-Smtp-Source: ABdhPJyo3jyzLMBLqhtiWMuYrhGQuRDVvnQQliPWpgSi4NpWg5z746QRc3ePj3eImUuMthk8W0b8Dg==
X-Received: by 2002:a63:1f21:: with SMTP id f33mr20004821pgf.31.1608648817910;
        Tue, 22 Dec 2020 06:53:37 -0800 (PST)
Received: from localhost ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id t206sm10924592pgb.84.2020.12.22.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:53:37 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC v2 05/13] vdpa: Pass the netlink attributes to ops.dev_add()
Date:   Tue, 22 Dec 2020 22:52:13 +0800
Message-Id: <20201222145221.711-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222145221.711-1-xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the netlink attributes to ops.dev_add() so that we
could get some device specific attributes when creating
a vdpa device.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa.c              | 2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 include/linux/vdpa.h             | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 32bd48baffab..f6ff81927694 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -440,7 +440,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		goto err;
 	}
 
-	vdev = pdev->ops->dev_add(pdev, name, device_id);
+	vdev = pdev->ops->dev_add(pdev, name, device_id, info->attrs);
 	if (IS_ERR(vdev))
 		goto err;
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 85776e4e6749..cfc314f5403a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -726,7 +726,8 @@ static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
 };
 
 static struct vdpa_device *
-vdpa_dev_add(struct vdpa_parent_dev *pdev, const char *name, u32 device_id)
+vdpa_dev_add(struct vdpa_parent_dev *pdev, const char *name,
+		u32 device_id, struct nlattr **attrs)
 {
 	struct vdpasim *simdev;
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index cb5a3d847af3..656fe264234e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <net/genetlink.h>
 
 /**
  * vDPA callback definition.
@@ -349,6 +350,7 @@ static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
  *		@pdev: parent device to use for device addition
  *		@name: name of the new vdpa device
  *		@device_id: device id of the new vdpa device
+ *		@attrs: device specific attributes
  *		Driver need to add a new device using vdpa_register_device() after
  *		fully initializing the vdpa device. On successful addition driver
  *		must return a valid pointer of vdpa device or ERR_PTR for the error.
@@ -359,7 +361,7 @@ static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
  */
 struct vdpa_dev_ops {
 	struct vdpa_device* (*dev_add)(struct vdpa_parent_dev *pdev, const char *name,
-				       u32 device_id);
+				       u32 device_id, struct nlattr **attrs);
 	void (*dev_del)(struct vdpa_parent_dev *pdev, struct vdpa_device *dev);
 };
 
-- 
2.11.0

