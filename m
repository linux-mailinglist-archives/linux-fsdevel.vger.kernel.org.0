Return-Path: <linux-fsdevel+bounces-52082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0AAADF4C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C2D3A36AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E430433A;
	Wed, 18 Jun 2025 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv5ZI2eQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE292F5490
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268495; cv=none; b=dYy1yPEDgtcYtitEh/g/GN7IebBa6dnM3O3CiIox9jBEL5tSrw91jBu+lZK+TVDdrWq8bPgO5O+3Jfyj8s35vmO+cLAvrQ2bprOraEKJh7JOcdl8w9GP2avYbI2AffUBbnr62b4Nnq/Whw1ANPjBTOafXXGYrOqcgO/n9MUE2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268495; c=relaxed/simple;
	bh=qANw5s/Bw3QCvq7BlzvxZffSRQGWJpFueQvB/Dfqsvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8kK2X4+ZByDO1V68Js8MJPA5ucRfgO0yLL0eC9uLhtGLl3reUOlnev6+X7prxZbNKLfN3O0tu6WC1+eb+IMtbfO9b0KvuJMWv2cCxqFDcyYn+Ys+LJlskHwjRASLF8ZpDGsKpn1p6XHzTe+83XqSHucIiZzNGVK9fEru6qP1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv5ZI2eQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmfdwaP0f5XUY3WcVBI8N3swmSiQtYBlwUFmuX0ZYxw=;
	b=Bv5ZI2eQ/dGldGwaua9XQhxpnfr9C51HJjG77T68zXscE04eMToqCfntF30JA1g3NGGodO
	8GFji0uuOp+cMLD0k2g9Rz+Rw0VeTCkjpTK2+/EGsXornRnKd2UloKg6qDCedeGLUa8qkZ
	ekTJ2z4TxZptLhl0LpNjTlmcUDlhem8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-ji1PkHZRPb26s1Hi3wuVsg-1; Wed, 18 Jun 2025 13:41:32 -0400
X-MC-Unique: ji1PkHZRPb26s1Hi3wuVsg-1
X-Mimecast-MFC-AGG-ID: ji1PkHZRPb26s1Hi3wuVsg_1750268491
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so4233112f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268491; x=1750873291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmfdwaP0f5XUY3WcVBI8N3swmSiQtYBlwUFmuX0ZYxw=;
        b=LE5jvn+bXjomC7RLtlAaqtpHu42NR5lXawoFuJDZNsCqoC43zFMaRdihqGYO1/uZFW
         RtvYAeKtOOCiIce9dEhMS4xyp68OXymCvk4zW/Bv5hu1c4VI6qaPXq/LUVMgfCcvmj2a
         fgt2p5TQw969QphFFpNB8lvxbu0ixQZEzfbLVuQsqouOgxjnhzp//GZD3g930PkSkzn2
         oUCW4IrBCO/9MU40Yamhva+7Brs005A/1p6T84nXwb95g8qX/95YJKZ4kCdW0CD1t3I4
         YkkfHJYWqf1vJJqIMg760v3Zseu1/C+7PhHpzoxRyAGRsLCP1qKcLox6u1jMD7LPWerB
         N72w==
X-Forwarded-Encrypted: i=1; AJvYcCVvIPxoltexqw5wJqzJnfrjuY7VKYZuIgkNPQb58KlUH/i0F7lDdWzm+i/ducJ1zL50ssKW8NNfnXhprDf7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lrs3en+LDO6n/6rAGRZS1qgnne7FyhEW620NXWKngbTOiN1E
	hgR5rxIWZvelDWdUw8a9jEkFjEPkHzzgQ+J5DRl/UgKGminl2AZH9r+A6p9ir+U2fOw1VkCbHkA
	UppIzhBlzBKZ7dcfsBZptTCBaP/EWMH/bEpzvMf+TbOWxP4tXJQ2mL/SOWFYu1dfrAJY=
X-Gm-Gg: ASbGnctHHfQRR1/1CvT5E1pviiaaNZKk99MTsLSp4nl1UZmoVv73nBjPUGr1LrtYlOY
	mOrcGdBMVxLu4MTXzKMgg3D/XYJpj9W2h4Ub28rJ5HR+4OfctEWk7bHcQUIVV1XZjGcvQF5NpMX
	7rRCM/XMUQlWaAzZ9EDnFHywQuW54XsYJrMMa7hJx64RpBdgSnnMWU2NQVXr6NYCaZJBr+JFnId
	k/rq2Rzo1tF3go6pLccmXpbrLG//rYx57xTE9Gn2HLjetU5bYwxEdIBqvnnv+HU+74biMrYOsfa
	USkBwY2ycCprt/E5K5J0VBTVNBqTJeJoxINQVOjdcfByKM07RtJKzUaesIU403LM0qz3Nyk3/z9
	DbGLYjA==
X-Received: by 2002:a05:6000:178b:b0:3a5:21c8:af31 with SMTP id ffacd0b85a97d-3a5723721bdmr15240208f8f.16.1750268490809;
        Wed, 18 Jun 2025 10:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZhpZh4slqbXf6Y+7KOO1SPenqI87LsZpqVnArN4AUioCPUgU259IOTbkkNjhv6BPhqHLFQ==
X-Received: by 2002:a05:6000:178b:b0:3a5:21c8:af31 with SMTP id ffacd0b85a97d-3a5723721bdmr15240182f8f.16.1750268490320;
        Wed, 18 Jun 2025 10:41:30 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b2f80asm17518051f8f.78.2025.06.18.10.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:29 -0700 (PDT)
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
Subject: [PATCH RFC 27/29] docs/mm: convert from "Non-LRU page migration" to "movable_ops page migration"
Date: Wed, 18 Jun 2025 19:40:10 +0200
Message-ID: <20250618174014.1168640-28-david@redhat.com>
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

Let's bring the docs up-to-date.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
index 519b35a4caf5b..a448e95e0a98e 100644
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
+(c) returning the movable_ops from page_has_movable_ops() based on the page
+    type
+(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
+    for other purposes
+
+For example, balloon drivers can make use of this framework through the
+balloon-compaction framework residing in the core kernel.
 
 Monitoring Migration
 =====================
-- 
2.49.0


