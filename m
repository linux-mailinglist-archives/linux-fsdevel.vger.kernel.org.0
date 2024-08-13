Return-Path: <linux-fsdevel+bounces-25829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD66950FD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 00:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E61F23267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 22:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509A1AAE2C;
	Tue, 13 Aug 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="MNEz2ETM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMj0NSfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BA16BE34
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588885; cv=none; b=e9xJXmUc1h970Yn23gG3riuYVwPQi9JTF+6lr2ryQ56J8RveaQ00qxtR+Xb8FF7asDiRqe7huJVeyeIY6fQWe6g9hmCHpUw+O7Ql3eS7hjJNiajZA+4bekQ3qCIRWlQFvjyFJSKwWVs7V1eo0eLhNvRg/5Ykp6ZKeBAxFScL/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588885; c=relaxed/simple;
	bh=MRuxhu0MYkAtvmu6/EY/jpQu5qQH8S7OphiwIIzknIg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iv6CqJ9KWRT71u2Mm7LfJNCtgAcylV+nY7qYDMiyV7fB6leU4CtE3BWxkPMrp8TojaY6T9mUWpd9k5xRjAAqnR8bH1Gflu+0yCxLa3wzSk4Y61iU2Rhukddg+ngAO2XzuBxTjkHKD4ivMfssziXME/xFB5pWMCu7s8dRZACxd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=MNEz2ETM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMj0NSfN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id E9F70138CDF7;
	Tue, 13 Aug 2024 18:41:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 18:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723588881;
	 x=1723675281; bh=8W/TyVhESKiBsUW7/EX000OibSzq1SyA4idAj8Zk9S8=; b=
	MNEz2ETMuyytkQcXrPgfckUJrYf2sP1QsWS6GpRmC9vPuD79w1N6MeFrQ3AYnLrI
	BNUmKLlSuHlf/Ryauiz0s1M46+6/OZli1jLR2x8/GcbKXqkJy2t4dxPbc7oDXvwx
	fO/ME3b6NgdYhJxdGORwM3vgH72xswlDeD+LEbgITkaKMIloHslDJwNPEhBDq3E+
	9DGYlH9A3b/TtLqTpBgZIBxycXcnvx8i2DTyg8IqL7nWfrMjBO5/D+ZFnxmZIcXe
	YmGgAERO8TZ3kv4cGx9te+ZBLYrH84lLUg6K74nLxOJI1PCoj9DbsbXK1YYWvmMr
	VQnmpQmdJmzDK9bLv8ty/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723588881; x=
	1723675281; bh=8W/TyVhESKiBsUW7/EX000OibSzq1SyA4idAj8Zk9S8=; b=q
	Mj0NSfNvgNRQltltByJE1cFM03ZOpHDBpmu1D3iZ4x93g6VluXUltG8yffgtlShF
	yjGLzfTzgegCB9LZ78dRMP6NGFXr2S5BkDfRTMJa5WRJLT8qTN3dhbxBK+n/ytzk
	6JyHHTVRia4/PVatQDtkOyORx1Xn3gwEn5iNgAYRlcIF9yhQVcTJLRCBxv21/hOm
	dvL6Sgj4O9NkNskcgOU+Z29JgZF4WxoxhyIPxHdglAlwF0qBO3qJf47+ieYsqQyx
	CE/vpa1Zn7v2OpiMuBRGzTdtlXLpnrYjZjzX6ncvJVoCTIUhGLRo78WhAlKcX+Z0
	MO16DJWd0HeHZMsCod91w==
X-ME-Sender: <xms:EeG7ZnjULgB4DxMoAVLsOalryRVb72IRuuUfx-DVDysUVldxNxGYBA>
    <xme:EeG7ZkBjal1zJAJd0ZvDVtjocCNp4m8n3Dn_PgnwVClusUvwpDmgnLihVoJ6V-YxK
    eR1_Ro5j3xOzUiu>
X-ME-Received: <xmr:EeG7ZnEa2FFDBZysg-OJ6zomNoB61mjlygTzhPZ1vTci8j9VK4MlH-0NAdrb6IIGF7h6hsdAKMnHBTWNBtcG3yyiw97EUg9OO5p084Bw3l_6B1DT7LnD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepffeugeeihfffteev
    heevveffjeehveekudegfedtfeegudevjedvhfefvdeitdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehoshgrnhguohhvsehosh
    grnhguohhvrdgtohhmpdhrtghpthhtohepshifvggvthhtvggrqdhkvghrnhgvlhesugho
    rhhmihhnhidrmhgvpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtoh
    hmpdhrtghpthhtohepughsihhnghhhseguughnrdgtohhm
X-ME-Proxy: <xmx:EeG7ZkQ01KNpwUOyykJZXoj48CD58onNMFG4oH6qFBCbQiWTy0ccwA>
    <xmx:EeG7ZkwdQ8unhCIIaJA6ZmJ_e4RnRCO7FqfkPKjjN-44sE_L_RRU0w>
    <xmx:EeG7Zq5d3EKJXV_IC6tbCrir-4KpsIzEtgtHcuNkvwyUeCxc60GqHA>
    <xmx:EeG7ZpzIAydxcXB8fZtTc9vyzJ7B3K-z45tI3wy2p6J6s3naKiGUiA>
    <xmx:EeG7ZjmB9gpkoMSWH7Ygcpp7G0RloT0NnhEstPN_ziZ0XrWD_ZzkEPf0>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 18:41:20 -0400 (EDT)
