Return-Path: <linux-fsdevel+bounces-43130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE166A4E9BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F36C883BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C12C2CAD;
	Tue,  4 Mar 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej+yP2fM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98202C1556;
	Tue,  4 Mar 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106211; cv=none; b=hH5h+CPSt73iH6p94JdKizNZoCk11vLkWaqfHD1OzY32B6oN51GuCa92VmIr9jBpAvPrySkzTS1GHMFYSkcKSaTVwvrfW/VLCsC1DoQRZmyh+R1eEJnZ8bSAu0X80zo8xfPosCDJg2a7tw1bAlVCHCh8iEIXF2Gv1+RujEmcP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106211; c=relaxed/simple;
	bh=2ZK91i9XsyeViiZuUTFKex2pNwvDjGUQw0C7bW1KLVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwDJNgbU0J8cD203Nm7z0ygDFMl/kCllkmWhC5Esmeo7PXjfVqJs2CSM6OLuaEjmEZZ2Jgno/Tz6ef1uDKpK47ha6z6lSjh5+yAkrJvp3UQR1BSFbDE+zE72S2l0PY2WVr7pRi0cfslpDtbNYuXYYPOGcDXKJccw5k20K25tKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej+yP2fM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so6804826a12.3;
        Tue, 04 Mar 2025 08:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106208; x=1741711008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nxGNdfaQRrtpdKySkoLLtxRlIKFtjBBmUFqnTGFSs4=;
        b=ej+yP2fMOGl4I6OTSgrDm192ZvmimVnmQZRKjJOUPS9pqYz77FbiGDMosId8bmtBYi
         /oR0u9Z/Y+O9p+q2sMautlDotkLY6YCgsQv3zaobssMRpamYjH7skD3OGY1uMU4CV+X4
         hc4rJjm2pZB2W1djFpqnSdegMGW/CZUdWbzyhw4jTmK1FNCU5zWr88HVyu3UYGlQO7v6
         JImS+iU2+TqkmgsAwX9sR6/B6YrUNJWokkNoJVeiqPljh6fj6QKpSukLGQ4cieI/mrO6
         /TJG0uF3EnDI2R/DxG0B/sL1IntAqu6HuuyLsXqqULP/aaYeKOSgdcQz4oNd72ZOcmai
         Aeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106208; x=1741711008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nxGNdfaQRrtpdKySkoLLtxRlIKFtjBBmUFqnTGFSs4=;
        b=CRs8RjrHeyGCknb0fZO6/QHG08IiusDyJBHGDVlOR6hF8kSNV1/5S9JM6riDhZYvDy
         a1O+S9VsmBz811rIaGodM9szNAhcr7MQMcp/UmBxWvMVs7RV7kW4GvlODjT8LxG/kc5x
         D973Mi7PC9M4/L85BMpb6AP9lSiammSRzPabMCTVwsVZQ9SpQL302rGIiZsNY3bmJxSr
         H8VWwhliX5dBf/OXAYVuHr/0rA8v285l90YcH75CVa8JKKgdiJTCtx4NRcVdeNaY518v
         E2Iz7yqKSMqKI5fFoyOhzs2YNiPtJaChxKe5AxDSQ+fjB4rfJZz/73TgRLkU/oiij+DH
         v+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUyUHJx5ZcEZ/kSqoYnrBaH54ulK1B8+kK5CAgQD+4mZwGAmwFaW9QlgbYiA24W9JIXXndqVpvrfBfBQ0PN@vger.kernel.org, AJvYcCVqrcYjqzC+wRVDg7OTVKdZcGT8INY5mfE+RFqNCtuxaNMhFnnraUmzr+KtLAVnigkmoLP+K0lNfTUfRVgb@vger.kernel.org
X-Gm-Message-State: AOJu0YzfbAyLfDA77CbzRBQcrsBW9Tp2VdSrsUZd7toErOViNwYK7UXY
	dBVMKonE0Tfp2ZCRK+qWX3RM4ku5tBLvgvcrOlYRHM4RTKvd0+UEkn7HzJWf
X-Gm-Gg: ASbGnctVBA3ML8rFU/JieLPhbyrUq1rsbbeDY3T0CMYVtw+jmiEcnO0KaDfYvpw4/vs
	xNA2VtmtPMKgVFcQZeRU9KkcyitmDkf5Jya+pTGoXwlO2IRMHuvsWflukeIX8NNbPsqbzQlhRdU
	MKFtSOW86dCqZWb0YlY36ycKcBSekICWghA68t9CSgOAKOwkRbUZfJ2CHcArzZkX1ZWuO5rpsEt
	V+pu3oIWrLezPil8a6zXykQ3c6KTArBr7enDNsOKJ98X7JT5mJ0t/1+wl2RzLb3CDsldIPH/ASF
	WLzjNq8sbKGi5tIa1QiZAca3Jt/YjZMLviWqEE5QHqH47vlGzmYBdJ3T2uZd
X-Google-Smtp-Source: AGHT+IFGd84YI4mGODr/3A2C48FrX5PULSDyz4Ll5zOxEygognINQY+eRMSlTy8ItK+YoohCCnADhQ==
X-Received: by 2002:a05:6402:2790:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5e4d6adc7a0mr44333777a12.11.1741106207565;
        Tue, 04 Mar 2025 08:36:47 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm8246202a12.68.2025.03.04.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:36:46 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] fs: use fput_close() in close()
Date: Tue,  4 Mar 2025 17:36:31 +0100
Message-ID: <20250304163631.490769-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304163631.490769-1-mjguzik@gmail.com>
References: <20250304163631.490769-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bumps open+close rate by 1% on Sapphire Rapids by eliding one
atomic.

It would be higher if it was not for several other slowdowns of the same
nature.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index a5def5611b2f..f2fcfaeb2232 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1577,7 +1577,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	 * We're returning to user space. Don't bother
 	 * with any delayed fput() cases.
 	 */
-	__fput_sync(file);
+	fput_close_sync(file);
 
 	if (likely(retval == 0))
 		return 0;
-- 
2.43.0


