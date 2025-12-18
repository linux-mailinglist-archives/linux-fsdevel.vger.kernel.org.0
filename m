Return-Path: <linux-fsdevel+bounces-71697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CBCCE01C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43770301F8D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1673093AC;
	Thu, 18 Dec 2025 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZbcV24Wg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296981F30A9;
	Thu, 18 Dec 2025 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102154; cv=none; b=swmlY+X9RdIoOAhX/vP2T78bD2bxs/Yc9zBFj7oQDbhSLRpWUeCvOqNgb3pXzKepsVfqU0iwA3D4oJcDZrb1dENdJgGWKLV4+84gj6hZ17uAznbQ5HyhqooZzq/x1QL/mtVIfJiUqrlfF7JNa5NIQqGZ6MdX410qUA43ZEVKv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102154; c=relaxed/simple;
	bh=GONjvaOBh0XpXpleiYvujXPILEwEfkwDmxomLs1O//M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7g4t3vJ71ZukS9xq06zw84Ynz1FLxkxCs5pMH1cGE3d3O5RcjL8AJI4v2aYMy4PR7ZYOcSAN5oWhoLgyEamczUEfFbjcWtLyazwM05XjwWYGtS+GYthKnqiEA0WT1uwWqDhzXZ4X0KW1eFKEGrFi+c0L36FpXXmqvZk6ZWGpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZbcV24Wg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7cRVqnT8PTUMlTtnuPb2AQO/9hbRZw65ZP76rwPKE1c=; b=ZbcV24Wgo7Invnggx+YGo10U0g
	k3Ub4BJrrQa42JxRBq96N8u/lt8QnaRuQKEZSbbOyMmN+0C4UZwldBfY/hO6YrfjI16S60uGKuM1A
	0L6m3Gaw7TJAQXzI7OpRr+PvPANWq9zqF0akdN9OXWvcLJXnLF7Et074WQGVOXmliS2giqShr3XK3
	DL/Mmw+9Cd6Hgh7D3Uof0XxVu/HZqJA8a1IKUC9ziMswAfPqyiV2Y0T5wAq9Yn2YAEQC0nkaHOYR8
	ZaUGlkLxMNXInyg43Wi8eUrZ8DmJCnVPqpJmslzV1UlMScm21UBqSrceem92beFSb5PwcbEa0laZ7
	0yF+f+8w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWNqN-00000006ngf-2n65;
	Thu, 18 Dec 2025 23:55:39 +0000
Date: Thu, 18 Dec 2025 23:55:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH bpf v2] lib/buildid: use __kernel_read() for sleepable
 context
Message-ID: <aUSUe9jHnYJ577Gh@casper.infradead.org>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218205505.2415840-1-shakeel.butt@linux.dev>

On Thu, Dec 18, 2025 at 12:55:05PM -0800, Shakeel Butt wrote:
> +	do {
> +		ret = __kernel_read(r->file, buf, sz, &pos);
> +		if (ret <= 0) {
> +			r->err = ret ?: -EIO;
> +			return NULL;
> +		}
> +		buf += ret;
> +		sz -= ret;
> +	} while (sz > 0);

Why are you doing a loop around __kernel_read()?  eg kernel_read() does
not do a read around __kernel_read().  The callers of kernel_read()
don't do a loop either.  So what makes you think it needs to have a loop
around it?

