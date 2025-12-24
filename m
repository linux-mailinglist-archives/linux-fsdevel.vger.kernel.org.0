Return-Path: <linux-fsdevel+bounces-72008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900ABCDB0C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 02:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3699C300EE54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F7C314D3B;
	Wed, 24 Dec 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2BQi91xP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02375314A62
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536295; cv=none; b=Z1XZF7FagWoJCLQ+KRw/poCdlzpviBGxgt3GmSXl/EAj9xZXpMEYCMS8wxtsEESa1q7piNGOTlkXnrk2D4Q2OfCWA1a2Txx3I/Q3m4JY/iwMbSJED94bIpw9s2Srom65UY6dRmZFhMMi2//x4OEdUfiGZoYQgT+8+rSA8SEpAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536295; c=relaxed/simple;
	bh=q5gMSiXxK+19YQ5unrApHjloewkL6CM34gTEsVFcHd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aAMSPupyxwASocwsNMYGY7fYoRjExmzqgh27CD/Xg2LdibtC2pmBSbcscwee2y4gqE4Z6ShecGWmi4B29q39GC7vYkEDdVVJjIyDfkpSylAdh4GBQZpjG/3uutvS1Gp7m3NVtla/jYb3mO6H2eXDivHYtc0zid9Ao8Nl1kEBh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2BQi91xP; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6455a60c11fso4341799d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 16:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1766536293; x=1767141093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5rDvPECvFaCsu10CL1S5YzrNkaWKW7eAydUhkB1MXQ=;
        b=2BQi91xPTyJSjdEJZgRXKTyiIg5puizTdWi8m8SwqA7zYhzA5Y3MxnHPSIvUcVDTMV
         O/QNUomNwj12IEUkYP/oFFuKPXY73/fiB2T+bDzSPqXZPggQl0oK/vwE3qB44HSiNanP
         asjnvNaw5kM30c9Bh6szwlvXR+79zLY5R3oLMS0DK2z9Qv+aOGzm+ZNZ1yT31mwINk67
         v7QFHNvy9cJWgNuAUUNtsD3ES8S2UAQoB3dfXFHeGZubMZu2d82//slZTajQ5LGfSP6J
         5FLwZWJ8uYGaUjQcNrs+O8FDii6kJe7G5Rx7a8BmFcnPXQ5jTI1Z2ps3QpM2H8USUKaC
         c9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536293; x=1767141093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5rDvPECvFaCsu10CL1S5YzrNkaWKW7eAydUhkB1MXQ=;
        b=lnpqZn7hUeJTLssFcswM42EB6p874g8xclvsyI7ygCieIh5k1CzdAjZ31SV00zyyIv
         LjQOrmLSTIW4HuNEiAJivkQiVaPFujBChQFkK14DQUPS5u+ebPysMYSTjdHz8Zdc0UI3
         1Q6x1ru0S2iz3fq9M7kZQ1E9Gy9QXqX3gCbBZ6Sb0dLCc+WvBX/jXGqxglqS/fzBPHTy
         D78eyY09NlpMVF3aICEtFeK85j3BD59sXhZj+4Vrq3REYvVBwjhoCnxLI5SFnE05Eg1g
         HGHIBVyxadw4laVc7A/n9TDU4brtsr9Gck88gRb8O29/SdL+R3J+k2Oh/+krDZy4JSuL
         xe1A==
X-Forwarded-Encrypted: i=1; AJvYcCWJBiPWWM4cHSzKEe6si1SjAM9jbaWj/UcIKAlVQUuu0kQcsoc8SfiLhT4uOIGZUQlcFeXr+mnD0Jpe53vO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5HpmnTKKlnSSAzj92e186RsDz1ONydySZe8tgW2q2kJIRTVU
	x8iSFDeMaEoCwvpRX5QPRyXxsJvxyeCPF03HPQMd18lbXrNUXnY0Yccp5s6RDe+fguc=
X-Gm-Gg: AY/fxX5bTtJvsPi5l79FbHVBsk7eTfIUtWz4gqNaHRRyxiu7IFQev48saygkG6OW81b
	T7mSo9YhPCkMB5vcZHuQoEMTAcuBJDE83s0J7YYWnR+3oRBfxIaYlpY5zRuY5f0euTjAD8xtTRb
	MuWRbJbtm4X4Ihrz6rRFevy9/o0eOL29Tq0ZfhR1DYx6mJBXQflFgb6Ei1CyM8OuZFiTgt4v/nx
	NY2FsVGqJykLqrdekcM02cwppAV7S/+Bd0kVOltI+9P4iOd7GsSwJVrLiLVjwhNjDL1ErcoseXr
	cdWAsYPIz8CV+DU6jHLROWKHcDP4UWce9GET0rEyajrKQ0Yh7R7RpZobETN1c/VO7c5fu32vBPB
	bKk9UYhpR5maiw3jPjba6LKuUuJ1GyNrWsiZee8xOGLCNx1lYbg9rokB2C96fsPwcwNXT0PJpuS
	2YDx5Zfz5Fzfy7QNcZay2GBVZMuXUcxU5PF5Hs1suIvUe0cMIlWVtQwDEsgvgTmzbGk74IfqDSd
	FmDrkl4535z
X-Google-Smtp-Source: AGHT+IEjLsxjJgm1tNq7go/FJWytc3qikX7hfJ771aCTmb2GXgsRKeoMSeIHBck7CqE/+dxxSKBwnw==
X-Received: by 2002:a05:690e:2453:b0:641:f5bc:68de with SMTP id 956f58d0204a3-6466a8d7899mr10102913d50.75.1766536293059;
        Tue, 23 Dec 2025 16:31:33 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d3b4:b334:ddb5:458e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8b1758sm7595565d50.4.2025.12.23.16.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:31:32 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org,
	zlang@kernel.org,
	konishi.ryusuke@gmail.com
Cc: Slava.Dubeyko@ibm.com,
	linux-nilfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] xfstests: add HFS/HFS+ and NILFS2 into supported FS table
Date: Tue, 23 Dec 2025 16:31:21 -0800
Message-Id: <20251224003120.1137284-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds HFS/HFS+ and NILFS2 file systems
into supported FS table with L1 level.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index 196c79a2..d5a94205 100644
--- a/README
+++ b/README
@@ -87,6 +87,10 @@ L4: Active support from the fs list, has lots of own cases.
 +------------+-------+---------------------------------------------------------+
 | 9p         |  L1   | N/A                                                     |
 +------------+-------+---------------------------------------------------------+
+| HFS/HFS+   |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| NILFS2     |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
 
 _______________________
 BUILDING THE FSQA SUITE
-- 
2.43.0


