Return-Path: <linux-fsdevel+bounces-25040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326A59482C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 22:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCC2283C18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD116BE3A;
	Mon,  5 Aug 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMqHCmnc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ScPloEQ7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMqHCmnc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ScPloEQ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54D15B56E;
	Mon,  5 Aug 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888120; cv=none; b=YebLJ/yrxauPIIIGvmXPauD9Jewa74NTJlRQVt7QfC4ZIsvjWNO+aQsDafcSxfBR/oAVNCIgPwkS+4DMash0aAVuiLUr3BF+SpHDMiAIBooA8wIshFWJkd/lUvqcmSefSo5YX7K0IJSaVvbBqhITiNH4N7JOR4TialjXtCmL7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888120; c=relaxed/simple;
	bh=gxmLp/uNXBqOn3x/iW2dRhbCOZm9iruQv3aR2yaJInI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqR8QTfGO9dfgo/6uVS4iNiyJD14QFsCVJOvwyZv9wEj8m5ApgPgvUUeESvZ0Eiv/9CJwX0vTOE1s103ABxoX4gDo2lr/sfvpzBfYJZFXtRja+8EVruqe6BmnM7jCwEHspmREjf1wlRodV2S2NcJbRPXioo0tP6XeXrFwjjGb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMqHCmnc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ScPloEQ7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMqHCmnc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ScPloEQ7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A8EA21C29;
	Mon,  5 Aug 2024 20:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722888116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64a1DXPlbrf25f/h5mLAdBWVSzHjNTzOUcAhNjirtAg=;
	b=tMqHCmncotrXz/nzMuNgxDqbPnsK6ah+IdGUnbPhbZW9ZD28X2pouFJIh7cbfZKi1g1jzB
	Bq4oMQ9M3k0mklHUKNaLCIM4yR25t86m/RWMqaPWQSRbFifwcZXNgfJhmHBso3CL8j3UPl
	9dxeuEQTHJm8RcuHVKPQWZPNEmBAVGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722888116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64a1DXPlbrf25f/h5mLAdBWVSzHjNTzOUcAhNjirtAg=;
	b=ScPloEQ7MpQpFGh1w1ttbQE42oDdsub/cLdJCBQdwFrOBOLCCP+9a7MCwvleDG51TmbkQ7
	5yGS5bnYWan5W5AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722888116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64a1DXPlbrf25f/h5mLAdBWVSzHjNTzOUcAhNjirtAg=;
	b=tMqHCmncotrXz/nzMuNgxDqbPnsK6ah+IdGUnbPhbZW9ZD28X2pouFJIh7cbfZKi1g1jzB
	Bq4oMQ9M3k0mklHUKNaLCIM4yR25t86m/RWMqaPWQSRbFifwcZXNgfJhmHBso3CL8j3UPl
	9dxeuEQTHJm8RcuHVKPQWZPNEmBAVGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722888116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64a1DXPlbrf25f/h5mLAdBWVSzHjNTzOUcAhNjirtAg=;
	b=ScPloEQ7MpQpFGh1w1ttbQE42oDdsub/cLdJCBQdwFrOBOLCCP+9a7MCwvleDG51TmbkQ7
	5yGS5bnYWan5W5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F4C113254;
	Mon,  5 Aug 2024 20:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rtVsD7QvsWYxLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 20:01:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B4F8A0663; Mon,  5 Aug 2024 22:01:51 +0200 (CEST)
Date: Mon, 5 Aug 2024 22:01:51 +0200
From: Jan Kara <jack@suse.cz>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-fsdevel@vger.kernel.org,
	Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paul Durrant <pdurrant@amazon.co.uk>,
	Nicolas Saenz Julienne <nsaenz@amazon.es>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory
 filesystem
