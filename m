Return-Path: <linux-fsdevel+bounces-30274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B1988B68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3911F217E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85631C2DCC;
	Fri, 27 Sep 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IHICuf0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA131C1AB9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469944; cv=none; b=dWjmT1s4NX9L8xcoF3ZIvTtVyKDb/lucGOQjSEBEzfPFT7YA6PoAsSveGD/Vmzv5UihhnX9A5I+XmgdK2MIJGWC/S6lttsc8lVtrZJQH+L46HT3eg5fOwdmOkTvbmPMeYHnAiVDX5+8xRfwf25MvgeHxBvk+3oyWSRBmffaCd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469944; c=relaxed/simple;
	bh=f/Gk8KLKsEiYexhk0587re0F37sdJg/L6HMGRpEpYb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/wSCuYlMzO5B49x8UEOy4zlHcoLON6m4BN4zlu5Id4eu/pJOj/gvjlbhwGKtCQNdQlDW+zG5AlofKK/lJ/9MpJBvq3yfxT9bS9kONyFtDev5ckuYZ7DY3sUe9qMgtRnb3SlQgLLtVNdtlNyG+8rjrPdolf4TSYZtau2nlCBOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IHICuf0r; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6da395fb97aso20487057b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469941; x=1728074741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcyFx8sF4r8eQa55DYdki2Qz8c+eiUu+NpKKcrfpvFc=;
        b=IHICuf0rT+FTE3nD5IlZYL6SXQhj0LsVOQ5jkqS2zM8tUtDF7jamihDkDXXu1Kyx0G
         fc0owDaJ+HzyiGbANXdBwyEgolqohIhGR2DQiALNmE13ykTZn66DHvc2EXrDTsKqXpDN
         Iv8QwJ0dmiwlxXPSsNg50g4Olyf4Nl8xUU795Jqhfv4Vr3h63l3hftvDSAGDt4XgUiXw
         Qn4QipXL61wcLeMRoV8dU0iDfrRzffBZTRxqSV2GWKN1O0xQ+HppNBNqyTCb1uzVtw7G
         bP2AuNeN7tvwL4cLHjEqbFkMVg6Xqv2W65ZsWjbIH72AYS4I0crD7vuYI6mtnTh3giO/
         frXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469941; x=1728074741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcyFx8sF4r8eQa55DYdki2Qz8c+eiUu+NpKKcrfpvFc=;
        b=DGa+oW8CZgG5A8Ephw7Z3grQpHoNZadBxrsd83ZVcwpww8rKg8BjypWYiWbpBSC5BJ
         xTwaXAiVYYBc/4pHU3SRv8FaR+/p3KTESKnNgzjZCQDfVmsSoRpYdW1KoPVaw5CyYck/
         FpC+U8LPCb2MSRsxqPFWekI8pC2M55JORsWbI1SLIjiolmBO/ZxfrDfOJ1wtIMmiZR92
         UkuvXAiViPGO6pBzcAn/14IHHjd8eEHOuIaCANXW1BfRs1m8B3cH59Vwv4A1fGvWJLi6
         S5TMg+dSZAF0UAnTcA30V5DMJJIhuhRjYt9SFBPpwUpDpTxcx3Ubs3g+x4b/KfNB8Fxf
         G7ww==
X-Gm-Message-State: AOJu0Yzt8Czwxin1gSX49ojAhb/9mG0CbkyjoimPVcpktgABBlelD7MM
	/xrQt3TwH9pACTaldU0tetsPXzl/Krb6Hr8PQgIP1Vv4/HSHy+e+hwmLtXnDlFGQkCStXltei4s
	4
X-Google-Smtp-Source: AGHT+IGzYhUo84meo83vcXCOAxiSnaaL9zl5bUBf4VG/33Nype4oQdjtHNL2Jlj7DdVGnMccYePWYA==
X-Received: by 2002:a05:690c:6612:b0:6e2:ffd:c11e with SMTP id 00721157ae682-6e2474d1224mr38895267b3.6.1727469941038;
        Fri, 27 Sep 2024 13:45:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f7c1bsm4172657b3.4.2024.09.27.13.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 01/10] fuse: convert readahead to use folios
Date: Fri, 27 Sep 2024 16:44:52 -0400
Message-ID: <ffa6fe7ca63c4b2647447ddc9e5c1a67fe0fbb2d.1727469663.git.josef@toxicpanda.com>
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
index f33fbce86ae0..132528cde745 100644
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


