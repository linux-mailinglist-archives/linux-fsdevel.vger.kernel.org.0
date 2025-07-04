Return-Path: <linux-fsdevel+bounces-53951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E08BAF9097
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE04188E0AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D02FD88C;
	Fri,  4 Jul 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OK56u9HP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251F2FD893
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624810; cv=none; b=M2ET0XS+BEcKVTNI8M0BTJ3Ea9AhTtItGFrQyCE+rpttcrYpfxxRZPLp46af/NYrXEKq7k5hUxaZ8usFYJ1d36clpbudwmKXWAk+8PGKUg6jaRAAfixPHIyy2/YI0r0kUKL7dFJ/z0BJyxYe+xc8C3/0qhwYQ04lgzLgPJUKyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624810; c=relaxed/simple;
	bh=8rQqgJp11Lk6antrmn+yK+r+00c98BCFbnlbAAQikq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II/aUc2AHkRU44jqQxckFVzYppmzViAMFI/OKodtqV2Jo5iqLnyKuR3sFFIGhBuv4KoBZImgNbHCBZQcnuSfYKDBCl3Fz8+ULQTTLudnpmtgCUmg1CvbkI0ERuXLQj3iVcFbfVmqpcCtEC3WXcM+oZKif9+9odWUDYWTNtfsVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OK56u9HP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egdaFmDJBU0TtndNYiZ6nPcRML2Mxu7RUt3KjMyWE24=;
	b=OK56u9HPfDiPZJeQemFNx21e+7OGxwPQ0L4T28kY2Dg9Z8Dc1MA4+8PHaCHeMSH3BWNuZ6
	V79vqB4VwZOHp+ksLdwtmjKgdL54kFnsAYHOdEq+GFkyvf2j2fD6WiAFcOksrTB8/oNH5+
	kAC3U6nNFRx72fwqL4e4oj6NE5UIRw8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-ZDl7S2VXMESQdzy5tUmwJg-1; Fri, 04 Jul 2025 06:26:46 -0400
X-MC-Unique: ZDl7S2VXMESQdzy5tUmwJg-1
X-Mimecast-MFC-AGG-ID: ZDl7S2VXMESQdzy5tUmwJg_1751624805
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so3903435e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624805; x=1752229605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egdaFmDJBU0TtndNYiZ6nPcRML2Mxu7RUt3KjMyWE24=;
        b=e+jw5dlRas1Z9fSQ1QWqbdav7f6/IzNUxUos+kmAvrHPc+5g5EDgJkDM7eVy5Pspx1
         FK+mDe6vIn21BQJ36Am7IcmSZ2l47Q63cMjyX51d8XpbjgNFR6eS3sEOMIWcBIAaUXNR
         rWtRAUT/UEZEidUgSmGdqisgJtNHY+HMPyqH0TcL39/zHm4ESvl031XUsVG5f74d9+Yj
         peiM0aIDRVtHxj3s75DV6mWeS17lDsw2A3v+uLILDg3XMj49Jc5lGswgbHEHgElaTFH6
         ZkbrnjBfYsq5otYzF+6gN9NtPFZOg4IPFJEUDhcuSCxrcV1ya9RfTauU5mTnacqHZ1TG
         xrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2cz1KJE/IzK8/tQk/orjTEdp7QYkes46JohlYH5VVbBqw9ggnpwKG6r8qJnagKKYEHTtXnKCJ3/2tddKq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jVl1x3RVaTMfs5EjEYbI+oLM0bIAloiSZPOpwtUFhDbzk+o8
	fSFEDtvxrU/6oRMa//T+57/YLxTv+YTw/ogyvI9knOksOgOOj2Y2wLnMIGSHp4Orl/KGz02H4+R
	ej+dPzUBqy8X2irinjJRZOL70LZ4VC0gwfghpJzL0MLpwQ0lnZTjgtjduWSx5S6weJJ4=
X-Gm-Gg: ASbGnctFpcdm2vts4/lUFOO7M8UHq7d5sOsH+qA5YQqY5cBkVzn4De19kpK0F6G2NNo
	Gl4FQM8WYIT7t4FZlLggtPXgfJz2RkoRsg6Q406d1fbUBlgO3uHwepWlvLlCo3pS2xSNvkJN3RJ
	AxT17odN3KUMmwG3NvjscDr3hDqRJtMV+ZxB7EnkMVdBYL0KZ83RKBYfu7CfItWvLtfx/OpNIGF
	Y+Emq9ZsG+vFq9kraaDF8miAaft5QAWCJBYwh97t18pSdVsvwEYFVSss6lUQWjdNc2haLpW2XX2
	Q+MVIHKAqHt/tdF8t9Z+QSqyMf5rSA5ZpiVFj6gZYGJRAvokPnLGm+IswkgQzdsKr4ZZauqmq3N
	AsOmWhQ==
X-Received: by 2002:a05:6000:41eb:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b4964eb8c5mr1818974f8f.12.1751624805274;
        Fri, 04 Jul 2025 03:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEReO138rar0bBMYwWljLx+rr/cG2x6KKHBHNt6saeQjtIgYNeV27GRLz6HCnNXsrL9yURvTg==
X-Received: by 2002:a05:6000:41eb:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b4964eb8c5mr1818905f8f.12.1751624804727;
        Fri, 04 Jul 2025 03:26:44 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285c90esm2152102f8f.91.2025.07.04.03.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:44 -0700 (PDT)
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
Subject: [PATCH v2 27/29] docs/mm: convert from "Non-LRU page migration" to "movable_ops page migration"
Date: Fri,  4 Jul 2025 12:25:21 +0200
Message-ID: <20250704102524.326966-28-david@redhat.com>
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

Let's bring the docs up-to-date.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
index 519b35a4caf5b..34602b254aa63 100644
--- a/Documentation/mm/page_migration.rst
+++ b/Documentation/mm/page_migration.rst
@@ -146,18 +146,33 @@ Steps:
 18. The new page is moved to the LRU and can be scanned by the swapper,
     etc. again.
 
-Non-LRU page migration
-======================
-
-Although migration originally aimed for reducing the latency of memory
-accesses for NUMA, compaction also uses migration to create high-order
-pages.  For compaction purposes, it is also useful to be able to move
-non-LRU pages, such as zsmalloc and virtio-balloon pages.
-
-If a driver wants to make its pages movable, it should define a struct
-movable_operations.  It then needs to call __SetPageMovable() on each
-page that it may be able to move.  This uses the ``page->mapping`` field,
-so this field is not available for the driver to use for other purposes.
+movable_ops page migration
+==========================
+
+Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
+zsmalloc pages) can be migrated using the movable_ops migration framework.
+
+The "struct movable_operations" provide callbacks specific to a page type
+for isolating, migrating and un-isolating (putback) these pages.
+
+Once a page is indicated as having movable_ops, that condition must not
+change until the page was freed back to the buddy. This includes not
+changing/clearing the page type and not changing/clearing the
+PG_movable_ops page flag.
+
+Arbitrary drivers cannot currently make use of this framework, as it
+requires:
+
+(a) a page type
+(b) indicating them as possibly having movable_ops in page_has_movable_ops()
+    based on the page type
+(c) returning the movable_ops from page_movable_ops() based on the page
+    type
+(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
+    for other purposes
+
+For example, balloon drivers can make use of this framework through the
+balloon-compaction infrastructure residing in the core kernel.
 
 Monitoring Migration
 =====================
-- 
2.49.0


