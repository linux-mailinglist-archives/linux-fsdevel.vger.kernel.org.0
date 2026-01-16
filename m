Return-Path: <linux-fsdevel+bounces-74277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A26D38A70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A603097088
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274D2E7180;
	Fri, 16 Jan 2026 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjbpKqM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00571314D30
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768607792; cv=none; b=hBCa89L0jRrzAD6jVMvrgPusB8Gyn72UAq3kgvWnouHX3flDLbkkAwjZGEm2N5jugot4dHlf331uwaErjTO6ZlI7fqNVJn+mtgO05uVDOz3/rD2Nr8FafDXzRbhmauisy270z4X5hKFzMzFsLBDVOzJ7ZS4hnSLbh8C7UnvL8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768607792; c=relaxed/simple;
	bh=ssrw1awMHlzoCeNmpma81uflElFSx5cDdHN+Fm9icVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+qxAQlXxYpuGKAAxX/uKDLBKiHE7dikT608c8B/4y5bCi7IjhacNJ62h1lqT2joqZUxv1aVeZdDLWnLMJjSi/XJP/aKcR7ibnS/Myd6D/uUEOXZ5hzEJR8yljjtOgiE7ex+i4/UUJdnMr3ijOaYBt89MX0yJ85aPTIrMLs1WEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjbpKqM7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a12ebe4b74so24989265ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768607790; x=1769212590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqi0+2n4aorrq2pT5JlFlTiBjeqwn4It3tpxTHhJjsQ=;
        b=CjbpKqM7v7NFiM70NOhzu1p7mprdSW9fXG7geHhnPujwGTpJXGNNtzi89z64eYFdlG
         lgiKNlsro12YzHqlK1vxuHkG6fhLfMtggv/VonCKe8JZi+dDFxKW9g1luBqthBJcf15A
         7rOSsP1eZLuR/9fsMBCkG0LZWxa1bsayUmEKuXV0q0k3uLKqlKD+xWRXYEn8ee9qgbw4
         NgRT/7xYwi5DSfpLprXSGP9iVcuW0KH9lUBFDjKwS3i0q+G1eb85yG42WfWJXR57vuN9
         +upvN2Z4EUrDJrY7e+/Ny5Hdfgwmlf5OmlnwWsU2N+BeyEfyY2acG9TIJwtNjcvV+CLk
         fQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768607790; x=1769212590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wqi0+2n4aorrq2pT5JlFlTiBjeqwn4It3tpxTHhJjsQ=;
        b=TzhB2hX5eOdskIitMYqebwQB+Tt0cwNPUzS0f6OIgfIRkejzTMpiKPGe8ufH8wI6fS
         93TotJQMCqhpHpbaY84V17cuQsUuQRFcD47Ir74YwFo4yjQf81gjx262tgQ3HG3A/gE2
         7XrLMjdyedqxs0QW/525aE5vwWzSXCVaSuPktUqdmjSrIV7kvYHZhTtWzZEZ4dMOAnMz
         CLNmSXz0AeDJDedYESJcE4viJtifp4vAfxklEqjQm6p1MtcY9kNyc1tn4UFpgc+0BF4J
         KHx+nCFY8Tck1Hj8KbLjMoTsWoOxw7vgsNn59KIOWVIsjjm2QuTqMMIL8vHrFBKGOwF8
         yaSw==
X-Gm-Message-State: AOJu0Yxqi2fmMALCFFodQxWdYDEp5RQSjVTvtnAGGU7QOpruXkSZt9sx
	pGInX3omTkByx8l6i3T/17R+MFs5urKufFqjedYCqXclQkM7fxMX9a1q
X-Gm-Gg: AY/fxX4iyN+XCUPNNDTpyd1PJQS6p1zbqco/buZLySwmFwi+d8iBKXNQPUngqUjpC7Z
	fBv4IvOqcqmFDXVQFBmOlrZxjS+cCyMw9AVH5dTohQ8M0/jAWKCTIJcmlok6xSX9GOISUwqhCGm
	Q6auLyN5D/UrU6zpBpa1I+gd7jmd+prqp6lgyaM8zZIAkpEo9OXfKl9MAyPhXss1WJ/xY5Ta42E
	ONQS/dnTXkJRuLDqUcfDK48Mz1EMF/jYgAUqY10XtKvf+jMkeyv9gMReEcqaAc21v7eLYRAknxR
	CWulP7ew8HM1NTFN/3Sq+L7bjWHybc9Nk/6htdoWb5duvI9MBVuHo5QZ+WMxDm3SytADYAtQ5JQ
	qFi6A5Ny1ACEinaGG26Qs93zDeTdcYvzWEz9MY+2ihSKUHEReCaqdDCA9wnQit7CAMXqUgnclQs
	F4IDjfZw==
X-Received: by 2002:a17:903:2f8a:b0:29e:e925:1abb with SMTP id d9443c01a7336-2a717568d79mr44511365ad.27.1768607790452;
        Fri, 16 Jan 2026 15:56:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fc880sm29969365ad.80.2026.01.16.15.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:56:30 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH v1 2/3] fuse: use offset_in_folio() for large folio offset calculations
Date: Fri, 16 Jan 2026 15:56:05 -0800
Message-ID: <20260116235606.2205801-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116235606.2205801-1-joannelkoong@gmail.com>
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use offset_in_folio() instead of manually calculating the folio offset.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 698289b5539e..4dda4e24cc90 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1812,7 +1812,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		folio_offset = offset_in_folio(folio, outarg.offset);
 		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
 		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
 
@@ -1916,7 +1916,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 		if (IS_ERR(folio))
 			break;
 
-		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		folio_offset = offset_in_folio(folio, outarg->offset);
 		nr_bytes = min(folio_size(folio) - folio_offset, num);
 		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
 
-- 
2.47.3


