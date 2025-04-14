Return-Path: <linux-fsdevel+bounces-46345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85042A87BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B1172DB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38925F97A;
	Mon, 14 Apr 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSOjll3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D8C13D;
	Mon, 14 Apr 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622675; cv=none; b=Qi3+XMKXt4q0FoPd572ehnZb+GiBP4OoCvihaY0/I73uPTTCwFP6LRih+h73uwp0VGGWEAcGN+I0PrzJNKk0RHxyC1HOrfeI19dUOYjBW7ucryQxhPV4BadvVJlax2S/jjX7f1Dm037pSVtcKTkGSGkft5po3haOnF0YFGezd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622675; c=relaxed/simple;
	bh=agTCgMoSAjEhU2SJdZ9IyLmvMRHBWqSCUMYVX1x+tbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mhe0YpFHRupgwC1xRkI4YRJIbSWUmVZT+64d4nz5JEQCZqDK8+JmUhBkxAWZPYQTkgxu0edH6kFudmGa9Q4AVWY0Nq+B/I17i2N7FX45hQb0MqE8GFGQtv04DphVVunLgVvVjW+978donkuxLPn1q5LTnLrFAsxypAVKFoK9Ibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSOjll3b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so34355585e9.3;
        Mon, 14 Apr 2025 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744622672; x=1745227472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzue1Jqf/6PZMYk21IFwYXYNC/Y+Ds8648fAr55/H5I=;
        b=WSOjll3bfqGOL/IjTDFaKJFg901NdMT5hQivaNKEqqQPc07u6Sj5/GWM29PKI92WUR
         T8QJDW74rrtja9rQ7WDjzEoHOMFcXQnufsSBQjXP+9oxDcl1DppojYEK84GHWXM3aApk
         6tMjyLscMu5Req2voS7+EscPuBSAg1Fk1jEieRpQztmgQNxvNcVI7ITWgrXXna22DOBB
         SOYyPbN04sESDP/djRQcf2KQ+qek5pYAh43Lo0/8MwtEFS8hJjdFNjoXxllCR8bY3ZKS
         yTgjWFD7vJou3COVixwXC/+WPp/czoeoHeOuMC3tV0vIx8yfxaGx8bHK3W0ct2ILTwgN
         i3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744622672; x=1745227472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzue1Jqf/6PZMYk21IFwYXYNC/Y+Ds8648fAr55/H5I=;
        b=kiKxPrsd9wFnPj7F/ivFcb1IXC9jVfncrUkYjl/dWW9YEwrK2OXt1PA9KXGPRx3iKW
         8dsBWFCTiJlD3D2AZvytuq4iVzp3xo12pG9qKF4bAO63oTwjp63sK0nvNqPmfxNtva/s
         FGJc7+rIaw43YH1qjQiinPCoyXtoJ21sW+JFla7++o/bX7X40RJLUbWUTh/ExrsldmTv
         DtqTh6No2PvUdjyLilV0wwaAMeF2r1pxSFHbCrc5i5NRU509DL+EiqLKmfUOdM6TRU0r
         L978CZsqpoVsAc/QMAbINJpfx6MFHVdcTG3EPeisEy9KM1a+9TNRNz3enHlJAOIHEpU5
         Z/hw==
X-Forwarded-Encrypted: i=1; AJvYcCUSJRjjKtmScc/MCeQtFM9AoMoyOXteu4OIXyIbNc8K1ilUFPVFcpabB6n+lFk5sT70cPjj0TLadTnrwi2u@vger.kernel.org, AJvYcCVZzMl1j09XT6lyJGn9ucx2qSolIR2pVNesWNZrYT+v/UMYYMWd9zmll7uJbo9kh0xNbgnn6sWGbITn0TLP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/FwDToINVFzCXNhYiU3chRKl7OrWdxMozdmFLl74ZYxKGTNF
	C36fvg+vU2m2Sp4AVrYfHTPrv/nZTRP36f96JQtPGKgUQLjSaeDv
X-Gm-Gg: ASbGncvhDAFsYzK4AeDuX5npZvgt4r1OWJzM2s26+gXM8Psw5eQPWL34apJPXfOngwo
	miGnyKWTGi6KCTIfeV+D2uje0azgDi7o1fghJ+42YDgmceaV55rSlzsOkpuLZ0/3LG1ai9P+MIh
	WEdLL2V1M4dzoXwlN/ZiP59zxucWU5kXWsnGqx+GnaJYFzGgpPyvgO5ratjSLU8b0YoSsTPhhGf
	9tz+LdqJj8GQh+cyfEWO7PFOgpYJoD9VUjUclghcWyNqifrZ4aBahXvY3DjN2c5NoLSu2Za2Wu9
	bvbizVkH9me5cAYitdSzWtbMIkTr0aGadolmMltRAqMhclXgrHYT
X-Google-Smtp-Source: AGHT+IHtWY6E+K4K+bXtvTUnA8A+xDFVvz/cd8uuterYyuoV91+43oLtXfRw8mAVEcC4tqjNcP+mAA==
X-Received: by 2002:a05:600c:46d1:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-43f3a93d697mr94168135e9.13.1744622671428;
        Mon, 14 Apr 2025 02:24:31 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43f23572c4esm172954905e9.26.2025.04.14.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 02:24:31 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] select: core_sys_select add unlikely branch hint on return path
Date: Mon, 14 Apr 2025 10:24:26 +0100
Message-ID: <20250414092426.53529-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding an unlikely() hint on the n < 0 comparison return path improves
run-time performance of the select() system call, the negative
value of n is very uncommon in normal select usage.

Benchmarking on an Debian based Intel(R) Core(TM) Ultra 9 285K with
a 6.15-rc1 kernel built with 14.2.0 using a select of 1000 file
descriptors with zero timeout shows a consistent call reduction from
258 ns down to 254 ns, which is a ~1.5% performance improvement.

Results based on running 25 tests with turbo disabled (to reduce clock
freq turbo changes), with 30 second run per test and comparing the number
of select() calls per second. The % standard deviation of the 25 tests
was 0.24%, so results are reliable.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 0eaf3522abe9..9fb650d03d52 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -630,7 +630,7 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
 
 	ret = -EINVAL;
-	if (n < 0)
+	if (unlikely(n < 0))
 		goto out_nofds;
 
 	/* max_fds can increase, so grab it once to avoid race */
-- 
2.49.0


