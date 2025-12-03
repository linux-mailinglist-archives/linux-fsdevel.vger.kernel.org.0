Return-Path: <linux-fsdevel+bounces-70518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA90C9D709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE636344F76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA10264A74;
	Wed,  3 Dec 2025 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He/rCLN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560D2609C5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722233; cv=none; b=sJ0kt1Wg+AmdYAWY/RTnoV1FYbFHAPlF+EoF6NANYBdMwxVm/cEpU04l6fWDjuyHiS+4t3kREZXEGKYWUx2FusGo3tzqY9wnfuf305kNcBo3JzIyDJpy5MSnmtGZtTai8sOb+dNsmjIOUj7BuYZyPay1S75if1wDvQyRr8hfPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722233; c=relaxed/simple;
	bh=E5B0edRrY+rm+1DIa+XmbtI1NMD+Chl2Nxqtsdgl1S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePHoQJGZr5JgLs27zB/GTd3RcMlV7J0U+hqLz0ZaMeZZ2O81fRmaMoIfn+X0jWT1xGL2IzkbgjPNk2RhYWGBUeBk8Ce/lQhJaYiPXHF87vtoQs4liEgKr7hMgZpnvz1XTShiecE815wNROoZryFp7mt3hx5YuqZJye1vYXsYV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He/rCLN9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso9395398b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722230; x=1765327030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dZgW5EX2VAyyFKLlIA9JTCACFZjum/fhM4OL5/3muE=;
        b=He/rCLN9zjPYuCU2cx/141KP89fQVwW3bt9Bbn37gJW4Uyy2DtcSMYjlVSfEsB22pD
         xB2jcT55PnDREiEu/XkHFlPoFzyCKwIzi0lN15EWPVVmXj4lbKONIxAMs7ZnhhCBLiah
         gjpQZ3kIuVUPfdhxW4eIrTuwknA/0s2rvX0nL1Ovh3L1dY/Nv13s9gOVCZ4SyqKG+2We
         ad17X1+5sGOK9dxJ60aakRzX07b9PaHwHAR1eSBivqeowwtMpV+DYsgTk4lvvBZuCssS
         UJdAmxLkj7p9XYSbFcpPpYGtHDUG79HnuG+iMg7qiAZfwXJOwcT6QhKAAt3pRkFmSP++
         JQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722230; x=1765327030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dZgW5EX2VAyyFKLlIA9JTCACFZjum/fhM4OL5/3muE=;
        b=b/2nhGS8K2bgsNux4KJUY44cqktzoQg+DRlc64fkajBp0WNiREnxsW8j39yjZ1haN0
         OX8rDVV48nXrQsoheZypsA3zNODKzcoEilrQ9IFbxT7v6gdR6wM4czYipUhfbTGnZ4lo
         2yESm8Z04/k8cztSMlnPhVDMxOgQaARsmaSqGMbEP8u+eGQ3OHP2e+JZ4cL+7w/WGpK1
         /kNkY/T/pXGm1QdxMT2p6N3EpoL9KGFfmRw3slHKBV+HrOf8mf39rhp4c0+Kiehj7zlE
         ittk36usBB42wbZRov/ff/gfMGMX6h7KxWiTOcrgoqN4GfzA/uTib7fX/Z/U1DMnfeuJ
         257g==
X-Forwarded-Encrypted: i=1; AJvYcCVGc2TT8WTWxKFgGjEcLlGIfGPrQkwDnfh8bEcmYVRBpsKJhxR7phdteHUypjSW/DmSlyszK6oPJ12GACUG@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJStf2JeaTLXO5wl3WCL6RuqTuPuj43p0Xd/ZnUBnLoDtOJs+
	ckCiKLKTIX2oxW88kjwP77ZNuVDEh6y/KHcFaLcNyKpgP9rNefb2Rot8
X-Gm-Gg: ASbGncuQ7rNQMHuCa0QJzVRqnhx7kfNBBud+meHSKFzoa1/XljUwuNFuy2ZKYz3WlLs
	x9ZNxMHce2J7AYoWQOGejhUx6Fr4K2E70A+xsazUSvGubYKNGKBeA5uqg7pBqnvqaxKqf1x4sJv
	EF0i2t9vZ9qpvj6Z3mcojzeC1ug4FGbqSG3FGq1o+vPcZPed0GGP32ZxOeUn1zncypS7eysxFVP
	chUjJdmBU6E6kHuY8Tmp9k2Bfe0ODc0w5phV2ducit5RNQ7SUWnov5G446LV/RKL0qTRlRqoe/B
	DoPN6cVzhfNxgMC5CAxahklF3yGOYfGp26WCW9+6r25mcqFOM2ISbNOQKRx4b/uyAnu8OgIIJMC
	amiBiKMdFk9mmr2XaS76FPyTO60k0sFETk13IdULJUGs2sW+VoaxYRwws+TYrQVLt7h4/OVY5wD
	RYbl2iZ1KHR7pI40p/
X-Google-Smtp-Source: AGHT+IFCE6HwROTSAgOg2+fwbRR8GMpBJxaEWeg20IU9c2K4wfOl8Q/ADtks+5Lp0Z1FXdVB0Ug0lw==
X-Received: by 2002:a05:6a00:194f:b0:7ac:edc4:fb92 with SMTP id d2e1a72fcca58-7e00ad77826mr464841b3a.11.1764722230051;
        Tue, 02 Dec 2025 16:37:10 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1516f6cdcsm18222307b3a.20.2025.12.02.16.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:37:09 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 24/30] io_uring/rsrc: Allow buffer release callback to be optional
Date: Tue,  2 Dec 2025 16:35:19 -0800
Message-ID: <20251203003526.2889477-25-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-1-joannelkoong@gmail.com>
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
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
---
 io_uring/rsrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 18abba6f6b86..a5605c35d857 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -149,7 +149,8 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 
 	if (imu->acct_pages)
 		io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pages);
-	imu->release(imu->priv);
+	if (imu->release)
+		imu->release(imu->priv);
 	io_free_imu(ctx, imu);
 }
 
-- 
2.47.3


