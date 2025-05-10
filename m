Return-Path: <linux-fsdevel+bounces-48669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA44AB237A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531724C83A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7513253F28;
	Sat, 10 May 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kulg6m0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D97254879;
	Sat, 10 May 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746874000; cv=none; b=hNt2gFOuQr+4DwmN4gdqcwuWgbRKgJNgF351sHdsRkWYnbtuhnOCLxL7NR2v/Zskte/z6Kg1YyhRDsLFFNFNCmIW/mORiWTMXPRDo/3Gd8Ek6jAGWj7Qdnkjs5Naze1E3gDKrTCHLGI02+ix7gdMDwlN45eRqtb7rDSxr5JFIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746874000; c=relaxed/simple;
	bh=tONAWPbheqZjSOzRMjKyQd3ii5Bap1iy55kgm4/x4EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sT2SX8oq1FCR4CfJ+gXTDwvzfOvJpMq8FwiTVTSVKPng9zlxaMxsL8FioctXsBdEZHN1Bemas2LUce2ZdKmIwZClvkD2jI2CTWQe1ZkeUx0SDxMrPwFNonePOz5RXcMieL/60XMspZ1YP5diGskOIFDClTu9AT+tGItvQ4uCJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kulg6m0k; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso2798276a91.3;
        Sat, 10 May 2025 03:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746873998; x=1747478798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TD2h6O2ZELE0SEdlV6FfA/tFTtDWEG+f4vWQoSqX30k=;
        b=Kulg6m0kpmVTAupQgMNMKdVfOOHllugc0h/htO6uJOBa5xTSPm19jHZWNNPMMNRPrK
         hJ/cWm0gCbGJnbzT1wQXV7hwCurprCNaH/iIWu8kKjT6eGavy14T4cAsiEqlwRT1lXHV
         ir2nwwmDTT4OtRZJjcVDtvFXe8K8ljGq28vDUvcAiK5uwOa4fqiUaXpVmiaQ3jUkwBbt
         WGiU0IWW0sbeQhVMe9Xn1/orwlaj3SC6vQLeIeShj3tBRUACZ49tjILOPZffsjf0z7do
         yetvk31QaCBalO2M87GZd/9TS46+nhSzUMHqxSXwAUpxoI4ypkXfp6P4r49DEoVqA3lj
         IC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746873998; x=1747478798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD2h6O2ZELE0SEdlV6FfA/tFTtDWEG+f4vWQoSqX30k=;
        b=hlhlSM6mHpO36ltNvCSDlmkoMLK3o6+HHp89b8Rk18N26pW/RN+q8RcAKTGIHSUgcJ
         5u5Uf4aqz5LJdDlwaElcmFdrG1+Br4C/QZ2nzlGw8DghKut2UyveRNslrq0QzcauDeft
         JpN3sTt/BHd+ymkW2ZLEYldugpNuTLq49gam+C9bAWfbtrN6Y/WiLSbvvl4WROjVJ0yT
         mFdHmK5LFc+iKx/yDBfow4IbB7kHnfffhU3FYBGMdUBoFpnldusXeLBIbhHhcPVAVWaJ
         zdvadNygqiadO9IwSTLJAt9MGsqpI/iLYJd9XOQ4R7UvlIY8uzxhz8NEV43GZBF+2LEg
         Aszw==
X-Forwarded-Encrypted: i=1; AJvYcCVrDv+KFWaklKea1VoAuCk+1hSPXUtW60cufjZefjGVA+mvSNmBSeES70y/OX8cVjVFtoO32gspu5Isccqz@vger.kernel.org, AJvYcCWN1Jm9p8BQGn9UqZpGrOr+VT9Qg56OPnCSK/iwkGIAEkHYq1+ytSlNQ/rM8Vuf000M2NySeXu4K4QtnO8y@vger.kernel.org
X-Gm-Message-State: AOJu0YxL00oaSmPvQwHDiUTjt1CGWyL09ERjXTet0UOROmi0hpMiGDU3
	Oa3P08KqArHEJ+IHHpGfn5RlWu2HwyY9W5D3I+KChpsxtAUWo7i+
X-Gm-Gg: ASbGnct+27uFqSFkN3ZpZdA8e5DACo+/wSmRfPqJnFT2TMqcYsKuEJhrVVXln7F1/Xk
	25RQx1ww0I8zoBfh9HbrD/gah7SLPo6IzCgtULxangvGpE8K6ZLT0yHr1FTWSIUO6Xp4PIH1Lax
	1AhhVEOLPwqu+41hfAPZjh7c08P8z4lfKAb0x5I6pimlpjXa8zBqhjXYgSk+nTiXD+Nv6ZyJ1Gj
	OYPtbxl7nMceH1MXZLl1zMpI7iLj9QbeiA0kJ7LTySZsLy50Y/SybjI7p75eYl89cjDyLaGabQv
	npIuINR1gjy8GyUklfGgPoQoMEWf6O/7EmiTOZBBHtNM1wiF2uV4VkndiuA96pnk3Q2hAavddda
	tsagITDbFa5iBygiY
X-Google-Smtp-Source: AGHT+IFTgEnFdE5dvjzeRSVgqLCYcGRFUweqn0/qENQ+v45c1Fu0UEUqhvKAbiD6PjqCjOfkDBti8g==
X-Received: by 2002:a17:90b:3b8a:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-30c3d3e1bf3mr10957906a91.15.1746873997770;
        Sat, 10 May 2025 03:46:37 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:9e12:1c37:6e8f:31af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e76055sm3223010a91.42.2025.05.10.03.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:46:37 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] fs: Fix typo in comment of link_path_walk()
Date: Sat, 10 May 2025 18:46:32 +0800
Message-ID: <20250510104632.480749-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix "NUL" to "NULL".

Fixes: 200e9ef7ab51 ("vfs: split up name hashing in link_path_walk() into helper function")
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 84a0e0b0111c..a2526e2103fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2480,7 +2480,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		if (!*name)
 			goto OK;
 		/*
-		 * If it wasn't NUL, we know it was '/'. Skip that
+		 * If it wasn't NULL, we know it was '/'. Skip that
 		 * slash, and continue until no more slashes.
 		 */
 		do {
-- 
2.43.0


