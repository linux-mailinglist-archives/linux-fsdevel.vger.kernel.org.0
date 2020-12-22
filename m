Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6832E0C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgLVOzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgLVOzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:55:13 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46669C0619DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:54:15 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 11so8600831pfu.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9QaV72vU0CvP07zYk0PiJX0syKXtEW/bOjBuLetYtk=;
        b=QGdRhTvWGjASw4KPz5cS1PAdxZ5xnZujqR/4keYRXM/ymbfGS/4H0xWjmE8YH2W6HW
         wOVIAgmXP0EBl1F5GevwY1TaUNxf+JMdPVLLSm1Xz+wsbPzo3bYX6UAvCyqavxglbxjp
         Yq2bJ2Km2RaIb9X9jNxydNbD1bHUgVVk52IeiKSyF9KCH29MxSdJ6qmwNucaScvwGuV1
         UmnsqJazjPyTeK7EY2Ogn++cHBlZRD/LtqjAjMjpQi7nMDUbka3/svou4lGQCBA0VGnd
         cvhxjN+BekT7sb4+s+0OHSRD/zjSeS9/q1sUz+O7wHC74GyL6WAWqLyOGI+jKdGOfVJ9
         z9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9QaV72vU0CvP07zYk0PiJX0syKXtEW/bOjBuLetYtk=;
        b=CUp4weCoq9dxT87nzD9fgGf/fPEz2exIvgwCtPk0zWqZwnFwBJT5gBjMYu5llPieFF
         /rNpG7p6FCmWr188l0nmyJLCsyzq6dxyEQYXu0gywOXpKEfEcwfk/W+B2TUbb551n5fg
         kBTzs8Qg99vcuKeOmqrqjp51CzDiSO5HJyfZUegyVzoLAtzEFcGRcKdq8s004PSbQSWx
         rrW2f+lCORVxAcYT02lTYChdDIwvBIqDyzkSG54gerh/BK4T/a8cmTVK5Skl3J9zjr8Z
         JHtdz5vdkJ4/jZ2py58tgO+KjZYerJnAVLNiFuCjQMyLJsJlxfqPT/ptBXIKIqSSxJ5f
         7Wiw==
X-Gm-Message-State: AOAM532EdPpBwSgoVcsYBs8/ZyEOIwyIxMK93uvNG87noJJlWlmhL2cD
        ImGZjhGfGhvuAV6QQ++5JHog
X-Google-Smtp-Source: ABdhPJx5JeOIN6GE5z/mEIdEo/CLbXeC86N4lOujqS9DPc8dRZ+sjIQX3qlMSBB+b6+0g8MdRv8DZg==
X-Received: by 2002:a05:6a00:13a4:b029:18b:cfc9:1ea1 with SMTP id t36-20020a056a0013a4b029018bcfc91ea1mr19754314pfg.25.1608648854889;
        Tue, 22 Dec 2020 06:54:14 -0800 (PST)
Received: from localhost ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id o7sm22182222pfp.144.2020.12.22.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:54:14 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC v2 10/13] vduse: grab the module's references until there is no vduse device
Date:   Tue, 22 Dec 2020 22:52:18 +0800
Message-Id: <20201222145221.711-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222145221.711-1-xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The module should not be unloaded if any vduse device exists.
So increase the module's reference count when creating vduse
device. And the reference count is kept until the device is
destroyed.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d24aaacb6008..c29b24a7e7e9 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1052,6 +1052,7 @@ static int vduse_destroy_dev(u32 id)
 	kfree(dev->vqs);
 	vduse_iova_domain_destroy(dev->domain);
 	vduse_dev_destroy(dev);
+	module_put(THIS_MODULE);
 
 	return 0;
 }
@@ -1096,6 +1097,7 @@ static int vduse_create_dev(struct vduse_dev_config *config)
 
 	refcount_inc(&dev->refcnt);
 	list_add(&dev->list, &vduse_devs);
+	__module_get(THIS_MODULE);
 
 	return fd;
 err_fd:
-- 
2.11.0

