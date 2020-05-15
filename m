Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF841D563C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEOQiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:38:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45511 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726226AbgEOQiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589560691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gZ5R0zPx7v8Q5QUl+dC4PL1yY2tt7RqoIbj3l8sE74=;
        b=WBNncdt1WHG7GWcgKVRt8rt2N13DCbiK6q+AhKuFHyxo8eYJoWkD3WfJe9AhscTQZZ1c8N
        v3G6VXSanEy6EWYyKsyKani4y+JKU7MEtNG9LEXFRSk3jaDt9PdVlpJeHDi9brC8qCHLeZ
        pFOftlHi3VNgaeNNoDPULGVZxFLpLRs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-eTjirXGAPGCL3FkQGzQiVg-1; Fri, 15 May 2020 12:38:10 -0400
X-MC-Unique: eTjirXGAPGCL3FkQGzQiVg-1
Received: by mail-wm1-f71.google.com with SMTP id l26so1236237wmh.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 09:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gZ5R0zPx7v8Q5QUl+dC4PL1yY2tt7RqoIbj3l8sE74=;
        b=Wj6W0WdNxTljPc/ozAqcpJB6AvOFg8vT6Ib2pO5kW4ZzLEMdUZlnYbVnKWZ2eGvSIC
         Cvd7keNHmzT0Byx/cz5m5Cj9daGFKgpHK+rdJyGGYGaD1KH7NZiJ0uVwokKnoI7hl5J+
         DhIIVl4nTiXD/PPYwDkWvJkcD6vYlDve1TVpqpJOiRiqeR4B36uNCIQaMGDsnUW5m405
         S6XNJJvi837DQ5720hENEw0l1iZy5bpGqHGMDl4Tc+ZHu55ulBsPR8VLH9n5VEUIYhV4
         NriVeJFq76qaThknzusTgVxfa6+txtbCVSVnlV9RhdTCDUCTIILvmAT2ejq4hQHFAtin
         rPEg==
X-Gm-Message-State: AOAM531kS27gcV/N65OXTzmn7HbGRI0ryuHOJSQysMZbOG7OZ4+Z7BLT
        cdh6wZwakiADBVUdAk1fX9I47IV/IbJELyDfEHK9xO34CaSFJVqLj1ABhxAeLlj+U5zJ2sjeTxK
        KbUicmDgVfYVnCLdYTU8HCrjakA==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr5068324wri.165.1589560688994;
        Fri, 15 May 2020 09:38:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF+hp4GbO5uog6iIPuueL5jjs4PZEKrB1UaoTN20cj9bx0TDVFE81Yzd2+7qty/BxbZXjrMA==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr5068296wri.165.1589560688701;
        Fri, 15 May 2020 09:38:08 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id b145sm4680274wme.41.2020.05.15.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:38:08 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] io_uring: add 'cq_flags' field for the CQ ring
Date:   Fri, 15 May 2020 18:38:04 +0200
Message-Id: <20200515163805.235098-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515163805.235098-1-sgarzare@redhat.com>
References: <20200515163805.235098-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the new 'cq_flags' field that should be written by
the application and read by the kernel.

This new field is available to the userspace application through
'cq_off.flags'.
We are using 4-bytes previously reserved and set to zero. This means
that if the application finds this field to zero, then the new
functionality is not supported.

In the next patch we will introduce the first flag available.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 fs/io_uring.c                 | 10 +++++++++-
 include/uapi/linux/io_uring.h |  4 +++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 979d9f977409..6e8158269f3c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -142,7 +142,7 @@ struct io_rings {
 	 */
 	u32			sq_dropped;
 	/*
-	 * Runtime flags
+	 * Runtime SQ flags
 	 *
 	 * Written by the kernel, shouldn't be modified by the
 	 * application.
@@ -151,6 +151,13 @@ struct io_rings {
 	 * for IORING_SQ_NEED_WAKEUP after updating the sq tail.
 	 */
 	u32			sq_flags;
+	/*
+	 * Runtime CQ flags
+	 *
+	 * Written by the application, shouldn't be modified by the
+	 * kernel.
+	 */
+	u32                     cq_flags;
 	/*
 	 * Number of completion events lost because the queue was full;
 	 * this should be avoided by the application by making sure
@@ -7834,6 +7841,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 	p->cq_off.ring_entries = offsetof(struct io_rings, cq_ring_entries);
 	p->cq_off.overflow = offsetof(struct io_rings, cq_overflow);
 	p->cq_off.cqes = offsetof(struct io_rings, cqes);
+	p->cq_off.flags = offsetof(struct io_rings, cq_flags);
 
 	p->features = IORING_FEAT_SINGLE_MMAP | IORING_FEAT_NODROP |
 			IORING_FEAT_SUBMIT_STABLE | IORING_FEAT_RW_CUR_POS |
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e48d746b8e2a..602bb0ece607 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -204,7 +204,9 @@ struct io_cqring_offsets {
 	__u32 ring_entries;
 	__u32 overflow;
 	__u32 cqes;
-	__u64 resv[2];
+	__u32 flags;
+	__u32 resv1;
+	__u64 resv2;
 };
 
 /*
-- 
2.25.4

