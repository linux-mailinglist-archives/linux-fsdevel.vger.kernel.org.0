Return-Path: <linux-fsdevel+bounces-67574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C65C439CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 08:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C14D4E6928
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC1275B0F;
	Sun,  9 Nov 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5xkoYjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA2271446
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672416; cv=none; b=dkl/zmb248FuigWK+kafibTChLVxpgcd2I6K2+IoF5VtPFX2aFcJZorIRyWMv5yiBp2XxdxXLRKwSZGdn11yHqbo4jz/IH2Nmq9FNnUm7jR5LtFUAfbM6/WE6i5kpZf+BBl83fml0EbtrshC0LMrh4CJXQhAk0MdeZp1z/En5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672416; c=relaxed/simple;
	bh=LLot6pt5Wmhq41aBfE52tj3sPEDXX9voBssCmvBVx9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qqs9bO/+l5NDeM238Au3U+V/K5lrOXxGulU6/JmVOuMGHuy8T+6jXsXeN4ZBHV6lR5jGVxpzlIK7i0X4k9b+EzbPU6ZPVkPrZ5F5Yp47ACYD1ynPZvgzxCH1AM6jg45kPOoT/c4hjmOO8f0Rm6CM5b06vzUkulC5w+o7vWZjSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5xkoYjS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297f5278e5cso1643675ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 23:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762672414; x=1763277214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPG8lSWe7kDm/83Spm0cQcQQxsDcUC8RpeocgKFENBk=;
        b=Z5xkoYjSD+Ze1GN4qAl5Gs+G30tudyjvYDYMPm2lm/y5pNxplk7TaGsygdAo3TOHN/
         59tXNpWj4/xneVZVAuqJMmo1nnfUECF8NTylVud+pnR6EDEivLdLCWEmDTbzwtAjYoij
         WlRdKEbFJbGTux8xo6rncvazTk5UjUMhmm9DZZEhIXzbUYlFhNatO+qBMF2xaIDWrlZW
         wI10QlBb0etvswJKZi3tdGbUVsaE2BmKV5xlYh7//j2WFqvRXO7pc7AWyrrrZ8tbDJKX
         KPNigsMls+AMBMcq2/rLCBhXZcaHksPO2Yfb1YhIOb9JJg7zqHDcfZyW2Y/zTlwingFX
         gxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762672414; x=1763277214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPG8lSWe7kDm/83Spm0cQcQQxsDcUC8RpeocgKFENBk=;
        b=PU813fX/Z+6kFwubw4+zDaqn3iKuNaPYAAmD/mVWI2kXrFKy2TdtreUWJhpnGNgHST
         cmk1nssRh4Fb6Qx1Qp3ezyVsJUKBolgNVrGdV+/HW7fEsWk03TMGTbGoLAs3A6Bpy6LA
         OpACgoOhxfI0+mHvO19Ern/77LwpoG5JP1b0cds43ZQUF3XeApPyxHqirlDWLRPyFEg8
         lo7ou75QvlFUCHx69JeyQJ0jgDz0GI3e8nZQfePXci/TFY6FUSspaff7NCjn+nhd8Fnb
         lsA4kBU8RuKN3pQZRvZ7GYd+KpLSf0GdZBKyXt4QBgZ9ra9S87N/wJ2aVKuBY7sHpE8J
         c1mA==
X-Forwarded-Encrypted: i=1; AJvYcCVo8ftWkwmbuIdu98fGsW18e2dayGjTutyQXyGtyqCEZiMNF9c+RJsJaqQF/BC6rtwBTCtzuethALGCtOu/@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQm7tHyivm0eD7PnEmIZCXusaaYl/q0vC/mjQVLjN/nLmWTJY
	Ql//z6CJHJIbze4qSr/bh5uxBXs+ZNO4jcN1XVJzI8V6lb04ffueF/MD
X-Gm-Gg: ASbGnct74q3HjFUmg53v1SZp8q8MQO/FrhwrXl1KvTv2WT7hkLzHdfYvkex2rIiyVsN
	G5LJusKIhHQgcjZJHWeE/oaJXAylWfrjcDlaAOCkC8kxFvILgelwzVK/WDSvz4MJaqOOhwCfCKp
	gN8nWBMbo9wZNCp8OdEB6Kx76hxJiPcE0UMEjBa1gRF9uGVTytZclMqSG6Mr1otu4IXTmG39DR/
	Os6YTFILgpuymlAhBlh6sUk6TqNq2YQu7SVoXlq9jDqeZ/rl/2Tf2AG5R0UmD2HWW2RHsOdMSzD
	2YfHujGYx5zSjXOJdd+UkQOWpSxzjOL7uT+qon8eJOprxQYODuPjXIW3V/WypNAwGUhrRUWICZN
	UZiQCzUpBEcKGTZzrDCwlXD1AAMH8fw+0VIkZlJDaOx9GEQ+iZEFjz11iYLfnHXNUOBE1+tf6E1
	7HS/T4k4ELzXFd688MHQ==
X-Google-Smtp-Source: AGHT+IET48aBLYXM2WgE4SXNwbfQ/VOKYL8lV7aiQ7bsg3ae4MfMOpcU4i8Zgn+mDIASK1OnC4wB8Q==
X-Received: by 2002:a17:902:f551:b0:297:d4c5:4c1a with SMTP id d9443c01a7336-297e56d6f99mr32754695ad.7.1762672414507;
        Sat, 08 Nov 2025 23:13:34 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm57287495ad.88.2025.11.08.23.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 23:13:34 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: jesperjuhl76@gmail.com,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 2/2] samples: vfs: avoid libc AT_RENAME_* redefinitions
Date: Sun,  9 Nov 2025 16:13:04 +0900
Message-ID: <20251109071304.2415982-3-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109071304.2415982-1-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
 <20251109071304.2415982-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 samples/vfs/test-statx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..eabea80e9db8 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -20,6 +20,15 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/stat.h>
+#ifdef AT_RENAME_NOREPLACE
+#undef AT_RENAME_NOREPLACE
+#endif
+#ifdef AT_RENAME_EXCHANGE
+#undef AT_RENAME_EXCHANGE
+#endif
+#ifdef AT_RENAME_WHITEOUT
+#undef AT_RENAME_WHITEOUT
+#endif
 #include <linux/fcntl.h>
 #define statx foo
 #define statx_timestamp foo_timestamp
-- 
2.51.1


