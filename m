Return-Path: <linux-fsdevel+bounces-16958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D48A5704
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96ACB224F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00A7FBBE;
	Mon, 15 Apr 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDD9FIlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285478C88;
	Mon, 15 Apr 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197094; cv=none; b=jwYqpZxchoolH8PXD8ilCw9LXF2FCf/q/R+nh7RRFXfv3sC+/VWKDSlW8U4kjaxN77UiLyZpvCPE+19cdCs8aO5bJO9Pryb93KtXSBG7vTk31myW5YpKkIduuV8OFMnCBh41MvxXW/ON6Y5Sf5HEnNIoBLvYfw90UER3+lWMrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197094; c=relaxed/simple;
	bh=vFMJFGnJyanRDxAtVKIrLAB0ePFQhQ+GU0wvYeD6asg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P+rmSpMm5uF0xf8M5YWnl5Koe5mP7zLYZoYPUeP3X+N7BjvYN1G9xQjIe6s8YRBQ/FftE1ecrDt6rubMDNBr8qKfzzfe7SE5HKdWSc0NjAegXca3f3iG91hp6x6fGCwf5nvON9rUfetIsdplNIuwgoSkL32hUxXREn8I9y8ORJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDD9FIlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBE1C113CC;
	Mon, 15 Apr 2024 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197094;
	bh=vFMJFGnJyanRDxAtVKIrLAB0ePFQhQ+GU0wvYeD6asg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UDD9FIlLCszfXS3i6dFnz0lKTpcFcfRbhntScaXy5d8gUHRFxwjLQKQaZfNwW2Ryh
	 7nRQd01d/K8fA8QLWuhYIw7RomrBeK7/cl3xRKTz859GMQynZORYQCqiO75PMqkdRf
	 +BUTAh6yr/W/nmyKW9FwVXMQZdPmytnIP1dup0cjPAjff97Tbvon/QKh1vsF+nMtzB
	 ObuR8kiYpMWR1zegA/rSJZN3pZbbndudpyNlwyYZ66r11OncXDF2bF2KoIjP2+aI73
	 LIjIcUHWh+XmybbioeXlZgeGhS+U01be1Eu0rrhDk3YdVgzMEpKB2Wa6V2P4LD2Va8
	 5N+mVpwTelLeg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>,
 Nam Cao <namcao@linutronix.de>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
In-Reply-To: <20240415-festland-unattraktiv-2b5953a6dbc9@brauner>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
 <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
 <20240414021555.GQ2118490@ZenIV>
 <887E261B-3C76-4CD9-867B-5D087051D004@dilger.ca>
 <87v84kujec.fsf@all.your.base.are.belong.to.us>
 <20240415-festland-unattraktiv-2b5953a6dbc9@brauner>
Date: Mon, 15 Apr 2024 18:04:50 +0200
Message-ID: <87le5e393x.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:

> On Sun, Apr 14, 2024 at 04:08:11PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Andreas Dilger <adilger@dilger.ca> writes:
>>=20
>> > On Apr 13, 2024, at 8:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> >>=20
>> >> On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
>> >>=20
>> >>> As to whether the 0xfffff000 address itself is valid for riscv32 is
>> >>> outside my realm, but given that RAM is cheap it doesn't seem unlike=
ly
>> >>> to have 4GB+ of RAM and want to use it all.  The riscv32 might consi=
der
>> >>> reserving this page address from allocation to avoid similar issues =
in
>> >>> other parts of the code, as is done with the NULL/0 page address.
>> >>=20
>> >> Not a chance.  *Any* page mapped there is a serious bug on any 32bit
>> >> box.  Recall what ERR_PTR() is...
>> >>=20
>> >> On any architecture the virtual addresses in range (unsigned long)-51=
2..
>> >> (unsigned long)-1 must never resolve to valid kernel objects.
>> >> In other words, any kind of wraparound here is asking for an oops on
>> >> attempts to access the elements of buffer - kernel dereference of
>> >> (char *)0xfffff000 on a 32bit box is already a bug.
>> >>=20
>> >> It might be getting an invalid pointer, but arithmetical overflows
>> >> are irrelevant.
>> >
>> > The original bug report stated that search_buf =3D 0xfffff000 on entry,
>> > and I'd quoted that at the start of my email:
>> >
>> > On Apr 12, 2024, at 8:57 AM, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =
wrote:
>> >> What I see in ext4_search_dir() is that search_buf is 0xfffff000, and=
 at
