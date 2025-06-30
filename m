Return-Path: <linux-fsdevel+bounces-53358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76190AEDE5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E065F3B483D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9929C32B;
	Mon, 30 Jun 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rk6/q1JN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0402299922
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288496; cv=none; b=TeL3PuzxOT82hXshaQ5SAZ4lVHhqwfa5yWHxjrzNqwrzI3XJmOuU5fCaSWny3cERF8YPJnZQJzX3M2wt4CZj+WAAHbeEoVAR7v2pQTFzgFYsj6K+DYNQSQRneTFu4MMY5lQET00+Pdcne+rZHqsL4Tnq/Kyz43FOUfVZSVYvQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288496; c=relaxed/simple;
	bh=WVagca6sn8mP5NDz3wa45UlfrVOPRD5IKy9vkw5Bh+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGWv6fpNP3uNGi26UWHpAup9O3twzhGvCmon2WlqP/D72Ky36OlVPRyIw4mhS7DrQIixWzR4o4cKmVwl9WhR29WA2uaiDSipU0B2MWkYSAbsGkIR6ZPVw1qYhPiyw5wz5aSrR7OGdeoil2vNA6FAblwqMYe5vNI0Gtkx+/2HCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rk6/q1JN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNIKdrm33pmadL5+MWfVmqXzrIDEGwSSahCLerJeLDg=;
	b=Rk6/q1JNAsyRt47c6rKx+4EWx0IkrlOxsVb7wHQUQ4y3OXUkV1q/iZmrWE2Y5qcbTepvlv
	UmUMwPyESeHX5mUjt443GJx9m4yKIEgvUerWaVKh1caWpQIM3kkPyxkrt0aDbFdC3evplv
	kIxhye7AFK6BXtGL21FehgRLlR1YL5Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-mr5hHWBrM8uFHuPv2HWESg-1; Mon, 30 Jun 2025 09:01:32 -0400
X-MC-Unique: mr5hHWBrM8uFHuPv2HWESg-1
X-Mimecast-MFC-AGG-ID: mr5hHWBrM8uFHuPv2HWESg_1751288491
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso13586345e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288491; x=1751893291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNIKdrm33pmadL5+MWfVmqXzrIDEGwSSahCLerJeLDg=;
        b=EdN/W2hQGMyTu7JgAky2zsRGu+rVawficBNlj2SPIZ8MQTJukZCidSj1OpX7S16uFa
         mqtpbBF6LxWf+WkkZ/qxERkNdgNIeEqezfUfvjDH1O0lw/E6yZo6qtY/U1sNxFmlsmUn
         iNyXGPY6F+1Vb8a9ohsclojkKTq52Fs1v22lxs7jDshZb+1GyNqiuWLbkBVdWxH4t12O
         meYATkKqjP+RvgngVcMGNcpcbkSZ7Vtv57we5lw+3ciHCp27bSOdnXU/RDIrNOOj2Tcd
         A66M3P74v2qvzrkp0mqhMSVcYTWg3JRqNKJxSxwHIhESZiA4W7D4eg6pVVvhjkG+ZQUk
         NttA==
X-Forwarded-Encrypted: i=1; AJvYcCXM8mNXvcScYgpa9uJiIlQQGCMO/ist+NRR7yGLC/bX4QwWQOsOebl46XUna8kD4BTFGrILEaTP1ZgtMPjn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EOaLFyk0SO0NXkl8FzKHPD+rdm21qrL1babRK0Rrkz5ChTUx
	4+ns5Dgnv8m6h67KpsJ2OaEVubmjIrCpw+46qrAAuDF0ujlufCp+GNqXi+qGv4OisJhwqqnW0d/
	kCBEwO+9lXLQZcqEKpwMmT3Ys4kzWBWGl+0l/ASuU9hkV9SDrwVATZnxCbIoF2Unlr0E=
X-Gm-Gg: ASbGncu25HVctLx9PoXPXk+IKtnwvqzEJeLsooAgqehBm5Xa8FTQbmko9mkSloM5KS4
	ycba2hyFQ3v6iQPGN/aeR+GY7ZHhVfSw9xFuTx2KbsoiClhYJI8Mfl8vmlnsDvOXTv+1u5VndWJ
	TAOyEEc6jJSyhH9ZnoiEK2y7Ik3dXg3J6nsXnbxWY87DQe75JGMFnKS2P2f9b9w7ISNKhxfQ7P5
	TgzyXRC5jImH45/6idrJiqwT3elNooSCWILGWXY+SuBaMuJSDdQeMKgE41sc6W2Ytlb9bTqQ+S/
	tneIW8uLLj/pT3lILVqrWN1wBekZF9PML3eI4T2hwc/mxlxrZ4AqAQXfMAvOPvZDyszxuMRBiCH
	dfnGVjQ0=
X-Received: by 2002:a05:600c:4fd1:b0:453:6f1:bdba with SMTP id 5b1f17b1804b1-4538ee60a60mr107461155e9.20.1751288490670;
        Mon, 30 Jun 2025 06:01:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvKPbKK01jDGKdO7HMFpJHGVfeP34xEfryqVjaTqeCy8FfNy/5uAgcgaE7N6g1euFItwJ1Ng==
X-Received: by 2002:a05:600c:4fd1:b0:453:6f1:bdba with SMTP id 5b1f17b1804b1-4538ee60a60mr107459575e9.20.1751288488983;
        Mon, 30 Jun 2025 06:01:28 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad01csm166146565e9.22.2025.06.30.06.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:28 -0700 (PDT)
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
Subject: [PATCH v1 25/29] mm: simplify folio_expected_ref_count()
Date: Mon, 30 Jun 2025 15:00:06 +0200
Message-ID: <20250630130011.330477-26-david@redhat.com>
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

Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
folio_test_anon() test only.

... but staring at the users, this function should never even have been
called on movable_ops pages. E.g.,
* __buffer_migrate_folio() does not make sense for them
* folio_migrate_mapping() does not make sense for them
* migrate_huge_page_move_mapping() does not make sense for them
* __migrate_folio() does not make sense for them
* ... and khugepaged should never stumble over them

Let's simply refuse typed pages (which includes slab) except hugetlb,
and WARN.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6a5447bd43fd8..f6ef4c4eb536b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2176,13 +2176,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	const int order = folio_order(folio);
 	int ref_count = 0;
 
-	if (WARN_ON_ONCE(folio_test_slab(folio)))
+	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
 		return 0;
 
 	if (folio_test_anon(folio)) {
 		/* One reference per page from the swapcache. */
 		ref_count += folio_test_swapcache(folio) << order;
-	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+	} else {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from PG_private. */
-- 
2.49.0


