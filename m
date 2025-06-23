Return-Path: <linux-fsdevel+bounces-52597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C0AE4702
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5255D3AB691
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0C24DFF3;
	Mon, 23 Jun 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IZmcRgw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427337263F;
	Mon, 23 Jun 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688928; cv=none; b=lkjgzHyJXBH8vn964HJbZ4G6N5cDOcZF28jocL6zNl6Bu52XMXaRi3KTFu0vRsgQFoR1IzROQ8+jHHdsM3BMavIl3oRJHNfT7B31M+MXr9Z2hP56HvcwUztf8vSMFmME4i3byBgG1hxfE2dObPEgbvmOKT68Cx5Mg9Ob1vaCzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688928; c=relaxed/simple;
	bh=gIsZGD7xrODd86Bc0EvzkFe7uTg/IvFvLUlXMfZW9lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L87lxP6hFDaoy2pMpIDaw/ddnFg7WhXL9Z+J7ZJQj6P3fMb0SUIa7hOiyZs607YyqO1Z0RySmB6Y30V/HZ8kc8srkFpLMb0/tXqh+JKptc4GUIbl/Ierjv7O4V6zPdKAQndUJC8MtxvfazaL4mKu2YcvuzrjnEGLPQzP7hbr3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IZmcRgw7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3weVWwBOUYIW/Nf1kizuLqzTbeJjj2BrNnaadbwNoE=; b=IZmcRgw7N+Xa00EMi8GPuMLYgd
	HPnauGCGdBXcl4Aph05+5vuwgj8gGgye4hIILbZZs+qTcn2XNDon8u9UfOKJ0QI3cQol3s2fVB5SY
	+xkdHm4YdZ/eRpohX9V7lG2JWhYhvFX4Q6x4axidiKEylraO1KI6HY6TaSyEyjZwMETfafzPQ3CL5
	xKXH/NAs+jGBiZVJZcmqv1XexddcM5wC4GGpipWTN4mAIClKKSiFgXB8HRq2jkCwwD4vBfmn8E1b4
	iP3KECNmomjCtWTAY1VWXsriUAlD0liquNgfhWg0rV2Wn2eY3CQT+x2xYYKVFcS7IyEp4FhP+sJp5
	Z04IstBw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTiA2-00000003gMC-1oeA;
	Mon, 23 Jun 2025 14:28:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 978EB308989; Mon, 23 Jun 2025 16:28:36 +0200 (CEST)
Date: Mon, 23 Jun 2025 16:28:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Mike Rapoport <rppt@kernel.org>, Shivank Garg <shivankg@amd.com>,
	david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com,
	viro@zeniv.linux.org.uk, willy@infradead.org, pbonzini@redhat.com,
	tabba@google.com, afranji@google.com, ackerleytng@google.com,
	jack@suse.cz, cgzones@googlemail.com, ira.weiny@intel.com,
	roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <20250623142836.GT1613200@noisy.programming.kicks-ass.net>
References: <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org>
 <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org>
 <aFleJN_fE-RbSoFD@infradead.org>
 <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>

On Mon, Jun 23, 2025 at 04:21:15PM +0200, Vlastimil Babka wrote:
> On 6/23/25 16:01, Christoph Hellwig wrote:
> > On Mon, Jun 23, 2025 at 07:00:39AM -0700, Christoph Hellwig wrote:
> >> On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
> >> > I'm more than happy to switch a bunch of our exports so that we only
> >> > allow them for specific modules. But for that we also need
> >> > EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.
> >> 
> >> Huh?  Any export for a specific in-tree module (or set thereof) is
> >> by definition internals and an _GPL export if perfectly fine and
> >> expected.
> 
> Peterz tells me EXPORT_SYMBOL_GPL_FOR_MODULES() is not limited to in-tree
> modules, so external module with GPL and matching name can import.
> 
> But if we're targetting in-tree stuff like kvm, we don't need to provide a
> non-GPL variant I think?

So the purpose was to limit specific symbols to known in-tree module
users (hence GPL only).

Eg. KVM; x86 exports a fair amount of low level stuff just because KVM.
Nobody else should be touching those symbols.

If you have a pile of symbols for !GPL / out-of-tree consumers, it
doesn't really make sense to limit the export to a named set of modules,
does it?

So yes, nothing limits things to in-tree modules per-se. The
infrastructure only really cares about module names (and implicitly
trusts the OS to not overwrite existing kernel modules etc.). So you
could add an out-of-tree module name to the list (or have an out-of-free
module have a name that matches a glob; "kvm-vmware" would match "kvm-*"
for example).

But that is very much beyond the intention of things.



