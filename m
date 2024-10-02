Return-Path: <linux-fsdevel+bounces-30746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF398E13D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7513A1F23782
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171B1D12EB;
	Wed,  2 Oct 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdpL4tgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221C1D14FC
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888126; cv=none; b=NbuHme5xURSBkyBctcNq8V6O13nijC/l3DLmfk+7D8eAxrXAXPOB4tRfrNR6J8tpMGxi9sv0oiUdm8rud4ofBWv40D92VWBn71+r4SQ81kITMM5Ly0SP0AtKRTFVwNX4lZM0bd6HdJp2stjJLr5F83pb2BTGaWWKigWfK45fKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888126; c=relaxed/simple;
	bh=VUALdsOChm/UH/6xww+Lg2kfoHu3w/qCV+qNhUKP7TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKYHf5iy19o4vw+ZQ84T1T3f0gskg560ALVv70HA4qoNg5Bv3EVBxKbP3dnblgdsB/RxOEznoj2/kFLrdNgvMjDBlZHyNbLgYrl0i0vUuskR40zbCji5EVDbNoqjT0CdOC+Hyt0yYtUu1ddnyAW3C9g85IYs4wd2+gs5O6IHSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdpL4tgQ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e214c3d045so178117b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888123; x=1728492923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cJzDyKn+uNfg5WYDJfs1LslS4wz8yVX2GO7J0Zcue0=;
        b=KdpL4tgQf97/qPm6tGvWNfBcCjdLS1r2/ZMPzU69pt2vyhfGo4Scz4ksItekw4KJam
         VWJB5N6M8fds6zDnm0rk83yB3S1HJAcCTb1xQtVsumwUL89DLTdg59iXvFfjQXMVbbmY
         kONMYgo706PqTeKKiuZwlK2XfLC3v4evRVmOqCfTcfw4WxXPOK1fKeskJ9/NuPtMFVTY
         5beW0kkC9nnCGrIvzfjf8lV5uKcm/0N85c1SIQCOEJHs2dIh3wbWJpssg3+UG+awpw8P
         j3hfhkQAPiZKI2JDwHfrhW/UojFyvVGMEvKFG7xqRimSY/dD2vEmYenH4E+kzTjMSb9H
         +Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888123; x=1728492923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cJzDyKn+uNfg5WYDJfs1LslS4wz8yVX2GO7J0Zcue0=;
        b=CxBbiAeUX/7NU9XlMvwkVoybJGnfDBW3fyDZbrMJHghUQVNbuR62qmdRuK8RVqK5ai
         1HcvTiCQTS7TSWqdEP0mE+6ou144Xk/9zsidlwN143Ve2o5wIloNoQf2K4yvPI6trwK0
         hVx7yKeknVxoOjP1eEPVraRKI29LfzV7utRGMAITrgHlomhMgoeZOBaOX3HeyJrABOWJ
         QQ5o3oUabDfF8njMfklpf15jZECdFEf5SLu/4VUkkCZ0BeoguAgy8Q4AMJJEU3JnBH+j
         X0Y/o0erlkn+u69dKq0Ee50F8obLJdzvGmiIm5XB4/MmEe8Mj/15W5bRnxFubcDNh2ds
         BwUw==
X-Forwarded-Encrypted: i=1; AJvYcCX3dVUGZVQPbULB9S6t3bcX1aAPotG4wmCK2i1XVUuLgslyf6JuOadNzpx7OcwOhYW7QDMHHZkdJDyihp7+@vger.kernel.org
X-Gm-Message-State: AOJu0YwJn6uQJaGyqMPiL+k4Dt38UEd/RFhlYRjEmeeLqN9/W6hHUNpa
	GkqhJrT1+sBWz7Xx9PbzWJrSGbCMBKuQBNKRoFXwHQnKRoEBBKde
X-Google-Smtp-Source: AGHT+IELgxFaSJdIeJAzIlW+xQ09HZDPpr6mdghKGEc/BeKgUpljKURCOjh1enkY7HAwLWwEP22ojw==
X-Received: by 2002:a05:690c:2e93:b0:6dd:bb05:3137 with SMTP id 00721157ae682-6e2a2aedfe8mr30581327b3.12.1727888123412;
        Wed, 02 Oct 2024 09:55:23 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24538880esm25636977b3.119.2024.10.02.09.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 08/13] fuse: convert ioctls to use folios
Date: Wed,  2 Oct 2024 09:52:48 -0700
Message-ID: <20241002165253.3872513-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
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
---
 fs/fuse/fuse_i.h | 10 ++++++++++
 fs/fuse/ioctl.c  | 32 ++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 52492c9bb264..d9fa12aee07d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1045,6 +1045,16 @@ static inline void fuse_page_descs_length_init(struct fuse_page_desc *descs,
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


