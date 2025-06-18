Return-Path: <linux-fsdevel+bounces-52078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E1ADF4B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA52A4A27F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17A303806;
	Wed, 18 Jun 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKS1Xflf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9A302CDA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268482; cv=none; b=tlOBt+XPApqycYY2mMnmucCRucpPKeZ1ce6fNhGYQnrZKpmqTliacuCd7kEpbcugMX4dz4ooOh1x/obSbFF1UWPaW2WN/k/o62yOpwnAm0eXKPbT0h7evpXBU00dRFDlET+3MZdTaWh7aNeQZhow84xSoJzngtz/JOzO2oLVASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268482; c=relaxed/simple;
	bh=7MqWYtvNLDCeRHTl94GzHGrw7bPzHhaA6ax/7SHlO8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWbZEdkPvwwCI71J+wqiAfw4FFUTBKW6BJiPqPfEHOctuZo/NujPjNZTmHp8TdO5v64JlKhAsSA09Nga0OegXeXzbgK3E2KwM2v9pwkNVFBJs++Z87+HjjfCQ1R4pfGEtkUFgJq7WKSG+LzRCbWfskkciv9L6t7JZFdjOyNnqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKS1Xflf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKAYn5W/PSf7oEyDpSl452LRf2zvea6hrq0MdbpucUo=;
	b=ZKS1XflfMbufrjNTh/XCijg4PCf8FU2scUO1BgMqz/LHpVd3LrU4GKeGUIFxFARUzLgFTK
	rYLoQp4Ktw5D4VaMMoVNm/4KP94itZxx/hD9g1c1zwNC4RIeJ0kPx015c+Zq7U0uh8T44Y
	0Cbdc3zpRDesQBsDtTgxWx97aiuZ7ik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-80BKHG7LNxGPheQiopiXFw-1; Wed, 18 Jun 2025 13:41:18 -0400
X-MC-Unique: 80BKHG7LNxGPheQiopiXFw-1
X-Mimecast-MFC-AGG-ID: 80BKHG7LNxGPheQiopiXFw_1750268477
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45334219311so28660635e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268477; x=1750873277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKAYn5W/PSf7oEyDpSl452LRf2zvea6hrq0MdbpucUo=;
        b=EifJqUpjS+MpxHab8UzLu9oAwop3/B4bS6EmVY6DPZR8WbzY8Ayp5GgkdHmL3eGX4+
         mumLULHJ+Pc00NHyOxglSvKV8ao6byqIh1bn+gEVKyEqkc9Ydm1o2OYRqLqjNF/ovjAK
         dTohOlU3bOKWJHgOPsiqGSdd6EfMVLPlICeEcddaWyopBZ52KPkRz6DdvHh04D8QrWeT
         CsaYWTZ8zayzlT5VC+pWHgki1XtSUZZUTBoTjtrJAOb5WD3bt3w8TmErwYtKUureF+OS
         PJ2xGcLH0rpY3WbxWFYBT/Yrbo6YvC6+jM5EoImVe+RfFfjj7aS31IFmSbNdXHcQ/aQb
         8hdg==
X-Forwarded-Encrypted: i=1; AJvYcCV11xOW25G5v1f6qtvsONleWTokL0s6D81otA6EKNCryKa5PWAYgH7GPj2GcUs+/+kyUdOC5FtSgr27Sp44@vger.kernel.org
X-Gm-Message-State: AOJu0YySMHTPAsa9Bjwdl8mF5061leY7PXtshhoPWi9pXd4OwPoUmBNg
	Iym6dqPNrlNhDuJx4sVuesYyy/LGzpjli1+ZFWK+Eo8aVrvoPeXkEhNKCv/YuCZln31Mo8JMh/S
	jCyEezQIU9rbCMNaeElAzbBoBVnGmEcTsugGBoO/v05F6vk5Bgc1XApvZuj9BjQcaAjM=
X-Gm-Gg: ASbGnctkm52KkAx5b1EG5tolXfp5oga88yA9QGGjcz2rOGDploKJqiMsj3+rfzj2N5U
	dhH1kEWenJCt2psAJk+2X0nfzrWlc/0xGMmozK09Q0h7Cqt469m6ADK156WHmMDOIgwuYrfp3eG
	n1gVgPpxxhco+uIGYnxNYwTc6Tc8jy6EltuMuJsRxoNFrnMCipXb6CXMLJId/TQw816dTiv3tTG
	9QvEjNUo7jeserp/dBNlHdmJ6shkg9V1xQ6ijktd52nh3nz8eUxXzfq7Y1xT+gg3sD0tiC2yWlt
	e3cWuGuD9H8ais/LvdwCDzeu4gK9rlwhUnCzcM1Bn70bg3T8t0gSVe4y/KMjNCBKqG/18AkWAYq
	DFquCAQ==
X-Received: by 2002:a05:600c:1c14:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-453430ececamr157094445e9.11.1750268477158;
        Wed, 18 Jun 2025 10:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENrfq9JZf2w4nH2VRe3EOokVKel4Rw1khN0dggc1dWhdYjdSzsol44AwGmQNvJE5b04zR6vw==
X-Received: by 2002:a05:600c:1c14:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-453430ececamr157093925e9.11.1750268476711;
        Wed, 18 Jun 2025 10:41:16 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b087a9sm17793395f8f.55.2025.06.18.10.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:16 -0700 (PDT)
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
Subject: [PATCH RFC 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to PAGE_MAPPING_ANON_KSM
Date: Wed, 18 Jun 2025 19:40:05 +0200
Message-ID: <20250618174014.1168640-23-david@redhat.com>
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

KSM is the only remaining user, let's rename the flag. While at it,
adjust to remaining page -> folio in the doc.

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


