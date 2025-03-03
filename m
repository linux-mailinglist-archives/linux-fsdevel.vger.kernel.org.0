Return-Path: <linux-fsdevel+bounces-42945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB04A4C7B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9928A7AB076
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10AA215191;
	Mon,  3 Mar 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Riz2rWRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEF238D38
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019431; cv=none; b=QrC+Pv3sYsbom+uvCIjlYiB0VSvzEa2DS/x2kl4vNE69Tfm7kqT+jZM3UEhXC28XTrOLPV34i6NzohBkTIcwipczOaNaz323YPiOAHkaENDeHyg6Tci8U4F5AMVN5K7ZoJJN+aT/+GKTH8F35poNT9T4sJW0T5D29qo80qoSV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019431; c=relaxed/simple;
	bh=ixANMC3lPCVB+QxhgoNOds44O6e5NynuKFD7IIp9IVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRBW7991CDnT2DK08a4/y3S85kZJzUFzQtGR/Hjbq50jD1iF/zWA8vKAZSCVXdZ7EiVvmcWWHFayeIMUuTWuQhdyql5A2ObmLGFK66rYTFY4ZMslx8gz8YSAx1tdmxNALOFjx0rZPeQw1FpnUfqbGEjoZArjOLjxIzbAEYa1j7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Riz2rWRF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXsaZOoTqmrj90mJbBg0yoAKUyLdOWV9hsabR6NX2f0=;
	b=Riz2rWRFO3x5/chzOAssiXnAEfN9V+dv3CeWZ5SLSOdlzpbrzsf3MbYwe+yuEN8krCsUwh
	G+fxTiEBT/kC+KyOtkjCMjn9clsZ98euMgM4wrwatx7C2aEq2y6HrZWryxnOvoX4jS55dW
	hs6fk9SW7nlddUPBws7hBEUfulG4EqM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Kx_KW_38NQeZsITujuEJ-A-1; Mon, 03 Mar 2025 11:30:27 -0500
X-MC-Unique: Kx_KW_38NQeZsITujuEJ-A-1
X-Mimecast-MFC-AGG-ID: Kx_KW_38NQeZsITujuEJ-A_1741019426
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43942e82719so33182255e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019426; x=1741624226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXsaZOoTqmrj90mJbBg0yoAKUyLdOWV9hsabR6NX2f0=;
        b=WUg5siMI2qkptL8seWCkiwHHoRM1JFMJ9tatmPok29wjUWTfse0YTuDIzr30zUqum+
         kCRZu4vEOtL8e3KM6Ctb7MRhRpcFKib82xskGsIfGfwbmMgMEqETDkS803cjW5fWdD1z
         jXSs76oY77dX2gFGliTiSBYy6cKINagN21DyaC8Ssi9eYF4F+tXT2FzZOBXm7HKK0U6e
         644iKR3veQUA/5YOfPLcj2SnCN/Ug20QIYyYJNfv5RhhodNBooIs1M0cL5jPD7Kx3mfF
         +AYCyeYsFKSftuJR5RpfdnuESkEsD4tS1U35rFhpFuRAAvn40KxLeTjt+T4qrdN08RSa
         d0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVh3QkGjOIv9Jyb89FMUcA+XHOEFNKM6R6VcDJNXlzna6yD0SfZMizg5xVg1R6tgJjNa1Wh3sVTdypWhVRZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hbkuCbuG2FcxIKUGFJ7p9JAcCs+21yapvMNgrnS7oTvsgFSC
	Me71uN3nAgxdEwJe6EgJp4XxWw6UP0BnQMDDNME+FQhSrKXXLRnzj1qIFeBeDAhYWaeGnw8Pek3
	Ah9UrAda2GXJwkwy0ZhGSKpSc/wTs28g/keXJ+b0xl0UghGRi6AZYt/KT4QxErN4=
