Return-Path: <linux-fsdevel+bounces-32606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CF9AB64E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B751C22C86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0D1CCB26;
	Tue, 22 Oct 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkp4T2jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FB1CCB58
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623297; cv=none; b=QZpvFajQtEVbirf5v29TylF7zYcIH7a56d6e1T2sBWjMYlAqNlfqsHwN2H1sbI2xjzA/uo90FMDTGn7q3FYe9Uhd+IpWrLjLOMfbuehdQOaSb7SGZ4DVDS7ErCpXR3lJ7RD+BhKJvnM91pAyOtYeSI8r/fh/0JqM44c2DtZzFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623297; c=relaxed/simple;
	bh=Husv96TOMO2qIvKRZvj2W7AV+kR/pj194D/faJu/Lkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvV/AmBVy/0HcVG8qcH0awS57mQThX3XP9o2WkK56a4R/gNmTO4ocHCtNaeTDR2K+MjxXtDS7PKuyDFWW/hZBjWk4eQoCEwsNYLSr4PBcHbtNXMc1+mumP2Fk2BZmHweYw4Xl7JuokmzM6VouXLny8GRbcTX0Opx1peA4qrPc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkp4T2jc; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so5822995276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623295; x=1730228095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmMFL8Z717LngE8XgMJcblRHxFbxLWA01uvsBYHeR/c=;
        b=nkp4T2jcaKwcK0C1cjHXW9I20O8pH8kCK2LEGU4PIxxfshwaS3XxK1ZIW4EHvr3ZnQ
         BrGhHabv1sC/ZakSXYx0YDUxr9x3m4D2tnggFhh4xdPe31J5ZROi1xxu8yUIPJU7b1Hz
         QnyY/l6PTz+RTglaQCdi+zoKxNi9RxXl6jALJqjs2tNMltNCtiCjpUgl/6ud1MRlc9Oo
         I9g7cjLmsvsqCFKCKnOW8gW6w242IbpTmJ26rxWJpa1pZd46URxWrUI5DjjMcbNYG2Qd
         AGaBg16u17wVOjTjyTmN8K7Z3uZtNUcMIlpcew6UAj5YukZRyCdBFCGcyplmSFuj+ddZ
         0GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623295; x=1730228095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmMFL8Z717LngE8XgMJcblRHxFbxLWA01uvsBYHeR/c=;
        b=Ug6oF0VKJGDGdf7xGAVZ9ahEMrH99BBDDddLzkl5wvEXORLYbjP/OaP091//oebSR8
         g3Q+K2b8otWa1MHCsMnO83EUunX+ANPXqXxhsLVlWe/MP+SINqYxNZFSKHjrhq4HAIwp
         C2GDU0PgL59Dzuv+0C7xdmmkoqn1ComWMwB61CNujdkwakjt9fPCs08Bv5fr5nJhYBWE
         /GeGmXtSWcy28P0LlTYwcBCnBh/xDJoP6nMwu1FBQM8IdjNufcu+N67Ck6rHNEjCx9b2
         53DMwM8niKm9yyqR2mNGLo298XaC4WIfiaI/IQbtLBLVsHvyYbge/kP8Y1+/nwnfh180
         ga4w==
X-Forwarded-Encrypted: i=1; AJvYcCURYDbqU6b6Qbw3BYiKdOlkBSxQIf7/evNjZ+sdL12BhpZy1wdqiKPdroX0fRowbkckvbkUfyjyf/IBEaaZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyNL2UDzE9JSJz2Yk+xDpjZ4laZl5oGvJlB03edkV4qk3ZKF3jp
	Dca7al3mAskqQic4plVbvdyprsBjn0M3+t8b2RzRCPka4/Pi7Eo6
X-Google-Smtp-Source: AGHT+IFIGcsiGd1/M1enXkV1i26m6ckvZGCknuhnPFPEjXYN70RwAHOM8Hp/wSuBMyB5fvdBihDLEg==
X-Received: by 2002:a05:690c:ecd:b0:6e5:e571:108b with SMTP id 00721157ae682-6e7f0db9871mr97467b3.8.1729623294717;
        Tue, 22 Oct 2024 11:54:54 -0700 (PDT)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a502d9sm11859597b3.47.2024.10.22.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:54 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 08/13] fuse: convert ioctls to use folios
