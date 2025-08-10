Return-Path: <linux-fsdevel+bounces-57195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AEBB1F85A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17CE189ACAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4F1E47A8;
	Sun, 10 Aug 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYG0b6lA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637BC1DBB13;
	Sun, 10 Aug 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801295; cv=none; b=HzOLVhl70+idUUs8TXtimoEkgyNQdW7elSU6CdJ2LmhPobyw9fX+mADWBdxL2xyCWQpcVHQZ7c6PPGwr8y12jajcinYzCQanfEB1hw/5cDZBUvEqrwHbLmjZ/hLXwM6WptpVIT7Z0EOtpqPKWzJ/7JVWAIsyumdrZPpCk3tAH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801295; c=relaxed/simple;
	bh=C8nrC1IFc3EI/BkP5+Ca66ne1NgDoTqJ46XyrCMrQzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zt2Lo3xGhL4bpcx3Zvk4S3N2cM2dWgrAsG3fsVIuTfdGM2Xf7vPmX7cPUlHRsU0QDEeK0UZfsi3k8z6fwEJds1EJyfpr3VYjdD/AsRU3bsYe4IriP3KazdWPvycMcBBHf3a2LeawtujYBvCYC+UUZ6fkH+DXeG+zk+lIOocIAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYG0b6lA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b421b70f986so2412904a12.1;
        Sat, 09 Aug 2025 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754801293; x=1755406093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ5fmgGeCdzB2I4GI1U/BvqGbR6CHSQL8u9JN/WFBmI=;
        b=dYG0b6lAn0xembK720xzgkmDujt+TEIUBm/eoUoxNrznWMbI9cBR/HeS6U9FJKtfmy
         3L+WpkWcma9D/De2o23Pusi3t8FOOyWBpAUomFZFfV/cq6If72OEvoNPNs7yqxC9nexU
         SS3AYhJTk5GkgsMPBNQT5V4eePUaNpGw6f/S1dIdzuVOEmOjRFumA8+2uhF1rCFY0w+R
         013yKcNamcAMFQncnDOWxT/2zAwFO2SY2kWTbUBou32R9AEskZfmmhX9Zg9B1bZvmHS1
         qSfBeEmsjFRMFoduEkZfFp3BGCJRVLOT9NYzMKLrZMRd1UwVgkEJDNqhw+O4FfJW3uVZ
         2l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754801293; x=1755406093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ5fmgGeCdzB2I4GI1U/BvqGbR6CHSQL8u9JN/WFBmI=;
        b=OXf/yicx2A5Y+oxMKsDfxQRgz61+aBxO7ZT4l6lVIsTuDROCgKTpuxp7+F192Ym/l2
         /H8vixlveyChrojUmUKJ3G8fE0oe2lEZCpKIGhLOMTlYsQYFStTduMfundI6FBx/G5SW
         IsbskMJr9i4PgQ3HqPyMUdi0Wcp9EGi18rNvP8Tviw1XKaBVqkzWMX0S5ulup5S5Oalx
         PRBW3m53jls1U4ZnSH9iu0+XuGkLETtSdS0A2CY20CGEOUs9eRTafA6BkKtEKNfjxG2r
         lUf7uvsXI4n8aZQvde9vff9WbbuaU5A3Cb5hpuG2bOCt2hOhkdG14SQHt30D6wOB8Lfv
         VguA==
X-Forwarded-Encrypted: i=1; AJvYcCUSukDZbjA37jDK8PN7TuG+6zJ9mxABA6eHAPja3f2OEOwciD3BFWyDWZv2o1JnZ3f3DH47cHzOe5sCJNim@vger.kernel.org, AJvYcCVUHny39Pw6Pv1qp5r1TpuHj10xIMrB9Lfso6MrM/YKSr5dmQ+8s2AgS7ReOldG7J6mCqEr1MeDpo+qMkC+@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpSSb9yZ7B02DvePwyvzHwHtNsampgm92xS17Y4wXHTjrTcJj
	ogSLGVSyRy/AsgGwebUKYtozBbS8GsMoYEVijFrWbtzTWcl67A1Ufgwe
X-Gm-Gg: ASbGncv2nGtveNPsvGEw44PAekyl+5x9IRueNv+/GIj2rieM3nrCLYSuYDkRXMRTtAh
	x6hfBNU+E4+RuZqNr7XlVkrGZ+gAxLlSVArH0Fxoob2tORboDT3B7eigD0FUb+FXI3uX/Xk5+qK
	3Mcx6Z9GLjhpHXRlJZReBHaV9Fc3u3kQ5wutRDt2CD0GfcGO+wm/bIo+Eoak02QhVLWLG8fYe/w
	3ZzdnnnlbhpWAQrTrV1qMLWQ75kKVHbVAWEh0RqihfHPGQjtEsztzqBA+I63KoBXUN+yeWKT4Ne
	Tj8FgPYTutTWGS16e+jhVIEk3VkMf7joOQOREVrble1QYJUXu2ktbM4V4u1Hm3M7f9gKYBwWtz4
	3KnB/aeKUK79SWR7N3fZzmQB7WbDLD5F6s5M=
X-Google-Smtp-Source: AGHT+IEijstVkN+H7I4+vcxOItVz8UOgqPXn3Xe4Uc6UfLGbFkBB19iKGx0drVHIf9pzc5RO5yNBig==
X-Received: by 2002:a17:903:acb:b0:240:3c51:1063 with SMTP id d9443c01a7336-242c2010d03mr102719825ad.23.1754801293418;
        Sat, 09 Aug 2025 21:48:13 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f53sm244113645ad.113.2025.08.09.21.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 21:48:13 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Sun, 10 Aug 2025 12:48:03 +0800
Message-ID: <20250810044806.3433783-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810044806.3433783-1-alexjlzheng@tencent.com>
References: <20250810044806.3433783-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

iomap_folio_state marks the uptodate state in units of block_size, so
it is better to check that pos and length are aligned with block_size.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..27fa93ca8675 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
+	BUG_ON(*pos % block_size);
+	BUG_ON(length % block_size);
+
 	/*
 	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
-- 
2.49.0


