Return-Path: <linux-fsdevel+bounces-58114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE9B298D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 07:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047217A33CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 05:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DE25F7A5;
	Mon, 18 Aug 2025 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="xeIEMq+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DF31771E;
	Mon, 18 Aug 2025 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755494258; cv=none; b=aFwYovFuNj6tlSbRFnZy/qnNlfGBR0bZ2LuDQiadzaaw4+Rh2AgliBi00iXT8MkCP9lB+Y5JSWWm6NWbzxisIRn33NN9+eUWF3idAySYMnbmQgB1zo/2nm6cHjjUbBZx93IMIAKH9kIOGkNu6NfvsXS12p1oevHNT461IT+fFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755494258; c=relaxed/simple;
	bh=Jfd2dTFyeKB2xDn34tvF4QC2QdcK0s/wj6YimXhuieo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMJZtmQkWuF9S/7TIom7IAJ3DGh2o/YRU+fnWQnKSHt2zuu2GRbQo2srq/G88VBIOoUHgRcgUevcixUVVEDNZvd+fTD4FHXzkP2RztYrBwzlNJuxKK5/y+8UObBkPLbakfgrT0loFK6nBYjovDr98cKz6P0qkNKrHgrHhHKjQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=xeIEMq+J; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c51Dr2Jp2z9ss7;
	Mon, 18 Aug 2025 07:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755494252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syTe/uAIV0t2r9xXhONHX6f7WtloSr6P6gMiq4MxqOE=;
	b=xeIEMq+J1v3//TRDOFKVvHZOHOSXlvHahsW4EQSTkTDsD88ScDLolCYEp1fQPVw52wiAb7
	CXB6e7u+3OELIG4E955g5VRTrxCidMVUbQkF7g3aRwIGwMLXsKyOMplcWP3kBZl5bgRSpG
	ho+yueGVKMxEtIDIkKIr2fK/joKjRFTpJNNlbtcp5+xIhDLnQVEuO0FNzzQzZMbrykZ6kx
	3m2NSoauOcWkCC8fboHzHNMFOacc7N68ap8G+AT5iHio74HqtU9sUXwrALwk6SU/YonCC7
	EkKi82gr+zBkugBbIjOeBZlQNLUJJ90ZxnyOZUZxqVYodAz9ORy91kyOmWZywg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Mon, 18 Aug 2025 15:17:20 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, 
	linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	autofs mailing list <autofs@vger.kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 4/4] vfs: fs/namei.c: if RESOLVE_NO_XDEV passed to
 openat2, don't *trigger* automounts
Message-ID: <2025-08-18.1755493390-violent-felt-issues-dares-AIMnxT@cyphar.com>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
 <20250817171513.259291-5-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jsoapanaxm6je7aj"
Content-Disposition: inline
In-Reply-To: <20250817171513.259291-5-safinaskar@zohomail.com>
X-Rspamd-Queue-Id: 4c51Dr2Jp2z9ss7


--jsoapanaxm6je7aj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] vfs: fs/namei.c: if RESOLVE_NO_XDEV passed to
 openat2, don't *trigger* automounts
MIME-Version: 1.0

On 2025-08-17, Askar Safin <safinaskar@zohomail.com> wrote:
> openat2 had a bug: if we pass RESOLVE_NO_XDEV, then openat2
> doesn't traverse through automounts, but may still trigger them.
> (See the link for full bug report with reproducer.)
>=20
> This commit fixes this bug.
>=20
> Link: https://lore.kernel.org/linux-fsdevel/20250817075252.4137628-1-safi=
naskar@zohomail.com/
> Fixes: fddb5d430ad9fa91b49b1 ("open: introduce openat2(2) syscall")
> Signed-off-by: Askar Safin <safinaskar@zohomail.com>

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>  fs/namei.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 6f43f96f506d..55e2447699a4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1449,6 +1449,18 @@ static int follow_automount(struct path *path, int=
 *count, unsigned lookup_flags
>  	    dentry->d_inode)
>  		return -EISDIR;
> =20
> +	/* "if" above returned -EISDIR if we want to get automount point itself
> +	 * as opposed to new mount. Getting automount point itself is, of cours=
e,
> +	 * totally okay even if we have LOOKUP_NO_XDEV.
> +	 *
> +	 * But if we got here, then we want to get
> +	 * new mount. Let's deny this if LOOKUP_NO_XDEV is specified.
> +	 * If we have LOOKUP_NO_XDEV, then we want to deny not only
> +	 * traversing through automounts, but also triggering them
> +	 */

This comment really could be one sentence:

  /* No need to trigger automounts if mountpoint crossing is disabled. */

Or if you really want to mention -EISDIR, then:

  /*
   * No need to trigger automounts if mountpoint crossing is disabled.
   * If the caller is trying to check the autmount point itself, -EISDIR
   * above handles that case for us.
   */

> +	if (lookup_flags & LOOKUP_NO_XDEV)
> +		return -EXDEV;
> +
>  	if (count && (*count)++ >=3D MAXSYMLINKS)
>  		return -ELOOP;
> =20
> @@ -1472,6 +1484,10 @@ static int __traverse_mounts(struct path *path, un=
signed flags, bool *jumped,
>  		/* Allow the filesystem to manage the transit without i_rwsem
>  		 * being held. */
>  		if (flags & DCACHE_MANAGE_TRANSIT) {
> +			if (lookup_flags & LOOKUP_NO_XDEV) {
> +				ret =3D -EXDEV;
> +				break;
> +			}
>  			ret =3D path->dentry->d_op->d_manage(path, false);
>  			flags =3D smp_load_acquire(&path->dentry->d_flags);
>  			if (ret < 0)
> --=20
> 2.47.2
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--jsoapanaxm6je7aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKK3YBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/zZwEA3uOoe6tqsP76hjwmV8US
yYybxOB07UZ/EkSRCgRv5EABAKd138R9BsEp5wytLcgmgqcD88nt35SD9RDYoi6g
i/UF
=778d
-----END PGP SIGNATURE-----

--jsoapanaxm6je7aj--

