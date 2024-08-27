Return-Path: <linux-fsdevel+bounces-27450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E619E9618BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82179B23440
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70641D4151;
	Tue, 27 Aug 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vrsmy/B0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026181D3626
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791595; cv=none; b=UMbiW1kJutLVO9pM4T0qt8fBBvQs0T9yF0QCP57UXH0Sv+sSRrDUCo0RYLtyuCWmzju526BsfmsX2sBSN6WoexoYVaw+ZS+lDq3FLO5K0vWfuZmzFD6A9cAnupb1naAX+FZcICK3ZCkHPx1Kfx3MtVOhHq8TvPxLKZei+XXoPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791595; c=relaxed/simple;
	bh=X0DApJFK7Z5eoBilBYIivvWd5ORVAHNlmLt50Lda20s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0QiYlPlRt1bF/ZwZxL6JFuY9DasDRmwlE82ioXGLFAQ8iPqbc4D2etm6RszPSz4uIZMcvILaGVVbJ33WSfpTNS8xh67v46g2K9hveT6UhkqhBgRQisV1l74F9OzyWC3iRVojRuM96tNA2Lm9Fs+Kyu9YrWwjXdROpOhXeFPZXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vrsmy/B0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7f4a133aso32239566d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791593; x=1725396393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ15t9uWlNPdfkJDsR4E1Urv+RYku/UF4TJezYHI1D8=;
        b=vrsmy/B0U0lYhb8UK6rahWV+5GcOE5bTG+vNm/xauWfHM5H36NsdZIZ+dtVhJFix/M
         h1PCDAjLHkHC9F3eTNMV+jyK9npbfeJMKff+/EgdmzUXImlzp73C8sDRgcYUJN1euW84
         uA79dH45X+s0iiymxLMjPsUb1XLjvUsLcHBAd3ifXd1LjfjrccmufVHTgwlLAM97SM7/
         wmbgwLz2c9WluwrXX7d/IOfkiwQzbMnzWtMnj9/SvuIqOiwxm0Ct5LQz7y3Sjmf7jZVV
         +CTqgEkkG639iXH/liHY4v7yUfyAVlIpgMyyt14SZV0dUfAzzVknyucXA81kE5zbLE1U
         uA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791593; x=1725396393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ15t9uWlNPdfkJDsR4E1Urv+RYku/UF4TJezYHI1D8=;
        b=Uix76uBqjYdqi/1JL7orQNiakzljzh6mwfXd4FTZdHoNkfU/V/UFhqQMrn2spFiAOq
         kIQpw2F6A/owEy38fM9OH7z34JMAro1qfBR6g6Um1jlNATzxRZX/QUYj+4qeXAQM/VZz
         CsV73K89uRIInpN0NrVfWBfYz68iN19ednZzO8NV3yexZyXs20div4ayW7NCYrPbkdcj
         VMhPTsTnfalk1/+5DzJep0oBUjTq0Y/qFNDZwjKIqwqS2IjvdIsf7t5JQ0zlJwFboSEd
         mu1AmPTpEIgRdDqE0uBWN+ttM7nsKL2CzF4MFTfi8yl/rGIfLgqIwEWxSUNEifH1uBcf
         HenA==
X-Gm-Message-State: AOJu0Yx6LcXdn+U83AIt+rmeB61oDQi5keLQEeGBxmfN31deAF8oc64m
	BikpbMR6RJI9edKTxQJ2x2dXloYEdZUBinAq9YiIbJuRHxDug/VMvQ7ZuMJqKp591YAk9dlhz3M
	x
X-Google-Smtp-Source: AGHT+IHY64FvbMBVx9McZPr66d6evKiFqwvWlKUdtgc6bwkMCo9Gl+Eejo56MjSJ5PZBowDoxEFURw==
X-Received: by 2002:a05:6214:43c2:b0:6bf:8186:be29 with SMTP id 6a1803df08f44-6c16dcbd348mr167877416d6.43.1724791592631;
        Tue, 27 Aug 2024 13:46:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d2122csm59779466d6.12.2024.08.27.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 11/11] fuse: convert fuse_notify_store to use folios
Date: Tue, 27 Aug 2024 16:45:24 -0400
Message-ID: <aeaf36747f322eef94b80ee88d16f7f40aec41d3.1724791233.git.josef@toxicpanda.com>
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

This function creates pages in an inode and copies data into them,
update the function to use a folio instead of a page, and use the
appropriate folio helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index bcce75e07678..eeb5cea4b7e4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1607,24 +1607,28 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
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


