Return-Path: <linux-fsdevel+bounces-62379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD1B8FCF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B279718A1E14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6A296BAA;
	Mon, 22 Sep 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K41XHuHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B842F5A08
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534129; cv=none; b=F44+3zLJDZb5HWY9yVBMgsMVuE3X1Cf3ouWehJvjQ4TkBK1e4aLI71GBVvG4RgxGNa6n1H0DB9QiWnsgY2Vvq+gl/bzbU8WRKi9Cc2XMhl0IGnLC4tQxuVRbdJDwOX5lXMx3Mc07Ibtua+KdzWZ78diQ4y0GRpkjnSM6dHr/oDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534129; c=relaxed/simple;
	bh=1fZ7uZviR12rEngACFAWSQEQQ2EujzRN08ukEAfB3yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwJ9jh9DeVo1oVXcEprAXm/DYOHPVq4Iwg6zy52KrsN4UEagva+r9OvjS0V9fBkVGfZAUhlfjDeRo3Cn47XwHX83eo8FbM6IBceSo6kYHqhVsbx6nGqFu4YETDWN2fe4bprZHVGPYrOKbth1hbkek53njmlhhZoUxCKI3Xj+1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K41XHuHd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b55562f3130so217063a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534127; x=1759138927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knShu2WB1nekyCXSMkQd4YYY4q1/2M50bRHS1z1OFIA=;
        b=K41XHuHdO1kdod3v2kDZ6xADmhQyxvefbQjKSRB4OBC1QuzjrUlWSNAcCILxkF27vs
         AkTqsIyQalAXoWGadaWOwm1NSacTLnmCU9yMWgl2nKGarmeqSslJlf3S3Nh+RJCzVWeK
         a324n3thQ+u7UKF3pH0cDMg3MzdZQMRR2T54WFHCcZfgjJzLVXiA1HyxhH12d5vAAdtE
         ZYfjQh2nItO107Ab+Z1m7b7EwyCOuuQz0hIoXA5DjMf+GPSb7lxuYN2NBJAzxMSYeyWZ
         48I2xu8tKURSuLKg9QU/NTQuw6YGy+xolOlWT8s3rsHyNrF2MBY+WDZzkNXgJ1v+n7LM
         +zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534127; x=1759138927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knShu2WB1nekyCXSMkQd4YYY4q1/2M50bRHS1z1OFIA=;
        b=mX7X0HG+8Fv4JUNC96BJY9QCB8PSQSqU64ln3x+kdU8zg81pBZWW5ewhdcn0/giX/w
         NdD+AFXmoGyLFQlexSluzB5xMWXSFEq8Nn/buLVaej+2BCRSCOG7Z5Z0iLzV5yPElGD5
         YmFOV49EM9GnYD31vdTxSMFIwJgPkcV75Jf0100HJDp8RzSXbk04h6XhMfWh3I8bGX8X
         vOGxBU8JCQ51DB/NbbjdGedMtLeg4e/yV1PYKa0pEbWulTlgOmjj4daGQlV7RXM/uVEt
         1jlaWgosQvKBeYSpjUbE0NGRgu8WX+vs1nvhaRr4UDTEWz0DBwNtvmqE+L+PS6NGXnxh
         WjIw==
X-Forwarded-Encrypted: i=1; AJvYcCUtYupnhK4PVqY8dfEoGvvG19OdKmTNOG/s51mhzhSCREuOt5yoquLHWQUVmIrQQWTXJKKe9Skc/bLwVKRa@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4wT7/R9kaovtpLvA646a0CO7gfzRZZYrYwSz98l3Lp4gz3F5
	cInDKoO+iieVp5cs9xefgx7m49gYVMz9hzk+NLxjmKgp2UIftTjIoR2nSKSGiFl2aJI=
X-Gm-Gg: ASbGncvA6cKef8klzfLdhAwAvEgYNVfxRmI7dVkC37uJgldNl57T0lpkyG68IRKFvGZ
	47JQMwVaWz36v7XfNwzyab42ga+XquFvjJOcawJMnuAWodU8syF2c2gMD0lO4Zo/yNjL9lP0ism
	B9OfhHC0M3y6eG2+bNcYlcFM8nzOtOplKBeLVn2slfWqoidyrvNGOGKDAUbATSvk9UnnkKIGhfD
	u0UPV09rwCVfWjJPLTBrcnTuF2jcC+y/uIom1qFM/+zmdDlDxloJYL/JpCLdt0UxQSfSSFn1MM3
	xWP2LQpkmIZe59seBRMiLMXxEwJiIEo/Nk5SneGE/PCziwJc5Ss0QkuxsO6NyKqOU7k5WkIvjMn
	U7ZfnpMZRpzlt6Hd0gAoPx93/StHN29wjeiUF
X-Google-Smtp-Source: AGHT+IEKQqaW75NwldMxFG0uIxBj1RxwlHvk40EHsE9KBkx/V3aCLEgpZJRJGmMKZpoisXIb1QsxfQ==
X-Received: by 2002:a17:90b:2681:b0:32e:38b0:1600 with SMTP id 98e67ed59e1d1-33097fd897emr15908772a91.6.1758534126690;
        Mon, 22 Sep 2025 02:42:06 -0700 (PDT)
Received: from localhost ([106.38.226.98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55268e73f6sm7544132a12.21.2025.09.22.02.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:42:06 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 3/3] memcg: Don't trigger hung task warnings when memcg is releasing resources.
Date: Mon, 22 Sep 2025 17:41:46 +0800
Message-Id: <20250922094146.708272-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hung task warning in mem_cgroup_css_free() is undesirable and
unnecessary since it does not affect any user behavior and there
is no misbehavior at the kernel code level.

Use wb_wait_for_completion_no_hung() to eliminate the possible
hung task warning.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..b7d9e795dd64 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3913,7 +3913,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+		wb_wait_for_completion_no_hung(&memcg->cgwb_frn[i].done);
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


