Return-Path: <linux-fsdevel+bounces-32134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2029A11D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 20:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7458F287EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D474A2141A8;
	Wed, 16 Oct 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="couV03Du"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA420E03C;
	Wed, 16 Oct 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103976; cv=none; b=b5/CErj/iiWDW7YHNeFu358/hr3SmqvCQxzmQpS0HZESCd0ZdjoaG4QSw6MLA8RPQXDVNOVggSO8A4TQw/vpSc/NMQQN33YaLQVj7HgiEJb/glxPmK/W6C3YHtWcY6q1aAYn+Dc+wYn/xzw6V7SR20FGFZWGZNMsjlJGBYz/5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103976; c=relaxed/simple;
	bh=f3cX0LErTWMJtR6W4TB/7BximEUwUAQwQqNu+HucVIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZF5LGjAB2lKaksDzDvF8uYyXGSw971QJfNdAyWnc32I4nO+c1N1FDuFs3Lmp+RvILjsNyS/CpkwEp3Gbax1GlIu3WrngGlhfuvriHzYqPcBNPdaUJL/XmNijXYth/hw5MF9eX47F99uNoHPG1CK+yvhXzphc+uScqYxKLhHMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=couV03Du; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 11:39:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729103967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OkGfnCJC40BXTXZ4ezhnm9p+y9W4JJIUfai7cW4RZ2I=;
	b=couV03Du4sIlAoaWoVxoUUiovpfGfwbMASMQ0cOtuREiDGX8HNFj88TBDIspJEn1Q3epTb
	KGtGXH26jFctcgbBa71xVWNK9MQwE7hzCnZkWQLw5Qi7dLzGNfJvy6G/Uqe7JKoZH6KPVb
	QEKZ5CZiXiiIg3ufMaZTalPj8J0WKQM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, pbonzini@redhat.com, 
	seanjc@google.com, tabba@google.com, david@redhat.com, jackmanb@google.com, 
	yosryahmed@google.com, jannh@google.com, rppt@kernel.org
Subject: Re: [PATCH bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <2rweiiittlxcio6kknwy45wez742mlgjnfdg3tq3xdkmyoq5nn@g7bfoqy4vdwt>
References: <20241014235631.1229438-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014235631.1229438-1-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

Ccing couple more folks who are doing similar work (ASI, guest_memfd)

Folks, what is the generic way to check if a given mapping has folios
unmapped from kernel address space?

On Mon, Oct 14, 2024 at 04:56:31PM GMT, Andrii Nakryiko wrote:
> From memfd_secret(2) manpage:
> 
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
> 
> We need to handle this special case gracefully in build ID fetching
> code. Return -EACCESS whenever secretmem file is passed to build_id_parse()
> family of APIs. Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> 
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  lib/buildid.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 290641d92ac1..f0e6facf61c5 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/secretmem.h>
>  
>  #define BUILD_ID 3
>  
> @@ -64,6 +65,10 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
>  
>  	freader_put_folio(r);
>  
> +	/* reject secretmem folios created with memfd_secret() */
> +	if (secretmem_mapping(r->file->f_mapping))
> +		return -EACCES;
> +
>  	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
>  
>  	/* if sleeping is allowed, wait for the page, if necessary */
> -- 
> 2.43.5
> 

