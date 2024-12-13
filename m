Return-Path: <linux-fsdevel+bounces-37383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9809F190B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8732188F1B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CF11EF087;
	Fri, 13 Dec 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0ZpW6rS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E61EE02F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128593; cv=none; b=eRlM5Q7irndK9DLUakWdP5r961/L03V7Fhu9VJelshOXwOQZzV/3tmBSFuyh2Zr5BLr+91iGe4q6tAF1JMFTEKGtpdY5w56DVV8HZLZqiYXGhgVhz8Tvt0nJ+fp9f/zbr5jjSXH0rcue65fXDUE/lloX6wv8il4tmjjXJUC3Quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128593; c=relaxed/simple;
	bh=WS/I5U2KbI+S5kf0q8JN4Ub6Aci1t5cdfMuK8Nsthn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPJHbJ9soU67Cb5g2kktQ5Mj8AinEUShz2a+CsRxhf9/KGKcl4jYbvxIiFx/bYx/atOw9gMrOHaG8oJFgxs6mkmRn2WFosPbpb862IwkEmoFxJg/M6Zcq2BsYKNV7Kj20j9lq+fPsQgcFAbtbJsJI/hZbv98YcK7Nx0eh6J+Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0ZpW6rS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6efe5c1dea4so18267877b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128591; x=1734733391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZEX878eEpMaAmNzCivXQiiOy62n1KQMbXhhtKas1sQ=;
        b=U0ZpW6rSKxNIR2g9rHiB8fSLa1NoPWOrzFY6WOnJC48AqJKF0TUumnPUZy5943/SGi
         xusV9C6q1m+ERGRDmg23v4UcUnQSKieEGQXOYIjw7y4KFIdsxMltDmqSRZber8jltLsg
         bj6ct1uRAIQ8lIGz1FI1Z3+WwDzf1re0U5S2pPFJth3OK3Ti6j/9hUwJlvWrm5bUul7z
         Yuqi28zBEZ/QKZyk6fjC+m6cRAUrvHNKUKkdFfZAU/+aBVoUpBsd6CdmaK9m+JB3SuRI
         duNAZObSS8W5HknyoKaZYc4ivCqRSR75qQolT/Lewl37k+zqvaNtKlkTBC/189bBrX34
         zqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128591; x=1734733391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZEX878eEpMaAmNzCivXQiiOy62n1KQMbXhhtKas1sQ=;
        b=u14Cr+KhCHIVhTUnqs6DYjsdm7nvBMURrs5eePbdA/HWwkLDEuJos86mF0RA6nye3u
         hNe66r2+X3NI/2+hkyb74ejj89Z3yASrydJF0K7OrYLpJxDQIcxTLCwEX330rC3EYILf
         PiGsXzbDYzKNL7v/w38quyiaiHwgQR79qhrajRaAwSnjeut7g0c48oAgAKq7BcmoW7MN
         HgE4KyJDP0XE2g2rdJ7/L7yyYAjec3QLmcNo///AP7Cz9JBcdRTvjr0AnqvgaqaA1gHq
         Y+9UF2cGvB/ZVXI/mvGrKELLXD2vdOKRmT+WBRsCSksTAuGaeyq/iTsujZmhgU40erat
         MuNA==
X-Forwarded-Encrypted: i=1; AJvYcCWuxySbKkiriYooSH4NoWIzEgvJTQG5pClyo6lVeeBC8jSzrBvEZXN/SsZiM+zJLmlkWpoRpJgerdEd2PDE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vm/evXJ0OUwl6+lEPicsu9v1MjbefnF0BXpDPSWhocqYY7nQ
	EK6GV8VNoGsiiJNgl8X3BxPr6pkwwKepY/Z4nHOc9lhbqQNyK+HSRMv7Dg==
X-Gm-Gg: ASbGncuGsIyzEDMRt1BACVaqBuIIhuM2z/BJgXXgxair2iAbtp2/1pb7XKoXAIcML+/
	GXjNj4gZ3botPoXRv3WaFzenUYerwbQ9zCo6qr58ULLcJ9HLh1ABQM89KN1wQHCXVA3E481ahgh
	aX2Sh5jHPy8N3CymaFy9UuHTm9ubANpUveSKq3ef847inCjmtsXT3/GCl5wpaSxHhaYyf3CC1w3
	eQP1pQgZfhMc26q7H9hjXYbZ3QId6ZjS/+IAoP8oCON8Z/RY6fP3J/XQBGAjZi8GHImLBkWI0FA
	db+Cxyi9eMxfT1Y=
X-Google-Smtp-Source: AGHT+IHvRzTQ661Zf73bgS5CsEoebjBHIhNdBW1/VicyKsajnXdFuIxD5DxAbxo47iBViyj+GNxPNQ==
X-Received: by 2002:a05:690c:25c6:b0:6ee:b6b6:dcac with SMTP id 00721157ae682-6f279b2244bmr38936887b3.23.1734128590829;
        Fri, 13 Dec 2024 14:23:10 -0800 (PST)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288ff3a6dsm1221867b3.44.2024.12.13.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:10 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 04/12] fuse: support large folios for writethrough writes
Date: Fri, 13 Dec 2024 14:18:10 -0800
Message-ID: <20241213221818.322371-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for writethrough
writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c041bb328203..84e39426862a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1135,6 +1135,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 				     struct iov_iter *ii, loff_t pos,
 				     unsigned int max_pages)
 {
+	size_t max_folio_size = mapping_max_folio_size(mapping);
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
@@ -1146,17 +1147,17 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	num = min(num, max_pages << PAGE_SHIFT);
 
 	ap->args.in_pages = true;
-	ap->descs[0].offset = offset;
 
 	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		unsigned int bytes = min(PAGE_SIZE - offset, num);
+		unsigned int bytes;
+		unsigned int folio_offset;
 
  again:
 		err = -EFAULT;
-		if (fault_in_iov_iter_readable(ii, bytes))
+		if (fault_in_iov_iter_readable(ii, max_folio_size) == max_folio_size)
 			break;
 
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
@@ -1169,7 +1170,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		bytes = min(folio_size(folio) - folio_offset, num);
+
+		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
 		flush_dcache_folio(folio);
 
 		if (!tmp) {
@@ -1180,6 +1184,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		err = 0;
 		ap->folios[ap->num_folios] = folio;
+		ap->descs[ap->num_folios].offset = folio_offset;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
 
@@ -1187,11 +1192,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		pos += tmp;
 		num -= tmp;
 		offset += tmp;
-		if (offset == PAGE_SIZE)
+		if (offset == folio_size(folio))
 			offset = 0;
 
-		/* If we copied full page, mark it uptodate */
-		if (tmp == PAGE_SIZE)
+		/* If we copied full folio, mark it uptodate */
+		if (tmp == folio_size(folio))
 			folio_mark_uptodate(folio);
 
 		if (folio_test_uptodate(folio)) {
-- 
2.43.5


