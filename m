Return-Path: <linux-fsdevel+bounces-29434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE05979AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0945B1F21BA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 05:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D8A2D032;
	Mon, 16 Sep 2024 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsq2KmeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614623A9;
	Mon, 16 Sep 2024 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464093; cv=none; b=uFKZvjIE6ce1allmuQSdo8fmRxrO2ViVgbEFeUiOWykLPijnHE2dfEmIr9NKwHkYtp1sBbwYdKhSh8WSbe/DBNsh3lVEQLalhkfXGTq9pXWN3XOPDxn+E0Q7WKk1Hm6m15K/RJQU7YGyGcVEFoOBly00P03DLCooK67v4vk0a9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464093; c=relaxed/simple;
	bh=6BSWlbShZI6FKCL+zCzIx1gPc3gWvUY+0MVQjYwSloQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UK2uB2S0fuOTBwvsHMTGdajmlJe0yI7OHmoRMIvNMS0pmJxY39/6LqkppTuR0O4veSLA0iPC0SraqUH3ajUN4CRRj77U1X51CBlqIsqJmHDASoE8dXLQ13Gt8YWGjyFnv/xXrfU+mVKRTegP9564VNkMfScMj7wsQG+jaKKo4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lsq2KmeB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so1932258a91.0;
        Sun, 15 Sep 2024 22:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726464091; x=1727068891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZPn/+H1ASm7qkxU/tBBk3TPehptgKtNICy+pHBy4t4=;
        b=Lsq2KmeB/YRjptOC8fivjzPCk1WKoLGy1QVxVK4x5LyPQeD8/LnO6E29pvEVzsma9v
         2heihrKj2UKBVZOKONmqqUXIySBq6zVRuAn9P6hIWK69QB1BvnrcOxUe9euyQ9OiXf0k
         TdcWWKqCQtXRaTZhT+I+qciYy4gyatqK8lAzgKABKFb6dO4yquTNjUh/MOI+hu3F0Phg
         Z5lhFzIzDoI1f9MG/sHCqpEEUr4J3wiWiKrAYNGDLdTDew760MAjrOe2J8LtFD5KxA0V
         Nk+Feni7ZfeqJ+JbRytPoRxi26fHy4lvqjp0pquXh1G7b73YNksuCrhK+eHSqDhvlGaX
         OjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726464091; x=1727068891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZPn/+H1ASm7qkxU/tBBk3TPehptgKtNICy+pHBy4t4=;
        b=IgoAAEGH5dQSlYvonbodco2r1BT82UV4F0vNu0NoCmhb9InNiHYCwufqurShqKCqfJ
         dTwjZKGM4N1oXBAMNwCDinXnx5g0g9wFjNPaN/jCZEvb1VnG4zZQTA/seJi3gMZ1LLhQ
         4c7ffhMHnTIA87czkrAd2zKbpMBrER3UpHOIPU3lZ3V1tulOxAjdbMhSiswRpnwxjTVB
         KkcL+I5RIjzpVNslMhfzgWyTnVfhiSjn3+WKli+GdrClHVSgkQUmVqgg5is1r0qBybX+
         vmyfA0CnfJoJ6YnnWRzG87/pL0mMANfmEV6TwDrARvBtiI1OqILEth1LaguyVZEQ/8kd
         bm+A==
X-Forwarded-Encrypted: i=1; AJvYcCVeuN++nqDHe2jb8otsZfhJxXMqe1P22cHRHagNztyBTAw0Gkx7J70ElpH9eoTbkQIkKcF0CYROjKkX0wt0@vger.kernel.org, AJvYcCXbW/Q0e5mSx1eKT0sw8nX+xsILaJpExBMYcYbHtTJW5W3HnvxslXrOa5pFSnHAhSVOpDTmkkgqTes3R+me@vger.kernel.org
X-Gm-Message-State: AOJu0YwXA4nWlhUfpnRhPSpN8cZNmMVsiKUnqdz+IJ3XP1OpaLkc9ycU
	qr/vK8k3Sg9YSTsyb+MGCr96jj+rfH/UqsmtkBkoZANk8OA1C/15
X-Google-Smtp-Source: AGHT+IGIAev7q4EhRphohWsMsUIEQhAipsPoO2zMLEYpKFlAbc/5WIy3Q9fd+3+buaY+vt+c9Fj0cw==
X-Received: by 2002:a17:90a:c697:b0:2d8:6f66:1ebf with SMTP id 98e67ed59e1d1-2dbb9e1d090mr13285136a91.20.1726464090813;
        Sun, 15 Sep 2024 22:21:30 -0700 (PDT)
Received: from localhost.localdomain (syn-076-088-006-086.res.spectrum.com. [76.88.6.86])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2079470f179sm29624525ad.230.2024.09.15.22.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 22:21:30 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: viro@zeniv.linux.org.uk,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Subject: [PATCH v2] fs/exfat: resolve memory leak from exfat_create_upcase_table()
Date: Sun, 15 Sep 2024 22:21:27 -0700
Message-Id: <20240916052128.225475-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    If exfat_load_upcase_table reaches end and returns -EINVAL,
    allocated memory doesn't get freed and while
    exfat_load_default_upcase_table allocates more memory, leading to a    
    memory leak.
    
    Here's link to syzkaller crash report illustrating this issue:
    https://syzkaller.appspot.com/text?tag=CrashReport&x=1406c201980000

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
---
V1 -> V2: Moved the mem free to create_upcase_table

 fs/exfat/nls.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index afdf13c34..8828f9d29 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
 
+#include <cerrno>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
@@ -779,8 +780,13 @@ int exfat_create_upcase_table(struct super_block *sb)
 				le32_to_cpu(ep->dentry.upcase.checksum));
 
 			brelse(bh);
-			if (ret && ret != -EIO)
+			if (ret && ret != -EIO) {
+				/* free memory from exfat_load_upcase_table call */
+				if (ret == -EINVAL) {
+					exfat_free_upcase_table(sbi);
+				}
 				goto load_default;
+			}
 
 			/* load successfully */
 			return ret;
-- 
2.39.2


