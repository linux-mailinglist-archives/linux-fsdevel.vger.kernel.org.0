Return-Path: <linux-fsdevel+bounces-53345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FACAEDE10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F60189CE2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868128D8DA;
	Mon, 30 Jun 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwaIciSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562228C840
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288458; cv=none; b=Cv2SGm0jr6vs+LpY5v8me2vhhjHRQL5KUhtkOO738QvqgNL0xdJDpD45DTM65JUPqdmH0HWjjs1hPpppaUEAv6OPz4BY2vlotHTTvNB/PoZW/IznopI6symHbKyASVMz1a9F3ALf97iAgsfemPFRAM+7S1b5jmJeUpdWTWSl73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288458; c=relaxed/simple;
	bh=B4KdnntE/37K79ZPh7jyK3I0hRR/1p6A2DVmbrYflX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSeKJrVA29BktuyW+Bp3VpQnC4WZxFXlR96bjAuJPl4GbmzrIPiD3M95Xsa/SZathztNJqUHrvYEh/yroMX5cZntOcMAOqXrFNtQETNr0aClSuh68kvmHaMDlBU3KBcXnqDDYlCQdrLhecg6mX3irI10fxca7NRkCFmXpnCzvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwaIciSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
	b=gwaIciSySWQNHly+vou9rQY7nvkZG8CMLLPyWVYwAeQdtPb317aguTtY+QU8ZhTicVfbbS
	u+cXjOVGDeiSa3yiYjS6DvE0W6bnD7PbAkpB/MAdGKuzbbESpgei4PISKE7NwHyygK7Hy/
	GMPGZLUBdaefwRuaPm8GVWtWzpjJpio=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-S7f0xursMqaNwPAX2vecRg-1; Mon, 30 Jun 2025 09:00:51 -0400
X-MC-Unique: S7f0xursMqaNwPAX2vecRg-1
X-Mimecast-MFC-AGG-ID: S7f0xursMqaNwPAX2vecRg_1751288450
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a503f28b09so2270024f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288450; x=1751893250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
        b=UvnNO2HO4r4z2aRRLbdQXO4IWjaLgS+CxykSsv9hoKDCTvaBVsurNvszxL4+HNLmhp
         EuTU1T7FUY6wL9XEZqhrVp8nqRkj2/U99XIgYq+7GCq+zBC/G/jO9vvPJ6pdYs9/vo6H
         HlpVQArQaLfA8yVWvLC/DC7STo4gZNHNVNlLEa6C7WNRSwCLwfRGCA9abCBzcz/V2qvc
         N7hWVdcsFfVOSGY8Kl7kZzv9ex5cRPGU0SI45pSDCRT0QUW+X78XnwwRtRGSn1Qp73Sz
         ce1DAc1iUw64PfUZBh72fd22tGXQSzXbuSHoaAqw/deKSgmjsUHI6V25GzWzXNO2hPuc
         2UpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUowXWmfQzEJaz+WWb8K+8x+D/MTE/zwBkrwWdm2k7aVPf9GkTrDUYPTpUtXndBDBB0tsjtGuvj+KRjqhgh@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxph8kH9JIv4aoXLaJIkds9oZ8q6XbF1EDvMNm4Y+F4Txh9/I
	bH7RbDoho/ds7n00Q9c5v8HAhcMuM8KXhxYrIuzes5RJ675E9lskxOvDvwSKama9sOaZeub8//Z
	JTBMzmVfyHJpTCWyxhSL6+eL9Y9HwczwvnWi+H6HTXBkTgnFF2ZVbzWq2ruY4nMWPiM4=
X-Gm-Gg: ASbGnctoHrujcx3vuYeHgfeMAOsTuSSIM7+IStkE30bR4Z/cfoIqGckVZSKEvd0PZVe
	eyGbz9x2EG9B8vC+wiDRrOWQPgnRaIX196Rl5V5X2C9Lw+OxaJhii1X0djXGD/rPgRBXC9mWevg
	HSglbVAEiHTZIZINKtO/kggaNmG1Iwfsfl6Bw2HNTk1o1jI/91gvgHbzXl6cf60YeoUv0AgmAEM
	4VyfG6SV20cZH3lnU2ZRG5shNwe9Qjph+DwN95XSJ7HVZXDP5oxBCmCWIZ9O7aeUL3bVLoXBXBK
	k7GGFlGCgz1JjG5J7gMfiO+Wa9SSJpvVdbJzzsgkRBeoYlNcxko7PQRK71TMdMlNn6+bwwr1cRg
	ITsiAkQ4=
X-Received: by 2002:a05:6000:2186:b0:3aa:ac7b:705a with SMTP id ffacd0b85a97d-3aaac7b761amr5970047f8f.11.1751288448889;
        Mon, 30 Jun 2025 06:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB1TGCDIUZET9zX0pBSLAtGHjOK3AMuobCCTliN5r8xMP/2a92mQUobTb4bSUGBJMrG9p6Jg==
X-Received: by 2002:a05:6000:2186:b0:3aa:ac7b:705a with SMTP id ffacd0b85a97d-3aaac7b761amr5969952f8f.11.1751288447748;
        Mon, 30 Jun 2025 06:00:47 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c80b5aesm10252042f8f.44.2025.06.30.06.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:47 -0700 (PDT)
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
Subject: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Date: Mon, 30 Jun 2025 14:59:53 +0200
Message-ID: <20250630130011.330477-13-david@redhat.com>
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

Instead, let's check in the callbacks if the page was already destroyed,
which can be checked by looking at zpdesc->zspage (see reset_zpdesc()).

If we detect that the page was destroyed:

(1) Fail isolation, just like the migration core would

(2) Fake migration success just like the migration core would

In the putback case there is nothing to do, as we don't do anything just
like the migration core would do.

In the future, we should look into not letting these pages get destroyed
while they are isolated -- and instead delaying that to the
putback/migration call. Add a TODO for that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zsmalloc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f98747aed4330..72c2b7562c511 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -876,7 +876,6 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
@@ -1715,10 +1714,11 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	/*
-	 * Page is locked so zspage couldn't be destroyed. For detail, look at
-	 * lock_zspage in free_zspage.
+	 * Page is locked so zspage can't be destroyed concurrently
+	 * (see free_zspage()). But if the page was already destroyed
+	 * (see reset_zpdesc()), refuse isolation here.
 	 */
-	return true;
+	return page_zpdesc(page)->zspage;
 }
 
 static int zs_page_migrate(struct page *newpage, struct page *page,
@@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
+	/*
+	 * TODO: nothing prevents a zspage from getting destroyed while
+	 * isolated: we should disallow that and defer it.
+	 */
+	if (!zpdesc->zspage)
+		return MIGRATEPAGE_SUCCESS;
+
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
-- 
2.49.0


