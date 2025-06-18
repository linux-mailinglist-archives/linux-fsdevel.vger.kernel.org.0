Return-Path: <linux-fsdevel+bounces-52069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09493ADF48E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F33E67AADB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D32F3C35;
	Wed, 18 Jun 2025 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjQRiJiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C132FE332
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268460; cv=none; b=BV49h7bLX48IyNFAPQhY//kv90Bt92zIwA4kJxfIkslcmCuzYoY+Wbdqbz4nQVM7mW5xlWGoZx/vnjFfWiOlBUCjBxjYiQH1kAhJ774XI0rQx3jRb3ODgQTu+kRqrzngY4eucfeLMlDa28LCOB1m+8vUaaGe6J3kU2/gTcqnoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268460; c=relaxed/simple;
	bh=qF9Vy6Hq3fkswUG+ny4V9wMgoAlWF7MBQAZDgFpHwys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlXW4W0ie4Hr2zeyt3iS4M1+XEoDlh5qOeqcwIWye+u6qxDD2n20IhXi6uXIk26D1dqM9zTekEXd2K4FhyqPAZiUkFamoJYAEtNdJCsGYi4TI0drIwl6nS15A7c0YQvd2c9bMGj+zqf90u1SAc+rlBDqF4q9zxF3m9Q0jAWmwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjQRiJiO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6C8lbjEXu6LV6W+fOxtWyWYf418kuz/nIG8TPoHlVI=;
	b=PjQRiJiOAfC+SLqlzSsEtVIWmPzHhmolqa5BTRwbREihQxzdVObbX1AS4bn/LlpMdb0CaQ
	hNXTzLva3Kfwm+35gl+N+DPo3BO+qU7RtB7Ss+V770DcqHKLy86eJljuNLzLC3RDBlOyp1
	1SndNRZUb2GlE2OgAeuEiqpe9CenllU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-IYuCSxgMPlq4qXChpGG4jA-1; Wed, 18 Jun 2025 13:40:53 -0400
X-MC-Unique: IYuCSxgMPlq4qXChpGG4jA-1
X-Mimecast-MFC-AGG-ID: IYuCSxgMPlq4qXChpGG4jA_1750268452
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso4780172f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268452; x=1750873252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6C8lbjEXu6LV6W+fOxtWyWYf418kuz/nIG8TPoHlVI=;
        b=vZHWaJJfwYlb5JHDwFiVuqvxl0bZTq+Gcnmk4/fZvK6ihtmBk+lnzLVBYOiAKG3+9q
         kNx1dvx6EybczGW9vrKQ2/BLMkazUHbBiegV2RfU4kUa4bu1aHpxflSv1ksIr67X8qjL
         6+Qu8TOP5Q7VsixKOyyxLfZGg9ssQNEVB34gn+zts40Vfm4zlCdvMkBNsC2rxpOo/0NM
         QIuY2IDfVXWHTXTRYI+BGF4lfUYyMNjopyJV4NNg2FBEsN6shScwdSapfT88ZZlUtKo+
         ybOkCaih7NRjHvSX6SAjO2xF78rqNOJLpmqzDV16mJdyLT1qu9CYMBUthKENTThISkIr
         +Nsw==
X-Forwarded-Encrypted: i=1; AJvYcCUXGmzED7JsYrneJR0DCPJ6oHVno9bUvw6VUahQZRAkuFAQCC78XaGJLZyrISWBdkuAXpRKkn7AxOLUvIBv@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7tfQTL1s7BXU96R/hjtDcJXrqlaevDTVr3/hegAcA/tg1/Ko
	BfqdB5h3Lgur/Bv0HPyubuAaoMeNoX2Jxy4AzbT3LgigV6RWcMw+cXgR5KeGYyx94V8+fvCy51O
	KlTSps6dTlk0p+a6ihGrs80K/z548USqI/UAOwxsDlwXgiLrDTkPuxz8jhhbZiWz/AF4=
X-Gm-Gg: ASbGncu4c96DhSD7B+XKABfgyk1Q7jW4oXo8Ip/C1zshKh5ca4c8dOZB9XgJLhte8K7
	NJTf9cByl9lv6vbwTzI0tRI0ri3MILLfvzR9sYxxpcw1+Fk24kUS22uWAiCzedT9/AyHJNyJzNU
	IXcVAXnLk9EW3HuLt/hFOmLUK/RiP4rsgXCTkSE140hc+bZZJ8Kc8Meghhk7L0niVljeX0m1h96
	jNU6SdIFllJNhz4rEbs/Sf5C5uwqWXEquEflRIV/sKeYBlsPY3fgHeG7lhCDYs1lvIyU//L4ZgS
	Tg8vltYgbtK6L63vlzVniDuzpjeWrANkoYp+qkd/+QPqtru5St6A5fvY4JQBppsLIc4fvoPuKkY
	sja0Pwg==
X-Received: by 2002:a5d:64ce:0:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a572e8bfb1mr13954322f8f.44.1750268452311;
        Wed, 18 Jun 2025 10:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4X4ziwIkhys2144e75SHEIZN/Ibpbo9aRHgWcvkByvBS3juQ4aklJtEd9sXicogG+MbEwPQ==
X-Received: by 2002:a5d:64ce:0:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a572e8bfb1mr13954276f8f.44.1750268451787;
        Wed, 18 Jun 2025 10:40:51 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b089c2sm17710418f8f.59.2025.06.18.10.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:51 -0700 (PDT)
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
Subject: [PATCH RFC 13/29] mm/balloon_compaction: stop using __ClearPageMovable()
Date: Wed, 18 Jun 2025 19:39:56 +0200
Message-ID: <20250618174014.1168640-14-david@redhat.com>
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

We can just look at the balloon device (stored in page->private), to see
of the page is still part of the balloon.

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


