Return-Path: <linux-fsdevel+bounces-65653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BECC0BA4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 03:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0835A18995CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 02:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0A32C158F;
	Mon, 27 Oct 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CI4KikoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B182C028C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530591; cv=none; b=feIFbr5YebGwSdxM+t09Nk4hkVAXyrjE6eITQWfZ/Oc46C8n0F95Zs3WXMiWVlfNixVo9FmnpkVuHYYj2U4rRoocrGp62bhlb2NY3aLHCbdGhMO2U+DJVx2xdyJqTlvKbkuvqeV9st1XWVEaJr/77MFG/1B4A++dHQh17nqb19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530591; c=relaxed/simple;
	bh=5e89GXt6DhKyASePnDrD7cthV1505P8u/yKg4DMfB4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7sJCCF1fhir1/sobP+9ri6CRCWGJMrmDBHg4L0WMoYI0uSgIqHjc1Zv0ABPHdCgQ1v3s93FUdHLXyybbREq3ex1Fx9wWZlYAqF6m46UzJI3l9GN2NJJa9nbMKPB3iJbAaZv6qnRtGmELrfawcQQbevUTTst9x56rix9KW+2V2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CI4KikoU; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b6d4e877915so79567366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530587; x=1762135387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=CI4KikoUMv2kLig1ndQImQ4XDPLt6YUXo3EKj+TA37dW4Hl1jUQcG4yK/soiMR/Twb
         OGNPYd11RrSV7u7Vnbzdp1BKP3+ifcbi+6VhsFmFOlATUW/d3DbIXWCmG7CwicpYsbVY
         Jr7bKDB9FHV3rws2u2t6oDhpnGoeWkQwm/Bya0+pRmf0sKJddJMqrT7j6EU///so4BvX
         CQziT6FS8AuGAxTc7EaCVF7zScilXF7LB64WmC3yWZiw4nRZqRgYkNBp3s/V73onlQK0
         izlq9nsLZdSfT6MA1HIYLi8Q23W4R5UmWlJqC8oLX8TSjBN2EZdt3fDi0mtKCdnQ6Pdm
         AKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530587; x=1762135387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=D2z4d3qlWQC2X5bnMucpNJITJzaPckSzVtVD1F9iIJCoZXcqbY37aKkuBfOC1ZPkRV
         scdztvFxpcO+pGuMU9HPJYtT8CIuTdYOqcc4HheV6JqZGOUF7gfWGd6zh6tEkP8E0WmG
         qQQoFhorwtVG/hK64cAcVZVN+WWkuSFSQbZxlqSJO1lb5ljx4RePRInKd+l4+LK+w4Rx
         OcZt32Opo++fG/ebtOmGc6SdRLCKLByTxwN3lRFSi79EecscuCnuGqLhteiM26ng7+3B
         0OIPgh77Uht5Gg9gsP0aK5GxtPe7hDnOeVcfGkj6o74BJOCpo9F2xRcz3af2y3P6XOQ4
         Ttpg==
X-Forwarded-Encrypted: i=1; AJvYcCUkTQ8H2iKPWM6UsLndPFaQCILNk5cXIrN/65hX7mDdf/RyGD20/CuGWem/53CxV+Nh9EuPqzeBSjgS4Tgk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kXOj001UCJjX7l0WFRysx1/6hw3pBLW4lfm+aw30/PWjKkDk
	BEjD3/fhZhXYiv1ZZG/FIrex9mN8tcLMf3MU1AY7d9jxo7sL3tbNxx/1ClCch5FflAHB75CM1dB
	kwpO1eg3Fl5GyLidwTyyFwdgDhb/btafC6fhH
X-Gm-Gg: ASbGncv+Dgorn0C2ZcKyC1WWhzDZ2T0HGSX2u3GIndV0uDkD7mqYDfL/huUdKdzJgFv
	vcfAyqeTXgma0cwsd9C7U9UsYHCZSMfoOEjwEWzAyrMwgnGzv8Gni9mKP8aKD0EPKY7VnQ29MMP
	ysjN+CN5zGyut1SFGuNpSgb7O/OXhkfx/1cnh2LZhEy7FcayAjz1pMrzR4BIvG7bhlSBzOjrggx
	qwMLwtMrW9ABl/5Oev9dVoiQlk/4oSsRBKYtHhUajEeQr0wmTQTlX3YFhcql7CCDIctbsSDYTeu
	OG9lIcIkiKr45fI3bh/5InWFf0elYLyhfhm7piB2eaUac+avWwaIfMZGljGJolEZaewj75N5J80
	SZ7KLaeJnGhkCY7moo7/13/gyNYrmC0M=
X-Google-Smtp-Source: AGHT+IGMoMb/41FNBYew5aW4eybeQmJ4NZaYT3SIiYCnt1CmEPvxyf464JNfGnI+afMOqCffpcuFgIb+lJb3
X-Received: by 2002:a17:906:fd84:b0:b2b:c145:ab8a with SMTP id a640c23a62f3a-b6c75d2bbb1mr1544924966b.3.1761530587070;
        Sun, 26 Oct 2025 19:03:07 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d85462057sm55892766b.72.2025.10.26.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:07 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B192C340670;
	Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AEC5DE46586; Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
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
Subject: [PATCH v3 1/4] io_uring: expose io_should_terminate_tw()
Date: Sun, 26 Oct 2025 20:02:59 -0600
Message-ID: <20251027020302.822544-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251027020302.822544-1-csander@purestorage.com>
References: <20251027020302.822544-1-csander@purestorage.com>
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


