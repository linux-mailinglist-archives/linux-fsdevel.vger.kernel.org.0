Return-Path: <linux-fsdevel+bounces-25684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E394EE05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442A61C2179F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290B17C217;
	Mon, 12 Aug 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHmkncF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1117B516
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468910; cv=none; b=jrPmbu3XALgpogwFSdH2+oeNYVm/bo8qpp4N9Eer4zcnDMnWxa1cjd/n4pxMP103vKtbYSwhHqoB4/FebCYVKxlS9j/ucqilygiq8ySRjnNHDwYgWwRRxHFjtTjElO0ZcPmz03N8VEr/ArHn9KwbynOF8xFom+V3OOZu2vz4k28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468910; c=relaxed/simple;
	bh=L4hLDbJY8YvYX2IvWi7R976S32Mco3tEXfLhybkfkxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd9anItysqiL3bEbqmbGevHgstK6vOKbNGTAdqaIUzsbtgy8RuZhNvQgCQGloyZulmKxztmpnhNPymoJR2s8kFkX6EPXEwJmCvNxC6rZm90aBex+g+ypSoRH9XBCUiqn26EIaIglQsbW3AH4Z0qtYIA79J8svRzNrs2KIGRY2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lHmkncF+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DDcNj9cZnbD9mUD0VQL0hm0vmpjLfCRrb0ZDnQ0zOgc=; b=lHmkncF+n8ZEIsW1TqaXL363+y
	1M0DHij9ITiFZo4svtXCwJ/OMWRHY1YOAZpPwZk89moROqlxIIoj1c27YFqvraz5D013kaMZ/GQn3
	PwPFL3PzbDyqm/vQuowKKlZn7eI+7qbyQ+XV+jniEXJp51TIwi9NK1VZ4+Nh2+kQ9QR642m5KdvKU
	hmnnFSWQAXpuqJVitoUPBRGtfC50qOzvlhE/miEazeVCppcduULxbTp7/IFBZqcebEmaFyPdfTQkz
	qovPx88Hi4T0JdNZSEiOJdjbHJHwVu7BSlvLy5efjtZUsCcY92RRCuQLiks08eS6IXJIZj5WxXFDq
	367h8i+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdUza-00000000OVS-0ukk;
	Mon, 12 Aug 2024 13:21:46 +0000
Date: Mon, 12 Aug 2024 06:21:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <ZroMalgcQFUowTLX@infradead.org>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 08:59:53PM +0800, Yafang Shao wrote:
> 
> I don’t see any incompatibility in __alloc_pages_slowpath(). The
> ~__GFP_DIRECT_RECLAIM flag only ensures that direct reclaim is not
> performed, but it doesn’t prevent the allocation of pages from
> ALLOC_MIN_RESERVE, correct?
> 
> > and thus will lead to kernel crashes.
> 
> Could you please explain in detail where this might lead to kernel crashes?

Sorry, I misread your patch as doing what your subject says.
A nestable noreclaim is probably fine, but please name it that way,
as memalloc_nowait_{save,restore} implies a context version
of GFP_NOWAIT.


