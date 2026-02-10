Return-Path: <linux-fsdevel+bounces-76770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPGaGoV8imk4LAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:32:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0E115A05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F1903025924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B523AB98;
	Tue, 10 Feb 2026 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nebUW9Y6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E1201004
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683502; cv=none; b=OiYNA5g6H+tTmgEvI233cDAqMRREpU5kWy/pH0q2+ErojqhWCsphHvDyPb6y/S0ShZRQVkYm1JQs4ltobmGMKU9Fw+aHDrbVdwF3iuwWewewhzeljf7flA0eDg8OG+QRFMkMasRMlp52zB7CBdeMy+4JQDaL4clPAWPfM+Olfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683502; c=relaxed/simple;
	bh=dp2zva6XdINCiTjEpcMbColOXMvyIKntsFlV87rumig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXFZUgNJ2LcayOFcjWjqSRbQ1Mfe60+qz9D9AWqNUJ9R6yIrnDwhgGLryaTUIqA4lfcfVGugvI70V28eMPCVxw6ojm65LXYp+ZsQREJLocgdpzTEsi0vNVCk8BhhMUGbaTCLFioshgSea43i0NtTxvibddzzHoUq6eJ6OMAoizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nebUW9Y6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso4323814b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683501; x=1771288301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXVdfIxRj4rkJkTIegBArW50gKoXsTjbuIeJDop4OiI=;
        b=nebUW9Y6WdUU1RRxW0Z88IGirkHYR2VF9P81WMtb0BjJbT42bdrBvfIgsp3vgp8+e7
         geYuiJZvRrhs6LIsbuucK06H5t9ZHXsRteUDTpQMrHx4V8iuC7e5ifKp6UDUCZYD6HQ+
         IPPgDNq5lV6ZZt1KsydtsIbg83GoXr7M3nKGhLc/zg1jdAOo0rhr0bc94nCtqngPXY12
         ea9JpdFfNfrLDftVIYgKGr+rMiY3XfBOoI7vF2DExEpBaSQfKfBoDiba4k7FDl6GxdvL
         x+ZG3ZrTdEUHQyc1oCeG1aYy5w1iEJ/3fjOcDu8UsCVZaT2MWHykmVbSPiLdJLFAVAAQ
         x93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683501; x=1771288301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXVdfIxRj4rkJkTIegBArW50gKoXsTjbuIeJDop4OiI=;
        b=S4CtAnrGLGWjDqCpKF09QHtMz6sRy7YMmRqwMBTCpu566f3JctC0AUIfFY8UVXljz9
         tJ74YDuwb8WHZRBVTDH7DzAkHJSfNvlpCgqAFn1L9Edaiy6rbj82bX7Wxnn/3HQmzwYX
         w9yvhF2H+PMVTuteYwFHu5nOHRe3R0VJN0cTvwX3de/F1E7UQjRy4f6Eu6bBsptivV9j
         RqPHwTOLns7EIXPzMA6J+i3ckLxK8FsUWVnG71+EegsQlZCx+jX9MVpRa0y/UJiJkAyR
         ENUu52tEUnTOHBRnEyLYcTrhzyXC10V7NqmZ6SBOJCsCnxkVrl6EDdF+W5BPWAecqQpi
         suqg==
X-Forwarded-Encrypted: i=1; AJvYcCVr+CDakI8qNWobFmrh6O9vXVroLuT9TnRC6J+gDGzb3swsDA7roDA8RpoV02yR5Ufup/Ppfv1RjKygSS/T@vger.kernel.org
X-Gm-Message-State: AOJu0Yydep+utFDAi7pP3JZi34UTy/a+PdIgAytj9l+dI2oYN+Rhtr0z
	2PgRANbLZ58wRT79+rLZW2i0fqWxdeyH23lZ6wmTGueOVwMbBSv64U4Y
