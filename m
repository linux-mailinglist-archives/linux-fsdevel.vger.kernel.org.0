Return-Path: <linux-fsdevel+bounces-73126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBED0D022
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 06:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29793301296A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78BF26560D;
	Sat, 10 Jan 2026 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZdOWEL1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285121DF736;
	Sat, 10 Jan 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768023645; cv=none; b=ez/GzTB7kU84WINFdknH+v9FGDQ3EfC1AH4+KaIf4BgxXcIIJXZgS3yE1eVbq/xy81DhxNJXdzdvG002czZCO4zS/8DSS6WXzM4PWR+mqwawpaEc0pw/WjYpmAr3lViZ160Q57jFciHiRH91UXqLCBYkrBJNBLlZud1jiicRQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768023645; c=relaxed/simple;
	bh=wrcSWMjFel7iA5yBtcxrH3294kHJ9tRdNj1n37hPAXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qjyaog8dp5FCjwr813Ug3O/gd+lFw5QsYCfeVKe+7Di0s4WKjSfhgzEQyWiNs6tbBwtr+iUFFB62VzE1Ar5/KO+F4A7yu0Jsq9IkeoG54JIcWFztItvwczrAD402nsC5+LQxNbHYbMfc5oToV1An+KIYzgOQH0D0i+9Sif1koL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZdOWEL1J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dq5WnUbsxkXZ2XZj0ZTWTXM2WHawM29bk17AjRKeCjE=; b=ZdOWEL1JrzdvWUCpsHwz2fifLz
	EhLnr5Mg2zR5nF8xinZpR1T9ePsoyo1uA4QtdJxsfvSnfDPVH92MFi8UGUwuhHZi64DDUhrH9w9sY
	7/0F5M+CQ83dgVK2CEa71i5uPu9wQaojdES5biXy147dNeXpLFtwdLes2Ea1Yva/rtQxfgvbUNG9S
	EIO9Zg+7YVmSoE05XrqpgI7kB8IGLb2ajRV1PSmTCvv6WKegqil/AgGsjP7EpkFVH65Is+7/gC+2k
	iqed1FP2Z/mKTX7ENFm+36J7rmjhabwnxSq5HMHf+iRdBGwhBO/z4NT9Y8CdOGsBjEioraIcI2xbS
	WBPlP0UQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veRiE-00000000GTV-3XrO;
	Sat, 10 Jan 2026 05:40:34 +0000
Date: Sat, 10 Jan 2026 05:40:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/15] static kmem_cache instances for core caches
Message-ID: <aWHmUsxQDGHOdflq@casper.infradead.org>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <20260110040217.1927971-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110040217.1927971-2-viro@zeniv.linux.org.uk>

On Sat, Jan 10, 2026 at 04:02:03AM +0000, Al Viro wrote:
> +++ b/Kbuild
> @@ -45,13 +45,24 @@ kernel/sched/rq-offsets.s: $(offsets-file)
>  $(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
>  	$(call filechk,offsets,__RQ_OFFSETS_H__)
>  
> +# generate kmem_cache_size.h
> +
> +kmem_cache_size-file := include/generated/kmem_cache_size.h
> +
> +targets += mm/kmem_cache_size.s
> +
> +mm/kmem_cache_size.s: $(rq-offsets-file)
> +
> +$(kmem_cache_size-file): mm/kmem_cache_size.s FORCE
> +	$(call filechk,offsets,__KMEM_CACHE_SIZE_H__)
> +
>  # Check for missing system calls
>  
>  quiet_cmd_syscalls = CALL    $<
>        cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
>  
>  PHONY += missing-syscalls
> -missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
> +missing-syscalls: scripts/checksyscalls.sh $(kmem_cache_size-file)
>  	$(call cmd,syscalls)

Did you mean to _replace_  rq-offsets-file rather than add
kmem_cache_size-file ?

(I also wonder if we want to just do slab or if we want to make this
mm-offsets.h and maybe put other things in it later, but I'm having
trouble thinking of other things we might want to generate)

