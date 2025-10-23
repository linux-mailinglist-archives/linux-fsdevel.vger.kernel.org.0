Return-Path: <linux-fsdevel+bounces-65385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B11C035AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D44F2C35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D662D7DE8;
	Thu, 23 Oct 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ce2+7RrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com [209.85.221.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D152877FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250720; cv=none; b=MB4SkU7s2FLHHeA7I8T1V389kG33dG5Or/tyv3cOeky8/oTKFsuST7PpjaUaQss+IjVeAds63Q5i5JX3Zc8Uzwc9ZrNEfeqz2m3o63udnOWhh6DrZVd3RtGzn5JWrIYUfWUEVFnwbJ7JifndFZNfazuSvF0HHhUHOoPCXxY2QgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250720; c=relaxed/simple;
	bh=5e89GXt6DhKyASePnDrD7cthV1505P8u/yKg4DMfB4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieSakonxhxZdMmhVk5Zc2KsH+j0UWO/ziTNqnA51ZStMzNoGRKzcuI8WAMVRK6LslTISXGftT95x6QjYTkymmYLHoAbnk/aFXHvMwiSkyf9W34m8lWO6s5FPGLMrufnTDqeYgFGxDeNBE509wo+7a87MFKupfZcI9H3N2rpik1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ce2+7RrS; arc=none smtp.client-ip=209.85.221.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f100.google.com with SMTP id ffacd0b85a97d-4270a072a0bso225534f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250716; x=1761855516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=Ce2+7RrSDt64qEdAiiM7W8oVRbhsCRxQmw6H+uO9r++8Jr5zF+3c14fhcDeUAUICoY
         8pm039TwNICcmH3sYwyzHtfckVKK9jwA+KS7HWIhMfpEOi90tFh3SNTKj0uwDp376Fmh
         uQThz9o+7YgS/FO7HkZ+AIQL91Ce3Uztgwh3JFnHZ1cPq7PwFpCz76sO63MRY2A0Rf9s
         3hfu8oOr6voaDXiwXUrsQrXwVRZWsqMBubzlBHs2bzloDsRe1q+kJS7P0MndMMgC+d7q
         5LLoD6TlqlHtfsxfzQ5Qnlgt/b1Poh1nlMV0zX/ImVmCMgsN0/UXAx4tuCiX52RkCuQ+
         7sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250716; x=1761855516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=sDwr9ck/vhzCPx05IL9yCDNQoARRH9L29YH3VbVpLvKNzJOf6/qI3UgOdHXqPEZSql
         niNgN/bRTqRCxFwsMOY1ZmRpCp0xRavkjqGGEh1w+idVNjxT2XvzK/eCvTCRzp8/X5pO
         NlNkooL9p345ZcGxNTehTlorX0jhvFDCTXEUAYGKLpZRXDPBQfj8Ehvpy5gDfC7ozytz
         5RqjmRV7n5z8Iq+mVk7fkvQcQKO6dGWT6nRM4JQmJk0fGCMG7e7s7g8KpT/hgdll7Jvg
         zhVc2BYbTe0KG59Z/NnbjeBUmwPMnc+QbRs2Y/NHnab2Nlf2iNOjLaLLs5da3YMU2gLY
         BUow==
X-Forwarded-Encrypted: i=1; AJvYcCVHv+K4l2Gj+P+7jMyOaV17tlJXaDwdDLNeOwkKN9Idve9uCUw9QVBiuHeviCDvTPLFYHJlsY60v0v8a2TX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8/+SuEaXYD9JQGZeL40H7v0bmXj61rPxV2Z4Kj5Zvc/HA1lr
	D7dSJfmcN502oXWKmolhH1UesQ396SscFeLrtgTN2VAeFOHDexgun+kmY1vFPKZY78GHNK0qvl5
	d1uVVesHerTV4wMkSibv5lkHKQhfSRP6bNtw1Pcf/QMmVgrMZq+Hi
X-Gm-Gg: ASbGncs0Ky299AquSJ1vLZU3P7FWS82N5OZeG7sFVm2YJxdmE6bWAWCR6e1c2upe+7G
	j5i2xNLQYl2+GPK4KtknP/WpYLu2bKR/f2Rh3WoAXVSQCO09+EbbVubj+Qf6hn3IeEUCWXcHu7e
	bmOnzM50jgVsYapjjoX8U10w5ol3KPXJ1ETyP+woUIquF5fqNtZEGO5mVdgkEXDuZ4nW+ORhQD8
	xZnBn/Z68AkNv7BcrT8Z76BQ3sCPtQSlwEx7FDB9X+girjmixK+RhSZsN+8bgepvIH4eNC/T74J
	s5qejeQYpOGwIsC6cWo/zRuik5J8XKYvtJNwmaN3AFd8ADLh4GzZmysajJ4TvREcDauAUDMFOMD
	7pigOMyuKGo+0UAQ3
X-Google-Smtp-Source: AGHT+IHWadkx9kp6MhgZHi2KvIKXfztJZsFFBsc7zE5C/VRcCJIv9FwFI0VQ0GJaihcf27tHQSLLkNs29ZhV
X-Received: by 2002:a05:6000:290e:b0:426:ff0e:b563 with SMTP id ffacd0b85a97d-4284e52d956mr4357297f8f.3.1761250716288;
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-429898e70easm248962f8f.38.2025.10.23.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EBE47340772;
	Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E9B1BE41B1D; Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] io_uring: expose io_should_terminate_tw()
Date: Thu, 23 Oct 2025 14:18:28 -0600
Message-ID: <20251023201830.3109805-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251023201830.3109805-1-csander@purestorage.com>
References: <20251023201830.3109805-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subsequent commit will call io_should_terminate_tw() from an inline
function in include/linux/io_uring/cmd.h, so move it from an io_uring
internal header to include/linux/io_uring.h. Callers outside io_uring
should not call it directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring.h | 14 ++++++++++++++
 io_uring/io_uring.h      | 13 -------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 85fe4e6b275c..c2a12287b821 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -1,13 +1,27 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_H
 #define _LINUX_IO_URING_H
 
+#include <linux/io_uring_types.h>
 #include <linux/sched.h>
 #include <linux/xarray.h>
 #include <uapi/linux/io_uring.h>
 
+/*
+ * Terminate the request if either of these conditions are true:
+ *
+ * 1) It's being executed by the original task, but that task is marked
+ *    with PF_EXITING as it's exiting.
+ * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
+ *    our fallback task_work.
+ */
+static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
+{
+	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
+}
+
 #if defined(CONFIG_IO_URING)
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
 const char *io_uring_get_opcode(u8 opcode);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 46d9141d772a..78777bf1ea4b 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -556,23 +556,10 @@ static inline bool io_allowed_run_tw(struct io_ring_ctx *ctx)
 {
 	return likely(!(ctx->flags & IORING_SETUP_DEFER_TASKRUN) ||
 		      ctx->submitter_task == current);
 }
 
-/*
- * Terminate the request if either of these conditions are true:
- *
- * 1) It's being executed by the original task, but that task is marked
- *    with PF_EXITING as it's exiting.
- * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
- *    our fallback task_work.
- */
-static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
-{
-	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
-}
-
 static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
 {
 	io_req_set_res(req, res, 0);
 	req->io_task_work.func = io_req_task_complete;
 	io_req_task_work_add(req);
-- 
2.45.2


