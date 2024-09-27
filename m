Return-Path: <linux-fsdevel+bounces-30280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F6988B72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A0B24160
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BB51C3313;
	Fri, 27 Sep 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DIDs83bF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8721C32FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469955; cv=none; b=AP7/oT1nFnpo4H1GAhJYbPw44AvHtWB2XNjtjj0RFmn8rzXkMthMxKIcllE4lKFP68tScWCTkX7MKEjnMNGQsLBoIQxwziBvBKNUr/NEXHucPsgWxe4mzr0jtz4SX9UMTCIy7GkDvyzWfgZX6fH1L2LMd4nynWxdLarWz3DVa/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469955; c=relaxed/simple;
	bh=qZnO/PT8Q3/BcHk3WdnUxOqowQGtif/DYfT/Q+jpt/E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOjNEZcDG4OPLWdoIQqeWK/62GTIgcySmGn860DmHP6MrT4PJauV542M675sbIjL3SInmPa7eq8YzZFR80vgcxyzV0jFe0uX21MdREhzBnpGqh69f4Phcm4NbOHsDficVQJMHrW2rYSMKrZhH0/nJ886qFZ8nKReWg4jaEovENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DIDs83bF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2598a0070so1977657b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469952; x=1728074752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UU5U/n5wGWeVhusJQimOUqE0sIjlM9T2CX5s7HYhGfs=;
        b=DIDs83bFdarACZVKbEsAKaQfEOd645HD+rUDFlg5Wmc0iiWPcbm8jjx2WMn1FvD7s6
         5Y7SYtO4m7l3+TmHHWHncZSdLl6eBAhN58KXXsh2AUTrMeTZ2KyRdiyngsfBSmYHxP2l
         fFw4DIjIzQP+Y8oTgsCEYtzWXvcVwTkq7It7T8jgUOi6Cx+nu1mNWj2Odxol4eemQ/hN
         pGRfenTG0sDsyEH5DEmThpyYiXUQ4WbqS6eLl+8fjHG2yzNzLv031X2b5cO9GFFOdBEJ
         b4hy2iBV57iyE+WTrB5Z0cZOsKqyeMhXW43vjc7sxgJGFsyfwTxi+QLfJkLCNR9/kmCM
         yXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469952; x=1728074752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU5U/n5wGWeVhusJQimOUqE0sIjlM9T2CX5s7HYhGfs=;
        b=I3s+fsOu0yqU3rcVpCkfPD3YCIjD2HAS1MGXJUKQFA5yQxXdK0VO0NvsXzZklxyXdJ
         0MeEunggICexX7p16G5fM7lYkB3PCVH242EXz5wJ4WFNVzL9UDf6weLyXhsgaZF1ECXZ
         m0W1qB6/Hp89iljNAj8CQm2G6en6E8mzIiwgbiaHUEml1xXZXDHI16my0iAbM9lKyAys
         bWOpKlRKqITe+UFnatNXfEiMCLTnFrJMTZ5oSa9opwdVKp/QEqNPlFnnjCZqZfY/f0Rw
         zswD69xl1LPfe3iexeICrVB/cErRiBsITs3Vqg45sKTDWlEXqmWSZkedB1Wk4lV5eplA
         Q/qw==
X-Gm-Message-State: AOJu0YyjH+KnS+qu7xUYAGIiGL1p4Ty6tQgxbDcXVrmEjcP+XX8eZbb+
	TaX4UNHWApHTlkXSwUteDeqFzyU3W+aOM7HByvqzYsyejV8s+DB38xck6EQC2AqlZ0LmLomB32r
	d
X-Google-Smtp-Source: AGHT+IHfGhx8yDOqADuy3iLsDuBF7MGqByzBQBfJfR5Co8ZoXIPAAC5zs+mz9lS8iJckEoJzT++DFg==
X-Received: by 2002:a05:690c:4b0b:b0:6dd:bba1:b86d with SMTP id 00721157ae682-6e247534134mr44683977b3.10.1727469952174;
        Fri, 27 Sep 2024 13:45:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24549d150sm4095087b3.134.2024.09.27.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 07/10] fuse: convert fuse_writepage_need_send to take a folio
Date: Fri, 27 Sep 2024 16:44:58 -0400
Message-ID: <622c8c01307fdaa9e9da254b5695eb082261b4a3.1727469663.git.josef@toxicpanda.com>
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
index 8a4621939d3b..e02093fe539a 100644
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
@@ -2262,7 +2267,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	return false;
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
+static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 				     struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
@@ -2274,7 +2279,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 	 * the pages are faulted with get_user_pages(), and then after the read
 	 * completed.
 	 */
-	if (fuse_page_is_writeback(data->inode, page->index))
+	if (fuse_folio_is_writeback(data->inode, folio))
 		return true;
 
 	/* Reached max pages */
@@ -2286,7 +2291,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_pages[ap->num_pages - 1]->index + 1 != page->index)
+	if (data->orig_pages[ap->num_pages - 1]->index + 1 != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2308,7 +2313,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct folio *tmp_folio;
 	int err;
 
-	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
+	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
 	}
-- 
2.43.0


