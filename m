Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D601F3F0363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhHRMJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbhHRMI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:08:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3999C0612AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:08:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so2457471pjv.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Upxg8K2RjM27bp0rNDyYgc14eCE3NIhEIdC+t18pOCs=;
        b=lygAyD3Keugif/7sVDBS0Q0WByJtqD55lFbxdT5snDeED0JPyahQ3wtT1oTmd/nNab
         YI0+3N8u2CnAhouYjLrt5FI/zRDPh+xjkeiBRbuBaw4yBwZcdpS5c+n+kJsgc+cZ59YU
         u2oOzgjEWW5Mpxf4M8OXllJPqNvTAuUYwxr9efXDrsvtc2zMeb2R4jci5Q8LkpOkAGVo
         nBYBnmI5yCDv9ZFIP+4XR0Cc3hWps8F6T+lqRcTYBnCHbMgTRfSATpE+zVZrOIiUH/c2
         ZOw4QXOAhQ7R3EWtb2d6awNdUcI8Gp3/S07gCrocQRhZuxHdS/QRSYuMchNsJXeIysoW
         gwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Upxg8K2RjM27bp0rNDyYgc14eCE3NIhEIdC+t18pOCs=;
        b=BvSinQ7q/6DWfC8TAAKrfy/XOrVAp7X71V/7oG7Zd9OCzYLgoOkHqFdGw1zHsmr4ly
         sGo3ndv9rmkzRsuVtd9sWhPUOE2HlfhdkK/Uvd335w93Odl794PZO1rtpAHKvdxTri/v
         QMrfVyQfHtDv6n25ehw8ApQ+ryH5319V+iEMnGacRZphoATd6SWTn3PR4UyH/yI9Bvsn
         RilklvJ0IP/BJvqHi6VQgJQB9EwhcO21XTagLB7ufvL31CGWKLe7p5yqKivCjMLGPJ2v
         4EHlIftcCSRidswzQNlhYm4zfzJ8lgHRK/YVvb8MgOdsfH6kqYLoKGvDuVImhmwT45kC
         y5AA==
X-Gm-Message-State: AOAM530SroSkIcFlnACEGS7DHumuObrxtqChp2AmT22QzU7a4N1y9lbD
        0wpa2BpyIilHe1kZD5mLiMs/
X-Google-Smtp-Source: ABdhPJx2zpHHk/rm1pUU6+vYW29Qy78558N3aIjYPaB+DOhvx26kSUU8EJK1qwKqbMvnWiWPs1Xy+g==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr8962859pjw.0.1629288484275;
        Wed, 18 Aug 2021 05:08:04 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id y62sm6138669pfy.183.2021.08.18.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:08:03 -0700 (PDT)
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
Subject: [PATCH v11 05/12] vhost-vdpa: Handle the failure of vdpa_reset()
Date:   Wed, 18 Aug 2021 20:06:35 +0800
Message-Id: <20210818120642.165-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818120642.165-1-xieyongji@bytedance.com>
References: <20210818120642.165-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vdpa_reset() may fail now. This adds check to its return
value and fail the vhost_vdpa_open().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b1c91b4db0ba..d99d75ad30cc 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -116,12 +116,13 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 }
 
-static void vhost_vdpa_reset(struct vhost_vdpa *v)
+static int vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 
-	vdpa_reset(vdpa);
 	v->in_batch = 0;
+
+	return vdpa_reset(vdpa);
 }
 
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
@@ -868,7 +869,9 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 		return -EBUSY;
 
 	nvqs = v->nvqs;
-	vhost_vdpa_reset(v);
+	r = vhost_vdpa_reset(v);
+	if (r)
+		goto err;
 
 	vqs = kmalloc_array(nvqs, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
-- 
2.11.0

