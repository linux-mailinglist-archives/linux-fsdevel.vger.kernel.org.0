Return-Path: <linux-fsdevel+bounces-42948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A8A4C778
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0196918845A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59C23C390;
	Mon,  3 Mar 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyh5jbvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7A23C8C3
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019437; cv=none; b=juz90Het6L/JLL1t6Kbvc4kF/uKzyrWU3jXSGhiGrkW3gEEi87CD4yvPrE9RLGzlsZeH6ugR3dQgGrT2g2KFJFWBiLkNvDbt/2KiQtvYnqhIczEmtEGfwdmUBvHm0hdFdr0jxO35NEO0Z2VDi/RukdJ1I+z1CIOqqykqZEFR0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019437; c=relaxed/simple;
	bh=3SmHXztWFIDnuQM+XInecxapotD7TtFOOmhMRtX7whw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cseu6IWKGEQfgEIsO0rKrDgskno6h08uIGXiWoqVOrCb6i5jp9I7AStE/QfQyLHiCBBZyRyqD1KCUEQbvi2ckxo0BScwW3QAGWCwD1PgNY3b0cj6e0UKRT3m+HZaeZsKk6t+6rXTgVWPxrPhwj7zqI7F44LxJNEp6wu6UD/A3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyh5jbvO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
	b=hyh5jbvOU2ZkwdJqO0511/0+P/XuXE2D3X4W8YlFNqt6rX9F7Eayx/prQ6/B38KPJw7Qgm
	4Jid6RQxuI8Z6bpw6lSuxZk1UOWxgx25eMhQe66ctBQKCZxsk7UvWvzVBPCQsDTc+Kvrsu
	8zbLRF6PCQ0h6szAKoXTk07D+hFyN/k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-LlvUWOeLPEOPlAKH97ENjg-1; Mon, 03 Mar 2025 11:30:20 -0500
X-MC-Unique: LlvUWOeLPEOPlAKH97ENjg-1
X-Mimecast-MFC-AGG-ID: LlvUWOeLPEOPlAKH97ENjg_1741019419
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f365274dso1236514f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019419; x=1741624219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
        b=bw/JG3VjZYH/XvACIN9r9MrxO2AKwx2V6gfJZKDCUi7AMMkmBHvJc8pHi/G2nXktB5
         f0pyKyr7J1vNskTu4M30gKDREl8muCw4saSXqpbgHK0yMeF720I6c3Z0PmlRHlIZqBxN
         Oc0VoDheXAOIoKFK8M1s2ksKT9+/brNFKJJr4lLoC166o8M+AA8eWVnCX95Gpjuj9h69
         sQi+xqvalosIyj3wY0EguF5KJda4uwTKUOXESiw7UcdoI8ci+dyn67VAVSIlIgjLuz9x
         oTeEWGy59q0MsHezl4nlZr/TNw/DjgcgxcO9LPqGOAzn42wXMZUh11Fq6+7yVMBZOrNJ
         M1dg==
X-Forwarded-Encrypted: i=1; AJvYcCXlt0yf8q6Tra2E0nglSJslAINhFBxjNEiO9QSs+oPn7g1/bzHNF1vCBZ0NeHv1BFuuV2NtwETqBoc6xWnG@vger.kernel.org
X-Gm-Message-State: AOJu0YzO852uRTZXmtd1TK/6/tx2/Z2ExRZvQ6lg7wjBsoSQBzFckSiS
	ispat+Q0XQlSOmyd6vWDeNDoq741fcI5JA+zYlzWC+J4g2XE7MEmSdcb7I1dfX3GyaE1S2rAxS7
	l/m/jQwK9XOYq5P8ZXT/UR6i6fknH+bBjCH7SvOamgrUePv7JZ6PdMdgFBT3T1tt5JYERTcaAlQ
	==
X-Gm-Gg: ASbGnctfTCdr+Fluj20IejV2NL8QrdAZPxaqtxoD/0BcJPZfg0yQswfUmMnJXvAp2sp
	cNoroV3/fKbgP9RaKDSHGEyrPVkcv0UolZBom1ewZ3iTFQCtIRt/dByPCiPxc2Yxjp1lqTiYA3E
	fiB/MnVw1qmPix+KVVxr7wyI5mMaBSMv//DMEuIINft5tDC6ToTDvma1y4e20ynHatymRQ36CXF
	BJWhQsuTTdIwK9qBLURT1T1DsjoykdmNw1wA2TnfWSJA/wV4Jn/0z7g11F6SAIY8NbrtfeA8XBI
	mSxKKbVaAjPaI+Fcd56/2aVaJttSQY2nJ5Zejz4mFH1yYZ1xKVQAt7bTqYchMJrMw+GN2vUZ4fx
	o
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547283f8f.13.1741019419254;
        Mon, 03 Mar 2025 08:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXzBd/+KVXhEWpKLy7bok4As8+LKdGdnCV2QCwLiXkX4QDGRFFrxDGOYHa7Hz+LJLKECZ5dQ==
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547256f8f.13.1741019418889;
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a6a5esm15196816f8f.35.2025.03.03.08.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
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
	Jann Horn <jannh@google.com>,
	Lance Yang <ioworker0@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 01/20] mm: factor out large folio handling from folio_order() into folio_large_order()
Date: Mon,  3 Mar 2025 17:29:54 +0100
Message-ID: <20250303163014.1128035-2-david@redhat.com>
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

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

Maybe in the future we'll have the order readily available for small and
large folios; in that case, folio_large_order() would simply translate to
folio_order().

Reviewed-by: Lance Yang <ioworker0@gmail.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b21b48627b05..b2903bc705997 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1194,6 +1194,11 @@ struct inode;
 
 extern void prep_compound_page(struct page *page, unsigned int order);
 
+static inline unsigned int folio_large_order(const struct folio *folio)
+{
+	return folio->_flags_1 & 0xff;
+}
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1207,7 +1212,7 @@ static inline unsigned int compound_order(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 /**
@@ -1223,7 +1228,7 @@ static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 #include <linux/huge_mm.h>
@@ -2139,7 +2144,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
@@ -2164,7 +2169,7 @@ static inline unsigned long compound_nr(struct page *page)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
-- 
2.48.1


