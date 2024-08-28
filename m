Return-Path: <linux-fsdevel+bounces-27647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED69633A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F98283235
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C581AD3F2;
	Wed, 28 Aug 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="q76dVhRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE51AC429
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879683; cv=none; b=imW9qPmthpslxyu6zJIViWwvup2B85R8VjFauq2Uer+JBpHBWeYmwrbH54r8VDhV/C0wTQrNSf9ZxuL9wNHYA7XSlqeJV4EPyPF7jVJCAAHqr1Zpm778g+PanpFa/8zoOw7/Po0BTPAKOY6ghw/lYAl2AW2+EymTvF3KmnAdzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879683; c=relaxed/simple;
	bh=/rTcYLoPcRIZV6/SmiOMJpBdcT9n4KwY5LbgEXkH9j0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtSIhngCbJ2ec3hIGJIkVQhI48lfQR+4IGQm9OcsTACuIuUqTkWauehUJFnWY1WdE8NtJ5AE+9dmCsJzeJswoJYjnO9lj+lHrs0AH06XD4W7UnTpN2dI7x12i2hc1sOJxeZLv8ydU+3ax1sNenhoaRa2unnzYZ2ZvS26fFZtO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=q76dVhRl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db145c8010so1502154b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879681; x=1725484481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNrq5/HUpXvsAD1MkCKtRH19IM1YIvu9q8Bg/8sxvEc=;
        b=q76dVhRlTNtlu3urFmq0PjsOV1cJ0CZa/v06jzX4XzI8ar7fqTAuhv4cj86u+AGC1a
         LxTEsPUsueM72ZpALIFiBmaFVoqjDwxx+TMJcP7kov/VUNveJVu7sIFgDAbypIiLnQg1
         +OkpDMCiz22EsGAKTfhNstjjLxZMulLqY2OE1jEyYV4Jvo5BmgLfU5mORA7UcQcWnnCO
         vdCc+ProGTJiJFQTdb2Qi+ieBUXUlgsMfKFB2zWWR2bQCS2JZhIDJ7DJtqqzMKncweL/
         ZxOAv2HSx4JGHxohK/dNylKPS3FlA/HJ90U7gWCYT6ui75j2mUdksX06GjCtJzBCsGOt
         fgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879681; x=1725484481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNrq5/HUpXvsAD1MkCKtRH19IM1YIvu9q8Bg/8sxvEc=;
        b=X+84LxQsEC2zJm0ajrln5hN8cIjcVjneBWgx77iU06VH6bCezyviH3hGZOcrhFXCpW
         nQ6ujB2eMEwghG42MyRN32sKxQPlkiNpJi7JJbH64y2tYD6xOwgcJ4y2Nmq2+sM8sDAb
         8Xnur6wimGKMMBW0ko4MrFxDLLZln8zagt40ybqVPC99/p2ksmPRoQqSZfXrTI3gHWIg
         LFKaIF4lHdkLJdhX6TS2/BfpHcdpQEysV5W2zh4DeW5M2CnKVWqxkNEtMFu4woF9ETKu
         tMzcFU7Sw5ZBkFbI+9mnQZC/io+tIlKzF0dNIgctGARSLxdo5F4KxRasqaHvsYoWUGQP
         cIpw==
X-Gm-Message-State: AOJu0Yyzm2cLX2Tm7FVjn6MwVfqMazDQRBOF1CUrtEolkik++JvbcEDf
	9+zNZSBDtXfCu67Xy+1uhbx6+3/cTAn26+zt2WTIrqnf6EDl6gNmhPRnl0oJoBOT5NwbREAwtOt
	y
X-Google-Smtp-Source: AGHT+IEWj6d61UsxElpUcYRhUT/IBgERWAcY7tW3nDPciNZYvgm3z4yzvNzA/L3RRHevdhOl6z7eRQ==
X-Received: by 2002:a05:6808:2004:b0:3da:ab89:a808 with SMTP id 5614622812f47-3df05e33094mr753104b6e.20.1724879680764;
        Wed, 28 Aug 2024 14:14:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfc5968sm64830931cf.15.2024.08.28.14.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 01/11] fuse: convert readahead to use folios
Date: Wed, 28 Aug 2024 17:13:51 -0400
Message-ID: <277609d4fde934da213f74f235f3731bd7f50230.1724879414.git.josef@toxicpanda.com>
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

Currently we're using the __readahead_batch() helper which populates our
fuse_args_pages->pages array with pages.  Convert this to use the newer
folio based pattern which is to call readahead_folio() to get the next
folio in the read ahead batch.  I've updated the code to use things like
folio_size() and to take into account larger folio sizes, but this is
purely to make that eventual work easier to do, we currently will not
get large folios so this is more future proofing than actual support.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 88f872c02349..2fd6513ac53e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -938,7 +938,6 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		struct folio *folio = page_folio(ap->pages[i]);
 
 		folio_end_read(folio, !err);
-		folio_put(folio);
 	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
@@ -985,18 +984,36 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	unsigned int i, max_pages, nr_pages = 0;
+	unsigned int max_pages, nr_pages;
+	pgoff_t first = readahead_index(rac);
+	pgoff_t last = first + readahead_count(rac) - 1;
 
 	if (fuse_is_bad(inode))
 		return;
 
+	wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
+
 	max_pages = min_t(unsigned int, fc->max_pages,
 			fc->max_read / PAGE_SIZE);
 
-	for (;;) {
+	/*
+	 * This is only accurate the first time through, since readahead_folio()
+	 * doesn't update readahead_count() from the previous folio until the
+	 * next call.  Grab nr_pages here so we know how many pages we're going
+	 * to have to process.  This means that we will exit here with
+	 * readahead_count() == folio_nr_pages(last_folio), but we will have
+	 * consumed all of the folios, and read_pages() will call
+	 * readahead_folio() again which will clean up the rac.
+	 */
+	nr_pages = readahead_count(rac);
+
+	while (nr_pages) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
+		struct folio *folio;
+		unsigned cur_pages = min(max_pages, nr_pages);
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -1006,23 +1023,19 @@ static void fuse_readahead(struct readahead_control *rac)
 			 */
 			break;
 
-		nr_pages = readahead_count(rac) - nr_pages;
-		if (nr_pages > max_pages)
-			nr_pages = max_pages;
-		if (nr_pages == 0)
-			break;
-		ia = fuse_io_alloc(NULL, nr_pages);
+		ia = fuse_io_alloc(NULL, cur_pages);
 		if (!ia)
 			return;
 		ap = &ia->ap;
-		nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
-		for (i = 0; i < nr_pages; i++) {
-			fuse_wait_on_page_writeback(inode,
-						    readahead_index(rac) + i);
-			ap->descs[i].length = PAGE_SIZE;
+
+		while (ap->num_pages < cur_pages &&
+		       (folio = readahead_folio(rac)) != NULL) {
+			ap->pages[ap->num_pages] = &folio->page;
+			ap->descs[ap->num_pages].length = folio_size(folio);
+			ap->num_pages++;
 		}
-		ap->num_pages = nr_pages;
 		fuse_send_readpages(ia, rac->file);
+		nr_pages -= cur_pages;
 	}
 }
 
-- 
2.43.0


