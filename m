Return-Path: <linux-fsdevel+bounces-2521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCB7E6C2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC641C20B91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7A1E535;
	Thu,  9 Nov 2023 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cOECJ9T9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED61E528
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:11:07 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188672D6B;
	Thu,  9 Nov 2023 06:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s3u9jxqjI5KwNmQNMyyZwIKD3v79jB5wPUc1BiFVB9U=; b=cOECJ9T9Vj4NcyTWwe/g8EKrad
	hhsH3X3woSg5q5NbpUpZ67TMtaSxwTPecV/2GVOwD88mQqhFjETKH7RK4BEBgbB9HNbAszF/Fj8B3
	HOeTxxBHWGV6dO/pva2uhbe8T50s++1kqopFzrjCFkDZ1vjnTH44mARAcD3P9mxFXTg0YkByBpfIa
	m5LIs/p1hczjJ22EzO+iqZW8FZytPYz7xfUUVirLV5/fnPeCgNLrSFFfRg8i5wjT1DE7oI8aMDkNK
	YisxxW+cWNb8jhkd3z4GEdD3TcN/JPv5C1CoVnQZ7OyGolUge3nIey8VDjdIQtdd6VtKesUalZtiu
	hVtMPe+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r15kA-007exW-20; Thu, 09 Nov 2023 14:10:50 +0000
Date: Thu, 9 Nov 2023 14:10:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	chensong_2000@189.cn, xiehuan09@gmail.com
Subject: Re: [RFC][PATCH 4/4] mm/rmap: implement anonmap allocate post
 callback for page_owner
Message-ID: <ZUzoanvY4eIc1xK0@casper.infradead.org>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-5-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109032521.392217-5-jeff.xie@linux.dev>

On Thu, Nov 09, 2023 at 11:25:21AM +0800, Jeff Xie wrote:
> +static int anon_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
> +			void *data, char *kbuf, size_t count)
> +{
> +	int ret;
> +	unsigned long address = (unsigned long)data;
> +
> +	ret = scnprintf(kbuf, count, "ANON_PAGE address 0x%lx\n", address);

... completely ignoring that it might have been mremap() since ...

I'm not an expert on anon memory.  I'm sure someone can tell you how to
figure out the current address that a folio is mapped at.

