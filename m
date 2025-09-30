Return-Path: <linux-fsdevel+bounces-63101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE42BAC12D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B437A98C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C62F248F7F;
	Tue, 30 Sep 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAq02j4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CF223DDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221337; cv=none; b=HLmXFiUXSy2cygyQAo7giak1tIQCa3uWwt4xMg88bUyVEyHToGHB8WBbJ+kABr6TZad7LMNHhpTXXKugmHjSg0dpDhZTsburDdEQb7h8/y5pzU1wNYWHO6GxlXoCK3W6OX8XVU+s7jYk++/Xcy5Tf+EDCbq98eIhW7nayUw2EFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221337; c=relaxed/simple;
	bh=ADEdvYCZrQhbb8wIcB8O8HKwCMDJp6UBw/AeIwUpfK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUWyw1qaEwBP1bjex2jUVwPw6OW1ERIU/ywN7jAFGbKQFK1XEsxEWPHNrAsPMEflnEwavdOELtPPIKW3JjnKbm+r38vb+V9vgxIiBwQUT1hjo8YXBxLhMuT3ilkV0sQh32IMw+lkljsr7HWIkmjId245jHS14/T04kSNPPEE44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAq02j4G; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3fbd3d76875so200935f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759221334; x=1759826134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUJqvmeemqRm1gvXL7Ny2YCLo6gR6Nwv5491LCLZ8/Q=;
        b=YAq02j4G03oMxA0zuj0UGiuDx2VYj1KNrz/gd+/DArAmzWRauuvWT6jv3EZ4utN8z9
         sfuqmSaDg3IQuv5yQdkYU1meJNIhRnnm0p2FnVKrwb/mXZ1gFHcvIqAcEBYgpz29qWS9
         Irsuko66oJtO80GMqyxNoFL16DOcjfI3lDeuFpdjbpxIDkCkOLNT6+2ohvvuqdl/LSZ4
         kU2C9EWFmNC5C9jXNRS88HYzA+fdnyiiyVS50wYcW53164aWC/6qqDhaeILqAsXVyhdg
         xOu0I2ufHDidzt9FxlkOEDeFWaPLsqfQo5+rZvXEyw8yJdDhJ6yYzttV6k8z5d2FwR4i
         JLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221334; x=1759826134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUJqvmeemqRm1gvXL7Ny2YCLo6gR6Nwv5491LCLZ8/Q=;
        b=oPtoiS77EAUuoEI0j3voLjLpYE8267I54EPoih7shL2vZao3/s9GdPuHwzrff7YnN9
         JCOeIl4+bl6tjbO5CWSVSSwE7QIGSDc3qMKrSZYkdr6KHeF5RkfPMfG4WV3QlUz7TA+7
         ltMfAy2LUH5I9ePHe7krV4ol+FyIfUFI0s6hqUn5igF8xAZQzgFkEo4vYSPzeX/hy0f7
         lPJOYhD6aMIzzMuHrJWqOTuBFqAkkZWl9LbnQF7S78Ku4xlSl4FVeYOS2WtMws8b0+AK
         Z3tjg8jhLOWuvOBYLUXXRAR6l3E65CiAfqzolfqXrPnG5Jtvzbz+1p2gkqVIFf7dFwJ9
         i6WA==
X-Gm-Message-State: AOJu0Yxm7mLipSMx7dQlAR+v28X23M5AS/N34ChvaplGSU3QjiTsRFKl
	sh4TqnRucGbxD8xSEwn9Apo058Duxf9S9KZSRLrfW1SK7sqpTBF7xpyv
X-Gm-Gg: ASbGncv0ChZxqnp9lg7sbEkeqP25V1DU5fU7PTRf12m3bBWbKE8sa8CNVUB8cV6gJC0
	T07p1Rg51Fmn2SzdcfoXKIdTrdPhbHS/+RODtXn9HoO2A1Ulh5u2cuqmdglAbzU1wgILbpAsEZ5
	ZBCajSeT/udQBplbCtNA08jLF8Dv88Ptke5KP+TeeJSYa7JLj5iQ5zuWsYw8VRt6SV+pbuwcuUM
	FaSG39sF6u1ADJNPKe1Kt0ech+b+zu/Nn8KTdQffa4bkDs55kd/YN8JPIenLGSAntt4HPGslxe9
	y1fzC8KkUuXa6R+/rY1wM/EaBFTKOhClzlHaevxYNflhzQP/wrNmqLACkstdpbXGQ8ccrtLYo4Y
	1Yr0BR4W64FGpHOrV6pyo5/5Mqfq00KVOFBkqKys05l+E7N+iR/hwMasqruTvv+eC
X-Google-Smtp-Source: AGHT+IEnc4h4ssP9sS7icqNK2zeN2NBLAu8VYYr2nlceMXRBqj2zPJC/ON5vQZnbcoK/iRDFPcwyVQ==
X-Received: by 2002:a05:6000:26cc:b0:410:f600:c36e with SMTP id ffacd0b85a97d-410f600c731mr8845629f8f.4.1759221333463;
        Tue, 30 Sep 2025 01:35:33 -0700 (PDT)
Received: from bhk.router ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb1a3sm22132771f8f.10.2025.09.30.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:35:33 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] init: Use kcalloc() instead of kzalloc()
Date: Tue, 30 Sep 2025 09:35:37 +0100
Message-ID: <20250930083542.18915-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kzalloc() with kcalloc() in init/initramfs_test.c since the
calculation inside kzalloc is dynamic and could overflow.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 init/initramfs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 517e5e04e5cc..fed1911b73cb 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -97,7 +97,7 @@ static void __init initramfs_test_extract(struct kunit *test)
 	} };
 
 	/* +3 to cater for any 4-byte end-alignment */
-	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
+	cpio_srcbuf = kcalloc(ARRAY_SIZE(c), (CPIO_HDRLEN + PATH_MAX + 3),
 			      GFP_KERNEL);
 	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
 
-- 
2.51.0


