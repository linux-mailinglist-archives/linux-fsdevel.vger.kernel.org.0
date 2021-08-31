Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C094F3FC5F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbhHaKid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbhHaKi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:38:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D91C0617AE
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 18so14573228pfh.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Vl3AHwuQDLe0ZGngtEfFx668CIPSygY8Oaw4ZN4vCo=;
        b=wObpuu7touPHyE2FlMtp6j82DVKvgvJGqxVDpQh426PCA4G0/SKGQXKEyHJVZQ8cIm
         L9XkoweTnt+6I4BW0Mn5WMJvosr3G5o8gM7IIYvH3KGm6heQlvcQObzommcU8i7cnUT0
         QRgkYd46omJIk7r6/K6p/cRey3grFpdCYxr0txvNQ+lkyVHC2OMROz/ezIQJEf6W9yvR
         2jeQJkG2XFVufs6nY4wO6FwV8xejE3tq1kLU6PROTvNysrRr7cvUwW3cLlScU5q9AQEA
         thnUcb8QN1ab0y0YDAkUPLMGlydGB6EUB2ANfuVz00VX5Kyh4O6qNPMi5OPi5yf/pyIu
         26kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Vl3AHwuQDLe0ZGngtEfFx668CIPSygY8Oaw4ZN4vCo=;
        b=eljhxnzYGx1VcdrzVz210OeEqKlxJG/0gM5/iyxf4IzwPg5V0q8tQRnM+ONkENGIrC
         J404sbK6PsYhHbC3dNysmzi0s5OyIudwktYLQQ4BrYaCfMzRun4x34xQxAeqP0v/j1ae
         sF79+83H9AqIWWty925AAzA/Cd+VaZvL5fIwwM3NEXfEhCEOfWCwKnZmWi+57Kq78FB8
         ZDt4Iyv80R0XI0MG1s0ngpFNKcgkSqFUjd+pts7Vd77q8dHlWFr1xAJ3UaEBJhi52XK8
         vh+n0hKCUx3b4/FsZwZ1nWFI1esPRCToNvOaOfIzVH4TDDEYIdfgQSYzlt0gsK/xrMQz
         bsTA==
X-Gm-Message-State: AOAM531LLyWu5awSUUtLxFcVW0e/5C/trEly/GKtBYkGGiodaFZEdoDd
        KSXUO6EjnyjsvI/+z84aW5Lr
X-Google-Smtp-Source: ABdhPJypZEfGrqo1WgyHIL6EcT5LWw7WqnAwRGMuQX/YOGdJQ19c5iZukJRXGO5wvdTG9X6CBrVIsA==
X-Received: by 2002:a63:101c:: with SMTP id f28mr26080762pgl.330.1630406231592;
        Tue, 31 Aug 2021 03:37:11 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id x15sm6941154pfq.31.2021.08.31.03.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:37:11 -0700 (PDT)
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
Subject: [PATCH v13 02/13] eventfd: Export eventfd_wake_count to modules
Date:   Tue, 31 Aug 2021 18:36:23 +0800
Message-Id: <20210831103634.33-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export eventfd_wake_count so that some modules can use
the eventfd_signal_count() to check whether the
eventfd_signal() call should be deferred to a safe context.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/eventfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..1b3130b8d6c1 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -26,6 +26,7 @@
 #include <linux/uio.h>
 
 DEFINE_PER_CPU(int, eventfd_wake_count);
+EXPORT_PER_CPU_SYMBOL_GPL(eventfd_wake_count);
 
 static DEFINE_IDA(eventfd_ida);
 
-- 
2.11.0

