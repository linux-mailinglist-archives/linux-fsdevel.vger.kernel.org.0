Return-Path: <linux-fsdevel+bounces-43256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A5A4FEC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588733AB2E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820DD24A055;
	Wed,  5 Mar 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfux4Ti8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE7924887A;
	Wed,  5 Mar 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178222; cv=none; b=rnf9egDMzqtSpvk5s3HoNlOtJrLj1GzLBQQ53l8rMfPQXkmqcHPfb1io+0SnKLAvnZcvAfnXCh9FcOdzYt7WBUHvPuiCba2i3VU8/fTLKEaRghKPoAJ1A4GkEygKSNljEQDsqxSYrulmCdKDW8vUC7e+X8OgfxDdE+RSbDYKtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178222; c=relaxed/simple;
	bh=lFarR6NBkdgP4UhOE5fr4mefNelcf7WeVn1JvhvnjeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfL+qTJgAVLFWuj507kESOxmif4+F3vupg/aPp8AljQ2vHkYV1CNRBrhJ+68UEI/XErawFb//61qRqwSOCq8+W6bwnM8JyvOt5Y8LdVc9BOHUdFtxOaH+UPmrx4jfm8BzMwzp9YsWiStHUAODJdkQWwSVna9qycN5lC1Rx0KMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfux4Ti8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso11778994a12.1;
        Wed, 05 Mar 2025 04:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178218; x=1741783018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryYM4FwuDMV/z3F/EjxddAUgiRg0W1++yjtCL16Ctf0=;
        b=Rfux4Ti8NQRFJTa+hlrURLlsNDXuHYXmPadwl6k9uZ38WMtdpyhXSfqqlXz18wnlL/
         ovXbpjeg8zA4IuY/yN6ENZufb6L8lL6QOPueEQzcGzbHZuuYp+dVq8VwYq/CndUjIn1n
         sMrGOE6wT3Y3lyiGXkbohVDyev4R4+H1I/0zaEH1AHCgdajHy/SkOvdvbtfaN5Trt2Rb
         YcrJQ4Z/KgsC/akvzsVhmZHxubMzyr5+Q42T1dmjXmCbmZJfyfPO34Ia41A7ESW20FDA
         qxhsqLka0zbIFUKC0Fpn2OtwXDd93TGmeEYF+dI8fUemATPvCqapE2kYeJPqUHVSM5Ry
         lQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178218; x=1741783018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryYM4FwuDMV/z3F/EjxddAUgiRg0W1++yjtCL16Ctf0=;
        b=Cfr4o2V3RYn8NfrBcN5Hsn4mpczziX8Q/izVW2K3Hcv9gHF03UUzaNYkrtfuyOOAam
         goHg2D2O70MhrAu+BYjcVzd7AKAJl5KlN09XO0s5wL9LvhccBSJlJn4ycPrHCX0JsKKg
         8pbfA2IXAyb9hs2tBmIKMtQ9Jwnyr/7IYfWE0KrThpSx7VBzBF4uTOXFGDxuANAz96R4
         nQJeLQrbIUxmValc+EKL6UNyMhflJhGOUSAArhvPBemjX3R51Gc2FjV0MMRwTQQHoAs3
         18Csj4bn5z7xiCpvGSGGBLt+i3AUvRSJqUtEj61EsqvBt1l5p+vkkNo/yTKwU+5K+yVy
         lCVw==
X-Forwarded-Encrypted: i=1; AJvYcCUdI/gTWtjkm+HWiQGFVfuD6zwiecdzDEXn2jzJp8w2oRkgAHxLpbBH72GxSGpYSLEMMM+El+2L0UZJXGZb@vger.kernel.org, AJvYcCUj4Ja8uBj9LG5e6wUOOLMJE2weAiMMm5W4alk0cMGOdr0h3ejJSytyeM4RrKjjeI3pr0uXSdL7c5hO52a5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyda39p85iv40EfHYM3WpqlAt8lBVP0gueKDSmyjs8eyKVIP9D/
	SIeUahU60kVD+uFx84+B+1D5nEEDaHCCrGXCwEr5LAl0cMct/Qv+
X-Gm-Gg: ASbGncvYr2L9m7o5oZDszQlfg4Nw5OMYVsFAm9wobM6z2RJeetdTw/wn89XvmnH4IEx
	ZBupIumGencb7mE43NMo2n21qIBdGoUe+gF7pxrCttFUGz28mr40vltLjRjuJ+XNNX/om3UJ3IT
	7VcBtVvcOXBZgBkSKmtz42fOBBWbJmH7QubNVVB7xaiNKfHN/nJoQU6sdB9u4O0/SjNeBrdjV5A
	pqDHpDpUd8s/oovECMCdXxdVpPNQ+OavLLENXMtYGSRS4WcVmhZ1HxxmkA0oSdel5BnkvMRXXXJ
	Epa1E/PcLix1n2vTxUFBvnyTsVaEIsnJhhEcCSfFUEnMA0goW8QXKNFwloo0
X-Google-Smtp-Source: AGHT+IEUhC913u3GMAkY0GYpmBkUBZ+LbShxj3ZYBqm4cB77P0kVFYlIYrinVaEVCFO1M8qLbtALaQ==
X-Received: by 2002:a05:6402:13d3:b0:5dc:81b3:5e1a with SMTP id 4fb4d7f45d1cf-5e59f3864ebmr2559563a12.7.1741178218391;
        Wed, 05 Mar 2025 04:36:58 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfc4sm9632068a12.18.2025.03.05.04.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:36:57 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 4/4] fs: use fput_close() in path_openat()
Date: Wed,  5 Mar 2025 13:36:44 +0100
Message-ID: <20250305123644.554845-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305123644.554845-1-mjguzik@gmail.com>
References: <20250305123644.554845-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bumps failing open rate by 1.7% on Sapphire Rapids by avoiding one
atomic.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index d00443e38d3a..06765d320e7e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4005,7 +4005,7 @@ static struct file *path_openat(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	fput(file);
+	fput_close(file);
 	if (error == -EOPENSTALE) {
 		if (flags & LOOKUP_RCU)
 			error = -ECHILD;
-- 
2.43.0


