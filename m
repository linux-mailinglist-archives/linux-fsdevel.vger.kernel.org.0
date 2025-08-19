Return-Path: <linux-fsdevel+bounces-58298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF69B2C422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4594E16B7C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90867334723;
	Tue, 19 Aug 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhclXTXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848F218EB1;
	Tue, 19 Aug 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607770; cv=none; b=mEsPur+CgIbvXKqvz55sfyikzwfgcm+Dtvobd8tnsaDitoLzHxwy9FQAYdt/MEGkDryTh4WaV1lm+kLnmVzkRyvM2TfRUYDS9hBsoOAuKywYhAMVJzsUdh+2c3p2QR5h0ChbSMGrXBnUHf5peEFWbTStEKFxWwyTRqAEMS6Tokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607770; c=relaxed/simple;
	bh=qhVpFzoBqfd+RgjOal3oIe+9WXyASUdDms79CPbr8Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZp1roGQZqU0hLCmSpfibRaVslPg9vXZskPrLsnfCJuBQJgjN2P4URvko6XdLutLGMxlQKZLySfe3tbqHc1eHLU3LJ4rBSigepoJKSc+f0YxI+Ve2i4D5uUIkYhR9bLOH6XHBp11W8rnpLTEccpSO2v3gTFEwO7Wx43xJKun8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhclXTXB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55ce5284d63so4706901e87.0;
        Tue, 19 Aug 2025 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755607766; x=1756212566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XyjnKLZ5WWpemxO8ebds83k13DRtYec6BqZXeYTy3EQ=;
        b=RhclXTXBIvEfZSBIHFbN6UOjexRV1OBEyd2eceR/wRAqWngVtgMVH6xs4PnGB94eQH
         jInsIyvzcf677l6ZAAKyM/XX7qFQvf3nPxWQYLUhcWxN7niNhCI9J0O7lP6PLedB/tGa
         g2rIUah7OJQLUzIgbbIhWQOQDH4UrNvkD54DqKQbEyLtH2uC4TUSnmDOUSrSdI3I6noi
         Cyr7WQoU3hb/JIyEb1UA85X7yE2Clk00kTCZ1aLEB41RoYTKzZk+5h9X9TYdPdrrU9u6
         LeBmHFhvLdrwhv0TE7V/XngeddTG166ybSeOj8axLEeXVaiHxyPDQsnrFAWsu4DRnhgr
         Tgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607766; x=1756212566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyjnKLZ5WWpemxO8ebds83k13DRtYec6BqZXeYTy3EQ=;
        b=Wlc/O/Wt7bxbFhgR0ZHvPYS9BOwILm6rWHtK8Y+H5IzmTVfyXLt7EvXN9TRCmoc+YL
         n/ELhAekPXzaK9wIM6gIUE2sQkpVHGbpQ5iZ9aUIF+0OZ9Mlyd6AdqRYDX4CUN0KL4Uj
         9W05zuu9U6D5XjwUZPYZyTUJ44DoQAKgO91YxqWJlPfYPAPu9ZdEVB9f4bTlECFquB0d
         VS9aScZbmCFW4Is3cdIc/6T2DqvJTf3iCMXJhtmizqbYlUNTu2LYjelRWEoA1iN6x7RM
         MWygu7eJSSxnIQI0kBwymBAPFH9LHzHgNABZXhlf3jfBJV5Fcno6g0RWfVqmcMLIXIKW
         wowg==
X-Forwarded-Encrypted: i=1; AJvYcCUi5piZ6LH7C9IQb2VGavMhEFrUv4T4s7apMYEjwMUiIE725zEOPKYJBdIkVsaIdBzGARxj4j75TkmaoX77+TS5@vger.kernel.org, AJvYcCXfMEgntJdRxLFkm0d9VMpqIW3weOnMQ0VNapfNj3wy3BHj0mDKKFokTE2evqpFO4bff6TnDEoAP9/BeuLN@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEeBchcR1VK3NsP83nOnO3YeOI+j1R7cWmECtYyjAata+6bgn
	ZFiFCoAHP4G1QGPxaGpgZkuEurdDH7IRxJwgyX2gi1HVHFgco9TKE9q0
X-Gm-Gg: ASbGncvrurls+4JumlTI+Xj5Eqpl0Xc6hkEbNcBT071HCbhK+/vRnJxt5PuPz3JJcHZ
	s5oJzBgmxO1oF8uf0qpBeVkgVXNZq4RtoAJSja2rc6atSQTx88SABUMW1Dq39Jy58pbew5eG/vP
	kTitOs1Ff1ej+R6W6tasNxEzI1k8Q2nwhwpISWt1h2HdyEYsEv59gnfc7FkwXuvPgtE22otZ5Nt
	MIEaaUNM6SpsY6gxx5MKSkFvmVgsNKbmpu+/PaHq7cGaCl6axbWxVP7hlyPxAIuEYb5WF95lMwQ
	UH9mV4g91/3HXX8KkqCau0CLhPacrxGBBAxA9j+SNAJ37dKxvzqfvIbyGVRYKIO2nxy2GrAvnL5
	ImAjKGAzYqc4STpY75OcSbpDOd03MtBqzPbkJZpGr1bmKebe0DbdjGhcS42ktEVNZ9n67BTNUIw
	BUD8/kvjYPNUzjj6yIfsEVzHJGPFwafnubi6Iv/q+AoaUOO4aVbqZY4A==
X-Google-Smtp-Source: AGHT+IF/ijueuST2FzGRO5KJQvLOr6+fvvF8eW23F6aUlibk+kIAn4JNAVQY5TPYyrPNiWB6hR5YOg==
X-Received: by 2002:ac2:4f07:0:b0:55b:8285:3f31 with SMTP id 2adb3069b0e04-55e00e87612mr708782e87.24.1755607766277;
        Tue, 19 Aug 2025 05:49:26 -0700 (PDT)
Received: from ip-172-31-45-110.eu-north-1.compute.internal (ec2-16-170-211-41.eu-north-1.compute.amazonaws.com. [16.170.211.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55df8db7463sm742057e87.166.2025.08.19.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:49:25 -0700 (PDT)
From: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
Subject: [PATCH] proc: /proc filesystem check error message
Date: Tue, 19 Aug 2025 12:49:23 +0000
Message-ID: <20250819124923.9094-1-mallikarjunst09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve /proc filesystem check error message when filesystem type
is unexpected

Signed-off-by: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
---
 tools/testing/selftests/proc/read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/read.c b/tools/testing/selftests/proc/read.c
index 35ee78dff144..c0f44ee71e79 100644
--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -138,7 +138,7 @@ int main(void)
 		return 1;
 	}
 	if (sfs.f_type != 0x9fa0) {
-		fprintf(stderr, "error: unexpected f_type %lx\n", (long)sfs.f_type);
+		fprintf(stderr, "error: /proc is not procfs (f_type = %lx)\n", (long)sfs.f_type);
 		return 2;
 	}
 
-- 
2.43.0


