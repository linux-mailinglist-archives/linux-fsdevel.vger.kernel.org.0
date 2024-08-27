Return-Path: <linux-fsdevel+bounces-27449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF439618BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ABF1F24D02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7051D3634;
	Tue, 27 Aug 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kBP2u5AL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9971D2F61
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791594; cv=none; b=HtczMJEBEflEgcrFO9nrXURxZCRM6EVdGpzfMEfjCZPwv2h6pNoIeqyqLHWaORBifYqc9b8TZw0xM8FxO4LhZxkwuPzYdxD0Bc8mL1V6A2Pxz1qDEF2BLEQABDic5fhZLS5WqTzC7N1p+W01P0MOHYDmgwn587uopXvjobtZ8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791594; c=relaxed/simple;
	bh=OV3zooZBd3zMTYsF5C24bLlFtKpkafNeiOFd0zeySog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psBey6dKgIrEElOxfUZpqDJliYb+UvwrHqTpkq1TkM6bn9u9zdWJZUT05qS38U/5MNsLFfl8RcJr86jrzOWWLanh/e5UzQq3pDulB+eezwBkwUnST2lvmGmTIifDGDqm4rKujo7ygHa5hDWIVmUYT9wPtqKmwxT9WSTQlpuRKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kBP2u5AL; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d7a544e7so391479585a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791591; x=1725396391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9dT/v3YgOTooURpd2nrSPGuDHyhAqYavjf+ZVThVnU=;
        b=kBP2u5ALuNr/ytcnaD0saYBm8gZ9ZMjTzlfrX2eQH2e0Few4kD0rxsQK4Ltl7nvo2H
         E5ZENVpWRQJOqiSHcztTTVL5sBGTnzvo8VF8PwNgu8MXaxyZLwew6gjJ3SOuMwiB6GBs
         IGW49iHaNq2dHQpSLnsxe07x58/LktQaSWqAbOUXWDtCv3stEhRgSxJBAgD+pg2DzYe8
         81gkz0x3HRplcXavvMwmGCuJBh5wuEoaWvlJVy4M9KYUjQav3/fl/5j8Fyw7c9rsDrat
         AVG1xPBuC1YabUU0MrkhN992Cm/yZ7BqvisRb9DdE+IN60LRPtf7Oly1n1BcbxWbb9/z
         VeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791591; x=1725396391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9dT/v3YgOTooURpd2nrSPGuDHyhAqYavjf+ZVThVnU=;
        b=YU/Yw0wYJU+3/lE04LMJ0CQQThNwu8qzgZIr/xFdUFh2qyavigv6+lcavPv6PkUc8p
         Rf8uKWp6AyztSm5UkQDcWcg0kl9/Jmy1oMhwW4xN8knFvHFS/YAqM5ssRA28/Q6WQKhv
         WPIevx2rHuhuHkc9N0bNc9I+U8vbS5pkP18hhqmUvK95mGDzbhWsjBDBoAJfxfVFdUOl
         hxV7WbMgzZSAijJO2/mIEMx+RTy9eTDIUL+5osR6CIObmq9VBS8/uCNmfMx/qob1pc4M
         bFpS7HKIBallf6b2nbrxPAeSDxZkyqPOdCiM8gEtNrgTkIJfOxu92ZNDpDy+gApdKX1D
         SkJg==
X-Gm-Message-State: AOJu0YxFrMvZxOVto4+vrfxStRwzWZBrpW4dayHnrCCiP12OAdWTRFMc
	Xz9Mfy8tNKEEaH4s+I1lMzXMj2OpjlVy2HonuFJLlwMs71RusM9NV923aedNuF5ZSLQw1J2D8OB
	Z
X-Google-Smtp-Source: AGHT+IEwLEEM81zHFlYT5j3b+Wf5oXR98btPnECe5l7B9KQUiJKW0H2Cba4SZbAoJwqT0QZj6sxQuw==
X-Received: by 2002:a05:620a:2990:b0:7a2:bd9:70e1 with SMTP id af79cd13be357-7a6897b941fmr1614820785a.60.1724791591270;
        Tue, 27 Aug 2024 13:46:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm577821485a.132.2024.08.27.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 10/11] fuse: convert fuse_retrieve to use folios
Date: Tue, 27 Aug 2024 16:45:23 -0400
Message-ID: <5666724f5947145cec4f7b774cf276eeb236eda5.1724791233.git.josef@toxicpanda.com>
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

We're just looking for pages in a mapping, use a folio and the folio
lookup function directly instead of using the page helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7146038b2fe7..bcce75e07678 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1709,15 +1709,15 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	index = outarg->offset >> PAGE_SHIFT;
 
 	while (num && ap->num_pages < num_pages) {
-		struct page *page;
+		struct folio *folio;
 		unsigned int this_num;
 
-		page = find_get_page(mapping, index);
-		if (!page)
+		folio = __filemap_get_folio(mapping, index, 0, 0);
+		if (IS_ERR(folio))
 			break;
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		ap->pages[ap->num_pages] = page;
+		ap->pages[ap->num_pages] = &folio->page;
 		ap->descs[ap->num_pages].offset = offset;
 		ap->descs[ap->num_pages].length = this_num;
 		ap->num_pages++;
-- 
2.43.0


