Return-Path: <linux-fsdevel+bounces-30276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D9988B6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D5F1C215A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8041C2DD8;
	Fri, 27 Sep 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="B4C4L3Hq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4E1C2DC6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469947; cv=none; b=XT+0ly9NJ4N5lvk03T85M4/TkdfMjl4rdz/T+Li/5zPDh2NEO+ekxIkyqrnuZofM+lqZreSNwmlJTgn0TEBU3a8np3pKpv79UAJRwcsX+SZdCBLPe/hVuf46brKd4Xm56j5SsgvYm82I/JP/CIfsIUJWXgaMF26w232Vv3YFCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469947; c=relaxed/simple;
	bh=fCTtLuyztHiM+saS9tz62DKRqjSI4mxVPQlXBaJEPL0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYKnECnTOTQLa7vxjh9/IjIhqcBzv5726z9JH9Tbo2bm0jpcDL304znlBKluhzTvY6UKZkCXf+o0iLkQ0L0j/go1hGupyUbc8hqJ/BDtqSBZmm6RrQpn8Ap0ZsXWAYcNsvQ4Zr1lv2JYAgcRE0cewuZvIwlkiAr0OWXJFo+vlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=B4C4L3Hq; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6dde476d3dfso21788897b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469945; x=1728074745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLXFw7FC7c0Zmld/zatVwu9aDMDaZMhEoSDldVy+/SQ=;
        b=B4C4L3HqwurK7TtWJ08gkZkcZC6RCu3mdxakiClyAJGQqZs6GHXpfnIoDzcakHpyfl
         s/OTI26C58l0P0z6zIqXrcxL6NFOb72x2hOIYB4a8dhVGI/8uG0rHm9YOjJTJW/ehsYI
         11PSjgjLWD0zU6+Ag4MLInLSckeno4ULjObhQaAUWxz0K+BF6+wYFTPkLXkuM7q2ARN6
         seWRCHGLAzE6Bbig3Epas+3V41/j0VjgpsxBi2b10fnhTz1ovUX7nnuXb/i9W+2/v6Nw
         jQqZ7s3zmXLo+4PHaFyiheNlVJ+gsA4C4uw/QvcSpQhaxvGUKfT4656+YZzn0F0/yCXI
         +Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469945; x=1728074745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLXFw7FC7c0Zmld/zatVwu9aDMDaZMhEoSDldVy+/SQ=;
        b=Gy350P9oJTfrFHwUITGoxcXa5wp/HvzD8N4jOWe73Q/2hpBoHmTqsvMvMask0asyzs
         YzI5n2ZMhluiZvHSjMEF4OPvsaBp0NQruJm0JKxqnk20W6MIC1u/FAmxeqUbXoFF3Nnj
         pgw+PQBZouf2tp9JS0/ujvtvxVchLJkkZo2XSlN7pK0WUeugy33Roq9dxD1H1vDTbHo+
         HjiIQXtrFKG0jvoJWnYnQWI/h7pD3i1EFqFr9avOn9NzAbi2lrDo/cf4Dmr7nuzM55zs
         d+WPHVQUqJnvANYoYS5fb1qRDrCYRQ9RMGNR8xatn/MdTIeN4Qerl/dKACy6lGAQMhgd
         StyA==
X-Gm-Message-State: AOJu0Yz4+VMNF5ByC06rslqAyDR7oc+Dllaf8pen8ftH2hFtv2AFe/Eq
	KOoi/HX7QmYQOApOrl/MpVsHUfXaSb1MxxadWRi7eVcvpMlDxAeuj2zIuT4T1RXggmTZ/atD6ZN
	l
X-Google-Smtp-Source: AGHT+IHhqiUStJz9R6UM0shmU5Pm/MasV9ar6Og1TVhZi/OZw9INuJtI7t1HIh0bi62klt6t1WmMew==
X-Received: by 2002:a05:690c:6f91:b0:64b:5cc7:bcbc with SMTP id 00721157ae682-6e2475d12bbmr47407847b3.32.1727469945017;
        Fri, 27 Sep 2024 13:45:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24538b5aesm4096667b3.127.2024.09.27.13.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 03/10] fuse: convert fuse_fill_write_pages to use folios
Date: Fri, 27 Sep 2024 16:44:54 -0400
Message-ID: <00a02299e944530c1be03d2d31b45614bedbc758.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727469663.git.josef@toxicpanda.com>
References: <cover.1727469663.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert this to grab the folio directly, and update all the helpers to
use the folio related functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 17ac2de61cdb..1f7fe5416139 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1206,7 +1206,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 	do {
 		size_t tmp;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
 		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
 				     iov_iter_count(ii));
@@ -1218,25 +1218,27 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (fault_in_iov_iter_readable(ii, bytes))
 			break;
 
-		err = -ENOMEM;
-		page = grab_cache_page_write_begin(mapping, index);
-		if (!page)
+		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+					    mapping_gfp_mask(mapping));
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			break;
+		}
 
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		tmp = copy_page_from_iter_atomic(page, offset, bytes, ii);
-		flush_dcache_page(page);
+		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		flush_dcache_folio(folio);
 
 		if (!tmp) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			goto again;
 		}
 
 		err = 0;
-		ap->pages[ap->num_pages] = page;
+		ap->pages[ap->num_pages] = &folio->page;
 		ap->descs[ap->num_pages].length = tmp;
 		ap->num_pages++;
 
@@ -1248,10 +1250,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		/* If we copied full page, mark it uptodate */
 		if (tmp == PAGE_SIZE)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 
-		if (PageUptodate(page)) {
-			unlock_page(page);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
 		} else {
 			ia->write.page_locked = true;
 			break;
-- 
2.43.0


