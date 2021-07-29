Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B581E3D9EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhG2Hgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhG2Hgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:36:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86F9C0617B0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso8018013pjo.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Luhm9TAVP2wsLg1TvJFQP9kHuyEtOYvhVNQ1V8OHfQ0=;
        b=wFCV4SBCXk5621fdFr55sUuwMMbmIgTgY/rtUdXbW3xvNzAaZ2rL+ez1VeGAW96pA3
         wTub1rEunVnzrVZ+QhEgGsPZyDe6h1lwSFhkPHV7txnkJkEaxRGzEd7qlgM6+KrU54RC
         RIABMezMY+9/7jd4fFE6hAZGKYA/7DgtLjBpuNMPXH81H18MjVxlBG/RJJh3gk6Yr4qS
         TE6Amax82kmf6u0GMsZvZBRonygQ0ViZrAJ4IKBjmuhMU5deWYzHZ1HebLjzHXDoWbcN
         xK/THnoSQtI9V5WWj2+phY/JzTjnobU+hrzH2icQzEbd7QDXO2gvO2nH2Dm7fln7p90e
         5rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Luhm9TAVP2wsLg1TvJFQP9kHuyEtOYvhVNQ1V8OHfQ0=;
        b=grK9IhDyRi6fRn/DLgEcZe72WVB1e7fkauVdevA6iWzGehO8iv8H06XnBari1voA/8
         9o7+46IBo5AVUACPEHT/tJQMMNjxHHsHXkOzZB0ZlLFcGQeGFyr7EWkrCDQX03iCK4Nm
         yHRWdAbYcNoyv+ldhPBIt5jR6fGtt13wd2H+YQqX1CjNdmI2yNxQc5BeVFK0J5xleQrR
         GUthrNN+49mCqmeFDDac5cvi6nb1559h1a93MnA9EI3kI0StMf4WaR2E/uhmpBMjmO5S
         zRPzXCR5tUUMk2r6lnXIbtxwd45PPKIlc0mCaHLrcwaERxxX7EswkQMWhVonls9IC7ty
         h/wQ==
X-Gm-Message-State: AOAM5312IEfK7lT1mO4sblNZ4Vi14zqfYuXnvRShr7P97YYCf9GoBRHx
        649zfE5sezDDfogbXS9uz80e
X-Google-Smtp-Source: ABdhPJy55TZBFCrNFJg4WwvBWq2FhbimstBp0qiEjol4+eO0MEa2OTmyjosxt7zxacNnQd7bldoYCQ==
X-Received: by 2002:a17:903:31c3:b029:ed:6f74:49c7 with SMTP id v3-20020a17090331c3b02900ed6f7449c7mr3508604ple.12.1627544194419;
        Thu, 29 Jul 2021 00:36:34 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id y35sm2412706pfa.34.2021.07.29.00.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:36:33 -0700 (PDT)
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
Subject: [PATCH v10 07/17] virtio: Don't set FAILED status bit on device index allocation failure
Date:   Thu, 29 Jul 2021 15:34:53 +0800
Message-Id: <20210729073503.187-8-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to set FAILED status bit on device index allocation
failure since the device initialization hasn't been started yet.
This doesn't affect runtime, found in code review.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..a15beb6b593b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -338,7 +338,7 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Assign a unique device index and hence name. */
 	err = ida_simple_get(&virtio_index_ida, 0, 0, GFP_KERNEL);
 	if (err < 0)
-		goto out;
+		return err;
 
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
-- 
2.11.0

