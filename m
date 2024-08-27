Return-Path: <linux-fsdevel+bounces-27447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE39618BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B048B1F25004
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9031D4144;
	Tue, 27 Aug 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cSOg8Mk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC91D3657
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791591; cv=none; b=kv0IKOnsPwTWtge+i+rjy4htEnXnvlXWqD/wQa+lJtOwthvNGOaYv4/FeAFhhJ8+sszfE7i78ZWa3RPCpgwQcHOJsr5vyM07goVYBVFBYnYpfbOHaIlEmyADkTaG6XnjnJX6GU5Wu2jfiGGFIcQBNaojjyOD6HhJju6kuBYXYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791591; c=relaxed/simple;
	bh=r63lu2F0dIUEB3OoPbVUZhaDSz+c7JGMDP+e6wv+x+E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQiFFC2TJPrHpFGlCXpH8fGCSWhKrmLqGg9/HN5V3saQZeQM6VGrggZZPb/R+tuyt85/cOsSKFteE4x+/VqQ3jgLouqCqo5oNGS1cWRWRUyz1MpR8YWUwaVowCCnQqHqaZl86MP4wdmpBuN497xgsPhc+aOwD1pgVK6EjfBKnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cSOg8Mk+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf9db9740aso26790866d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791588; x=1725396388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOF+ElhywBlYSZgj+ON3lSoaKQYrzzRHrogJZy0VJM0=;
        b=cSOg8Mk+23pG02U0M2m0/Dy6dh502sq5iZTOhDhi8z/Ojd52h1r1/NXDZpXXhj0YEF
         lAgnM+Vnv1eigDEROG/0FlIeCyZZbaIyb2CM9F9TCjnR4b3QXRMFDVpBPxrVpMpIsJDm
         C7zgi/1+Y6Qa7NbHQYT0xYzrm+NU9/ZH15eUzF7s14nptA+I/wEyGPa+joWPCs+ObfBE
         9S/9fPtfK65dZYxAO38m6tVKlIiRDUC2boxHK8DpnTtewxKW8HzwXBc3NdaBvMHYkRMR
         7g+gTQumRTy++O9dBR9b5CPd/OioEDigz8eVE98ddUN2MpUj/YNvKy0h2Xj/NxQjI7T6
         Z4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791588; x=1725396388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOF+ElhywBlYSZgj+ON3lSoaKQYrzzRHrogJZy0VJM0=;
        b=q5RrynCZrDEmE1oFsozzaulqQ5aDSAO9hNgqA6Zezl+31hvJklbU5RneDN66lUba1I
         OzBMf1KfYHQTFQbyufFpVaaxw2SPkqkXJ5HJxL5fvgEcO3yp0p5ooDskV8MxYw6XWu8t
         w7cx/Tn2LAMn2r1yU7lKyOnap5uPJZFciiTYw93rUv97WH+0Z1fbh45aBV5BG6Qb9Lsc
         xlpqlttRt3Ln+6NwTyPU1hkGordJtLXd6vp2SMfzbb29xzYh8FfNZJAm2N3a49p6QfJu
         jZtHIMD15IE6jQBsSekEmEWOkvilZmxBwx/0ejvTPJRNxwpGIG4EEau1G+bFYbe30/NT
         dwUg==
X-Gm-Message-State: AOJu0YwqEhf0s7Wu+2b0DtFMPaXQIW5jk/9iwPnIVLij/f1/jX93NKHk
	Pz5oma9KSQFbP80DmyUWLtiJrICVtkeW3IUfkUttBq/ivGvHtnvQQ/sU5ipZGIBPhYawCQYJ+QX
	x
X-Google-Smtp-Source: AGHT+IHBOmSF2R3pufMmsA1xwN0PnD/qR4ga56m0H0uNryTgBEYp+CHTWB781LQzQ2mgpjc1xqurCQ==
X-Received: by 2002:a05:6214:3bc6:b0:6bf:7ae2:3f13 with SMTP id 6a1803df08f44-6c32b695e8amr46578316d6.8.1724791588614;
        Tue, 27 Aug 2024 13:46:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1cb93sm59492686d6.6.2024.08.27.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 08/11] fuse: convert fuse_writepage_need_send to take a folio
Date: Tue, 27 Aug 2024 16:45:21 -0400
Message-ID: <cf3cdc8006e18f0fc56572d613c6e6dee42b4bb2.1724791233.git.josef@toxicpanda.com>
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

fuse_writepage_need_send is called by fuse_writepages_fill() which
already has a folio.  Change fuse_writepage_need_send() to take a folio
instead, add a helper to check if the folio range is under writeback and
use this, as well as the appropriate folio helpers in the rest of the
function.  Update fuse_writepage_need_send() to pass in the folio
directly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f06f0239427b..3ef6c2f58940 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -484,6 +484,13 @@ static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
 	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
 }
 
+static inline bool fuse_folio_is_writeback(struct inode *inode,
+					   struct folio *folio)
+{
+	return fuse_range_is_writeback(inode, folio_index(folio),
+				       folio_next_index(folio) - 1);
+}
+
 /*
  * Wait for page writeback in the range to be completed.  This will work for
  * folio_size() > PAGE_SIZE, even tho we don't currently allow that.
@@ -2319,7 +2326,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	return false;
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
+static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 				     struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
@@ -2331,7 +2338,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 	 * the pages are faulted with get_user_pages(), and then after the read
 	 * completed.
 	 */
-	if (fuse_page_is_writeback(data->inode, page->index))
+	if (fuse_folio_is_writeback(data->inode, folio))
 		return true;
 
 	/* Reached max pages */
@@ -2343,7 +2350,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_pages[ap->num_pages - 1]->index + 1 != page->index)
+	if (data->orig_pages[ap->num_pages - 1]->index + 1 != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2365,7 +2372,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct folio *tmp_folio;
 	int err;
 
-	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
+	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
 	}
-- 
2.43.0


