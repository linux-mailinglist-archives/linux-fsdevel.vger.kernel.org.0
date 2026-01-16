Return-Path: <linux-fsdevel+bounces-74271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F489D38A3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 531B530B53C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DB23B61E;
	Fri, 16 Jan 2026 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgO7Ptdx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F473101D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606304; cv=none; b=SSqKV4W/OMiysTvc+7QmmPbEJLI2dILGqCz80IK9x1Q9xdmhTdcS2nDGiA1aCVTdgkDF+eS7FUNN0G+dlVLKG9A2zRcjvbUfMr1eF/DWWXTkAdKYZ04sB5X0jyf4CUVij4fFDHwYJ4/53pvJCOzH0Dzcng2u+672PxR7Kx5gDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606304; c=relaxed/simple;
	bh=ivPoUzroIpJRQA5fNd8bgoKTlK1sllAkVv2Qkjs1H6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao2W62H3yLNEOcWMeE58WwlJTQwMqMCLqAOgt2Ota1+9JjJV9geYprFah8NRwn12peh9zOkx4Kxh54GM8OEzqa1vjq+C9MYBt5BVSeLh5nB+YiXzHubzHSESM4kpeHB7Om6XctDgk98y08gZtPZx9VIccgrec66oMV355BYoBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgO7Ptdx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f102b013fso23495445ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606303; x=1769211103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F455casoetTzeH6TRK8x9XB97xDajVMprk+C0lM7aq4=;
        b=RgO7PtdxPn37gga7fbBjCDBRjuAtknoUBm6ekx66L223uyT5gN9S61Zwg000f2KKhu
         DVsU21cVeWmqyHa88mVUKs32YQ2Xxx98Cb0IUve9P6Nlnn0xt3kfun4xVn+6NzMbrCkX
         7GNE0pDDTy9tKcncAR74q3kUeuuTiQlZqdEJoEBYOlIp19Ka1auaJt4AYaHVRzzAJXag
         pUlTAVqOoQuxCIY9167hoc97W+TAHzzcomXXcCu82xfev5OZk2aiZLH7Oxtwh+3PX2Fb
         f9LfYqSCdV70Qtj+roNs2vhkyx8IEISyUP7mHBFr1JuFwXRjHTRcKYXouN5VDh/3/sXV
         1pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606303; x=1769211103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F455casoetTzeH6TRK8x9XB97xDajVMprk+C0lM7aq4=;
        b=LqIKFw3fwsVXD6AoPO9MqcRxsDiN4LDM0IhYZEjcjQg1MlPzZEDRMqjPJueRcpKucA
         tzyH0IKa9dfh9C2wVVyQr2H/Nb4RJhkfHUorQEq5SL4kLWuMVoWm4/Q1A/bNN03sc9aT
         We3JgvDK5S8cLQuqXaBj6qRczDj3KTOn5iVxfjoiMwv9SDoFI21l63QiiHh+QJ+s8God
         ze8jotwltthAVexDK6FI0Nbo24dFiokZdGZBQnOA7bIgUSy/8PkD3EBJUjA7ay5N2fKF
         tRwafQoEugN53hted82T8JnvQJTGk8Q0BdNOTrl3DAho4CA0nwvm+zzW4x4v8w0MbqOQ
         0Now==
X-Forwarded-Encrypted: i=1; AJvYcCVY9Zkm4iAVLGjji3lGrCRni8QCo1RfY8gBL2DVcggwi18dM+N+4C+S8wqaUSpnUUcB22YfBDl6pSlc8/Ta@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0spKNkzn16Yi+XBynrDg02ULSDfc+UuG8drHhRo+cHZq+CRgx
	boOeEd5EgMk2kx+ALIPAjvn6eTNOQh3CCJcw6swO3iNeXBgwDy7965tR
X-Gm-Gg: AY/fxX4T3ngDG1uAgYirJkJrVFW0LtW6ff/1c/vMi1B4fwPDDzu7sm8Q9DyxZfHr1Lv
	CU+0Ouw3CLwOqmvbaM25Qs4y2j/X9qX837wuNLbJk6xqeXLxprWmPvTk+ApqV8WnuPJyMuvCpP4
	YJnnjXfJg5PitA6RR7oAb9bZ1f74hoNXR80DfAk8emJC2RZDrDYEIoQAMtsr+dZBmrncsDaVD4l
	kHyBGF4RUNuf2W7C42lgNrgAy1GDZOJL/BzDGpNIOecwMSyRZ/SVpsa9DxlBsrhk9ZSyy0o4pHV
	FXlpy6y85FUbEqNu5THd/C/6QNUnTg9z+6rnqDc0ZMqKJzMAFEqb/ty/vGFtOpQPra6Z27IIuJa
	M+jO5aMu00BIT8VtmPizp5Zo0JXZCRQjuCuqDt9wlTddrIQN4PFJwO1dgG2u7nQ42aW42g8GMld
	zUDrfXsRKMgVvXI5k=
X-Received: by 2002:a17:902:f545:b0:29d:7a96:7ba1 with SMTP id d9443c01a7336-2a718918720mr42646925ad.46.1768606303043;
        Fri, 16 Jan 2026 15:31:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab910sm30225005ad.6.2026.01.16.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:42 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 22/25] io_uring/rsrc: Allow buffer release callback to be optional
Date: Fri, 16 Jan 2026 15:30:41 -0800
Message-ID: <20260116233044.1532965-23-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
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
index 63ddadca116b..dc43aab0f019 100644
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


