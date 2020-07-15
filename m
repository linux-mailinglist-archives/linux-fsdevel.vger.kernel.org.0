Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F122186F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 01:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGOXdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 19:33:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:48698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGOXdR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:33:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59290B6E1;
        Wed, 15 Jul 2020 23:33:14 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jul 2020 09:33:04 +1000
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/23] md: replace the RAID_AUTORUN ioctl with a direct function call
In-Reply-To: <20200714190427.4332-6-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-6-hch@lst.de>
Message-ID: <87blkgxsjz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14 2020, Christoph Hellwig wrote:

> Instead of using a spcial RAID_AUTORUN ioctl that only exists for
> non-modular builds and is only called from the early init code, just
> call the actual function directly.

I think there was a tool in the old 'mdutls' that would call this ioctl
from user-space, but I cannot find a copy of that online, so I cannot be
sure.... not that it really matters.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  drivers/md/md-autodetect.c | 10 ++--------
>  drivers/md/md.c            | 14 +-------------
>  drivers/md/md.h            |  3 +++
>  3 files changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
> index fe806f7b9759a1..0eb746211ed53c 100644
> --- a/drivers/md/md-autodetect.c
> +++ b/drivers/md/md-autodetect.c
> @@ -9,6 +9,7 @@
>  #include <linux/raid/detect.h>
>  #include <linux/raid/md_u.h>
>  #include <linux/raid/md_p.h>
> +#include "md.h"
>=20=20
>  /*
>   * When md (and any require personalities) are compiled into the kernel
> @@ -285,8 +286,6 @@ __setup("md=3D", md_setup);
>=20=20
>  static void __init autodetect_raid(void)
>  {
> -	int fd;
> -
>  	/*
>  	 * Since we don't want to detect and use half a raid array, we need to
>  	 * wait for the known devices to complete their probing
> @@ -295,12 +294,7 @@ static void __init autodetect_raid(void)
>  	printk(KERN_INFO "md: If you don't use raid, use raid=3Dnoautodetect\n"=
);
>=20=20
>  	wait_for_device_probe();
> -
> -	fd =3D ksys_open("/dev/md0", 0, 0);
> -	if (fd >=3D 0) {
> -		ksys_ioctl(fd, RAID_AUTORUN, raid_autopart);
> -		ksys_close(fd);
> -	}
> +	md_autostart_arrays(raid_autopart);
>  }
>=20=20
>  void __init md_run_setup(void)
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index f567f536b529bd..6e9a48da474848 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -68,10 +68,6 @@
>  #include "md-bitmap.h"
>  #include "md-cluster.h"
>=20=20
> -#ifndef MODULE
> -static void autostart_arrays(int part);
> -#endif
> -
>  /* pers_list is a list of registered personalities protected
>   * by pers_lock.
>   * pers_lock does extra service to protect accesses to
> @@ -7421,7 +7417,6 @@ static inline bool md_ioctl_valid(unsigned int cmd)
>  	case GET_DISK_INFO:
>  	case HOT_ADD_DISK:
>  	case HOT_REMOVE_DISK:
> -	case RAID_AUTORUN:
>  	case RAID_VERSION:
>  	case RESTART_ARRAY_RW:
>  	case RUN_ARRAY:
> @@ -7467,13 +7462,6 @@ static int md_ioctl(struct block_device *bdev, fmo=
de_t mode,
>  	case RAID_VERSION:
>  		err =3D get_version(argp);
>  		goto out;
> -
> -#ifndef MODULE
> -	case RAID_AUTORUN:
> -		err =3D 0;
> -		autostart_arrays(arg);
> -		goto out;
> -#endif
>  	default:;
>  	}
>=20=20
> @@ -9721,7 +9709,7 @@ void md_autodetect_dev(dev_t dev)
>  	}
>  }
>=20=20
> -static void autostart_arrays(int part)
> +void md_autostart_arrays(int part)
>  {
>  	struct md_rdev *rdev;
>  	struct detected_devices_node *node_detected_dev;
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 612814d07d35ab..37315a3f28e97d 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -800,4 +800,7 @@ static inline void mddev_check_write_zeroes(struct md=
dev *mddev, struct bio *bio
>  	    !bio->bi_disk->queue->limits.max_write_zeroes_sectors)
>  		mddev->queue->limits.max_write_zeroes_sectors =3D 0;
>  }
> +
> +void md_autostart_arrays(int part);
> +
>  #endif /* _MD_MD_H */
> --=20
> 2.27.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8PkjAACgkQOeye3VZi
gbkPzRAAn5qOYJIGEh1PAEMKA3z3S43OAV2OIW/7M/EtYA3Ns3qggb132sayetSl
WG4Wvpr60UMXbFFdVmJzwRGnfp/V0VCgnuI3gcS4QePF7AXAAmwtGeVDyHEW+mhS
Cb/tl+fBYUaCiEp/FRRks4i8O6mE5OFKQq60SKMZa+n5XNVwLWbQkimOwmSsn6zD
zO0og6tmY0ji3zrC2nxr4gH8wdvOBd8zrmLG4SMdRkGNFrhaP1hX7XlFcewcKoY4
KyMTaZg3oQyoftaccZ+37pgiPC9eEHYb9v6ivsn2D6KYPqRMNSQPgxuCD3JjgVju
ZiaXIv5BzrZot04zyKLDxC8CUd19fsEpNln1Xi24l41ITCpp4+t+g2/3/X078lc4
GHHEJHQg8FK90SzTCXJ+oR8CaotTl1QweRbJmCJ752gQnI1X/xkRPRbq4IE3Q8bL
6ptSkm9KbddWJQYaH+z5kcPuRi0bBYse6SdWfk94aE3OeE8SdFfomF68paV5Tgkn
RrmquAve4pca2wnGtwF5po4BH8g82URcUinmrrNu37QJJDdcSozMVr9mQf8WQrGm
knNySDeGbwswLndrR/m1XHeopXroG3zym1G6vPe4b1GPq+c7oje/RK21ha57t+CG
npJ0UPW5Mr8gABDUvTCg4/sZpxyR6/jZWSLedUXt2Ek6IFPRIU0=
=61mh
-----END PGP SIGNATURE-----
--=-=-=--
