Return-Path: <linux-fsdevel+bounces-49545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBABABE4A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08517AF333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2528935A;
	Tue, 20 May 2025 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxU0J8LB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9552701A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772288; cv=none; b=Kd/FdVjB00D1jQqqiFAVKsfilvg+Mx3uAzv7n7PJoEC6PY82zUDJNLWrMxoj8XD1rBPx1xX9HMJroqQsT3qWEF+er6Ni8cnqdOqDbG7hDI4rKZanyIjojwd+04rbLxk9zf7x9T21wnWHuUb1cPk3wVOK4Wp4g0bzyza9AAfnMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772288; c=relaxed/simple;
	bh=Wd0cB2BtYsRRZFwuKrTXHI6GV0c5eHQqUyIj5jjcKKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5aFDOZGYpTGsZKKz7RHl93CPeBAWw0cvpzreByqfYebBGXah3tDtuWNPZ9I9fc3H/eAh/9+6gpfdAyNHJ64KA7CzgGmL2FLrKN0xyAs8FZUfY1TmRrOKrZm/PMKuMNVMMs6rodLbKNaeveGuCyQry701hrParuaxj8hngc+2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxU0J8LB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5139342b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747772285; x=1748377085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMAmznG+qSN+j1mHqnMXWw6JVEIIzZqAC+9Q/42nbjg=;
        b=hxU0J8LByVp8Tp+Rms10RxLajH/Xa84mte3DntwkUtQpCP+avVt6cXpNXnQM4g1tdS
         YyvQCUKvRioyShH6h7rr5r6fyWCWfj8ezULlMpurA2bKSVEfpwYpIKuo7jM06d1KB2Fz
         Lka+2zVqkFXlx+s0KB/J1Ibly0hbq170saqXxNSk/P9EdkXHjQirj7aD9nd6skz4YtI1
         p8coxd/MyamM4V/48fPFfPq6Q9pn+VX5NeUWmE1wlp0A4PK7Z7gQbVjD/CWjGoUXNwm6
         VmZiGRla2D+z7JY6UvLuIctBVye9iuDGn96t6PSP7ei/7IBx/tGCNmg37/wuLLfd1cJM
         jhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747772285; x=1748377085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMAmznG+qSN+j1mHqnMXWw6JVEIIzZqAC+9Q/42nbjg=;
        b=ipQAGb24ks3CDl/Zwm6YLZsK6e2lJX1TLstg1TTG/ts+4yx0dH82TjoiLM84i2vKZT
         Rk5VBJCCQSFg5falF+dUQUlCDYNFDNO2SUDGQ07NJi/LInk+z48BwGGjKP1z6BpuDRNW
         +0olzuN3QbP/UJsID4k+riDMWVC5wr/dvAPh3IAxFiEeXE+MhYEMyMHZJTucMcMrM496
         FnpQ0SToARb/5vyLvDVHG4qXTjNIvAZI09wOkYTQzMbRksPhe3BrXSnH624KOcAlHvPM
         CF04TiAcQ5KG0Gj+T8kB1/1Rp+f3QrXPLOU7ncfSIROqL2Sj0ADPnn24hmuQHt5Nw74Q
         EOdg==
X-Gm-Message-State: AOJu0Yy8qCRqjWWB2WMUkeVRSwAZFF3xd+331oTOrPTVN7c5JDpjuaFh
	iZ4/JLCtv6qLsVe0BNugIqW4Nho+93ysgF82hFV9Ry/8mz9tktdaFBPU
X-Gm-Gg: ASbGncswoFjRCAl3M63kte01lzNDCuL8a4ZhfsNwFR88IrSD314ji+I4kCwaDQS/gKH
	Jl+lPoVPxo9BoccEEqDPasHdBWrPEuNGmWM6icJjhv6+OdGUXkjTKTGVcG01+TOqjXdzG1h7VvP
	b/1IkfEt9WPEkacgF46LCN2Kb++JRutjj3sUv9uqOfniHJw70DWf+c7LwNC1YeZOZG2QSAKM6LC
	DvjloSX6P9SY+HUSe5XlJzQqHuBafCd7zoc4OSHkh9mVa5cUH5DPZ331E2shQ0WJ6UirW3EEx2j
	tE1EDrn4gjWTDtIuEGBKS4mdybCFHIx0HokoLkE6ExynUA==
X-Google-Smtp-Source: AGHT+IFJyy0LgcEYT/e058E+ucVtoZBF/GAm3AgmqugLASzBtu/jxT14Ud/LPgaqrQ4fm78SYWhsgw==
X-Received: by 2002:a05:6a20:7fa7:b0:1f5:5ca4:2744 with SMTP id adf61e73a8af0-2162189ef47mr25981309637.17.1747772284655;
        Tue, 20 May 2025 13:18:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf70870sm8285938a12.30.2025.05.20.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:18:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: remove unneeded offset assignment when filling write pages
Date: Tue, 20 May 2025 13:16:54 -0700
Message-ID: <20250520201654.2141055-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the change in aee03ea7ff98 ("fuse: support large folios for
writethrough writes"), this old line for setting ap->descs[0].offset is
now obsolete and unneeded. This should have been removed as part of
aee03ea7ff98.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: aee03ea7ff98 ("fuse: support large folios for writethrough writes")
---
 fs/fuse/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3d0b33be3824..5bd08f231221 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1160,7 +1160,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	num = min(num, max_pages << PAGE_SHIFT);
 
 	ap->args.in_pages = true;
-	ap->descs[0].offset = offset;
 
 	while (num) {
 		size_t tmp;
-- 
2.47.1


