Return-Path: <linux-fsdevel+bounces-16887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289BF8A42D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5141C20E78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E205473A;
	Sun, 14 Apr 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKtfqaGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682469946;
	Sun, 14 Apr 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103696; cv=none; b=Ed3ZYn8eCHisgZPO/F+4AQc6siuXyZz52YUhmmZ3nO5LIW1G/sBOBQOZknTpixc5ZNdxBW5wm3mnxPjXP5THyL0rtvIcuhoCPDTlz0wrltqrSyf0moXvvzUCh6CqPBoSc7+3SwZywl5S33QAQK2ssnpdxpuyn4fO5YA3pD1qzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103696; c=relaxed/simple;
	bh=nJphaxyGk5suB7H36OjqlLYhSoBdMx7ElHPwRl517d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=baWpR7lgWrR5OFFBG90TiiS/o0YRK0oLOdzES6obopDUNIOgwKwVgmUfL1OH1TUF2IKevFTI4UGTvnckmq8GeNcIDSV6nkttvQyGuHMWyYMb+dHUSn6qkLI1AXaSINjg/9ySQrShvZZZoDTSbU2eb44uhCw0lmYkSyrVK5od08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKtfqaGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7932C2BD11;
	Sun, 14 Apr 2024 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103695;
	bh=nJphaxyGk5suB7H36OjqlLYhSoBdMx7ElHPwRl517d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KKtfqaGXNf6ctHlU9UkBITIAtIiMUXT6NFIiTGdm3+tyNS5BojD78UO4E3Bs+JzRk
	 hUS6xHiWSaYJRGhHykfOeuGRQf8Ng4wSSrKTPIQ1KP4E1DAy3dnD/NHTGo1/dtM2Ev
	 Q9VeGbig0+8dF17EoYKo2eg8Jjq3OyD2gLyAOXNR8pusfRt3tJhtHa4tZDJqYV4DAy
	 Oc+2UvT+7j7NVGyyRAHUVoIgDp3DqoN2Cgq5JsBrYMTyfsjTCc2J6M7J5/gqRVagc9
	 MJar/oNL/+BYrBvsVgS/30FQi6r1T7ghGUy466yxWtmcrYKDBUb9cWtrLJPNKdyo+G
	 JkfZw2ubteobw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Nam Cao <namcao@linutronix.de>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, Theodore
 Ts'o <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Conor Dooley <conor@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
In-Reply-To: <887E261B-3C76-4CD9-867B-5D087051D004@dilger.ca>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
 <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
 <20240414021555.GQ2118490@ZenIV>
 <887E261B-3C76-4CD9-867B-5D087051D004@dilger.ca>
Date: Sun, 14 Apr 2024 16:08:11 +0200
Message-ID: <87v84kujec.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Dilger <adilger@dilger.ca> writes:

> On Apr 13, 2024, at 8:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>=20
>> On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
>>=20
>>> As to whether the 0xfffff000 address itself is valid for riscv32 is
>>> outside my realm, but given that RAM is cheap it doesn't seem unlikely
>>> to have 4GB+ of RAM and want to use it all.  The riscv32 might consider
>>> reserving this page address from allocation to avoid similar issues in
>>> other parts of the code, as is done with the NULL/0 page address.
>>=20
>> Not a chance.  *Any* page mapped there is a serious bug on any 32bit
>> box.  Recall what ERR_PTR() is...
>>=20
>> On any architecture the virtual addresses in range (unsigned long)-512..
>> (unsigned long)-1 must never resolve to valid kernel objects.
>> In other words, any kind of wraparound here is asking for an oops on
>> attempts to access the elements of buffer - kernel dereference of
>> (char *)0xfffff000 on a 32bit box is already a bug.
>>=20
>> It might be getting an invalid pointer, but arithmetical overflows
>> are irrelevant.
>
> The original bug report stated that search_buf =3D 0xfffff000 on entry,
> and I'd quoted that at the start of my email:
>
> On Apr 12, 2024, at 8:57 AM, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>> What I see in ext4_search_dir() is that search_buf is 0xfffff000, and at
>> some point the address wraps to zero, and boom. I doubt that 0xfffff000
>> is a sane address.
>
> Now that you mention ERR_PTR() it definitely makes sense that this last
> page HAS to be excluded.
>
> So some other bug is passing the bad pointer to this code before this
> error, or the arch is not correctly excluding this page from allocation.

Yeah, something is off for sure.

(FWIW, I manage to hit this for Linus' master as well.)

I added a print (close to trace_mm_filemap_add_to_page_cache()), and for
this BT:

  [<c01e8b34>] __filemap_add_folio+0x322/0x508
  [<c01e8d6e>] filemap_add_folio+0x54/0xce
  [<c01ea076>] __filemap_get_folio+0x156/0x2aa
  [<c02df346>] __getblk_slow+0xcc/0x302
  [<c02df5f2>] bdev_getblk+0x76/0x7a
  [<c03519da>] ext4_getblk+0xbc/0x2c4
  [<c0351cc2>] ext4_bread_batch+0x56/0x186
  [<c036bcaa>] __ext4_find_entry+0x156/0x578
  [<c036c152>] ext4_lookup+0x86/0x1f4
  [<c02a3252>] __lookup_slow+0x8e/0x142
  [<c02a6d70>] walk_component+0x104/0x174
  [<c02a793c>] path_lookupat+0x78/0x182
  [<c02a8c7c>] filename_lookup+0x96/0x158
  [<c02a8d76>] kern_path+0x38/0x56
  [<c0c1cb7a>] init_mount+0x5c/0xac
  [<c0c2ba4c>] devtmpfs_mount+0x44/0x7a
  [<c0c01cce>] prepare_namespace+0x226/0x27c
  [<c0c011c6>] kernel_init_freeable+0x286/0x2a8
  [<c0b97ab8>] kernel_init+0x2a/0x156
  [<c0ba22ca>] ret_from_fork+0xe/0x20

I get a folio where folio_address(folio) =3D=3D 0xfffff000 (which is
broken).

Need to go into the weeds here...


Bj=C3=B6rn

