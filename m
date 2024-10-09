Return-Path: <linux-fsdevel+bounces-31449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9B996E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D661F22034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8A1A2567;
	Wed,  9 Oct 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MMd6c0jx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098FE1A0B16
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484904; cv=none; b=a2wof9lHhzhaeQ51+Yr9LaVxPyET+60IxyfecLPjTNLfYxWT7y/B4s95JAlEe6veuxj3e5vXD3T11haZHGqdcg9imVU9TE8m8EJ2jtx7t3i1w/zP983idBfrZIDYHQOwUwqqd6JD7sRAa9muZUYMMoJ2+4MwZiz4eANaVFlOO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484904; c=relaxed/simple;
	bh=x1PEDGoQZwbge4Fs0/XyWOQN0GzDczYGkUFOvNnIEXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6SnGittRSi8wWlh9rYhXi+5gxT4MYzLQGpHQ51y0VuTcLI///X2L+4yHGGh5wBWf+YY48ocCicT7Z+3ehF0BUD9nPZA4epBFQGLF+2nkM2mLC1DXFD673evh4HAFn3xOo3mcJZaDxUQpAHtEQUWoOdDRVNHWx8Ty1LiDyb5NMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MMd6c0jx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e05198d1dso2404171b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728484902; x=1729089702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=262u3WRSsnZCS6tRA/wryh4VmMTwkyxbe0lMaxXGOBA=;
        b=MMd6c0jxPSa1HgufRPOSfBtaBGFCjblfIJA2K7hKC3CnW5T7E+LY8nviBarVirRQ1x
         GRUargm8fPXekdmqIQRwQr9rtAvF+JYe34OjtlZSRbGFal7Tn24YFYhMN0XJlR4i2xea
         oChWpQ92PIlcwyRfRrgn/SCyUj0E2LXdzm4y2bLrpNJTyUm4QAO7GHKiUrp02GtFSjZu
         iAWfUQBiYS2bh2WngfVNCYpQ33ouT21H845Z0M1L0Emfxh3RZguvGMkRGVSKUfxMwDoe
         uFbWocIoUOlF+Y+gX6j3uNGQvYOeoFVppU5Iy0p6+YVl1AQOUo1ZuBCQ+ITza0dcz43T
         Jh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484902; x=1729089702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=262u3WRSsnZCS6tRA/wryh4VmMTwkyxbe0lMaxXGOBA=;
        b=oaTIi7wTa+r/CxkkHChsGq/Q8i3rBxfg2L//EBaMhxJCGH9rAhDOxDdw8YFuznvV8W
         9xHaGephIhmSmSoh6T9POOP8tkB5eGljhIGWo6GnAzGJ/J3Hit0LGPmqdS+SmHEo6DRM
         avZUUuj2ZW31ZiMWMIfxx49mYdyQnWG3Kkni7sz+H+8WZ6dDdyo55Pxp//xI+r28QDhZ
         nqG5Q10UCwuDfA4Cs0d6twJF+TKrhWFpnOlyzXxu+TwQ+72052J4mzt3A11arwaJUPTq
         QnCSMUUOgurL/uOHVabyewbFaGX0diQUS6DafTIWW8M4Y3FH5OGchqVVT3jzJqqV6rkI
         k4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVoj2Xyy8nFFjAXailgNdR1mgnoHYM/Jt2QWnCtfUDiEKykKtPj45SRjfFmCNAoUQHXF7mZhyt5UzcaAOy9@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqLOvtoeCjPWTU6yAosDSioi2qKbJLAdxF17vCbIN+0k94UGC
	4HzHlWwFgce4rgGZRAl+RlUw6SAsByMMOEMSrNhLzaZa9ZhDZDbir9LMiel1ULw=
X-Google-Smtp-Source: AGHT+IG8FUHdCZJ605uLVInPK/Fx/m2C72TUt/JwkrShuf6hbCKGofvSPaCkEirNpBKGNWAE8tweJA==
X-Received: by 2002:a05:6a00:194f:b0:71d:eb7d:20d5 with SMTP id d2e1a72fcca58-71e1db74bbamr4668154b3a.8.1728484902193;
        Wed, 09 Oct 2024 07:41:42 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccdb64sm7852764b3a.48.2024.10.09.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:41:41 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 2/2] mm/page-writeback.c: Fix comment of wb_domain_writeout_add()
Date: Wed,  9 Oct 2024 23:17:28 +0800
Message-Id: <20241009151728.300477-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009151728.300477-1-yizhou.tang@shopee.com>
References: <20241009151728.300477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

__bdi_writeout_inc() has undergone multiple renamings, but the comment
within the function body have not been updated accordingly. Update it
to reflect the latest wb_domain_writeout_add().

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c7c6b58a8461..72a5d8836425 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -586,7 +586,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
 	/* First event after period switching was turned off? */
 	if (unlikely(!dom->period_time)) {
 		/*
-		 * We can race with other __bdi_writeout_inc calls here but
+		 * We can race with other wb_domain_writeout_add calls here but
 		 * it does not cause any harm since the resulting time when
 		 * timer will fire and what is in writeout_period_time will be
 		 * roughly the same.
-- 
2.25.1


