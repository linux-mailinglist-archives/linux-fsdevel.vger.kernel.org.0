Return-Path: <linux-fsdevel+bounces-62058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F361B8289A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093796221CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDDF235345;
	Thu, 18 Sep 2025 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PPU3KPeO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIdHwxsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376810957
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159795; cv=none; b=CEEMCdJaLImipJpLiuNfDMw55gd5uEdz1UkfNQ8hM4EeOrPdPESuwARbaF5YTHxuKQbuQ6duV3xgk3qqVXkenStbEYX2lXTlJCaNxFLv3Sk7iSx7jXeZunngyNesbH7bb78DlzM2wbxzEBKr9CkpDITOujL1YNL8zqGIYYbkang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159795; c=relaxed/simple;
	bh=PeddWXVgWo4eHRyRfZpilj0f33qSKh6lYj0n7ERqV5g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Vwn8pFmBlBF+fULSUQfImloi6OfW7UICLWlBEvQSkz2NzJV55HmLY+grw9KDjEOUb/ob578P05mxlYncLd5E+yOHVPmPXP0plfNuYyNDdlv9fag9Yo2RMidaCzMeeuBFqggEaO5TnUlB4EHDeJz/P/X78vZQtytTb8U4N+p2U1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PPU3KPeO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIdHwxsI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A18951D0008A;
	Wed, 17 Sep 2025 21:43:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 17 Sep 2025 21:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758159790; x=1758246190; bh=zC5xF1JlZ9IheLsiTAfLPUNUfhlAAhpQeN8
	HuNCHLyU=; b=PPU3KPeOSvlBoFtEnBCbz86UVrgSH8KeZyW/8P9Lh98qObWrp2o
	reEqz+PIHsYRVgAfT8lfp7CLb0sooQ6z6KeVgklprhPtd2hFPDdDrCWXNZw7Nmnn
	Y4PqA8wfGd67UKlUvCjN8vdEw2SUoR/E/ax6bRrtdIIv2YSKmVstwBZSHegQvXe6
	oxJXGo8B4aAqI+vHj2Gf8M4m0b73Y4FxoCgaJTPByuw5/OHHo3ud12Sp4nMJh/WC
	nvJamBJqF1lzJaUjQOHSELeeh1gm9YA1nRm2DLL8giMFOPHDeI0MC2frgfEocIik
	2qHlXrwe8cfGtxgqVt3i+urjr00Ple/rMnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758159790; x=
	1758246190; bh=zC5xF1JlZ9IheLsiTAfLPUNUfhlAAhpQeN8HuNCHLyU=; b=V
	IdHwxsIZ9wQzIEFtse6GI7izvc/Amz+JVvMo8RZccHff47tCisKSCe0hjzCynqJA
	3o1SiqcfEnnhjUrhd3ZTMJeXXmyzYRFqeX+7mo2Nrb8iBVuokwpr0JSqEQgslhvK
	bfGSa+jkehKZ9t/4HbpJEgGMIt6twpgQudRdL+/ZXNmuqwWg/YHEJZ8QAHYLa88u
	sp1Ft/S0b7blrIFHN0vsg9mBqF0+LytYUdg9rRN/Sp2ub32Uvpm3xidOFoAdLjyS
	g03RvW+POyjmcm6Pc3KbcewUzg+WkrhXlU7l5Auz8582D8EZIroHqh4/xy5gIsUq
	NvEy7NZBeky06RyMtZ2OQ==
X-ME-Sender: <xms:rmPLaOTuN5JX6aeJzgux16I3W90RYCxw9nh1E9FxtKM3z3IcONrdIA>
    <xme:rmPLaOqYdOKDq4dp3aliyDiFtC7fO7DHCYnxT57-qDdvAUfOITfKqqbhHodymZPL4
    kl0DqrIxnSYcw>
