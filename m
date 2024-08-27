Return-Path: <linux-fsdevel+bounces-27442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB59618B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6046B230A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6F1D3186;
	Tue, 27 Aug 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jQkIUcmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244521D362F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791582; cv=none; b=EU2l1Vl3u4VF4NmQNG5x4Yk0L3cdOMAeh3IwW2jc+GbesmyGGCtOfa9ooACzY2gau74xs0PqvXHIBvHXSOFtOwPjSeEYICirmJ6jZzHR6wc/tgCNuq/J3fGFan7sIJknZT2o3rtGTkw95LCGfwel77FOS431v56eRGl4qfZkMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791582; c=relaxed/simple;
	bh=h58GESlvRDXe3ek+F5uc9f9XUaRxzzp2bcTjgu2JQmg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhp9a3d+/RADV0k3Zd6ywrvfG2q2G4sKo8lTNse2CDAqDQqlzlV8k5FT8ulShei4vPKqDy2+MxGjE16zRD1b5ugxioX15/Mg1/MYjd87QM4CXxJ5oUO6IX57ha27mn/2mzC7F7QpXEJ+0UiX3Uew+efU9fsq4n06Stb8XuHXdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jQkIUcmF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c331543ef0so4567136d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791580; x=1725396380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7/dxM1vdkG7vAtlLLf0svhtr79HXDwZ7x9Bq9iwmHs=;
        b=jQkIUcmFRZLg8SfZaUtUETYkyv3dAEQXfSFyFsezCJYphlMkdv/3u0f97/HTB0r7hN
         SRUrtCL5wCk3l07qxo7GzQ3CBfa87nLEphYnrKjatpcbrwnoAfRfz3Me37fLFXTxefJS
         BADuU+9j/j+YihutTdD0LPRAhFANyaqAkmThQpfTKqoADFF5Bk7CMoZaoeQ5tK2dBfjz
         AnnDzfmtJrn+ZErUVpTuqlmRsTKLsDRUAhb3z4PPfKV7cs2pWBTYwNABDSpVfQCPobjD
         AYdkS4FrlJP2dAzxkprEr4sM5k90TknfU9m/7whKdfdWnY8wEe8KB1wX8wtYLIwOjwfg
         neUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791580; x=1725396380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7/dxM1vdkG7vAtlLLf0svhtr79HXDwZ7x9Bq9iwmHs=;
        b=YJb6fHj8uax2Sx5ZNk1dm2H37WaJpTMpxaZX4kglftABdJBAcv+sdzAVraH+b2qPGW
         t8QYdAsjyCrkw7CEzx0jEnHV4xRcqCeMOlMznh9h/SlgqB8tmRPAeIKvFbf2voXmtqNW
         Tjdz3hD+5RqPbyWAAHCTGmnQZKeYCHtRghJ4WHRlb7YhNc8QVYqJ1mWXczPgCjhQ2D3u
         MSwUahj/QRfnbjt5mECIrkw9TmpdW+cyEokdXPQ7N9xpsNp0NOU99Cidrq+VvlbsT6NZ
         hncCU9sCNbU/P6NSwydVs7cEMkwbCn14wSmz+wIicw0PxbdW6owdWs4tnzJQfjgbZMmH
         C2wQ==
X-Gm-Message-State: AOJu0Yznhbhs8NyW1a6IpsZCFMgRllKfWXYD0JZqyH2RPUSwM3UWoWyD
	UTk2y/rE9XvmGi7bzHvBnqgAYRVQi3dV96W5bEGJ5rDK37qzSnOQKaD+o7m8KpQ06MDokVaKHEM
	T
X-Google-Smtp-Source: AGHT+IE14pMb4e+Cu7xI7Vh5LxEeqffr1kHb/nkuJsWgLci2vq8HX9hDaAp4bTh8pSN19NR345KjEA==
X-Received: by 2002:a05:6214:2f90:b0:6b5:def0:b60 with SMTP id 6a1803df08f44-6c32b677f6amr47681866d6.4.1724791579661;
        Tue, 27 Aug 2024 13:46:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d216fasm59240236d6.22.2024.08.27.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 03/11] fuse: convert fuse_fill_write_pages to use folios
Date: Tue, 27 Aug 2024 16:45:16 -0400
Message-ID: <fb8b6509ff4f2f282048de6884f764f2eeefee12.1724791233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724791233.git.josef@toxicpanda.com>
References: <cover.1724791233.git.josef@toxicpanda.com>
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
index 3621dbc17167..8cd3911446b6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1215,7 +1215,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 	do {
 		size_t tmp;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
 		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
 				     iov_iter_count(ii));
@@ -1227,25 +1227,27 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (fault_in_iov_iter_readable(ii, bytes))
 			break;
 
-		err = -ENOMEM;
-		page = grab_cache_page_write_begin(mapping, index);
-		if (!page)
+		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+					    mapping_gfp_mask(mapping));
+		if (!IS_ERR(folio)) {
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
 
@@ -1257,10 +1259,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
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


