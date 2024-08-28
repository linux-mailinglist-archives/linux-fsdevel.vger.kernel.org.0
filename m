Return-Path: <linux-fsdevel+bounces-27654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D29633AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F91C2405D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FC1AD9C8;
	Wed, 28 Aug 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="hfczvDxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9341AD419
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879694; cv=none; b=oW08KR1iNbiXtKXJKnuF6TysKOaY6dKd91uDIz+M8x0nwc64zEIdfukP8+3gKyus4XzVzQjSj5JOVb/kRy++WJ7yTVZlc8CGa6NM2i57uiECDWnGeRVRL62hhVc4wVCbt9rI+p1S8iF9Z4e5zvENs5XESlAJzDc8PpahjY7D4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879694; c=relaxed/simple;
	bh=YYV29pYTxYgsBWsZzEyM4sTYsqOEA1TfbxKd63pMxnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghE75HxRHh8lHtW/oyLC0GNw1sez6UAWdKgLI2d8o66O2jV9/2qS69F7x7YiHQ8BO+6goqb2Vxe0NGh/Pgzxz7ASiBsOpLRc2OEQ1YkyVU5fVN3NDBmpsdXetytnTDytWylk2sz3tfBI82nrVQxkuauqdRq8MYKU7aNzCvRuYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=hfczvDxY; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27032e6dbf2so4560994fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879691; x=1725484491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOeMxAMMFxnDV6WSRHEEFaOXZzMwCrDnlmMbJf8550s=;
        b=hfczvDxYM7ZxXbVgmdBrDxl8P16sI9YRyS1Hbe/XcL1pJiNXXVqcgcMfQMQRIMVO4M
         zxQzpyerQbsLzNopJ3T+kIokuiYJzgWsxZHdgT4XlbJphG7lcqgTVFmtx7gkwsc9PB87
         G+q9T3PFr/BcbnHvp9IahB1W8m3Z5PYS+xJIjvUdsiEzvRfW3R2d5r5UZagbSFmSkX4O
         q06vlVPsiB9qpn5GRgogOO2WoQOwwsBwkqNYlv9ipMKWb5Ej4jbHGTJWeTH7fTrkSKs2
         AcFdvfwWfZD6RZJ3bQ3arbVB7AuZLk9/HqsB4dRyCyjVUvCu9X6zHpz7wHsQjElZPZg5
         uqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879691; x=1725484491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOeMxAMMFxnDV6WSRHEEFaOXZzMwCrDnlmMbJf8550s=;
        b=NOrBqRAh7NDOkZ2ZpjttCOHxCqcmpfM4EjYKiJnhf7OTc7sqlForYypR22LA6ySSCe
         BaWPPPZvpa1VQp0ITVYINkV6CDvL8Ud8XclTFITxbsh3ordPvKC8srOSyXVkS5B/rasN
         LqoDt8QkNd5PHlPKMZLB+ZptRfmo0TQlBpow6mzhGVzM7a1XXHbWmmO4Y0grJcbga1lo
         bdjUFAH55s5Xoe76I+VYTxzamTEdSkDVQ6kkZfACcOjA5hrFPDX9ePBcEWwA8ndM5qGI
         qMs2WT1ILQHJS1OZKa96XMxQeNvJ1zBzobx0tI82ich8LJUcSCEXwkd1RMd7McQr1tQX
         90Dw==
X-Gm-Message-State: AOJu0YyypNP0DkwH9nSGRFsqr/mQuy365N08+JhUYGhOyBnQ9nW+GIex
	ielO96Tq2KNvcfe5hJDq0kJUgJuSkV9nZlc2rrx4RbYHtsvcp4W7iDKH6TFtIBAPa8CKTF2Wk0D
	L
X-Google-Smtp-Source: AGHT+IGrs8pmhwfKz1j0KuxKzV5CcsRblneWVDYyTUFpBSY7Pb4LaK4/+opYZbwHHY82Wv61LijoZg==
X-Received: by 2002:a05:6871:729:b0:260:3ae9:c94 with SMTP id 586e51a60fabf-2779035f7a6mr863273fac.51.1724879691219;
        Wed, 28 Aug 2024 14:14:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fb45csm668997485a.114.2024.08.28.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 08/11] fuse: convert fuse_writepage_need_send to take a folio
Date: Wed, 28 Aug 2024 17:13:58 -0400
Message-ID: <84ea16d5fbdcdb0b0df1d6e0c764e479aaf3af25.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_writepage_need_send is called by fuse_writepages_fill() which
already has a folio.  Change fuse_writepage_need_send() to take a folio
instead, add a helper to check if the folio range is under writeback and
use this, as well as the appropriate folio helpers in the rest of the
function.  Update fuse_writepage_need_send() to pass in the folio
directly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7b44efbe9653..8cbfdf4ba136 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -484,14 +484,19 @@ static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
 	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
 }
 
+static inline bool fuse_folio_is_writeback(struct inode *inode,
+					   struct folio *folio)
+{
+	pgoff_t last = folio_next_index(folio) - 1;
+	return fuse_range_is_writeback(inode, folio_index(folio), last);
+}
+
 static void fuse_wait_on_folio_writeback(struct inode *inode,
 					 struct folio *folio)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	pgoff_t last = folio_next_index(folio) - 1;
 
-	wait_event(fi->page_waitq,
-		   !fuse_range_is_writeback(inode, folio_index(folio), last));
+	wait_event(fi->page_waitq, !fuse_folio_is_writeback(inode, folio));
 }
 
 /*
@@ -2320,7 +2325,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	return false;
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
+static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 				     struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
@@ -2332,7 +2337,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 	 * the pages are faulted with get_user_pages(), and then after the read
 	 * completed.
 	 */
-	if (fuse_page_is_writeback(data->inode, page->index))
+	if (fuse_folio_is_writeback(data->inode, folio))
 		return true;
 
 	/* Reached max pages */
@@ -2344,7 +2349,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_pages[ap->num_pages - 1]->index + 1 != page->index)
+	if (data->orig_pages[ap->num_pages - 1]->index + 1 != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2366,7 +2371,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct folio *tmp_folio;
 	int err;
 
-	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
+	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
 	}
-- 
2.43.0


