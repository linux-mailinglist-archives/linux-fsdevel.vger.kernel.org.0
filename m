Return-Path: <linux-fsdevel+bounces-74276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB76D38A6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793D8306E5A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354EB31A065;
	Fri, 16 Jan 2026 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWsCu5Cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C130EF6A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768607790; cv=none; b=L9h42inTMY9UqzuDlBXO1gEI+eTXE9siQoD4TEX7sNIgfxWMgBLp71KZ8VaDe6MzA/0NiuAXTDnQ5n0Ic1ZkemDlhxoNDWcozg+yucFRYAQ46SAnZfZ7CVy8UFtiw2ewmNCiKJgIl1cZmldPaRoGqBXvplV7YynhdHsr2ANnH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768607790; c=relaxed/simple;
	bh=/XdPYwdaoS/INsSIzSNRNac/9POe20ycDb95O53xvnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNCaMTez9U8D/4hpqXrIkvpn6ukLNI8o51fb+OnDfKr9+/ZAVdBeGAWwn87cxhNMb3U872KICHfliv18VLQ4/P9cJMLDZFHZmn6QrwTGR46xHb5HMi+o6dY8i3UPwic0iSCgwgodzsvBRv51M6ASigu09h1qYsVreteywYF62Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWsCu5Cf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29efd139227so16350685ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768607789; x=1769212589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIqgD65YFTK4HSKGGoqySy1k4mwepDIN6W4un/bGIwM=;
        b=iWsCu5CfJslIzJ7SVkF1PohMoPBIXnI7X+X8urgUXUMo+LqLjMs0FwPmwW5S/Ny0LF
         S5veLt9YJVanlzTIswDrDEG6VfQ85vzrfJCbZ8BiqCtP3kxWSScwutuk54GK6U7qP2WQ
         bd33zEMrjiJMRyyeqxs/0S1TZ0f4fK6Xp7yru+8Rm8RyT64dz7i2qNEKeoz/8zmzao9I
         MJ7PAkfrZk/3Ar4M9GPcGaVmTOuZ9L/vHxj4LSFM3iUL4X4iIhQXlydR5T5GLhzxB9xn
         vw9gJCeDTkjnsPntZaWWjWDjZz797Lgc7nhor8EqozUIvaxoiMNCl3UAFUG/fkmeXF6t
         0clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768607789; x=1769212589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIqgD65YFTK4HSKGGoqySy1k4mwepDIN6W4un/bGIwM=;
        b=pRx8/fE67kCTx7CRorge+mhfEhN3j9HysPjHWqCMlnQuVkBcTei26xPdO+768Ep7LJ
         EiQoVF3c5dTlep5n859Ea6X9ECQvCAuzlgZehreJFlhBRfCh+RAzLLPw1unOIRhKqGXP
         lxBvhjJhn0WZFJPQC8vJkIrF+KE8hd5J5d8MpU5Ajhw2CtSBzcZPPEPNVgUcBnRenLkx
         vJXTDtRIEAz9YFpkhX7lYT9A7NWmZjP40gorHwWLcKgj0W+RYCHljq0ANHEcn/0AeajS
         lDuPvhSnyimg8WqaFK+85K9J62aKN9sWW/I/a2exof9nFJO73gwcAocMn5ONhOWhUJ4a
         cOAg==
X-Gm-Message-State: AOJu0Yzr/DhLxph0kNcUeAv95pLXaSYYBkVmM1uNXk5wEV7oVdwya+Ic
	K9I8vQFdkxosTsjnr25kp+m3iAi9PRKYlX+x4ZbdazUOQaSzoY02YhoOA+qzZw==
X-Gm-Gg: AY/fxX6YuqD8blD+YV+yYpXxa/7mo3lKmInOgTM+WKvxekFqlJeLNNmb3TBSIhZL8LB
	n98BDv0npykHKq+Aol209q5paxwjZCG2DPGxXZeAbHA2oR7TuotaUttMDsLcWeRXnZplYUuphW8
	0oCFCtJhjonrxSR4r93VIG8IqewX/rqCzjNUSgElu/dMEsSUJsNlb9nh47mxtzlrDeIk7DxI1AM
	7AeUnyEUx6s8RNrifaJVK10YH3y7V0Gds79uRfjMQfji5togVzaevhyefN9KdSZfmjn/3rKS7F+
	BRz0iTKC/khyTXlNleFNrLC4a72a7VwZOHPM8E3F4BvZ1uR46VqMj2CKySSc7jHUCWTHjJUYfrW
	uTKqyPshZ1S4ef1ysWy9CPFX7hFHkzUFiKYUSjNLK9t61ENH6t4yUP9lcOnyGX+yd2yq6vatAAx
	rJJacR
X-Received: by 2002:a17:903:1105:b0:2a3:e6fa:4a06 with SMTP id d9443c01a7336-2a7189295edmr42660805ad.39.1768607788932;
        Fri, 16 Jan 2026 15:56:28 -0800 (PST)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fb98bsm30564125ad.73.2026.01.16.15.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:56:28 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH v1 1/3] fuse: use DIV_ROUND_UP() for page count calculations
Date: Fri, 16 Jan 2026 15:56:04 -0800
Message-ID: <20260116235606.2205801-2-joannelkoong@gmail.com>
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

Use DIV_ROUND_UP() instead of manually computing round-up division
calculations.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c  | 6 +++---
 fs/fuse/file.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..698289b5539e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1814,7 +1814,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
 		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
-		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
 
 		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
@@ -1883,7 +1883,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	else if (outarg->offset + num > file_size)
 		num = file_size - outarg->offset;
 
-	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	num_pages = DIV_ROUND_UP(num + offset, PAGE_SIZE);
 	num_pages = min(num_pages, fc->max_pages);
 	num = min(num, num_pages << PAGE_SHIFT);
 
@@ -1918,7 +1918,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
 		nr_bytes = min(folio_size(folio) - folio_offset, num);
-		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
 
 		ap->folios[ap->num_folios] = folio;
 		ap->descs[ap->num_folios].offset = folio_offset;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index eba70ebf6e77..a4342b269cb9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2170,7 +2170,7 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
+	if (DIV_ROUND_UP(bytes, PAGE_SIZE) > fc->max_pages)
 		return true;
 
 	if (bytes > max_bytes)
-- 
2.47.3


