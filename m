Return-Path: <linux-fsdevel+bounces-53932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAAEAF902A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0D06E041F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587732F5310;
	Fri,  4 Jul 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt8up5Ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0732F50AC
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624756; cv=none; b=l9f6B0FTGWpsHJ1bIqT4rLSV/ztrmZK7q/1/33na0pY0o1BiW5tGIua7uYieetb0tWw69jyWpVgFvK0n65oU2ZimUOWT5lwrCsOxts/pDDLM5V39HP/7ByuiHo+jQ5+2ilbLXpap5fZUMOJSncbmCfG7voHira9IGrqYEFCEpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624756; c=relaxed/simple;
	bh=cpXSWX6aTPOh+pmlPrRH6DoAXsk2bYocWaGA0TOO5Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr7DyO9kC3oXxZZPODhFAVSdiun3Cma87p4Mx1Kra7eOSoTSIG7inHSjQnT0T1vCZH1rBTZFIKH6klElmqr7xryF5h42rVrgB0nLirDeXKRVpm8zpsmPLW6CVXew3c1wBC7ukO9Bx5x/hzPO+myjGVasThiqpJUMPeYSZM0lY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xt8up5Ay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVyour2UNFNS7aNaSR0hE5hzdL3B1bhwCvX/GUFQiSw=;
	b=Xt8up5AySavAvEx9qxpOwNV+rjLcRshFO/bPhWiittVu6T+GKAft0tNbaeQbj+nK2IJ2nW
	zsMOcs0fUd6lLaKiXBR6aQ7qmeDYHPSmg13HTsSCT+cmoukZNXrCT/sF1HODYn4QhAi4MO
	Z1vvwfj8EMAIQ5P90QxyuBF4E4BB9L0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-uHSpDNZDN9OXQwbpU8IfsA-1; Fri, 04 Jul 2025 06:25:53 -0400
X-MC-Unique: uHSpDNZDN9OXQwbpU8IfsA-1
X-Mimecast-MFC-AGG-ID: uHSpDNZDN9OXQwbpU8IfsA_1751624752
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso4614285e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624752; x=1752229552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVyour2UNFNS7aNaSR0hE5hzdL3B1bhwCvX/GUFQiSw=;
        b=Wsn3tCjGFcYUWWFtvvkajVmqI8ar+rJVFXZXUulQDXzI1PCf/kAA1ujZPx4BWVdqV3
         WQxNCPxLiLmLH/o0U3n/n9Zqt4sG8srQzGD54tZcwVgHeV4Um0lZ26DXUiVcqkXjwizT
         KEsJv52W8SOOB97VYHx6fb2r5hB9CBH5q1DGB3n7Y2/e9mnOZmhhKptMP3Iy5W4nXIga
         3sbX/6WPRLlparasWe+daHPnXUYGLtEZHo8N0C6Z3tjcP8aP/NSBbMdoptmyEi6C4i0a
         GpLTMglth+hIZ5ixj1/kdx5RikEq24sJnNHGQO9tSiAeaJsGisA/SUW19p3NgEyL170r
         6XKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzmGlmmattvSR1Xd6MMyryTcJr3rgT9+4DcCa3MgtzSXvuGctQEmEzMU9+lsbRj/2M9ip3v03CCYTyCr1I@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxHHI4sfLd8AEuWXFKwjW0Es96tbLG4CiKw56nrgVGztUkIkT
	EF2Zfb4DaH++TiTFGc76fOx90dRc/4e6cO/fcclTJhtoRqvX8OFejx/mFCVeTwnH2JybB1KH+Um
	hVVsrBSeqGIkSMZD8xFJ0UYRK1UVmwbGGTLZ52rK2L4kap706u7ENueNgbYP8Vdcu7EM=
X-Gm-Gg: ASbGnctcfR5S6b/dymSyhH3xaN6e/0XnhYl2ubmnhk3bOhFNLfLPcJrmj16H9pCqnjv
	bgdcYnDj4kCroKGD0ObeMEHKqMOclep48cjZjSkhI35IIL5SBpxtIq+QWSpT9ebUhaYY5fNsSj2
	yQHSHBy62wylmAVQgJvif27uy9iXildX8rNTJRjSLJft1AEMxDJW1ubwFSxO/IdQeg65bNJQZgp
	zB4VPXrf9UutKgLqEWfvoROM5+AW6vA9DRtTjHKRk9Uadc2TDEKkMtgFItXFDAi+l+PSmvks6SU
	+Xhg6rlDAUmN8x4Pgu6LqUe8MxtuJRdmXj/Yl9297o7yerrpL18XZm/IbRY5r4BBtvpUdnwh9Nq
	XTPl4Hw==
X-Received: by 2002:a05:600c:4f07:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-454b835631bmr1456085e9.14.1751624751526;
        Fri, 04 Jul 2025 03:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Rez8KVGPQFiDbU29hzAgNjBI7xFdtw4twkMv/+PHLeFt8+nZnPGBAy1buVfR9Z9nLRQVCg==
X-Received: by 2002:a05:600c:4f07:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-454b835631bmr1455215e9.14.1751624750855;
        Fri, 04 Jul 2025 03:25:50 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454b1634b0fsm22804075e9.17.2025.07.04.03.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:49 -0700 (PDT)
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
Subject: [PATCH v2 08/29] mm/migrate: rename putback_movable_folio() to putback_movable_ops_page()
Date: Fri,  4 Jul 2025 12:25:02 +0200
Message-ID: <20250704102524.326966-9-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
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

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2e648d75248e4..c3cd66b05fe2f 100644
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


