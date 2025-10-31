Return-Path: <linux-fsdevel+bounces-66628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FCC26E93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47B5407DA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08635329C7C;
	Fri, 31 Oct 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BHzRCFab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74EB311958
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942882; cv=none; b=a+R2VGSlGVDhYrgeMuwlB8IbLYEjU35lZPBiBPV4cZpN1SkxRXh8m1ra3X6QRxiontVvaNCGXWdMHWRxLDXyrNtFfj25yxCRCrQwYV8SG4AyVKvlohtrx5Mv55eNiLc2INaE4S/+yA0ndhBGBPerUjmir6ztYdTwoaDJLf2JRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942882; c=relaxed/simple;
	bh=C6whxhY2k5fPAXSikyioIezH+fO5txoMclXOMXtXotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxcKVRTI20JC4LsrALKcJF3SN9NTO2Cik7cXj8vpPBFNmfUH025D8LYnw4FqmBS9ypRC+EmioOl57qxwgJhmnsmjF4zC3mNc/sAm67AHCzmt9QiYpwnIhhq5BKaT/awaefT7+jEeCZF/xNQY+m2UKzC3/vxMIy/WHzzBZCR9/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BHzRCFab; arc=none smtp.client-ip=209.85.208.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-378ee1aebfdso4143181fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942878; x=1762547678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=BHzRCFabhiAWethpTxaoampQf4oPL+XouXKbBZxEG8mFL1FqS0EF9jpZN9UQ9wgzoK
         OZNRYic/S9lVXkZF+GytR7vTTrI/3+WOcb/nhJ1KpaRHfMaDUXuvOe0ncwLthQxgJWHK
         802pT0+3ovV/QNVTFvhTCms70QWPuaIXoyqkOTKNz4gSCc7BDLIReCo5noxgqf6fFK8f
         heqDvTywyL84V7XzxDYd9n/Jr+jrKlZ2YFR7+8ssV13ZkpSYevogr+pV+0FNNDU1zb86
         PkTWXQisezVYIfpyBCDOeYp2of0/y/mE2LfKODuUTdZQVDVjER8KDWxli54z8W9rrP7C
         hQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942878; x=1762547678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=YAupywJbVym/jHvFVafpE6mfxX1DmZJ9vrfaswLObXsBMNwbJVxy3Ro7io+2QjN5bH
         Z9jKacIghSM9Lnu840712E5vSkoku4dxuf3p0D/tWSueI3MTgw0f730eOkSQ3w1goWVf
         l8tuwLhrf5+iZFHVpRpZ5vwlzRSGu5yIt+OQSCBrOkau3c1Tmb4uXVMzmc5XzFdLaL51
         bnRYvYIx49LNmbncIH5FUDam+0HlM3npSV20biU1287qJD8GOwVbDYzWtpA2Zb2gbVY4
         SL1E033afOLTzvGzU1231IM+Rv2bF80Fxq1UT1ufd9JZJdGRpivqcC9WLXFaenTtZUcO
         GjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSL40+Ci/+Q9Dcy1RVdoNc6tAOzMEV2G7QQLsXQo8GFUoYCvx8Q0/KZzBK8q7TkD5SUbLqVPPX4f0ppcSk@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoe10Ym6yO8N72hJLazDfNtNpNuaASuxi6Ir4wCRkUUlzyRTg
	2LsHwkBKCW9+s3z8KH0cPXTQBwtTeZSUPsPELzGC8lc5E1yl6Agn9qckHwl+CN6q0nTywaAQRkI
	91aWOazq9ndQy6Jm2S9N7T0mg3i9xrpmqUOX4ztqa45EEzkvIW2/p
X-Gm-Gg: ASbGncuOvaRad0eIKmwiS3E1+6OSbpaljwrbGIRfuE4tR2a1wOOKafBe7NkFoJZu6/h
	gbkCQ/1kcC1QE3vFPoF2a4zDyo69amUWgREnJihQelYvQvnzYBQPqgp0HfTNnRp+FtvPNMi4o7m
	tmh9J2DpTXt91PvrVIOrHQMw8ipEVTRl27jcxrocx5Cs2ALZu2VXDsc3oL8iiIZw6iVb0xeSaY9
	pLLnIZ5qGE9mXAxUcRIle9rpZRjhjwoMGINUtuf5iYTgUQ/QANFlABITW6Ld9IClJq7yyW2m0UF
	YwEyRqleKAvEL5sN6FnWmdwObxRJo4vJWsC/wAb1c1a0Cjtuifck/NoHiGZ7KrCuntgY3eNMCyx
	CB9EIG/enkFJ9og2w
X-Google-Smtp-Source: AGHT+IFkklfQMtwtYHctUmXUj84xAbmvWB5viNqygwZDDgD7B4MpJ/ProRXWufuferuOhixNh09lD4F7KOks
X-Received: by 2002:a05:6512:4025:b0:55f:6637:78f with SMTP id 2adb3069b0e04-5941d5539bdmr914999e87.9.1761942877597;
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f5b5c33sm282549e87.37.2025.10.31.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DFCEB341B91;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DA9BEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
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
Subject: [PATCH v4 1/3] io_uring: only call io_should_terminate_tw() once for ctx
Date: Fri, 31 Oct 2025 14:34:28 -0600
Message-ID: <20251031203430.3886957-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_fallback_req_func() calls io_should_terminate_tw() on each req's ctx.
But since the reqs all come from the ctx's fallback_llist, req->ctx will
be ctx for all of the reqs. Therefore, compute ts.cancel as
io_should_terminate_tw(ctx) just once, outside the loop.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93a1cc2bf383..4e6676ac4662 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -287,14 +287,13 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	struct io_kiocb *req, *tmp;
 	struct io_tw_state ts = {};
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
-	llist_for_each_entry_safe(req, tmp, node, io_task_work.node) {
-		ts.cancel = io_should_terminate_tw(req->ctx);
+	ts.cancel = io_should_terminate_tw(ctx);
+	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
 		req->io_task_work.func(req, ts);
-	}
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
 }
 
-- 
2.45.2


