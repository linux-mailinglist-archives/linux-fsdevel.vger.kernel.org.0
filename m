Return-Path: <linux-fsdevel+bounces-53340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29663AEDDFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92D117B14A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F028BAB3;
	Mon, 30 Jun 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBu0Z+k2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E328C03D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288443; cv=none; b=Dq49zfXsEXb54r/W1C1mdGZpJdw5GUJU/h3u7Vt61U16ovj0tbHK4pGeB6EQgp6AWNzOWIzN48iZgPT4cGG2qfjd2QeNp5yEHsarOHi/wIrCW/f3THDYTlwP8iVydiGxC4UH17cYCPVDZvFdRDlQFPcnQvfISRuLXEhbCOuH1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288443; c=relaxed/simple;
	bh=QFR4ekfQkxloQewE0nsmyAbq1SFLKM7czL9sZhql/lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMFTrnCpIZX0dHfsML8Quyl3kjtTIeLE7rp62/xXXp48SJdD7m3uC17145eXKTbxEoBMAM1P0bwIiVlZh9RpohW5JCRRPGMgIYYSlLAdiXWT/9ifThLBTDclTPP6MLoezdrUpx5svI8KdJxgF9IuluwpdVAZOIGXTHMlrFlgXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBu0Z+k2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4HyaliWLgvplqkgqKCCNJ5/P2ZKVlm1Wsjs2FxXnxE=;
	b=VBu0Z+k2OEwZjE8+15r0UzZCWBFuL4CaxBLpI74DD+VfPAGB92j8EGt79GkuGhGhbqCpBo
	Qtop1APguq+TkX1Sv1QtLA+i0rJ7HgxyufrRWujyTUzG8UV8vz5lAx4oQbtp3GHeGDsOCL
	OEKZnE3+E9woAcmisfbpfm9bGI4gxrc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-x1t6OmnQP0KqeIYTgzc84A-1; Mon, 30 Jun 2025 09:00:38 -0400
X-MC-Unique: x1t6OmnQP0KqeIYTgzc84A-1
X-Mimecast-MFC-AGG-ID: x1t6OmnQP0KqeIYTgzc84A_1751288438
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6da94a532so1367746f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288437; x=1751893237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4HyaliWLgvplqkgqKCCNJ5/P2ZKVlm1Wsjs2FxXnxE=;
        b=m63xSSWt+Xtve8j9nJ+RSgS9w5J0hARavFeuneO6DBb1zuHn74Hd0Y6BiYumjhjl0V
         LqL0gcFgwJTHZLDJl6aFuc7UNum1eNvpErdpFBu+r/16czGQV7Bo7OP1jcZG/aTeHZ9H
         UAh+wl0TtIn9Vf8nxBSFmZtSl1cO4g8grQhA18kxiYDqpo0WlTliIAqs3RlsPplh7zVW
         MVBgoNICVQGY6AousSE3gGTotSw2n3R3ruOUKiuhZLRPZQRVRPdMH9Hltla2ofNrO9Av
         0pG6FtarYRCbd94EQzPPlhsOm47xka8+UHxRmhMw7zXPTZPDGp1erly3uxNk+g1TyeSP
         u1vA==
X-Forwarded-Encrypted: i=1; AJvYcCUcKPVOFHQtZcyqBEv2ZHeXygNVnrMPFjoMoNasxnDljnqb+3tqJnrEQz/2qAUfJKLTE+ATXTSPYzuTvrZw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2SYJCPPiT/VAsvwPIGcHAMVVNcLgb4ShCs6TOS6dsnYRoXow
	PxaQ8IVrTwwYxwBG53jg5s//fGYvIEEJH9fg8u+0d/UUa4RrIn3UZ/791FOmqIIQOf7icbBeMP1
	yc+eCFhBRtTFNJz6qZYJHSzIrX5h6apzEoHmm3eOOKdOVh0rRSRVvLWNtYT0xM8L5WYI=
X-Gm-Gg: ASbGncvmn5bltupLlIXSNrvAB0mDmGVIkZCg/FVYBTo/WOgZdVmF1DKT5IltYdv1pm1
	ZKBbGrzcBw9s2J3yxFDjtFqcOixevWM1uFN5+hUYl+pMdiTebAsjUSrzk25fYZdvrbkOv7ml+Va
	Ld1ln4nZ6HJGkjtsL6J/JzWF36wSgpFujVRIOmDqFwwX7fJxo+qnY6q/taVtU0yMCelNnJrs0if
	kxaPCPLSON1TKHsJgNyJtOeJ9kEpJaMrNvaU8X/HrCAZj48o3c1ZmoDinW2qirUex25VcP457ot
	zZjcPTSJZrMlqOg5yzMFY2u5GAChlxkyFj0RGKRx9XmNWRKOfOMvXnFrzt1b+lOjmEcWl3xcdrI
	Ld1kRgKQ=
X-Received: by 2002:adf:b649:0:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a8f45494cdmr9830776f8f.6.1751288437420;
        Mon, 30 Jun 2025 06:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEehlYPXkAQhWmsU6NKWbFkXt51tuHaEnt5gEo+HlKa0FWalrdKbSodH+fk72qwn9YuXcO6g==
X-Received: by 2002:adf:b649:0:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a8f45494cdmr9830683f8f.6.1751288436787;
        Mon, 30 Jun 2025 06:00:36 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5b2a7sm10408982f8f.69.2025.06.30.06.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:36 -0700 (PDT)
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
Subject: [PATCH v1 08/29] mm/migrate: rename putback_movable_folio() to putback_movable_ops_page()
Date: Mon, 30 Jun 2025 14:59:49 +0200
Message-ID: <20250630130011.330477-9-david@redhat.com>
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

... and factor the complete handling of movable_ops pages out.
Convert it similar to isolate_movable_ops_page().

While at it, convert the VM_BUG_ON_FOLIO() into a VM_WARN_ON_PAGE().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d4b4a7eefb6bd..d97f7cd137e63 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -133,12 +133,30 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 	return false;
 }
 
-static void putback_movable_folio(struct folio *folio)
+/**
+ * putback_movable_ops_page - putback an isolated movable_ops page
+ * @page: The isolated page.
+ *
+ * Putback an isolated movable_ops page.
+ *
+ * After the page was putback, it might get freed instantly.
+ */
+static void putback_movable_ops_page(struct page *page)
 {
-	const struct movable_operations *mops = folio_movable_ops(folio);
-
-	mops->putback_page(&folio->page);
-	folio_clear_isolated(folio);
+	/*
+	 * TODO: these pages will not be folios in the future. All
+	 * folio dependencies will have to be removed.
+	 */
+	struct folio *folio = page_folio(page);
+
+	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
+	folio_lock(folio);
+	/* If the page was released by it's owner, there is nothing to do. */
+	if (PageMovable(page))
+		page_movable_ops(page)->putback_page(page);
+	ClearPageIsolated(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
 /*
@@ -166,14 +184,7 @@ void putback_movable_pages(struct list_head *l)
 		 * have PAGE_MAPPING_MOVABLE.
 		 */
 		if (unlikely(__folio_test_movable(folio))) {
-			VM_BUG_ON_FOLIO(!folio_test_isolated(folio), folio);
-			folio_lock(folio);
-			if (folio_test_movable(folio))
-				putback_movable_folio(folio);
-			else
-				folio_clear_isolated(folio);
-			folio_unlock(folio);
-			folio_put(folio);
+			putback_movable_ops_page(&folio->page);
 		} else {
 			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
 					folio_is_file_lru(folio), -folio_nr_pages(folio));
-- 
2.49.0