X-Gm-Gg: ASbGncuKxHPNMYodWA8OWwWteLRRkAaJ3REmMHxtn5aQkKpIHt44P6spN4jElkE/I/x
	/zoLgG35y9ONY44TuI5kT/cN2t9D9YG/Laz+deHj6NhEI7j0g0I01gErh7zl13e5k0icN4DOAdB
	IHVMSqrAc1MbG3+4pDxRWEZdYzZK5PJwnzXtIoIS0q/H0+KPMvN8q5AXDSx2Yxn1duRzA2ytqFC
	AHwloCAsjMLPCPC87mBD+fK7A1KZevwzJHsZhqZuW3aFZsDiS/dDlFtHN/MHJP9Ylgl7NsuEMHD
	46dpY4tzvgCTni4URJBwr0ulAFBvNqMW0XbAiY7wUvYG/m/k2X5OyaruKqvhtuyfKXTYHg2+4nD
	2
X-Received: by 2002:a05:6000:1565:b0:391:9b2:f49a with SMTP id ffacd0b85a97d-39109b2f905mr4268651f8f.55.1741019425838;
        Mon, 03 Mar 2025 08:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyH4J1EAqaHR0tUbY9OuS6FmG3s0lngE2eSOblLtE+C7Z78Ry//BFuo4023zOsYhDT+DJ8lw==
X-Received: by 2002:a05:6000:1565:b0:391:9b2:f49a with SMTP id ffacd0b85a97d-39109b2f905mr4268630f8f.55.1741019425450;
        Mon, 03 Mar 2025 08:30:25 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a7b88sm14820945f8f.40.2025.03.03.08.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:25 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 04/20] mm: move hugetlb specific things in folio to page[3]
Date: Mon,  3 Mar 2025 17:29:57 +0100
Message-ID: <20250303163014.1128035-5-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's just move the hugetlb specific stuff to a separate page, and stop
letting it overlay other fields for now.

This frees up some space in page[2], which we will use on 32bit to free
up some space in page[1]. While we could move these things to page[3]
instead, it's cleaner to just move the hugetlb specific things out of
the way and pack the core-folio stuff as tight as possible. ... and we
can minimize the work required in dump_folio.

We can now avoid re-initializing &folio->_deferred_list in hugetlb code.

Hopefully dynamically allocating "strut folio" in the future will further
clean this up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 27 +++++++++++++++++----------
 mm/hugetlb.c             |  1 -
 mm/page_alloc.c          |  5 +++++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e81be20bbabc6..1d9c68c551d42 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -405,20 +405,23 @@ struct folio {
 			unsigned long _flags_2;
 			unsigned long _head_2;
 	/* public: */
-			void *_hugetlb_subpool;
-			void *_hugetlb_cgroup;
-			void *_hugetlb_cgroup_rsvd;
-			void *_hugetlb_hwpoison;
+			struct list_head _deferred_list;
 	/* private: the union with struct page is transitional */
 		};
+		struct page __page_2;
+	};
+	union {
 		struct {
-			unsigned long _flags_2a;
-			unsigned long _head_2a;
+			unsigned long _flags_3;
+			unsigned long _head_3;
 	/* public: */
-			struct list_head _deferred_list;
+			void *_hugetlb_subpool;
+			void *_hugetlb_cgroup;
+			void *_hugetlb_cgroup_rsvd;
+			void *_hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
-		struct page __page_2;
+		struct page __page_3;
 	};
 };
 
@@ -455,8 +458,12 @@ FOLIO_MATCH(_refcount, _refcount_1);
 			offsetof(struct page, pg) + 2 * sizeof(struct page))
 FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
-FOLIO_MATCH(flags, _flags_2a);
-FOLIO_MATCH(compound_head, _head_2a);
+#undef FOLIO_MATCH
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct folio, fl) ==			\
+			offsetof(struct page, pg) + 3 * sizeof(struct page))
+FOLIO_MATCH(flags, _flags_3);
+FOLIO_MATCH(compound_head, _head_3);
 #undef FOLIO_MATCH
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70a012af4a8d2..c15723c8d5e7f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1634,7 +1634,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 
 	folio_ref_unfreeze(folio, 1);
 
-	INIT_LIST_HEAD(&folio->_deferred_list);
 	hugetlb_free_folio(folio);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ae0f2a2e87369..2fc03cb13e49d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -975,6 +975,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		break;
+	case 3:
+		/* the third tail page: hugetlb specifics overlap ->mappings */
+		if (IS_ENABLED(CONFIG_HUGETLB_PAGE))
+			break;
+		fallthrough;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
-- 
2.48.1