Date: Wed, 14 Aug 2024 00:41:15 +0200
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Joanne Koong <joannelkoong@gmail.com>
CC: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 osandov@osandov.com, sweettea-kernel@dorminy.me, kernel-team@meta.com,
 Dharmendra Singh <dsingh@ddn.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_fuse=3A_add_FOPEN=5FFETCH=5FATTR_?=
 =?US-ASCII?Q?flag_for_fetching_attributes_after_open?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
References: <20240813212149.1909627-1-joannelkoong@gmail.com> <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm> <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
Message-ID: <C23FB164-EB7A-436F-8C3F-533B00F67730@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 13, 2024 11:57:44 PM GMT+02:00, Joanne Koong <joannelkoong@gmail=
=2Ecom> wrote:
>On Tue, Aug 13, 2024 at 2:44=E2=80=AFPM Bernd Schubert
><bernd=2Eschubert@fastmail=2Efm> wrote:
>>
>> On 8/13/24 23:21, Joanne Koong wrote:
>> > Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
>> > fetched from the server after an open=2E
>> >
>> > For fuse servers that are backed by network filesystems, this is
>> > needed to ensure that file attributes are up to date between
>> > consecutive open calls=2E
>> >
>> > For example, if there is a file that is opened on two fuse mounts,
>> > in the following scenario:
>> >
>> > on mount A, open file=2Etxt w/ O_APPEND, write "hi", close file
>> > on mount B, open file=2Etxt w/ O_APPEND, write "world", close file
>> > on mount A, open file=2Etxt w/ O_APPEND, write "123", close file
>> >
>> > when the file is reopened on mount A, the file inode contains the old
>> > size and the last append will overwrite the data that was written whe=
n
>> > the file was opened/written on mount B=2E
>> >
>> > (This corruption can be reproduced on the example libfuse passthrough=
_hp
>> > server with writeback caching disabled and nopassthrough)
>> >
>> > Having this flag as an option enables parity with NFS's close-to-open
>> > consistency=2E
>> >
>> > Signed-off-by: Joanne Koong <joannelkoong@gmail=2Ecom>
>> > ---
>> >  fs/fuse/file=2Ec            | 7 ++++++-
>> >  include/uapi/linux/fuse=2Eh | 7 ++++++-
>> >  2 files changed, 12 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/fs/fuse/file=2Ec b/fs/fuse/file=2Ec
>> > index f39456c65ed7=2E=2E437487ce413d 100644
>> > --- a/fs/fuse/file=2Ec
>> > +++ b/fs/fuse/file=2Ec
>> > @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct=
 file *file)
>> >       err =3D fuse_do_open(fm, get_node_id(inode), file, false);
>> >       if (!err) {
>> >               ff =3D file->private_data;
>> > -             err =3D fuse_finish_open(inode, file);
>> > +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
>> > +                     fuse_invalidate_attr(inode);
>> > +                     err =3D fuse_update_attributes(inode, file, STA=
TX_BASIC_STATS);
>> > +             }
>> > +             if (!err)
>> > +                     err =3D fuse_finish_open(inode, file);
>> >               if (err)
>> >                       fuse_sync_release(fi, ff, file->f_flags);
>> >               else if (is_truncate)
>>
>> I didn't come to it yet, but I actually wanted to update Dharmendras/my
>> atomic open patches - giving up all the vfs changes (for now) and then
>> always use atomic open if available, for FUSE_OPEN and FUSE_CREATE=2E A=
nd
>> then update attributes through that=2E
>> Would that be an alternative for you? Would basically require to add an
>> atomic_open method into your file system=2E
>>
>> Definitely more complex than your solution, but avoids a another
>> kernel/userspace transition=2E
>
>Hi Bernd,
>
>Unfortunately I don't think this is an alternative for my use case=2E I
>haven't looked closely at the implementation details of your atomic
>open patchset yet but if I'm understanding the gist of it correctly,
>it bundles the lookup with the open into 1 request, where the
>attributes can be passed from server -> kernel through the reply to
>that request=2E I think in the case I'm working on, the file open call
>does not require a lookup so it can't take advantage of your feature=2E
>I just tested it on libfuse on the passthrough_hp server (with no
>writeback caching and nopassthrough) on the example in the commit
>message and I'm not seeing any lookup request being sent for that last
>open call (for writing "123")=2E
>


Hi Joanne,

gets late here and I'm typing on my phone=2E  I hope formatting is ok=2E

what I meant is that we use the atomic open op code for both, lookup-open =
and plain open - i=2Ee=2E we always update attributes on open=2E Past atomi=
c open patches did not do that yet, but I later realized that always using =
atomic open op=20

- avoids the data corruption you run into
- probably no need for atomic-revalidate-open vfs patches anymore  as we c=
an now safely set a high attr timeout


Kind of the same as your patch, just through a new op code=2E

Thanks,=20
Bernd


