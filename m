Return-Path: <linux-fsdevel+bounces-59297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940A9B3709C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAA8163EE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED83680A8;
	Tue, 26 Aug 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D01DiQUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A73313E33;
	Tue, 26 Aug 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226262; cv=none; b=jukuIGucf2ZeNl9IFsprZD7/LlHDnj+GC4l4VDWMpJnT/DEWT6ppMLPAPV1hjnSyfKKcKX5EOTlNUMKaEOdzZJKHVsu3kYFSOTZLIU/bBAnHfWCyCnQO0OgXf0i2klUohHY3nvAvIkeHHitu++xwjMlTNTx1xTVlHOVSJBUEfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226262; c=relaxed/simple;
	bh=AEdKHjzMg9eUTtDLSUEGj/0UGdfhDJa9ocC7lXKnb8w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=g9V4AdypVcTZ2wiJCLIzdPhHr2vk3S9dhYEIf7LjDhGateiJJ9WHYGoaW6PcbWBqlCSbAUf0u3Q4RebQash7fyAGCyk+f2rwQsdiRUXn8gb3Stkm4ShTl0h1KIdlvkfIJu24JYoCoNYnJxuUGdaXqA/RZtkApBIajMuTVT3XWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D01DiQUx; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49cf21320aso3700509a12.1;
        Tue, 26 Aug 2025 09:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226261; x=1756831061; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyPF/dL+2YqZRv98PVCshXGneATY8Fvhth5O4vhMkWc=;
        b=D01DiQUxNIduTbdm92yf7LYkrPhfjFPZWkW0sBV9zQHJvey3zsAL/81M2tAxk0TTYN
         dWz3YFqNyWtR2dgwGqX8VAnb7mxp0vHwlYKIwoHObRSePB+3JleS1BU1yJeR6saLVbuL
         /I/GitxfVVcHL+XJ8j5s7ajtErAjE0jYOOEM3Oj612OYlYpoS00633a5hQFlnlWfzmWS
         RqNGrUfFgYMiFqE4j6wbkRxw2LseB2OfgK4CuZduKMFrHg2LawKdKj2SE7BxnErx0yDM
         aw3e6SODrKsjcjGjmdJWqHuZ/vYKYshNozb2jH+PBu6XeDDIazuhHS7SpllpWt+ytUjg
         R+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226261; x=1756831061;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyPF/dL+2YqZRv98PVCshXGneATY8Fvhth5O4vhMkWc=;
        b=lb3okvgrZiWB4QyP+4N6CbybvseEMSy+ZdP5wq3Wb9q3lPZqCZDW3TjebJ9abBTmpq
         fECURxw+iFXdqoVhEAI6N8nMpBkmaX90i4jQT4k76ktsV5kxAG+c/CMly7i4bUfpppOW
         UM/HnQm8kp87na9m9VcbLM+8btT7hhFjMPTfqc//dWba6hYW3K4asMSRJfhf0u3iXj/Y
         WoaG7oinS5ylJK8IlNaRk2zr8xOzuaTNvN1Ak04ruGAXA+ksqLdAP37SGq2Zvm/pe/UU
         Lp1weyX0u14APWfNsznHcpGUzcJgv6bs9bHcoenNErSxlz5htpYC1Vgu+ljY70VPWHGv
         5Yjg==
X-Forwarded-Encrypted: i=1; AJvYcCU9tWjO0Zk8eWiWJDxPy8LhkttKRCVrOpz5T9VxtKRujbANras8QR1ZYQXwROa0FWckSIIEAj2Z4d4tYrGG@vger.kernel.org, AJvYcCV/vNZuTaPPL0v2t/tNqkP9j2CxjW8tZmE90sx/1tSbTsWiS8zQMAya/rziP8VSDhsIrXxUUzWZ/Qnt6ul0@vger.kernel.org
X-Gm-Message-State: AOJu0YzagvuYcEktylCbn86KnVv5Bh8bPVXG/bm/+J4RGAw09iSvIfQ2
	uOoVGNWZJRmkc/PahfApKwEqI2W2M8q3NH0RNDBc7qBRIfxABr5HXt0R
X-Gm-Gg: ASbGncvdXI5bid4izHGWt8glBNobNiOVsDtt8p7fPYP4zlHDwqVFArRICAMkJV0ehk8
	/S1ns1VUZzzMJDubJxVrfwGpbvtlj2bf71LU/HNW6MxpCb0lFknV1/xTpACu6em3PkQmxQdoyxp
	1YAFYiJRuvzE+MR7ZEV/5G1dnDIgNceVSYtAxBhaAwtEZGp8VCzP4Ce2ZWz8Agro0FYnFUduBEO
	pMgSAaxfKjdJgEpnEziFLJZ0atC5jb2KO8Rj7uNKRxwOsj2lVqDWLyqzI1kPlA93oH0KRB6gpro
	ytx8gvqjH4WP5JhWm5m3kJcv/1kem24HM12+cuIEcC/9/1F3cgHm7Ipc52MDC+HnSmM6g5FubzH
	wmPch76z7Fm0jDA==
