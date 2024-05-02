Return-Path: <linux-fsdevel+bounces-18479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49B8B96B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247AFB2373F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F045552F92;
	Thu,  2 May 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USIXoz5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8BF51037;
	Thu,  2 May 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639638; cv=none; b=VvW1ZfbLVzKLTh8kD2JhohWNld1Zc9hTYIFvwumntiIyaedaaPlS30LpmmYuWpH0bGILWBRoKR5wr/jQ1JrajkW9DiIwA/UQCYCZ5oQ8pJpCfId2NgtDaSsAXleVd7Hnk7wv1mEJV75CI15XJqj6TbbpYfbZOmy7g3cQaM02EnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639638; c=relaxed/simple;
	bh=hDlPxTRmPzQHkSl/lYkJK+GDIbLDQq8I/dn2VuGCZ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfiGt1ZwCrcai3YAO0nvxyxPpLG74XrcPWEhrMaAyYjOCARxNzc3XZTA4ahoWkX9OQTbANEO+QWlX6hGgbaL2YO6WeXqMw2vVWFea7yFfuVZWCET5G9QRuJ/qhXI75HOSAx6/TROEXJUDk/7+tE5GvnfXl9VmckRJn5Y8LKVkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USIXoz5L; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso5833300a12.3;
        Thu, 02 May 2024 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639636; x=1715244436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=;
        b=USIXoz5L7aQeO48zQYbJ8D9WH4ebRtl7/H5hFbpZm9stkqUbCBTdhHmw+KXqavbzai
         D0yQWWw0PfGLf8S48HKli5X7a4Rsdix03X7QH9ffyOc3zLm6FJWjNCJXq1cLfDkgfmXP
         wB0Zpl1JQ6rcHlut3t/Qij1G6XNCoMZAw3XsovXXMKUFdDuX9xhgO5/ni1JxLx6cG4sW
         w+N63RBAnLovqv99VYnG/xupFr+GbD2+I/gZi67Gx7nSkLYAZlCK2D/saQ9QuEQJcPso
         AdoZ8h+Ac49vh06Gjp70nIKskvFUIIuhFTyHIwJXv+aa+QlAO8a1T+tC1EV7WG5puTpu
         5mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639636; x=1715244436;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSvD/YVvY3oR/SV9lrJcxmGa9WfASg1z+eMVQdwymCU=;
        b=EIT6xxsuRcEp1zEbZ3yXgjzDwstnzfB69OfDz6lAnIQBQdhAwNheadHJlOUkRkC1pX
         S1nTPAGqiWpMoPP9mI3neq9CWxA1EcJ6WTga4D47ZHw0tYv5oAJBsb4euCnGD958LrNF
         sz58Td4/FqdJBiyfRjjZIe7z6L72va5/oTt35pD73mvDLWVE27623yd2dAoQUNtbusCz
         Mf88guIinli6Kvva63Cis5QvxUXlGk4m2ym9rJAZBMWWWc9bFchR9loX1+8omGJXSQI1
         IUG5ClPOidxF69VACheijmDKnoheIKWbwLxoOtexA66mbabP0Ffs71AfxdUhCFH3NH5r
         Nn1g==
X-Forwarded-Encrypted: i=1; AJvYcCWrbH0eG6QYqvYnu9RLGfmtJ+zOUicBjBEu64UiomjeT4KbxXDfz4XDBqXRXpp4kXOvTIzE9pJEyzk2OiL0lUnz3X2M6uPLmBRSDY/UPAfqWF8Un5EShJ8iONr6in9TaCyBNL5eZLaTZI/aog==
X-Gm-Message-State: AOJu0YwCjJ5tE2yzjsWiIoiOl9smO47wkLLqGA9yk9DDguDZvEc9aqz5
	iVnced3YW5Zrj6RNU9gGql/8mDvvibRJcuCYFkD4eORcfFcKIpe+
X-Google-Smtp-Source: AGHT+IHHmKPYxmQ1NnctSOq7P493kmk6LeLXH7PC/dx0NjjiKoIYGnc+kgONRssyDz3JCfG5GAiMeg==
X-Received: by 2002:a17:90b:50cc:b0:2ad:da23:da0b with SMTP id sb12-20020a17090b50cc00b002adda23da0bmr5630235pjb.34.1714639636249;
        Thu, 02 May 2024 01:47:16 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:15 -0700 (PDT)
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
Subject: [PATCH v4 01/12] f2fs: drop usage of page_index
Date: Thu,  2 May 2024 16:45:58 +0800
Message-ID: <20240502084609.28376-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502084609.28376-1-ryncsn@gmail.com>
References: <20240502084609.28376-1-ryncsn@gmail.com>
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


