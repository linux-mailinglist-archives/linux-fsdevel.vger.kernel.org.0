Return-Path: <linux-fsdevel+bounces-58126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA0B29AA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 09:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6CC7ADFF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49D27990C;
	Mon, 18 Aug 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="NqxcVjs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4B5FDA7;
	Mon, 18 Aug 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501339; cv=none; b=Kd2qbknw2ng4qjuebrrEHzwGHwxYifV3UkF/wKRpPbnqnYKZlfnj9+DLizQTyqtIznJL95XXxP+pd7Bd4pUX2Pd3KfeExEzEWnkAvhtoF0+8eSArUb8FS2yGkehnHAzMkOv3w9qvPAOZ2SkyQcLRDNvcRIk39thhYBlt4rivgnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501339; c=relaxed/simple;
	bh=/2NRTp6YWIrj6g3ydkyLG8IqaSjj+aNWtAVkBJh+1os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUEzwosTVI+9oNthRzh73TNxPjR7bl4Hp7RtLia0++BPKR6iBfyRyd9XA4smlOFTtQT5RTTzCzQMxK5p9BLzpnOCg3u2jrWQK2oTrTjUd+NoZ+0fiMtuHR/N1NQy5KRuWZiJgfGuy+muaHPmxlnmH+7xkLeekEAHJ7jHeLiWNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=NqxcVjs7; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c53s00Fhyz9skV;
	Mon, 18 Aug 2025 09:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755501332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj1/XLL/AzYIOlRA8pwRquZjNoxlC2SeoQS3eaKYHqI=;
	b=NqxcVjs7qvzW55j/Q1fKyduw3sz34pNSAW0mELibcvct3eMKsfV33UyBkXydZcT07kvCHy
	/Xu53Zo9/QUwnhzHkW9dq2GVs5TBe+yuTnzuKnPBdNxiutDnlwlLDsW1LNLGo/O8758Y78
	Et+PyhSVEm5oitljrXr5v//Bb+Gj9/wbf9+PyBnwOmnhKSZY72FMz2kBGd7VxU6nESsx7N
	A8W0BUnlcSlt/ADAO+mCw49HrXezhkkT4JHbYNLHPTWm7o2lIC3KkDcsUlSO8qMGnV05xx
	UzBduDYdEn7w3qmgxDvzxEExUeNWhzcIGB1By0UgnhecShtcko/Gut0ymSPXVQ==
Date: Mon, 18 Aug 2025 17:15:16 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, 
	linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	autofs mailing list <autofs@vger.kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 4/4] vfs: fs/namei.c: if RESOLVE_NO_XDEV passed to
 openat2, don't *trigger* automounts
Message-ID: <2025-08-18.1755500319-dumb-naughty-errors-dash-YpWnja@cyphar.com>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
 <20250817171513.259291-5-safinaskar@zohomail.com>
 <2025-08-18.1755493390-violent-felt-issues-dares-AIMnxT@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgbl7w6wm2xkwjr5"
Content-Disposition: inline
In-Reply-To: <2025-08-18.1755493390-violent-felt-issues-dares-AIMnxT@cyphar.com>


--xgbl7w6wm2xkwjr5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] vfs: fs/namei.c: if RESOLVE_NO_XDEV passed to
 openat2, don't *trigger* automounts
MIME-Version: 1.0

On 2025-08-18, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-08-17, Askar Safin <safinaskar@zohomail.com> wrote:
> > openat2 had a bug: if we pass RESOLVE_NO_XDEV, then openat2
> > doesn't traverse through automounts, but may still trigger them.
> > (See the link for full bug report with reproducer.)
> >=20
> > This commit fixes this bug.
> >=20
> > Link: https://lore.kernel.org/linux-fsdevel/20250817075252.4137628-1-sa=
finaskar@zohomail.com/
> > Fixes: fddb5d430ad9fa91b49b1 ("open: introduce openat2(2) syscall")
> > Signed-off-by: Askar Safin <safinaskar@zohomail.com>
>=20
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> > ---
> >  fs/namei.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 6f43f96f506d..55e2447699a4 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1449,6 +1449,18 @@ static int follow_automount(struct path *path, i=
nt *count, unsigned lookup_flags
> >  	    dentry->d_inode)
> >  		return -EISDIR;
> > =20
> > +	/* "if" above returned -EISDIR if we want to get automount point itse=
lf
> > +	 * as opposed to new mount. Getting automount point itself is, of cou=
rse,
> > +	 * totally okay even if we have LOOKUP_NO_XDEV.
> > +	 *
> > +	 * But if we got here, then we want to get
> > +	 * new mount. Let's deny this if LOOKUP_NO_XDEV is specified.
> > +	 * If we have LOOKUP_NO_XDEV, then we want to deny not only
> > +	 * traversing through automounts, but also triggering them
> > +	 */
>=20
> This comment really could be one sentence:
>=20
>   /* No need to trigger automounts if mountpoint crossing is disabled. */
>=20
> Or if you really want to mention -EISDIR, then:
>=20
>   /*
>    * No need to trigger automounts if mountpoint crossing is disabled.
>    * If the caller is trying to check the autmount point itself, -EISDIR
>    * above handles that case for us.
>    */

That being said, the only user of LOOKUP_NO_XDEV is openat2(), so the
stat stuff is a bit of a red herring.

At the moment, O_PATH and O_PATH|O_DIRECTORY have different behaviours
here, and I'm not sure users expect that -- O_PATH will let you get a
handle to the automount point, but O_DIRECTORY causes the -EISDIR case
to be skipped and triggers the automount. We can't just remove
LOOKUP_DIRECTORY from the check since it is used for a lot of
kernel-internal lookups, but we should have O_PATH|O_DIRECTORY produce
identical behaviour to O_PATH in this case IMHO.

> > +	if (lookup_flags & LOOKUP_NO_XDEV)
> > +		return -EXDEV;
> > +
> >  	if (count && (*count)++ >=3D MAXSYMLINKS)
> >  		return -ELOOP;
> > =20
> > @@ -1472,6 +1484,10 @@ static int __traverse_mounts(struct path *path, =
unsigned flags, bool *jumped,
> >  		/* Allow the filesystem to manage the transit without i_rwsem
> >  		 * being held. */
> >  		if (flags & DCACHE_MANAGE_TRANSIT) {
> > +			if (lookup_flags & LOOKUP_NO_XDEV) {
> > +				ret =3D -EXDEV;
> > +				break;
> > +			}
> >  			ret =3D path->dentry->d_op->d_manage(path, false);
> >  			flags =3D smp_load_acquire(&path->dentry->d_flags);
> >  			if (ret < 0)
> > --=20
> > 2.47.2
> >=20
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--xgbl7w6wm2xkwjr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKLTBBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+yDQEA9cFyoq35bvrj9ODvEWTd
9GwkZfz/O6WfZW6/sIGkGxMBAPv3r23XydNZUkFXK4URwlrlW+jiLrCCvhvkjgc3
KK4M
=Wh/y
-----END PGP SIGNATURE-----

--xgbl7w6wm2xkwjr5--

