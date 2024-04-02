Return-Path: <linux-fsdevel+bounces-15862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30747894FE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BA4B255CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C25D903;
	Tue,  2 Apr 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Q43HfRbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26A5C90F
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053098; cv=none; b=JYQoglUlnXAn9C9R+sp+R2au2tcL/rSA2UASoginsdP/bWKMrpY/9XjebHfHC1heEn8I/fw3Yn+2xJBQAuH4+7jIBan8OXsLyfQEjONHEQwcF59sSJoQzcxGb4pOFKOdfDZ9+bLti+1sWdLEMMIkA9QnQhkc+yU1ojpYGeHHlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053098; c=relaxed/simple;
	bh=dXhymU/yhP/SWi0YisBT6HFMgx39UOW7ypyZK3sbSQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BEX76+PHghSoRYSiCZdz0ZY4nTSUeIQxOt8WHgzrr7xgmcikXpoOArKhXWVGV0IbFkUbTFWw/lq3Hu13GfTPmEA2AgBIiVKEObUnxq/Wse18XI/M9RPg5BglwEeBuWj48GGUlHioW7ZWcguolTfvmDj6gCwtqkhAJTQVKsFoBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Q43HfRbM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46a7208eedso642989766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712053095; x=1712657895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/mwm8zCn+doNkvtBZ+vvbGDawPDSfojGEsYmNo3/HI=;
        b=Q43HfRbMt2qIs4njHO4isN90w+CAwFEB0bYcDT6BJ/vp9y+dH541xxZap5shjjhCb7
         FqaTg+BQagH32JrXbh2Itmtc8cVljuay6SP44HqbACDk5jtCXnLqhhJdo9Y9J4D0vGUg
         RLd5bfVPwoxE51ITCq/FDabHbsMzyYzEnfWwryQU0qtlOcrck+7iaa7hJp7VG0Ycu0YJ
         4Gxb8+NdSFdATq+JVf0MxU3ZsZYMAFgIcoXv8s/PzcYW87tEehOfTVclxKd9rGv1Oq3/
         0tHYqE/EANUOW93amb2Y0x6yJH882/WXH75e77mU01OthhQYKle5FXkBVNJQz5UHMbIp
         fMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712053095; x=1712657895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/mwm8zCn+doNkvtBZ+vvbGDawPDSfojGEsYmNo3/HI=;
        b=DGbjz8KyRvc9C3d5g+LPGsRgKpgPG3oLTNcOkZDOu956l5XvUWnzjMcsnPbuvFWZ1X
         ZHdGkMBYj9gpJD3eV1LdAJLBtCZo1JUFKD1Wj7ftm20F+DZm648CTKzDuVyjSvbz4CwG
         JaS8rF9t6agKXR0mL1MstM7zxm7D6e6nZ+ikc+9Yq8vRJTHdI2mi5b8AU9GAwTkZqDis
         XvrUpmPMlc2UUBVHZ+Sd/2xTpXW7s0W7Xa/9eEup4alJQaV2UvbaeDw4G+yhH4lm1ZRV
         Qetdlfb/FZUL7yklYOPy9k49uaJ3Nm8sTk2KeM0y4ULJNTF+/RsmGAU88dbXQzFDX++o
         hD6A==
X-Gm-Message-State: AOJu0Yy8H0IZ3+ddiyozYcEGEMQ6sTWhCD7AIbt58yKB9sp12Yj58cpd
	fbVAfViF/744+3Ds/j07CU9Pm63NtcOiBrkSd3+BFqdHPZmIwBWktjvdmOnddjU=
X-Google-Smtp-Source: AGHT+IGRRkrsspMxPa7CSS0ljbAnAoga3Kv+wy8nZ/y9VMIo2bDrs30aCtEgVHfaq26HrGZO6HQEYQ==
X-Received: by 2002:a17:906:c249:b0:a4d:f2d9:cf1a with SMTP id bl9-20020a170906c24900b00a4df2d9cf1amr7201372ejb.63.1712053094629;
        Tue, 02 Apr 2024 03:18:14 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id c15-20020a1709060fcf00b00a4e4c944e77sm3943658ejk.40.2024.04.02.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:18:14 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] zonefs: Use str_plural() to fix Coccinelle warning
Date: Tue,  2 Apr 2024 12:17:16 +0200
Message-ID: <20240402101715.226284-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(zgroup->g_nr_zones)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index c6a124e8d565..964fa7f24003 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1048,7 +1048,7 @@ static int zonefs_init_zgroup(struct super_block *sb,
 	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
 		    zonefs_zgroup_name(ztype),
 		    zgroup->g_nr_zones,
-		    zgroup->g_nr_zones > 1 ? "s" : "");
+		    str_plural(zgroup->g_nr_zones));
 
 	return 0;
 }
-- 
2.44.0


