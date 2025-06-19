Return-Path: <linux-fsdevel+bounces-52205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B4CAE0304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E033B6CD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7892264BF;
	Thu, 19 Jun 2025 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoMQ81Cl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEF1799F;
	Thu, 19 Jun 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330893; cv=none; b=U9+oAkAcGhnX1Pdcn6j7ZIcUWHcf8TtigB7DXuthRlE8MU8jH8Mk78GnZ1Rc8gIYNxvuibypyfKQhqyrugLVsVBVUhRCrF+WZPTSXnnz7uqDGtnoOl61lJy1X5rEhtYyFypOWq/6VabAXNtBqR4WIGxTr3FwpAmj8TBb1TW56ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330893; c=relaxed/simple;
	bh=rDmigmN49xXs0ZOjH9v39Y8p1cz3EI4TKppC8A5ZQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfVfjAtPwKVpLo8yY0wWxmV5+1V1r628HuWTfs7fX+GErM1h4ukFul/fwqBWylP9GHaoPQl4Vu+pGMIjPouUL71Ps46yRU/kRfg+/r00xCiwDk6PC3v7XPDa2ms5WGRg4Sqc64cr/cPnIlqgLqk0pC1beTEUyB6YUBJADOtcp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoMQ81Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D62DC4CEEA;
	Thu, 19 Jun 2025 11:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750330892;
	bh=rDmigmN49xXs0ZOjH9v39Y8p1cz3EI4TKppC8A5ZQxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoMQ81ClaVBTp7kQcn7uQPJivmnRlWWPqFzJYmXoRwpDIhLKNe8ZseCSKH58D42nQ
	 xGAW7qCI/lAPesK05F0n70kScG9o+ZftkU2K5GKYU9biS8X6AHYhdsD2S8oSOQArmq
	 9C3jnqq6fE9oFZMI4Seld/WQmbGrVvdfxwi1CcakXNUM9voUIEYbFBaSrvMJc/e3GG
	 0QZCZBdWDJtcsxjdRy4GfXRCbf0P+5Zwx5CSBICvZJmA+auwqb2M+T1ddqi9F2VM2V
	 w00NhI4ZGtEuzEp7WiCZE9TOVGDOF6v/XjicL7K4AGqyIHvztMLXrwpPJG7PEk06lE
	 yRChYbkEztqCQ==
Date: Thu, 19 Jun 2025 14:01:22 +0300
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
Message-ID: <aFPuAi8tPcmsbTF4@kernel.org>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>

On Thu, Jun 19, 2025 at 12:38:25PM +0200, Christian Brauner wrote:
> On Thu, Jun 19, 2025 at 11:13:49AM +0200, Vlastimil Babka wrote:
> > On 6/19/25 09:31, Shivank Garg wrote:
> > > Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> > > anonymous inodes with proper security context. This replaces the current
> > > pattern of calling alloc_anon_inode() followed by
> > > inode_init_security_anon() for creating security context manually.
> > > 
> > > This change also fixes a security regression in secretmem where the
> > > S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> > > LSM/SELinux checks to be bypassed for secretmem file descriptors.
> > > 
> > > As guest_memfd currently resides in the KVM module, we need to export this
> > 
> > Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
> > explicit for KVM?
> 
> Oh? Enlighten me about that, if you have a second, please. 

From Documentation/core-api/symbol-namespaces.rst:

The macro takes a comma separated list of module names, allowing only those
modules to access this symbol. Simple tail-globs are supported.

For example::

  EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")

will limit usage of this symbol to modules whoes name matches the given
patterns.


-- 
Sincerely yours,
Mike.

