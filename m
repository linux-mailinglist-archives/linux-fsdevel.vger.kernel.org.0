Return-Path: <linux-fsdevel+bounces-70138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC13C91FAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 13:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26E74349D89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5131328B7E;
	Fri, 28 Nov 2025 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFYuo7O6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC0328267;
	Fri, 28 Nov 2025 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332708; cv=none; b=ROfXyXO25UbO6O51ssvVIQqmVv/oz75zQ/Z5X37e8vr23JfJzl7XQT3q8gG/F2DRci5mJ5Jjs0fww8x+6kB8LCOpBe2rXIVTqTCGWVOQmmYCoiyam+Epk0GN8m2yLPEYXa+gyoJsbZZuuLw76/0GuPDRGIkPI97Q7kbbmnApaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332708; c=relaxed/simple;
	bh=w//MMNaJ76/6XmuFlJvBo5HIxOMDYwo1z3nrqJzcqPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbx9IfEc9OD9cvmGeZi005412NcJpR1eSiqMKlnHyZenz+Q+Qu0Wu0SJmum+lWpGvfQOpvgeLkbk60RNTd8LoowvZfn99+fKJAFaGKB33XykRS7VJxRN+QlW2WmYZ5RTc7MqCUZbVip7jAwkLzjzBP9AqjdL2he6o7LNQ1a2Xws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFYuo7O6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA2FC4CEF1;
	Fri, 28 Nov 2025 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764332707;
	bh=w//MMNaJ76/6XmuFlJvBo5HIxOMDYwo1z3nrqJzcqPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFYuo7O6PCmDiLmkZeeh6nVMNHkwYIYbsLmfcKYnkYNKUATjFpjfTZFq3Q+28KE7g
	 ylt9vg//gd1+4k8VyYXowAEW5KYWTyqqH8fDxCjY7xCdp0JYC8lbiAvqFTPDSDuzVd
	 ZZNkKSnMf7l6FLFaN4UTLygN0pK+cATxNDnYUILy8odb1QsWZhW9MIh21tT3yRxRKR
	 pKfcxYFqWNwThsn7KLBSaNRF1fHII9S2TmQ2dqm3qTKUm2S1BIPmkAq6tPt30ayMfV
	 tVfq4PWAJPQDJP9s/Mj6hQm3sivZGux0EL/3BnsxPBqKy22MZCFiBrON583IqSyDV9
	 Ng7LVaqtx5vZQ==
Date: Fri, 28 Nov 2025 12:25:01 +0000
From: Will Deacon <will@kernel.org>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: jack@suse.com, brauner@kernel.org, hch@lst.de,
	akpm@linux-foundation.org, linux@armlinux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	yangerkun@huawei.com, wangkefeng.wang@huawei.com,
	pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <aSmUnZZATTn3JD7m@willie-the-truck>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <aShLKpTBr9akSuUG@willie-the-truck>
 <9ff0d134-2c64-4204-bbac-9fdf0867ac46@huaweicloud.com>
 <39d99c56-3c2f-46bd-933f-2aef69d169f3@huaweicloud.com>
 <61757d05-ffce-476d-9b07-88332e5db1b9@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61757d05-ffce-476d-9b07-88332e5db1b9@huaweicloud.com>

