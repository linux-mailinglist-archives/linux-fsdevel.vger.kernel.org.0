Return-Path: <linux-fsdevel+bounces-48778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD4AB47BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5753AD85B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A129A9D4;
	Mon, 12 May 2025 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7ix+wqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676829992B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090773; cv=none; b=SmBOSpKsLIo5GlecqTMvlAIIdKR/MsKlf6mH4DVmENarXDaNlfZrf+n9VSWL+tEshkcsY8hf6Et7a0LTgBRs0p1nMDv+kDNmEGxVJOm8x/ynxptOJ/0S1CYpCoj4M1Rv7McDhSyTGh9oBhys6830BRHLUIwb9ewuUVfiC0hgG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090773; c=relaxed/simple;
	bh=ik3s3UxR2WAyoxJ/fKJrClekI/E3X7UwO8WwxvMvs2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsYqnGzURL/OtqHJG+wrWfMNZobJEBXc5Yf0JL7CgNoKLrP5mSVeRpOIGNMQPU/nYjFOWo/MYbW/UwceCVUxlmDkLTmFIP6fQEk53nKSEszwU7FWZqFviAPUhG0YY+w8U3zkJap0reK3+TH/gZT5kPzG+k1B/oJCkWtg6UJ95gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7ix+wqP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so4462660a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090771; x=1747695571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ0b+zd1UaQtNQVxpwN4ZyEjHwKRb44wNnjO5WdiROQ=;
        b=U7ix+wqPCPuijTjG4ZhgaxV/NcD74FfdgqgySUxN6Dg/eduKyBp3dKXg6JngbabKRe
         zwz2R1/Qvz09PTKPIMoufq2L8o0ZhQJvRBRZwfMcQ0eINvAZN1FLQ0jF7GAdqSHB9u6F
         VwoeVctoWla8z5iV/TMlAjWNBt+dhHQdizcAGUWqE8h7QuoGafRDbc+BGcPUjxrJ0Nex
         9xGu7LnfWU4OjuycuGNHZB6E7uvUhd0505kPTtZZJ5VmSWbyGhi5tQkXvVSoyKk/sR4v
         IhqKLRESzGKZGmQfDJdgvTzVKJjNSxZPjdgS3KsNIDJ4KFShJijMOpDX7eIvnHJIdPft
         yLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090771; x=1747695571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ0b+zd1UaQtNQVxpwN4ZyEjHwKRb44wNnjO5WdiROQ=;
        b=wW4qQqM9ulqw5GzEx87pdpBZUq6QFi4w1eUK1eEhLhZMhTIh6eRe06NxyPA+gZtz8+
         2nuYcSqXDPr3BUTjGF5NBJLz0EQv4C+vZ1HCfonp7Liz4ZQuYLqeYcoyN7GYdu5G9nkY
         3MgxQZME13cuxr6PTJjpL+vUU4FVVJJp3m2i8gqNueC8PFzPuaGGC9srERqNTL/1ksWm
         f4hlCoUKC4fXFIVbFhBo9gaQh104V87tqDcAaxeZoqif3uUDSpBGP42eG3znUbs02zLG
         ilJ0UKj9UxfHdeOj+ASbNxtQX91sq85IW09A9oFfUOPl0XT1m6Sne60th+7DsJYPYdzd
         qdyQ==
X-Gm-Message-State: AOJu0YzgF236xHOoVPy1HnuCf8gt33+XHwUXXyGvoFm7YgfClXp+1vI4
	C/KF0RPhE9/ZQpaiv2xn1lqSS4c89qRebQKDMIEFL0hMQS5mNeHf
X-Gm-Gg: ASbGncs/ivaCrhZZxx027Q6HMQO97WBDX1INkZCcEYRIupFKlhJCZsoPDxy+vq3N89C
	H1ms/8ngkhRdIQ8aiOagk2tluN/B1bZBaWZ4Qbuuc9v4Bdvy/upLZplvRJMCXLmJKDeVHaXWVKB
	cdfkrBenUW5wIgMiPpCjSih8UDEZBu/ZFHhftISAiZTRBNMkRV6WvhMA4Kxa5O+nsPSzHZfR12b
	h4tt2DST8wCXR0FY/lcZNSCNsTbzzSHrEXj0Xbinc1F7hjcYVIpUVGhZum0jkMTtheW+NdKCYIh
	Uw7M7maOAPGGIvcVCRRRzKLZ/T0nyeQAgxBcUe5XwaDcNYo6TumAnZygTg==
X-Google-Smtp-Source: AGHT+IGjuH2fWGKsvMc0tPn7QTXgMTyNjKSjnMfjmeKU9YiDyufV/Xy8Kw/AHFOZX/VM5OuYY4GgMg==
X-Received: by 2002:a17:903:41c1:b0:22e:62c3:6990 with SMTP id d9443c01a7336-22fc8b33517mr188389455ad.16.1747090771189;
        Mon, 12 May 2025 15:59:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271aacsm67665635ad.152.2025.05.12.15.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:30 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 03/11] fuse: refactor fuse_fill_write_pages()
Date: Mon, 12 May 2025 15:58:32 -0700
Message-ID: <20250512225840.826249-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the logic in fuse_fill_write_pages() for copying out write
data. This will make the future change for supporting large folios for
writes easier. No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e203dd4fcc0f..6b77daa2fbce 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1132,21 +1132,21 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
-	unsigned int nr_pages = 0;
 	size_t count = 0;
-	int err;
+	unsigned int num;
+	int err = 0;
+
+	num = min(iov_iter_count(ii), fc->max_write);
+	num = min(num, max_pages << PAGE_SHIFT);
 
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
 
-	do {
+	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
-				     iov_iter_count(ii));
-
-		bytes = min_t(size_t, bytes, fc->max_write - count);
+		unsigned bytes = min(PAGE_SIZE - offset, num);
 
  again:
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
@@ -1178,14 +1178,13 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			goto again;
 		}
 
-		err = 0;
 		ap->folios[ap->num_folios] = folio;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
-		nr_pages++;
 
 		count += tmp;
 		pos += tmp;
+		num -= tmp;
 		offset += tmp;
 		if (offset == PAGE_SIZE)
 			offset = 0;
@@ -1200,10 +1199,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			ia->write.folio_locked = true;
 			break;
 		}
-		if (!fc->big_writes)
+		if (!fc->big_writes || offset != 0)
 			break;
-	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 nr_pages < max_pages && offset == 0);
+	}
 
 	return count > 0 ? count : err;
 }
-- 
2.47.1


