Return-Path: <linux-fsdevel+bounces-58614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E755B2FC58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6050D68012C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07128505D;
	Thu, 21 Aug 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Xdq+Wd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3782512F5;
	Thu, 21 Aug 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785903; cv=none; b=mxK0ojU2BXI4GKlSfU70XRxp/LOKKyBf+xiXUG71O/UpXL0NRHWICYbb2/inYWLJgmRYLVcQ6veHy+x86JFTCa2pT2tNvPQTdj0zXDURNA3FDxdCSqKiFALnmfGVFxfDeRMiqqhvgEAxekK80Rn9xlYBU/li7YQpGCziqG31LLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785903; c=relaxed/simple;
	bh=TcX8NeHWAwuUuwKE2XUJCBatenrLJsTQIQah1pf8+4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z/q84LRkrfJ+fovMZ8EiaGWP4J1RDbCqcc1DHpqw2N9J7RSHcYMHHwYuSzoT4TnAeiOqF9f4pps9sqEpoo5kSe8b0yUaa1z2rWWGNrbyKoreC32ge48W+kxb0tsvQzxOp2QK2rubtM09kImXCwNJ28M95/Ba5/5/wc3EHwThqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1Xdq+Wd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24458263458so10250665ad.3;
        Thu, 21 Aug 2025 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785901; x=1756390701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFANnOdyDEFo5mH6635NFLlXzZy5eqLkP42uOn6+63g=;
        b=b1Xdq+WdystSp0qmCIO2GfZBa5jcvIfM2GJpslkozYnglH3evh3O6luwW+0m901Nec
         IXPvGNzLUk+1IFjej9m3BnNEMW1bV5dNPn0Tm8fptn318NvnDfg/j8a3EUJSVy/6dW/h
         0jD8UAX1uPEY+jXRuNjvp/HXZvVHyHNzhuXS3hVQFe/4DojMY25WKuaJ8n/ZJqQE96R3
         XCitd1rYLODM5RyTJPlphQ7in25DxJ+vj/iP6VA5gM3D1SjBntfB2DHBWZ20f4xT4q91
         KzsEZpBribZV93PuQmIzyLU1rXzVBV9iDSKtNnZ7kwt7VMvKoIX8FS8CwcfZt/gDuRLn
         lpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785901; x=1756390701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFANnOdyDEFo5mH6635NFLlXzZy5eqLkP42uOn6+63g=;
        b=iKiT8p8IyXbVTnDyuPsH4YwygKs4gwwESp/16EeP0MdvnCWezqlDp40+CAJdF9AZmw
         RlMe7XPZzlhZvAJu2EfDRneoO2lXAuVE0Dottl3qdhlx8eSfxxYy0pzFhCeYHeT05y3t
         v3uMFge7YamJYFonAUmeXBLtNX0lvuR/O1MTdiM6OR+EBj1E0Qd3vlonKzt6El1WIJiN
         dd1gvgCJn2qmZ+M6edGuHkJUQESBhYaTCuQ7HdkLcdw9YEvqGmIifcsTn5v46MxbY/zr
         +ZwbV/oN6Jun+vNy8WRsY4EX8943bSPMEEcFZMafufiob4eXTHwn2h6+MNqrlI2x5siN
         zgKg==
X-Forwarded-Encrypted: i=1; AJvYcCVTQJDxeCA1UXm13K6ZnGUPcME8dy8igVPHytrD1ScwNS/RipNSyiZcHH0HSPmefJ8Mq9YXYrL0Q1fPcQUg@vger.kernel.org, AJvYcCVcuUPO3YVYy+rr5WnE1lpG/GFy1LSWubDXfv4lSNdnhKC/ocSciefYC4suZFWoGbPuU333td4xukvdWKWM@vger.kernel.org, AJvYcCVyVlXYskZ9Z2Wha8+MWoGv9/Ry6ajJqgL5sdBcopb9rjO7uI6Z1gCjHXHNzs8YpPQELK7b7qrwsfzPYALu@vger.kernel.org
X-Gm-Message-State: AOJu0YytTXAy6nNxpaZehkxnwNxqoYiHT4LhvbYiF4V08r6UolvLB/Ru
	Uv4sfODhYx99eTLwfqnfMA3JmlnKQEUpKSA8sHurJQzxp4p2Cp3agImEqK5jkdhf
X-Gm-Gg: ASbGncvBC2tppUmLTNZAci8bRTe3lpw2wBZDQr0vzXdPlt+ffFsB5JRrurAauGBmCcj
	IekFm3PoQUSx82UJyMtRy7yXxE6D3MHhrPPFZ+Y2AZE0GBUm6N0pwZIqpnWvCWC2hcwwmvs8plt
	jnFXARDwT31NdRgX2PaqJwu8nTF2vOGVt+Q56RWxqcNxyLIEW7WEzhLE2epC9GCA+3wKDjriSbG
	iiwFVRM69gswCAFdMVL3eWq4rZ+pBRtZIxu1mMAas0PfVjdoTspVyBYKnHv3hpSB9Va6i+jBqla
	bByybTXlZoS4xz6dcoa89yUnn2OjY/8lVxQh/9R2DZof4cVsZwm5MmzWpLuanMTlD/7wuj/F31V
	1+vuWluRK5OkkQTxy98sqzcOl1XLzJ9fOfXC+PHef1C39tZ4rDrRxy5xGQbS06HxidpL/M87+D1
	4kuK+FL/cRWtTgpz2f
X-Google-Smtp-Source: AGHT+IFLFpPiTVyjcFsYb/cKD5JLPSua34vdSAQhD2DIOBMCjS2avgMVs9Vs0BZDgrJDpAEIdzE0Bw==
X-Received: by 2002:a17:902:ce83:b0:240:49d1:6347 with SMTP id d9443c01a7336-245fedcae38mr35274225ad.35.1755785900849;
        Thu, 21 Aug 2025 07:18:20 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4fd29fsm8438611b3a.72.2025.08.21.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:18:20 -0700 (PDT)
From: ssranevjti@gmail.com
X-Google-Original-From: ssrane_b23@ee.vjti.ac.in
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	skhan@linuxfoundation.org
Cc: jack@suse.cz,
	masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas.schier@linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] docs: fs: fix kernel-doc warning in name_contains_dotdot
Date: Thu, 21 Aug 2025 19:48:11 +0530
Message-Id: <20250821141811.41965-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Add missing @name parameter documentation for name_contains_dotdot()
to fix the following htmldocs warning:

  WARNING: ./include/linux/fs.h:3287 function parameter 'name'
  not described in 'name_contains_dotdot'

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..945d04419caf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,6 +3281,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
+ * @name: file name string to check
  *
  * Search for ".." surrounded by either '/' or start/end of string.
  */
-- 
2.34.1


