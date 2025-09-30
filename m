Return-Path: <linux-fsdevel+bounces-63129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30CBAEC61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 01:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E50A3C7A8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 23:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7E2D0C68;
	Tue, 30 Sep 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPDDThNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D02D1F44
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275008; cv=none; b=mbf8d4lnMrDwazpKHHLyDhcqiTcMiIU6PgPdkQZZM1JounEm3B60HmjUo9C8akuBvKOEr8I4uiZjZ8WLmEQ6D419GVP26FjoOM6iFyxP9HZvKQGlzgKn7wwrBqdhI7+zgu1spgoADI8AaRp5xNoSPyWJLvx6r1jjGQwHtL41pdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275008; c=relaxed/simple;
	bh=gWZTJSIIbrP380uCP//L36Rf0RBfgxrLDVwOgWvpHuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQhGShRWr+xcwamEWoTUTmBF5yfiPYjkGmJDbmGuBrDyB70waRebB8N02jKrJ2ce2lp27TddFx30EyV1t3pvyeAQYSmLS9uIL0edcc54PclEfKbfHJGDIlHem05CZcdpds1SmIzYybTd82RD8Qj8z5mUAWK80SnlF6hUsMfr+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPDDThNY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2e363118so62673905e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759275004; x=1759879804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKocoFyhYs5voJ1j0rINOqN8fPDxe4oLJZbuE7DLMzA=;
        b=aPDDThNYGfv4RuuzIaALIH+FJDaJ9rnuS84vRUSXVvQovK25+wvuQPWWO3Tq9CsSqv
         XHSGh/Y0qgkmqIaKTMtfjr0ZIK/4hwoOEMCKnkYIMBiN54jxbmCWeCbsnEFamQhGzxev
         EKHjaDDA1G4346OD5SyprKz1xEoL63o0a+mxUzstxwmF2Vly1Y2fkBW9GrNYfiXwn6vY
         a08Ww5KPI/kfCDg+VfPK1fXPxlD/5i+DCPSMoPStkeA1qv1U0lXCHi0ZIaPr0y5/Ol/R
         ZRmXpjgCIu6y4A1Cgt0IUxPlbb2ydOJGYEw5jDi441rSX1POfLYwtAqN6N1JVvd6Mkrt
         xJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759275004; x=1759879804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKocoFyhYs5voJ1j0rINOqN8fPDxe4oLJZbuE7DLMzA=;
        b=rVVQwa3kH/Qklk4/vnooK/r9phgQx6KCpw4RF0t/Wj/I0o36YjTxsiJD0C2nVne94W
         2WzxglMhqvKWTTDQVKsQHSIhKL4sEDbeWxFXEZS2xxw+rgXDpWaZ50nY1RnNmglrYJXP
         ApXKNnaLUq+Epr2BKB9IOXFqe6TN9nd6HBL4Qwpqam/WKdtvyKy9/67GiOdMwQpD+kRA
         xebDXqii8igTRfGeX2AJbIemwpn4NyjXWX/qNcvVmCDnVDB/dxJPs1hENwIWm5m+eyBy
         GQW+XnziQVvrq7WbLtTl0wLPsZTKAj/AK/kDIAb9d5ef8m7TmmeMXJvRr5/3JHuiQV0+
         wXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl2nVxp3uz2o9x1sGXFizbewplJWG7bTg2WKi6xh5X5hXorHFFL4zfu6f9DUD/8p5DUiX4uqyzrobLDCdy@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtUGs7pIoA5R/JOyZDyVcDEvbB1iGYfgwUr2x96LtDIiJPDW9
	Ie+Z4gf0DbEsEVR9G+I0ldLu69k5gCZaspV15lcuUOzfJBJxW6q1jqvY
X-Gm-Gg: ASbGncuAR2K8qiJHsyS+x+c1pK0S7fLuwkq/wccjeFwhdX5VFGnr4qwzFRRZIAMN/5r
	HdYEAc70HX21IoBioZs9hD2sWIlPBm6HrpG3Qem5UZs3Wywn8F4wMnh+p8y+ZAg0xzpfDztUrr/
	uIR+PIW/SLqcEhl9JYB+JE29G6qIH+NrSQDr2mV509FbUUpCUxYx48GfgZZhD8bxwE7AmK/ZwYN
	BjtJOHb1WHSoYbmP8KJGyiI3G24AiKEkS914rvZCaRAsBXukeiZjRBx4kys6AXso9I0cvdv9ce7
	w/oryTLbVxKk87o+pnSsSorLYN3rOWL3A8WHTb/+N8vHHzoZZYuGzR3uk7q73226mnIl6N2GNiJ
	CDU01WxlcARFgnAu6UrprNHY4MAiHVwKRYo88+W7J9gZRpRtchIjmdb+20YwfYdinyC9t5Lm1E3
	Ci7Odtul+xaw8/fEyLoEI3Fw==
X-Google-Smtp-Source: AGHT+IGrlrBcqkdbjFn8gHHNIH9V5H/OJUSkp8w+fjG+KJIkz3Qh/I+P4TAxPxRIKI9Oo1ZDCt+OuA==
X-Received: by 2002:a05:6000:2381:b0:3ec:e0d0:60e5 with SMTP id ffacd0b85a97d-425577f0a74mr1070502f8f.15.1759275003933;
        Tue, 30 Sep 2025 16:30:03 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm25156984f8f.12.2025.09.30.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:30:03 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	oe-lkp@lists.linux.dev,
	linux-f2fs-devel@lists.sourceforge.net,
	ltp@lists.linux.it,
	oliver.sang@intel.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] f2fs: don't call iput() from f2fs_drop_inode()
Date: Wed,  1 Oct 2025 01:29:57 +0200
Message-ID: <20250930232957.14361-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202509301450.138b448f-lkp@intel.com>
References: <202509301450.138b448f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iput() calls the problematic routine, which does a ->i_count inc/dec
cycle. Undoing it with iput() recurses into the problem.

Note f2fs should not be playing games with the refcount to begin with,
but that will be handled later. Right now solve the immediate
regression.

Fixes: bc986b1d756482a ("fs: stop accessing ->i_count directly in f2fs and gfs2")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2619cbbd7d2d..26ec31eb8c80 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			spin_lock(&inode->i_lock);
-			iput(inode);
+			atomic_dec(&inode->i_count);
 		}
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
-- 
2.43.0


