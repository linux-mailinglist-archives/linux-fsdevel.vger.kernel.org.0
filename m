Return-Path: <linux-fsdevel+bounces-42465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C8A428AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D6175798
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B72661AF;
	Mon, 24 Feb 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqjCBbdl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596B2661A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416187; cv=none; b=qPIIDbu0ZPdon71G/ID6+X9Coo9Gtsq4OQkRQqUV+03Qrh2JtdAcYAJFx2zzZuy8zzAVVo7ywmKhZb4wQsiaZkHN5TDJtUyyM0Nw2xtLwKtlaFCTj0ErdfCq81WYmS+8BBZ0uHBkZvXuZlNT5408hKLA5gactzF+VUsby+AICsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416187; c=relaxed/simple;
	bh=jBMc/6KfiUuhsqx8U3JCMjpv5FKb+tGdfD4lU0RajKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1DcJ6Q3vIB0cZ30rDjCqYS7FcthiTPHtMuelUzt4Po/h8hTvDaOYeIAq/85BNlfpMGGSsXSrAHc6/f6bzRFUF4z/qU5P6IxgAkv7UYuLoLJaIn7c7b+ar0QzaHrsjN4pbUVSt0yGPB0biPKUIBQE4AxFBpp5YVS4SqfHrf7HWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqjCBbdl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
	b=VqjCBbdlPlJfWKdtpzRebOZP/m4M1trXDyXEMhF4VYUwkrwZdkr0uk9EAsdXWC2AhVelSO
	AfGszlCQ7y4LjOY2SYff5Lc4EGNTipK5In9yBniyhHROAYFlfbW8Zhjg7yakNh0zi2b15z
	7pEuZ+qI2yL+HG3/ohuFUTaOp/izVbQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-frNtS1wLNayBJ6-HllwmTg-1; Mon, 24 Feb 2025 11:56:23 -0500
X-MC-Unique: frNtS1wLNayBJ6-HllwmTg-1
X-Mimecast-MFC-AGG-ID: frNtS1wLNayBJ6-HllwmTg_1740416182
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f628ff78eso2437528f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416182; x=1741020982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
        b=jy0Qd9qyrcRtbAeR5N+kWKvBIOEwttxAkgP8xCFHwKb4Cn5u2LF6SGIlZSqKEWoCgc
         NMp7Oof1HEsL7YBL2MlTb4SSRXgmztqIwcVpEaIlkBCPl/jw7qjbwpApMbwoVJMZONp5
         oYItkFZahnYg8evIkoK8WbGJPgg5Z2gsSuATli74Ts5wMIx4B9cuAN7B7JaN0qohu9AW
         cBOkDZRyIRe6iiisFM4v9yEA6Uyk7YtyhkKXnJwhnGH6R/mVRuSUskH8JuQaOyC1a8Ae
         cOuzMr8LSsP8ZKXzbLIJzpte6g/BsqSTz7Cm8ZRjgeF5xS++Hsz3trURUtpG9suySuUY
         a97w==
X-Forwarded-Encrypted: i=1; AJvYcCV7b4yjWVW6EPExUQUJ7MZxZislyzB7fa9Q1BOn13/tAJ+ValE6XAVHPx//kkkFE+YuhTvv0rz6vaJnKRjN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5UHRJFOnBWRtMBhlN06q/qtgj3xYEEvElfiYG9xw2QIyO3we
	SRi6mFS1FAp/eohSjmbEtpzgVVlrCoMtZ4U8/nWATW+bZRJ5/zMw1cpfRa4erNISnwaBW9uY48W
	Zw598BkxUAzTZ7HDo3dbPlUO3Pp/cz5isw3GDyWWol0rfne8lsxoSCLTUB/w2IMg=
X-Gm-Gg: ASbGncvTIIAjV9kCSUprScbfnjNFkSxgGYAi+1jJRQQrl6UZkf6fJTXosPGdiue+mIl
	MQDZk9povznI/XwGsCZO2DhMVLurhlpqtMoRHqJupGL4zZRPsKJ/+UkjpYGKaCiXWJ0UvdfTSK8
	Bso3S5Q8kQGrgCSH+80rTBC5OHWaL69d/MJnjiltaUuzwz936GsrxJt9mbs6OW5wiqOefTYpnGm
	2TAJH783o9kngC1yHO2H2z7UykuYDdLIVet3lSCBlcRw1kBcdkYQyENgxXBLG2K/OMlAv37OUyE
	EZax8EBNfwy+3EYJfWkJ33oRSowYsetWf8AR3cIC8w==
X-Received: by 2002:a5d:6d82:0:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-38f6f3c507amr11123599f8f.1.1740416182289;
        Mon, 24 Feb 2025 08:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG35xVnH9LhIY4oSSBr3n8xfuxml7Goul51SSXyqtQOXZX4W9oDib+9PjJY2pvFXqp8djOQA==
X-Received: by 2002:a5d:6d82:0:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-38f6f3c507amr11123573f8f.1.1740416181836;
        Mon, 24 Feb 2025 08:56:21 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259f8115sm32604557f8f.92.2025.02.24.08.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:21 -0800 (PST)
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
Subject: [PATCH v2 08/20] mm/rmap: pass vma to __folio_add_rmap()
Date: Mon, 24 Feb 2025 17:55:50 +0100
Message-ID: <20250224165603.1434404-9-david@redhat.com>
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

We'll need access to the destination MM when modifying the mapcount
large folios next. So pass in the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index bcec8677f68df..8a7d023b02e0c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1242,8 +1242,8 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 }
 
 static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
-		struct page *page, int nr_pages, enum rmap_level level,
-		int *nr_pmdmapped)
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		enum rmap_level level, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	const int orig_nr_pages = nr_pages;
@@ -1411,7 +1411,7 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 
 	if (likely(!folio_test_ksm(folio)))
 		__page_check_anon_rmap(folio, page, vma, address);
@@ -1582,7 +1582,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/* See comments in folio_add_anon_rmap_*() */
-- 
2.48.1


