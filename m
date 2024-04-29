Return-Path: <linux-fsdevel+bounces-18166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467498B6198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0100E28149B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278413B5B5;
	Mon, 29 Apr 2024 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXZIHhLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56E13B292;
	Mon, 29 Apr 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417613; cv=none; b=Q82980/6epVuwscASfxjnpkm2OMjs+1AYy4y15Cwz3pmlDSzdmbepRIzVaLUH0Hvo5dNz7NpEV9jPw9mIgbyeCv7rV651o4NQT4evoJZGctzrbU/yCewDMEiH4VoonVAJqnCHoaITP98qMue99gVlB7PUhNLTJlJ9nYAIZk3RIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417613; c=relaxed/simple;
	bh=hDlPxTRmPzQHkSl/lYkJK+GDIbLDQq8I/dn2VuGCZ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lghgKr5FMYBqjIovdlWnysxFc8QeOE67RjdVgIHfJJIV3Gp2MD3RkaBbh9Za6sr8zdPyHGF7BTNqPEatiLV5e+xDwnlDLaT1pq0OLx1W5cv8dJVJdy64N5kbXjugIGPDDLUNV2PH0X2SJoOb4MPc0ygTOuPPSgkVKDP1mAHxTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXZIHhLr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eab16c8d83so38643555ad.3;
        Mon, 29 Apr 2024 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417611; x=1715022411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=;
        b=aXZIHhLrZeNyFWhKGu/8Mw804jf9yqvaXYPvKV7DwUfDeCsQe7GJWrbKK1JbsKi6ds
         ePz9vhvNr2Q+Q5jgKrjlOPyEXM6uSECUfIbYteeWbM9E6eu1XuU6S9QMAp2ypF4SHFun
         UbfvgO3EBtNgy8/UdXGhoGA6GtiBA+TgesXCqwlCXNuFT1yeKsaGwGAGIFOXhgWyQXo0
         g/tOcxstKUVTYKIeceAfI7V7BNbBstfoLkHDP9mULKG3vKdmfVrBN9m7Hm2tJa9osM5w
         6y8WAcY62czY7C/VqfYUndSCLlhZfIIZzUsQgE5o7gwR0z4ktMPUBasarXMUQnFoV0Hh
         gWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417611; x=1715022411;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=;
        b=NJwoYoRjqTjXkkzYE0NbKmF+K58Z3wXG+DUo25atu6GbMWTjFs4rs+9UmWkym3r14i
         kHs6RygAstL03m8EShW+fiQINaH/Nt9XoM+vs4rYt0DsVsgRsLkcpZcDrXJiDEL4SinE
         7gDs1comHV0QPe6yjGG3hcMGkBW6toYC107b2vMqHE5U6RFS97pLK3WqhBFoi42uTvXo
         M3aQMOgh4r03hhBpSpbz7nADK5s6d0EVrFgan672YDI73OdGHLYGdN+9DiNezDCX2F2v
         f/lh7p5PoucS49dMWPKCK+bRjBn4zWH/exqy9nbyJUQgpZ34+6qkbF3uHYg6z83VQ1kl
         SpFA==
X-Forwarded-Encrypted: i=1; AJvYcCUkXNr0WfkrGDd/iPlzf96SmPOY+yZ7QRpRj7W2/vuO6Yex6lFFSTrZjpYVaMrwycJA2XVVQbQm/7yYWo47FKmKs4vgNQEsq88dxSSDgpusLg3N8EAJiZycUgyiRDc+NCzl5n7URUC/mM7xVA==
X-Gm-Message-State: AOJu0YyKojKu1ucJnoOOJM5bjTkQHvSJ+TloikBPRqQqqnE9l4R17RLq
	jjggpa+oRaPZVN70rYqHKg5+GJCagiNNrHaT72lCUU3Y9VfbAhD5
X-Google-Smtp-Source: AGHT+IEWWyXjXq5qxQK4Wj2h+dXwYC3HBxH2tY9g+B+mmj2ONuL2mZBA9D6pxjlnJqOR4++MfTCr9w==
X-Received: by 2002:a17:903:1249:b0:1e4:b1eb:7dee with SMTP id u9-20020a170903124900b001e4b1eb7deemr13466540plh.47.1714417611389;
        Mon, 29 Apr 2024 12:06:51 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.06.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:06:51 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v3 01/12] f2fs: drop usage of page_index
Date: Tue, 30 Apr 2024 03:04:49 +0800
Message-ID: <20240429190500.30979-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

[ This commit will not be needed once f2fs converted
  f2fs_mpage_readpages() to use folio]

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 961e6ff77c72..c0e1459702e6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2057,7 +2057,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t block_nr;
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)page->index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
-- 
2.44.0