Message-ID: <20240805200151.oja474ju4i32y5bj@quack3>
References: <20240805093245.889357-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 05-08-24 11:32:35, James Gowans wrote:
> In this patch series a new in-memory filesystem designed specifically
> for live update is implemented. Live update is a mechanism to support
> updating a hypervisor in a way that has limited impact to running
> virtual machines. This is done by pausing/serialising running VMs,
> kexec-ing into a new kernel, starting new VMM processes and then
> deserialising/resuming the VMs so that they continue running from where
> they were. To support this, guest memory needs to be preserved.
> 
> Guestmemfs implements preservation acrosss kexec by carving out a large
> contiguous block of host system RAM early in boot which is then used as
> the data for the guestmemfs files. As well as preserving that large
> block of data memory across kexec, the filesystem metadata is preserved
> via the Kexec Hand Over (KHO) framework (still under review):
> https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com/
> 
> Filesystem metadata is structured to make preservation across kexec
> easy: inodes are one large contiguous array, and each inode has a
> "mappings" block which defines which block from the filesystem data
> memory corresponds to which offset in the file.
> 
> There are additional constraints/requirements which guestmemfs aims to
> meet:
> 
> 1. Secret hiding: all filesystem data is removed from the kernel direct
> map so immune from speculative access. read()/write() are not supported;
> the only way to get at the data is via mmap.
> 
> 2. Struct page overhead elimination: the memory is not managed by the
> buddy allocator and hence has no struct pages.
> 
> 3. PMD and PUD level allocations for TLB performance: guestmemfs
> allocates PMD-sized pages to back files which improves TLB perf (caveat
> below!). PUD size allocations are a next step.
> 
> 4. Device assignment: being able to use guestmemfs memory for
> VFIO/iommufd mappings, and allow those mappings to survive and continue
> to be used across kexec.
 
To me the basic functionality resembles a lot hugetlbfs. Now I know very
little details about hugetlbfs so I've added relevant folks to CC. Have you
considered to extend hugetlbfs with the functionality you need (such as
preservation across kexec) instead of implementing completely new filesystem?

								Honza
 
