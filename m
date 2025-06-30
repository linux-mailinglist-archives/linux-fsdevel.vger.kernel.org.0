Return-Path: <linux-fsdevel+bounces-53357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E71AEDE3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD0B7AE85C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CB295D91;
	Mon, 30 Jun 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXU89Dh3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5E293C52
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288492; cv=none; b=NDRuOiiiiY8gT/3s7TjoGCJTaM2NlpbmRwNX5H6+Qlk1I8+awz2yaV2eyzogLo/3qwnLq8zrQeqFsPn0ZESZwoGY5trNklH/t2zAoVkQeoSIYp4d+xdjhktWXbZSGz9qodwvFMvpnGlcj+tannwLXKj3ZFDaqyvUxeS7av2aspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288492; c=relaxed/simple;
	bh=isaI58t0kWAv0VvFIE40k9qBORzA058ggEZ88nMmJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZehQv9TH+/S2ixPcbXTBTyMBgUPPGEwtwHJmXxRLroXdpD4ZqX2h1UKa/QmWNITqPGh9ynBSakcw/tKUahRTTa2v1vqOUOQ26yNzIvju/Gf3J1KcbYaFeh0jqdfJcLNTXHegP4EImMkBYO10bME5VJ8cu66qztMOX/t4iMi40Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXU89Dh3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olXYTUdhc5G5HcwZfX2j4qOOcGFF0hDyepBOzPt910g=;
	b=BXU89Dh3ZiISfDbw6nfDn7paY/01Bk3kRAGjnOBK7sZlaZ1YQyjjS4BLSug0NYziwdYUuj
	VJxm4hX2WpS4F4Un9WVRGM2oADtuYbrpgTfVeyxaM4d7fpcnra229AQMRxn0eP1DWpO+AW
	HpYOZabQlQ8PqW/2shUcmiP9T4KIjJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-VMW42qzXPROf28_6kjP8Vg-1; Mon, 30 Jun 2025 09:01:28 -0400
X-MC-Unique: VMW42qzXPROf28_6kjP8Vg-1
X-Mimecast-MFC-AGG-ID: VMW42qzXPROf28_6kjP8Vg_1751288487
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso23510805e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288487; x=1751893287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olXYTUdhc5G5HcwZfX2j4qOOcGFF0hDyepBOzPt910g=;
        b=stkri6X7ydItlS4IF1bHJTN89lq0Nx4w46xa+f6AoFu+1jGspeAhiHtbQWUs57ZOLR
         V/sw7sLFR0NiMtiNPYGRQiMe8w9CmLnC/RoZT8GRJmJwrzSKC4qlxUnCgHoIMptkDTAF
         dExztZrDBgMS+DzZlDQkPJwf/8tbo2+iarsb1aApqGKhvP7Bp/crCv6Ggm8mOlAgwLU/
         kwjnFvh8JBLlw+Y3oiuEOfQrYXpespr+6owe21XDe1ISyKwidicjtBZrqmqfWMhvz2TA
         ch/GZbTWDe8qb+9PjkMQ14r4MRsZokpAe8clWj4duYeAO3QT24KU0tOCzIJ0dsFocLFE
         ULFw==
X-Forwarded-Encrypted: i=1; AJvYcCU6/puzRgoQYkF4OqDa9wUcVudGdOc+WBjMu+MgBL89Q+if6Iykw3cJnFOi5Bc9yRqg/j4s58JJV31EHh2t@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcao5/+4BQ67yMrH1AurUEuUgQpg2oz9TL85Rt6AvX0sYVqTjM
	lbsUCH6tuQYXg1ACiAQw/yt41nPbaU6Dz+r6YZPJZpUZ/CaQOaWn46LKzf/LRRLRMS7F7UzVm/l
	bcsbFMgfHZlsMMV6QUDnJFZWFj7wFGnVDMl55Ir2/dPq7+j8Z/hqQ14tOQ8XYZHjuIgE=
X-Gm-Gg: ASbGncuMCo+3mXLTXD4UqAkU9MKuWX2/QKvSQyPk1EC91QPeIFsp1EiIhzh0Agu9I/1
	KYsgQfTEpcGQIWjZR7/rDOgRtv7s3m0zCL/nmTIAD2mZcZ50nrRO8P0TbLmIl+Xk3y1BBPB/Ym3
	9TpdxC+6G8mKl39C91pXVtpvrkDLVAf+FGxCHsO/VsgIG2+f126lGU4U7+VCNT3JKLPW3ZJW+cK
	zYKtTlL3j/yu45bzC1bngSfIJeEtiiTrnhGLRnYU06QUCMp3pLWLJmSWtbRORqYCf3QaDpVEAOZ
	IAFiFYTcPRPuz3TaIzdkWLaAw+GTqyy/bNTu5ahrQ7myZ4KQR2UzB6BWxHnMsrI3EChpgpNzxoN
	1MGBfqsM=
X-Received: by 2002:a05:600c:5306:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4538f308f2amr124064685e9.13.1751288486311;
        Mon, 30 Jun 2025 06:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9JbLrxBujZu2VjgMn1mCOlcQzRUhKdRhzGdc0P5pPEt9jKXPpDvx4Rwh6D/+Yae/APwbOBQ==
X-Received: by 2002:a05:600c:5306:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4538f308f2amr124062795e9.13.1751288484673;
        Mon, 30 Jun 2025 06:01:24 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823b913esm162071665e9.33.2025.06.30.06.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:24 -0700 (PDT)
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
Subject: [PATCH v1 24/29] mm/page-flags: remove folio_mapping_flags()
Date: Mon, 30 Jun 2025 15:00:05 +0200
Message-ID: <20250630130011.330477-25-david@redhat.com>
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

It's unused and the page counterpart is gone, so let's remove it.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f539bd5e14200..b42986a578b71 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -718,11 +718,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
 
-static __always_inline bool folio_mapping_flags(const struct folio *folio)
-{
-	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
-}
-
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
-- 
2.49.0


