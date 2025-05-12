Return-Path: <linux-fsdevel+bounces-48784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A1AB47BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 01:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E2C19E124F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 23:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3229A9FA;
	Mon, 12 May 2025 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USjYnrTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6A29A324
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090782; cv=none; b=VoNne8IM3Gvk7mQYhgE+xNKRpmbJw79MVschfNuzJkbr1/SGqm7bPmdhIc4stp0s5msUgNdMdqzrxlehDLkYDJD+1HBEHEa1iJXMETRVLMd9QhhzS0BNbDeOSXPShuGAVUodlLwD8WIe+Xr0HK2z1IPsd2rBt71UcaKzMym7oks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090782; c=relaxed/simple;
	bh=zRHHIN3s1OCf8lNdtE4ADRcI0c44ZCiAPrOcaTDyefs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8k7cG/rCMe2IfiVpkHON+C0MYllK9famqMTETkE2KEBr3sAaACnSqN9dWO1+cwHwP3NgQPmKqo2PsZECnsTpJ8zkt5wOiapKTyYSRCNbl2dX6K4yzST8dlj95/qBNkK1ESjjW21FzFGwnlOAROX1hWL4rFWed3/ZmI6PmykCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USjYnrTc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30572effb26so4551340a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090780; x=1747695580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GGetw4j3pZnXWcykEyW1HrM7YVXSEsWLADx8b1eJp0=;
        b=USjYnrTckoxu6Q7QCmNhVnh+dwGQWIEcJ3MYFiocNED22dpCA7dcLLe52NrhrwdJcg
         y45sFLe5tQtmOqor4TdbW1W19WKguDTCCfmD2t7HSuUJfs0FRpRhThotxNnkgPub3+YT
         gg1yrmHuYnGUd/Pjy0SAv91hf4ztMzBIccqcWgrixEKYTu8bm1T/knYHDNlnfrEpMPAu
         qwktmTtdFvxntR/e9rZLFBvJ11DWXihLhJdsPtWrknZKfwbWssorI2V3Y8omD0UV8Fvj
         nJIpPkf4OcyVldtIjo5yZV4fJtNAH+dwZTPpCh1MLdOiDXRmhgIh5bmkym+w9rzTm8IR
         yWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090780; x=1747695580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GGetw4j3pZnXWcykEyW1HrM7YVXSEsWLADx8b1eJp0=;
        b=vYKFaxaaLHzSc9BJCs4rkCpFdCsV7C7tuyi1jmWrVwr+WhG0pPXvycPr1p8Od9xVXY
         hw3mEC8j9FpIFnDxkj3J4S1trks9dhRxOqi0Ftp6K6m67or+En/3sp6FZAQJzva8NWxU
         yRTsVhMBYmNvuQkDYTxmHodhj5nECdqML0RpSpWn/YoNytlsikJGk0jGVEX7nQ3ZUYQz
         OLcoiyQnilymIVYsStJ5Ifxevy73X59Yy0Xrltg08vTRwiEej1vD/HwoHKZiMY/gRPKn
         vJNj8YFnR/hzoXKLPRS567QgIcO1BFWKousWJKGkQg8YxgYYko4NXnymmffX5NIVbL5p
         TGqw==
X-Gm-Message-State: AOJu0YypuVax0XcgPS/DQdHFf2VVTtOumtUkqtLC9K0mRn5Xefs6yRwM
	iLdndiGVWZg1H0eeAxo9MZTQSDxpmlhApEtK3qs6uNme00IkA0YK
X-Gm-Gg: ASbGnctlz5aia8r3TuRl5zP3mOsraOGqFVSsJZW3j/DBcwHC8M7NK0nzddS4KBVMf3Y
	2ttB2WPz4xbhSKXSh6DaSV4qk4MHfZYhWK9LwCWCMO6N0mZwte4+zbb0JaRbHN+eYNYsi+zAIwe
	zpodjSoJ8vFgTYXKUYDX/5cQJEcsDUJRVXWacQX10JQqzRi0zzHzpz83cUnEKNP3DxU3jV0vTZz
	LuiXBhjQ0V/yjZThJ48AUKKIH7A/qRiJcQ6b70PBw1mKXKl0dAtO2JMemNV3RUHCHIRXQka5Yd1
	mDJzPh9L6woNINTwsqmRyXP1f/4JKwI51vNFHMu1EGRWcA==
X-Google-Smtp-Source: AGHT+IFULKODzjqgCevzng+ovNPug9sdTZOefdsEcHvLRagWQLDcQLa3e+B6UPr8pzVEc0yIqsdyeA==
X-Received: by 2002:a17:90b:3b4c:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-30c3d64f39emr18644692a91.34.1747090780221;
        Mon, 12 May 2025 15:59:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e61040sm7214250a91.31.2025.05.12.15.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:40 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v6 09/11] fuse: support large folios for readahead
Date: Mon, 12 May 2025 15:58:38 -0700
Message-ID: <20250512225840.826249-10-joannelkoong@gmail.com>
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

Add support for folios larger than one page size for readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f221a45b4bad..07ff81469a59 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -876,14 +876,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	fuse_io_free(ia);
 }
 
-static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
+static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
+				unsigned int count)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	struct fuse_args_pages *ap = &ia->ap;
 	loff_t pos = folio_pos(ap->folios[0]);
-	/* Currently, all folios in FUSE are one page */
-	size_t count = ap->num_folios << PAGE_SHIFT;
 	ssize_t res;
 	int err;
 
@@ -918,6 +917,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	unsigned int max_pages, nr_pages;
+	struct folio *folio = NULL;
 
 	if (fuse_is_bad(inode))
 		return;
@@ -939,8 +939,8 @@ static void fuse_readahead(struct readahead_control *rac)
 	while (nr_pages) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
-		struct folio *folio;
 		unsigned cur_pages = min(max_pages, nr_pages);
+		unsigned int pages = 0;
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -952,10 +952,12 @@ static void fuse_readahead(struct readahead_control *rac)
 
 		ia = fuse_io_alloc(NULL, cur_pages);
 		if (!ia)
-			return;
+			break;
 		ap = &ia->ap;
 
-		while (ap->num_folios < cur_pages) {
+		while (pages < cur_pages) {
+			unsigned int folio_pages;
+
 			/*
 			 * This returns a folio with a ref held on it.
 			 * The ref needs to be held until the request is
@@ -963,13 +965,31 @@ static void fuse_readahead(struct readahead_control *rac)
 			 * fuse_try_move_page()) drops the ref after it's
 			 * replaced in the page cache.
 			 */
-			folio = __readahead_folio(rac);
+			if (!folio)
+				folio =  __readahead_folio(rac);
+
+			folio_pages = folio_nr_pages(folio);
+			if (folio_pages > cur_pages - pages) {
+				/*
+				 * Large folios belonging to fuse will never
+				 * have more pages than max_pages.
+				 */
+				WARN_ON(!pages);
+				break;
+			}
+
 			ap->folios[ap->num_folios] = folio;
 			ap->descs[ap->num_folios].length = folio_size(folio);
 			ap->num_folios++;
+			pages += folio_pages;
+			folio = NULL;
 		}
-		fuse_send_readpages(ia, rac->file);
-		nr_pages -= cur_pages;
+		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
+		nr_pages -= pages;
+	}
+	if (folio) {
+		folio_end_read(folio, false);
+		folio_put(folio);
 	}
 }
 
-- 
2.47.1


