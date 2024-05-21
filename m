Return-Path: <linux-fsdevel+bounces-19875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B6D8CAC62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F401C2194C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF86EB5D;
	Tue, 21 May 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="O/1T7dc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AE6CDBD;
	Tue, 21 May 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288192; cv=none; b=f/nxNbBPjOWjsfJq+QuTwmLlUSJeVNRPjjcFHUw1FVIUgeCZ2A681/fQmveLVNEnDn5jkxB3t+eB/pbE5wAHWArsCMp6YD0hXjI9ntgBoo9DqprED9z2glUq4GAeCKCSThCMb/6TJb4CjUTAOaktCiUAcvtPTChPqoBtOvkTshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288192; c=relaxed/simple;
	bh=9xMriote5JorYDhgNp4LSt+zcJU2s4T6KrDyethtsEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqrSbJYgNjl1quW/vSIyJdFKxfwpuXKX0sqAKSCZOnPp32l0pzy9O/tNXjyPyvDv5+vnmCQLNmvn//xzKeygOwLvDKH2UYZd0H/XpqCK5SomcyDL67A9j5lsUmW+AW9JArH8ngTfLov/1wavYpT697htkGEfjGMVJPo9ZoFpY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=O/1T7dc6; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vk9y23BRcz9sdF;
	Tue, 21 May 2024 12:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716288186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYTAhwnpE+P1ehtdAEfh1DqiXMQlr6YhhirBwYk8EwA=;
	b=O/1T7dc6oz0X6pG2RyIbPXrwceAGz5ttLLwg8LkOO0rkKC6QBnHNNXrCD3MimpnWDhWkXp
	5+7vrAv0wE/Aoajv7wIpZkLMYLsktutqyS2Kykhfj7hfW0syoCKFQ2SRTsGUKAd/p6m1eG
	ven8AW49zigYWrZbiFB4AygNG1EF8xfUf9qe9pbmS7FXMGqzKOV3CVeAS3GoqFQZ01qijb
	k4pgq18L1alBz8W4LnQ1XaxgUFNMhrpZg0DsweTbAEOZChpo0heZ0uAWGeC74y4dNcwkAz
	hqY+hPoTIucALxpvWxyWh2grAlRCplQrU9AchASVY6Wkl+pXp2dDUcDp0rt4MA==
Date: Tue, 21 May 2024 04:42:46 -0600
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgoettsche@seltendoof.de>
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240521.101154-orange.hermits.guilty.barriers-SCEfgdQWePpT@cyphar.com>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <f51a4bf68289268206475e3af226994607222be4.camel@kernel.org>
 <20240520.221843-swanky.buyers.maroon.prison-MAgYEXR0vg7P@cyphar.com>
 <CAOQ4uxiaRGypAB0v49FW8Se+=4e4to1FAg77sxLPCkO55KcuHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hpyjshrojjwimm26"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiaRGypAB0v49FW8Se+=4e4to1FAg77sxLPCkO55KcuHQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4Vk9y23BRcz9sdF


--hpyjshrojjwimm26
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-21, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, May 21, 2024 at 1:28=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > On 2024-05-20, Jeff Layton <jlayton@kernel.org> wrote:
> > > On Mon, 2024-05-20 at 17:35 -0400, Aleksa Sarai wrote:
> > > > Now that we have stabilised the unique 64-bit mount ID interface in
> > > > statx, we can now provide a race-free way for name_to_handle_at(2) =
to
> > > > provide a file handle and corresponding mount without needing to wo=
rry
> > > > about racing with /proc/mountinfo parsing.
>=20
> Both statx() and name_to_handle_at() support AT_EMPTY_PATH, so
> there is a race-free way to get a file handle and unique mount id
> for statmount().

Doing it that way would require doing an open and statx for every path
you want to get a filehandle for, tripling the number of syscalls you
need to do. This is related to the syscall overhead issue Lennart talked
about last week at LSF (though for his usecase we would need to add a
hashed filehandle in statx).

> Why do you mean /proc/mountinfo parsing?

The man page for name_to_handle_at(2) talks about needing to parse
/proc/mountinfo as well as the possible races you can hit.

> > > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* =
bit
> > > > that doesn't make sense for name_to_handle_at(2).
>=20
> Christian is probably regretting merging AT_HANDLE_FID now ;-)
>=20
> Seriously, I would rearrange the AT_* flags namespace this way to
> explicitly declare the overloaded per-syscall AT_* flags and possibly
> prepare for the upcoming setxattrat(2) syscall [1].

I'm not sure that unifying the flag namespace is a good idea -- while it
would be nicer, burning a flag bit for an extension will be more
expensive because we would only have 32 bits for every possible
extension we ever plan to have.

FWIW, I think that statx should've had their own flag namespace like
move_mount and renameat2.

> [1] https://lore.kernel.org/linux-fsdevel/20240426162042.191916-1-cgoetts=
che@seltendoof.de/
>=20
> The reason I would avoid overloading the AT_STATX_* flags is that
> they describe a generic behavior that could potentially be relevant to
> other syscalls in the future, e.g.:
> renameat2(..., AT_RENAME_TEMPFILE | AT_FORCE_SYNC);

Yeah, you might be right that the sync-related flags aren't the right
ones to overload here.

> But then again, I don't understand why you need to extend name_to_handle_=
at()
> at all for your purpose...
>=20
> Thanks,
> Amir.
>=20
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> [...]
> +
> +#define AT_PRIVATE_FLAGS       0x2ff   /* Per-syscall flags mask.  */
> +
> +/* Common flags for *at() syscalls */
>  #define AT_SYMLINK_NOFOLLOW    0x100   /* Do not follow symbolic links. =
 */
> -#define AT_EACCESS             0x200   /* Test access permitted for
> -                                           effective IDs, not real IDs. =
 */
> -#define AT_REMOVEDIR           0x200   /* Remove directory instead of
> -                                           unlinking file.  */
>  #define AT_SYMLINK_FOLLOW      0x400   /* Follow symbolic links.  */
>  #define AT_NO_AUTOMOUNT                0x800   /* Suppress terminal
> automount traversal */
>  #define AT_EMPTY_PATH          0x1000  /* Allow empty relative pathname =
*/
>=20
> +/* Flags for statx(2) */
>  #define AT_STATX_SYNC_TYPE     0x6000  /* Type of synchronisation
> required from statx() */
>  #define AT_STATX_SYNC_AS_STAT  0x0000  /* - Do whatever stat() does */
>  #define AT_STATX_FORCE_SYNC    0x2000  /* - Force the attributes to
> be sync'd with the server */
> [...]
>=20
>  #define AT_RECURSIVE           0x8000  /* Apply to the entire subtree */
>=20
> -/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits.=
=2E. */
> -#define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is needed =
to
> +/* Flags for name_to_handle_at(2) */
> +#define AT_HANDLE_FID          0x200   /* file handle is needed to
>                                         compare object identity and may n=
ot
>                                         be usable to open_by_handle_at(2)=
 */
> +/* Flags for faccessat(2) */
> +#define AT_EACCESS             0x200   /* Test access permitted for
> +                                           effective IDs, not real IDs. =
 */
> +/* Flags for unlinkat(2) */
> +#define AT_REMOVEDIR           0x200   /* Remove directory instead of
> +                                           unlinking file.  */
> +
> +/* Flags for renameat2(2) (should match legacy RENAME_* flags) */
> +#define AT_RENAME_NOREPLACE    0x001   /* Don't overwrite target */
> +#define AT_RENAME_EXCHANGE     0x002   /* Exchange source and dest */
> +#define AT_RENAME_WHITEOUT     0x004   /* Whiteout source */
> +#define AT_RENAME_TEMPFILE     0x008   /* Source file is O_TMPFILE */
> +
> +/* Flags for setxattrat(2) (should match legacy XATTR_* flags) */
> +#define AT_XATTR_CREATE                0x001   /* set value, fail if
> attr already exists */
> +#define AT_XATTR_REPLACE       0x002   /* set value, fail if attr
> does not exist */
> +

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--hpyjshrojjwimm26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZkx6ogAKCRAol/rSt+lE
b6pxAQCSPhH8/puRhj9aVC4vEbP75PcnVUIS/FZzITkwj543GwD/U4fAcii58Jr/
KCEdC2P+hpRduVSHHQqFcndDB2L5ywA=
=ewlE
-----END PGP SIGNATURE-----

--hpyjshrojjwimm26--

