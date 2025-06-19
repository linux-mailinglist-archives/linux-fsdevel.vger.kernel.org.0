Return-Path: <linux-fsdevel+bounces-52151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5FAADFD0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 07:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B5317DB3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 05:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B5224292E;
	Thu, 19 Jun 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR4cAjwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7B23A9A0;
	Thu, 19 Jun 2025 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311442; cv=none; b=fXF8fCht2AjwwYcAwmoet3Nsai7kPz8r/65NbwkutmXrv6ZKUN5DQnTTaoC0LtpPjJqvPKmG/Mb0lEUdAFdN0xa/+AphjpAyPagpFWNjTHExNMpcYyCU/o6/CuItWGNycZVy9Aznk1bF8OZDs2vPGzyu4O+MabNmpJOUl9abwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311442; c=relaxed/simple;
	bh=CGFYslQlYW28b83jtPiXInTX2NXpIKy71b9x3BZGqSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl73Or3TKF5pQ5jqJohW5YDN/2spIyeAlhP4C8nizWtC8gjP5bQizJ/2TI173XD1ZQoknQmcd0CSrftRq0X1pKLNK77pYJAlhkn4jiO9air1oVPKkLf0hKb8Tf0MZ6sppE/hihSzukB4AYPTBBhT7PfmgQpAxNiB2R+7lDszRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR4cAjwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FBCC4CEEA;
	Thu, 19 Jun 2025 05:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750311441;
	bh=CGFYslQlYW28b83jtPiXInTX2NXpIKy71b9x3BZGqSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OR4cAjwNo5wTYjgFpDC06vgMwWeVUlDkFt6P/PrdIsZc5cizAUV5QN+ZwbHohDycZ
	 HH2zoU0ftohWLkRwMQPyWPT2yndJWQXBzxp/1gZr7g030cH8ZxL0HQ1JHMRBxp6ZjE
	 SQPIypgESqrDheTs8P8q9DJn3McibdDMY2/uUr1gUkLHGsU0FougmgKnk3EfFahcMf
	 8p7SPvWyq3QrtydLEZxp4Oxsj1UW5n40m7AwrSCbw5w75WS8tfHRMoihWOSxlptPA+
	 vM9CP6m8PKGUQJqIrLZaK5IzpuhToHZ1dJIGPZLoV6QiyX8K01e1OVQOqDSOb5AXkr
	 GQmKqnw4EifCw==
Date: Thu, 19 Jun 2025 08:36:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Shivank Garg <shivankg@amd.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Paul Moore <paul@paul-moore.com>,
	Ackerley Tng <ackerleytng@google.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-fsdevel@vger.kernel.org, aik@amd.com, ajones@ventanamicro.com,
	akpm@linux-foundation.org, amoorthy@google.com,
	anthony.yznaga@oracle.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, bfoster@redhat.com,
	binbin.wu@linux.intel.com, brauner@kernel.org,
	catalin.marinas@arm.com, chao.p.peng@intel.com,
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com,
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, graf@amazon.com,
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com,
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com,
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com,
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com,
	kent.overstreet@linux.dev, kirill.shutemov@intel.com,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev,
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
	palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
	pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com,
	pgonda@google.com, pvorel@suse.cz, qperret@google.com,
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
	quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com,
	quic_tsoni@quicinc.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	roypat@amazon.co.uk, seanjc@google.com, shuah@kernel.org,
	steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, tabba@google.com, thomas.lendacky@amd.com,
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
Message-ID: <aFOh8N_rRdSi_Fbc@kernel.org>
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
 <aD_8z4pd7JcFkAwX@kernel.org>
 <CAHC9VhQczhrVx4YEGbXbAS8FLi0jaV1RB0kb8e4rPsUOXYLqtA@mail.gmail.com>
 <aEEv-A1ot_t8ePgv@kernel.org>
 <CAHC9VhR3dKsXYAxY+1Ujr4weO=iBHMPHsJ3-8f=wM5q_oo81wA@mail.gmail.com>
 <68430497a6fbf_19ff672943@iweiny-mobl.notmuch>
 <647ab7a4-790f-4858-acf2-0f6bae5b7f99@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <647ab7a4-790f-4858-acf2-0f6bae5b7f99@amd.com>

On Mon, Jun 16, 2025 at 06:30:09PM +0530, Shivank Garg wrote:
> 
> 
> On 6/6/2025 8:39 PM, Ira Weiny wrote:
> > Paul Moore wrote:
> >> On Thu, Jun 5, 2025 at 1:50 AM Mike Rapoport <rppt@kernel.org> wrote:
> >>>
> >>> secretmem always had S_PRIVATE set because alloc_anon_inode() clears it
> >>> anyway and this patch does not change it.
> >>
> >> Yes, my apologies, I didn't look closely enough at the code.
> >>
> >>> I'm just thinking that it makes sense to actually allow LSM/SELinux
> >>> controls that S_PRIVATE bypasses for both secretmem and guest_memfd.
> >>
> >> It's been a while since we added the anon_inode hooks so I'd have to
> >> go dig through the old thread to understand the logic behind marking
> >> secretmem S_PRIVATE, especially when the
> >> anon_inode_make_secure_inode() function cleared it.  It's entirely
> >> possible it may have just been an oversight.

anon_inode_make_secure_inode() was introduced when more than 10 versions of
secretmem already were posted so it didn't jump at me to replace
alloc_anon_inode() with anon_inode_make_secure_inode().
 
> > I'm jumping in where I don't know what I'm talking about...
> > 
> > But my reading of the S_PRIVATE flag is that the memory can't be mapped by
> > user space.  So for guest_memfd() we need !S_PRIVATE because it is
> > intended to be mapped by user space.  So we want the secure checks.
> > 
> > I think secretmem is the same.

Agree.

> > Do I have that right?
> 
> 
> Hi Mike, Paul,
> 
> If I understand correctly,
> we need to clear the S_PRIVATE flag for all secure inodes. The S_PRIVATE flag was previously
> set for  secretmem (via alloc_anon_inode()), which caused security checks to be 
> bypassed - this was unintentional since the original anon_inode_make_secure_inode() 
> was already clearing it.
> 
> Both secretmem and guest_memfd create file descriptors
> (memfd_create/kvm_create_guest_memfd)
> so they should be subject to LSM/SELinux security policies rather than bypassing them with S_PRIVATE?
> 
> static struct inode *anon_inode_make_secure_inode(struct super_block *s,
> 		const char *name, const struct inode *context_inode)
> {
> ...
> 	/* Clear S_PRIVATE for all inodes*/
> 	inode->i_flags &= ~S_PRIVATE;
> ...
> }
> 
> Please let me know if this conclusion makes sense?

Yes, makes sense to me.
 
> Thanks,
> Shivank

-- 
Sincerely yours,
Mike.

