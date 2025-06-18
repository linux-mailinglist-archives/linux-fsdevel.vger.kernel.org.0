Return-Path: <linux-fsdevel+bounces-52062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A08ADF456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD11C7AD5B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2AD2F49E6;
	Wed, 18 Jun 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+wH6k4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329122F94A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268441; cv=none; b=ImX4GogvptiOCd5rIjQMGLqnFYjsKvNCSy1GhLbAeh720GNs3Z3MbRhOysY3K3cRYTdRzvQMOJ9eUyUiA9xR8zhZD6qQ24a/wz/4kKyZH71XiKa6uM5zKeNpsPA5kR+xmi9K2JJtCBpbNfpyijnIMC2SEC6waR58P3kW9q+rTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268441; c=relaxed/simple;
	bh=9PSofqRI4P1+E7gv4s7LsRbrQULLczAgLmwV7OUNB6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJX1iHxc7Fn3o7dNbBw/SfSg7VLDtu9T8fAiTPigq52S2oV6TVZSmXieaCeIIgd2J4jw56q+AyhP/E2B2BikhQl3YLYca3UoYrwcA+PpyHWzoQiaL+UhgrDBtJCXrvAW1iVd7xBNgVzrTzVwens7/gzbsUJGOmrXvrNvyp33m8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+wH6k4y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piFGbpStSQJy+mcXr4hbLewWyhEioJRgfJ7dmrDuxBM=;
	b=g+wH6k4yVSz8NiVW+KJV2wCr/DlvVMVdZXWR9aCK5YAhi1QPUAL956+03mU0BnNGdkv63R
	+SRfcNzzT0BaYbFKdh9KPc0H3dvsH/VSqUd4SF7HFpWP/+CjsV5AjlfxSuQsPtiMgP7BJ8
	bMeXgAfyOOeRBxDFS/iOvUxKQaVhD/U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-0qKcfo-0NrOl7tmJ4z8fJw-1; Wed, 18 Jun 2025 13:40:34 -0400
X-MC-Unique: 0qKcfo-0NrOl7tmJ4z8fJw-1
X-Mimecast-MFC-AGG-ID: 0qKcfo-0NrOl7tmJ4z8fJw_1750268433
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4535ad64d30so7581525e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268433; x=1750873233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piFGbpStSQJy+mcXr4hbLewWyhEioJRgfJ7dmrDuxBM=;
        b=EV9v9zwnCMbE7Rr4IEW+7se2OSE8WT7eI02XyitkFSpqd6LW0mcwm4hRQy3WOem9vh
         pwq0nB7hp7rzDPz1QDqrkal4DvAk4JURFcRzBR1RCLapCgsE5XiQ1LVHZlsC6WOgQbuP
         zdc6sdS8wjFcJdY3SCPQg8xqEr5SG+nwy7zfxLTFMGdR8r8f/A1DX8YNiLyLACs/+iRr
         Jkw18KtybG2GS3JKg8q+CsJY8a+ZG0EN8GDSkdAFdxeJxglVTnFq7Irzx4tkfANdnGb9
         exGXxXh7mzNwnUPBl6RL2JQa/LeEcisp201EP9drmygq57ZNMwmP5xo7JgXBW2z6ojbT
         G+5A==
X-Forwarded-Encrypted: i=1; AJvYcCW7RkRifuO+CdlBeV11mjnvDoutopfA2bcTFQzwcpf4U2dWzND5tUHq1asDFKRW6m3JX61YiOGUqakoAuY4@vger.kernel.org
X-Gm-Message-State: AOJu0YyHYqlhmGIwgE3mlc6TIUbgv1xfAoAaf1IermehWPiKdqH9PMKO
	plxOJ33YV8XgsECIbjJt3AzMhKQL9YBPTV/czz/aqfIyoDY8Z+1teOgf2l50YuKvrwsc0e+ubLt
	nKPOn7USPKQNy3R7Onbj+Onvy2oGlYtIqufo2yIUwy2d4OJZfivbr/jz3VdMi+Z25+z4=
X-Gm-Gg: ASbGncsH8fjbbTaUX+VkmJzjBDbWNA5X250DdlvR+mUWBDE26VyUrSdKrXSExEIG3Ii
	oKSWuFknIu8qTG0Rae3Nn7PrU8dmDgpsUJFiRo5Y17qXHvkqI2Wbcm5JKKUR2Dbh6Yy8xH893gp
	HX6yB/0InZPAt01iIaOUavIu7g7ri1Nra3oeg3mR1Ky7dsW3bRXlAt8IROCTUotYm/+s4nF0hRT
	05GqMvJtJ8rGS1UYC4JnQOfIes+FdP/RyKJzQXH2beVCcRV5AX+02okU4W8m04Xg3uJmJX64qlC
	p1d1+dbbErw/eaEO2VZYK9SuaIEa/DOtf3vRrozByOEVjUof0uc6jqHHtU0Ls6abTsOz6L4Jult
	eugzHhw==
X-Received: by 2002:a05:600c:8b26:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4533ca6635amr196392865e9.10.1750268433005;
        Wed, 18 Jun 2025 10:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPWAw9+UfLP1Ct5dqz9wzZx48CMnDwfNIf0E7YgKYn6BQsIliiNikQN1x74QYxh04+83mIbA==
X-Received: by 2002:a05:600c:8b26:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4533ca6635amr196392375e9.10.1750268432585;
        Wed, 18 Jun 2025 10:40:32 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e99d5bbsm3600465e9.36.2025.06.18.10.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:32 -0700 (PDT)
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
Subject: [PATCH RFC 06/29] mm/zsmalloc: make PageZsmalloc() sticky
Date: Wed, 18 Jun 2025 19:39:49 +0200
Message-ID: <20250618174014.1168640-7-david@redhat.com>
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

Let the buddy handle clearing the type.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zpdesc.h   | 5 -----
 mm/zsmalloc.c | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 5cb7e3de43952..5763f36039736 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -163,11 +163,6 @@ static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
 	__SetPageZsmalloc(zpdesc_page(zpdesc));
 }
 
-static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
-{
-	__ClearPageZsmalloc(zpdesc_page(zpdesc));
-}
-
 static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 {
 	return page_zone(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7f1431f2be98f..f98747aed4330 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -880,7 +880,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	__ClearPageZsmalloc(page);
+	/* PageZsmalloc is sticky until the page is freed to the buddy. */
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1055,7 +1055,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				__zpdesc_clear_zsmalloc(zpdescs[i]);
 				free_zpdesc(zpdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
-- 
2.49.0


