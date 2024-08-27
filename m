Return-Path: <linux-fsdevel+bounces-27440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751C9618B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADFF1F249FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ACE1D3622;
	Tue, 27 Aug 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="auAqS6Td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49560155725
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791579; cv=none; b=JEAjMC6s009jhl4UIz0W4l34bIuTS2F7+WpzYPRuD+/c4mD6A/rxOsvXl6tnso9Qv0lw5z8hPSoAqZq7NKpPW90ERwXjg/agyRrmBGpX7dRRsysjICrsMbHi9Lb3fmsnHrLerM5NA0W8HiCY6tyVz/c8V2oL+gNz5Jje6phvd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791579; c=relaxed/simple;
	bh=edDSWxmfXaCuzTueDm86Jp/cUZmwSPmPkS0s549IPC4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV1dJq51o59jQcA5VakoZQMnAcIQKwFHycP/pqKPbnKUAV04veEQIw0AbIeu/dH9BTxcsBPNUCTXbunGa1UfSRkDkeE5C0HEi2Jy0MKhdNlFc7jNXxnRRc8+ee1zCb5bHTOZMO8pRpaGrQ8DIAl2c2RI42dcVF8YSXUOLEsdQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=auAqS6Td; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093d565310so5817408a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791577; x=1725396377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qc93bZuLUuosBEzFDRporb0v/ZZ56YN9E5pszTfif0=;
        b=auAqS6TdnRLAOdxRH9sWcrJbw6IcLZUQbruBJUZKBrfeJSUQJgXAqec0tvl/D0tIb1
         wlhXDyHH51za/hNV9q6I1Mu3S6P6Hfd97H9o7T2MTXt5uIVYAZHggRVkKFpxGp+izJ98
         Vi3WjfH1AgLmVL3hV7QtgnDW/G7mDzMJRp/q4RDutmqPElyzSXf2si7sBEPHVQSEi8Mg
         P0jEp//V8BZjModjPi/N5drItPVuqCGFCUuycM2kXrv7yzL+MmeGsdJwrbQ9xpOsidyU
         1DB88kyrbsbIBwSiH+UaBQ3t3hMFvLhwWiAUW1BOZJuLwqYrCAdKrHWZaxrV449vHiAH
         OSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791577; x=1725396377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qc93bZuLUuosBEzFDRporb0v/ZZ56YN9E5pszTfif0=;
        b=SxuCV6rMQLeVSJ4cuLLaWcb+TbKXX1XYe7LHGP3CAc6JimjRoyrRfXL4dph7qNBeu5
         PKFa9lAYRgu49Bv6Mn8sPLOLkCmWqKQ5aemVvRZeJHLDTFlpcGDfNV5O/WdNUPFSreVv
         xFzw2Sa6JR7820gmKWJqaG8ID14l4lk7zx5FcCaHewccugYYC77DL3H3uAr93pPVoDPU
         p8jo3SiBJbJyIfVE8wUBcTnPl2Fm6armKIYGhvVtjksVl2yixNek6FDadJZVmZ5zPO2C
         u2HhYkf2Md8XUPoFsL5nIjWdfSWLQYTSG4jppABo+GPOQ1KILQ6hIO7fLB/ldL7yub6m
         AWUA==
X-Gm-Message-State: AOJu0YwTPsWdzspnBnch9LnsENgZ9a0up46ClA3GdEPatEItswJIRa53
	pmz2rcrXLitf7ARwmzHUbDNPTAgAwKloxEmR82y78bodACuXOHWAR4sRlRi1Z483mPkWJlV8YVM
	+
X-Google-Smtp-Source: AGHT+IENPUvB84YZtY7Bvb9o8iXddgC6wS1XobOZTIhMzEpdOVXn9GHSkkVMrjrGWY9BC197c1a47w==
X-Received: by 2002:a05:6830:7106:b0:70d:e5aa:38af with SMTP id 46e09a7af769-70e0eba82c0mr16144556a34.11.1724791576676;
        Tue, 27 Aug 2024 13:46:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1b2825sm56277501cf.80.2024.08.27.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 01/11] fuse: convert readahead to use folios
Date: Tue, 27 Aug 2024 16:45:14 -0400
Message-ID: <aa88eb029f768dddef5c7ef94bb1fde007b4bee0.1724791233.git.josef@toxicpanda.com>
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

Currently we're using the __readahead_batch() helper which populates our
fuse_args_pages->pages array with pages.  Convert this to use the newer
folio based pattern which is to call readahead_folio() to get the next
folio in the read ahead batch.  I've updated the code to use things like
folio_size() and to take into account larger folio sizes, but this is
purely to make that eventual work easier to do, we currently will not
get large folios so this is more future proofing than actual support.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 88f872c02349..5024bc5a1da2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -483,6 +483,18 @@ static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
 	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
 }
 
+/*
+ * Wait for page writeback in the range to be completed.  This will work for
+ * folio_size() > PAGE_SIZE, even tho we don't currently allow that.
+ */
+static void fuse_wait_on_folio_writeback(struct inode *inode,
+					 struct folio *folio)
+{
+	for (pgoff_t index = folio_index(folio);
+	     index < folio_next_index(folio); index++)
+		fuse_wait_on_page_writeback(inode, index);
+}
+
 /*
  * Wait for all pending writepages on the inode to finish.
  *
@@ -997,6 +1009,8 @@ static void fuse_readahead(struct readahead_control *rac)
 	for (;;) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
+		struct folio *folio;
+		unsigned nr_folios = 0;
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -1006,7 +1020,14 @@ static void fuse_readahead(struct readahead_control *rac)
 			 */
 			break;
 
-		nr_pages = readahead_count(rac) - nr_pages;
+		/*
+		 * readahead_folio() updates the readahead_count(), so this will
+		 * always return the remaining pages count.  NOTE: this is in
+		 * PAGE_SIZE increments, which for now we do not support large
+		 * folios, but in the future we could end up with 1 folio
+		 * covering multiple PAGE_SIZE increments.
+		 */
+		nr_pages = readahead_count(rac);
 		if (nr_pages > max_pages)
 			nr_pages = max_pages;
 		if (nr_pages == 0)
@@ -1015,13 +1036,14 @@ static void fuse_readahead(struct readahead_control *rac)
 		if (!ia)
 			return;
 		ap = &ia->ap;
-		nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
-		for (i = 0; i < nr_pages; i++) {
-			fuse_wait_on_page_writeback(inode,
-						    readahead_index(rac) + i);
-			ap->descs[i].length = PAGE_SIZE;
+
+		while (nr_folios < nr_pages &&
+		       (folio = readahead_folio(rac)) != NULL) {
+			fuse_wait_on_folio_writeback(inode, folio);
+			ap->pages[i] = &folio->page;
+			ap->descs[i].length = folio_size(folio);
+			ap->num_pages++;
 		}
-		ap->num_pages = nr_pages;
 		fuse_send_readpages(ia, rac->file);
 	}
 }
-- 
2.43.0