X-Gm-Gg: AZuq6aJYIeAsRe5mEL4mKgUe2VSo5GPQSkiisMsFzgGsozKD+OrZvYIP1BMHKRIZmqi
	wSw3LOJestmj1krUayodz2xLlGuIdSqX41X4A6YIQLsqvc4ZnhRj7pvftI3zqMVcrtXRf6eboz8
	reRwLhDnbsW/PwFwzzakvjEFpXNxdKk7zH71kyatYG01YjiQXufdoV2HiQ71u9hASp0gRGuVhPo
	QhN/MjFm23J6hj5pU94cUws8pyaqKkks5ylmfeOPMl6MDKgjqHAg4BBgS6v85bHY4ZaP2zwfBGV
	7xjZvydDBMJgeAFwp/g7o4yjiR+Z6AjDksCNNyuPvEFhUj1H4dz8wvIQ9JrTCsjhI+e6YOdNns7
	OW0LhIw10H/rHtmCMl2UW9DmPYAeO3AIKpEOaF7zPFQl427iXesKHnCzA+4dIlwfDS5kVY9YyM2
	PElw8TuA==
X-Received: by 2002:a05:6a21:e0aa:b0:38d:fe2a:4b13 with SMTP id adf61e73a8af0-394182110ccmr387084637.77.1770683500533;
        Mon, 09 Feb 2026 16:31:40 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5e406asm14987924a12.22.2026.02.09.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:31:40 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	io-uring@vger.kernel.org
Cc: csander@purestorage.com,
	krisman@suse.de,
	bernd@bsbernd.com,
	hch@infradead.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 01/11] io_uring/kbuf: refactor io_register_pbuf_ring() logic into generic helpers
Date: Mon,  9 Feb 2026 16:28:42 -0800
Message-ID: <20260210002852.1394504-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210002852.1394504-1-joannelkoong@gmail.com>
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76770-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3F0E115A05
X-Rspamd-Action: no action

Refactor the logic in io_register_pbuf_ring() into generic helpers:
- io_copy_and_validate_buf_reg(): Copy out user arg and validate user
  arg and buffer registration parameters
- io_alloc_new_buffer_list(): Allocate and initialize a new buffer
  list for the given buffer group ID
- io_setup_pbuf_ring(): Sets up the physical buffer ring region and
  handles memory mapping for provided buffer rings

This is a preparatory change for upcoming kernel-managed buffer ring
support which will need to reuse some of these helpers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/kbuf.c | 129 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 44 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 67d4fe576473..850b836f32ee 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -596,55 +596,73 @@ int io_manage_buffers_legacy(struct io_kiocb *req, unsigned int issue_flags)
 	return IOU_COMPLETE;
 }
 
-int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
+static int io_copy_and_validate_buf_reg(const void __user *arg,
+					struct io_uring_buf_reg *reg,
+					unsigned int permitted_flags)
 {
-	struct io_uring_buf_reg reg;
-	struct io_buffer_list *bl;
-	struct io_uring_region_desc rd;
-	struct io_uring_buf_ring *br;
-	unsigned long mmap_offset;
-	unsigned long ring_size;
-	int ret;
-
-	lockdep_assert_held(&ctx->uring_lock);
-
-	if (copy_from_user(&reg, arg, sizeof(reg)))
+	if (copy_from_user(reg, arg, sizeof(*reg)))
 		return -EFAULT;
-	if (!mem_is_zero(reg.resv, sizeof(reg.resv)))
+
+	if (!mem_is_zero(reg->resv, sizeof(reg->resv)))
 		return -EINVAL;
-	if (reg.flags & ~(IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC))
+	if (reg->flags & ~permitted_flags)
 		return -EINVAL;
-	if (!is_power_of_2(reg.ring_entries))
+	if (!is_power_of_2(reg->ring_entries))
 		return -EINVAL;
 	/* cannot disambiguate full vs empty due to head/tail size */
-	if (reg.ring_entries >= 65536)
+	if (reg->ring_entries >= 65536)
 		return -EINVAL;
+	return 0;
+}
 
