Return-Path: <linux-fsdevel+bounces-56011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F5EB11987
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5223F7A9B78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164812BE7D9;
	Fri, 25 Jul 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANAUrx2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B023DEB6;
	Fri, 25 Jul 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430870; cv=none; b=iIX0y8864GUy/zrE/P3Nw8Yu6Cb1ix51+QuxXIO4hpuHGthIW4dDTbQIB07+8ZynbBZLFI2sYV9g7wSso/JDuql716o9IQ9GF8rdrFbW52FQRNZKNIWMjRw/Ms+zzTa2dxDwwbEp7tizYSa0Ji65JDycXboJVCA0D1HOYxYROMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430870; c=relaxed/simple;
	bh=auO+0nXXt+NuDuF3lfzVvtuDC82gdWNOHt39vvi8AnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYEdvrfAGLAw/2HGDaLStfy08LeNs7gDbZ902THMzoeLpIckovIwjd2ZN8TFhwJc+bUMnt2bQtciz+98ad1Kj1jfMzN7n1Smyi+G6yVrNFFJh5LHc+QIqDTI+omYroWvBbpqhCmvwFkeOrnaOsSXMjtN3DTYBAIVsXoO6zeZJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANAUrx2o; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so330307866b.2;
        Fri, 25 Jul 2025 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753430867; x=1754035667; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXMaEZZATaqkCZVg69+il4b2i1RIWEG7iB7MnNkYGzI=;
        b=ANAUrx2obTsG0Bjhc15f55UQHwnkSqPF7i+rm3Mlxc7Goq2nlyA3GeRuAOWR397fiu
         Yy3oc4IUubNaulrBckHA2avp5id/aCuMOeI6HpET2+KyuDuefMLA+xbLbp4pvQlDGOCl
         fd9Tt9C9iv3IifzjcZ7X0soNgHbXLnA1t13ZRubzOsD+twiM1qq6VuFjc4kBIFryYHHj
         e0eryXMgtfUgU35Hj2gJ1HpqDv1Vt1e5IVU0feWcB4JleS8asBZo3oHy06MUuKW+nrE5
         I0Ue+YMxNZCWyPCck/H0OxF7wk1D9yBsNTbmgjXafokIJPtgJI1cUfnbsSSnirr3RWVC
         psnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753430867; x=1754035667;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXMaEZZATaqkCZVg69+il4b2i1RIWEG7iB7MnNkYGzI=;
        b=AGNVpN2Da2derg+T9tsLrB7xHM5rGCm5WIvL1Wk5E+BHLeXerXsRZN31R9p1mlgNvR
         uJJxxmemVyr79X+MtVYyK2qvvVDCZFZkbliOfXHiVVAxkl8/RadI5B0WlhKCvUeiS7zX
         vKwAZRZ1OPwTu+7+ZwSXxtRmn0X/3hzafa/EoKR87eYd33rhdGFFoeUEAQEBrPZuPOBQ
         fBIttctAcEpgHGQK97NMMyCYNa+iAKBr1CWN1itelbGOGS4/ii3355x7K/8+N0NpCuxo
         ALVvHVi4agR2/kcuCmg7v9RTrCWcWcLN+jq7SioY0EA9xv2y5kEBwOcAeaxZy4KE3GXv
         sLLg==
X-Forwarded-Encrypted: i=1; AJvYcCXAOY9URMtgleIJaSRNtZ3ftbUKw3Vku8V14gkjdgfJPZsHqJJKq5ufC+ENe1X+zRpDymGtc9Pa65A7Wojl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Lxt5b8EhCGf2pACM30k1FcY6ILo9tw3hEoskX46Hta+vofzw
	642wpNeVoIXhgJ9IKENPAaJzuREi9b63QjkPJwlbpQ9izYTGNqVe3TYj
X-Gm-Gg: ASbGnct+gwxx36nKoC9rodJBmouoJVSGVivcNEn+7sSyuDjV4P54qgzMU4NkUkjDm/r
	ydl1AmHCocgYUQuWlU4bXCrZWHkH65WXlDy2k4QLzDQQgThMesm3g2uP7XKUrW3Lj8wO0NcICwv
	vZoLFbNdqHKGWsiUDDUxlQK4iUto9CGL1dd5UQoy9c9q0qp+ytlJwUK3k3HQlKxnY+7tuM27xHN
	pZYY4/PiRShxHmMkvEkaRRhcbiz9sTozcxVoGcvnkupi6R/RgW7BGPUHRDCCZ5t1vRhDdY/X970
	K+OGlDofr0cmNMTB80r0L1mdHE4S525YHyu0KPqcglQDZBqXwdaGENeZOcJaogz05lwYBVMxOYT
	Ty8Lu2uo8/wmUWve1D2QWOA==
X-Google-Smtp-Source: AGHT+IHl6UmUdU8B6e4xhx6Ln8Ji33PC6IYqJ94cYWNmCS+nZAA1Gam8BVTsB8iILWrkEqlErnW5Hg==
X-Received: by 2002:a17:906:7949:b0:ae8:476c:3b85 with SMTP id a640c23a62f3a-af6172034a8mr105706166b.8.1753430866719;
        Fri, 25 Jul 2025 01:07:46 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0d1f85sm1848549a12.4.2025.07.25.01.07.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jul 2025 01:07:46 -0700 (PDT)
Date: Fri, 25 Jul 2025 08:07:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 3/9] mm/huge_memory: support huge zero folio in
 vmf_insert_folio_pmd()
Message-ID: <20250725080745.clm4s73fqtmsnqsn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-4-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 01:52:06PM +0200, David Hildenbrand wrote:
>Just like we do for vmf_insert_page_mkwrite() -> ... ->
>insert_page_into_pte_locked() with the shared zeropage, support the
>huge zero folio in vmf_insert_folio_pmd().
>
>When (un)mapping the huge zero folio in page tables, we neither
>adjust the refcount nor the mapcount, just like for the shared zeropage.
>
>For now, the huge zero folio is not marked as special yet, although
>vm_normal_page_pmd() really wants to treat it as special. We'll change
>that next.
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> mm/huge_memory.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 849feacaf8064..db08c37b87077 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -1429,9 +1429,11 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
> 	if (fop.is_folio) {
> 		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
> 
>-		folio_get(fop.folio);
>-		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
>-		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
>+		if (!is_huge_zero_folio(fop.folio)) {
>+			folio_get(fop.folio);
>+			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
>+			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
>+		}

I think this is reasonable.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

> 	} else {
> 		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
> 		entry = pmd_mkspecial(entry);
>-- 
>2.50.1
>

-- 
Wei Yang
Help you, Help me

