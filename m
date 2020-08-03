Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F182A23B145
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 01:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgHCXx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 19:53:57 -0400
Received: from ozlabs.org ([203.11.71.1]:49747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHCXx5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:53:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BLF8g4Y82z9sR4;
        Tue,  4 Aug 2020 09:53:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596498835;
        bh=3QaMmEzhlBgq6Ivf/aR6g7OyQi5RxwDhBNguqGe4DVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sC9b0q1Eo0uDAZ7OVLJiourxKj9swRNnE8opgbAz6JzI+Xjw7u7UMJtLO+xvF/XNy
         RlPjRgIEOdumfXHXy7O0F3gJWR+6OblWNBt+iqWGapx1K4RDlF+hdrbh0PHvKLYmxv
         c5kUX0nRFRvLEq7YQnHv9N7fFsCy7cLWa6qWCLf6vRiupB2jw3/Si5/BzV3oA8IM92
         ILD6prp1dPUIOHHC4wmjJPn+0VQsoECORu/rvtwri08JmdpHyPShitihLX7IIOOlBS
         TYAxSAl6cP8G6obyvjNk5UQLr0s9ePctGn7ssahTP8kteQpdDdFgYKQDK85o06uman
         /Pmb+Yun15ktA==
Date:   Tue, 4 Aug 2020 09:53:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: fix init_dup
Message-ID: <20200804095354.59190431@canb.auug.org.au>
In-Reply-To: <20200803135819.751465-1-hch@lst.de>
References: <20200803135819.751465-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4FwB/DEAbxQGc+6cKsfOMcC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/4FwB/DEAbxQGc+6cKsfOMcC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Mon,  3 Aug 2020 15:58:19 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> Don't allocate an unused fd for each call.  Also drop the extra
> reference from filp_open after the init_dup calls while we're at it.
>=20
> Fixes: 36e96b411649 ("init: add an init_dup helper")
> Reported-by Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>=20
> Al, feel free to fold this into the original patch, as that is the
> last one in the branch.
>=20
>  fs/init.c   | 2 +-
>  init/main.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/init.c b/fs/init.c
> index 730e05acda2392..e9c320a48cf157 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -260,6 +260,6 @@ int __init init_dup(struct file *file)
>  	fd =3D get_unused_fd_flags(0);
>  	if (fd < 0)
>  		return fd;
> -	fd_install(get_unused_fd_flags(0), get_file(file));
> +	fd_install(fd, get_file(file));
>  	return 0;
>  }
> diff --git a/init/main.c b/init/main.c
> index 089e21504b1fc1..9dae9c4f806bb9 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1470,6 +1470,7 @@ void __init console_on_rootfs(void)
>  	init_dup(file);
>  	init_dup(file);
>  	init_dup(file);
> +	fput(file);
>  }
> =20
>  static noinline void __init kernel_init_freeable(void)
> --=20
> 2.27.0
>=20

Thanks, I have added that to the vfs tree merge today.

--=20
Cheers,
Stephen Rothwell

--Sig_/4FwB/DEAbxQGc+6cKsfOMcC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8oo5IACgkQAVBC80lX
0GwoPgf+NaWmqIiug637VbuVtEbaruFhA2AKNE6+lqFZ3QOvIds8YbOjaPiXDBLP
RTAXVlj2+Nym6R57ihxbAJpdH+WmRpawah38hQTdOA900RHwJRRRBHE2p6wELtIh
bj+yo1+NmuFQIpD4I+MvmrJbUO7evszAH/TAbD7saCuhomIeajssyLm3HdeVTkeX
KDyb5xt1nFZW13cZW9cCV+h76bah1/P2J1kpULMmQV5R2jEJx5ehhSO/+8w7dbym
ltM4pQNFht1WGA75Bcxx0AqGfiRpNPvhxpbQzvlTeIkoiK3TMg4sD8lIiGs6GbgV
M+oMoTag1UG1744hkpKGzY9BzKNgtA==
=UN2h
-----END PGP SIGNATURE-----

--Sig_/4FwB/DEAbxQGc+6cKsfOMcC--