On Fri, Nov 28, 2025 at 09:39:45AM +0800, Zizhi Wo wrote:
> 在 2025/11/28 9:18, Zizhi Wo 写道:
> > 在 2025/11/28 9:17, Zizhi Wo 写道:
> > > 在 2025/11/27 20:59, Will Deacon 写道:
> > > > On Wed, Nov 26, 2025 at 05:05:05PM +0800, Zizhi Wo wrote:
> > > > > We're running into the following issue on an ARM32 platform
> > > > > with the linux
> > > > > 5.10 kernel:
> > > > > 
> > > > > [<c0300b78>] (__dabt_svc) from [<c0529cb8>]
> > > > > (link_path_walk.part.7+0x108/0x45c)
> > > > > [<c0529cb8>] (link_path_walk.part.7) from [<c052a948>]
> > > > > (path_openat+0xc4/0x10ec)
> > > > > [<c052a948>] (path_openat) from [<c052cf90>] (do_filp_open+0x9c/0x114)
> > > > > [<c052cf90>] (do_filp_open) from [<c0511e4c>]
> > > > > (do_sys_openat2+0x418/0x528)
> > > > > [<c0511e4c>] (do_sys_openat2) from [<c0513d98>] (do_sys_open+0x88/0xe4)
> > > > > [<c0513d98>] (do_sys_open) from [<c03000c0>]
> > > > > (ret_fast_syscall+0x0/0x58)
> > > > > ...
> > > > > [<c0315e34>] (unwind_backtrace) from [<c030f2b0>]
> > > > > (show_stack+0x20/0x24)
> > > > > [<c030f2b0>] (show_stack) from [<c14239f4>] (dump_stack+0xd8/0xf8)
> > > > > [<c14239f4>] (dump_stack) from [<c038d188>]
> > > > > (___might_sleep+0x19c/0x1e4)
> > > > > [<c038d188>] (___might_sleep) from [<c031b6fc>]
> > > > > (do_page_fault+0x2f8/0x51c)
> > > > > [<c031b6fc>] (do_page_fault) from [<c031bb44>]
> > > > > (do_DataAbort+0x90/0x118)
> > > > > [<c031bb44>] (do_DataAbort) from [<c0300b78>] (__dabt_svc+0x58/0x80)
> > > > > ...
> > > > > 
> > > > > During the execution of
> > > > > hash_name()->load_unaligned_zeropad(), a potential
> > > > > memory access beyond the PAGE boundary may occur. For example, when the
> > > > > filename length is near the PAGE_SIZE boundary. This
> > > > > triggers a page fault,
> > > > > which leads to a call to
> > > > > do_page_fault()->mmap_read_trylock(). If we can't
> > > > > acquire the lock, we have to fall back to the
> > > > > mmap_read_lock() path, which
> > > > > calls might_sleep(). This breaks RCU semantics because path
> > > > > lookup occurs
> > > > > under an RCU read-side critical section. In linux-mainline, arm/arm64
> > > > > do_page_fault() still has this problem:
> > > > > 
> > > > > lock_mm_and_find_vma->get_mmap_lock_carefully->mmap_read_lock_killable.
> > > > > 
> > > > > And before commit bfcfaa77bdf0 ("vfs: use 'unsigned long' accesses for
> > > > > dcache name comparison and hashing"), hash_name accessed the
> > > > > name byte by
> > > > > byte.
> > > > > 
> > > > > To prevent load_unaligned_zeropad() from accessing beyond
> > > > > the valid memory
> > > > > region, we would need to intercept such cases beforehand? But doing so
> > > > > would require replicating the internal logic of
> > > > > load_unaligned_zeropad(),
> > > > > including handling endianness and constructing the correct
> > > > > value manually.
> > > > > Given that load_unaligned_zeropad() is used in many places across the
> > > > > kernel, we currently haven't found a good solution to
> > > > > address this cleanly.
> > > > > 
> > > > > What would be the recommended way to handle this situation? Would
> > > > > appreciate any feedback and guidance from the community. Thanks!
> > > > 
> > > > Does it help if you bodge the translation fault handler along the lines
> > > > of the untested diff below?
> 
> I tried it out and it works — thank you for the solution you provided.

Thanks for giving it a spin.

> At the same time, since I’m a beginner in this area, I’d like to ask a
> question.
> 
> The comment above do_translation_fault() says:
> “We enter here because the first level page table doesn't contain a
> valid entry for the address.”
> 
> However, after modifying the code, it seems that when encountering
> FSR_FS_INVALID_PAGE, the kernel no longer creates a page table entry,
> but instead directly jumps to bad_area.

FSR_FS_INVALID_PAGE indicates a last level translation fault (that's the
"page" part) so it's only applicable in the case where the other levels
of page-table have been populated already.

I wondered about checking !is_vmalloc_addr() too, but I couldn't
convince myself that load_unaligned_zeropad() is only ever used with the
linear map.

> I'd like to ask — could this change potentially cause any other side
> effects?

There's always the possibility but I personally think it's more
self-contained than the other patches doing the rounds. For example, I
don't make any changes to the permission fault handling path.

Will

