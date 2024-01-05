Return-Path: <linux-fsdevel+bounces-7486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42162825BA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E576C287B95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA721A0E;
	Fri,  5 Jan 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vGJE93BW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC234540;
	Fri,  5 Jan 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/8LSk0CHWLNFxCq+HMOMV+w8Jp229fGkmxCFNkg1slo=; b=vGJE93BWwpcVJJk/aXPJrMmk75
	zz4GLt4oCX16rr47/iIuYk5CeyAlNAnGxnefLDWHR4cysEH4JGtvDsowS/5vmV/nV/Qs6Pc7NZmq3
	NqLyELWuR+xmPGpydLMYVBwg+/uDKr1HztpvafT6jc9/SVgCSh6jL66bT/MmG+3WDTCL2AOP/H+th
	Osekg6EUIvoD74Ge3VrBJgU2+IytlW8+DTXxQ0ahThpclzUCy/r3It0uGM4GU+Vp7/IuCPdEtlCcm
	P6r+W5xJY1IazoUNRHpXD47QJPuAsaLscZYOjH0PXcaCX5n7R3PJzOxgX2OOxJ2QPR5ub5xGpWS+m
	OPUB4k5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLqs5-0018Z2-Q8; Fri, 05 Jan 2024 20:32:49 +0000
Date: Fri, 5 Jan 2024 20:32:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <ZZhncYtRDp/pI+Aa@casper.infradead.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
 <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>

On Fri, Jan 05, 2024 at 12:25:42PM -0800, Linus Torvalds wrote:
> > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > +
> > +static void bpf_token_free(struct bpf_token *token)
> > +{
> > +       put_user_ns(token->userns);
> > +       kvfree(token);
> > +}
> 
> > +int bpf_token_create(union bpf_attr *attr)
> > +{
> > ....
> > +       token = kvzalloc(sizeof(*token), GFP_USER);
> 
> Ok, so the kvzalloc() and kvfree() certainly line up, but why use them at all?
> 
> kvmalloc() and friends are for "use kmalloc, and fall back on vmalloc
> for big allocations when that fails".
> 
> For just a structure, a plain 'kzalloc()/kfree()' pair would seem to
> make much more sense.

I can't tell from the description whether there are going to be a lot of
these.  If there are, it might make sense to create a slab cache for
them rather than get them from the general-purpose kmalloc caches.

