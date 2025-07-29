Return-Path: <linux-fsdevel+bounces-56234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B150AB14986
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05F818A0CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4DB274B5E;
	Tue, 29 Jul 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjYUNxJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727826B77A;
	Tue, 29 Jul 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775562; cv=none; b=lkCe9d0wEUDlRHCFgOqy5hE5wIywkitMTXiGnJ9wmTi7EkdnoQU+AgclwnZqB1C2GwWqt7aHzoo5KlLVc/M+1UdaEE0+/SUpeeBgIcCvpOEWAy5zKiCJPJNHrR0/o9M0Sk9aQXfmCPFwNxjUGuZQWLlB1fHXw3se6oxNoKrjnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775562; c=relaxed/simple;
	bh=up6yHYGnEFam/C87iS/6Oa+IpVXTrFoTn6clDs9PXaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqDv/mannIWw8KOP764d5YklFicWmTOnYH45HuTOuoxZagD3E0YW8eoFXa/mvLu2Qgo224SIhRe5NiznTIMF37lVv6VjiKDocYLp3Rv/O4WTaSM5x5LRS/WjemtjeJJEv0z15FqahsrcMB31cCstaiKS7odDbi3umzGrU8I722I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjYUNxJS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af66d49daffso253885466b.1;
        Tue, 29 Jul 2025 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753775559; x=1754380359; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smgFHrQGxmFhyoF2rRGKiX2BsEmUYdFGX1JZMpUcdm4=;
        b=BjYUNxJSe4/6kctk4RhHTf54n1d77TmzDigDc3uZrfVOga1zqSnQGtIk/4q1jUXr1y
         JaawodYJrTLjFbxcDWMryOf2ysndwtdwHiFax6WwD7saw6cDDszos1NOthMkR8Yc0IaL
         D4UUkQgeWFjOay4+pbmBlwqF5uYkWIA7g1tjQh/ij30e+FmGZsJCunF+bEQaEhoBpBdG
         4+HzQKCEUinrV+LubMA9fV3Xpxynn9hZXbrNAHbC8F591FcgHQ4C2IWDY0e8EIIOyQI4
         jjUDKU81EzP+ScaMkprU4J4ZGYJQDFzusWYgH0Ghsl9TMmnaDKEpaNOkWppG31RoybRE
         xEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775559; x=1754380359;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smgFHrQGxmFhyoF2rRGKiX2BsEmUYdFGX1JZMpUcdm4=;
        b=AwWB9kHl5EEI2AaVdlWxbUbjZJzS4aoESKXOYaIwEJQJcI7VMncgWYDW2/WQIhjRFC
         9PfYPxl2R+0DBPkd8wna/h3qBKxusLTEf1C96u1KBxjSrk4Zw+rcdrr+OWotRQ4+tJnm
         YvGCjw4jtUsnoCAPUMZP4ikFKOfT8OfG1XE2T9mKnS/Q+RHXAgmFXnqFJZq3GggFqq+g
         3InaV91Nte4IJLEu7WKuEMx/vqxv5eo0ExDIg/OmU4iWLPytVBqsQ9mLitYZpWEPkg/b
         m52Y+yfaC6V5ZNWQs8nJncvqS/hihrW/1CjvSY1QPPJjgay5Gnrl/GRGckxu79+jvc59
         E1MA==
X-Forwarded-Encrypted: i=1; AJvYcCV+LPlDCWuQkqw7CN5hNI2BCpWNKJR+ySjK4E/AZU5m7UU8OiyvSYz9bM5OLqTmVyhnWO40hzDA+6Oki17F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10RyzeWU+OV+rXGHAzzgdnTOoeMKgVcG0o4bR1zLKzGijApzr
	88xE3jbBG8Mjy34+TbfCcV6z3md/rqMil6XNMr4P08I4mh8C51s63rVfW92hW+zQE3c=
X-Gm-Gg: ASbGncvWNNOgzCfD4sFvWy2h2xzTdOdvHM7EaJ9GierZjdCPbE+Og0Deq6jQINDhLSq
	WjnPYVuy7WdMJU/Os9HZTX9jMCkU8l/eDrNxiL1BmGbbOdfm3ytmFM0qBBz5epZG/jp/o084LOq
	pVCU+uKNGvAowte3YXDC5x2EOk/5AlNtQHmRVQxbkPUzRSJx1S3VgOC1CyHsRzP8U9O2mKe0knl
	vJEs6alnEMMzywDhq2l3KPAEq8x5s+1CuEplg8ihkDBIXyNKAUuO8T5QvJUd3U+Sbywd5JxDG66
	WSZEEDBFljrybZ3dW1VPbdu/e8qbIsLBrPHBcUMx9V+43BzN03N5fHkkx+VlEy7986sWPGbFSdG
	9RbGMeeoj8JkEUElfBxfp4A==
X-Google-Smtp-Source: AGHT+IEV6FhS7BcuKiy2mmCmExHdPH8UplQNL1+hlnfx7GXoYFJTZHp4rwskMVqcf+8guTBozWXdIg==
X-Received: by 2002:a17:907:6094:b0:aec:5a33:1573 with SMTP id a640c23a62f3a-af619aff33bmr1645989666b.41.1753775559042;
        Tue, 29 Jul 2025 00:52:39 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a1aacsm549963466b.49.2025.07.29.00.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jul 2025 00:52:38 -0700 (PDT)
Date: Tue, 29 Jul 2025 07:52:38 +0000
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
Subject: Re: [PATCH v2 8/9] mm: introduce and use vm_normal_page_pud()
Message-ID: <20250729075238.44l3jgz2l6fbss2j@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-9-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-9-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 01:52:11PM +0200, David Hildenbrand wrote:
>Let's introduce vm_normal_page_pud(), which ends up being fairly simple
>because of our new common helpers and there not being a PUD-sized zero
>folio.
>
>Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
>structuring the code like the other (pmd/pte) cases. Defer
>introducing vm_normal_folio_pud() until really used.
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

