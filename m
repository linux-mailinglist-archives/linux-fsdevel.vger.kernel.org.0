Return-Path: <linux-fsdevel+bounces-53925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A17AF8FF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353AE5A1E60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7D2EE96F;
	Fri,  4 Jul 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv4e5rzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958652EF9A7
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624736; cv=none; b=aJKtj6M6jdw7cU/T3uHnjnQSuGS/3BJngpD4r4EZ1otSTrfesRByspwla6K0NRzLay20QIGBM1cMombtsoW2OnmG62A3p9mHtzb3HqJUlszPggvTgD9sKtYYYOoAonFp1VjvOlU3VAr7Nm00LQCSPEhrQXEddtQo/4YZujayADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624736; c=relaxed/simple;
	bh=N0i0mDmhVdZqrTyFYSoYTge/lbt5vfjL3ApU/H749m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfDVLGVqdjFmadBVmo/nSIOgHXURXpa3CdjV7NT1IkPNY2TK9CtGo/inFItc4gYbz+a/E5tP1rdsRcnOk9FSv6okWfpC2aIyS2fcnvcAmSrOx/f3OQiqjN4HrdyoI1N9OQfYI4djjjrcU7WEceKrqW5V7ONJbRgRyA0s+VOopvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dv4e5rzU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQQqBmPuJGjYXvvpwjiHFMj2XowEg2vBjzCyliDZdkg=;
	b=Dv4e5rzUQuJCJ7ENSuydkFd18om1f8WJUMM3YG8INvtYAmiObPBojwsb943cyS9gzH0Un3
	NRufT3WHp88ntXe/muVCv3syPsZ1/IoDnnEQYnZGE1rEfILbM6eCHVu4VQ6jeiY1JN+y4w
	OuqG7S9UlZWH2cRKBaZ8BAvOblK/4Tc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-htLZck8xPceAG4Yx3aeE0g-1; Fri, 04 Jul 2025 06:25:32 -0400
X-MC-Unique: htLZck8xPceAG4Yx3aeE0g-1
X-Mimecast-MFC-AGG-ID: htLZck8xPceAG4Yx3aeE0g_1751624731
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45311704d22so4285015e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624731; x=1752229531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQQqBmPuJGjYXvvpwjiHFMj2XowEg2vBjzCyliDZdkg=;
        b=oC/0crRnIhjkSdtUlUftbywJ7vXesOqW4Ifi9LwzVppCm5TrgohOZR19hm6S1RMA9V
         0GIO4pzFJVS4h6Q0XSXhb6wCAdMzmjnz5Ek/zccCprTHeNkYS6qoBefsb4yMfcZpj3MP
         mIz7x5nRz33GwzSiktoKH0OyjFZb0s7QStQk4cyW8nleqF7HBgsyvYsARDjCatNoC2Aq
         g1Xa1M/Upb0IiPqiX/odeQFui2Wc7xtZ3/TJFxfuzoLr4MCWtaj56Qg7N15i6+kvY1Bk
         wNAAxK2QrrWBVgd5BdI/eRb5IBSy7SWBDQrjeuAAHxMGlH/jJh+d6nYkElbZ9sGNOMgh
         8lPg==
X-Forwarded-Encrypted: i=1; AJvYcCW5xnQ2NpkGg3a7xm62RpkqeJxHFzad/+TfDjwsxPzVutbfxFLYMXnTNZf+tb/gmhDsrf7RkGZYtkF09tD4@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiHSB4ZqaD67vjhDAkmTR11dtEah1t/p+zsDvgCYTn9R+ZZ9T
	u+myc0U/qpFIV5igouP62C8HlLJJRE5GLjoOqNseDnN49obvPkILyu4f9FWYEzi1Gd/EJMRQNND
	VHirHnX1+byVxTOgLyZYDCvMBkrLklmm88da6pA/KEkUJvVV5C/pvVPxtC3ucMRHPaWc=
X-Gm-Gg: ASbGnctf2IswbdrJuFTFk6BW4H0r+GFllur4Lw954p5yPezq/pcM8mHnbltVXDpUwZx
	E+/Np1Tr6J6nWQZxly/6dMZy3TK9oMxXMcDrSG3eiNDEazI0Xm8MyAzhRQgNHmBxt1VSqhBDCl4
	2IJH0IrpJJ6Q/kXoJMXdAWHq505rCqpPv7zDUyJUoWe3Jcm5uQlyuyEED925uYxNYb5h8WoW+Vt
	uR2BJFw9KPeLNF0dhxEtFh4ahi3saTyGNDOBUAqYIHFkBvECzi8U30tekXYrOEM/tRz9c/h1xVW
	+/11yl7myfMQQUvu4cIMit52I/jh0aB6e/dN8u4GKX87ItaIxNc/Nm/jIzUXyfjxpgk+Mz3/K9L
	geQtU9A==
X-Received: by 2002:a05:600c:1c19:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-454b4e74ba9mr16507495e9.9.1751624730934;
        Fri, 04 Jul 2025 03:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2JCKcFSESlucn/AkzEEQU5f9yWEwz5OrnoWVnvSvIPUgrXnOXbfSZDcsxaTgozbAMtqKAdQ==
X-Received: by 2002:a05:600c:1c19:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-454b4e74ba9mr16507075e9.9.1751624730349;
        Fri, 04 Jul 2025 03:25:30 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9989fcesm51185055e9.16.2025.07.04.03.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:29 -0700 (PDT)
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
Subject: [PATCH v2 01/29] mm/balloon_compaction: we cannot have isolated pages in the balloon list
Date: Fri,  4 Jul 2025 12:24:55 +0200
Message-ID: <20250704102524.326966-2-david@redhat.com>
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

The core will set PG_isolated only after mops->isolate_page() was
called. In case of the balloon, that is where we will remove it from
the balloon list. So we cannot have isolated pages in the balloon list.

Let's drop this unnecessary check.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index d3e00731e2628..fcb60233aa35d 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -94,12 +94,6 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 		if (!trylock_page(page))
 			continue;
 
-		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
-		    PageIsolated(page)) {
-			/* raced with isolation */
-			unlock_page(page);
-			continue;
-		}
 		balloon_page_delete(page);
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
-- 
2.49.0


