Return-Path: <linux-fsdevel+bounces-30375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3398A5BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5651A1C212AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867A18FDCE;
	Mon, 30 Sep 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zKRenhHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6618E02A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703956; cv=none; b=LpT7ooI62z8qHlV/MfZvMG8NslA7jLl4jO9Io2Js7G+REPHnEzS3ZjP2mkjJymlIacAtnx+XLmjn6WH2f92+QzbrXpEaILcryD8iZ13jcukiWJ8Dx61Ea1rET+pMpaqDdHcHzaQxI6nKqy7dV+V52e1c4d/1mgrF+jSyMIvrnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703956; c=relaxed/simple;
	bh=3yoAzpc6x7RiKepbAWzbPPZl/rfOMuOQW7PbDw7hlOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrnqio0XtKsjY4SYX6DaIhUTxfwkJNNGyRLLZZMIp4K6xgsERcZj6GXk3N3crimVBxy1xP0K8Q23maoOZK0yfAI79sCUW5NLOjFVfFQ/IQMQOK5GLWQMXv6MOM8ZS11oZ73JxJmnARSPTe1XsK9WLQFQhshERB1eMC9gj4dBMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zKRenhHC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45812fdcd0aso47513041cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703953; x=1728308753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXm352ZikGGcWRy0f758PDXSSrckconTdtleB82mBFs=;
        b=zKRenhHCwutukpJ1uOjElYd0X2FAsrOHoTfZU2YUrQhRsjJIUmaatvpL+xyYmZq5ty
         ZYPOTkGAZw1RUT/6/oh/0DzefMXc7SIIVVZoi0tNix4W4oagshOJy8grXw+QFjYckKKE
         FdBokLK/tdpEaD/nk3fvEyQu2jx0MfR1OCR4zO0x1hRhAVsHd7nosEKRw8gXFSX8WyhD
         Wkc7Ms3/tiBYzue5/H9Qqf15dFyv6LZLTh4fSsYMI7VGwJtPSQ8znQo7kb7pLfp9xzvJ
         /GG02hrHyTcNi89ftJ3U/xSlkVbpieITqR8dPie8SgY9cfiVuxWbETG0hAjG/AU8gyA/
         elXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703953; x=1728308753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXm352ZikGGcWRy0f758PDXSSrckconTdtleB82mBFs=;
        b=nK/2x21HzqxesYikNkdSOvBU313QTsJPzMi/iBdAumAbNM8PK37nu+5xFgzUMDcGWp
         XwE6KXmWNFhwOjfL5PUiTXgp3O6qrv5WyC4TJat9sEDkRBZM2yCOTECs2qlGpIoeK5yD
         pyMMCF17OvfO9ZLOsa8rbzJfpQCp9u9u2bElUqxHw6EU9xE5hZMccLO/RipkVflURt7Y
         ae06Gcp6lm5WQ+RZolG+u/kuIVmK1VtugrBdfrn5mhzgE/JmJj58G/VTuQQwUugWxNHe
         rpXHks2N9w4J/ehdRAwE/gAvPDD4SDAAdDsW9E4wsGjYUl0deUZaictFkA17WXjZ8PZH
         GLiw==
X-Gm-Message-State: AOJu0YyQKRzXcn0cHgvReXfW317u3uWQ1ICjzX79wLrG8xqtS5la3tBa
	YZ15OOrHYqlRwWjodn99we+8rpysETP8bdLi7Wu6YalCKebngncTQI40u3bXQ6PaHNExneGpNwT
	B
X-Google-Smtp-Source: AGHT+IGMPE7B+bd8DIU6zTUjipwGbHHQXTwEtVUV8/xm75Jgana7gCtHE03z1iZ5SdOP56PYa7mmJA==
X-Received: by 2002:a05:6214:d0e:b0:6b0:8ac1:26bc with SMTP id 6a1803df08f44-6cb2f2832d2mr263806366d6.14.1727703953118;
        Mon, 30 Sep 2024 06:45:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66b0adsm40111976d6.91.2024.09.30.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v4 10/10] fuse: convert fuse_notify_store to use folios
Date: Mon, 30 Sep 2024 09:45:18 -0400
Message-ID: <dbf9b5f071177bc18d157e8bb2ebe258d7ce49a8.1727703714.git.josef@toxicpanda.com>
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

This function creates pages in an inode and copies data into them,
update the function to use a folio instead of a page, and use the
appropriate folio helpers.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a332cb799967..7e4c5be45aec 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1654,24 +1654,28 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 	num = outarg.size;
 	while (num) {
+		struct folio *folio;
 		struct page *page;
 		unsigned int this_num;
 
-		err = -ENOMEM;
-		page = find_or_create_page(mapping, index,
-					   mapping_gfp_mask(mapping));
-		if (!page)
+		folio = __filemap_get_folio(mapping, index,
+					    FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
+					    mapping_gfp_mask(mapping));
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			goto out_iput;
-
-		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
-		if (!PageUptodate(page) && !err && offset == 0 &&
-		    (this_num == PAGE_SIZE || file_size == end)) {
-			zero_user_segment(page, this_num, PAGE_SIZE);
-			SetPageUptodate(page);
 		}
-		unlock_page(page);
-		put_page(page);
+
+		page = &folio->page;
+		this_num = min_t(unsigned, num, folio_size(folio) - offset);
+		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
+		    (this_num == folio_size(folio) || file_size == end)) {
+			folio_zero_range(folio, this_num, folio_size(folio));
+			folio_mark_uptodate(folio);
+		}
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (err)
 			goto out_iput;
-- 
2.43.0


