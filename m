Return-Path: <linux-fsdevel+bounces-53339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E2EAEDDEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B087ADD4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9C28C03B;
	Mon, 30 Jun 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgkmDZwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBED28A1D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288438; cv=none; b=eWiW296sxKrj5Gc4wz0whVYgrsD2c3ygxkiJB9sJCT0jbcSg8YHfWGAcn9Pdt20urzn1Mq0s3WiUOBxj3qLb4/JNyAf+Yu/CHwhzVmQGUyT7ipxdQ45aREZD33kKp+NzC3BC9V/xITf0ApNhuduCDl9J7UeA5s+EjXWB7Qgv5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288438; c=relaxed/simple;
	bh=19X4bQvLwR3+OfNQbpdo9I8RjESqqjGAQVBNJ6TpCho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI+xDjQ63VOnSjtl18YJcCAaTpczujR8U499yzYJFvzTxPDvHTNyiEoSb72YjVn3ghpquB0bxR0KlFV8POSzksFDdosJ/5mH0NTy8ij2vLmB/kGx49COd4bORL6KdXs8Su+nP3BHBIpkbU9lk5PKkH6fmsJB85vUsOMwxpGJyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgkmDZwE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJlezl1jqk1KHM/JmX+CbcKO2aiRBLF0rBMpUlNHwJA=;
	b=FgkmDZwE7Od0H8zjv2Ox96v6kKOMt1Er2mUY6znRigr+d0lmyr6QI62Dbq6Jxsx+rJDqrk
	s+7jkpEPbemPbACkWdIzig35bneqnwmZGIOYrSwrSbvIsm92MPgjSU8Kr0ACLYTYIcXT52
	JaS+PMevcTlHm9WGyK1jQP815h02slY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581--Z08sRtENKSn70D0baJMQA-1; Mon, 30 Jun 2025 09:00:33 -0400
X-MC-Unique: -Z08sRtENKSn70D0baJMQA-1
X-Mimecast-MFC-AGG-ID: -Z08sRtENKSn70D0baJMQA_1751288432
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso1184554f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 06:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288432; x=1751893232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJlezl1jqk1KHM/JmX+CbcKO2aiRBLF0rBMpUlNHwJA=;
        b=OMzoujXrpPidEcJY9j+E6jT+l9c5gyOHYIQueWltYh982CM8P33xbfJg0m4JFIBBhj
         dDHnFnlIRWyP6Ei7qa49EF/DX89aOtqPNre7J9CRV0ZPHltqJbZoY6v2Mupc2Ds+gm0G
         mJgpEY+mt6E2DFHQDkoqzAFaHeB6VAK0nwh2qCmqhfSQ5L9CJ98RZ2h0YjuTpyDV/5Gd
         LKFjsEJ3RwSIyDpqfdAvh1S1y77TdCZAZmWh6ywM6uJ1bp63WHMx4z/+Ogc/EJ+qkpoU
         Knndd0fLOlzOWaavz6eI+NSvwQvI1q4N7TPgQikHAhBnc6rn/4NVQ66jE6Tp/6f9nrHK
         vuOw==
X-Forwarded-Encrypted: i=1; AJvYcCVRYChYmiuDj9rk7PYfu2iR655aR9MdJ3KewybNgJtDcSv5w7NJFs7kmFXaaBO2E+U/a/EocQnrPYfzpqoE@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxSrZ1TQWQho0Lq0wgDBeIb0LX8YeozND0liGJ+D8HJZIcv2+
	MEIHccgnwP3jkjFtnbfTamtx2Zk34gz0+Kyccgu/+cj++Z4nuhAvHHVHCB9WfKZHRp6xHU+nR26
	WDlykHy7KdJTiUgNBxpBS9H4WgLf4n5tHQfq2ZqZvQxMLmDHAl0p8zuHVFysDuQ6NQk8=
X-Gm-Gg: ASbGncsxWGhZluJFf8OQK0CUoKFZwx5kL/n20pCDpAhlsd705HNDlkT2qTwvW+UakPD
	ejBS5DZWCbIQbZSCF4Qopx5Jy2k0m4RZixrYev6pU/FOI4HiA52caJ1U+2bNQItxGMmMYA+yexD
	DYKsh0rWY9BEw5Ef6FeHmvZmnsD0LEq70iT61+W+Z2MiBM7rlv7iMEKzNoqg7F1aRJlAc2sPKTp
	pzSzioOoe2HuGdjuJyvXv7tsqMY9+h2wj1KqgoAkQxXksKGpYl3+T4qzcnpgeqacxkt3caFbXWh
	KQu6SeBnzRttEwwq6OJAydBwZTAzak5ChFvjiwnmg2CNoWf47o71+9+MqYCTpGpZmspjKLfFR0e
	Ut/MecxI=
X-Received: by 2002:adf:e181:0:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a8feb844cemr10501278f8f.53.1751288431555;
        Mon, 30 Jun 2025 06:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGEarPHGaA16flG07pTm8Y+2ZoBRaEqSqyGzIU15EPr/yTHmV5lKxwKCSS//XnEer0oKPVNw==
X-Received: by 2002:adf:e181:0:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a8feb844cemr10501216f8f.53.1751288430998;
        Mon, 30 Jun 2025 06:00:30 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c7fadf3sm10557609f8f.34.2025.06.30.06.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:30 -0700 (PDT)
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
Subject: [PATCH v1 06/29] mm/zsmalloc: make PageZsmalloc() sticky until the page is freed
Date: Mon, 30 Jun 2025 14:59:47 +0200
Message-ID: <20250630130011.330477-7-david@redhat.com>
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

Let the page freeing code handle clearing the page type.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
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


