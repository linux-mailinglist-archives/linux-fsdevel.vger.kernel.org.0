Return-Path: <linux-fsdevel+bounces-53361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F2AEDE67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D2E16A61C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C658285C81;
	Mon, 30 Jun 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqUBm0Vs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB81E5B7E
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288508; cv=none; b=QiqDhzPTyrGnOVkA3ebl604yXYzwvS1Je8i3Z8bv5G6Dbp/MpQrovRE3dlO/rbaxrVWWZUyOzX2FbRnECSb+lXJaeUC1wsOqIEqw1efAWRcGe/aVFsJt6XWAVWvbWT9VuGRjo+gfdGkbrwsGfjBYJyg2rc0nNWRhY9CK/dAmeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288508; c=relaxed/simple;
	bh=xmAX6FaG7PwzByxdVNWIboeTPGW5tjq2c62uEFet5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dvz+74wqZb7Pb15iuNazdvyUWitIVrJw7RvjuAyJ/WlH4PhYwpq8BZWiS0KBEKsHD4/D6ADM3vk3owuHITgGzAvP7O5RBctcLQ3su7cgUcYKkd8qoJtgkX46ObnyO/eB9GaJPvMu8/JJ60zGicpFwnGmoFvlnloFLO1nWLTHedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqUBm0Vs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpLhIwgxSmOTAUjcHZTQRVGXB1xFFa6Mgym/mVDU2pw=;
	b=bqUBm0VsokyiVDo7M4JX/+7D0Imc50MAYnL/AtcQu2iX88fWWH3ckGNfLdAoLK9UdSTHEt
	mNccOQ9OMWlSvpk3olz02ihWxsoCIlkHiL6PaT/m6hY/oATVNShFTKGEzliPCr07aGQV4h
	+6Dtk4vpQiSGTBGOQu7vjWolcWaoxQE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-lSQlZZqCNzGwPfuAIxMbNg-1; Mon, 30 Jun 2025 09:01:43 -0400
X-MC-Unique: lSQlZZqCNzGwPfuAIxMbNg-1
X-Mimecast-MFC-AGG-ID: lSQlZZqCNzGwPfuAIxMbNg_1751288499
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso1185538f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288499; x=1751893299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpLhIwgxSmOTAUjcHZTQRVGXB1xFFa6Mgym/mVDU2pw=;
        b=NDPGfHVZaWCec2Rl+BcdffR7sfYVz7Dx/Y7z+L6gKOc+LUdUsfhOqM4Piaq1sbmPHF
         ergLMuypW51c5lWWZtjbDTas+pKQnD3bn2ZFrwWxUV0853BLr5gWgSeua6ADX1v5cHFn
         U0g5sCgiAMUOfCFVMLrDIIQ83OYAi2fYsC1A3TN+7NfzpBCdr+9EMReVr5qDEqEmeGkl
         o+gGcivtBt02UnEQupDj/Zwcz9iLehtJmM+WSbqdu349a4mlNPcNKRbRv0zRYaE60IzV
         SS4kQK2jdOqEryRzCiDimp/X3GuZzW7PzM4F3wF/x/J2OxOzhXwQ2limdXxpevNWp857
         hFoA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Bpvh95+zgWdMG+56hBCRPmSQkentEsAxCDePgPQbSjciH+yJzOlpcmzqqclRe9NwH9bEHTvZ6zb/VrO/@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmcHaHubFG+MRIREQ9+F9gP54HVsVqg3DpyahYY7DeGdRhsdm
	M39bPdaGBAWalEDOMPyCZp02IozBiPJzN9mPuBPpKhYWtt52L8YvctAlR6ddqsKUlDIj4lCIQjt
	kSP5HXyxA+WKjM69TDbWOncyy0i+G7MO4g2RB2+YGCxJt8UISsM5SjjVETjmYcxTvpY2XMXF40h
	j5WA==
X-Gm-Gg: ASbGncsOsh7GLSulc8LuGcMJWcJ3QWdaC054wFaLpTFNlxWIr2HX9k5GS8KwCJ/sx3N
	fUQ2zMRocjCOaEC0XV73gKmHod39ZZijfc6CCnmqZL7KSC13Tbt++uBvgZmITD7EkoaBGhOcoPT
	IYIEkGMGvGC7VMfff6jJ4mA1ftlBO89X/ZpisPsLS7KRL3rfYrRExVYScbMaVinJj5PlWHFWTaX
	bVbNBdYuBWWWqelAj8eerir19H75Ddck0cgPu0nZM992I79hAF5bilirPI85cWSgeKjCpkJ6fti
	sG4zHxWYQBPJn7oznk6PUUzQM8TcL/Ud8nc7yzKoB2sg0x2phx7cwY4cQ14v4UXxJOY1buAkrwr
	VDpvA6pc=
X-Received: by 2002:a5d:5849:0:b0:3a5:8934:4940 with SMTP id ffacd0b85a97d-3a8feb70269mr11468322f8f.50.1751288499052;
        Mon, 30 Jun 2025 06:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU/EidvqQvGX4HPGBQwVJZ7hXZfY7F5Qe2rCBAm3bwMmXiBwrV5rV1e++rVLkevEN+RDkRKg==
X-Received: by 2002:a5d:5849:0:b0:3a5:8934:4940 with SMTP id ffacd0b85a97d-3a8feb70269mr11468280f8f.50.1751288498410;
        Mon, 30 Jun 2025 06:01:38 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5f92esm10485904f8f.90.2025.06.30.06.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:37 -0700 (PDT)
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
Subject: [PATCH v1 28/29] mm/balloon_compaction: "movable_ops" doc updates
Date: Mon, 30 Jun 2025 15:00:09 +0200
Message-ID: <20250630130011.330477-29-david@redhat.com>
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

Let's bring the docs up-to-date. Setting PG_movable_ops + page->private
very likely still requires to be performed under documented locks:
it's complicated.

We will rework this in the future, as we will try avoiding using the
page lock.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b222b0737c466..2fecfead91d26 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -4,12 +4,13 @@
  *
  * Common interface definitions for making balloon pages movable by compaction.
  *
- * Balloon page migration makes use of the general non-lru movable page
+ * Balloon page migration makes use of the general "movable_ops page migration"
  * feature.
  *
  * page->private is used to reference the responsible balloon device.
- * page->mapping is used in context of non-lru page migration to reference
- * the address space operations for page isolation/migration/compaction.
+ * That these pages have movable_ops, and which movable_ops apply,
+ * is derived from the page type (PageOffline()) combined with the
+ * PG_movable_ops flag (PageMovableOps()).
  *
  * As the page isolation scanning step a compaction thread does is a lockless
  * procedure (from a page standpoint), it might bring some racy situations while
@@ -17,12 +18,10 @@
  * and safely perform balloon's page compaction and migration we must, always,
  * ensure following these simple rules:
  *
- *   i. when updating a balloon's page ->mapping element, strictly do it under
- *      the following lock order, independently of the far superior
- *      locking scheme (lru_lock, balloon_lock):
+ *   i. Setting the PG_movable_ops flag and page->private with the following
+ *	lock order
  *	    +-page_lock(page);
  *	      +--spin_lock_irq(&b_dev_info->pages_lock);
- *	            ... page->mapping updates here ...
  *
  *  ii. isolation or dequeueing procedure must remove the page from balloon
  *      device page list under b_dev_info->pages_lock.
-- 
2.49.0


