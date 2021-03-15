Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933C133AB0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 06:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCOFiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCOFh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:37:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A0DC061762
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:37:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id o3so1195965pfh.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQwyOgJ8FbVKIyGmYgv1VI8rf3/7i+776SIOH8C9h3s=;
        b=tKC5Kczn7W4GX2DVAtJhGQH7OZ/Y9d5HQGZokltTFvIKjewpr8wlARk9gk5FOOpdyM
         u6azIY9AT5RdJPG56be28vHXhQeiduc8tM0CpBk9BMSctJXkdS1HVd569aB0ftF35541
         In86LSyOjqLfo31fh21uUaSqQsXVZDOp+KOKDjas7vRQjJ0ZAOsHYfW4UaNxC8Zr5gPy
         DLd2kiSTWjC8AqTt4t7cWjtLSMcGSs6gpn1l0Z3KGUQYnFctmVN/MM5pr8HiggThoQfi
         yevqx1dZqd49OTgP9EADlRkPZgMm2AfL/AO2bfmC4Zg9pPqTvDR76CiYtth8OvtWG8BW
         caMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQwyOgJ8FbVKIyGmYgv1VI8rf3/7i+776SIOH8C9h3s=;
        b=iG/h1q0pxmeoMQsCOw5+P2c0YN6l0ji0tT3sr60rJyLkZP13c9rG7bpLHD6Lh9OHbi
         c9zeI9foyPlpADsupm0JZ7QZ06gr7h4CHuJsx3bNBFg92ugXFY0yoVC1lo9tv+n9s8sG
         Dmh7nctMXP0JV92rEWzQa8Jp/4Kiba2kCooh8We8NTZVgZpy4tRyMdi50hSxlrMhWxIm
         NwHdqj8Bwd0CmwVcgJ7EMYiiE4IqNLqn/ddPIXhsDqwcjf6XEaTYarxJfKd70Lojf9KJ
         DxKHzyx7KtvSkXzm9JeR6IxIhK4DS5D6EbVoKOQ8MbZwmXOm7mXVNwd6jIvUhR73p9LH
         sHNA==
X-Gm-Message-State: AOAM530RnEV+4r8ot5XBVbEaTEsTAn4ge34wYrr9lVTeZfEkopvDa5zE
        z++kk7G6p8OSXJU696Tq+z7g
X-Google-Smtp-Source: ABdhPJw90klV/lhgLs9r2kWZa9+r4MKFCLT6x38DG1GBOMIxMW2w5D3Tc5a7icPrhx3yRBOSiAwkmQ==
X-Received: by 2002:a65:5cc2:: with SMTP id b2mr4878167pgt.280.1615786677555;
        Sun, 14 Mar 2021 22:37:57 -0700 (PDT)
Received: from localhost ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id u2sm9282968pjy.14.2021.03.14.22.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 22:37:57 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 02/11] eventfd: Increase the recursion depth of eventfd_signal()
Date:   Mon, 15 Mar 2021 13:37:12 +0800
Message-Id: <20210315053721.189-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315053721.189-1-xieyongji@bytedance.com>
References: <20210315053721.189-1-xieyongji@bytedance.com>
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

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
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

