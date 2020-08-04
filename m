Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157B23B6EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 10:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgHDIjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 04:39:16 -0400
Received: from ozlabs.org ([203.11.71.1]:59697 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbgHDIjQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:39:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BLSpn4Hstz9sSt;
        Tue,  4 Aug 2020 18:39:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596530354;
        bh=FeQf8FUgKun80Y4EHdOmtvVnEY9w5MASUexH8Ovewu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NE2IAF4hz2t7q9OtBLZ/snuNWluHF9FgUjyG4X5CWDblbNoavEy+N/W/8V0FW6Rha
         rjbnEHA2uwyYq0WugsId/FcV9vYCjJDsXt7MFuReeeYbRRcj1ADA/UgYwT964pmxM9
         vLJIRhyz6l4F8/YHgfdD31nMk+vNRH5nPKlE68ktOAybOUpCjzz/Y258/VoWc9rUoe
         Tz/tj8XNQiV8kC4BgVkssiSSR+OSFWLDL8RA/eBiGpNiImoh2B1rKtjJ9Oj472/xSG
         jM52tIy5NCRWSqAeSViY7Xb5a1jMRj+vpJw/V2yR/QTWJvn1EI0bHE+W/Qn82dBS+E
         TxyO1qJVPKiHQ==
Date:   Tue, 4 Aug 2020 18:39:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: fix init_dup
Message-ID: <20200804183912.75fd9525@canb.auug.org.au>
In-Reply-To: <20200804095354.59190431@canb.auug.org.au>
References: <20200803135819.751465-1-hch@lst.de>
        <20200804095354.59190431@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/THxzpuXscrNWJBSAuafU_fx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/THxzpuXscrNWJBSAuafU_fx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Tue, 4 Aug 2020 09:53:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Mon,  3 Aug 2020 15:58:19 +0200 Christoph Hellwig <hch@lst.de> wrote:
> >
> > Don't allocate an unused fd for each call.  Also drop the extra
> > reference from filp_open after the init_dup calls while we're at it.
> >=20
> > Fixes: 36e96b411649 ("init: add an init_dup helper")
> > Reported-by Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >=20
> > Al, feel free to fold this into the original patch, as that is the
> > last one in the branch.
> >=20
> >  fs/init.c   | 2 +-
> >  init/main.c | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/init.c b/fs/init.c
> > index 730e05acda2392..e9c320a48cf157 100644
> > --- a/fs/init.c
> > +++ b/fs/init.c
> > @@ -260,6 +260,6 @@ int __init init_dup(struct file *file)
> >  	fd =3D get_unused_fd_flags(0);
> >  	if (fd < 0)
> >  		return fd;
> > -	fd_install(get_unused_fd_flags(0), get_file(file));
> > +	fd_install(fd, get_file(file));
> >  	return 0;
> >  }
> > diff --git a/init/main.c b/init/main.c
> > index 089e21504b1fc1..9dae9c4f806bb9 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1470,6 +1470,7 @@ void __init console_on_rootfs(void)
> >  	init_dup(file);
> >  	init_dup(file);
> >  	init_dup(file);
> > +	fput(file);
> >  }
> > =20
> >  static noinline void __init kernel_init_freeable(void)
> > --=20
> > 2.27.0
> >  =20
>=20
> Thanks, I have added that to the vfs tree merge today.

This fixes my qemu problems, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/THxzpuXscrNWJBSAuafU_fx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8pHrAACgkQAVBC80lX
0GwE5Qf6A0sD6ftKk/1qFG9ewK9A7eAyg0ByHwa7KQyn9bWpc1DjTXb5VKN4VpkP
AVy8J81ShjX92L4EpaK97jQfY+oqrFCiZBX2WddU6EZiPhRhmeqXohOar2butSiz
9r1zDHHmEH6OihLup9KJPP3LeqKpe2VCwtQP3vzk755b8Lvxg3hr7BbRL18muiUw
Y0s70UqHTwsCCuxpFJXKdoUJd08sGZAAwp1Uc7dHQuHTzQxsrPvde0fEo0U1JjNe
WvFakNnc4q6icx4jwePMPckMNuD7FiiivqxT1U3FrIUMPBl7UoqXFPvOaGmMISmg
m3LdeW1ArV+fNt4yC/3dBAkZFRqNZw==
=DzeI
-----END PGP SIGNATURE-----

--Sig_/THxzpuXscrNWJBSAuafU_fx--
