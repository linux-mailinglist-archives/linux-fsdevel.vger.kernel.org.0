Return-Path: <linux-fsdevel+bounces-8219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCD83114D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83176B214A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256B5395;
	Thu, 18 Jan 2024 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qezhMimt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1254422;
	Thu, 18 Jan 2024 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543975; cv=none; b=kDqF4EuqCbJVKbzqre3WgQWBny7d7CB442lbR+xk3bkSEsF7HTakAISlsuRZ8Y2cwIqQPqh7mWiCeIjLvMVpXMsP5/iz1Ph25Vyj1Z1AynAB76l35gpmhy4im3KQD74GR96Iaje/i7fpgrGqu/d7C3Gd1lPF8w2j43j/ykJFROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543975; c=relaxed/simple;
	bh=4dC4ZDeDROF3nw9tpuL+mISXlMm7geDfxO16p6Xykz4=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=tFOKQO/UY+QTng68ig2t18x15d2mDYFF3ckMC2bT+Ajk1ubl7YBHRfgh/bb33Y5lC5xgJFjdYZyQ2VaWOSdYio3iyBMAlgjUDr/MwcrmjTYg9/wbwa43ol2ZAjUnO6VU/P2tAcXB05cVm7AnyCq3QFEa6CyBMzOcCfgd4ZRZl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qezhMimt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5l5efZNY73Qhq1tGWozeEdJ6d0fwUHOUFXbDlZJhdxc=; b=qezhMimtZvQP7WzzivmmK56dcC
	LcTSdSHXVcQALW0kaZxu3T7uptCQcWE5xmul1tCGRFyV6jAxXS5/Hw/azDIY60pi1K7zew8nDRFOG
	XCV2+DASY32Xkgll+ccpN+OipwjfHc8vcLoarGfreFT0YUqjDqtrw56/mM8QQcgEvCo01/w+ujiYu
	sfx6Nx/o1+OVUIOWlTdPWjm9/RbXbGlQOA8yzfxhpgaN/NHdBHucYJ6T5CSn9GNhP6Ko4bndYRP6a
	V4EiE+nxi5U+H4yYHWeMBUFea/gKEYQvjUan2Z7w2l7SmQPSDsWg7Ll56UgZFaHv6g3CgPQwh1ffD
	NKta2JaA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQHtg-00000001EVK-1zNv;
	Thu, 18 Jan 2024 02:12:48 +0000
Date: Thu, 18 Jan 2024 02:12:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
Message-ID: <ZaiJIIrzUR7qPkjC@casper.infradead.org>
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
 <20240118013857.GO1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118013857.GO1674809@ZenIV>

On Thu, Jan 18, 2024 at 01:38:57AM +0000, Al Viro wrote:
> On Tue, Jan 16, 2024 at 03:53:35PM +0800, Baolin Wang wrote:
> 
> > With checking the 'dentry.parent' and 'dentry.d_name.name' used by
> > dentry_name(), I can see dump_mapping() will output the invalid dentry
> > instead of crashing the system when this issue is reproduced again.
> 
> >  	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
> > -	if (get_kernel_nofault(dentry, dentry_ptr)) {
> > +	if (get_kernel_nofault(dentry, dentry_ptr) ||
> > +	    !dentry.d_parent || !dentry.d_name.name) {
> >  		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
> >  				a_ops, ino, dentry_ptr);
> >  		return;
> 
> That's nowhere near enough.  Your ->d_name.name can bloody well be pointing
> to an external name that gets freed right under you.  Legitimately so.
> 
> Think what happens if dentry has a long name (longer than would fit into
> the embedded array) and gets renamed name just after you copy it into
> a local variable.  Old name will get freed.  Yes, freeing is RCU-delayed,
> but I don't see anything that would prevent your thread losing CPU
> and not getting it back until after the sucker's been freed.

Agreed that it's not enough.  It does usually work, and it's very
helpful when it does.  We've had it since 2018 (1c6fb1d89e73) and we've
been gradually making it more robust over time.  Part of my reason for
splitting dump_mapping() out of dump_page() was so that it would get
more review from people who understand the fs side of things ... and
that seems to have worked.

Can I trouble you to suggest a more robust solution?  Bear in mind that
dump_page() does get called on pointers which turn out not to even be
pointers to struct page so this is all very much best-effort, and giving
up and printing 'this is not a dentry" is always an option.

