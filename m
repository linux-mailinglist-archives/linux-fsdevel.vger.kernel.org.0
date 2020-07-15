Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015AC22187D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 01:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGOXht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 19:37:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGOXht (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBEA1B718;
        Wed, 15 Jul 2020 23:37:50 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jul 2020 09:37:40 +1000
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/23] md: simplify md_setup_drive
In-Reply-To: <20200714190427.4332-9-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-9-hch@lst.de>
Message-ID: <875zaoxscb.fsf@notabene.neil.brown.name>
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

> Move the loop over the possible arrays into the caller to remove a level
> of indentation for the whole function.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Song Liu <song@kernel.org>

Nice

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

> ---
>  drivers/md/md-autodetect.c | 203 ++++++++++++++++++-------------------
>  1 file changed, 101 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
> index 6bc9b734eee6ff..a43a8f1580584c 100644
> --- a/drivers/md/md-autodetect.c
> +++ b/drivers/md/md-autodetect.c
> @@ -27,7 +27,7 @@ static int __initdata raid_noautodetect=3D1;
>  #endif
>  static int __initdata raid_autopart;
>=20=20
> -static struct {
> +static struct md_setup_args {
>  	int minor;
>  	int partitioned;
>  	int level;
> @@ -126,122 +126,117 @@ static inline int create_dev(char *name, dev_t de=
v)
>  	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
>  }
>=20=20
> -static void __init md_setup_drive(void)
> +static void __init md_setup_drive(struct md_setup_args *args)
>  {
> -	int minor, i, ent, partitioned;
> +	int minor, i, partitioned;
>  	dev_t dev;
>  	dev_t devices[MD_SB_DISKS+1];
> +	int fd;
> +	int err =3D 0;
> +	char *devname;
> +	mdu_disk_info_t dinfo;
> +	char name[16];
>=20=20
> -	for (ent =3D 0; ent < md_setup_ents ; ent++) {
> -		int fd;
> -		int err =3D 0;
> -		char *devname;
> -		mdu_disk_info_t dinfo;
> -		char name[16];
> +	minor =3D args->minor;
> +	partitioned =3D args->partitioned;
> +	devname =3D args->device_names;
>=20=20
> -		minor =3D md_setup_args[ent].minor;
> -		partitioned =3D md_setup_args[ent].partitioned;
> -		devname =3D md_setup_args[ent].device_names;
> +	sprintf(name, "/dev/md%s%d", partitioned?"_d":"", minor);
> +	if (partitioned)
> +		dev =3D MKDEV(mdp_major, minor << MdpMinorShift);
> +	else
> +		dev =3D MKDEV(MD_MAJOR, minor);
> +	create_dev(name, dev);
> +	for (i =3D 0; i < MD_SB_DISKS && devname !=3D NULL; i++) {
> +		struct kstat stat;
> +		char *p;
> +		char comp_name[64];
>=20=20
> -		sprintf(name, "/dev/md%s%d", partitioned?"_d":"", minor);
> -		if (partitioned)
> -			dev =3D MKDEV(mdp_major, minor << MdpMinorShift);
> -		else
> -			dev =3D MKDEV(MD_MAJOR, minor);
> -		create_dev(name, dev);
> -		for (i =3D 0; i < MD_SB_DISKS && devname !=3D NULL; i++) {
> -			struct kstat stat;
> -			char *p;
> -			char comp_name[64];
> +		p =3D strchr(devname, ',');
> +		if (p)
> +			*p++ =3D 0;
>=20=20
> -			p =3D strchr(devname, ',');
> -			if (p)
> -				*p++ =3D 0;
> +		dev =3D name_to_dev_t(devname);
> +		if (strncmp(devname, "/dev/", 5) =3D=3D 0)
> +			devname +=3D 5;
> +		snprintf(comp_name, 63, "/dev/%s", devname);
> +		if (vfs_stat(comp_name, &stat) =3D=3D 0 && S_ISBLK(stat.mode))
> +			dev =3D new_decode_dev(stat.rdev);
> +		if (!dev) {
> +			printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
> +			break;
> +		}
>=20=20
> -			dev =3D name_to_dev_t(devname);
> -			if (strncmp(devname, "/dev/", 5) =3D=3D 0)
> -				devname +=3D 5;
> -			snprintf(comp_name, 63, "/dev/%s", devname);
> -			if (vfs_stat(comp_name, &stat) =3D=3D 0 &&
> -			    S_ISBLK(stat.mode))
> -				dev =3D new_decode_dev(stat.rdev);
> -			if (!dev) {
> -				printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
> -				break;
> -			}
> +		devices[i] =3D dev;
> +		devname =3D p;
> +	}
> +	devices[i] =3D 0;
>=20=20
> -			devices[i] =3D dev;
> +	if (!i)
> +		return;
>=20=20
> -			devname =3D p;
> -		}
> -		devices[i] =3D 0;
> +	printk(KERN_INFO "md: Loading md%s%d: %s\n",
> +		partitioned ? "_d" : "", minor,
> +		args->device_names);
>=20=20
> -		if (!i)
> -			continue;
> +	fd =3D ksys_open(name, 0, 0);
> +	if (fd < 0) {
> +		printk(KERN_ERR "md: open failed - cannot start "
> +				"array %s\n", name);
> +		return;
> +	}
> +	if (ksys_ioctl(fd, SET_ARRAY_INFO, 0) =3D=3D -EBUSY) {
> +		printk(KERN_WARNING
> +		       "md: Ignoring md=3D%d, already autodetected. (Use raid=3Dnoauto=
detect)\n",
> +		       minor);
> +		ksys_close(fd);
> +		return;
> +	}
>=20=20
> -		printk(KERN_INFO "md: Loading md%s%d: %s\n",
> -			partitioned ? "_d" : "", minor,
> -			md_setup_args[ent].device_names);
> +	if (args->level !=3D LEVEL_NONE) {
> +		/* non-persistent */
> +		mdu_array_info_t ainfo;
> +		ainfo.level =3D args->level;
> +		ainfo.size =3D 0;
> +		ainfo.nr_disks =3D0;
> +		ainfo.raid_disks =3D0;
> +		while (devices[ainfo.raid_disks])
> +			ainfo.raid_disks++;
> +		ainfo.md_minor =3Dminor;
> +		ainfo.not_persistent =3D 1;
>=20=20
> -		fd =3D ksys_open(name, 0, 0);
> -		if (fd < 0) {
> -			printk(KERN_ERR "md: open failed - cannot start "
> -					"array %s\n", name);
> -			continue;
> -		}
> -		if (ksys_ioctl(fd, SET_ARRAY_INFO, 0) =3D=3D -EBUSY) {
> -			printk(KERN_WARNING
> -			       "md: Ignoring md=3D%d, already autodetected. (Use raid=3Dnoaut=
odetect)\n",
> -			       minor);
> -			ksys_close(fd);
> -			continue;
> +		ainfo.state =3D (1 << MD_SB_CLEAN);
> +		ainfo.layout =3D 0;
> +		ainfo.chunk_size =3D args->chunk;
> +		err =3D ksys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
> +		for (i =3D 0; !err && i <=3D MD_SB_DISKS; i++) {
> +			dev =3D devices[i];
> +			if (!dev)
> +				break;
> +			dinfo.number =3D i;
> +			dinfo.raid_disk =3D i;
> +			dinfo.state =3D (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
> +			dinfo.major =3D MAJOR(dev);
> +			dinfo.minor =3D MINOR(dev);
> +			err =3D ksys_ioctl(fd, ADD_NEW_DISK,
> +					 (long)&dinfo);
>  		}
> -
> -		if (md_setup_args[ent].level !=3D LEVEL_NONE) {
> -			/* non-persistent */
> -			mdu_array_info_t ainfo;
> -			ainfo.level =3D md_setup_args[ent].level;
> -			ainfo.size =3D 0;
> -			ainfo.nr_disks =3D0;
> -			ainfo.raid_disks =3D0;
> -			while (devices[ainfo.raid_disks])
> -				ainfo.raid_disks++;
> -			ainfo.md_minor =3Dminor;
> -			ainfo.not_persistent =3D 1;
> -
> -			ainfo.state =3D (1 << MD_SB_CLEAN);
> -			ainfo.layout =3D 0;
> -			ainfo.chunk_size =3D md_setup_args[ent].chunk;
> -			err =3D ksys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
> -			for (i =3D 0; !err && i <=3D MD_SB_DISKS; i++) {
> -				dev =3D devices[i];
> -				if (!dev)
> -					break;
> -				dinfo.number =3D i;
> -				dinfo.raid_disk =3D i;
> -				dinfo.state =3D (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
> -				dinfo.major =3D MAJOR(dev);
> -				dinfo.minor =3D MINOR(dev);
> -				err =3D ksys_ioctl(fd, ADD_NEW_DISK,
> -						 (long)&dinfo);
> -			}
> -		} else {
> -			/* persistent */
> -			for (i =3D 0; i <=3D MD_SB_DISKS; i++) {
> -				dev =3D devices[i];
> -				if (!dev)
> -					break;
> -				dinfo.major =3D MAJOR(dev);
> -				dinfo.minor =3D MINOR(dev);
> -				ksys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
> -			}
> +	} else {
> +		/* persistent */
> +		for (i =3D 0; i <=3D MD_SB_DISKS; i++) {
> +			dev =3D devices[i];
> +			if (!dev)
> +				break;
> +			dinfo.major =3D MAJOR(dev);
> +			dinfo.minor =3D MINOR(dev);
> +			ksys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
>  		}
> -		if (!err)
> -			err =3D ksys_ioctl(fd, RUN_ARRAY, 0);
> -		if (err)
> -			printk(KERN_WARNING "md: starting md%d failed\n", minor);
> -		ksys_close(fd);
>  	}
> +	if (!err)
> +		err =3D ksys_ioctl(fd, RUN_ARRAY, 0);
> +	if (err)
> +		printk(KERN_WARNING "md: starting md%d failed\n", minor);
> +	ksys_close(fd);
>  }
>=20=20
>  static int __init raid_setup(char *str)
> @@ -289,11 +284,15 @@ static void __init autodetect_raid(void)
>=20=20
>  void __init md_run_setup(void)
>  {
> +	int ent;
> +
>  	create_dev("/dev/md0", MKDEV(MD_MAJOR, 0));
>=20=20
>  	if (raid_noautodetect)
>  		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=3Da=
utodetect will force)\n");
>  	else
>  		autodetect_raid();
> -	md_setup_drive();
> +
> +	for (ent =3D 0; ent < md_setup_ents; ent++)
> +		md_setup_drive(&md_setup_args[ent]);
>  }
> --=20
> 2.27.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8Pk0UACgkQOeye3VZi
gbkfDA//eI1nE42ZAiYpzUXFdcDjZ59KiUeg/ojs36+7GhrrUBkb6yw0wkOvfRvH
kRyr33whc9l4JYX1CkPaCe2Yc0H2T7DgFTffXTAUZC7xqGyYz5X8Xun0zDEIp6JX
TC9fq3AG9gRywKGdvYuM1HBVUwdcd8bb2UUUYLHxf2qlTA6KvaWp/OTYc+lNTqz6
cP7Ttge5cU+4ShZM6jEF0rf1VjmErfP0oHMbr+QFj8YsR+AdVHn1iNGURcbTtMlU
KxFDuBIaW4qDDU9TV0wyRgdtQwksCYU9uJ0nX7wKDBMjcu1fuEGajtoY4ANWf73k
24c7NdvLYIb1+/G+hoW9unr3UNiUK9bAGpA3ueWCohUjQ/1wuoGLoJciKB5GlJcR
sLxUohA400j8x99VEitc8iW4EyNhCA8cf2azzQ+BjrwgOCzrjfaMOGG7NQ1wS3l0
CpobOfmPKaevVRuspudQspc+Q4LVDtB4B9Y2iZ0WkUhGrRwB0MnA5wgddk4MVs5U
H1v0YdazQsa0xNrMKeYexm/YAsspAhV1nV/cdmj+y/B8bO6M27nZF+k8QOeDLmQI
JKSj/+Nu9dZkJJXT/JLdiif8BX0nQwstpnRUk1kwAd3Y2P1hjSTagmXSMfrIAaFQ
EK8HV6aJbTjfGRM8B8KVVvSo5SC8vAwtQygUNwDmiacvzCLjcX8=
=eiAe
-----END PGP SIGNATURE-----
--=-=-=--
