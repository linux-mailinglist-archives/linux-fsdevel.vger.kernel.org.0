Return-Path: <linux-fsdevel+bounces-24133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB993A114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25EE283D72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B0153517;
	Tue, 23 Jul 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZhAOtM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4065152E1D;
	Tue, 23 Jul 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740573; cv=none; b=ZEWOsw1meQRUGioDvaqJ6nAj3mP61Qe8/xzjNmCkW/eX5W/u6RQTY9pH4E8rilredKjbKUWcAL+asQ6CEiVBXDhIQ90Pyofcx1WX1nSsYHBgmgnIDkPwVOhCH+YVU4CrdFPWYkpzsydekyXDmvIc7EODChXPdsayEQrrrmPyf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740573; c=relaxed/simple;
	bh=KWifQZqQ8T0lPyWaVa/Z6CVrrNBq2dz1vtCZNDGJaF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPFU5Tei7ayW1Ebfu+vqKZCItg+KtpPgeXNrczEgR4IMOkiU6BwohndKG0MExvQCaI1QuZT0XeCxqRTJOlvMC2IFV2KRmNlLBGoYx1UTiIYerDoyBnFsGR7SUfUV8rKvdAGjNp4Oe7lpj3IZDm2Z0bAIlBSvIC64VK2jkMmB9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZhAOtM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBEEC4AF0A;
	Tue, 23 Jul 2024 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721740573;
	bh=KWifQZqQ8T0lPyWaVa/Z6CVrrNBq2dz1vtCZNDGJaF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AZhAOtM4TNL2zitLuFmXduh3EIZQqqDE2vZvgYKx7bzSV/1F43u+MiabUx13sLV/w
	 ituKOro2E8t0h4EgjbeFIwOSWDVVfn5C2p1vhZmy0Xpmgddie2AAa0fKFmdmxnF26a
	 9wxHCU4HXuaP/dxrBz/apKDRKLXoxYwFXQmBvKAtSqayXL4yoyz+Ki77k21PzXCRoL
	 NWNCy4gTvpFj/ucdrPREkRGjSysnBEaJp2VwInoORvzYt2ZaGvafh16N/5qTefRWRc
	 UV3aqmkYpK3Gl8aN5MacpadAHndXHIyWsl21o5TB/mmUB1YGDueCvietEYdXzWUaxY
	 c29V7FN7RVDjw==
Message-ID: <7ce8cadfc432368924134ae96f8d9710282a15d6.camel@kernel.org>
Subject: Re: [PATCH] filelock: add file path in lock_get_status() to show
 more debug info
From: Jeff Layton <jlayton@kernel.org>
To: Yuwei Guan <Yuwei.Guan@zeekrlife.com>, chuck.lever@oracle.com, 
 alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssawgyw@gmail.com, Dashi.Luban@zeekrlife.com
Date: Tue, 23 Jul 2024 09:16:10 -0400
In-Reply-To: <20240723123816.3676322-1-Yuwei.Guan@zeekrlife.com>
References: <20240723123816.3676322-1-Yuwei.Guan@zeekrlife.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedY
	xp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZQiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/D
	CmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnokkZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-23 at 20:38 +0800, Yuwei Guan wrote:
> The current lock_get_status() function shows ino, but it=E2=80=99s not
> intuitive enough for debugging. This patch will add the file=E2=80=99s
> path information, making it easier to debug which specific file
> is holding the lock.
>=20
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
> =C2=A0fs/locks.c | 25 ++++++++++++++++++++++++-
> =C2=A01 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index bdd94c32256f..feb0a4427a5b 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2764,6 +2764,8 @@ static void lock_get_status(struct seq_file *f,
> struct file_lock_core *flc,
> =C2=A0	struct pid_namespace *proc_pidns =3D proc_pid_ns(file_inode(f-
> >file)->i_sb);
> =C2=A0	int type =3D flc->flc_type;
> =C2=A0	struct file_lock *fl =3D file_lock(flc);
> +	struct dentry *dentry =3D NULL;
> +	char *path, *pathbuf;
> =C2=A0
> =C2=A0	pid =3D locks_translate_pid(flc, proc_pidns);
> =C2=A0
> @@ -2819,8 +2821,29 @@ static void lock_get_status(struct seq_file
> *f, struct file_lock_core *flc,
> =C2=A0		seq_printf(f, "%d %02x:%02x:%lu ", pid,
> =C2=A0				MAJOR(inode->i_sb->s_dev),
> =C2=A0				MINOR(inode->i_sb->s_dev), inode-
> >i_ino);
> +
> +		pathbuf =3D __getname();

This won't work. locks_show is called under the blocked_lock_lock
spinlock, and __getname does a GFP_KERNEL allocation.

The second problem is that the procfiles that this alters (/proc/locks
and /proc/<pid>/fdinfo/*) are considered part of the kernel's ABI, so
we can't just go change the format of them.

If you're interested in getting pathnames, I suggest using the lslocks
program which resolves these pathnames in userland.

> +		if (!pathbuf)
> +			seq_printf(f, "%s ", "UNKNOWN");
> +		else {
> +			ihold(inode);
> +			dentry =3D d_obtain_alias(inode);
> +			if (!IS_ERR(dentry)) {
> +				path =3D dentry_path_raw(dentry,
> pathbuf, PATH_MAX);
> +				if (IS_ERR(path)) {
> +					strscpy(pathbuf, "UNKNOWN",
> PATH_MAX);
> +					path =3D pathbuf;
> +				}
> +				dput(dentry);
> +			} else {
> +				strscpy(pathbuf, "UNKNOWN",
> PATH_MAX);
> +				path =3D pathbuf;
> +			}
> +			seq_printf(f, "%s ", path);
> +			__putname(pathbuf);
> +		}
> =C2=A0	} else {
> -		seq_printf(f, "%d <none>:0 ", pid);
> +		seq_printf(f, "%d <none>:0:<none> UNKNOWN ", pid);
> =C2=A0	}
> =C2=A0	if (flc->flc_flags & FL_POSIX) {
> =C2=A0		if (fl->fl_end =3D=3D OFFSET_MAX)

--=20
Jeff Layton <jlayton@kernel.org>

