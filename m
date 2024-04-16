Return-Path: <linux-fsdevel+bounces-17025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2141A8A6611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 10:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE29328611C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BCF156652;
	Tue, 16 Apr 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKHWYhR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF393B78D;
	Tue, 16 Apr 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255966; cv=none; b=AgkhBHO6IKtr5SP7nKddLXqBI3HX7TDv7wElh8eVYzYrMo5gfZlGwiVOELih2ZHxBjax2wXWJgLAGvG7I+6+87Z8C22lALA6kYEdC1QRP4c0BzR1VWWNEqvrcqDCEEvXtYQqWr17+e83cwejmEwz3JsFJdoU1/nWY/7kyqfsXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255966; c=relaxed/simple;
	bh=dU7PkEFRm93LBS1Z28p9N1XSH6G5tnTgOH3s9Y4nZt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uXzfKjBalvINkwB0RIsdxA/Exytxc5/UPmmPYtpIiaxLJvvaO6yM6vZUUxv17t+hgE9i8nymoR2eWMOuKVrznKB0Zt6SkJYoKK2m3DywRbY5xpFQ9UFklm7SLCfX2SuY3XtjeZGGqJSRcCd9XmXa3f3heYQMhbQjbnsAQdMhVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKHWYhR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3887C113CE;
	Tue, 16 Apr 2024 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713255965;
	bh=dU7PkEFRm93LBS1Z28p9N1XSH6G5tnTgOH3s9Y4nZt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WKHWYhR5mbbNVzGbhCPf7kl3oB3jDL3oHMn4Q3PKGa5PZXdSv3F82AMPzTnllqrB4
	 eZBDrqWP3HqjL+d8FxqNuISmb9y7y4WCaIE1AKWLLrnaaF0NASBwhgLGvWRYLecpTO
	 ttEfbAtfQ8AJvE0g7ukarqYG4cu6ptpkcv9VPL9XAGDJtrUvUjgz3YtAF7LDMUgrDa
	 s/zksYEOphxkiemLTBFR2/kTS9c5z3U4A2SCiAAxhWpDiRw6Bwmz98kZLETHOr9Bg7
	 eyAiL1mqWCvwl0QT9oRiiwzTJzltC9q8nqukrrPuz9rMas7Qhl8FYpTAxdzmV9SdoI
	 9XFSIr6NmMG1Q==
Date: Tue, 16 Apr 2024 10:25:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Nam Cao <namcao@linutronix.de>, Mike Rapoport <rppt@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley <conor@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le5e393x.fsf@all.your.base.are.belong.to.us>
 <20240416084417.569356d3@namcao>