> Next steps
> =========
> 
> The idea is that this patch series implements a minimal filesystem to
> provide the foundations for in-memory persistent across kexec files.
> One this foundation is in place it will be extended:
> 
> 1. Improve the filesystem to be more comprehensive - currently it's just
> functional enough to demonstrate the main objective of reserved memory
> and persistence via KHO.
> 
> 2. Build support for iommufd IOAS and HWPT persistence, and integrate
> that with guestmemfs. The idea is that if VMs have DMA devices assigned
> to them, DMA should continue running across kexec. A future patch series
> will add support for this in iommufd and connect iommufd to guestmemfs
> so that guestmemfs files can remain mapped into the IOMMU during kexec.
> 
> 3. Support a guest_memfd interface to files so that they can be used for
> confidential computing without needing to mmap into userspace.
> 
> 3. Gigantic PUD level mappings for even better TLB perf.
> 
> Caveats
> =======
> 
> There are a issues with the current implementation which should be
> solved either in this patch series or soon in follow-on work:
> 
> 1. Although PMD-size allocations are done, PTE-level page tables are
> still created. This is because guestmemfs uses remap_pfn_range() to set
> up userspace pgtables. Currently remap_pfn_range() only creates
> PTE-level mappings. I suggest enhancing remap_pfn_range() to support
> creating higher level mappings where possible, by adding pmd_special
> and pud_special flags.
> 
> 2. NUMA support is currently non-existent. To make this more generally
> useful it's necessary to have NUMA-awareness. One thought on how to do
> this is to be able to specify multiple allocations with wNUMA affinity
> on the kernel cmdline and have multiple mount points, one per NUMA node.
> Currently, for simplicity, only a single contiguous filesystem data
> allocation and a single mount point is supported.
> 
> 3. MCEs are currently not handled - we need to add functionality for
> this to be able to track block ownership and deliver an MCE correctly.
> 
> 4. Looking for reviews from filesystem experts to see if necessary
> callbacks, refcounting, locking, etc, is done correctly.
> 
> Open questions
> ==============
> 
> It is not too clear if or how guestmemfs should use DAX as a source of
> memory. Seeing as guestmemfs has an in-memory design, it seems that it
> is not necessary to use DAX as a source of memory, but I am keen for
> guidance/input on whether DAX should be used here.
> 
> The filesystem data memory is removed from the direct map for secret
> hiding, but it is still necessary to mmap it to be accessible to KVM.
> For improving secret hiding even more a guest_memfd-style interface
> could be used to remove the need to mmap. That introduces a new problem
> of the memory being completely inaccessible to KVM for this like MMIO
> instruction emulation. How can this be handled?
> 
> Related Work
> ============
> 
> There are similarities to a few attempts at solving aspects of this
> problem previously.
> 
> The original was probably PKRAM from Oracle; a tempfs filesystem with
> persistence:
> https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com/
> guestmemfs will additionally provide secret hiding, PMD/PUD allocations
> and a path to DMA persistence and NUMA support.
> 
> Dmemfs from Tencent aimed to remove the need for struct page overhead:
> https://lore.kernel.org/kvm/cover.1602093760.git.yuleixzhang@tencent.com/
> Guestmemfs provides this benefit too, along with persistence across
> kexec and secret hiding. 
> 
> Pkernfs attempted to solve guest memory persistence and IOMMU
> persistence all in one:
> https://lore.kernel.org/all/20240205120203.60312-1-jgowans@amazon.com/
> Guestmemfs is a re-work of that to only persist guest RAM in the
> filesystem, and to use KHO for filesystem metadata. IOMMU persistence
> will be implemented independently with persistent iommufd domains via
> KHO.
> 
> Testing
> =======
> 
> The testing for this can be seen in the Documentation file in this patch
> series. Essentially it is using a guestmemfs file for a QEMU VM's RAM,
> doing a kexec, restoring the QEMU VM and confirming that the VM picked
> up from where it left off.
> 
> James Gowans (10):
>   guestmemfs: Introduce filesystem skeleton
>   guestmemfs: add inode store, files and dirs
>   guestmemfs: add persistent data block allocator
>   guestmemfs: support file truncation
>   guestmemfs: add file mmap callback
>   kexec/kho: Add addr flag to not initialise memory
>   guestmemfs: Persist filesystem metadata via KHO
>   guestmemfs: Block modifications when serialised
>   guestmemfs: Add documentation and usage instructions
>   MAINTAINERS: Add maintainers for guestmemfs
> 
>  Documentation/filesystems/guestmemfs.rst |  87 +++++++
>  MAINTAINERS                              |   8 +
>  arch/x86/mm/init_64.c                    |   2 +
>  fs/Kconfig                               |   1 +
>  fs/Makefile                              |   1 +
>  fs/guestmemfs/Kconfig                    |  11 +
>  fs/guestmemfs/Makefile                   |   8 +
>  fs/guestmemfs/allocator.c                |  40 +++
>  fs/guestmemfs/dir.c                      |  43 ++++
>  fs/guestmemfs/file.c                     | 106 ++++++++
>  fs/guestmemfs/guestmemfs.c               | 160 ++++++++++++
>  fs/guestmemfs/guestmemfs.h               |  60 +++++
>  fs/guestmemfs/inode.c                    | 189 ++++++++++++++
>  fs/guestmemfs/serialise.c                | 302 +++++++++++++++++++++++
>  include/linux/guestmemfs.h               |  16 ++
>  include/uapi/linux/kexec.h               |   6 +
>  kernel/kexec_kho_in.c                    |  12 +-
>  kernel/kexec_kho_out.c                   |   4 +
>  18 files changed, 1055 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/filesystems/guestmemfs.rst
>  create mode 100644 fs/guestmemfs/Kconfig
>  create mode 100644 fs/guestmemfs/Makefile
>  create mode 100644 fs/guestmemfs/allocator.c
>  create mode 100644 fs/guestmemfs/dir.c
>  create mode 100644 fs/guestmemfs/file.c
>  create mode 100644 fs/guestmemfs/guestmemfs.c
>  create mode 100644 fs/guestmemfs/guestmemfs.h
>  create mode 100644 fs/guestmemfs/inode.c
>  create mode 100644 fs/guestmemfs/serialise.c
>  create mode 100644 include/linux/guestmemfs.h
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