X-Google-Smtp-Source: AGHT+IHkpBzdMdA7eE7qfwfc1lxqW0m87+LkJnM6/YhAHtUnIYSPMtiSiZLKGMu2nLQJcFkeNv4YGw==
X-Received: by 2002:a17:903:32c8:b0:248:79d4:939b with SMTP id d9443c01a7336-24879d4978cmr26372675ad.54.1756226260428;
        Tue, 26 Aug 2025 09:37:40 -0700 (PDT)
Received: from dw-tp ([171.76.82.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248681adacdsm21450705ad.10.2025.08.26.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:37:39 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Oscar Salvador <osalvador@suse.de>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 06/11] powerpc/ptdump: rename "struct pgtable_level" to "struct ptdump_pglevel"
In-Reply-To: <20250811112631.759341-7-david@redhat.com>
Date: Tue, 26 Aug 2025 21:58:09 +0530
Message-ID: <87a53mqc86.fsf@gmail.com>
References: <20250811112631.759341-1-david@redhat.com> <20250811112631.759341-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Hildenbrand <david@redhat.com> writes:

> We want to make use of "pgtable_level" for an enum in core-mm. Other
> architectures seem to call "struct pgtable_level" either:
> * "struct pg_level" when not exposed in a header (riscv, arm)
> * "struct ptdump_pg_level" when expose in a header (arm64)
>
> So let's follow what arm64 does.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/mm/ptdump/8xx.c      | 2 +-
>  arch/powerpc/mm/ptdump/book3s64.c | 2 +-
>  arch/powerpc/mm/ptdump/ptdump.h   | 4 ++--
>  arch/powerpc/mm/ptdump/shared.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)


As mentioned in commit msg mostly a mechanical change to convert 
"struct pgtable_level" to "struct ptdump_pg_level" for aforementioned purpose.. 

The patch looks ok and compiles fine on my book3s64 and ppc32 platform. 

I think we should fix the subject line.. s/ptdump_pglevel/ptdump_pg_level

Otherwise the changes looks good to me. So please feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



>
> diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
> index b5c79b11ea3c2..4ca9cf7a90c9e 100644
> --- a/arch/powerpc/mm/ptdump/8xx.c
> +++ b/arch/powerpc/mm/ptdump/8xx.c
> @@ -69,7 +69,7 @@ static const struct flag_info flag_array[] = {
>  	}
>  };
>  
> -struct pgtable_level pg_level[5] = {
> +struct ptdump_pg_level pg_level[5] = {
>  	{ /* pgd */
>  		.flag	= flag_array,
>  		.num	= ARRAY_SIZE(flag_array),
> diff --git a/arch/powerpc/mm/ptdump/book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
> index 5ad92d9dc5d10..6b2da9241d4c4 100644
> --- a/arch/powerpc/mm/ptdump/book3s64.c
> +++ b/arch/powerpc/mm/ptdump/book3s64.c
> @@ -102,7 +102,7 @@ static const struct flag_info flag_array[] = {
>  	}
>  };
>  
> -struct pgtable_level pg_level[5] = {
> +struct ptdump_pg_level pg_level[5] = {
>  	{ /* pgd */
>  		.flag	= flag_array,
>  		.num	= ARRAY_SIZE(flag_array),
> diff --git a/arch/powerpc/mm/ptdump/ptdump.h b/arch/powerpc/mm/ptdump/ptdump.h
> index 154efae96ae09..4232aa4b57eae 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.h
> +++ b/arch/powerpc/mm/ptdump/ptdump.h
> @@ -11,12 +11,12 @@ struct flag_info {
>  	int		shift;
>  };
>  
> -struct pgtable_level {
> +struct ptdump_pg_level {
>  	const struct flag_info *flag;
>  	size_t num;
>  	u64 mask;
>  };
>  
> -extern struct pgtable_level pg_level[5];
> +extern struct ptdump_pg_level pg_level[5];
>  
>  void pt_dump_size(struct seq_file *m, unsigned long delta);
> diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
> index 39c30c62b7ea7..58998960eb9a4 100644
> --- a/arch/powerpc/mm/ptdump/shared.c
> +++ b/arch/powerpc/mm/ptdump/shared.c
> @@ -67,7 +67,7 @@ static const struct flag_info flag_array[] = {
>  	}
>  };
>  
> -struct pgtable_level pg_level[5] = {
> +struct ptdump_pg_level pg_level[5] = {
>  	{ /* pgd */
>  		.flag	= flag_array,
>  		.num	= ARRAY_SIZE(flag_array),
> -- 
> 2.50.1

