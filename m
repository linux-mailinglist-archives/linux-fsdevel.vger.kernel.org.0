Return-Path: <linux-fsdevel+bounces-52068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20720ADF487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B538216892B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392E2FFE05;
	Wed, 18 Jun 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNrW6Pap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB32FE30E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268458; cv=none; b=r3QSgtvdy4im8wuwWNjNawlNQCb75yRMnz+4h5Btb/8wGPk76SQZ7UeiLTNZ9TaGr1V5Kfqbp74ex+5AgjMLrr3vy7SBS5N6x70MS+hPf/kUkrlynN9UccOj4BdIjkJtQj+0bh4832mIB1LUZbWmnsqagXKrfyf5SLoSI30XRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268458; c=relaxed/simple;
	bh=B4KdnntE/37K79ZPh7jyK3I0hRR/1p6A2DVmbrYflX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bS4B595USzT5/aek/0j9lCzPrJ1kR2mbHxYfrJylusBvZinSW0quCJWUgZHHYUIUqvACjzpEF+YkDiqEI9UOF4Ta6idoKl3Dzew3nKHalLLdu2ErL1BxcH5eo2Ypbhv0YaR0uDtnjLLtM328QElaCsdOlkAIi3sLSLaPYEOEWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNrW6Pap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
	b=iNrW6PapMQn0TiB7cIEmWpOqq+6UgmnVd04j+DoDJGW0/IQH56s8+X5H8Y9WP8jj5a8oDc
	Ir73TymVM8AMZJPtXZsZD81c1XQf25lF29PCDZtcIDQE8NhHl0XFPtfK2gAXQcIkDGdi4K
	sl/b0Lunff+TAU4g6QDsU/fC5DK3F54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-pUaqkt4DM4uPc1uXKg5HbA-1; Wed, 18 Jun 2025 13:40:51 -0400
X-MC-Unique: pUaqkt4DM4uPc1uXKg5HbA-1
X-Mimecast-MFC-AGG-ID: pUaqkt4DM4uPc1uXKg5HbA_1750268450
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d244bfabso59189215e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268449; x=1750873249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
        b=ZeRtKyaL4rr+XY8Ax4f27XUwBXTKehyVT710C4uI8PNkC8jrbXpDP3nfKLqWZluYP+
         hzKYIFomt4WEpTehQtOAT6ZmOftyDGGiBYMk8ghxmlrrbtxBb5YY4pT0UEQcZ+2EdNbU
         klrNJVOtPgtmonJppd1dusygLdymT7sw2xJG2h8TXkEyj2ZelbDZIn/y8N6J2rzZ0+Ln
         XCKbkGvP+Tc2PR0SBBgd3EuJAfYT40sVY5QWNeGa1lwyIV9cz5qJUDEkMU/PmYY2hXE0
         vWcIUPOAP40TV21C+H67iQNX7AJ+F3PkpKVGvC0tvZqJ6KIJIh6feaYQ4fiWsTnfEwpC
         ysnw==
X-Forwarded-Encrypted: i=1; AJvYcCUGeu09cXKMfb/LUWWOXJJBK6qzBEPj5T2aphr8g0y3j9jUr9KwXm7AGjmljbNtpvtb31eYvsf/pQsqU++A@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvhdllbcq73W7RrHjCUSa8VRcifW2Ug4t3pdrWD/YLS6uJKlYd
	0weXlSCz4yiz6mTbGZS1jVAd7g9pRt3yQC6q4qVvNfonWwQw1PTiOX/zJ3tPHAs/uNufE4vnfRo
	Et43VcxkEmZ0I80dYdixZyc76n172RXEtpSOSfeeFaGRzan+yhhr97K8XEiSL4HQ6aCk=
X-Gm-Gg: ASbGncuI5dS+wFczUAU6cspdx0bULTQKmtOMX4cZe7K1V0eCr4nwD0hJ8YvAguduldw
	bqRFZhU1Wi0+RCVczO3IBjvJUYwku2ZZmsmjNk1WqDaU6AROXlrV4aDcapuviVIKFKykOZ6rtUN
	y4bMcw76aqYO2ko7steSpREEAWxIm3bKhfXPVv2cDSPhNg/84ImaXcKKFUZQcIB5jBe4OguYxWS
	2uW9o1BkQaO2x288AJGWq5qcN4gAyVi3ViRWmq7dR56hS/8MapFPbyOjZaOPw5qAL01X6OqFuEv
	MsCOJofNVn6LWL0zrM9SMnm3r+wzku90yvVnU24t0on4zApJFhjeNhhEgvLkb5f09ffAQ6Vp/26
	o6orfbQ==
X-Received: by 2002:a05:600c:1d8c:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4533caad0aemr171064555e9.19.1750268449522;
        Wed, 18 Jun 2025 10:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGznKIGl3nAorQ6sfOY/mgzfowzauuqoYlpxs90ugUrSAZIVXpSWN8Es+fpzvWy+uQJD/IOZw==
X-Received: by 2002:a05:600c:1d8c:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4533caad0aemr171064285e9.19.1750268449019;
        Wed, 18 Jun 2025 10:40:49 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e983c76sm3664265e9.10.2025.06.18.10.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:48 -0700 (PDT)
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
Subject: [PATCH RFC 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Date: Wed, 18 Jun 2025 19:39:55 +0200
Message-ID: <20250618174014.1168640-13-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
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


