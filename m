Return-Path: <linux-fsdevel+bounces-53948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A9AF9088
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC66E1CA6122
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F72FD5A3;
	Fri,  4 Jul 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kg4WjpIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDB2FCFF9
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624802; cv=none; b=WbOaK3vRrhb1AAIpNxewibiHejbmWj605yX31ieiW6TTd/3E6bR3RY7wh31z3bdLtM3gItptOJKfsOmQsg5DYYsQABY4OcrQ/PUjnUHGV1gQX+Wdf8Iezceaic0k2RAH8ep/ZGsUZYMntrptfFlh+4lNod1MlSpmjlPQv35J7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624802; c=relaxed/simple;
	bh=1ETQVwTWSzuFM96Cj9uVjywNtHELv/PpY51PqKnqH4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bImSxQVEc1pYe5Bg+FsDSbNUYCYVyOdVyXed98iPMdQbO3MZRfsmG55aPT3+18HInNH3xscrnHfHp8kzccrAnhILGVoEa1RCrruIiJiG7m7iOn+K4koyAAHyiDuoCgzSeDHhbSe3+kQ9rPm0LXLvr3afaFIPmyOVWjL10QHbPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kg4WjpIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiR5g77+dfB6TjFQFOB3xNqG4FRd5Im1/1G4CsJHDLI=;
	b=Kg4WjpIMmyvlE3jnyoCcv6dY3XDVGNFEgMH1Vh35GzAeJyqKV+U5H+651dttLpSrVFnLDE
	TbxgyuiZSbOLm2N7/eRsvRpZ4NNh0tvq2mTbucxLVIBYV3mcYnATFP1ajjaJxhtMB/j29y
	y4P3dMBmgmQBO9M3RYvi4NB5/XzY6rQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-e4iG-TVcO3C_bwmz-kpO4g-1; Fri, 04 Jul 2025 06:26:38 -0400
X-MC-Unique: e4iG-TVcO3C_bwmz-kpO4g-1
X-Mimecast-MFC-AGG-ID: e4iG-TVcO3C_bwmz-kpO4g_1751624797
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so416267f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624797; x=1752229597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiR5g77+dfB6TjFQFOB3xNqG4FRd5Im1/1G4CsJHDLI=;
        b=FcK9Y2eDYQMcV1nMONNdffLQZMHntXCDccZ7idxMUfSF2evYeiZ/bYF+kNLzYiE9SU
         OWYKX6DKC88y92eYJqtwzdscAG727q2b0AgIL57cyYpoTUD48oIMoHN1Rfa1WnR+cg42
         4fStqKbBPSRWis++JEJeDPEjdC0NKly4gstlnjAD1XfLcsDz1yJqdSKrp3NfI6JPhKVf
         p4ReqzY8M5yqqyDLEknIKHujlCOwmmvPZ+aI0VCVwINg861ab5vq2BOrb+HEGRBDSFe6
         AicWMVx6SQ3ei51hKsJMnJchH4szZ/xunvxLHHCAXZdtvlL/LyHpVMJjA7IgXOqhgWbd
         CtIg==
X-Forwarded-Encrypted: i=1; AJvYcCUzZku3ntYCMXVe042/KXAZHNXl4S7O4kbKF4OMHEkkFU5DeWZc+rPseH5f/7kDXpm1mJmWPuvcf8ic98Dk@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlFJVhzBUuevUK0v84PoY8+ItSIiSl5jvVSN2oM3jii8BmBV8
	lCXPpSOQ1xnTtTVqFr3YpCfz6W8zDb6Xaa3a74Xo0argz/OZKTEBboVzXoXIfbaS/10dxPM2q0A
	pS+HyR43YPNGDfpgGq6u+VABmFYfK9aKhcJ+ol/6R14JQuNIZeceoA2qfSRuBp7yjzO0=
X-Gm-Gg: ASbGncubLpsrpvlH2RIK3PF7pxeOButPUWgLapIrKYoTfraY/Y7jfWSsMDEk7snWYgy
	+x/TKYfwBlbdU3m0DWiMZM4S/2E8g5TwoQEgorLRlQjt3gweN1rV0ATHTSbhPXcHlq1h2FGiUTE
	kB6Nmebm13zb7xz1wRCJZk1GwBVJaKGpp7B9a6l+UCziFO1CWVQEUVpvg+8n0RQ+QCJNuMXjVx4
	N4O36AcKQfWqKfLYXCoqzhQLbPi6mVKL52nzYAf+2UQ9xAgpCB7KB3PJHryAyk/TqYazz4x92Uu
	xKysoRNq4x3ybiNstzL5RG4wYZsAKZGlhwvE0b/JgtRgNQGUuvbjvJ97GibecUwPNiyXcMPh3tS
	OoybMmg==
X-Received: by 2002:a05:6000:2112:b0:3a4:ec23:dba5 with SMTP id ffacd0b85a97d-3b49700c571mr954070f8f.5.1751624796886;
        Fri, 04 Jul 2025 03:26:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtfbiTuj+217pme6OFEkgrGo09w9YBtXxahiaI+UfZ531v1EH5FnBXh5DrYfR2GN/01q/x/g==
X-Received: by 2002:a05:6000:2112:b0:3a4:ec23:dba5 with SMTP id ffacd0b85a97d-3b49700c571mr954008f8f.5.1751624796346;
        Fri, 04 Jul 2025 03:26:36 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47225985csm2148740f8f.69.2025.07.04.03.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:35 -0700 (PDT)
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
Subject: [PATCH v2 24/29] mm/page-flags: remove folio_mapping_flags()
Date: Fri,  4 Jul 2025 12:25:18 +0200
Message-ID: <20250704102524.326966-25-david@redhat.com>
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

It's unused and the page counterpart is gone, so let's remove it.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fc159fa945351..e575ecf880e59 100644
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