[Adding Mike who's knowledgeable in this area]

On Mon, Apr 15, 2024 at 06:04:50PM +0200, Björn Töpel wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Sun, Apr 14, 2024 at 04:08:11PM +0200, Björn Töpel wrote:
> >> Andreas Dilger <adilger@dilger.ca> writes:
> >> 
> >> > On Apr 13, 2024, at 8:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> >> 
> >> >> On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
> >> >> 
> >> >>> As to whether the 0xfffff000 address itself is valid for riscv32 is
> >> >>> outside my realm, but given that RAM is cheap it doesn't seem unlikely
> >> >>> to have 4GB+ of RAM and want to use it all.  The riscv32 might consider
> >> >>> reserving this page address from allocation to avoid similar issues in
> >> >>> other parts of the code, as is done with the NULL/0 page address.
> >> >> 
> >> >> Not a chance.  *Any* page mapped there is a serious bug on any 32bit
> >> >> box.  Recall what ERR_PTR() is...
> >> >> 
> >> >> On any architecture the virtual addresses in range (unsigned long)-512..
> >> >> (unsigned long)-1 must never resolve to valid kernel objects.
> >> >> In other words, any kind of wraparound here is asking for an oops on
> >> >> attempts to access the elements of buffer - kernel dereference of
> >> >> (char *)0xfffff000 on a 32bit box is already a bug.
> >> >> 
> >> >> It might be getting an invalid pointer, but arithmetical overflows
> >> >> are irrelevant.
> >> >
> >> > The original bug report stated that search_buf = 0xfffff000 on entry,
> >> > and I'd quoted that at the start of my email:
> >> >
> >> > On Apr 12, 2024, at 8:57 AM, Björn Töpel <bjorn@kernel.org> wrote:
> >> >> What I see in ext4_search_dir() is that search_buf is 0xfffff000, and at
> >> >> some point the address wraps to zero, and boom. I doubt that 0xfffff000
> >> >> is a sane address.
> >> >
> >> > Now that you mention ERR_PTR() it definitely makes sense that this last
> >> > page HAS to be excluded.
> >> >
> >> > So some other bug is passing the bad pointer to this code before this
> >> > error, or the arch is not correctly excluding this page from allocation.
> >> 
> >> Yeah, something is off for sure.
> >> 
> >> (FWIW, I manage to hit this for Linus' master as well.)
> >> 
> >> I added a print (close to trace_mm_filemap_add_to_page_cache()), and for
> >> this BT:
> >> 
> >>   [<c01e8b34>] __filemap_add_folio+0x322/0x508
> >>   [<c01e8d6e>] filemap_add_folio+0x54/0xce
> >>   [<c01ea076>] __filemap_get_folio+0x156/0x2aa
> >>   [<c02df346>] __getblk_slow+0xcc/0x302
> >>   [<c02df5f2>] bdev_getblk+0x76/0x7a
> >>   [<c03519da>] ext4_getblk+0xbc/0x2c4
> >>   [<c0351cc2>] ext4_bread_batch+0x56/0x186
> >>   [<c036bcaa>] __ext4_find_entry+0x156/0x578
> >>   [<c036c152>] ext4_lookup+0x86/0x1f4
> >>   [<c02a3252>] __lookup_slow+0x8e/0x142
> >>   [<c02a6d70>] walk_component+0x104/0x174
> >>   [<c02a793c>] path_lookupat+0x78/0x182
> >>   [<c02a8c7c>] filename_lookup+0x96/0x158
> >>   [<c02a8d76>] kern_path+0x38/0x56
> >>   [<c0c1cb7a>] init_mount+0x5c/0xac
> >>   [<c0c2ba4c>] devtmpfs_mount+0x44/0x7a
> >>   [<c0c01cce>] prepare_namespace+0x226/0x27c
> >>   [<c0c011c6>] kernel_init_freeable+0x286/0x2a8
> >>   [<c0b97ab8>] kernel_init+0x2a/0x156
> >>   [<c0ba22ca>] ret_from_fork+0xe/0x20
> >> 
> >> I get a folio where folio_address(folio) == 0xfffff000 (which is
> >> broken).
> >> 
> >> Need to go into the weeds here...
> >
> > I don't see anything obvious that could explain this right away. Did you
> > manage to reproduce this on any other architecture and/or filesystem?
> >
> > Fwiw, iirc there were a bunch of fs/buffer.c changes that came in
> > through the mm/ layer between v6.7 and v6.8 that might also be
> > interesting. But really I'm poking in the dark currently.
> 
> Thanks for getting back! Spent some more time one it today.
> 
> It seems that the buddy allocator *can* return a page with a VA that can
> wrap (0xfffff000 -- pointed out by Nam and myself).
> 
> Further, it seems like riscv32 indeed inserts a page like that to the
> buddy allocator, when the memblock is free'd:
> 
>   | [<c024961c>] __free_one_page+0x2a4/0x3ea
>   | [<c024a448>] __free_pages_ok+0x158/0x3cc
>   | [<c024b1a4>] __free_pages_core+0xe8/0x12c
>   | [<c0c1435a>] memblock_free_pages+0x1a/0x22
>   | [<c0c17676>] memblock_free_all+0x1ee/0x278
>   | [<c0c050b0>] mem_init+0x10/0xa4
>   | [<c0c1447c>] mm_core_init+0x11a/0x2da
>   | [<c0c00bb6>] start_kernel+0x3c4/0x6de
> 
> Here, a page with VA 0xfffff000 is a added to the freelist. We were just
> lucky (unlucky?) that page was used for the page cache.
> 
> A nasty patch like:
> --8<--
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 549e76af8f82..a6a6abbe71b0 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2566,6 +2566,9 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
>  void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  							unsigned int order)
>  {
> +	if ((long)page_address(page) == 0xfffff000L) {
> +		return; // leak it
> +	}
>  
>  	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
>  		int nid = early_pfn_to_nid(pfn);
> --8<--
> 
> ...and it's gone.
> 
> I need to think more about what a proper fix is. Regardless; Christian,
> Al, and Ted can all relax. ;-)
> 
> 
> Björn

On Tue, Apr 16, 2024 at 08:44:17AM +0200, Nam Cao wrote:
> On 2024-04-15 Björn Töpel wrote:
> > Thanks for getting back! Spent some more time one it today.
> > 
> > It seems that the buddy allocator *can* return a page with a VA that can
> > wrap (0xfffff000 -- pointed out by Nam and myself).
> > 
> > Further, it seems like riscv32 indeed inserts a page like that to the
> > buddy allocator, when the memblock is free'd:
> > 
> >   | [<c024961c>] __free_one_page+0x2a4/0x3ea
> >   | [<c024a448>] __free_pages_ok+0x158/0x3cc
> >   | [<c024b1a4>] __free_pages_core+0xe8/0x12c
> >   | [<c0c1435a>] memblock_free_pages+0x1a/0x22
> >   | [<c0c17676>] memblock_free_all+0x1ee/0x278
> >   | [<c0c050b0>] mem_init+0x10/0xa4
> >   | [<c0c1447c>] mm_core_init+0x11a/0x2da
> >   | [<c0c00bb6>] start_kernel+0x3c4/0x6de
> > 
> > Here, a page with VA 0xfffff000 is a added to the freelist. We were just
> > lucky (unlucky?) that page was used for the page cache.
> 
> I just educated myself about memory mapping last night, so the below
> may be complete nonsense. Take it with a grain of salt.
> 
> In riscv's setup_bootmem(), we have this line:
> 	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
> 
> I think this is the root cause: max_low_pfn indicates the last page
> to be mapped. Problem is: nothing prevents PFN_DOWN(phys_ram_end) from
> getting mapped to the last page (0xfffff000). If max_low_pfn is mapped
> to the last page, we get the reported problem.
> 
> There seems to be some code to make sure the last page is not used
> (the call to memblock_set_current_limit() right above this line). It is
> unclear to me why this still lets the problem slip through.
> 
> The fix is simple: never let max_low_pfn gets mapped to the last page.
> The below patch fixes the problem for me. But I am not entirely sure if
> this is the correct fix, further investigation needed.
> 
> Best regards,
> Nam
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..17cab0a52726 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -251,7 +251,8 @@ static void __init setup_bootmem(void)
>  	}
>  
>  	min_low_pfn = PFN_UP(phys_ram_base);
> -	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
> +	max_low_pfn = PFN_DOWN(memblock_get_current_limit());
> +	max_pfn = PFN_DOWN(phys_ram_end);
>  	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
>  
>  	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));

