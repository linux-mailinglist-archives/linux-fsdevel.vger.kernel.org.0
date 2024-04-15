Return-Path: <linux-fsdevel+bounces-16931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AD8A50FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E95F1F2157E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48C12A15A;
	Mon, 15 Apr 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImXb6uTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D01292D7;
	Mon, 15 Apr 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186284; cv=none; b=SRtRrM3M0jhxCINofRuSa36FoY1wSuvQPV+lZL8juCCBMfdh8zr4AWNkKW9Ef30ERN739F40rPkEOOi8DcIR15Fw3iknM5uggtqSEZK7JMw4s9wstrzdWjvqMN1wmDrXdejHH0s6TrzMwmeija0fLnMRPfFjpIqXMVSgq+rj+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186284; c=relaxed/simple;
	bh=tr9yQ+4cpsOL+xDqeA+9j3kwvie9ouEBUsT3s2BSqh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFwxrQ6RbIrV5Alb3GZc16jTT5SZvx2X9iCKGbgkAEO0CGT6icfbqYw7fp1pzC7jHYcs3v0NV3SFeQ3sgUw6xPLsVQIK3gRF31xGaw7+cgL1ufuypXcFaT94EEPNUJmCk3CHt+z5OO+IbRIL59M6y7kl6ZuGF5rmBnMRGZtEYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImXb6uTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F057C2BD10;
	Mon, 15 Apr 2024 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186283;
	bh=tr9yQ+4cpsOL+xDqeA+9j3kwvie9ouEBUsT3s2BSqh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImXb6uTdlDCasCuJVRBnQ/oQfhr22tFWdjclh8WLsJ51AFkxolDjzhT2GQlm/+p/N
	 9lm5WzGsVB83N7l70F+8UV4g5QyTtAaKByZJWzsn10NHjWUs1BQNZz8O02ZqR5Jz7X
	 11S1K2ml15QnwoaSdSOLTYvNBvTclOyqiO4t5U6YTE09luSAa3KTHP2MG6UdfVS1xq
	 2gcKyRUnrIe0DlP28Iaka2T22JJBMh7r4Dy154gOf3CnUwBwjMrc7RXqZdv6/ve/u3
	 NSrJwKZRbvGQvJXWd4UWknDa6x/n2J4tQn1LR3oRrmJAU17jqx4f3yq7sN6OoU5/6N
	 s2Wurhmc8fQHw==
Date: Mon, 15 Apr 2024 15:04:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>, 
	Nam Cao <namcao@linutronix.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley <conor@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240415-festland-unattraktiv-2b5953a6dbc9@brauner>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
 <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
 <20240414021555.GQ2118490@ZenIV>
 <887E261B-3C76-4CD9-867B-5D087051D004@dilger.ca>
 <87v84kujec.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v84kujec.fsf@all.your.base.are.belong.to.us>

On Sun, Apr 14, 2024 at 04:08:11PM +0200, Björn Töpel wrote:
> Andreas Dilger <adilger@dilger.ca> writes:
> 
> > On Apr 13, 2024, at 8:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> 
> >> On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
> >> 
> >>> As to whether the 0xfffff000 address itself is valid for riscv32 is
> >>> outside my realm, but given that RAM is cheap it doesn't seem unlikely
> >>> to have 4GB+ of RAM and want to use it all.  The riscv32 might consider
> >>> reserving this page address from allocation to avoid similar issues in
> >>> other parts of the code, as is done with the NULL/0 page address.
> >> 
> >> Not a chance.  *Any* page mapped there is a serious bug on any 32bit
> >> box.  Recall what ERR_PTR() is...
> >> 
> >> On any architecture the virtual addresses in range (unsigned long)-512..
> >> (unsigned long)-1 must never resolve to valid kernel objects.
> >> In other words, any kind of wraparound here is asking for an oops on
> >> attempts to access the elements of buffer - kernel dereference of
> >> (char *)0xfffff000 on a 32bit box is already a bug.
> >> 
> >> It might be getting an invalid pointer, but arithmetical overflows
> >> are irrelevant.
> >
> > The original bug report stated that search_buf = 0xfffff000 on entry,
> > and I'd quoted that at the start of my email:
> >
> > On Apr 12, 2024, at 8:57 AM, Björn Töpel <bjorn@kernel.org> wrote:
> >> What I see in ext4_search_dir() is that search_buf is 0xfffff000, and at
> >> some point the address wraps to zero, and boom. I doubt that 0xfffff000
> >> is a sane address.
> >
> > Now that you mention ERR_PTR() it definitely makes sense that this last
> > page HAS to be excluded.
> >
> > So some other bug is passing the bad pointer to this code before this
> > error, or the arch is not correctly excluding this page from allocation.
> 
> Yeah, something is off for sure.
> 
> (FWIW, I manage to hit this for Linus' master as well.)
> 
> I added a print (close to trace_mm_filemap_add_to_page_cache()), and for
> this BT:
> 
>   [<c01e8b34>] __filemap_add_folio+0x322/0x508
>   [<c01e8d6e>] filemap_add_folio+0x54/0xce
>   [<c01ea076>] __filemap_get_folio+0x156/0x2aa
>   [<c02df346>] __getblk_slow+0xcc/0x302
>   [<c02df5f2>] bdev_getblk+0x76/0x7a
>   [<c03519da>] ext4_getblk+0xbc/0x2c4
>   [<c0351cc2>] ext4_bread_batch+0x56/0x186
>   [<c036bcaa>] __ext4_find_entry+0x156/0x578
>   [<c036c152>] ext4_lookup+0x86/0x1f4
>   [<c02a3252>] __lookup_slow+0x8e/0x142
>   [<c02a6d70>] walk_component+0x104/0x174
>   [<c02a793c>] path_lookupat+0x78/0x182
>   [<c02a8c7c>] filename_lookup+0x96/0x158
>   [<c02a8d76>] kern_path+0x38/0x56
>   [<c0c1cb7a>] init_mount+0x5c/0xac
>   [<c0c2ba4c>] devtmpfs_mount+0x44/0x7a
>   [<c0c01cce>] prepare_namespace+0x226/0x27c
>   [<c0c011c6>] kernel_init_freeable+0x286/0x2a8
>   [<c0b97ab8>] kernel_init+0x2a/0x156
>   [<c0ba22ca>] ret_from_fork+0xe/0x20
> 
> I get a folio where folio_address(folio) == 0xfffff000 (which is
> broken).
> 
> Need to go into the weeds here...

I don't see anything obvious that could explain this right away. Did you
manage to reproduce this on any other architecture and/or filesystem?

Fwiw, iirc there were a bunch of fs/buffer.c changes that came in
through the mm/ layer between v6.7 and v6.8 that might also be
interesting. But really I'm poking in the dark currently.

