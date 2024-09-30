Return-Path: <linux-fsdevel+bounces-30372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA998A5BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C8428422E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356F18F2CF;
	Mon, 30 Sep 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wgq9fZDW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E018DF9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703951; cv=none; b=SvSacknqkPxWIlIuNIU6+mjVjzSbLh0IhI9lfyc0XUhgSsxhaMyQsinMETgb0SDWKZ4q+RbwA6Hxpk283XpDYmMRPdVG/HrtQ7VT5M6Q+Upu+SNwSSj9KUEhzxmuJV9nUpFEbe92EnntRAheqL3GLiWCKZT1yk5JKt/q6eOIfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703951; c=relaxed/simple;
	bh=hxIdkYJbYaGmZD4/VZaVql3VRw40/UEU587zIk9dHqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKnW0U7FoSleufdlaVOY7P88AsgqW78Ve3y9AzYEp0VJxB5v159qo3gQCaxMicyNlqfiyp2tzUhXL6/EGT/b9VbozZt2Bz7QbFDeT+lEvIJRzDRkfFz7AZWADdc5gBPmcm7I11sQBghiOrOcFVpbeUGwdiKJ9TQaEKUuv1r4SkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wgq9fZDW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582f9abb43so32479621cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703948; x=1728308748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FacLCPRk8JOpjY0CME80CbB0FcXhlgP3XFZb3CcxNJ8=;
        b=wgq9fZDWjd81JHXWt0Snf//QbU9To8gOGqmvOMCds2kL6g3boghyDIAlXnTK02gMh/
         iH/lLChLpmiOR3+S+v/fFSDMSb+fJlG1FdR2UQY23zYms3CCFCbKyyYJuv2MewRFzcGx
         FLrWHSv7PrG0ctUQzOS4GT6gMAuEJX1wRcGMQUMhHyhiOvOhCGHPmZvNbMc/RuJjuD5X
         Rh9E8K2w8Qaw2f2j7Eiyw6mywhEF5lnPqU5sdpjBOgZ3Su09tnwY07svxRC2wHJSXLqa
         0k1MJgfNOAUnPWU8g0IduXKyLa/Q14i60zWjkzADeqGSCTf7+9u01MfifCxDHK0O5Viu
         ClGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703948; x=1728308748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FacLCPRk8JOpjY0CME80CbB0FcXhlgP3XFZb3CcxNJ8=;
        b=i1ft0DvN5bFrRibRL+dFDJWBrbeZZWkEqg5iJOCMI8bnvqpsoSoUKC2JewoSlfqql4
         UEzAKUdvvNv/IMm7yZwHQ/0/TjGUzMT1YYaHkDstId6Wz/ZoX4wMPk2rZ2CmjtGH9lYO
         lUNxvd/PIpWwIRCgVQxbKY5NJo5bYrrCqwwBGafmODhNPpDSTQiAaIaFPOSG708tnCzs
         2fmbUGUF4j8QwUUJEnnz9pRXJrpK0QTcgEYKuiU2j6giVxL+0HTTlRX1GyOstUy93KIs
         vyL8iBRf6MxJyWRxHe4VTzamQckNNlU1b3oauAWXbS99RLVHuIuoJUORCwDfGhGAWVxc
         bKgA==
X-Gm-Message-State: AOJu0YyP0pZiu7tFRRcHiFqcqI1GsxYoDwmQBHBrj5At4Kv68nl7tqYk
	ucu12F7HzYycu2yDk15ab0U4NYx270XQpmW8yIiLR48mNbjZ3XggrTbptFn4af1BRBdQR6pOzO6
	y
X-Google-Smtp-Source: AGHT+IEQqcKSCNXyO83RFf8J1ELIDGRzWPVRT8FRWQ0V6r0J1toz4rCbZUrcq10LxonFj8nuIoA95w==
X-Received: by 2002:a05:622a:11c5:b0:457:f8b1:a042 with SMTP id d75a77b69052e-45c9f2258e1mr208962061cf.33.1727703948152;
        Mon, 30 Sep 2024 06:45:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2f2264sm36508941cf.56.2024.09.30.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v4 07/10] fuse: convert fuse_writepage_need_send to take a folio
Date: Mon, 30 Sep 2024 09:45:15 -0400
Message-ID: <b3eaad825fe0591ecb5eb6b5cf976e44b0bc7e7e.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
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

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 45667c40de7a..33f98cd27e09 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -483,14 +483,19 @@ static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
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
@@ -2263,7 +2268,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	return false;
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
+static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 				     struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
@@ -2275,7 +2280,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 	 * the pages are faulted with get_user_pages(), and then after the read
 	 * completed.
 	 */
-	if (fuse_page_is_writeback(data->inode, page->index))
+	if (fuse_folio_is_writeback(data->inode, folio))
 		return true;
 
 	/* Reached max pages */
@@ -2287,7 +2292,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_pages[ap->num_pages - 1]->index + 1 != page->index)
+	if (data->orig_pages[ap->num_pages - 1]->index + 1 != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2309,7 +2314,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct folio *tmp_folio;
 	int err;
 
-	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
+	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
 	}
-- 
2.43.0


