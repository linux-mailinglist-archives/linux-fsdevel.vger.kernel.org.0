Return-Path: <linux-fsdevel+bounces-58258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A21AB2B930
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0606C627040
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0726D4E3;
	Tue, 19 Aug 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3rv6a1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DEE26AAB7;
	Tue, 19 Aug 2025 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583994; cv=none; b=mYP6XYfOzFjrJBrQQRrUXn016TkAD0eMfXgK+D48I0KurwozOalK2GGR3z7BtXc0p5krc8sj1w/ZcU5Gu94pl6ssiWVYCMopi/KNEKyWFFDhCty+MMD36imeZV+NXJTAgpv4OU1vSZcMzwHey70E+RQCUPIFWGUokUfZR9w7CBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583994; c=relaxed/simple;
	bh=fUQfFElf/n1YFXeRlilipOc60lM1F9gHYrxTpwBa/k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUV2waXXnkghnt6CiFDxRW6dC0/2IzMpQIR3iwI91YtpXbaUAbAcyCawYNTn6w0NBJDekYNpECo6LH/VWJiV5+KO6BmQmvO6/rQzZmjvYMiyg3Qlp+VLtjgc8tiXrM2c7F/HHBOPcBQVkitPxUa23GqcjXRswXZOHFYZV3medOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3rv6a1T; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so3087493b3a.2;
        Mon, 18 Aug 2025 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755583992; x=1756188792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvUpJRHXD7LfaMIhQuE2PNU6sHNZt1v4226N/AtOZPE=;
        b=F3rv6a1T4FrcCAH92vBfMieOfJ6kGu6ZwLrbkU7d36NhW20dKG43eqO4E6dtkgrQiB
         K4SST/uztE9XNgaY8kVSosuU78/P1wadkRyKprFTwA4DxlGqpvpfcMSq9U3x6TLGEcn3
         2k4HBDZ7yp03ZEOvpbqNt4kaNE5V5Jk+/hVWCsrCz14Ye5nfLYeqyrlWSvBRaTKnCPUT
         lBMGKFJ/BD9SmN4O2EeppU638ZXAMk2W+xNylSdRrsxs7HyiECLYNHgeQ+m4i9DyB4gw
         Yonmup4LlMNE2XfUaSdTMpWm7gDiTQGClevgYQw5bO/c95m3pLw/Le4BPScFA4R6YpXz
         t61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583992; x=1756188792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvUpJRHXD7LfaMIhQuE2PNU6sHNZt1v4226N/AtOZPE=;
        b=QVbLkwuem30v/CRjIYPsZPh+7muPoeQPanceQyB6UgzQD0hAUbOu4pLY2Q2maqLnKD
         kSTyadU/pSiUzDqq3O792ckbYDq1q7wLMn81lXrV+SYx993/lJ8262XwN7x/esEH7Vku
         Nh70Cx3jiS2lEfK6mSjecht8nnLzcCuffwrsusmNCVarRIlwCg392iX55eJ49Qa1KsuT
         itftPjIRceAzBVoSSxsd1kNgzECVAVV5vZciGDtJAYO2x23GkAn68n3vCkPD27e01jeD
         gAWak20zaqPWpWLqRyIKNek/YxbgzJfZ9C1oGOlGXJKIf21qQ1pEthhy1ugSlf9gTRNG
         Od6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDeg/7Vork4IzouoEK/Mt5qLmGiXKeXSbBCUZtCVufpv/Qw8PhRDf9ZMI43fnd8QT+5D0DTfGJivU=@vger.kernel.org, AJvYcCVWGcbsTUrI8oUe5e5tCB3ce0uE3lwIlrZw/qeW4vaEAET2t9y+QaiKD4k8tA64GFxP31ZlG00wcAJCGN3aNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQ78grONWVRsgapWHmagXBa1Wi9ajlWcV8mkNyXmpknyey3QL
	+pqlDFmBdGVKRPZsoUMa5ryI4XuKtUT2QB+RcsUPTnksayumHfepp0Mn
X-Gm-Gg: ASbGncvRIJUBAdBcTWJe/Eamao/92M8zRlt9l7lJJTPCViKkdLmhwFBMpScYa95St/l
	vPXY9KV9usEzN/17KxC5yR2O/XctRTcnXaLoOUSCE3qX25LMfhhLYxp2kEd7x27u+cL7dJr9gJ0
	VegM3rYYw3XArG6ZEA3h9heX2/yM7fCB5tG7TMvbvqseIpI6UqRYo1nBVGhBDZwTuukQktlIvid
	RPHxgPkgHZo8JWYLFE0Il+SOmYjt4eB/1E3NXQEcGLB2FG73XXa7hKtAAWhyNB+E+7JFSPmix1p
	6Wa8Hf6lyC6HxB2cq+6armT0aipAAi+remN2D029/DTrbLLpPg6xYPb2thC6MrPNRePTiM14Qf0
	QNpMKY4VXTFVX6pf3K7wm/A==
X-Google-Smtp-Source: AGHT+IHAd4NLhm4YbX8GL0Gp5jilXdKFIcCke+oZZDTNSdHJKdy5DBnzdsTd0AfPUm9kE3DkOtnFfA==
X-Received: by 2002:a05:6a20:918e:b0:23d:6956:26e1 with SMTP id adf61e73a8af0-2430d49d6famr1916438637.46.1755583992324;
        Mon, 18 Aug 2025 23:13:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331184ee0sm13150009a91.29.2025.08.18.23.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:13:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 42B1C41A38C3; Tue, 19 Aug 2025 13:13:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/5] Documentation: sharedsubtree: reST massaging
Date: Tue, 19 Aug 2025 13:12:48 +0700
Message-ID: <20250819061254.31220-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=bagasdotme@gmail.com; h=from:subject; bh=fUQfFElf/n1YFXeRlilipOc60lM1F9gHYrxTpwBa/k4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlLRB5bnrXf99JknpFfYKDaTqd989v1Zzp+Yr9Wkxnbv kHnOX96RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZSZ8/IsNppj+fLt07Tlxew x10uVcxqMJgtJJG6/trT/490hC+7NTP8MyirNtXm3GvGXRkfuu+EddHVyFuf+rK5gh6xcV8SD8l gAgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Shared subtree docs is converted with minimal markup changes to reST in commit
cf06612c65e5dc ("docs: filesystems: convert sharedsubtree.txt to ReST"). The
formatting, however, is still a rather rough and can be improved.

Let's polish it.

Enjoy!

Bagas Sanjaya (5):
  Documentation: sharedsubtree: Format remaining of shell snippets as
    literal code blcoks
  Documentation: sharedsubtree: Use proper enumerator sequence for
    enumerated lists
  Documentation: sharedsubtree: Don't repeat lists with explanation
  Documentation: sharedsubtree: Align text
  Documentation: sharedsubtree: Convert notes to note directive

 Documentation/filesystems/sharedsubtree.rst | 1349 +++++++++----------
 1 file changed, 672 insertions(+), 677 deletions(-)


base-commit: 37c52167b007d9d0bb8c5ed53dd6efc4969a1356
-- 
An old man doll... just what I always wanted! - Clara


