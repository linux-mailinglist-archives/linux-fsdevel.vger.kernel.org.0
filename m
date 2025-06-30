Return-Path: <linux-fsdevel+bounces-53355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB0AEDE45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2879C16BEAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A3292B53;
	Mon, 30 Jun 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P48oBnuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7D28B7E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288487; cv=none; b=cJ4edvqhrEfzGejup60YgsOf2Q622FgdyWz6H8fp5r3Yw+VxWikMXEFc/uQPkJL+jgf0uCr7i6w9wvpvqOjpkbHTrtr3LF48gL2y73Uk7EQGtEqyPTgT2z7uYW0tuAI42qkHKNcI0MsFPylhZAco92XP+NLgZtyk1AAD1q7SkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288487; c=relaxed/simple;
	bh=bX2O32zo3eRkpyjOPjcPSMjPx5jynwq3pH5hPVFisUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utIwk0BibvqrJJI3LyqoH1CGpMxBqZ3pJvI+ACHei7WN8lPNCTy0zsnuUvtw1bva0pSIEXuZ+uRY7Bprk7Vs5VVZeCqHmpXSuLOc1jRe+BY2Nf5FOTuLDh1ONjcvVczCxLo4cuq8mBcOw8A+IxgOQvPKsRvnMxKHL3RBMn6rQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P48oBnuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqdlPSrzqUfx0/Anfl8VFepfeUNo5Gqwl7mCFswBHro=;
	b=P48oBnuDotMAWHhOK0t+uhG5sZLPSQxzFwaZY3Brj7uV2WZPja3QCodFmcgHbaF0870ScS
	JqHhPRtiqDgqyL0gC2Cq6zrXNTS/HKd6NC8jYuUZwLtcrmt9q+L1eNk3Ral5pXCq8Jx2YH
	uaYsl3ZlX7MK8WcCGUSmlWNVkPzASuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-t-ysPoGKMRWkqr6odZIe2g-1; Mon, 30 Jun 2025 09:01:22 -0400
X-MC-Unique: t-ysPoGKMRWkqr6odZIe2g-1
X-Mimecast-MFC-AGG-ID: t-ysPoGKMRWkqr6odZIe2g_1751288480
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so1644225e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288480; x=1751893280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqdlPSrzqUfx0/Anfl8VFepfeUNo5Gqwl7mCFswBHro=;
        b=bqOJVx/m/YSDRmO/hjl0cH0IAcrvtwewBdcWkGc3tzHt+B4hznpgcj/uniIVeuVPsg
         c8A0goK+nh/EoGvsoxJYQmRrRpUip3N+bhQ3r/f2uj/kKo1g8FfbUFDSAVTh0GPjPmFa
         9f5o3wk//4sczSp+Kunc/bFscGuoixquoo/vC/xq3tNOTdsUat+O0Tovhrk//3M3GfSq
         87z+jyEk15i0wkUaaWWqpYsN85gcmgnwT5hNpPuebUTURvebVP98JaQrZI9Bx/6Wz6tP
         bdnXMUH1g3nZ4+TgFGeClpUuIc2gQvVvGXuLzFocSlaljqjZwijZDOpBtGLQkIFRS2Nk
         Svbg==
X-Forwarded-Encrypted: i=1; AJvYcCWpeaXRQdCmw2/DYrwvYfxViM0PX+SdWqN+Y6RPh1jQ4Y4T/5NSGA3PhDIYTJFzraMzPnZ/yuVuQGcD3DYj@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqHkeo2VMYx8df5JnFY1IGsH5VMRFdGvNxaBEYAUlP3AwzMMf
	lxr0og8NIFm28Axgfn924ABAAvhNi/x9YNrdA8475GPowBaF6B889n+HqMembEBF21XoFrU9n6D
	eu6MNKRyfhpdvksJRARB9T4fib5r3TVW+p+xahXOAXEJZ72VyW76lKoVxPzh0LkLrWqU=
X-Gm-Gg: ASbGncuAOYW2fw00vJ0/r8aaQqsbdput/3DPEZLyhmFCzwJdrsWklqp63Bc4lgJV5TC
	UcvoRsLSLnrYjj8591KkuL2QlpDde9VAUaCFCRXEZ12fbbi6/EKIzD8G5ivrtzosHFi4/+TyOST
	ONtKVVaFHU1S4a9BzeX0E3t6QhTqzeAYQcNToA/1SXxgVKV5adL4fBWHrTP4pVXEQclDWLTMjvJ
	3PD9E28qRMpjPapHo5Rt4x6BIzx9dptx2QryCIUy9IN2Pv8tDCXA0jgovEDjHp2HcaETuOb7wRY
	rggH3ZChmZvzhiZq2sVNcuukKa2JFCvGm/Kp/dB8qQXYgKvt3+zdvvPgJTQhDdPr7L7dwLs7RxC
	GrKi0WSM=
X-Received: by 2002:a05:600c:190b:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-4538ee4fd6cmr142842195e9.4.1751288478936;
        Mon, 30 Jun 2025 06:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIe1HafHWQMdBGxTE/8gmXCwDECQtvb4nkW8MYtHAgLmX5UxDUSKKTFebF7rirr8hhXGCxDA==
X-Received: by 2002:a05:600c:190b:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-4538ee4fd6cmr142840675e9.4.1751288477814;
        Mon, 30 Jun 2025 06:01:17 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e528a9sm10541491f8f.60.2025.06.30.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:17 -0700 (PDT)
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
Subject: [PATCH v1 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to PAGE_MAPPING_ANON_KSM
Date: Mon, 30 Jun 2025 15:00:03 +0200
Message-ID: <20250630130011.330477-23-david@redhat.com>
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

KSM is the only remaining user, let's rename the flag. While at it,
adjust to remaining page -> folio in the doc.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index aa48b05536bca..abed972e902e1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -697,10 +697,10 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * folio->mapping points to its anon_vma, not to a struct address_space;
  * with the PAGE_MAPPING_ANON bit set to distinguish it.  See rmap.h.
  *
- * On an anonymous page in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
- * the PAGE_MAPPING_MOVABLE bit may be set along with the PAGE_MAPPING_ANON
+ * On an anonymous folio in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
+ * the PAGE_MAPPING_ANON_KSM bit may be set along with the PAGE_MAPPING_ANON
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
- * structure which KSM associates with that merged page.  See ksm.h.
+ * structure which KSM associates with that merged folio.  See ksm.h.
  *
  * Please note that, confusingly, "folio_mapping" refers to the inode
  * address_space which maps the folio from disk; whereas "folio_mapped"
@@ -714,9 +714,9 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * See mm/slab.h.
  */
 #define PAGE_MAPPING_ANON	0x1
-#define PAGE_MAPPING_MOVABLE	0x2
-#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
-#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
+#define PAGE_MAPPING_ANON_KSM	0x2
+#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
+#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
 
 static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
-- 
2.49.0


