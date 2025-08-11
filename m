Return-Path: <linux-fsdevel+bounces-57317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B7B207BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0024421445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336302D3EC0;
	Mon, 11 Aug 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5jFWIKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AD2D3A66
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911609; cv=none; b=Qj0hKJ4caoZQvMQJfyu/0Z3wlls3v5kORpI/H4xHJCKX0tFEFlczKAHj/OHoQKWEvOnnxYfsWD9ngO4HN+VPr8Ti99vR5ycP/k+axUaLmmTHm6Q2+WpQXnC70HWRobNI9saS+J9DQC/sv7oQwFWeu9q8/eamh5YKdIilsNL/SVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911609; c=relaxed/simple;
	bh=Two6z2c+eu7eJRnlv4eH9xLpdr8pvhEq/q43/f0xNIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6QxiYRxWqZGdKpzNvQNh+77LzEcDxUCJAt66/KW/f7R1NFqfGPQyrIyPWxXc0E/tXX+7rw3fG3eJtU4xsENVKWzWdmYoHs99NiqWPLtCGICcIZXXhEcy13ZmiuwfNdeucvEaqGczMgKesB9elv018IgvXqwwYd1+dFUYcplogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5jFWIKp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPzS7A0H2JYY/4bVoDqq5vs7hjaSrgBmC9jJDJzHOMU=;
	b=a5jFWIKpZRlW9NU2JDc8sdV22owHQ471VdRgNGKhjhe4NLROWNMqbVKPuVwfU6i9wytifi
	+biZyf3fEnxCIWoRYLJg9vWBNnerSrOx3Mj/2WY1rPGxXMSXYBzUt435j93b6io/CvcTmi
	//UbKHebIW6ixWhoj7NiKgc37i3SfWs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-3XFyYAqbNSm5OhMNTn4FHA-1; Mon, 11 Aug 2025 07:26:43 -0400
X-MC-Unique: 3XFyYAqbNSm5OhMNTn4FHA-1
X-Mimecast-MFC-AGG-ID: 3XFyYAqbNSm5OhMNTn4FHA_1754911602
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a09c08999so5497935e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911602; x=1755516402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPzS7A0H2JYY/4bVoDqq5vs7hjaSrgBmC9jJDJzHOMU=;
        b=VD9uvsxY7laSvw3HmNOrJlinBkyDJXzUD5FeKPjavxUL5uDQ8hEFNcmpcAqqFve9su
         u4RML9empwvALxZ+ty/QGrLhvneRkbapkHW+dN1dppdUQ1MafDAOsZ3Bl9tPEjJ/Iv2S
         SbDJIkMODq/GiTtsWhuAS2sJDNwW4FcBCOO26WgTLPRcNQoRJGqN/z/njS6wAlTQEZib
         cUM0WXwLG1jvCJ5VgargANlowRnY/TWyeDNjXUmMkAoP3ngmUh9xHPqOFRMTi8yr9o5F
         +5xWckVfZuFiGHHDrq3PQsIQKWoeCpTXkRNrexLwSj5pQK1QkCTKt2umDSPtAsNU3Dnc
         8YHg==
X-Forwarded-Encrypted: i=1; AJvYcCU17ymVKUghPXG2tzeXtKj6XdzBHcUeTKebQRyZhWAO3cIPGD4TBNxXtlthwKRgYwVkGBjttvrTvNryZawP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ExnwtjWeWfhZs6vRiyHDntzWnd3H3UwcqHr6HnBU4Ma7M+h1
	AQ7ePbPnkls6Pu8R0IyAGMuun6JzXYf2AxcrM0yCgSpsiLwQoa/uMM0w7sVQQJhXOqESIYMMwQl
	miPVOF00a//6oGzShtQB+7LqH2vLbAQ2tl70NkB0D1QoFDCkDKJPnDSnPu6s9YNh4XGo=
X-Gm-Gg: ASbGnct/Ezil+lhZ8XIulqvvQP91WlZPSX5cvdsGvR7KlSzFlJms+nGk889SdbLavej
	VEqDtwvHSiuYHZAY4RB12K0ITKgFmxkAnjF0qX9Fmc2rprfCSaiP4W19+0pdiqttbFVKUd1LzGs
	WS3EPLyXcAJFJzlQJew96ODGP/9gH5+EQOwRDwG5XXBt9IyGvGGnBL8MESGWH9k+UXnyIpEndIi
	V6hspkVNiBcj1aZucPWfSj3GvYmi8aQoaooooxyToAe5+QMgFmKHbcF4FB9ScmS/8f9ZEAEGuht
	eKP5m1bt9sYo+07ZexUo8+Je7ekQIkjJLHcc38soDNqnFhOrvJhmuDZt9IZiAcLDAFpDhSrNIPs
	a7Lb30opx7jK+8Z5c0owviAVz
X-Received: by 2002:a05:600c:4ec7:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-459f4ea2167mr89525605e9.1.1754911602501;
        Mon, 11 Aug 2025 04:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2VXT8eja0G/6oYjAzMox3Wj/YsLa0WXg9I30LI+rqq9mj5h9Avu9edvonRgK7PI+OIDYPVA==
X-Received: by 2002:a05:600c:4ec7:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-459f4ea2167mr89525255e9.1.1754911602063;
        Mon, 11 Aug 2025 04:26:42 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e6dcdbbbsm122068765e9.7.2025.08.11.04.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:41 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 03/11] mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
Date: Mon, 11 Aug 2025 13:26:23 +0200
Message-ID: <20250811112631.759341-4-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811112631.759341-1-david@redhat.com>
References: <20250811112631.759341-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like we do for vmf_insert_page_mkwrite() -> ... ->
insert_page_into_pte_locked() with the shared zeropage, support the
huge zero folio in vmf_insert_folio_pmd().

When (un)mapping the huge zero folio in page tables, we neither
adjust the refcount nor the mapcount, just like for the shared zeropage.

For now, the huge zero folio is not marked as special yet, although
vm_normal_page_pmd() really wants to treat it as special. We'll change
that next.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7933791b75f4d..ec89e0607424e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1418,9 +1418,11 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (fop.is_folio) {
 		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
 
-		folio_get(fop.folio);
-		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
-		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
+		if (!is_huge_zero_folio(fop.folio)) {
+			folio_get(fop.folio);
+			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
+			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
+		}
 	} else {
 		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
 		entry = pmd_mkspecial(entry);
-- 
2.50.1


