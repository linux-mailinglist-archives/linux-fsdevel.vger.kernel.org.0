Return-Path: <linux-fsdevel+bounces-71649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF5CCAFC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1883E302E702
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228F335550;
	Thu, 18 Dec 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5sIS/vk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927133506A
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046911; cv=none; b=TxBcvIpQrDYWQIhGvn0AR9Uic3yXMYz1WUsUsm78ZELpRxw3gA9ESbX6wIB2TN4gmOOA0imdDjDA+j8HC9ZNmialOQGyeKqd4y2vkFd1EIjqd9QhFbA1RUMejExaEe4V3zpMdI6t+aQ5QMgTypp+YgrcYw2pGW58jnD+WiJz590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046911; c=relaxed/simple;
	bh=UvxGykMLagJodFF82NAYTU28hUSWK6gDUTcLTRmQJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfZwOME2PJzSyy0b1QzmYq/O05YLTcBdRn+t5n0z0Kz+A2/tt9qagThXOm6jkL4Hiejh/CcnZiwdTT9ywdrb5Oe5LSKCf9ulmFJ0EjD+EdMP3ogRGaw1oGB+Op5c4z6SVBBNMxmHSRdkWKSyZVKQDPFQm9MzV55huOeZKiMkANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5sIS/vk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c902f6845so548307a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046910; x=1766651710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMsOqo9v937yP4fh4eba7UqfVJcPSIWogxrx4HYNtHk=;
        b=H5sIS/vk7fKBT6BoN1/ZbMSzMy5UijTRCtsUA5/0DQQapwJC7rgc+juWjlp6Jr2V12
         KZIEDxZPLlrOHLlu3bCE5H6m7j/XRXPJ04kP/RYnpwtwFsXdVae6mpPfFhCMfQHlI/B8
         dHyr0EMZFta1t7l34FsVWcGbEOE8hkst2gX1XSX7G8Q9lF/lkIZHSQgYya+DRG+DnrLW
         9v59Xv88k6OaiwVI/UIrl0NMv4d1MUBzJh2P4PfRKfUMdhZWp0KuYtF1qAn34FIVwk0N
         5YJJ6N1+dj9p3A2zwU1OMMxPpi4KZv/JRqAB6btv01ZXI2mWX72mFQHvcIAtO90tGxaj
         QwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046910; x=1766651710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jMsOqo9v937yP4fh4eba7UqfVJcPSIWogxrx4HYNtHk=;
        b=m08CSKp8ZODicucjyTMEwpBf95I5vWXzGy2Vi5crohXbtpLmtHE4+qXX5AlmE8SLqk
         p595M9LNPFyiFGv2sDnAI+FfiKev66gs4LkG41FXfP0raraTfFpIeUzDWLjcYMpcZPLg
         70fT+9O8Fx50glfvCUo4t9k4qf4+j91qb2I8LcC9rO/OzSiWVVoLIVOH9UMM2KotAD+x
         s0MEINqGTCXQLyLXhmLKGqZAgtd3xHMEBwUDt/LVEH/qUz/ty3CCtyy+3OLewacYkDS1
         2UC7zCeLD3MO4FzhsxBeWnW9g5KW7MjAZ2Zm5M1lLe7n23HHtN/kdzPQCLxoFrFFxd9M
         0P6g==
X-Forwarded-Encrypted: i=1; AJvYcCXfWN4c+Y/OlB1i3MwKYK9UxFlcQXrKtTCjSXfUJj6v58ffmSmIX5sn2JtkAPkkDpi86ISjEif6BalCaOS2@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEkBDKxf81JroIUWQ/yGoXunX+YnGUZrC6pHHQqbzzdoPc4/B
	PDeLQIBwswkw/nvel/oOMCpJ2iD+xAzcgL6BpG0460xONqfvEwoDMom9
X-Gm-Gg: AY/fxX7s96OrAqQyu+tdqSq2upLLscHb3TUGil9aAUCrVeFYUEeE7OmCDmCKQzsVfgA
	f6Qw9KHMPx1kRWsfUO1b0xk00NtERz+PNbe0tDTL9roBx4aJtuRugT7NMQlCHcIvZ8V+AiDS0mW
	fHqexQmZmZvvH06/Y8j7vfCGsXtC5NhLxoi99p17IoaM7KzP5Tr7wAIDYFr6xQGsrbdObnXPxGN
	z4eqlA4TTG3+qcxjx8jvlPJhXplnw709APYMhdpNlucF5fp8EMql5GeXdUNBtg3edTxzxboY0K/
	g59sfioxiQB0fmjHGdN+1ZFXZpHfCVtEXk2AGMgwCSfUaBYwlpENx6FKvofPB0XCiWPXajz0l2v
	nl4gsnBJkZ9Pbu12n3hXB/RggKw+6BCBDRCXrB9cuh7ADrkm9JYc5Om+4Fu4QOdS6Plqoe6ONso
	k/Es+/WbT2WfyBbxde5w==
X-Google-Smtp-Source: AGHT+IGNysnUgud81zg6tiqMjIi3MWubotdaZNNwAn2aMcMHx7UXWf6+Er75NM3gN3rjaJs+wBtmjA==
X-Received: by 2002:a17:90b:2e0c:b0:340:ff89:8b62 with SMTP id 98e67ed59e1d1-34abd78fbedmr17591453a91.21.1766046909601;
        Thu, 18 Dec 2025 00:35:09 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7454653bsm1609107a91.8.2025.12.18.00.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:35:09 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 22/25] io_uring/rsrc: Allow buffer release callback to be optional
Date: Thu, 18 Dec 2025 00:33:16 -0800
Message-ID: <20251218083319.3485503-23-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory patch for supporting kernel-populated buffers in
fuse io-uring, which does not need a release callback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 5fe2695dafb6..5a708cecba4a 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -148,7 +148,8 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 
 	if (imu->acct_pages)
 		io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pages);
-	imu->release(imu->priv);
+	if (imu->release)
+		imu->release(imu->priv);
 	io_free_imu(ctx, imu);
 }
 
-- 
2.47.3


