Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A979122189E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGOXvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 19:51:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:53352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGOXvD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:51:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2C66AC37;
        Wed, 15 Jul 2020 23:50:59 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jul 2020 09:50:49 +1000
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/23] md: rewrite md_setup_drive to avoid ioctls
In-Reply-To: <20200714190427.4332-10-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-10-hch@lst.de>
Message-ID: <87365sxrqe.fsf@notabene.neil.brown.name>
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

> md_setup_drive knows it works with md devices, so it is rather pointless
> to open a file descriptor and issue ioctls.  Just call directly into the
> relevant low-level md routines after getting a handle to the device using
> blkdev_get_by_dev instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  drivers/md/md-autodetect.c | 127 ++++++++++++++++---------------------
>  drivers/md/md.c            |  20 +++---
>  drivers/md/md.h            |   6 ++
>  3 files changed, 71 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
> index a43a8f1580584c..5b24b5616d3acc 100644
> --- a/drivers/md/md-autodetect.c
> +++ b/drivers/md/md-autodetect.c
> @@ -2,7 +2,6 @@
>  #include <linux/kernel.h>
>  #include <linux/blkdev.h>
>  #include <linux/init.h>
> -#include <linux/syscalls.h>
>  #include <linux/mount.h>
>  #include <linux/major.h>
>  #include <linux/delay.h>
> @@ -120,37 +119,29 @@ static int __init md_setup(char *str)
>  	return 1;
>  }
>=20=20
> -static inline int create_dev(char *name, dev_t dev)
> -{
> -	ksys_unlink(name);
> -	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
> -}
> -
>  static void __init md_setup_drive(struct md_setup_args *args)
>  {
> -	int minor, i, partitioned;
> -	dev_t dev;
> -	dev_t devices[MD_SB_DISKS+1];
> -	int fd;
> -	int err =3D 0;
> -	char *devname;
> -	mdu_disk_info_t dinfo;
> +	char *devname =3D args->device_names;
> +	dev_t devices[MD_SB_DISKS + 1], mdev;
> +	struct mdu_array_info_s ainfo =3D { };
> +	struct block_device *bdev;
> +	struct mddev *mddev;
> +	int err =3D 0, i;
>  	char name[16];
>=20=20
> -	minor =3D args->minor;
> -	partitioned =3D args->partitioned;
> -	devname =3D args->device_names;
> +	if (args->partitioned) {
> +		mdev =3D MKDEV(mdp_major, args->minor << MdpMinorShift);
> +		sprintf(name, "md_d%d", args->minor);
> +	} else {
> +		mdev =3D MKDEV(MD_MAJOR, args->minor);
> +		sprintf(name, "md%d", args->minor);
> +	}
>=20=20
> -	sprintf(name, "/dev/md%s%d", partitioned?"_d":"", minor);
> -	if (partitioned)
> -		dev =3D MKDEV(mdp_major, minor << MdpMinorShift);
> -	else
> -		dev =3D MKDEV(MD_MAJOR, minor);
> -	create_dev(name, dev);
>  	for (i =3D 0; i < MD_SB_DISKS && devname !=3D NULL; i++) {
>  		struct kstat stat;
>  		char *p;
>  		char comp_name[64];
> +		dev_t dev;
>=20=20
>  		p =3D strchr(devname, ',');
>  		if (p)
> @@ -163,7 +154,7 @@ static void __init md_setup_drive(struct md_setup_arg=
s *args)
>  		if (vfs_stat(comp_name, &stat) =3D=3D 0 && S_ISBLK(stat.mode))
>  			dev =3D new_decode_dev(stat.rdev);
>  		if (!dev) {
> -			printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
> +			pr_warn("md: Unknown device name: %s\n", devname);
>  			break;
>  		}
>=20=20
> @@ -175,68 +166,64 @@ static void __init md_setup_drive(struct md_setup_a=
rgs *args)
>  	if (!i)
>  		return;
>=20=20
> -	printk(KERN_INFO "md: Loading md%s%d: %s\n",
> -		partitioned ? "_d" : "", minor,
> -		args->device_names);
> +	pr_info("md: Loading %s: %s\n", name, args->device_names);
>=20=20
> -	fd =3D ksys_open(name, 0, 0);
> -	if (fd < 0) {
> -		printk(KERN_ERR "md: open failed - cannot start "
> -				"array %s\n", name);
> +	bdev =3D blkdev_get_by_dev(mdev, FMODE_READ, NULL);
> +	if (IS_ERR(bdev)) {
> +		pr_err("md: open failed - cannot start array %s\n", name);
>  		return;
>  	}
> -	if (ksys_ioctl(fd, SET_ARRAY_INFO, 0) =3D=3D -EBUSY) {
> -		printk(KERN_WARNING
> -		       "md: Ignoring md=3D%d, already autodetected. (Use raid=3Dnoauto=
detect)\n",
> -		       minor);
> -		ksys_close(fd);
> -		return;

I'd be more comfortable if you added something like
	if (WARN(bdev->bd_disk->fops !=3D md_fops,
                 "Opening block device %x resulted in non-md device\"))
                return;
here.  However even without that

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> +	mddev =3D bdev->bd_disk->private_data;
> +
> +	err =3D mddev_lock(mddev);
> +	if (err) {
> +		pr_err("md: failed to lock array %s\n", name);
> +		goto out_blkdev_put;
> +	}
> +
> +	if (!list_empty(&mddev->disks) || mddev->raid_disks) {
> +		pr_warn("md: Ignoring %s, already autodetected. (Use raid=3Dnoautodete=
ct)\n",
> +		       name);
> +		goto out_unlock;
>  	}
>=20=20
>  	if (args->level !=3D LEVEL_NONE) {
>  		/* non-persistent */
> -		mdu_array_info_t ainfo;
>  		ainfo.level =3D args->level;
> -		ainfo.size =3D 0;
> -		ainfo.nr_disks =3D0;
> -		ainfo.raid_disks =3D0;
> -		while (devices[ainfo.raid_disks])
> -			ainfo.raid_disks++;
> -		ainfo.md_minor =3Dminor;
> +		ainfo.md_minor =3D args->minor;
>  		ainfo.not_persistent =3D 1;
> -
>  		ainfo.state =3D (1 << MD_SB_CLEAN);
> -		ainfo.layout =3D 0;
>  		ainfo.chunk_size =3D args->chunk;
> -		err =3D ksys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
> -		for (i =3D 0; !err && i <=3D MD_SB_DISKS; i++) {
> -			dev =3D devices[i];
> -			if (!dev)
> -				break;
> +		while (devices[ainfo.raid_disks])
> +			ainfo.raid_disks++;
> +	}
> +
> +	err =3D md_set_array_info(mddev, &ainfo);
> +
> +	for (i =3D 0; i <=3D MD_SB_DISKS && devices[i]; i++) {
> +		struct mdu_disk_info_s dinfo =3D {
> +			.major	=3D MAJOR(devices[i]),
> +			.minor	=3D MINOR(devices[i]),
> +		};
> +
> +		if (args->level !=3D LEVEL_NONE) {
>  			dinfo.number =3D i;
>  			dinfo.raid_disk =3D i;
> -			dinfo.state =3D (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
> -			dinfo.major =3D MAJOR(dev);
> -			dinfo.minor =3D MINOR(dev);
> -			err =3D ksys_ioctl(fd, ADD_NEW_DISK,
> -					 (long)&dinfo);
> -		}
> -	} else {
> -		/* persistent */
> -		for (i =3D 0; i <=3D MD_SB_DISKS; i++) {
> -			dev =3D devices[i];
> -			if (!dev)
> -				break;
> -			dinfo.major =3D MAJOR(dev);
> -			dinfo.minor =3D MINOR(dev);
> -			ksys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
> +			dinfo.state =3D
> +				(1 << MD_DISK_ACTIVE) | (1 << MD_DISK_SYNC);
>  		}
> +
> +		md_add_new_disk(mddev, &dinfo);
>  	}
> +
>  	if (!err)
> -		err =3D ksys_ioctl(fd, RUN_ARRAY, 0);
> +		err =3D do_md_run(mddev);
>  	if (err)
> -		printk(KERN_WARNING "md: starting md%d failed\n", minor);
> -	ksys_close(fd);
> +		pr_warn("md: starting %s failed\n", name);
> +out_unlock:
> +	mddev_unlock(mddev);
> +out_blkdev_put:
> +	blkdev_put(bdev, FMODE_READ);
>  }
>=20=20
>  static int __init raid_setup(char *str)
> @@ -286,8 +273,6 @@ void __init md_run_setup(void)
>  {
>  	int ent;
>=20=20
> -	create_dev("/dev/md0", MKDEV(MD_MAJOR, 0));
> -
>  	if (raid_noautodetect)
>  		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=3Da=
utodetect will force)\n");
>  	else
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6e9a48da474848..9960cfeb59a50c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4368,7 +4368,6 @@ array_state_show(struct mddev *mddev, char *page)
>=20=20
>  static int do_md_stop(struct mddev *mddev, int ro, struct block_device *=
bdev);
>  static int md_set_readonly(struct mddev *mddev, struct block_device *bde=
v);
> -static int do_md_run(struct mddev *mddev);
>  static int restart_array(struct mddev *mddev);
>=20=20
>  static ssize_t
> @@ -6015,7 +6014,7 @@ int md_run(struct mddev *mddev)
>  }
>  EXPORT_SYMBOL_GPL(md_run);
>=20=20
> -static int do_md_run(struct mddev *mddev)
> +int do_md_run(struct mddev *mddev)
>  {
>  	int err;
>=20=20
> @@ -6651,7 +6650,7 @@ static int get_disk_info(struct mddev *mddev, void =
__user * arg)
>  	return 0;
>  }
>=20=20
> -static int add_new_disk(struct mddev *mddev, mdu_disk_info_t *info)
> +int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
>  {
>  	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>  	struct md_rdev *rdev;
> @@ -6697,7 +6696,7 @@ static int add_new_disk(struct mddev *mddev, mdu_di=
sk_info_t *info)
>  	}
>=20=20
>  	/*
> -	 * add_new_disk can be used once the array is assembled
> +	 * md_add_new_disk can be used once the array is assembled
>  	 * to add "hot spares".  They must already have a superblock
>  	 * written
>  	 */
> @@ -6810,7 +6809,7 @@ static int add_new_disk(struct mddev *mddev, mdu_di=
sk_info_t *info)
>  		return err;
>  	}
>=20=20
> -	/* otherwise, add_new_disk is only allowed
> +	/* otherwise, md_add_new_disk is only allowed
>  	 * for major_version=3D=3D0 superblocks
>  	 */
>  	if (mddev->major_version !=3D 0) {
> @@ -7055,7 +7054,7 @@ static int set_bitmap_file(struct mddev *mddev, int=
 fd)
>  }
>=20=20
>  /*
> - * set_array_info is used two different ways
> + * md_set_array_info is used two different ways
>   * The original usage is when creating a new array.
>   * In this usage, raid_disks is > 0 and it together with
>   *  level, size, not_persistent,layout,chunksize determine the
> @@ -7067,9 +7066,8 @@ static int set_bitmap_file(struct mddev *mddev, int=
 fd)
>   *  The minor and patch _version numbers are also kept incase the
>   *  super_block handler wishes to interpret them.
>   */
> -static int set_array_info(struct mddev *mddev, mdu_array_info_t *info)
> +int md_set_array_info(struct mddev *mddev, struct mdu_array_info_s *info)
>  {
> -
>  	if (info->raid_disks =3D=3D 0) {
>  		/* just setting version number for superblock loading */
>  		if (info->major_version < 0 ||
> @@ -7560,7 +7558,7 @@ static int md_ioctl(struct block_device *bdev, fmod=
e_t mode,
>  			err =3D -EBUSY;
>  			goto unlock;
>  		}
> -		err =3D set_array_info(mddev, &info);
> +		err =3D md_set_array_info(mddev, &info);
>  		if (err) {
>  			pr_warn("md: couldn't set array info. %d\n", err);
>  			goto unlock;
> @@ -7614,7 +7612,7 @@ static int md_ioctl(struct block_device *bdev, fmod=
e_t mode,
>  				/* Need to clear read-only for this */
>  				break;
>  			else
> -				err =3D add_new_disk(mddev, &info);
> +				err =3D md_add_new_disk(mddev, &info);
>  			goto unlock;
>  		}
>  		break;
> @@ -7682,7 +7680,7 @@ static int md_ioctl(struct block_device *bdev, fmod=
e_t mode,
>  		if (copy_from_user(&info, argp, sizeof(info)))
>  			err =3D -EFAULT;
>  		else
> -			err =3D add_new_disk(mddev, &info);
> +			err =3D md_add_new_disk(mddev, &info);
>  		goto unlock;
>  	}
>=20=20
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 6f8fff77ce10a5..7ee81aa2eac862 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -801,7 +801,13 @@ static inline void mddev_check_write_zeroes(struct m=
ddev *mddev, struct bio *bio
>  		mddev->queue->limits.max_write_zeroes_sectors =3D 0;
>  }
>=20=20
> +struct mdu_array_info_s;
> +struct mdu_disk_info_s;
> +
>  extern int mdp_major;
>  void md_autostart_arrays(int part);
> +int md_set_array_info(struct mddev *mddev, struct mdu_array_info_s *info=
);
> +int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info);
> +int do_md_run(struct mddev *mddev);
>=20=20
>  #endif /* _MD_MD_H */
> --=20
> 2.27.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8PllkACgkQOeye3VZi
gblpCg//Y3mGVscw9giutzGjsI/GWiOtxrJda5+l/LnqsnN32w+YCMW99gk1UEOF
E0xl0nOmj7H333nr6slpP6aMspvSt1unkv7Pd1XsnGM0nQGpuvIBXnErK8vLJoYL
wITl9XIgG51xUI52LWe+F/ksrQz0jqUljYfqEoAtYZSaQpLn+ukyM098d8qXV9Sa
yFtinpRlLaDQqz7Gzh029IGnHjtF0HFJhbzRPpJeOFs3tC7QiegcZCM1GGmX1qHj
EpdLliWiQxP6m33JIZf9EIgE56SWNwi62O0FJiOqjGpF5HRb1LLlFGzQA+loLFdG
fdAfyQ82D1x8CXdrmchyVxb4BYqB3jHiXiuwJqc6Ot7LwI/o8zkH5dRuxcWtTKq0
JGU/1FLdb/yXNX7DbrND/BP0j//1Ht54cCzAmC2FWgxPBveQ9Rlqn7UQF5NTQpWT
RwdeCYOsncAgb3gScEDuZfH1J4DVnub9bSYlGZGbrO4ALF+qO4lagFiOpRXlt/OO
eeQqkhr3gMViuCntk/gWcID4fotjn8hftLPJPziwCfUx4BAg6AU4JyGjFQlmfavA
3ARNdMUfhPksbT4CxL7ks7gIMEuDmFSOFhpEHbI3nOjjxJGKegUaDS/1Kyj/792Q
igbbT8CnJ2z4jQOn23nVbj9sB6LciBnNEpzVJ7FMtQXevygSL8k=
=7Xpw
-----END PGP SIGNATURE-----
--=-=-=--
