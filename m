Return-Path: <linux-fsdevel+bounces-53929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AEEAF9015
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A37B6373
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB22F432B;
	Fri,  4 Jul 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkkQMC71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A582F3C3C
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624748; cv=none; b=pI+kIYZ7uZyFWbrwAec8wSiUZgG7owxrBhupbbVBMOr8dCfBTEAvUdVM8vSrAuZTxfVOqJb4rIS2i1gUfEgUkczYWp907CSZ4/OAUqQ7BhAaRBNhhursS1OpgYSoJJHUV9QzH1YY2IaCtBHNYk552w2HOXvM6kE3xLlHcKqTehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624748; c=relaxed/simple;
	bh=ALxPszCmVcU8TjBy7B2t3BqkreYKMgNug+n8yrbc+Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSMabOQgZAoU0ifV0z7gDsIh9C673zmK5940MMHE/aAg+3/QSkY7kX6ODmQWIA5oWjqDSrivAVc5wit0S0PF4VkULfaqnDwf2oi1BNz+MVp1G+z5VZODqYPgXxmpibb/zyiExcudhxcbxoUHxHzE4NtJJhlPWhCC1tKXXVwJ8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkkQMC71; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4vricv2e71NWYYMzs8BIQr/CRgQSzBMTqlFovEI9fk=;
	b=AkkQMC715yGmSovBRIW3z6FKfftarha9NjRCKC96i1kcYfAzI/dwgiVPY4uuYoy4mKIdp0
	uokh3MYkcSTj7o7q9s+Yv1EsrE/Iv4BVdSxXzddURdgpDiVspuRVN1kaG4K0ejz3zVAuIk
	IsdIHfNcK7UBcydtu+6h25UYOngKtVY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-qNufDJhoPsewUhAZ7qv9fQ-1; Fri, 04 Jul 2025 06:25:45 -0400
X-MC-Unique: qNufDJhoPsewUhAZ7qv9fQ-1
X-Mimecast-MFC-AGG-ID: qNufDJhoPsewUhAZ7qv9fQ_1751624744
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso354621f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624744; x=1752229544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4vricv2e71NWYYMzs8BIQr/CRgQSzBMTqlFovEI9fk=;
        b=Kqjinsz6eiRU/+RPJuQL9jyFilBz5bBBA0g1so2lZGaS/hPxuvPi1lJQCkc/fM7RV7
         47WMMbK2yRMTnperuyJqaDamyubGkENBVouJdHJOws9xdHZMau7EOAbvw9avCQRWom86
         valnHm9kUT5kxkniojYyq+E+lw0bF80pLo7fJlBThB438bSh3wQC0KVz44tM7HknVfuD
         sIi9VNE1XsoEpHneGYC4G91canlgh+L+RdqbbMKtBlJihxn1hpxz9xuzXWbbsmK+jqvL
         IZrsBFlemFeov8UXPuTudtFK3bd4IEgKij71mYGj+8kJr6F2uDIpqEv9zV7Bohu8h0cU
         rMiw==
X-Forwarded-Encrypted: i=1; AJvYcCWtCVrf3/vYSh+8IkEokI/j+CIyIs7oZoaA2NRkVIX2d0aVzlSRHfkHEhzObvdAATCzMMjk5pk0roEG91rP@vger.kernel.org
X-Gm-Message-State: AOJu0YyXessgSzRmZzTE+RtlBIPQ2Yj+wrh6ScKWkjVt7KMx2j9M8AAW
	pLiUe3qG+STWKtHQXYFQmkC2KSzXt/kYXQyJDTDnUPdxFLT/XzCgj5uAOh/UgaqEf0x+aMhxlgV
	P4DpbHmcJq8HznyFiDzVBZDLB8NBKzF3C6yRHYZl4O+KSqOevdCqCy23EEHXRaVQuXCc=
X-Gm-Gg: ASbGncsSfFO5MfBxwgwDcP2ToCNMiorKuQMANEunFg2K/IhAzjAOr4g8sWShDANq4Ra
	d3A3Iz9T9oSQcjMlPQWuWww8k6JvUxZSVtGaPm/Oz/G05+VpO4XJu8+HtmL4mN5vYihIhUKxTF+
	cPSl7TGiArd4F3HHQOvmufkoIZI3vOaMOND0F/fzvQUA/f1kW5hLRW79L5OZ36g5vY9+bSc8lZa
	3RWXD6Zvfa3g0tpcoWo+5jMpg/yEewyaj1RnpDUr0Rqs3rou1bc2BNyyGsf6CjZfCDtQvjnKH7I
	HCj+8qupGTblb9hfOmNwsLxfSxU8PZHMJ6uxEEnBwGoCMytrp5avBUEEQASjCBRG17RcKll7wdQ
	U28uZaQ==
X-Received: by 2002:a05:6000:25e7:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b4964ded13mr1424184f8f.31.1751624743642;
        Fri, 04 Jul 2025 03:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFw2GicaPInsB28PjQGll7qbBWs9+u0wQOGd0rdAKVxiB08VA9zODFfDmMz6Eob0+nsp252Q==
X-Received: by 2002:a05:6000:25e7:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b4964ded13mr1424048f8f.31.1751624741867;
        Fri, 04 Jul 2025 03:25:41 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47225a2dcsm2114225f8f.71.2025.07.04.03.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:40 -0700 (PDT)
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
Subject: [PATCH v2 05/29] mm/balloon_compaction: make PageOffline sticky until the page is freed
Date: Fri,  4 Jul 2025 12:24:59 +0200
Message-ID: <20250704102524.326966-6-david@redhat.com>
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

Let the page freeing code handle clearing the page type. Being able to
identify balloon pages until actually freed is a requirement for
upcoming movable_ops migration changes.

Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b9f19da37b089..bfc6e50bd004b 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
 		__ClearPageMovable(page);
 		set_page_private(page, 0);
 	}
-	__ClearPageOffline(page);
+	/* PageOffline is sticky until the page is freed to the buddy. */
 }
 
 /*
-- 
2.49.0


