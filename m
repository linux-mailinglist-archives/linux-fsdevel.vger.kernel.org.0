Return-Path: <linux-fsdevel+bounces-34354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D005E9C4A5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676F9B2F3D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44061CEAD7;
	Mon, 11 Nov 2024 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DiY4ayqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A31CDA27
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368947; cv=none; b=EaY/eSWQEaSeYMZcDqcw775vxstfBK0W4Ta0RVg5JPxFyJLGDo4PntQ9nHrEueKisnwOWmwZrYb2iYkT0VyzYFYMwVp93+/KuDKGYMx/37alKlr5HYCnH6r8stoz/s/N1ixNE/RDwm9dZAyYG0Hn+vWjRp4VP3mk6SKpvnG0eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368947; c=relaxed/simple;
	bh=g/haD3K2EU2Y4QS833/TY88VMz3RgG7lve6et2tjW0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNewXC5ppk0/3fCIoCeAqsdPJ2k13z9jhDTBo1TrJgKv/PRU49wWzsrcojql2/t0Ni85dRF6YfQFaN+NorBbPhtlGbYcHpAOmWtMbscIydLnCSqIDGAWISZ3SyICWSbuBBgKGKBlSOCbNdZ+BC60idY1i7dSmNKn4AohyCSGR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DiY4ayqz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720be27db27so4124199b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368945; x=1731973745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuWHSESvZxScxt1gtQJTtWY+NoQXodLd0kknM0wzZSI=;
        b=DiY4ayqzzDxIFKJRkM05e6VspCONzC/qGzPdoWEEbQfWMJMgiLpMZD3swUijZxqMAE
         IUWhkquDG2fMenZuNEbnc5+vNuxgqeD4jnb8WMIJtxWgzd5gfYmZs16g1lV4iKVXWrpJ
         KvWLo+QQRV7Bf55axkLLjyJ5MyS5bRNb8h0WxNG2r63B8ejocaaSTK8oaxTb94Js+u04
         umkCd6PEWkI58RYrfgXO4Bbhobj3XCjIsF2c2KhLiRRh0yz6bxaZ6CzevDMTKKsIggxg
         6qYDUIv4aM/5tjGXcexy4XjGVEpG7mlil7fwaF8d89jGv+3Xmy1l3Cmjf4lYJnthgzQ2
         6TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368945; x=1731973745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuWHSESvZxScxt1gtQJTtWY+NoQXodLd0kknM0wzZSI=;
        b=EMz4Ov90VWQaomUvOx/t95hgQeu4u6rOBLpImUHx96ajd8/dxpKMmO0YA4yaEslVRp
         2duGMKM2dXUk/6e4tXpiNkEBXdxvZWG/RFD0zYaF9VzhvBBQj8PRvB75gbDdn2GQG/GJ
         SQwSDwnLEd8XIK1i3+F0vVXrzscI4sEZ14wTJFiTRsK+2QGZevYyTc3uNVhMid0c9/ix
         74LE67LFVNK1XYXvlM6Ej9V+e4MsH5apP3BR7Hv8GLNg/pv4DZ9tSiLcdJ6J8rtAYZ2J
         aIXl1Z/bicUNrWfXpLEs0WKauKf4FCdMjTgf9wiNevV2FD6v68DFePL3vgH9kM+KST7P
         UMrA==
X-Forwarded-Encrypted: i=1; AJvYcCWNL+Jr2bkDZ6lzmJLYQr6stpAwW7jtAd2JEJjSKChrTcUpGEIL5EORk1k41Vn73RMkFosA25zcBnvluj4I@vger.kernel.org
X-Gm-Message-State: AOJu0YzvO1zGnnW9wdI5iyS0g0+/W65lsLXAdLoBItoZUzLvZ5Vqmoye
	N65Nq7QKikmykk21jqR+Ek2MvKwKM41R/uqBb/N/UuXiyrm/A6KWUhs4Av0pCcU=
X-Google-Smtp-Source: AGHT+IGY8U2EPa5TOjOCgJt8zYCC4on7T5T+FZCdrixkNsVQpkNRkQsZMbpHQUFVB4Pf9fNlDncpCQ==
X-Received: by 2002:a05:6a00:22d2:b0:71e:755c:6dad with SMTP id d2e1a72fcca58-7244a4fdea0mr1056066b3a.5.1731368944673;
        Mon, 11 Nov 2024 15:49:04 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/16] mm: add FGP_UNCACHED folio creation flag
Date: Mon, 11 Nov 2024 16:37:38 -0700
Message-ID: <20241111234842.2024180-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers can pass this in for uncached folio creation, in which case if
a folio is newly created it gets marked as uncached. If a folio exists
for this index and lookup succeeds, then it will not get marked as
uncached. If an !uncached lookup finds a cached folio, clear the flag.
For that case, there are competeting uncached and cached users of the
folio, and it should not get pruned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d35280744aa1..0b298e81fcae 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -741,6 +741,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_UNCACHED - Uncached buffered IO
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -754,6 +755,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
+#define FGP_UNCACHED		((__force fgf_t)0x00000100)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 0d312de4e20c..0949f0f340f5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1985,6 +1985,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
+			if (fgp_flags & FGP_UNCACHED)
+				__folio_set_uncached(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
@@ -2007,6 +2009,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 	if (!folio)
 		return ERR_PTR(-ENOENT);
+	/* not an uncached lookup, clear uncached if set */
+	if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
+		folio_clear_uncached(folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
-- 
2.45.2