X-ME-Received: <xmr:rmPLaDoY7nOiZkBdz7H8QImd38u7karaIHALDfjLdU5kiRainXtmpRyfZ8WtxZTLIwaYzaD--Hcoz_vC2I7UDqmDU8G8BTfRePGC9y4uK84q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeghedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:rmPLaIN6hlUwMtsu6ghuiWJVA4xmJnb8hegJ4QkByCchoxC2nKGASA>
    <xmx:rmPLaMzpN6D4Pkl840FifVfmEbSGBzFEi8xpDCB7lF8Pa4x5G6KxKg>
    <xmx:rmPLaJsJLZE-cotfTTfXwr76Mjbk4NMLJ3M0MMhufFe6Ey_1o5sSSg>
    <xmx:rmPLaN6mSNqjB5mmh8z9VBKpmK4a-IcxIHbDHQ3K9gzjgpFW1QaR_w>
    <xmx:rmPLaOx5IUS0BjMHyNtHbpXQJlSqRmLUPN74eztvaeqpL_PC0WONHJCp>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 21:43:08 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Miklos Szeredi" <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
In-reply-to: <20250917153031.371581-1-mszeredi@redhat.com>
References: <20250917153031.371581-1-mszeredi@redhat.com>
Date: Thu, 18 Sep 2025 11:43:01 +1000
Message-id: <175815978155.1696783.12570522054558037073@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 18 Sep 2025, Miklos Szeredi wrote:
> If a path component is revalidated while taking part in a
> rename(RENAME_EXCHANGE) request, userspace might find the already exchanged
> files, while the kernel still has the old ones in dcache.  This mismatch
> will cause the dentry to be invalidated (unhashed), resulting in
> "(deleted)" being appended to proc paths.

An inappropriate d_invalidate() on a positive dentry can do worse than
just adding "(deleted)" to paths in proc.
Any mount points at or below the target of d_invalidate() are unmounted.
So I think it is really important to avoid invalidating a positive
dentry if at all possible.

If I understand the race correctly, the problem happens if an unlocked
d_revalidate() returns zero so d_invalidate() is called immediately
*after* d_exchange() has succeeded.  If it is called before, d_exchange()
will rehash the dentry.

Could the same thing happen on rename without RENAME_EXCHANGE?
The unlocked d_revalidate() finds that the name has already been removed
so it requests d_invalidate() which runs immediately *after* d_move()
has succeeded?

I think the race should be addressed in VFS code as it could affect any
filesystem which provides ->d_revalidate. I'm not sure how.

Maybe we could make use of LOOKUP_REVAL retries and mandate that if
LOOKUP_REVAL is set then ->d_revalidate is always called with an
exclusive lock.  We would still need some way for d_invalidate() it
decide whether to trigger the retry by causing -ESTALE to be returned.
Maybe try-lock on s_vfs_rename_mutex could be used.

Or maybe we could sample d_seq before calling ->d_revalidate() and only
allow d_invalidate() to succeed if d_seq is unchanged.  If it changed,
we repeat .... something.  Maybe the revalidate, maybe the lookup, maybe
the whole path ??

Thanks,
NeilBrown

>=20
> Prevent this by taking the inode lock shared for the dentry being
> revalidated.
>=20
> Another race introduced by commit 5be1fa8abd7b ("Pass parent directory
> inode and expected name to ->d_revalidate()") is that the name passed to
> revalidate can be stale (rename succeeded after the dentry was looked up in
> the dcache).
>=20
> By checking the name and the parent while the inode is locked, this issue
> can also be solved.
>=20
> This doesn't deal with revalidate/d_splice_alias() races, which happens if
> a directory (which is cached) is moved on the server and the new location
> discovered by a lookup.  In this case the inode is not locked during the
> new lookup.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dir.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5c569c3cb53f..7148b2a7611a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -235,9 +235,18 @@ static int fuse_dentry_revalidate(struct inode *dir, c=
onst struct qstr *name,
> =20
>  		attr_version =3D fuse_get_attr_version(fm->fc);
> =20
> +		inode_lock_shared(inode);
> +		if (entry->d_parent->d_inode !=3D dir ||
> +		    !d_same_name(entry, entry, name)) {
> +			/* raced with rename, assume revalidated */
> +			inode_unlock_shared(inode);
> +			return 1;
> +		}
> +
>  		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
>  				 name, &outarg);
>  		ret =3D fuse_simple_request(fm, &args);
> +		inode_unlock_shared(inode);
>  		/* Zero nodeid is same as -ENOENT */
>  		if (!ret && !outarg.nodeid)
>  			ret =3D -ENOENT;
> --=20
> 2.51.0
>=20
>=20


