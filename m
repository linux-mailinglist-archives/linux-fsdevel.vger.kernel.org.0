Return-Path: <linux-fsdevel+bounces-53937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558AAAF9053
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9400C18920E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB382F6FB3;
	Fri,  4 Jul 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blUE6qi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2842F6FA0
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624771; cv=none; b=o9HoGHl/DRiOLomW4K4/prrRZQpVt9BUdw0KPJqGO0x/D97DaS6u+yCtvhXNXFp8obbpRnqJTeqwBIzheuZvJmjdJWkAb44y3bWeVmBGV8fiULaYY39JmeeOA8ZUV9NBSmFnUzrWFa/XQNOn7zkg5br3lmhDeIARbESRJFbOOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624771; c=relaxed/simple;
	bh=oaSTbzQ3dv0aK/zBA0y8w/GgIiybny/jYiHjyAxnR0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDvA3SchE+qC0rEGahTwvU83XXzyWSYhxowEMFtRTb0WAKJy2Vs1Zd3duHHItf6LaB2rBpDJehPPgzrKyEUQmm49bjPNaGDweN6RjNb1CXjKSD4jla0t/LyaUjhEQYU6jB/LwMlxC7G5hyxE50exL81ifQs/f1EpCNElTxPsee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blUE6qi0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMn47cTQVrdLq38vaZj//jvNYLvXfWrM/D4yqUNgXk8=;
	b=blUE6qi02WQHKJbTYH5D66fp7uR1atjjlhkcwXv+H163Sv/lbKZ9GWi0EG9lO48iW5kNnI
	DyNF/EILjNAWawzXhfMVI+FpCKsdrA7YYA35gQZUVoKr2W0S7n+ZZcQOIZOrmU4efxZjPo
	fq+ONp9FTsZ04NkFpY+YwItAY8RzPmM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-s1SWAHpaOUyyn4bDU53JyQ-1; Fri, 04 Jul 2025 06:26:07 -0400
X-MC-Unique: s1SWAHpaOUyyn4bDU53JyQ-1
X-Mimecast-MFC-AGG-ID: s1SWAHpaOUyyn4bDU53JyQ_1751624766
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450df53d461so6214715e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624766; x=1752229566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMn47cTQVrdLq38vaZj//jvNYLvXfWrM/D4yqUNgXk8=;
        b=d/c9daDtViDfC/aGNj0iMEkP54JMP3xGNcOcvxqBNvM+5onWHO4+4ISrVTdMWR/rSo
         MTz+VC+9/i2tqeTFwA05ZJZbeLPScgzabgHH1Or/mYl2fC9+yqxwR+wEBU8T3p2j84zg
         Gksc4squLyfI+AL1cDqZYRkNzJYZDvgqouWgLBrCDe7+tFs9T2paWAXfIXOvo3RkVAJW
         aRwRiko/4QB1z2TBq+Egggqb/P1dzR3qgUVHTskYM3iE/jIZj5nST/K+yoR0DlaG3hD5
         yKh6AMDdJHvjmgggFNP1fqsdBbySz7AghX9n1pH0kkG0dvBO3MdtOW1y74Lra0t4E3rv
         M3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXDTomVphVTfYQ6OdhtJ27ykV0W6bs6tLfnoop5o8t2KKXmjAJrz5GLWjfP4k0+/2Oqs47h+MZLCfT7VT+R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Ss/8kDWSHdAwuDI66Naa6PliK7seygKE9b6aiUkirHuxsf2I
	7UpHB9cV8A9oAyevahB+wYoHpqUiHXid9DCqXMIAQw4UJEJuL13+q/18m9aZegUG3qY8JYcB901
	bBXgk8TuynrftA5kN1VNiXjmHvh0VSFJ0783uJVnl1RZRtkOc5eGUPJJvu5WJuyQKhd0=
X-Gm-Gg: ASbGnct/BeVxYjYOOhSBy0nQsrlijw2cVZaAc+3OJfPXCiJbRAVOwqiHj3N05zUqlJu
	na215xnu872+6ZuCY7Bt7w+a92o/2I5bDTYPMb6jLwPs4duMQYHHpacjt9BvhVC+R5KhWxClwqK
	o2klT/wMwMaxEHPKMXdDMVmqXu1IXikd6NCT6rmW2wcUQ+LW60XKvk1qjOhOt4j2aBa6ugYXZjU
	HsfYfqnRTw6pI/7yhihEdjVrWkMMcyLaZzU5tUp/VvGQV+zIkOvNc+r9efqfK/JZsra1Nb9lbUc
	id0XBCrr2kRRlFBdb1s8mvfAbMCMWIG6NdcJlmk4Swh1oc8AbUlYRl9tE90Q5IxhA5P7KhK0mUP
	8WtnScg==
X-Received: by 2002:a05:600c:34d2:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-454b306a0efmr19575525e9.5.1751624765947;
        Fri, 04 Jul 2025 03:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOTyF2MeOIC1dyzcwecIwxCxQh4QIfn5IAcyJ3Cqp147OZBgMH5DYs267rEpv1i04qDIM8Q==
X-Received: by 2002:a05:600c:34d2:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-454b306a0efmr19575125e9.5.1751624765503;
        Fri, 04 Jul 2025 03:26:05 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454b1628ff9sm22617005e9.11.2025.07.04.03.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:05 -0700 (PDT)
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
Subject: [PATCH v2 13/29] mm/balloon_compaction: stop using __ClearPageMovable()
Date: Fri,  4 Jul 2025 12:25:07 +0200
Message-ID: <20250704102524.326966-14-david@redhat.com>
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

We can just look at the balloon device (stored in page->private), to see
if the page is still part of the balloon.

As isolated balloon pages cannot get released (they are taken off the
balloon list while isolated), we don't have to worry about this case in
the putback and migration callback. Add a WARN_ON_ONCE for now.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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


