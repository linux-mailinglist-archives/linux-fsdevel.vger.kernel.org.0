Return-Path: <linux-fsdevel+bounces-52058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD36ADF440
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34C7188C0D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988212F5495;
	Wed, 18 Jun 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dH4OutVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AD2F430A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268433; cv=none; b=WmMeAm8N5e/2J+R1HRs/0g41MeIvTxzuPJDYCsYvUo06PGFMLO1f+ke71hFoMDjP9TRudwQdM8I6aeWc0GXkw1EohRAYW9a1qBnTl5S3Uj7JmWu6AKGh59mJ9bvLYx829QpF2Ehw9TbKd3yohS2C+6M1IIOMH8UsB72EiQ5S2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268433; c=relaxed/simple;
	bh=LfUaIY7XKmkW22E2CA7zcjn2zCtCLb3wGZMadkbbvUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKjdlBW6xknIwFj4OP6S3WLwKGJPGX47VEQZwBbMI5fMSSEFJvgUbvr8Bc0aH6Xscw48KTo5NbHoo/VTqBOg3mZryiyTusmDFzAtMKFkwTCMWDSWsQ/xu/h8jLgQMNcl+eOMGdH2UXYLwvrE71+2rxn6OJyzgbD7umAipQO7DkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dH4OutVm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztkVXhL49uhBZn35+Dz91j/1BkEFGTeWr88qG2zBn1I=;
	b=dH4OutVm9vr7lGZ9zshGymz39lGUKJjHxcG7CRNS79LFLbbhWr9pXZ+Hwdnf8aZ3sl40Y3
	MY4+p57l9/b/iTO7yu83UBjtYsAZECKUoPPO7paKgKnZoR5gKGOiPMlqypdaXF6e5bKBLt
	c31lGovATsGFfGk83YaDO5QuBhCDokU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-N56Rjbs2Nb29bjSOCmQB9A-1; Wed, 18 Jun 2025 13:40:21 -0400
X-MC-Unique: N56Rjbs2Nb29bjSOCmQB9A-1
X-Mimecast-MFC-AGG-ID: N56Rjbs2Nb29bjSOCmQB9A_1750268420
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5780e8137so530655f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 10:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268420; x=1750873220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztkVXhL49uhBZn35+Dz91j/1BkEFGTeWr88qG2zBn1I=;
        b=QnCgGAwTVPMQWOc5KiBJvssmsNa/2t0Np7wnriwcFbJNFhS1eQhbqic513bAj0tM7H
         WoZZ9RUZBnnSfin9PpJgPROStB/w1BViwnT583kbCaRXtFX/tRFOK4UA7hdZtnp0UYrS
         YgSItYt1nhXbuuhD+8NZi4NGnLA5jtyhNHZwKIRf2bcgbX8xMbcyrb5LMDlxfNLmaEjI
         WBAHhoCSliC2w6miFw3HTVD8A2V9+6Ep7mOXC21hyzxDoix2QX537cP3jYD8pMWb6Ima
         KHhSs1JtGNtPRjc2CCjr2vUsX9jsNJmIEPGAjtxKVU+d0jgmG2Hmma1suc4gQyxPN4jA
         +vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOWARjl51J8VGZfvJuVoRef58HdcjIplvHflS24omfx7u2fpDtL0SOAO7jiNZb5xeZU9dXkCG9du1Ow7i6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzocm42o/vvlo3WcnTxle/DPaRtvQVY/AIC7BEzJiWAzduZRUv6
	7Zr5wcQRx+uDn1K5gRht1EGnb+aQnPMZPhepCwYxEvB9ZD9SQVVA09m8IQGw3ii1j/ZV/H5Y0iO
	hmf97Ot0Nia9Tgn7BbOdPKlzt6TPUzIc3pgvbZoWhv90qm7+eOWXsEWz62+v2npyJUJU=
X-Gm-Gg: ASbGnctL8quC+I7hMeJweX21NBC6xf4jylb/JGl5zaEnjHXpV49GFmKPAVHR97HYw16
	Z1hpP+TagOCURCsQTgaDID1hbDqh21DrC91C+oHN3sLnyJOICCGbDBYbrDiziImzcfgm7RxlUGF
	gZVbL/+alDolz4PTQi+1GwumZ1NGFLPQtxZ469jBNormcou7RwccaalXDcw3TnBD7b9GNHesAZQ
	enjjxxSM6YUid+14XvUXUFybZhp6EjiTj8mORdZ5obsdiWL2i3XOSzhX7Aou/ZguheLJhM+6MVh
	B/lAM9HwQwv8akUzhnffwNLUO2oY3vl6J3OS7a08l1RN6qW6FE6y7+OWns1LlhWtjIzS3POcjYw
	S9J0xUQ==
X-Received: by 2002:a05:6000:22c1:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3a6c96bde70mr478004f8f.14.1750268420090;
        Wed, 18 Jun 2025 10:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdKc/sogX7P8eUPuNrS35oj8SOpb+inlndXsECh3VUw/sMAlaRsKTNBWIAReSnT0M7eOt7jg==
X-Received: by 2002:a05:6000:22c1:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3a6c96bde70mr477976f8f.14.1750268419626;
        Wed, 18 Jun 2025 10:40:19 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b0898fsm17901600f8f.54.2025.06.18.10.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:19 -0700 (PDT)
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
Subject: [PATCH RFC 01/29] mm/balloon_compaction: we cannot have isolated pages in the balloon list
Date: Wed, 18 Jun 2025 19:39:44 +0200
Message-ID: <20250618174014.1168640-2-david@redhat.com>
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

The core will set PG_isolated only after mops->isolate_page() was
called. In case of the balloon, that is where we will remove it from
the balloon list. So we cannot have isolated pages in the balloon list.

Let's drop this unnecessary check.

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


