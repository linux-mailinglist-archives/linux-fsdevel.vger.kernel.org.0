Return-Path: <linux-fsdevel+bounces-52231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F33AE0561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3ABD7ACA8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3723B609;
	Thu, 19 Jun 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbrveWT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B659230BF2;
	Thu, 19 Jun 2025 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335578; cv=none; b=df+ctUHjvkxG9a3D8FPs74V41CJ+Tgocu6IZ/sugTS/d2ueI0fcciWAMCrd5U9CowHRraklctKEoQwkykFGiTKwj1MbwMhLbyao7k6o6Dz4BJ7gf6oSLgU9zOQB51Y3Z6B0WlKBgJ2Glq1DOxy7/29YiFFArZgzLtgFo8MYffAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335578; c=relaxed/simple;
	bh=bWucXohm5UQliw0jgNdes75056dCx0VKGA2x7BaDfjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOBmDwFUtPAGYKeBQc8QaFf/acnngPlEggkFEqN/Zqjb/u+3+D374T3IA/y0MCMKmxKjjc/HjCuNCfL0ohX331JqMSwhoUJ2R/z8Z0UrE4/mTnFzBOItr3+ZbM9YOq560ne9pLI7fdoDgv+jgnKabEItIKWD37J8IM8i1x7DaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbrveWT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C377C4CEEA;
	Thu, 19 Jun 2025 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750335575;
	bh=bWucXohm5UQliw0jgNdes75056dCx0VKGA2x7BaDfjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbrveWT3Ix1MhEG9PoRbqXv+NwtVpookYbG87CTowWUM78ftAPSq3WhwrvGffRsly
	 Ss3Of6FJDub6bzJagswOrvX0zhzFraXBQAo6+pCbQ29lZIaFHTe1afbHVg3pSVSYsw
	 nULaNztFF7DU160x9Wv/KV9OwfOJ9XriFpBXA+6HQdEi4/fAaY2eKtmRP6+hst7AgQ
	 Yhl6G6+hp0fP/NPzVW2ZUwo0y+OF8szvwQrClId6cEIilOm3pDahCRqgupYlBepxhy
	 HelF+ftHLlfEQKrvP1AsVqknQbnT0Njhsfr8JeZbgI/5tXAOXxrfg7OZV0klKur9sX
	 vfWnJXwi5dYNg==
Date: Thu, 19 Jun 2025 15:19:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shivank Garg <shivankg@amd.com>,
	david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com,
	viro@zeniv.linux.org.uk, seanjc@google.com, willy@infradead.org,
	pbonzini@redhat.com, tabba@google.com, afranji@google.com,
	ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
	cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <aFQATWEX2h4LaQZb@kernel.org>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>

On Thu, Jun 19, 2025 at 02:06:17PM +0200, Christian Brauner wrote:
> On Thu, Jun 19, 2025 at 02:01:22PM +0300, Mike Rapoport wrote:
> > On Thu, Jun 19, 2025 at 12:38:25PM +0200, Christian Brauner wrote:
> > > On Thu, Jun 19, 2025 at 11:13:49AM +0200, Vlastimil Babka wrote:
> > > > On 6/19/25 09:31, Shivank Garg wrote:
> > > > > Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> > > > > anonymous inodes with proper security context. This replaces the current
> > > > > pattern of calling alloc_anon_inode() followed by
> > > > > inode_init_security_anon() for creating security context manually.
> > > > > 
> > > > > This change also fixes a security regression in secretmem where the
> > > > > S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> > > > > LSM/SELinux checks to be bypassed for secretmem file descriptors.
> > > > > 
> > > > > As guest_memfd currently resides in the KVM module, we need to export this
> > > > 
> > > > Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
> > > > explicit for KVM?
> > > 
> > > Oh? Enlighten me about that, if you have a second, please. 
> > 
> > From Documentation/core-api/symbol-namespaces.rst:
> > 
> > The macro takes a comma separated list of module names, allowing only those
> > modules to access this symbol. Simple tail-globs are supported.
> > 
> > For example::
> > 
> >   EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
> > 
> > will limit usage of this symbol to modules whoes name matches the given
> > patterns.
> 
> Is that still mostly advisory and can still be easily circumenvented?

The commit message says

   will limit the use of said function to kvm.ko, any other module trying
   to use this symbol will refure to load (and get modpost build
   failures).
 
-- 
Sincerely yours,
Mike.

