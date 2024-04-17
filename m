Return-Path: <linux-fsdevel+bounces-17162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA48A887F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A331A1F23812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496F14883C;
	Wed, 17 Apr 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g97zxKK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE2148821;
	Wed, 17 Apr 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370194; cv=none; b=UOIN4ki9D5x22TibDaUrRQ86BmbUPggo1Tr1STsU1I4wOw65ou7PfgLzDehUwZeblDf6VWOgJjo3i4DEcKO8P+TCBVfBcdzrYYsMiLlaYw/+qxtsBVwgi3+GdTAuv21eTlgZOBIH9JoO1K52tgZsjA5J4PXtaTkAw3RTlF1D6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370194; c=relaxed/simple;
	bh=UaTaQyDAPYJXzxuGE+S2wWuP7fLVM+PYcfLn2sBx5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlTPIxve2ItD0jWT/DOnbbKOmNBr0DrIVPk5vM5OSWK7jzhKskpOjP8fLczpFmndMR2hcdgAoVkyIs4/Y5fGt9hmkihX7lYbCIcrYfOLQMW9Mz3ZA0o1zIfrhcK0QOJyIja2WaO7M9W6yoQSIAto1FQ7taVZQmkYGqzBu/JjkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g97zxKK1; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d5e27eca85so260990639f.3;
        Wed, 17 Apr 2024 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370192; x=1713974992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=;
        b=g97zxKK1wtWoSsmpHyXzBUATjRO3qORf+hY5Ih9b4KYbLmH+NdlQWIXXkVan3R1Btu
         4FIktFcJl4AZDeeM014EY+uvUJtlVyG4XaBby+5Ieb2mfS81zFq052EqOcSTcnrJjUyK
         dAAAMfOvFnd84o+mI5eV9JUcS+V+svcYntAqauy9RmVIX5wqptBuAo0lC6msdJQeKdnc
         XyCsG2RAeAMkBDqlWQwzgLKiJXLM3Wq72lpMhpBQV7gRStarobJYR8eGmivI0lylPQKL
         L3nZF3GJySzAJ2zTf2YWL0VjxOA3AOm4nyhK/Yow+M1UbJnCEGMoSBDpEZlX+WN0RHxy
         Y80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370192; x=1713974992;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=;
        b=YoKOfd4Yzz2yuKyTSh3dKS10dx62NQCP4nTgf/Cjh6EmPdnP0piSEryAIgGgINMRIA
         nNWK/Vp2zXFQaQQrNuPV32v2lxfKnTA8smCY3JdhTnxI6P7BLUAEFFMgyww3aN7cl75B
         nCtDL56VYTkx5ZXn2JIyENokGxzEowKWQyMVhOv5msDRQtRi86B4cR9dYk5VwEyhdNWB
         WvwmCVj60WgjvLDtGwX8QFKz+axaHVqSkH+BYXRYqR8UM3gW4sGnB/vzd7cNeOgbbffB
         S7U2e8Iyj3a2f70nwpeSCNxbKYmXmxSZhBqfuqQrJkyW9Gkq4yFAnsUtVCC8W6lRr3nL
         AhtA==
X-Forwarded-Encrypted: i=1; AJvYcCXHLAZH5SgMwONWkVFE1guPAN9uy6PxkQsPZt2yQEqEi6Db9Vu7YDl7nw1lNEbKl6zUlSRT1NJAx548ZRDUeD+y6bCaBmWkmpX/uoyRw5n7/2N3u9dT37Q5DfJzuIth6+YpKCcSfkwTln+3IQ==
X-Gm-Message-State: AOJu0YxVqaprX5cOj3ZSm1X093oEXhVU31zsoZLm2zlIBTrM1VN/1f8o
	bHXwuVy5gtdVpOaxVRchOmAk6gU5e/ReUk/en2tXU272rUyDIlWw
X-Google-Smtp-Source: AGHT+IEpyaQ2B9laiL5Qz3xq+OgAsfHl508IHieRw4jQK+zsxfoW9aDncD8KQfXYdlyhnJK/CywmIw==
X-Received: by 2002:a05:6e02:12e1:b0:36a:1e27:1708 with SMTP id l1-20020a056e0212e100b0036a1e271708mr18563457iln.25.1713370192373;
        Wed, 17 Apr 2024 09:09:52 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.09.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:09:50 -0700 (PDT)
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
Subject: [PATCH 3/8] f2fs: drop usage of page_index
Date: Thu, 18 Apr 2024 00:08:37 +0800
Message-ID: <20240417160842.76665-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com>
References: <20240417160842.76665-1-ryncsn@gmail.com>
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

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..12d5bbd18755 100644
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
@@ -4086,8 +4086,7 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
 	unsigned long flags;
 
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	__xa_clear_mark(&mapping->i_pages, page_index(page),
-						PAGECACHE_TAG_DIRTY);
+	__xa_clear_mark(&mapping->i_pages, page->index, PAGECACHE_TAG_DIRTY);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
 
-- 
2.44.0


