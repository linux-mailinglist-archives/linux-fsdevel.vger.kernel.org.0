Return-Path: <linux-fsdevel+bounces-50599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF6ACD939
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 10:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8457C3A8C82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555128B3F9;
	Wed,  4 Jun 2025 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGe/uAgs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D623C4EE;
	Wed,  4 Jun 2025 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024165; cv=none; b=XddAhxs5rOjgc34D3h3TOXuS/lnojS3ogGMGozNHuJUOBCBd7MYhM4hp/8tJ8bphA+2HIpN8jJnU/Nyhrc3JeJc1xwRpSr5LLvwXinNQy7u8Xy+cab/hQDZD7vwdkhf4u6FeLr0Gof9VYWL7ROqoZ+6uDu+NQnwLCWQwjaB/Mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024165; c=relaxed/simple;
	bh=Jaqas4siZfyHC3zJUwFjJctoaJZnY6E7zLbs1Uswva0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtiQQwH8m6zJdhkFOBEdJ9EdSS6MYpZwPGN5RlZhrv5cfKn9qmY1S1VTOPHFmR5j4cp1AYQI9gJSmPIdKjHpGis/uWZultCBNJKAKryp/afb4akJ6lv7+jbPhDLfvmd9ehoInz0dRSeOEwuG7NsehIaNs8r8vlcEQ5tqm8SSpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGe/uAgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEDAC4CEE7;
	Wed,  4 Jun 2025 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749024162;
	bh=Jaqas4siZfyHC3zJUwFjJctoaJZnY6E7zLbs1Uswva0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGe/uAgsPIRQU2B2h16hQJgTBzIEgOdiEF4FKsN4XNIriqHqJ6kHgQ5iHr0a/PtrJ
	 IWvt7c4eSRh4Kerl88SEGyp1StCq/y/k9wKYlkPhswytp+CavJA5CjU/RBkWT9s4N3
	 iMZnrGVoEHbgIa2pAnyGl3mhSigAg5flocJoCgPQfPagn8sjGi41L+UG30Bcld5sZ3
	 h9OfBVajv5cf+1tQSBKURhDx7qksnrUdvtzKX5Nl5MTF8atMqODyrjtZwM1anCwNoq
	 Qx9UXNB1Uteet4o7SEmkC5nVPPkjw9g0gXuOV4APy+1USZpTdRR29AscXKceq9l5iE
	 4JcGR7i8WmDHA==
Date: Wed, 4 Jun 2025 10:02:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maz@kernel.org, mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, 
	palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com, 
	pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, 
	pvorel@suse.cz, qperret@google.com, quic_cvanscha@quicinc.com, 
	quic_eberman@quicinc.com, quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, 
	quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, shuah@kernel.org, 
	steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	tabba@google.com, thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
Message-ID: <20250604-rational-stunk-9427c610c219@brauner>
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>

On Mon, Jun 02, 2025 at 12:17:54PM -0700, Ackerley Tng wrote:
> The new function, alloc_anon_secure_inode(), returns an inode after
> running checks in security_inode_init_security_anon().
> 
> Also refactor secretmem's file creation process to use the new
> function.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---

Once -rc1 is out I'll pull the VFS bits and provide a branch that
remains stable for the duration of v6.16 development that can be pulled.

