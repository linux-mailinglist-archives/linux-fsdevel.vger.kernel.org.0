Return-Path: <linux-fsdevel+bounces-34073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828F9C244B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C80D1F277CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DAB21EB99;
	Fri,  8 Nov 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lRrySLls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ADB21A711
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087924; cv=none; b=QXmJ0zYsj8DMIoq6Je5a/ILH2s+h8jzvopNj0+BCuTxOhUunrmDWbl749/RFWa48PldrlrpQLviSWgvPdF1lb5dLkffLtEmzK95UQq/isk0mwJn9sFJaOi927g85kdpkFAmJtG0EjU1y3dh+Nx4HtuUFpO6eqo03bxoakKONq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087924; c=relaxed/simple;
	bh=aEnrAJGEshe44zlb6XbbKSp/FXpeH0RZvF9K0y5SLj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UM9QgWQD8nThrSsFx12a/3L4ZuTc7YLqZdFvNluG0YcQruXzAbFr+UewJkBX7lve+p1qXhSXSCWrtza/SYd73q4PlrkaU5Rm2Wk+zJxLgz8I4Nm1+M4hcyJtLmUpqXKmOJvaIjwM984Xhz5Iv24XypE3Y2EKr06Ip2jeMQfwzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lRrySLls; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e600add5dcso1373114b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087922; x=1731692722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJBisbj/rGvidSFxNEf05dxDvPbQrKvqbgVXmZ2uTrI=;
        b=lRrySLlsPvkjgWEoIeTcImf5J9L6KPiHTwOJ/WY5bYGrymWCjwzTNLULYyDH3PBYXX
         BMR8zdThJIsZRHADfIi/j/kT28vGano02RM17EGduF/b6BSfQGoDco2mqTAg1gvItsvh
         liivkL5JkhRVG8gHZ+OsE2bqNyruxmaDYr4Yc3GTuqeGRfrlsjs3cnFp5qiGgHNFsDaU
         ti6OXyjw1ARiRySWE08pnz2qkFn1d6hN9WsRU4oqw0M80g5qGixR4wiU3D9BAAcn5vfX
         Y1JuU8LAWmE2H52GCvP8DekK2p2035wH6JDE/4lDZBM96DgZ/o3IbqJW1Frh9fwRByI8
         uDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087922; x=1731692722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJBisbj/rGvidSFxNEf05dxDvPbQrKvqbgVXmZ2uTrI=;
        b=jD8v/KBOHyec4v/j9H9fUKojZWdxSNzPaqs/65mJTocxO4J9CweVyVb4XYqW3rFoxj
         0QPFKSWQsY4m+S/zdLFT1j2JxsyNU/vwEQ/h+2ofpVXtHK9Lm/RFqZI7Tluh9HsgjDxi
         3ECqD1XDK+u57xsfpBbW0uzSgE6nDuaX0Y4oerpoYZi0Jg8j2b7N4+5//68PMvHQ4Ga1
         rFGq4OiiwkrQXEEqjqeULl46Pgo3X4Q8PqXFkzcuoO297ZSKYSKDaGf/GTm20ZJc1w+X
         AiouWxkZ5NuErbdvxzA2MI2+EjF9YDX5mUNLWxaYmcvAYNWtoZv+R2+v26PqOE2ONLML
         /x/w==
X-Forwarded-Encrypted: i=1; AJvYcCV6bZtbZMlIN1tKhcboeq3udYwibtNlw9mkAFil3fcE8s7PciWpGg6DbfwzMQqmiaMQ0PtpbpNeuzzdeeW3@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGGMDHsajFEWg7xevtffiWRwEDRyoDIgW8WFAYFfs6kl7BKET
	t1ZlD7UuSEolXE6JnM0F/fMxRqYOt+JWE8I9dTZG5OCv/I7VT110NOXVqGIgNW0=
X-Google-Smtp-Source: AGHT+IHAnYXln3VhbkemWI+8mH1zeQAS07vGHF77rvkzzA3Evd8Py7SGOWt6/hgQMWEBNANFNnt9yQ==
X-Received: by 2002:a05:6808:1987:b0:3e6:1057:21af with SMTP id 5614622812f47-3e794772f73mr3805781b6e.41.1731087921963;
        Fri, 08 Nov 2024 09:45:21 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/13] mm/truncate: make invalidate_complete_folio2() public
Date: Fri,  8 Nov 2024 10:43:29 -0700
Message-ID: <20241108174505.1214230-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make invalidate_complete_folio2() be publicly available, and have it
take a gfp_t mask as well rather than hardcode GFP_KERNEL. The only
caller just passes in GFP_KERNEL, no functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/truncate.c           | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8afacb7520d4..0122b3fbe2ac 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,6 +34,8 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count);
 int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait);
+int invalidate_complete_folio2(struct address_space *mapping,
+				struct folio *folio, gfp_t gfp_mask);
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..e084f7aa9370 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -546,13 +546,13 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * shrink_folio_list() has a temp ref on them, or because they're transiently
  * sitting in the folio_add_lru() caches.
  */
-static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+int invalidate_complete_folio2(struct address_space *mapping,
+				struct folio *folio, gfp_t gfp_mask)
 {
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, gfp_mask))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
@@ -650,7 +650,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 			ret2 = folio_launder(mapping, folio);
 			if (ret2 == 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
+				if (!invalidate_complete_folio2(mapping, folio,
+								GFP_KERNEL))
 					ret2 = -EBUSY;
 			}
 			if (ret2 < 0)
-- 
2.45.2


