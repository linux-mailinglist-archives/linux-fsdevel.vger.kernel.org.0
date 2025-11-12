Return-Path: <linux-fsdevel+bounces-68028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2162C51498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7B34F856C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFAA2FE042;
	Wed, 12 Nov 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="miMbDpEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235C2BE02C;
	Wed, 12 Nov 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938274; cv=none; b=XZRWBLzPcZM5ENEaj4f+3ZyU7RdNcrN4uHskauo21+EKF5EQfanM3WgHWxJotvKbvUtBmWNZLsLYQZEJ7N2nAh+Tm0fTRps+ow6sq/1QHQbtTq9WqtgX0KvrzpkLAEmpvWD4/C5PTobijLFCnKPr6u+/I6HhbvyipRo87LK3ZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938274; c=relaxed/simple;
	bh=lyjZXUrlphIxuixvBVLAjK9KndUJkhS7WQvlj7IaeTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HarwMxwn3ZQj+uNa02alnAzTuGB29hgHDQ/czZzWQ1/OlV5XdQYTMrvpk/olfoabPEl9x/G+cWgney1ilLQP0My2tMK3sHgrIOp3le4+Tc7I6RyIa3OpI0GP47blG+D48WTw5uLJXWASWv3JYHYeLxv/s0C6/ctNJMoLfxRQcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=miMbDpEI; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=b1
	zPTdN/hA5mnggfUMyqH4kKpci5g4qd+230XAq5yYg=; b=miMbDpEIFgkCUJax5z
	1Gx5VNj82HQNZAeN+X6tBVeJAbFn+e89ov37pzyGcESM9YRmdIOIZQHOTnr2W50f
	X7kcBUqeN29DtrYsA9YTXjDmYJq3sO0sQfKdY74+c0HsxvFXqk4YrbQIEh3LauAS
	M5PmYjtAUbmv2FTrJR78Tf94E=
Received: from DESKTOP-IUGILCF.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3v75iRhRpBsW3BQ--.41139S2;
	Wed, 12 Nov 2025 16:33:38 +0800 (CST)
From: HsuehBo@126.com
To: linux-kernel@vger.kernel.org,
	trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	HsuehBo@outlook.com,
	Hsueh Bo <HsuehBo@126.com>
Subject: [PATCH] nls: fix byte order conversion warnings in get_utf16()
Date: Wed, 12 Nov 2025 16:33:24 +0800
Message-ID: <20251112083324.60209-1-HsuehBo@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3v75iRhRpBsW3BQ--.41139S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw48ZF1UAF1rCr4xKw1Utrb_yoWfKwc_A3
	yIgFyDXFyqgF4xuFy7CFyDXr42gay0gr1UJan2g390kF17GFy5ta1kurn8G34DWa17Arn3
	KFy8CFyS9FySkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8dwIDUUUUU==
X-CM-SenderInfo: pkvxvxler6ij2wof0z/1tbi3BIE3GkUP8ZYywABsA

From: Hsueh Bo <HsuehBo@126.com>

Add proper __force type casting to resolve sparse warnings
about restricted __le16/__be16 conversions in get_utf16() function.

This fixes the following sparse warnings:
fs/nls/nls_base.c:180:24: warning: cast to restricted __le16
fs/nls/nls_base.c:182:24: warning: cast to restricted __be16

Signed-off-by: Hsueh Bo <HsuehBo@126.com>
---
 fs/nls/nls_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..4c6fa02e01d6 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -177,9 +177,9 @@ static inline unsigned long get_utf16(unsigned c, enum utf16_endian endian)
 	default:
 		return c;
 	case UTF16_LITTLE_ENDIAN:
-		return __le16_to_cpu(c);
+		return __le16_to_cpu((__force __le16)c);
 	case UTF16_BIG_ENDIAN:
-		return __be16_to_cpu(c);
+		return __be16_to_cpu((__force __be16)c);
 	}
 }
 
-- 
2.43.0