>> >> some point the address wraps to zero, and boom. I doubt that 0xfffff0=
00
>> >> is a sane address.
>> >
>> > Now that you mention ERR_PTR() it definitely makes sense that this last
>> > page HAS to be excluded.
>> >
>> > So some other bug is passing the bad pointer to this code before this
>> > error, or the arch is not correctly excluding this page from allocatio=
n.
>>=20
>> Yeah, something is off for sure.
>>=20
>> (FWIW, I manage to hit this for Linus' master as well.)
>>=20
>> I added a print (close to trace_mm_filemap_add_to_page_cache()), and for
>> this BT:
>>=20
>>   [<c01e8b34>] __filemap_add_folio+0x322/0x508
>>   [<c01e8d6e>] filemap_add_folio+0x54/0xce
>>   [<c01ea076>] __filemap_get_folio+0x156/0x2aa
>>   [<c02df346>] __getblk_slow+0xcc/0x302
>>   [<c02df5f2>] bdev_getblk+0x76/0x7a
>>   [<c03519da>] ext4_getblk+0xbc/0x2c4
>>   [<c0351cc2>] ext4_bread_batch+0x56/0x186
>>   [<c036bcaa>] __ext4_find_entry+0x156/0x578
>>   [<c036c152>] ext4_lookup+0x86/0x1f4
>>   [<c02a3252>] __lookup_slow+0x8e/0x142
>>   [<c02a6d70>] walk_component+0x104/0x174
>>   [<c02a793c>] path_lookupat+0x78/0x182
>>   [<c02a8c7c>] filename_lookup+0x96/0x158
>>   [<c02a8d76>] kern_path+0x38/0x56
>>   [<c0c1cb7a>] init_mount+0x5c/0xac
>>   [<c0c2ba4c>] devtmpfs_mount+0x44/0x7a
>>   [<c0c01cce>] prepare_namespace+0x226/0x27c
>>   [<c0c011c6>] kernel_init_freeable+0x286/0x2a8
>>   [<c0b97ab8>] kernel_init+0x2a/0x156
>>   [<c0ba22ca>] ret_from_fork+0xe/0x20
>>=20
>> I get a folio where folio_address(folio) =3D=3D 0xfffff000 (which is
>> broken).
>>=20
>> Need to go into the weeds here...
>
> I don't see anything obvious that could explain this right away. Did you
> manage to reproduce this on any other architecture and/or filesystem?
>
> Fwiw, iirc there were a bunch of fs/buffer.c changes that came in
> through the mm/ layer between v6.7 and v6.8 that might also be
> interesting. But really I'm poking in the dark currently.

Thanks for getting back! Spent some more time one it today.

It seems that the buddy allocator *can* return a page with a VA that can
wrap (0xfffff000 -- pointed out by Nam and myself).

Further, it seems like riscv32 indeed inserts a page like that to the
buddy allocator, when the memblock is free'd:

  | [<c024961c>] __free_one_page+0x2a4/0x3ea
  | [<c024a448>] __free_pages_ok+0x158/0x3cc
  | [<c024b1a4>] __free_pages_core+0xe8/0x12c
  | [<c0c1435a>] memblock_free_pages+0x1a/0x22
  | [<c0c17676>] memblock_free_all+0x1ee/0x278
  | [<c0c050b0>] mem_init+0x10/0xa4
  | [<c0c1447c>] mm_core_init+0x11a/0x2da
  | [<c0c00bb6>] start_kernel+0x3c4/0x6de

Here, a page with VA 0xfffff000 is a added to the freelist. We were just
lucky (unlucky?) that page was used for the page cache.

A nasty patch like:
--8<--
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82..a6a6abbe71b0 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2566,6 +2566,9 @@ void __init set_dma_reserve(unsigned long new_dma_res=
erve)
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
+	if ((long)page_address(page) =3D=3D 0xfffff000L) {
+		return; // leak it
+	}
=20
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid =3D early_pfn_to_nid(pfn);
--8<--

...and it's gone.

I need to think more about what a proper fix is. Regardless; Christian,
Al, and Ted can all relax. ;-)


Bj=C3=B6rn

