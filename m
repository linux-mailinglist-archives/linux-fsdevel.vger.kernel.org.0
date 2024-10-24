Return-Path: <linux-fsdevel+bounces-32804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460999AEDCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EA61C23596
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA501FC7D6;
	Thu, 24 Oct 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me+v/1lM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCC1FAF1E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790496; cv=none; b=qdnkEVm3lpA7MjxGowg4agF3ljbJq3UJv//7ed4ZxhvQ6V5mjEF+nNmfFAajIo0eCwBUBvlyXIP908fnbZDAHFjQtNKHo8tmhc6lDKTlbWB2E8uJxbnerJJLBpFKyfLrOlwTeiJWpjTElSF5rgjLpTkjdA2GetMC5G3GsqVoGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790496; c=relaxed/simple;
	bh=Husv96TOMO2qIvKRZvj2W7AV+kR/pj194D/faJu/Lkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0wUQMD5VTHW0MsBT01Zq3/17T06+7i6iur3RX99Zgodcyz57wYD0uH6mBoyG+bfbKgzlRXFMJxwtsl5ydge3xw2mHUOCf5rw4F5fsFJ/mft/Pienj5Ksiwb3csNymr3zeoFquRR7G0iu0wvyb+tSzXKB3+pVGIPJ0dLOfS2MRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me+v/1lM; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5a5a59094so10932217b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790493; x=1730395293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmMFL8Z717LngE8XgMJcblRHxFbxLWA01uvsBYHeR/c=;
        b=me+v/1lMcj/VOqd+mudXo9ccpCKAasoZAt/FNVbP5b0lhvzPKbUhE1CYduJryWU+ho
         3y0yeKpHilV4y5SuUWHtkGt0vxtrmXaen8G6ti7//A+3OT1wK/kJXAFj2R1eoM/pleym
         gXj7+EWuGqxNONuYolbDQlB6wUeA7owA04b+k9RERFa0zfJELCmOpW3+RFPeHDEebx9t
         7Pb43r0X9TLkCpTmbendidqxTusIk+6bFCmXKgwIDK4CJq2i/jZAVSyYDEWIYJfchyTV
         pYJ4cjWxS/P06FwhNfqwXROBGXXMbqKNU/nj6gMNdl5UioUb0FrDpTn+1iCcibTOvqYP
         B5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790493; x=1730395293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmMFL8Z717LngE8XgMJcblRHxFbxLWA01uvsBYHeR/c=;
        b=UypbY+STUSQrw9bk94f/CrFNlvSguqGRB3wrcxNk9SmwheQt5lOU/5U9tq5Lo8cuk6
         x6Tz8c/8vpRkj937eL55hJ+IILoXT1sZwX9iSfygBRsOmkSfnNAT3z6umanrsJmEV8MX
         NaeR6ly7VcCTdOyimgThHdPVBQPI/pgkFTTl6ytHEnavENdbz4iN8s2Su1YTAzKqDNtF
         /88VVNQ5Hs6AzBbK67o7UtwRkOT76UTBSPUZHgD9bZTmH63mif6Uj6zF2h8n50aMUvXT
         470ks0eaYgvccDiu3Q5bj4IYh+CdXpDRe975cucCmM2WrdNBtasCXoKBYDTvjFBdn1tU
         oXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqdqDZ4fmqzRnJ/izHlnsjc5q+SPSjx1enB921fhD/oXUXkxTtdG6cYlgT2Ghytf4k1tRmTOI2h9nAFQC7@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDa+vSAyjv6qrwShxyFyb6bKE9dObZ9NYNe7pov/a10LAJp81
	odUmHcfPmstDQ+sI1x5Xwzr2oFYvn09Nb1LQBKUd8e2FJ4uzLO+L
X-Google-Smtp-Source: AGHT+IGOLaJWd9wMI5C33pZctqcot6R56/oxOYrU4iLhRICRsvkRLtwjuL2nXuucCnoX5/MrLWIKzw==
X-Received: by 2002:a05:690c:67ca:b0:6e2:7dd:af61 with SMTP id 00721157ae682-6e7f0e04c70mr78960967b3.17.1729790492835;
        Thu, 24 Oct 2024 10:21:32 -0700 (PDT)
Received: from localhost (fwdproxy-nha-010.fbsv.net. [2a03:2880:25ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d142f4sm20721577b3.115.2024.10.24.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 08/13] fuse: convert ioctls to use folios
Date: Thu, 24 Oct 2024 10:18:04 -0700
Message-ID: <20241024171809.3142801-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
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


