Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555673A8277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFOOTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhFOORk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:17:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D21EC061153
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y15so13364661pfl.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
        b=teEC3X5118RCoqRjDpVinxrBxb/ZnCm6ryA5hTE///DNJNJIJ7ry41IlzLM/WQ5RZi
         5rM29Gvy1WbJsWL0k3ucFdrxybEvdyBmK744/4SAfTdXMBCd9dtjzdV6h4lNYp1H3YAe
         RaY/wxthVmrWQYX778EfdTQbqgDLnqWYzbbAUF0xXFFqFVkE4KxZ564GQjL0iwdHK9zR
         QipmY/L7g/sua/MKoU4gAbpjYDQ8XMk0LrElfchchmEY96U4NRRm7211KAJCMtvD/tLG
         2zK0nUfsHKDTzh/XdBfdvD4OZrzHRQtNECYGSoQtBcAELiDzP1QZt2UELiaroy3e2M1k
         QF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7apvPbQfTG1FYg2uNsocmvMG/QdC7c4RuzNmrGKxtc=;
        b=rcBrO+1ozTXpwj1rk0P+DhH5sBKHkNYSwCiqyAu6k5nXnoa+jP1Lb6uIO6U1liQs4K
         hGotGVlBXxxoEw/QqBeWFVWfFDP5YLq52iLZyqCNZS3OPdOrmTVo3S9D/ZmM6XL2cbU3
         6Nmd5NzAfwgvkJUhhe7wsHXgmG63RuqKN2ERSQEvbJ8IwvyOFo5Az5QevF4JGcwvHYMF
         gJg48gMDOP26RhkEZhQjG+Ra7AjNRQXaLwew+jLrMVOc6OyO+bJG/lKIORwQqextGh/K
         JUpltkd/8pMfJD+uoDkZ/jUYmc4lnJ1VgtO0+mSdu7KRNdkGifrmea4/RL7ImiO//Blq
         SF9w==
X-Gm-Message-State: AOAM531VYWF2p3IQccC8i7P2Z25ziDuBPw+Kdw+iIUSWFCXJqZoLWk0F
        CclVtoznkM4P2TW7DiQUKw7l
X-Google-Smtp-Source: ABdhPJzJT+1d1E8F4L3uwEMXEuWS3/RAonqjFcnOvR03YvpVA7eJh794mNzTaDsLprM6LBC/PxXhrA==
X-Received: by 2002:a63:9302:: with SMTP id b2mr3039614pge.277.1623766446912;
        Tue, 15 Jun 2021 07:14:06 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d8sm16097026pfq.198.2021.06.15.07.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:14:06 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/10] eventfd: Increase the recursion depth of eventfd_signal()
Date:   Tue, 15 Jun 2021 22:13:24 +0800
Message-Id: <20210615141331.407-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Increase the recursion depth of eventfd_signal() to 1. This
is the maximum recursion depth we have found so far, which
can be triggered with the following call chain:

    kvm_io_bus_write                        [kvm]
      --> ioeventfd_write                   [kvm]
        --> eventfd_signal                  [eventfd]
          --> vhost_poll_wakeup             [vhost]
            --> vduse_vdpa_kick_vq          [vduse]
              --> eventfd_signal            [eventfd]

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 fs/eventfd.c            | 2 +-
 include/linux/eventfd.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..cc7cd1dbedd3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -71,7 +71,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..886d99cd38ef 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -29,6 +29,9 @@
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
+/* Maximum recursion depth */
+#define EFD_WAKE_DEPTH 1
+
 struct eventfd_ctx;
 struct file;
 
@@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
 
 static inline bool eventfd_signal_count(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return this_cpu_read(eventfd_wake_count) > EFD_WAKE_DEPTH;
 }
 
 #else /* CONFIG_EVENTFD */
-- 
2.11.0

