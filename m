Return-Path: <linux-fsdevel+bounces-52224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A5AE0519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7F23A90B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C24C22F76F;
	Thu, 19 Jun 2025 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXJSLurJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31121A94F;
	Thu, 19 Jun 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334785; cv=none; b=C8fXkcmo43JxDgdmAZewLmPf+hUCP3UYn3Rxoxqf3Bj2B1JrKuEOGlaRe2qaoZETFP4gclXaY10R5+WNiNAlEmaER0gL2Wj3ZN8qUPDAaeopR6O+zhyHQKT7t2yqZez88AaeDeyxXYhiRHBoUaBEIU6uN72sIEN9c8zo7+f3CEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334785; c=relaxed/simple;
	bh=qCHpBeYXKcvLBhGYRvbWtM3m7ZUS3RMm3uxtfmdZNfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeguKt8u1NAXbuFtZA8XwnjKIOdJIO/i3nGu7Y+FkhyTJj0gGEPcXYDe+wULtvYkIHhDOiKpKDpyZMUsaACcywPOpkh7tewZWZgExNxVdEgBRdpALCminBNbLwCwzu1XiJp5t7D/IVqQgspwXf4RmaKH5l2cAs9UBaVS18FvLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXJSLurJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2C2C4CEEA;
	Thu, 19 Jun 2025 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750334784;
	bh=qCHpBeYXKcvLBhGYRvbWtM3m7ZUS3RMm3uxtfmdZNfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXJSLurJV0FMeFP5DScAD7u8DQTWMZDvGTMxtvmIQM8PosQIckjMSty1/wRiztHLi
	 DOza4j0ZvxolOQhPW/6605ikqSH/FTzFQJG3EZ9BrXG9XPD2fL3Fyvqa0SV5CDiJEV
	 cY9jXFNJ3R6AUASaHlIMQg1BUAwZ6PpQ+sI/RSQCg51U7OkIUKPvHA0PuvYANQmA4h
	 jY7xbgfa1XaYMs0CaMYiGzmGvUyrtOG169+NATQEvDlY5KqyWUkbfeBFHL8V9hkqIF
	 X8IBtDm/O8wzWENYBGoZN4xMFi8eliVnYY/NrAxZVwSUCwteHhYJGfqg2NNBWbvkmQ
	 frNk8QOyxh/Gw==
Date: Thu, 19 Jun 2025 14:06:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shivank Garg <shivankg@amd.com>, 
	david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com, 
	viro@zeniv.linux.org.uk, seanjc@google.com, willy@infradead.org, pbonzini@redhat.com, 
	tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFPuAi8tPcmsbTF4@kernel.org>

On Thu, Jun 19, 2025 at 02:01:22PM +0300, Mike Rapoport wrote:
> On Thu, Jun 19, 2025 at 12:38:25PM +0200, Christian Brauner wrote:
> > On Thu, Jun 19, 2025 at 11:13:49AM +0200, Vlastimil Babka wrote:
> > > On 6/19/25 09:31, Shivank Garg wrote:
> > > > Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> > > > anonymous inodes with proper security context. This replaces the current
> > > > pattern of calling alloc_anon_inode() followed by
> > > > inode_init_security_anon() for creating security context manually.
> > > > 
> > > > This change also fixes a security regression in secretmem where the
> > > > S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> > > > LSM/SELinux checks to be bypassed for secretmem file descriptors.
> > > > 
> > > > As guest_memfd currently resides in the KVM module, we need to export this
> > > 
> > > Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
> > > explicit for KVM?
> > 
> > Oh? Enlighten me about that, if you have a second, please. 
> 
> From Documentation/core-api/symbol-namespaces.rst:
> 
> The macro takes a comma separated list of module names, allowing only those
> modules to access this symbol. Simple tail-globs are supported.
> 
> For example::
> 
>   EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
> 
> will limit usage of this symbol to modules whoes name matches the given
> patterns.

Is that still mostly advisory and can still be easily circumenvented?

