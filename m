Return-Path: <linux-fsdevel+bounces-52079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABC2ADF4BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3652117055B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD947304337;
	Wed, 18 Jun 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHCzLiRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC07304301
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268487; cv=none; b=jQ0mMh8/HRLP/dSvXcjUwPEwErfbicxgA0YvcUbIv0hb4WD1gTa/PAzuJ/dH4yEq7wuRkEAWblDC0JBFhr9mVi6C1pud7QkQZEyYVpNCyj3aqCyeHKenZLXGu8lEz1BTertSye4siy1JCrE+uhuNwJ7e9IPY9CkNN7FB/RyDqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268487; c=relaxed/simple;
	bh=/g8pHF1/RVrgJ0Pc+SNNZki6HQmNZWyjtOO510JBXkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZFefF7Bx8Ound9zJ2xsdr5ydWCfSNr73PIHBQKKrfOiP0tZqlU5NShsQSdwVPcMUxslEyT+Gs3DB/YxFjoFY2lYqJrYfuzJwDdhIn/pWslepIbmYVsxARP2v+LzEvXsXmcP/yDV5Z70WcQVSSczjvmr1D6B78wgtH28qVhT9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHCzLiRZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdeAYiIbvuQl6YyCSbJM0KZ+PwGvgoJ4GiSuuebq9Wc=;
	b=OHCzLiRZFNhP+c9m9Q1QyMlV5ds+XQi8PFXcszFCt8tzflNSr53x5M+0V2RLmxahFecUPM
	4Mlt8t2aC5m0czB2wuCFRdJ/IsddMoci+ZY2oxVDJWOUiozqEIi6FF5KcFigDabdCXt7bB
	dObxW9CtHKyl3Jcc2Ou+YgPfPe/bHaQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-i-nGkKHXMeqia8XvARTZmA-1; Wed, 18 Jun 2025 13:41:23 -0400
X-MC-Unique: i-nGkKHXMeqia8XvARTZmA-1
X-Mimecast-MFC-AGG-ID: i-nGkKHXMeqia8XvARTZmA_1750268482
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45311704d1fso40533085e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268482; x=1750873282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdeAYiIbvuQl6YyCSbJM0KZ+PwGvgoJ4GiSuuebq9Wc=;
        b=IiQ7v8CRC5Xs+Q3HRcLSZzNBY4TMADhY5IcxNoG10+7itS3tPwtmIU4lwzJdgArvHF
         Pdg5XITOTREsDVouMJQk1FdTEBZ7zgf8LqvXi0cL7CNiqbha79JeBDtxK+5+iVKU6T4b
         twgyL2v+EC6qEejrpgUO1Tbc6L2eL/OIi3/ajxh2Xo4QmiTau06kUb2Ksr6JcGdaXsTi
         wqEHbcEq3Rtuyz+CT5EnKCUFhyszxAXYjs4fKHHamHJz0H2WRqk8kYdyklL+S98NuqDS
         h12B/4ohxhCYvhNsWxSTHJOK4flHZ4SzrPYfqADJ/kL9nbV3KsMSEp2KCPKZ3Ccioc7w
         f+fw==
X-Forwarded-Encrypted: i=1; AJvYcCWMYbexdTsEHVHHI77OywVotsEgDCVvbXre8i2JhvcXRvVdyjEhxIoHm71XNKcNVvVjmRH/5CTRQPXekOs2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Iye8Gr5MusBAlX5kS8bVlyFwdHoPByhCr8YXgxgoBM7ucGLW
	/UrueaZH1D4lnBt6TCGk+ClDDpwTMASM0GWVI6lmVc/qT8RneDrqY9AOM23YI3k3NCQreXdug1O
	KKy5tYRxJXFs5RRflzs+8WFXYO6yr9fKr34ZqgeZNdhzFpcg05L+L5XZy1KUDYnQp9o8=
X-Gm-Gg: ASbGncs3o1PHJHgch/zeRGonFjvMbP/LevgLauDQ+tsu1t2ZKv7lYZBX4rXlD8FxeFl
	4otGnpMA4KsOG+WoNjxcGc7xAGTDENrUTOQWJ/9E10T9ByOQtm0OLX20t6Gc+tg+G+9JVxrLMdg
	GU40O91YZHklTIaAk6gdFN6y71wvW/Ok/7ifi4x39qO5qz06vNGx0pmOeuHrcpxHbRt40eUqcIs
	iUabX5EHK1vMpkGkQVSoJD7chJrY68zq0pR3vYHroN3wQefD+tQvSU1t/RIPNFMYTiL8DTjpWHE
	iRTq643CSOwgZSyFEDXfh/OWK0h64gDf8VMtwQBFYPwmN0hITErhETpXUqTZGeNxbh8jtPNgbCd
	z8MyYzA==
X-Received: by 2002:a05:600c:3489:b0:453:78f:faa8 with SMTP id 5b1f17b1804b1-4533cacf0b2mr167448125e9.6.1750268482485;
        Wed, 18 Jun 2025 10:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrKZ8zfCrGufAh/HvE/XIf55Hjs+1HFJqQV1cfkKzvu6o7QRQJ1IpAcZ7M33DksKCqTfpzKA==
X-Received: by 2002:a05:600c:3489:b0:453:78f:faa8 with SMTP id 5b1f17b1804b1-4533cacf0b2mr167447475e9.6.1750268482090;
        Wed, 18 Jun 2025 10:41:22 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535ebcee09sm3315485e9.38.2025.06.18.10.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:21 -0700 (PDT)
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
Subject: [PATCH RFC 24/29] mm/page-flags: remove folio_mapping_flags()
Date: Wed, 18 Jun 2025 19:40:07 +0200
Message-ID: <20250618174014.1168640-25-david@redhat.com>
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

It's unused and the page counterpart is gone, so let's remove it.

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


