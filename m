Return-Path: <linux-fsdevel+bounces-42461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56DA42883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1309167C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BBC265621;
	Mon, 24 Feb 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgL53GVI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D7264A82
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416179; cv=none; b=AYzrhBeqDUAtwFBhvObjGz+rnDPS4tRt83NLWT6ceAZWBzqwcscvxPoe0uU8Jyb5PRNUZq1Qm9+zCAKT6JTIPtteuz6kDzo1V4t+cNbNKBf0s4q5IF8/y4JR6KPG1VLS0yM/cQyd65jTAX9sWjGEQUT6IFEStHA6IFjRnhEcjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416179; c=relaxed/simple;
	bh=2+hWsKxtAvrobFrzRh+8Ehcyr57/khonaGBhd7DELH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN6VKqK45urxUJzku5dbXg4MP4vdq1RjpYH/o3ucAGQpPkvD7CxYgStYWK+nBpq7oxzZW8Bfq12veSKnoUQBqYBDjkEZRRNcglehIGdNAk6i72i0tdRnayLWnC9PbsCpx6+5Oe7zjxUZPufF//4LGW3M6qg6qGZxdkWv3gKp8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgL53GVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2J0EAZe5fI1EPFno0gWSdFeb6AH1J2rAdhMuBREbwsI=;
	b=KgL53GVIJoY26UOd1giLFF1m9oQXBqM26UfTvguXaNRXmzyFv5k2STvZGmeF6ahThDpPsz
	XyLbEf2ycXSaBZneMZir0O1hK60g1fbD5j3WPL2MVsMECGTfR0a5jopHBb5FQ6lK4Lagj3
	ZO9wMOHoCjsXmSQ0S2WP7GEOkNpAC0k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-kzloj6dBMtOIf42Gm7tMzw-1; Mon, 24 Feb 2025 11:56:15 -0500
X-MC-Unique: kzloj6dBMtOIf42Gm7tMzw-1
X-Mimecast-MFC-AGG-ID: kzloj6dBMtOIf42Gm7tMzw_1740416174
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f55ccb04bso3397954f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416174; x=1741020974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J0EAZe5fI1EPFno0gWSdFeb6AH1J2rAdhMuBREbwsI=;
        b=s43+Xq/UwlNetJ26iamGZ1j+2OVaenTAOLi1ZD7Zri3Bq0cRkniKEdPSF73+Qh5Px0
         GwESipGQwtJTq0MfHU3c5gZJSAJkvRa0jzC26VFib7TtO3SqNxKYlVcZhhBT2JBrJBlX
         YUO9HKC7JB2LP9SW53ngh0JiPfLe2PFm/kKogxAr1pT9cCYF/r6ToSXSrZKvj7usHxGn
         4CtFj3L5cLbz8efEeDP0ZP5K2nYfEYmvZp75bfU6kZHu1NnkcwVDmL9OTBx0gVZ5Jezf
         GHzEeyYJZTIZxAi6dPLOJIxbHlDHdEHr+FtL1KJiGaC9jBkeAlEijnAvFUmFCro8Ivcb
         8bSA==
X-Forwarded-Encrypted: i=1; AJvYcCVwpY3TULKAMxQFH24mL0/Xdxh8gY+RomXe37Lylb3mTqpwPE6re3SQ217PGYOoBD3z3ii0Y8/N0dkQwA3J@vger.kernel.org
X-Gm-Message-State: AOJu0Yyowl8yUGiJw9GNCP6RFELcGgxOcy5VnoyDB3ciB5W2e5rGLn9M
	0pTKwC4xv+HhB3YwQXDiibQFcEzjqIl5HeUx07qfTEjB3FVVY6RIVHyilM5SoZ9AHsbas+dlE91
	VHxaLvs3UbClUI4D/oHcAMha8mB0HDFyVtWh5SuHnVhJMBW3skCQuDahHZvIsPMk=
X-Gm-Gg: ASbGncstVMylFCh7qEqfWhSSRjWOoBjPaE72EVhLk2Ab02r670VAo6Yfdwvb8HzzPMl
	pyTDApTMP+/LbcWpqBsu7idChpS0D0d/L20dj2nT3jG0LctFLPfTSXuZuc50XISXu4Ym8w/T+0o
	k2cWybdeeIRW5RZUS+SfidnZ8SWoLgp3oitixIGNCC/SrwdMQq0rcDcrBTs5q/2BrhISnWk7cQL
	95ZAh0wVxLWRVbqMYMJYCQiD88JNbdKAipN+YfBRPvRP4Pk9dT6GXDreByeop0lVg5g1Claptrl
	IHm6Ve2MWD/Y6wC3rrsKRBNYAaUKR2AMt57NtQWySA==
X-Received: by 2002:a05:6000:178c:b0:38f:32ac:7e55 with SMTP id ffacd0b85a97d-38f6f0bd36dmr13581420f8f.48.1740416173937;
        Mon, 24 Feb 2025 08:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEK4+EskiCQe6b4Tt/1yywMxIN3N8u+em5znQyoHp6oO/UQ3gXRmnxMS/Oum/lKFSKXiOoHw==
X-Received: by 2002:a05:6000:178c:b0:38f:32ac:7e55 with SMTP id ffacd0b85a97d-38f6f0bd36dmr13581391f8f.48.1740416173570;
        Mon, 24 Feb 2025 08:56:13 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258ddbe0sm32403003f8f.39.2025.02.24.08.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:13 -0800 (PST)
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
Subject: [PATCH v2 04/20] mm: move hugetlb specific things in folio to page[3]
Date: Mon, 24 Feb 2025 17:55:46 +0100
Message-ID: <20250224165603.1434404-5-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
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
index 9faa1034704ff..2ad5c292568ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1646,7 +1646,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 
 	folio_ref_unfreeze(folio, 1);
 
-	INIT_LIST_HEAD(&folio->_deferred_list);
 	hugetlb_free_folio(folio);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdfc954dab9aa..05a2a9492cdb0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -971,6 +971,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
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


