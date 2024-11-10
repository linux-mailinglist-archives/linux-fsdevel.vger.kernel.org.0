Return-Path: <linux-fsdevel+bounces-34147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C799C3323
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169BA1F21434
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4084D34;
	Sun, 10 Nov 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uCQqbBCW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421C4F21D
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252557; cv=none; b=RDUUvHFi2RWTCXHvuiCwr+5oghXrTYZAxjfGXdRt6cOP0xQnFwZDJUDm1mD4EqmefhARn2eL4hJk04hmqhc8wINMaCgndEsMlBOD7tp8c86DAJwCNfOmEs80QEzAe3Tm3Rn8j/Wbe4OBVSSJ9bTteI4T3G5+1qnfKNQJ/gyhrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252557; c=relaxed/simple;
	bh=wdE7j3SXsvf8mZ3WLeO9bDbqT1xBl9uoI5Ta1MifPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXTeVAiR/lhdCDJ4+wqfI+Wu2t1bq6PkMcB9cIpluZx8upb5uZNXgb6LbSQbkJEvdf5vyy+z86xOJkuT9g8Dgnp1LNKcI9ThwHRDUyNFDI0OgY9Etb6KrnhgrkUrOSQksHjzVDIRx20OVCex0KvMHBXVO97LnJnui8wz+nBRHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uCQqbBCW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so2769145a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252556; x=1731857356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=uCQqbBCWKXwXYqwtTldcjEciA9O/jswHvB8sLHez+k1MKrdrexbKmmLlB/2xSJNehQ
         zuenZR0qWPmvPing0Yi5k+ZkBLHdMbPMqOqZJQnQiVwt9tVjJhPoykkq92T+mJD7mQoa
         lni6bK8H6oHmdCTtAeO2TEYmshXmLFggiMg0gaFKq+ZH17jiPFxRK8ssBeviSxnhO72r
         lI7jc0oBbhqdTX8v8xLwtecgCnTQw//ddS5raCd0WoJiLtKDMxyfa5Lb5SlI3KVhG+b5
         l3W4+EASOfHXCGRQqQM4MFMb6MuaBaR/gwe8C6CDdjetfO2m8GEvGkYZKTcWmA5kYsiw
         4Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252556; x=1731857356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=oo2N7M1jhuuSD+Z7/hXRglTRb/J8TEJGooJqhEsJ9zOUZYCdeXdLKxSB897/03jTxQ
         KXWNAt2xAGEzM6vlcT120jXl+p6Qz0MkFpudShCIJ6PcG2Ev62MHgY5UUvtT56M5eFpa
         gk47X9sn8H+ZhGLrvtBG6OKI0ykx78ykQnld4lfvUmlTc2oH2GLSVSywEXqxV2IcMJVB
         D904kC5ZYG2+pK03Wq5/65ZNq7P4vk+m+6x6leNb2Ip9SetN5q3+9ie9CXz8eVuLBgA/
         kfIfEZKAwA8vS4E2iht/XaU49C0CZ8M2DfiG2hbKLLEwFT0WNV8TYpa+tIMmVhaZaa2P
         3WCw==
X-Forwarded-Encrypted: i=1; AJvYcCUWXwFqMMZWh3s3/S2d+JuNt1yFlcUTp9S1AysRyRmaTjZ8XFCxIxu0tUZ8pOv1YwbvroM9W7nEN2ui1B2j@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0UUWSHazAhUj19CuCPOuH1EIFtcSW54ZlKIE2L9MtWbYQNUn
	A1pG3alsOr4rBZLBlCU8B4aEveTlLctEmG+wpIMMFhW/5sF8EHvsdmMyuE+VUZA=
X-Google-Smtp-Source: AGHT+IGMsIWblwQtQWO8JcRHCLRTN0pIGof64EqqksTz4TFFvZ2UD/wQcBuuSf4CK9eKe+atZiR/kw==
X-Received: by 2002:a17:90b:4acb:b0:2e2:be64:488f with SMTP id 98e67ed59e1d1-2e9b1655945mr13617134a91.6.1731252555726;
        Sun, 10 Nov 2024 07:29:15 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/15] mm/readahead: add folio allocation helper
Date: Sun, 10 Nov 2024 08:27:54 -0700
Message-ID: <20241110152906.1747545-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a wrapper around filemap_alloc_folio() for now, but add it in
preparation for modifying the folio based on the 'ractl' being passed
in.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/readahead.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..003cfe79880d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -188,6 +188,12 @@ static void read_pages(struct readahead_control *rac)
 	BUG_ON(readahead_count(rac));
 }
 
+static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
+				       gfp_t gfp_mask, unsigned int order)
+{
+	return filemap_alloc_folio(gfp_mask, order);
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -260,8 +266,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask,
-					    mapping_min_folio_order(mapping));
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -431,7 +437,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
 	int err;
-	struct folio *folio = filemap_alloc_folio(gfp, order);
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
 
 	if (!folio)
 		return -ENOMEM;
@@ -753,7 +759,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -782,7 +788,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


