Return-Path: <linux-fsdevel+bounces-43355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A755FA54C35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9A1897563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BD20F097;
	Thu,  6 Mar 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM6z2hVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD820E6FD;
	Thu,  6 Mar 2025 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267777; cv=none; b=Un+X/q1ZqyZOUBje1BfB68Ic0jldWmy1VNjAIzeQ8RCn7vQIXjplOiPxgQN5UaHT0Hbc/m00zJcel1c8Fty4LHY+b+AvVW0ub9xP84Amogt4R/s975pYnnhqzUTF9j9AE5fcKrTqKjbc48ukQNEHbgTMFvp9TRm9m7AK5KuuJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267777; c=relaxed/simple;
	bh=tUjGMr2PNjVqFTHi5r1KwQNDuGEFlQEAFC+BFKW+nzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jnabF0qHtan2wHsZQV3iOo4yUtE3NXOLHXSNdtHFmfXjrKgrqPaWmdgLbPK78hJeCDJiI7BIR5J6u4uHQvIOZ5wW6YVljoJ4cNiNFTnbgV1sL+KltQZDstu4u7x+D4Kijhmoois9hGodcBCwadHvcJmyPzv/Fouc5BiVWfNCfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM6z2hVK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223378e2b0dso8410725ad.0;
        Thu, 06 Mar 2025 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741267775; x=1741872575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLwkTL/PfTbIkV/GSELW9k3O0aYAoOxcDfSxjEQxtSI=;
        b=aM6z2hVKrpRag7OqQoPNqrALc43gMp5PSkE75u8eC/p8tnEK8TkjnnM+OkyXQzq5FT
         M/3UGVqQaD4/x05J+mxNSDGwPNaWOPKQV7FeRAWjRzXK6XcW9gy4oepOeKIpxR3oSX80
         BriEWNlvqk+VAxyOtL29O+TM7D4/dHOIXeVO8LKMxR6gJdUkMkRtrvmW1rLzYugLHIp2
         Mimw8yN5a08l3U39QkFyY6DwabUN33Ij2G6NZOp+PVkFimEQSlvPb4sSVzoXPpKOXpWR
         p4zHmmLwDmoeUqVUZzBmOEc78ibZy+6L93P14jtwbTZJqQUCMP78Rqi7sqR93IejOVaF
         tGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267775; x=1741872575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLwkTL/PfTbIkV/GSELW9k3O0aYAoOxcDfSxjEQxtSI=;
        b=wr9Bn9LFdfdyd4dDGDHUggkDIszVlW8MNp2uSiVmNlp294sdtKJlSQJh+7FhzGVarh
         906CD730NLIkBkY2+hB7KTrP4a/TEpFC2roMjdS5LbhldaXSeFoGbjYdHwC7YGZSc7JO
         CjwciHE8tOmYTQ9M+tHV4saRHWrCvcOXsY3zc0rvU7wEUqgzjaMKSt7Jva3SDpBiku0J
         ge7xG27nzVcME72l3efnpjhrRGG+mxs0WhxT95jDpXUP3ggb+4aTLwNjIuItOARExJgb
         VeRdVSvL2DBTChP0JYSlPiOFJQGY3qb5lM+i/qsok19hXYvXEaKkfmrPBlPnAg28LWUN
         atcw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3w10qj2x2xc5gBcKsUt9ouHWaMRVtI4Wlzi7uW1YEmnTJTONNNNsbRGd6yf1QA1eMvM011YLwb1u9ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPipwJWRSV4KbWLFGHIm6VHjmGjPnyIQUra0U3tb0l4rO04nJ
	HnuWyDvbZN9USi7AgXjJBgvblteaUi9EX81GeqFqGBjentWVRANq
X-Gm-Gg: ASbGncsTbRVj0qGl7B1Ua7LN0aduLQxXzoiWZvaQqkPPB2dgF25N/vbqRXUDdOJqmNk
	IxaOYVPqfLxthrnXZfhTlezA5nOnHJ+DbZKY87r/bi6BkIZAwLmkebat8X6p1sUs39tj9Tm5vSN
	0a2gy5teDQLTWfamLDq9o8bAAMKjEe8VJQHQV/AyDB/zY88pxgToiRdjEcbmixGLHy49hau11Pb
	Vkg4GnyYtmQwJqYLkftvK9jHf8L9ZXy315S+eIz0GuZE2gNo97ytkqq+A0Zxozruy/owU5QsRWG
	anMhtKqyhchv85DerGGRo0zo981JanQ2uQT7k5toUI+VXINLDJAk3CS4K5uF0H0ye424Ja8B5az
	HEOWbt+QUa00BC1CmI3LWWxL2
X-Google-Smtp-Source: AGHT+IG5wdj3cx1mmSazMo2hkXpLtYe62gqdLlh0v/Gd5mh3lnljdLXxXUoIT5mERWJy2vY8nYRVaw==
X-Received: by 2002:a17:902:ec89:b0:224:76f:9e59 with SMTP id d9443c01a7336-224076fa0damr65766745ad.10.1741267775079;
        Thu, 06 Mar 2025 05:29:35 -0800 (PST)
Received: from localhost.localdomain ([159.226.94.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91985sm11881705ad.194.2025.03.06.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:29:34 -0800 (PST)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: phillip@squashfs.org.uk,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhiyu Zhang <zhiyuzhang999@gmail.com>
Subject: [PATCH] squashfs: Fix invalid pointer dereference in squashfs_cache_delete
Date: Thu,  6 Mar 2025 21:28:55 +0800
Message-Id: <20250306132855.2030-1-zhiyuzhang999@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting a squashfs fails, squashfs_cache_init() may return an error
pointer (e.g., -ENOMEM) instead of NULL. However, squashfs_cache_delete()
only checks for a NULL cache, and attempts to dereference the invalid
pointer. This leads to a kernel crash (BUG: unable to handle kernel paging
request in squashfs_cache_delete).

This patch fixes the issue by checking IS_ERR(cache) before accessing it.

Fixes: 49ff29240ebb ("squashfs: make squashfs_cache_init() return ERR_PTR(-ENOMEM)")
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/CALf2hKvaq8B4u5yfrE+BYt7aNguao99mfWxHngA+=o5hwzjdOg@mail.gmail.com/
Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
 fs/squashfs/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 4db0d2b0aab8..181260e72680 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -198,7 +198,7 @@ void squashfs_cache_delete(struct squashfs_cache *cache)
 {
 	int i, j;
 
-	if (cache == NULL)
+	if (IS_ERR(cache) || cache == NULL)
 		return;
 
 	for (i = 0; i < cache->entries; i++) {
-- 
2.34.1