Date: Tue, 22 Oct 2024 11:54:38 -0700
Message-ID: <20241022185443.1891563-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ioctl requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/fuse_i.h | 10 ++++++++++
 fs/fuse/ioctl.c  | 32 ++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 201b08562b6b..c1c7def8ee4b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1051,6 +1051,16 @@ static inline void fuse_page_descs_length_init(struct fuse_page_desc *descs,
 		descs[i].length = PAGE_SIZE - descs[i].offset;
 }
 
+static inline void fuse_folio_descs_length_init(struct fuse_folio_desc *descs,
+						unsigned int index,
+						unsigned int nr_folios)
+{
+	int i;
+
+	for (i = index; i < index + nr_folios; i++)
+		descs[i].length = PAGE_SIZE - descs[i].offset;
+}
+
 static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 {
 	/* Need RCU protection to prevent use after free after the decrement */
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index a6c8ee551635..1c77d8a27950 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -251,12 +251,12 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 	BUILD_BUG_ON(sizeof(struct fuse_ioctl_iovec) * FUSE_IOCTL_MAX_IOV > PAGE_SIZE);
 
 	err = -ENOMEM;
-	ap.pages = fuse_pages_alloc(fm->fc->max_pages, GFP_KERNEL, &ap.descs);
+	ap.folios = fuse_folios_alloc(fm->fc->max_pages, GFP_KERNEL, &ap.folio_descs);
 	iov_page = (struct iovec *) __get_free_page(GFP_KERNEL);
-	if (!ap.pages || !iov_page)
+	if (!ap.folios || !iov_page)
 		goto out;
 
-	fuse_page_descs_length_init(ap.descs, 0, fm->fc->max_pages);
+	fuse_folio_descs_length_init(ap.folio_descs, 0, fm->fc->max_pages);
 
 	/*
 	 * If restricted, initialize IO parameters as encoded in @cmd.
@@ -306,14 +306,14 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 	err = -ENOMEM;
 	if (max_pages > fm->fc->max_pages)
 		goto out;
-	while (ap.num_pages < max_pages) {
-		ap.pages[ap.num_pages] = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
-		if (!ap.pages[ap.num_pages])
+	ap.uses_folios = true;
+	while (ap.num_folios < max_pages) {
+		ap.folios[ap.num_folios] = folio_alloc(GFP_KERNEL | __GFP_HIGHMEM, 0);
+		if (!ap.folios[ap.num_folios])
 			goto out;
-		ap.num_pages++;
+		ap.num_folios++;
 	}
 
-
 	/* okay, let's send it to the client */
 	ap.args.opcode = FUSE_IOCTL;
 	ap.args.nodeid = ff->nodeid;
@@ -327,8 +327,8 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 
 		err = -EFAULT;
 		iov_iter_init(&ii, ITER_SOURCE, in_iov, in_iovs, in_size);
-		for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
-			c = copy_page_from_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
+		for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_folios); i++) {
+			c = copy_folio_from_iter(ap.folios[i], 0, PAGE_SIZE, &ii);
 			if (c != PAGE_SIZE && iov_iter_count(&ii))
 				goto out;
 		}
@@ -366,7 +366,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		    in_iovs + out_iovs > FUSE_IOCTL_MAX_IOV)
 			goto out;
 
-		vaddr = kmap_local_page(ap.pages[0]);
+		vaddr = kmap_local_folio(ap.folios[0], 0);
 		err = fuse_copy_ioctl_iovec(fm->fc, iov_page, vaddr,
 					    transferred, in_iovs + out_iovs,
 					    (flags & FUSE_IOCTL_COMPAT) != 0);
@@ -394,17 +394,17 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 
 	err = -EFAULT;
 	iov_iter_init(&ii, ITER_DEST, out_iov, out_iovs, transferred);
-	for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
-		c = copy_page_to_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
+	for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_folios); i++) {
+		c = copy_folio_to_iter(ap.folios[i], 0, PAGE_SIZE, &ii);
 		if (c != PAGE_SIZE && iov_iter_count(&ii))
 			goto out;
 	}
 	err = 0;
  out:
 	free_page((unsigned long) iov_page);
-	while (ap.num_pages)
-		__free_page(ap.pages[--ap.num_pages]);
-	kfree(ap.pages);
+	while (ap.num_folios)
+		folio_put(ap.folios[--ap.num_folios]);
+	kfree(ap.folios);
 
 	return err ? err : outarg.result;
 }
-- 
2.43.5


