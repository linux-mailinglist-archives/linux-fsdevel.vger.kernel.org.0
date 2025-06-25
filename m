Return-Path: <linux-fsdevel+bounces-53000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F1AE9228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD10177823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3CE2FA64E;
	Wed, 25 Jun 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="F9t7R7P9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFB2F546A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893531; cv=none; b=el6n1vdeIexrVqBNg2i10NmUf2EHe4A12c5t/wSTHkxVJ0Q+OUsHKN2+M+GujAi4c7akx+I1XXwmnxizGvOcF8aieygsqSgltkJHsW/xpch1HPrDBQPo7En2TwMRVYF5DDHvjOaRMM4h/zXj5rWF4fvud+S5mLd9iUgLY0m2xQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893531; c=relaxed/simple;
	bh=/jzvkX8kKfTXXj8MUiRnudSB6Xdv5AVsl+DY3UD5y1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxSLXAQVagPPUq3ILAuCegzdF7BT5fWIkVt8SpQixqCot2kT9YszZk/cJP5WOe7j6TDcWYAyFXf2bEyYm36pEoZjdwKj6CF20CJQdT8Jfl2d7PSwzYh/U5s2os2cOBmUbgImPLFzYEbAGAEK5soJBwbf/yzldlsYYmpR9Ja+s9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=F9t7R7P9; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e740a09eae0so339918276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893528; x=1751498328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wSjS0lZdjVq2RRm0w30gwoerGRiuhO0wW0911FpMqY=;
        b=F9t7R7P9dOGnqua2bU1oS8V5+PpPHYjDibdhoeD7vrzFWQyO3q1F3CETLNDkq7wAYU
         tUCaAlNp7TmnxBG8owXlaM6m0GgnD/imjmxKUmJ23onCesxS4a8qNNV0rhuixhrYNb6X
         s0UB7r0YaSzJR08JqzXM2tGpF5jH6kQ+b6s9bdh1vmneDMgJqODayDn1Pdh/1lzyO8w/
         5OMBvcOr8I8YpA183bWVTpumuLgPJ0s+aYU8G8LpazAPP81Yv5Lm+8AQdEf8ehupgfLr
         mChA1YXOl91Esij/I+g73U47AqsGk6D6YCpZh/r8kSej1HQCGkiqfxqypBBO15pTRjRq
         QBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893528; x=1751498328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wSjS0lZdjVq2RRm0w30gwoerGRiuhO0wW0911FpMqY=;
        b=IMXagNlavvBkbueZWAHe8jqv7i/SkLVw+uif53tlq8DeDlN8+kJfIsq9k6LTTW0CME
         DHQ6FKJcXSmiOVnz8AUiaQSB09l1g1fm2oE9SCvxgTBLJDqsQTGi0AFNKMf6atITbJF5
         bn1yV6XJATvYHi3svK6ZK0d+0lBEUBOVmp3OuhDD70s0PQCHpqp7VZkjptSTaUB4uvEz
         9yH2iV8BnxRbUdbXUhpPHiNKTP/8yWATmn+Ob1k0Nh2xHJU4/NLJWhRHcgIwgtwKFNRe
         zgE5q7W+hxLh71wjFzfb8lAMiDjKPKNfbgI8F1jGeubgAhbFyOzZ5gu5zH34A1Ig5LLi
         uy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7obKumPcL/ryf9ioKEERLVqBmSYdWwFuDChRxsZIh0L6mg7QqorjZRVxkkZw6GE/vUszWTaD9gA3Pli6D@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXDY6SsPDFZUKGaM0DMXk+T1ebDBP4Un8NG+ILHYaJ6EFTozR
	Xns+WgJ6x5eceKJcRjmSuuB8IeioE4nHhnjOUoF35VJaIel0wQExsyYcXpLJhXENBvE=
X-Gm-Gg: ASbGncvMAfqDp6Ukgb/Mdrnwmdo5ilpQbeV3F0CIoLsv+WQwW/wVkpnz24Sx8cl0xjP
	hTNCBNxlAq4+rpBYTJ3znuojopv+8MFhX9bsdQcAtdXKSgY0FkA4R1fWG0cvYapRbxJP1wLjuph
	4XnySkxXoUXHc2PKcKh3AWgStlAueT61X2ihPaSDhyoqZC9iur9Vm4R6PiptYy6QFlUH17LfNr6
	VEklEvYgBQs6c+6AwlJdrBNISZGo/jsKyTmhfClWz2NBWHy6RkBY83KLi+TylVgBws+ONvnG/uv
	NrguBn/7bc88nQA5n0abK5dRyCCfIyRW3PTWKHahiHRd0DQUPQOgijcwFpm+SMpJSENVSg7mm5y
	otiy1zRscZh63R181pK0rNRJ3w1xsDGXE2liCpuUBzQ+S/OIaDXCF
X-Google-Smtp-Source: AGHT+IG5OApmmqdCJD+/fcR7XfWrM1aqENTJa6SY/4uuowksGcfqjeB+tW5gpbSUsbeJPGxBKqv3/g==
X-Received: by 2002:a05:6902:488a:b0:e81:b38f:6dec with SMTP id 3f1490d57ef6-e860177ef01mr6098227276.34.1750893528412;
        Wed, 25 Jun 2025 16:18:48 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:47 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 03/32] kho: warn if KHO is disabled due to an error
Date: Wed, 25 Jun 2025 23:17:50 +0000
Message-ID: <20250625231838.1897085-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During boot scratch area is allocated based on command line
parameters or auto calculated. However, scratch area may fail
to allocate, and in that case KHO is disabled. Currently,
no warning is printed that KHO is disabled, which makes it
confusing for the end user to figure out why KHO is not
available. Add the missing warning message.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 1ff6b242f98c..069d5890841c 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
 err_free_scratch_desc:
 	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
 err_disable_kho:
+	pr_warn("Failed to reserve scratch area, disabling KHO\n");
 	kho_enable = false;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


