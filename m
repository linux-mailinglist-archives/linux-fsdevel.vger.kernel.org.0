Return-Path: <linux-fsdevel+bounces-71728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB042CCFB13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABD733022B53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883A31D759;
	Fri, 19 Dec 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="y0nD3fMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E130100B;
	Fri, 19 Dec 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145231; cv=none; b=dee/R/NDLQBvmGZ1z97PJA8Gfqa7V5WxmNliYjGFYm6/7pEwCMBPRHy1ioR2Cb5wCrKl9F+kETgB5pxj2BsimRVpBxT2J3oEilonqQwOsrmrBNGeRrYOxHvK0OS8cX6YgAxRp7DFL0ZtCBuVli+b7yWhLC5jnINTXGVOYbYH7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145231; c=relaxed/simple;
	bh=Gn73MGP8KEsJbO800H+my6Vn8wtst5VEKM6rKxvZfA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4zDi7XymSGEiOtCQ4FHDdmhw3z6B5VaWIzsm2l3KbyeYiHeu6l98Rk4i52vGEQYGNkznyx4+h8WpRlhH4WMReql/H4xoY22iMUwIYnTzr8dOMISCpi09u2UC5FlYh39O8MUaBjhIS7H+DZeKH84v5mCMgSNZZS9RHOweOYVOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=y0nD3fMA; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 70F0F14C2D6;
	Fri, 19 Dec 2025 12:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766145226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+B2m+cVifxPUlL/5aB0ysYbsBdkjakWRPsCb1/KTIQ=;
	b=y0nD3fMAqP4xMLPYeebhwNZUXEEQ8NE/fWYPzkoFilDJORLGr6Q7k1hnOMS2Tx/xzZ+DVo
	kc/6JPVM/kop5mbTJfCSHduBd7bdja+xPeF/6CbVJB3K4upVVnYrZJz6qid1bqKWk0lMi/
	XBGlUYSrleem/AjfwRIL5Idz8WvOZvEH2eU/LWVQCxX1qcsonsVxtV/cKfHorvqaDU6r+S
	P1WrPTGGT+Q1SL83fkQ5Nt5lWpt2zcAQDz22wJO7SmzfaFTfMyk9h+hc7I64fEjAueSb78
	qiiyHBe5DcPxtViM9jwfKAoUtqdVv0Ml1ploa/D0loz3Ee95hzEZ/b5+4GQhlQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7f50762c;
	Fri, 19 Dec 2025 11:53:41 +0000 (UTC)
Date: Fri, 19 Dec 2025 20:53:26 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: 9p read corruption of mmaped content (Was: [PATCH] 9p/virtio:
 restrict page pinning to user_backed_iter() iovec)
Message-ID: <aUU8thEsa0X4YrlF@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aUMlUDBnBs8Bdqg0@codewreck.org>
 <aUQN96w9qi9FAxag@codewreck.org>
 <8622834.T7Z3S40VBb@weasel>
 <aUSK8vrhPLAGdQlv@codewreck.org>
 <aUTP9oCJ9RkIYtKQ@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUTP9oCJ9RkIYtKQ@codewreck.org>

Dominique Martinet wrote on Fri, Dec 19, 2025 at 01:09:26PM +0900:
> - I took a dump of dmesg (with debug=65535) and tracepoints (netfs, 9p),
> and it looks like the mmaped file IO is mostly correct? -- a TREAD is
> issued with the correct size, I'm seeing the data is collected... and..
> what is that ZERO SUBMT with the same size? Could it be related?
> David, could you please have a look?

So answering myself on that ZERO submit now I've looked up the
tracepoint definition, s=%x is the start offset and the following item
is the length so [0-5fb2[ was "downloaded from the server" and
[5fb2-6000[ was "filled with zero", and there's nothing wrong here...

Both are triggered straight from the page fault so that answers my last
question as well:

clang     691 [000] 18146.476058: netfs:netfs_sreq: R=0003306d[1] DOWN TERM  f=192 s=0 5fb2/5fb2 s=5 e=0
        ffffffff81601197 __traceiter_netfs_sreq+0x37 ([kernel.kallsyms])
        ffffffff8160625a netfs_read_subreq_terminated+0x10a ([kernel.kallsyms])
        ffffffff817fcbc6 v9fs_issue_read+0x86 ([kernel.kallsyms])
        ffffffff815fd86b netfs_read_to_pagecache+0x18b ([kernel.kallsyms])
        ffffffff815fdc62 netfs_readahead+0x152 ([kernel.kallsyms])
        ffffffff814b9c2a read_pages+0x4a ([kernel.kallsyms])
        ffffffff814b9f20 page_cache_ra_unbounded+0x190 ([kernel.kallsyms])
        ffffffff814ba677 page_cache_ra_order+0x387 ([kernel.kallsyms])
        ffffffff814ae2a9 filemap_fault+0x5c9 ([kernel.kallsyms])
        ffffffff814ee518 __do_fault+0x38 ([kernel.kallsyms])
        ffffffff814f83a5 __handle_mm_fault+0xbb5 ([kernel.kallsyms])
        ffffffff814f9509 handle_mm_fault+0x99 ([kernel.kallsyms])
        ffffffff812a6e2f do_user_addr_fault+0x1ef ([kernel.kallsyms])
        ffffffff81ceb097 exc_page_fault+0x67 ([kernel.kallsyms])
        ffffffff81000bb7 asm_exc_page_fault+0x27 ([kernel.kallsyms])
            7f776ed86c23 clang::SrcMgr::ContentCache::getInvalidBOM(llvm::StringRef)+0x13 (/usr/lib/x86_64-linux-gnu/li

Which leaves me absolutely clueless at where to look next, I assume the
data is populated cleanly but by the time later pages are read by clang
the content changed or something like that?
I'll try harder to create a synthetic/more deterministic reproducer for
now...

Any ideas welcome...!
-- 
Dominique Martinet | Asmadeus

