Return-Path: <linux-fsdevel+bounces-20021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712F28CC7C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05F91C20F45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B1146001;
	Wed, 22 May 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upkC6KFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552F41A80;
	Wed, 22 May 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410238; cv=none; b=SjjP76w1iZkYl852VZENzaMfEjVLxG8UHcG0lDy5eYDfIaY3/nsYkJ5EZHvQ7o9Id3jHQTBoxLmmipxqragU4G0cDF2ySKsXu9dSzvlJe8ZvcOSfENYi2MMVaFksX9o4SZmL/Ck0C+LskyLKhSKyOWRFdCOqDm7qyGLX6mfWIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410238; c=relaxed/simple;
	bh=VcM8F2FPLqzgtpHQvCPz9zqv6y0dtpdMnsnBdC8UywQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIzQ8m6ueqUcjQQ7+HYHsmkonXgPozKmwLiA1Gay4Ailh2343l5ZakJv46eE4u6HNrEaBSyqm2vgnHrhkjNLVVQ8C83Rx03KMX+4emuzp+p8piTUcTm36bgXHZMX5VxuZUYsMa8yJxpmjZnMemA7/Wn0iHLnC6n0iB5aFoo57dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upkC6KFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468E2C2BBFC;
	Wed, 22 May 2024 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716410237;
	bh=VcM8F2FPLqzgtpHQvCPz9zqv6y0dtpdMnsnBdC8UywQ=;
	h=From:To:Cc:Subject:Date:From;
	b=upkC6KFDmfHYP3VzMMaSBzUNcNOZV8dVkWBbvXfSHMVVk/Za3Bqa7oCWE2YtUuRkL
	 Je5IR3rwMYRUJmS8LC70S+eryHbpt3YhtB9MOUbRsykdlYCoJTCUhbhDa0Zg/uToIJ
	 5clW4PVneaeUKUdtRrYMlzCcoeTqQsB6AqWNVflJpI3vzj6LDVPO1IUHEsraMPTgLI
	 v49xzLirxN1HmUQRN1Jbl5R6s17WSoDkg9u5/fZP0FS7Qfx2oJrFpo6Q6JzUEwUlza
	 ZO6ahD55PUDebcaD7g79cIDGY0oMo8OoXShl24wiAskDn29n8XZjso+fZdt0yvHusi
	 5QWAgJs+pPxRA==
From: trondmy@kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] filemap: Return the error in do_read_cache_page()
Date: Wed, 22 May 2024 16:31:14 -0400
Message-ID: <20240522203115.27252-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the call to do_read_cache_folio() returns an error, then we should
pass that back to the caller of do_read_cache_page().

Fixes: 539a3322f208 ("filemap: Add read_cache_folio and read_mapping_folio")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 30de18c4fd28..8f3b3604f73b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3812,7 +3812,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
 	folio = do_read_cache_folio(mapping, index, filler, file, gfp);
 	if (IS_ERR(folio))
-		return &folio->page;
+		return ERR_CAST(folio);
 	return folio_file_page(folio, index);
 }
 
-- 
2.45.1


