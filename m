Return-Path: <linux-fsdevel+bounces-32642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAC29ABF1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 08:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4C283F96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36214AD3F;
	Wed, 23 Oct 2024 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8F828hs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A556EB7C;
	Wed, 23 Oct 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665914; cv=none; b=Y6MeTvrOlbdlh/n9R6r/L8E0vtQzp2Zu0hm8GjSxW60qfkQJF6B+mFqbzGgjWvNZLLus2on9XjTonX2PZSs6eFM/Uobjiq/yq3+4gQR7buNjHd4Fi3YsK/EbcxYZDKiiDhIadCww9Ism8zk3GPulm6gP6KyT2ROj6jA2ju71Byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665914; c=relaxed/simple;
	bh=5QHNOKzSaP6+V6m2H0p2UwehChnWSxNkBlBVyejMPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifpalqJQ3aqSySIAjeyvLq5a/mXa9nYKhizmfOgfarhySwuvCGyiVGk/2k/pryqK01HNswWn5Nmx8DomA4Tz20C/ZX42a2ardpHjOOsHUR9DsIBJ2E0Ia4NzbdOUev2yorEhGueAvJ0vP5+SCofckmp27MsPNzoif6kKudPwxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D8F828hs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RSQPrKwOEquJSUdRa82UBzxuqVq2bj42C8it3gsI3CQ=; b=D8F828hsvgs7JIEkxW2YE8E8K8
	ZRIbGWqlTPyT4Kr4Y41UubrQrHSUGUlWClC1kVCgaegmr0RpziLXGd55B3fLxdGijOWy6qyXuzhEJ
	M2cWbNmO5wAKXXeCDezszGBSPL6EvZiCQ3JDPsIo09uPqp8uFlAyQ7IBG7RU6PEEaIZoenr/aw0Ht
	FiJ/BOqU3y/2n/jE0vT63+1mavSvBeN7YK9J6D7sk0Qmc1HmPu9b4wJeWcbYm92MqL1/LEDEbHZOm
	JG+y+ioL/nBk4bYzRx2JLk0H0anIXiO5i9xz27LRDK6Al4s4wkGdj8ARfuoNYp0JG7/OceZ7awt0o
	qgXl8pKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3V7H-0000000DFF7-1TUN;
	Wed, 23 Oct 2024 06:45:11 +0000
Date: Tue, 22 Oct 2024 23:45:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <ZxibdxIjfaHOpGJn@infradead.org>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
 <20241016-luxus-winkt-4676cfdf25ff@brauner>
 <ZxEnV353YshfkmXe@infradead.org>
 <20241021-ausgleichen-wesen-3d3ae116f742@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-ausgleichen-wesen-3d3ae116f742@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 21, 2024 at 03:24:30PM +0200, Christian Brauner wrote:
> On Thu, Oct 17, 2024 at 08:03:51AM -0700, Christoph Hellwig wrote:
> > On Wed, Oct 16, 2024 at 04:51:37PM +0200, Christian Brauner wrote:
> > > > 
> > > > I think that getting user.* xattrs from bpf hooks can still be useful for
> > > > introspection and other tasks so I'm not convinced we should revert that
> > > > functionality but maybe it is too easy to misuse? I'm not really decided.
> > > 
> > > Reading user.* xattr is fine. If an LSM decides to built a security
> > > model around it then imho that's their business and since that happens
> > > in out-of-tree LSM programs: shrug.
> > 
> > By that argument user.kfuncs is even more useless as just being able
> > to read all xattrs should be just as fine.
> 
> bpf shouldn't read security.* of another LSM or a host of other examples...

Sorry if I was unclear, but this was all about user.*.

