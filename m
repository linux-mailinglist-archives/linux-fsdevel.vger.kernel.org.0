Return-Path: <linux-fsdevel+bounces-53346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA0AEDE21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D617A06D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBD28DEE5;
	Mon, 30 Jun 2025 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F72IRsZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769BB28D834
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288462; cv=none; b=JrHPMNX/KDZF5byOXNEW1K5zVLhQu8moAQFhgomJ18uvEHYlrDnGWKQqHX8mZJXUeMnU0sXDcuzxumWuTY/WxCID5qFpXI+srW0EFYMJG29R0QaLQiq7RAaBJtC9+eBkNzgGGOaZy5kArmCrIU/T2y/KFBJw8BqyBYEOAAtYdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288462; c=relaxed/simple;
	bh=h679pTWyf5chDo0jTdgc5eTOddfWMzqMz/6J3iuD7Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh1v3zKcY0QN2QHG7R26mUxZvtvLiTBJhv17cBdnzZAm/U4pnhj6hBDRha8Thvkj8PYWwQcmY/H9KUcRUP58uvaVErtyiI6IP4d650b0u52M2rEL7f1CiRbwKEtOoj+gCzCGV8Hq8sbDWokNoSpWaVh42qk4QnERhAXBg3iJV5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F72IRsZh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZbSryMy27xk/lWuJyIeQilPAEeTxdVw8qHGMwbITkw=;
	b=F72IRsZhgUaNCQ9KWEm2+NjuXmOBC0FC77Abp0mvaTwo3LAynBC0Kr7G3lNezokosgTQe7
	DdH9SBclnBNmF9hc/y58rbrJAUNMlP7J1hIkNL79EZD360c+S2QvrQwjm7Fnlwyeib87QH
	MdPl1hME2rHM2+wOJWTKkiFjLXMjjq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-9ngoL0vIMPqSdx0QUzif5w-1; Mon, 30 Jun 2025 09:00:54 -0400
X-MC-Unique: 9ngoL0vIMPqSdx0QUzif5w-1
X-Mimecast-MFC-AGG-ID: 9ngoL0vIMPqSdx0QUzif5w_1751288453
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so1983420f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288453; x=1751893253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZbSryMy27xk/lWuJyIeQilPAEeTxdVw8qHGMwbITkw=;
        b=k3+jIs7YK86il50dGCnyW1vJu5C3xvgz2zmf1An1ZVZM6uPJC0KBgNME2IR0MfSY/u
         1rvpLflA4U1T5XDSL2Jk3fIwnsw8xF3hXyi6A8DhT12YgdRLZE4KCRP4px9jZmVpsTo+
         EUYDs1pMiAdNZZRo1lyz/TbuhHg2n0UIBoor7n48iGSWTVIpS+muYE+6GCmb1dL3m9vi
         UE4Y7sq6cKDrB7bmzVtw11xGR+J3bN3hfcV5o7TI0Uu9/uhz1P+uxKqoj/7S2SvI/a0y
         EZQ6JdvanJLjqMxzzl8GvFvb+n3mz/DlkLTy8fGljcx7lVkhEP8MNrt+bghqZDUWU0qT
         zqOA==
X-Forwarded-Encrypted: i=1; AJvYcCUeyCjzHUAMYbROMRUC/fEz1zlrJ8kwbW0Jo381nVZLqTJmz6c7g2LyKMDi1WUGPIkt+CvXMNiY3ZTHyAt6@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjrCtBZvvLWqU3HvC34UQcWRg+TQ9mXjAvxWfsrjSurVovOwJ
	pnxB46+Mqn2R9OTjc84GOzLF0iGcX0wLgGtHQZF7mSrjeHxNjXJneOTBPqSg2TAj+3MW2DDrt33
	aidAOQsGjcEPPJkmobvMKuUflRP9R9Jpv7QTkzKrBEUWGsG2RxOAUmTXDce0tkr4awBA=
X-Gm-Gg: ASbGncvmPUQBKyHWKUr8MvR/+05O52XnTi1X+3Z7jK1y1uVP2sd5PU3Wt9aPCQl8xKU
	EiDFGXVVPMAaTFeui3f+pU9IT4GjftlBQL2AbpgOyeOeZLL0jEy8mpERsi+3mcB7vHesusp9JOh
	uZ7V/atV9uuXH6a86XjPa7fpoKlrjcwJDjiDBCLF+9RQWhVlvs5COT9+U2leggip72ChtQW0MyH
	7IaX5mAH0aSBJT5vOibmBN0aOy0UDF3lL4L+cwaSDsnmZXQ18dqkn2PGxTRM6lT7xgPKylp88fp
	JYv23cvMcFbrVgFchooK/WzNC/6mreHW38uImFSJUyqerm73ZwjXEbeJaZ83qGlDGTT+kumyB51
	MPov+HUk=
X-Received: by 2002:adf:a143:0:b0:3a5:8565:44d1 with SMTP id ffacd0b85a97d-3a8fe8917d5mr8134455f8f.25.1751288451765;
        Mon, 30 Jun 2025 06:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHR74Vg3fOLDK1bhOkeMb0O7J5iWXrvKqq6qclu6yGGjB1xdv/xPEmRceAckepewzfNXHQQ==
X-Received: by 2002:adf:a143:0:b0:3a5:8565:44d1 with SMTP id ffacd0b85a97d-3a8fe8917d5mr8134296f8f.25.1751288450453;
        Mon, 30 Jun 2025 06:00:50 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823b6d50sm167133055e9.30.2025.06.30.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:49 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 13/29] mm/balloon_compaction: stop using __ClearPageMovable()
Date: Mon, 30 Jun 2025 14:59:54 +0200
Message-ID: <20250630130011.330477-14-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can just look at the balloon device (stored in page->private), to see
if the page is still part of the balloon.

As isolated balloon pages cannot get released (they are taken off the
balloon list while isolated), we don't have to worry about this case in
the putback and migration callback. Add a WARN_ON_ONCE for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  4 +---
 mm/balloon_compaction.c            | 11 +++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index bfc6e50bd004b..9bce8e9f5018c 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -136,10 +136,8 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
  */
 static inline void balloon_page_finalize(struct page *page)
 {
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
-		__ClearPageMovable(page);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
 		set_page_private(page, 0);
-	}
 	/* PageOffline is sticky until the page is freed to the buddy. */
 }
 
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index ec176bdb8a78b..e4f1a122d786b 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -206,6 +206,9 @@ static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
 
+	if (!b_dev_info)
+		return false;
+
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	list_del(&page->lru);
 	b_dev_info->isolated_pages++;
@@ -219,6 +222,10 @@ static void balloon_page_putback(struct page *page)
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
 
+	/* Isolated balloon pages cannot get deflated. */
+	if (WARN_ON_ONCE(!b_dev_info))
+		return;
+
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	list_add(&page->lru, &b_dev_info->pages);
 	b_dev_info->isolated_pages--;
@@ -234,6 +241,10 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
+	/* Isolated balloon pages cannot get deflated. */
+	if (WARN_ON_ONCE(!balloon))
+		return -EAGAIN;
+
 	return balloon->migratepage(balloon, newpage, page, mode);
 }
 
-- 
2.49.0


