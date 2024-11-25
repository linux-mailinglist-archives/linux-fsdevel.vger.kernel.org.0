Return-Path: <linux-fsdevel+bounces-35850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A519D8E44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8732B28A0A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCC1CD1E0;
	Mon, 25 Nov 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laQ/n9tq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443D1CBE8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572362; cv=none; b=GxQTH1Mlv8dXE04++M3pO+faJKt9cQUUuQ3UQE6O5HmjSwjABsugotbtHy8TRoI/ZtBWrW16T6RRBFRDzD+y2FV3cr3rDctjdFxNklo+xNdWQcleU67g4AzNMd9Jnw8EPb0sUFqEGys3wQ+5d+jQXTY6jQNy8SYpnkR0lo6jMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572362; c=relaxed/simple;
	bh=GdAn7v7Hx5GXrwmyld6KDS/W0WHxQ6/VXwwmv8Ab4+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqyYjg16HKjldvACCm+JExF1Y/v+9JXlK0I3ynRYgybZySkEXAZewhK+60LhwGZdOYst8YzLdcWguBiGK7GUZUCKkgDb0JrhJ+eIBH+MJXfsutVEXsO6L7HCUhg6LhdCieUo0z3/IrCcrHzPm1v8QhHr2DIMsjCUL6VB8LlDAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laQ/n9tq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eeafd42dd8so51759237b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572359; x=1733177159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JlHLhlBCg7PkXL6On8ehHEY3Iplfl2NNRUfXG6PYTo=;
        b=laQ/n9tqUPesQ9sJv7e1m5I9FKdIh+EO/ZiPsKcttvAwSNATyvTb48hvv2yinnBLyY
         cIM3tfv43AHmVRaL29+nWNmMgGvrdmt506xgJn9WcnjR9/UILIWcHn+OlHM0DHm+EgUi
         NmQEwkDwE0dhElSnKu3oCpI4JhEP+2rODacb4J47onYkUk5/OdBqPzWyP4aLjkms+cCA
         h0zW7P2kcdY68CK5lZGv3iTXuLuKa33gp+9n4/D2JqGgb4WJWsrtEc7yDGZimjbS5w/K
         l8oXADRzTD5A1tKK878UXorxPoPp4FdMaWjSUkckTjVV69d+AXB0J7vGXGZeSO992ztC
         2+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572359; x=1733177159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JlHLhlBCg7PkXL6On8ehHEY3Iplfl2NNRUfXG6PYTo=;
        b=O8vgO4dQcAf1/CxbhXi5fmNP2JP2C4YeDGL4HX2vOUqRpHtdRXqdc6gaewAhKYQwrR
         ZwFhGd9lU83eIr4G4Y4EbJEdGpNDQdPpGvobzVL19Yt3MDb9IGIpS70X6tutau/hXCUc
         ZuO+ygpTwqPNe44De2w7aCz8GjQWi6OFhWb7Dui+2NVdPqaACYFRDKu8k8P2mTIHUeXL
         EewneIydp3EBa2AaKmQmRI4WyrTc9RzAT7iZ8QdYa5h7zal65Q09FGYyBqZUMlNA+0jB
         z5ulo8bGffLlSh7tUs6/GZqcGh5ytpio3yOdBCRgW7UyXkjIMS901L8SNYk9sOWUK5y1
         GrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTw2M/MbqhjzWgRUeM38dSCmFMIqxky9ckegAEY5SGTI1sVSysS/jzGwhiwNXVBzq2/xIAPvqAy7z9Lr4T@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNrCztfPpThFKGi0PGzuxlUNZ2n6AModaehJqrju90GuFAOjO
	6Di72hPjysI8A4klvPTWzggXW8ZDVhHNRBdKZhdxOqW4+BYpbH7m
X-Gm-Gg: ASbGncvTO394l0S9B/rPHG3AsKqvzDfqeY3sTywwYi/oRK73VVmldGZw02YvYj/+ztf
	SVD4x8DSP/tEVy8hRn6r7MHhurzTgEOFUR94pujh+6bZKSyKIPhhZbtZCRrP4raCkgC0Hh36QNL
	Wonoa1K9Z1/Vsnwg5CqTSqSieYz11SF532QhghXosWMjgiMKoPufTCKlbS+6VlWJuNfBXf7ms4x
	Y5OMVSinOOKEnLs6cWwGVwMwQmN0rr0VxGyMIWRDktwD0wz03GoxhXszvyqqhRWRYmj8Dg4QLXi
	3/UUVlMF
X-Google-Smtp-Source: AGHT+IEKDVuGUGYiAVPP+n7Sl39AeW/UuPhZawAUzY4HgAIyS0DUcsOBeaTIssdYoxb4bV2dZ9+EOw==
X-Received: by 2002:a05:690c:4b09:b0:6e3:2e50:8c0c with SMTP id 00721157ae682-6eee0a6fe4bmr162261607b3.41.1732572359209;
        Mon, 25 Nov 2024 14:05:59 -0800 (PST)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00afb94sm19489707b3.130.2024.11.25.14.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:05:59 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 02/12] fuse: support large folios for retrieves
Date: Mon, 25 Nov 2024 14:05:27 -0800
Message-ID: <20241125220537.3663725-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for retrieves.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4a09c41910d7..8d6418972fe5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1716,7 +1716,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages, cur_pages = 0;
+	unsigned int num_pages;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1734,6 +1734,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
+	num = min(num, num_pages << PAGE_SHIFT);
 
 	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
 
@@ -1754,25 +1755,29 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num && cur_pages < num_pages) {
+	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_get_folio(mapping, index);
 		if (IS_ERR(folio))
 			break;
 
-		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min(folio_size(folio) - folio_offset, num);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
 		ap->folios[ap->num_folios] = folio;
-		ap->descs[ap->num_folios].offset = offset;
-		ap->descs[ap->num_folios].length = this_num;
+		ap->descs[ap->num_folios].offset = folio_offset;
+		ap->descs[ap->num_folios].length = nr_bytes;
 		ap->num_folios++;
-		cur_pages++;
 
 		offset = 0;
-		num -= this_num;
-		total_len += this_num;
-		index++;
+		num -= nr_bytes;
+		total_len += nr_bytes;
+		index += nr_pages;
 	}
 	ra->inarg.offset = outarg->offset;
 	ra->inarg.size = total_len;
-- 
2.43.5


