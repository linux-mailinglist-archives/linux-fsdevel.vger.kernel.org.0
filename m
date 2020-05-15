Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7020B1D563D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEOQiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:38:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30428 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726294AbgEOQiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589560693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZmrRZSpZSImU0ZWw6sQoh3piuQw6gdHG9URSW684/o=;
        b=XIjfRydhU0zefeOxzx4Cq1p9jYq3vcNMShDMZAOeCjJuOCEtGOWhHalu+s9UGULUdM9Uo8
        pJ29HaSuQ3h4zQjarTffc6cdVpPxeUZvoaBKdCvLmm4tI1WAsG8UbezBuH3xhZcTGdSc3e
        AbBr8RlM4beXYACQzMZDjQ83kiamabM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-fKT5OynBMg25p2NPVNr1Ow-1; Fri, 15 May 2020 12:38:11 -0400
X-MC-Unique: fKT5OynBMg25p2NPVNr1Ow-1
Received: by mail-wr1-f69.google.com with SMTP id e14so1434967wrv.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 09:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZmrRZSpZSImU0ZWw6sQoh3piuQw6gdHG9URSW684/o=;
        b=FhFh1+DSFPs9ST5IB6+gm3a+0WZ9PwXB4kNtre+H124KId++dTg8U5cVPzbpnZmb5j
         8yDx1wYb7KlqO+fgk5juJFtdeweEhCnjFWjhbOP3/A0kEDBbdnOoc4EZ1bM1CF84AowP
         DTzSFaZ1JKQ+2+cKqjPNqNVAr9fmV7x07qaRCkjAONTDSmDfE34DzTSp0RPA4EcR3oPA
         jZl8MCUocLlINiLb7bejjbP0NbrhktUAbDLnFG3asYl7DCHcj3KH+fs/QVgObxxv/0I7
         pDBBq94JQkeiShDqmAcRD8Er3SMWVhqai7pZcB/ggWpsDXBJZ6c68IsocIU07pZ/CELC
         kf4g==
X-Gm-Message-State: AOAM531NGtJctSmcRDcZNCWFDYjxE7adsDjfvDEuUdmuj8eQSEwvKCNK
        TN++sy9jogtdiViZ+6TlmHcZ/QgcXX3Y0ExKGj6OCE0llO5QkOWGBzXmS/R60TiTWJMAlYHcuxy
        gHVDOABOmDVYP0K4RmyQiUKiGaA==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr5379928wro.255.1589560690177;
        Fri, 15 May 2020 09:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHkK+pYRdkGRoBHu7DvxKUQxjk5W5DN2qukBf2VTAqpWYC92WZ6RC31kIRR64YG+MD9jnxcw==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr5379900wro.255.1589560689927;
        Fri, 15 May 2020 09:38:09 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id b145sm4680274wme.41.2020.05.15.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:38:09 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] io_uring: add IORING_CQ_EVENTFD_DISABLED to the CQ ring flags
Date:   Fri, 15 May 2020 18:38:05 +0200
Message-Id: <20200515163805.235098-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515163805.235098-1-sgarzare@redhat.com>
References: <20200515163805.235098-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new flag should be set/clear from the application to
disable/enable eventfd notifications when a request is completed
and queued to the CQ ring.

Before this patch, notifications were always sent if an eventfd is
registered, so IORING_CQ_EVENTFD_DISABLED is not set during the
initialization.

It will be up to the application to set the flag after initialization
if no notifications are required at the beginning.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1 -> v2:
 - changed the flag name and behaviour from IORING_CQ_NEED_EVENT to
   IORING_CQ_EVENTFD_DISABLED [Jens]
---
 fs/io_uring.c                 | 2 ++
 include/uapi/linux/io_uring.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6e8158269f3c..a9b194e9b5bd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1152,6 +1152,8 @@ static inline bool io_should_trigger_evfd(struct io_ring_ctx *ctx)
 {
 	if (!ctx->cq_ev_fd)
 		return false;
+	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
+		return false;
 	if (!ctx->eventfd_async)
 		return true;
 	return io_wq_current_is_worker();
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 602bb0ece607..8c5775df08b8 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -209,6 +209,13 @@ struct io_cqring_offsets {
 	__u64 resv2;
 };
 
+/*
+ * cq_ring->flags
+ */
+
+/* disable eventfd notifications */
+#define IORING_CQ_EVENTFD_DISABLED	(1U << 0)
+
 /*
  * io_uring_enter(2) flags
  */
-- 
2.25.4