-	bl = io_buffer_get_list(ctx, reg.bgid);
-	if (bl) {
+static struct io_buffer_list *
+io_alloc_new_buffer_list(struct io_ring_ctx *ctx,
+			 const struct io_uring_buf_reg *reg)
+{
+	struct io_buffer_list *list;
+
+	list = io_buffer_get_list(ctx, reg->bgid);
+	if (list) {
 		/* if mapped buffer ring OR classic exists, don't allow */
-		if (bl->flags & IOBL_BUF_RING || !list_empty(&bl->buf_list))
-			return -EEXIST;
-		io_destroy_bl(ctx, bl);
+		if (list->flags & IOBL_BUF_RING || !list_empty(&list->buf_list))
+			return ERR_PTR(-EEXIST);
+		io_destroy_bl(ctx, list);
 	}
 
-	bl = kzalloc(sizeof(*bl), GFP_KERNEL_ACCOUNT);
-	if (!bl)
-		return -ENOMEM;
+	list = kzalloc(sizeof(*list), GFP_KERNEL_ACCOUNT);
+	if (!list)
+		return ERR_PTR(-ENOMEM);
+
+	list->nr_entries = reg->ring_entries;
+	list->mask = reg->ring_entries - 1;
+	list->flags = IOBL_BUF_RING;
+
+	return list;
+}
+
+static int io_setup_pbuf_ring(struct io_ring_ctx *ctx,
+			      const struct io_uring_buf_reg *reg,
+			      struct io_buffer_list *bl)
+{
+	struct io_uring_region_desc rd;
+	unsigned long mmap_offset;
+	unsigned long ring_size;
+	int ret;
 
-	mmap_offset = (unsigned long)reg.bgid << IORING_OFF_PBUF_SHIFT;
-	ring_size = flex_array_size(br, bufs, reg.ring_entries);
+	mmap_offset = (unsigned long)reg->bgid << IORING_OFF_PBUF_SHIFT;
+	ring_size = flex_array_size(bl->buf_ring, bufs, reg->ring_entries);
 
 	memset(&rd, 0, sizeof(rd));
 	rd.size = PAGE_ALIGN(ring_size);
-	if (!(reg.flags & IOU_PBUF_RING_MMAP)) {
-		rd.user_addr = reg.ring_addr;
+	if (!(reg->flags & IOU_PBUF_RING_MMAP)) {
+		rd.user_addr = reg->ring_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
+
 	ret = io_create_region(ctx, &bl->region, &rd, mmap_offset);
 	if (ret)
-		goto fail;
-	br = io_region_get_ptr(&bl->region);
+		return ret;
+	bl->buf_ring = io_region_get_ptr(&bl->region);
 
 #ifdef SHM_COLOUR
 	/*
@@ -656,25 +674,48 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	 * should use IOU_PBUF_RING_MMAP instead, and liburing will handle
 	 * this transparently.
 	 */
-	if (!(reg.flags & IOU_PBUF_RING_MMAP) &&
-	    ((reg.ring_addr | (unsigned long)br) & (SHM_COLOUR - 1))) {
-		ret = -EINVAL;
-		goto fail;
+	if (!(reg->flags & IOU_PBUF_RING_MMAP) &&
+	    ((reg->ring_addr | (unsigned long)bl->buf_ring) &
+	     (SHM_COLOUR - 1))) {
+		io_free_region(ctx->user, &bl->region);
+		return -EINVAL;
 	}
 #endif
 
-	bl->nr_entries = reg.ring_entries;
-	bl->mask = reg.ring_entries - 1;
-	bl->flags |= IOBL_BUF_RING;
-	bl->buf_ring = br;
-	if (reg.flags & IOU_PBUF_RING_INC)
+	if (reg->flags & IOU_PBUF_RING_INC)
 		bl->flags |= IOBL_INC;
+
+	return 0;
+}
+
+int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
+{
+	unsigned int permitted_flags;
+	struct io_uring_buf_reg reg;
+	struct io_buffer_list *bl;
+	int ret;
+
+	lockdep_assert_held(&ctx->uring_lock);
+
+	permitted_flags = IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC;
+	ret = io_copy_and_validate_buf_reg(arg, &reg, permitted_flags);
+	if (ret)
+		return ret;
+
+	bl = io_alloc_new_buffer_list(ctx, &reg);
+	if (IS_ERR(bl))
+		return PTR_ERR(bl);
+
+	ret = io_setup_pbuf_ring(ctx, &reg, bl);
+	if (ret) {
+		kfree(bl);
+		return ret;
+	}
+
 	ret = io_buffer_add_list(ctx, bl, reg.bgid);
-	if (!ret)
-		return 0;
-fail:
-	io_free_region(ctx->user, &bl->region);
-	kfree(bl);
+	if (ret)
+		io_put_bl(ctx, bl);
+
 	return ret;
 }
 
-- 
2.47.3


