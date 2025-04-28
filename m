Return-Path: <linux-fsdevel+bounces-47516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4DA9F2BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58721A82BBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035926D4C4;
	Mon, 28 Apr 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1+gzWbU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97A16A94A;
	Mon, 28 Apr 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848257; cv=none; b=NezUspOPPorFQL+0Ty2Ftj05U0YY4qcQTsjKKUVUSQtd/NXWrYB8LCZ0/fIxfAWMB+AoqBGWLspL/5XOwfDqdx8mQy0kAXf9YnCNXJNNd7R1G4X7ujjOCCUqZx+LuyBEH62lVOHhYEO6CdlBpO2bcpZ4J5Sh/SzvLuVAszhWlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848257; c=relaxed/simple;
	bh=lQq76dRmueLQGI7dx3SifO6L5gl6uzvl5yyQmxW/zBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNS4lT/cu1BG5CwKawEU1PlzI42stysIRu2696F3/JjHNhsIuIkwV+23Tn+H49mtgW9XXS+Xg1GIRbpSV3Tb8DmRvzDD53XQZxzVmv8nvy6qBzftcDShIl0cQr2qmhpaX+x7Fr3dSgjgBteAYQb36Zlf7CIbkuYar8296pTDoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1+gzWbU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223f4c06e9fso41104785ad.1;
        Mon, 28 Apr 2025 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745848255; x=1746453055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIoP0X5XBEcUW4x0/+1BeR2G81ayGVIk254syErGqwc=;
        b=Z1+gzWbUj3sUI6ph4ZAQcLSOZWeJ9HKzV3mSAT76w7WmgtkCWZHvO490gHnsgU1HT4
         TdWDj4fPGm3sxB/C90LVu4LclqZXd1kjk+mmdni+hNVId2ipJf03u+FJvA9B1Elngz9f
         XO9Kbu98oyt+JGuGTMdmGx8+c2GhZT27F7RYBPJLt/d6pWFh6WHgGfgRpjTDdKyLzArR
         VpVLVwgzOme17tP07OrFeAuwU9/xAq37YfMacRiy6fTToCe7Gb4zkhxekLf/w9FhllBZ
         P36WZv3tbE0h6DOwRwenUwJQH6ljTXqufoCzqoYvj7LpPD3I3Q9NWm0tmaeK67D82aVc
         2YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745848255; x=1746453055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIoP0X5XBEcUW4x0/+1BeR2G81ayGVIk254syErGqwc=;
        b=hH2Dep5tQ6UkQdjnDKTWdiVtVmBcCXaxy7rNAm3YBtQsb23nvN3iQ3sioub3s7A7/x
         DpGRKvKDJgMmfPlsRyoQQwlsoWzVeCbQx9XmzSiHsni4OaJRD+QTTthYnHMXKLiq305d
         KqtgT7158hWvrvryJjqNkTkt6DyngHlacHzsW1qN2YAQi9/Fd+IpeDF7yA1BGD8J6pH0
         T+gYinoIq7s5ATuPZC4lpZ4OJkpVKKTn/PzTCPTLqScpSjncs5ylgtqIhzYQWeJpD+5q
         pgYx89cpJdphNH2mwHhy9R6pGWr3ZMaYs1DvB/I12gagGv4rJzsqdIiFI6y38YyipP6W
         WEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZETonnmr1vtNEmkPvCnav6zgi/+j3ou4px5qmM3DjZR8UL7zBFiTY7r1O8MO7SnA4EFmdl6gmMirlCOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DpMUXYyAICDTV0ncfnQ/HIHzm4JjcuON4U2eJYPADsIp7Nk8
	4JdZ8ywNcPF1HxN9XQrLyjvT1RqK2ABSHg7w7PzNhuRW0ZPOtBk3
X-Gm-Gg: ASbGncu7UxJ8UnIhsxIn1a0z+65ilM6AyATKFEAMbpsZSaDbUojeeyo+d/mZhFxYiyG
	oL8pZJ23XRqKeagJLboESIAF7zCkHv8+QBzC34170cFx5ldnvfCSMrctOaq1eb2r3thm2EzwbWP
	a6t4SreYUeacXVFDuG6JuoY57uKRiAuafH89Y107cGDhMJkrx2ZLMAoABQg5XhXCJRZ72XoE48/
	e3DrB1xX1bilBxchgDvPFR8vo0afCWPUXRMmNjz9fBSIf5aDgEGJa2IJZkpl0SQjLY66vSxu7wY
	iARZLyf15VAk0ccQAbSPddR3ztZgjzjplRxpyWqgDV5NuYhuneI=
X-Google-Smtp-Source: AGHT+IEzcxG2UpPCOfExYElxeiJDegKc/VlE1G0K7plE7/TAFQzwceEHQPlxKbBqZZx0PEoL8AY10Q==
X-Received: by 2002:a17:902:ebd1:b0:224:3994:8a8c with SMTP id d9443c01a7336-22db47f40c9mr222140245ad.8.1745848254952;
        Mon, 28 Apr 2025 06:50:54 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c13sm82623545ad.162.2025.04.28.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:50:54 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] fs: remove useless plus one in super_cache_scan()
Date: Mon, 28 Apr 2025 21:50:50 +0800
Message-ID: <20250428135050.267297-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

After commit 475d0db742e3 ("fs: Fix theoretical division by 0 in
super_cache_scan()."), there's no need to plus one to prevent
division by zero.

Remove it to simplify the code.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..6bbdb7e59a8d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -201,7 +201,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 
 	inodes = list_lru_shrink_count(&sb->s_inode_lru, sc);
 	dentries = list_lru_shrink_count(&sb->s_dentry_lru, sc);
-	total_objects = dentries + inodes + fs_objects + 1;
+	total_objects = dentries + inodes + fs_objects;
 	if (!total_objects)
 		total_objects = 1;
 
-- 
2.49.0


