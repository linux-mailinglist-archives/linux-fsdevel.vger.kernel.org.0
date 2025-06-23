Return-Path: <linux-fsdevel+bounces-52513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC8AE3C03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66D7166B31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049923C4ED;
	Mon, 23 Jun 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUjqUI2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A223BCE3;
	Mon, 23 Jun 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673797; cv=none; b=lrl/HOcoOI3Rpq9s6A742gyDPZoOiMGDUoZwz7N6IAW0xN4Sa+zGkRyay3+BT+0vIl9EPj4tll71BDsjy+KHaAJv5Y+xdGltCfbX1fCa60K2I4bDcACa/Y6LOeljs+MdHxoDHtUkbAALcQAOhbYhiK3k6VnN0q6wqo+9TZqdVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673797; c=relaxed/simple;
	bh=uANWeMNyTEGUxGx9R6g80F8R/lxIBbDL+x6N92SBdcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUnpS19orifCDmbUMPSk0rQ6C37fil2xLFr8MImo2MEnTUcOKw0ngffs/507nCbVXtT4AJvuOX7uca4qTo6pdODGKlulZz3h9T16w+Xrhq3K8PQqSgID0d+S2h3C2RE5IhWSRYjckIgqLiW9f8Y3C1qex5hS0yXsieTXo5Th9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUjqUI2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE6EC4CEF0;
	Mon, 23 Jun 2025 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750673796;
	bh=uANWeMNyTEGUxGx9R6g80F8R/lxIBbDL+x6N92SBdcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUjqUI2tWmvPUPoMTkwJDfBa0vFFJLqGjdn+pzExsg2adnrlJ9aQi6TlF/4QMR/lW
	 2QXmBWrc7i8N7RFeJu39wki9n3pVEpGTCOi0ZpPJtUv6LNbbJ3BNjzNmJO0vexSjhH
	 Y/b36coxu7XGxmkU8Hyefqemrb15U6fOREfQ++8wzL6B1EJj0ne3IyZRLBicjbgPIn
	 Rg3FXxu2I5263anXonUzxyhQWRxCkfM54smFSWhOL/Zq5kfLzUE5wqU7ZaA5OFQV7r
	 t+k/siDb5gQAv+lmeoLZT038qa06KHlD2yAS2P0IiIPxL0vJJoyvjkbKf7C9V9kHwD
	 VMr35Yv8SS0Sw==
Date: Mon, 23 Jun 2025 12:16:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Shivank Garg <shivankg@amd.com>, david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org, pbonzini@redhat.com, tabba@google.com, 
	afranji@google.com, ackerleytng@google.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <20250623-warmwasser-giftig-ff656fce89ad@brauner>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org>
 <aFV3-sYCxyVIkdy6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFV3-sYCxyVIkdy6@google.com>

On Fri, Jun 20, 2025 at 08:02:18AM -0700, Sean Christopherson wrote:
> On Thu, Jun 19, 2025, Mike Rapoport wrote:
> > On Thu, Jun 19, 2025 at 02:06:17PM +0200, Christian Brauner wrote:
> > > On Thu, Jun 19, 2025 at 02:01:22PM +0300, Mike Rapoport wrote:
> > > > On Thu, Jun 19, 2025 at 12:38:25PM +0200, Christian Brauner wrote:
> > > > > On Thu, Jun 19, 2025 at 11:13:49AM +0200, Vlastimil Babka wrote:
> > > > > > On 6/19/25 09:31, Shivank Garg wrote:
> > > > > > > Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> > > > > > > anonymous inodes with proper security context. This replaces the current
> > > > > > > pattern of calling alloc_anon_inode() followed by
> > > > > > > inode_init_security_anon() for creating security context manually.
> > > > > > > 
> > > > > > > This change also fixes a security regression in secretmem where the
> > > > > > > S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> > > > > > > LSM/SELinux checks to be bypassed for secretmem file descriptors.
> > > > > > > 
> > > > > > > As guest_memfd currently resides in the KVM module, we need to export this
> > > > > > 
> > > > > > Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
> > > > > > explicit for KVM?
> > > > > 
> > > > > Oh? Enlighten me about that, if you have a second, please. 
> > > > 
> > > > From Documentation/core-api/symbol-namespaces.rst:
> > > > 
> > > > The macro takes a comma separated list of module names, allowing only those
> > > > modules to access this symbol. Simple tail-globs are supported.
> > > > 
> > > > For example::
> > > > 
> > > >   EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
> > > > 
> > > > will limit usage of this symbol to modules whoes name matches the given
> > > > patterns.
> > > 
> > > Is that still mostly advisory and can still be easily circumenvented?
> 
> Yes and no.  For out-of-tree modules, it's mostly advisory.  Though I can imagine
> if someone tries to report a bug because their module is masquerading as e.g. kvm,
> then they will be told to go away (in far less polite words :-D).
> 
> For in-tree modules, the restriction is much more enforceable.  Renaming a module
> to circumvent a restricted export will raise major red flags, and getting "proper"
> access to a symbol would require an ack from the relevant maintainers.  E.g. for
> many KVM-induced exports, it's not that other module writers are trying to misbehave,
> there simply aren't any guardrails to deter them from using a "dangerous" export.
>  
> The other big benefit I see is documentation, e.g. both for readers/developers to
> understand the intent, and for auditing purposes (I would be shocked if there
> aren't exports that were KVM-induced, but that are no longer necessary).
> 
> And we can utilize the framework to do additional hardening.  E.g. for exports
> that exist solely for KVM, I plan on adding wrappers so that the symbols are
> exproted if and only if KVM is enabled in the kernel .config[*].  Again, that's
> far from perfect, e.g. AFAIK every distro enables KVM, but it should help keep
> everyone honest.
> 
> [*] https://lore.kernel.org/all/ZzJOoFFPjrzYzKir@google.com 
> 
> > The commit message says
> > 
> >    will limit the use of said function to kvm.ko, any other module trying
> >    to use this symbol will refure to load (and get modpost build
> >    failures).
> 
> To Christian's point, the restrictions are trivial to circumvent by out-of-tree
> modules.  E.g. to get access to the above, simply name your module kvm-lol.ko or
> whatever.

Thanks for all the details!
I'm more than happy to switch a bunch of our exports so that we only
allow them for specific modules. But for that we also need
EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.

