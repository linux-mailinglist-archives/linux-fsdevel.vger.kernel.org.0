Return-Path: <linux-fsdevel+bounces-16220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E0A89A487
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8001F24936
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E8172BAD;
	Fri,  5 Apr 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="sCazVxU9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921717276C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343777; cv=none; b=cyDg0XKLU/O+Y7L5i7FTJwvjJqQKQgk74creqy0ekJswun68YSzZVo6VRgAlFBnmjtlD80mASdJk7l0POwE9wh2MITtiXJDnG3d/5lvfaTNelef87ceBj45wwVwhQhPMUBMoOLUUzZVlChrgtBU1BTb8DmeuOPRxKDyijB4l+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343777; c=relaxed/simple;
	bh=ZIAG9x/PcVSM2P5QOPPaLYLdPnZScPOYGt9HhU5grp0=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=is4hZMj294IFzRDhna99K6osmm52DUZh6EujdIJfn71lBDD7RFm9XI4wXS4u8jrXbudUSfMSlM15w6e20bLuA3lM8PBI5jxaoEGafTAJzlfJcjXNGcmM6B7OHC6BMrnSRWUlXzOrodOqp6fvtGZtIx8kxacuKIORdCtzsBZ6uMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=sCazVxU9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2987e9d06so21694955ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712343775; x=1712948575; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlcUCwwD/xs/pRLAcRjZyL1Yxttx0IjN1rmp8XoQaAs=;
        b=sCazVxU9ndU38AeHllkGYMie1dF/8i0Qhm6nkGUrej7dSgbAp5TKesehoh3tJqMg4Z
         2rVlAXTtCe/22oyPzgxrr7yJknZVtHt6xr97GhmID4Hhq9D5dEV8IefIjsqtiij2q6Wk
         L2hfyK5j5fnBY3+vSutadTRIvjb6lONw3NcgIaXWgpfxmgjWS2IityZDv34k8I2VIMwx
         NQSq+IvNzWIjkCYwou83dpMlhoxZp/a4zUMLT4mrwHpSrKRgWLltGOsd556bzIG85wd1
         SqZyDeYUi9Ew3OEUtPLKxBaHZRjpRIA8Hj/0zeacwTa90pYsoIFH5xDIqbh1r5RkPdZR
         9Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712343775; x=1712948575;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlcUCwwD/xs/pRLAcRjZyL1Yxttx0IjN1rmp8XoQaAs=;
        b=C2DSAMLm+pWQ1aVA4LopdFTRSsRlXlE/VzsugZdk6EgUJVZPtt8cAjFOwsnwTgwBhk
         3iAJ9vnIIW83vHN2NtiP0mjsvq0/qzsjDrzQ4sQ4TtVKcLDA9/uRujXv7Xuvo9FADT62
         i1iOnnTRpjkmZUP0xB1pMHrJV7opSQpcA1e7Y6Tf2hzc9qMfbcn9RgZB5hXeaElp0Fbw
         rrtcEdJ/Brj80CVf2SGVKm67nyItGe55M8kR8t2OBGWogSxiU92wG3gvBxmX60bqCKea
         jVQKz29Ke93SUNuvK8ezaxiXwKLSqs8Q42it4FXZp/8TDkFW2/zCRdMkn7CQjTf8U+1D
         n3yg==
X-Forwarded-Encrypted: i=1; AJvYcCX9x5qTVSaUve73WQvRdULEj0ZN+YBnLDJXMJSSQh695tC854Nkr7R48d4U/Hal56iKffqIIAKw07s/YYS1FZQ6abee9yKQtwsRD6iQqg==
X-Gm-Message-State: AOJu0Yw/SGmdOi/HUYktS3ZZQInZhyNIOSY6R4I/LbBIEY9rZ1o7lxEA
	w/wb2I+ozvzz7UkNmIamGCkiOxoqnMBzGD6EgVfBslzonLjy6/KGpg+YkdJ6IiM=
X-Google-Smtp-Source: AGHT+IGJMCGYULbsDAYpovKC/JRuJMvPOR950R3y2JFAFNPk2MltL2524efn8E4UUPVw2lf7G4g6lA==
X-Received: by 2002:a17:902:f389:b0:1e0:2bce:d7dc with SMTP id f9-20020a170902f38900b001e02bced7dcmr1792285ple.66.1712343774602;
        Fri, 05 Apr 2024 12:02:54 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001e27011a18csm1940272plw.134.2024.04.05.12.02.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 12:02:54 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <BDD29EBF-3A5F-4241-B9F2-789605D99817@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B18047D7-F546-4BB3-8288-3143CAF3C184";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 02/13] fiemap: update fiemap_fill_next_extent()
 signature
Date: Fri, 5 Apr 2024 13:05:01 -0600
In-Reply-To: <58f9c9eef8b0e33a8d46a3ad8a8db46890e1fbe8.1712126039.git.sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>,
 Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <58f9c9eef8b0e33a8d46a3ad8a8db46890e1fbe8.1712126039.git.sweettea-kernel@dorminy.me>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_B18047D7-F546-4BB3-8288-3143CAF3C184
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>=20
> Update the signature of fiemap_fill_next_extent() to allow passing a
> physical length. Update all callers to pass a 0 physical length -- =
since
> none set the EXTENT_HAS_PHYS_LEN flag, this value doesn't matter.

Patch-structure-wise, it doesn't make sense to me to change all of the =
callers
to pass "0" as the argument to this function, and then submit a whole =
series
of per-filesystem patches that sets only FIEMAP_EXTENT_HAS_PHYS_LEN (but =
also
passes phys_len =3D 0, which is wrong AFAICS).

A cleaner approach would be to rename the existing =
fiemap_fill_next_extent()
to fiemap_fill_next_extent_phys() that takes phys_len as an argument, =
and then
add a simple wrapper until all of the filesystems are updated:

#define fiemap_fill_next_extent(info, logical, phys, log_len, flags, =
dev) \
   fiemap_fill_next_extent_phys(info, logical, phys, log_len, 0, flags, =
dev)

Then the per-filesystem patches would involve changing over the callers =
to
use fiemap_fill_next_extent_phys() and setting =
FIEMAP_EXTENT_HAS_PHYS_LEN.


It would be possible in fiemap_fill_next_extent_phys() to add something =
like
the following in this patch that is adding the phys_len argument:

        if (phys_len =3D=3D 0 && !(flags & FIEMAP_EXTENT_HAS_PHYS_LEN)) =
{
                phys_len =3D log_len;
                flags |=3D FIEMAP_EXTENT_HAS_PHYS_LEN;
        }

which would immediately enable the fe_phyisical_length argument for all =
of
the callers.  This would reduce the chance of errors by the filesystems, =
or
avoid the need to change the filesystems at all unless they want to set
phys_len and log_len differently for compression.

Cheers, Andreas

>=20
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
> Documentation/filesystems/fiemap.rst | 3 ++-
> fs/bcachefs/fs.c                     | 7 ++++---
> fs/btrfs/extent_io.c                 | 4 ++--
> fs/ext4/extents.c                    | 1 +
> fs/f2fs/data.c                       | 8 +++++---
> fs/f2fs/inline.c                     | 3 ++-
> fs/ioctl.c                           | 9 +++++----
> fs/iomap/fiemap.c                    | 2 +-
> fs/nilfs2/inode.c                    | 6 +++---
> fs/ntfs3/frecord.c                   | 7 ++++---
> fs/ocfs2/extent_map.c                | 4 ++--
> fs/smb/client/smb2ops.c              | 1 +
> include/linux/fiemap.h               | 2 +-
> 13 files changed, 33 insertions(+), 24 deletions(-)
>=20
> diff --git a/Documentation/filesystems/fiemap.rst =
b/Documentation/filesystems/fiemap.rst
> index c2bfa107c8d7..c060bb83f5d8 100644
> --- a/Documentation/filesystems/fiemap.rst
> +++ b/Documentation/filesystems/fiemap.rst
> @@ -236,7 +236,8 @@ For each extent in the request range, the file =
system should call
> the helper function, fiemap_fill_next_extent()::
>=20
>   int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 =
logical,
> -			      u64 phys, u64 len, u32 flags, u32 dev);
> +			      u64 phys, u64 log_len, u64 phys_len, u32 =
flags,
> +                              u32 dev);
>=20
> fiemap_fill_next_extent() will use the passed values to populate the
> next free extent in the fm_extents array. 'General' extent flags will
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 71013256fc39..f830578a9cd1 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -931,7 +931,8 @@ static int bch2_fill_extent(struct bch_fs *c,
> 			ret =3D fiemap_fill_next_extent(info,
> 						bkey_start_offset(k.k) =
<< 9,
> 						offset << 9,
> -						k.k->size << 9, =
flags|flags2);
> +						k.k->size << 9, 0,
> +						flags|flags2);
> 			if (ret)
> 				return ret;
> 		}
> @@ -940,13 +941,13 @@ static int bch2_fill_extent(struct bch_fs *c,
> 	} else if (bkey_extent_is_inline_data(k.k)) {
> 		return fiemap_fill_next_extent(info,
> 					       bkey_start_offset(k.k) << =
9,
> -					       0, k.k->size << 9,
> +					       0, k.k->size << 9, 0,
> 					       flags|
> 					       =
FIEMAP_EXTENT_DATA_INLINE);
> 	} else if (k.k->type =3D=3D KEY_TYPE_reservation) {
> 		return fiemap_fill_next_extent(info,
> 					       bkey_start_offset(k.k) << =
9,
> -					       0, k.k->size << 9,
> +					       0, k.k->size << 9, 0,
> 					       flags|
> 					       FIEMAP_EXTENT_DELALLOC|
> 					       FIEMAP_EXTENT_UNWRITTEN);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index eceef5ff780b..9e421d99fd5c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2577,7 +2577,7 @@ static int flush_fiemap_cache(struct =
fiemap_extent_info *fieinfo,
> 		int ret;
>=20
> 		ret =3D fiemap_fill_next_extent(fieinfo, entry->offset,
> -					      entry->phys, entry->len,
> +					      entry->phys, entry->len, =
0,
> 					      entry->flags);
> 		/*
> 		 * Ignore 1 (reached max entries) because we keep track =
of that
> @@ -2793,7 +2793,7 @@ static int emit_last_fiemap_cache(struct =
fiemap_extent_info *fieinfo,
> 		return 0;
>=20
> 	ret =3D fiemap_fill_next_extent(fieinfo, cache->offset, =
cache->phys,
> -				      cache->len, cache->flags);
> +				      cache->len, 0, cache->flags);
> 	cache->cached =3D false;
> 	if (ret > 0)
> 		ret =3D 0;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e57054bdc5fd..2adade3c202a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2215,6 +2215,7 @@ static int ext4_fill_es_cache_info(struct inode =
*inode,
> 				(__u64)es.es_lblk << blksize_bits,
> 				(__u64)es.es_pblk << blksize_bits,
> 				(__u64)es.es_len << blksize_bits,
> +				0,
> 				flags);
> 		if (next =3D=3D 0)
> 			break;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d9494b5fc7c1..87f8d828e038 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1834,7 +1834,8 @@ static int f2fs_xattr_fiemap(struct inode =
*inode,
> 		if (!xnid)
> 			flags |=3D FIEMAP_EXTENT_LAST;
>=20
> -		err =3D fiemap_fill_next_extent(fieinfo, 0, phys, len, =
flags);
> +		err =3D fiemap_fill_next_extent(
> +				fieinfo, 0, phys, len, 0, flags);
> 		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
> 		if (err)
> 			return err;
> @@ -1860,7 +1861,8 @@ static int f2fs_xattr_fiemap(struct inode =
*inode,
> 	}
>=20
> 	if (phys) {
> -		err =3D fiemap_fill_next_extent(fieinfo, 0, phys, len, =
flags);
> +		err =3D fiemap_fill_next_extent(
> +				fieinfo, 0, phys, len, 0, flags);
> 		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
> 	}
>=20
> @@ -1979,7 +1981,7 @@ int f2fs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> 			flags |=3D FIEMAP_EXTENT_DATA_ENCRYPTED;
>=20
> 		ret =3D fiemap_fill_next_extent(fieinfo, logical,
> -				phys, size, flags);
> +				phys, size, 0, flags);
> 		trace_f2fs_fiemap(inode, logical, phys, size, flags, =
ret);
> 		if (ret)
> 			goto out;
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index ac00423f117b..49d2f87fe048 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -806,7 +806,8 @@ int f2fs_inline_data_fiemap(struct inode *inode,
> 	byteaddr =3D (__u64)ni.blk_addr << =
inode->i_sb->s_blocksize_bits;
> 	byteaddr +=3D (char *)inline_data_addr(inode, ipage) -
> 					(char *)F2FS_INODE(ipage);
> -	err =3D fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, =
flags);
> +	err =3D fiemap_fill_next_extent(
> +			fieinfo, start, byteaddr, ilen, 0, flags);
> 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
> out:
> 	f2fs_put_page(ipage, 1);
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 8afd32e1a27a..1830baca532b 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -99,7 +99,8 @@ static int ioctl_fibmap(struct file *filp, int =
__user *p)
>  * @fieinfo:	Fiemap context passed into ->fiemap
>  * @logical:	Extent logical start offset, in bytes
>  * @phys:	Extent physical start offset, in bytes
> - * @len:	Extent length, in bytes
> + * @log_len:	Extent logical length, in bytes
> + * @phys_len:	Extent physical length, in bytes (optional)
>  * @flags:	FIEMAP_EXTENT flags that describe this extent
>  *
>  * Called from file system ->fiemap callback. Will populate extent
> @@ -110,7 +111,7 @@ static int ioctl_fibmap(struct file *filp, int =
__user *p)
>  * extent that will fit in user array.
>  */
> int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 =
logical,
> -			    u64 phys, u64 len, u32 flags)
> +			    u64 phys, u64 log_len, u64 phys_len, u32 =
flags)
> {
> 	struct fiemap_extent extent;
> 	struct fiemap_extent __user *dest =3D fieinfo->fi_extents_start;
> @@ -138,8 +139,8 @@ int fiemap_fill_next_extent(struct =
fiemap_extent_info *fieinfo, u64 logical,
> 	memset(&extent, 0, sizeof(extent));
> 	extent.fe_logical =3D logical;
> 	extent.fe_physical =3D phys;
> -	extent.fe_logical_length =3D len;
> -	extent.fe_physical_length =3D len;
> +	extent.fe_logical_length =3D log_len;
> +	extent.fe_physical_length =3D phys_len;
> 	extent.fe_flags =3D flags;
>=20
> 	dest +=3D fieinfo->fi_extents_mapped;
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 610ca6f1ec9b..013e843c8d10 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -36,7 +36,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info =
*fi,
>=20
> 	return fiemap_fill_next_extent(fi, iomap->offset,
> 			iomap->addr !=3D IOMAP_NULL_ADDR ? iomap->addr : =
0,
> -			iomap->length, flags);
> +			iomap->length, 0, flags);
> }
>=20
> static loff_t iomap_fiemap_iter(const struct iomap_iter *iter,
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 7340a01d80e1..4d3c347c982b 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1190,7 +1190,7 @@ int nilfs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> 			if (size) {
> 				/* End of the current extent */
> 				ret =3D fiemap_fill_next_extent(
> -					fieinfo, logical, phys, size, =
flags);
> +					fieinfo, logical, phys, size, 0, =
flags);
> 				if (ret)
> 					break;
> 			}
> @@ -1240,7 +1240,7 @@ int nilfs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> 					flags |=3D FIEMAP_EXTENT_LAST;
>=20
> 				ret =3D fiemap_fill_next_extent(
> -					fieinfo, logical, phys, size, =
flags);
> +					fieinfo, logical, phys, size, 0, =
flags);
> 				if (ret)
> 					break;
> 				size =3D 0;
> @@ -1256,7 +1256,7 @@ int nilfs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> 					/* Terminate the current extent =
*/
> 					ret =3D fiemap_fill_next_extent(
> 						fieinfo, logical, phys, =
size,
> -						flags);
> +						0, flags);
> 					if (ret || blkoff > end_blkoff)
> 						break;
>=20
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 7f27382e0ce2..ef0ed913428b 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -1947,7 +1947,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct =
fiemap_extent_info *fieinfo,
> 	if (!attr || !attr->non_res) {
> 		err =3D fiemap_fill_next_extent(
> 			fieinfo, 0, 0,
> -			attr ? le32_to_cpu(attr->res.data_size) : 0,
> +			attr ? le32_to_cpu(attr->res.data_size) : 0, 0,
> 			FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST |
> 				FIEMAP_EXTENT_MERGED);
> 		goto out;
> @@ -2042,7 +2042,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct =
fiemap_extent_info *fieinfo,
> 				flags |=3D FIEMAP_EXTENT_LAST;
>=20
> 			err =3D fiemap_fill_next_extent(fieinfo, vbo, =
lbo, dlen,
> -						      flags);
> +						      0, flags);
> 			if (err < 0)
> 				break;
> 			if (err =3D=3D 1) {
> @@ -2062,7 +2062,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct =
fiemap_extent_info *fieinfo,
> 		if (vbo + bytes >=3D end)
> 			flags |=3D FIEMAP_EXTENT_LAST;
>=20
> -		err =3D fiemap_fill_next_extent(fieinfo, vbo, lbo, =
bytes, flags);
> +		err =3D fiemap_fill_next_extent(fieinfo, vbo, lbo, =
bytes, 0,
> +					      flags);
> 		if (err < 0)
> 			break;
> 		if (err =3D=3D 1) {
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 70a768b623cf..eabdf97cd685 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -723,7 +723,7 @@ static int ocfs2_fiemap_inline(struct inode =
*inode, struct buffer_head *di_bh,
> 					 id2.i_data.id_data);
>=20
> 		ret =3D fiemap_fill_next_extent(fieinfo, 0, phys, =
id_count,
> -					      flags);
> +					      0, flags);
> 		if (ret < 0)
> 			return ret;
> 	}
> @@ -794,7 +794,7 @@ int ocfs2_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> 		virt_bytes =3D (u64)le32_to_cpu(rec.e_cpos) << =
osb->s_clustersize_bits;
>=20
> 		ret =3D fiemap_fill_next_extent(fieinfo, virt_bytes, =
phys_bytes,
> -					      len_bytes, fe_flags);
> +					      len_bytes, 0, fe_flags);
> 		if (ret)
> 			break;
>=20
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 87b63f6ad2e2..23a193512f96 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3779,6 +3779,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
> 				le64_to_cpu(out_data[i].file_offset),
> 				le64_to_cpu(out_data[i].file_offset),
> 				le64_to_cpu(out_data[i].length),
> +				0,
> 				flags);
> 		if (rc < 0)
> 			goto out;
> diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
> index c50882f19235..17a6c32cdf3f 100644
> --- a/include/linux/fiemap.h
> +++ b/include/linux/fiemap.h
> @@ -16,6 +16,6 @@ struct fiemap_extent_info {
> int fiemap_prep(struct inode *inode, struct fiemap_extent_info =
*fieinfo,
> 		u64 start, u64 *len, u32 supported_flags);
> int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 =
logical,
> -			    u64 phys, u64 len, u32 flags);
> +			    u64 phys, u64 log_len, u64 phys_len, u32 =
flags);
>=20
> #endif /* _LINUX_FIEMAP_H 1 */
> --
> 2.43.0
>=20
>=20


Cheers, Andreas






--Apple-Mail=_B18047D7-F546-4BB3-8288-3143CAF3C184
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQS10ACgkQcqXauRfM
H+DZLxAAlJo/2IlGKAQFhRORGteq1SC3CeTXMaw8zigT87v3L/nSocfglYY1IEBA
7rfwHBBBNU5M948fSD9ltzMn/yTHO3FcucB3pHPVZ4AvKaz0PgsKIg61Qku83Ypx
FdRD9YXWAv5mpYfeABRrUoUGPkxMxAha/IK2BKE9zg6WxlK2CHPUtsPCgDT9eMdw
Qmdmau6v2sDn4sYTzB7TyCBx+4NrTxWQNRP3BTVSN1VKYbguVim0Qvuaw+Soq1zB
JR7inoHDjLZ2oDIxa0AUroTQO8vAWAGNy1868pdRCa4bthXDRJjQhDXZmRnn7PWP
yGavQddXPpUKqb0bGJXgrU6pAgeUdquLvChcQcRR0I37EChMZwlxN2YqCk+qFkhC
iSv5awLT72KNf+i1o3HM3Hn/+ztdtyTJpRVW9P4bxgeWRPlQYKFr8UPjXljAcTIv
jU8+c6JXGcuiFdfScFCoVW2sA4+EgF+QyqtghubPs9IVHxteJwll+9cPddIHI//8
SRgo65RFc811yGAdoLv0pEISrjTLG0kDTjoiXFXMwE60dB0gz9lbdmqkBr6DJkJE
bzyMxwGml6sdOUHJtm0Z84SDsOpRcyRvr1pHu7HyQ6bq4uE2eJqR7SwLyhKYaREX
DeTkbswx8/UaHADZ7SKxuRXJlWg1jfPc3zlznyCXDJlci8XCj/I=
=vehB
-----END PGP SIGNATURE-----

--Apple-Mail=_B18047D7-F546-4BB3-8288-3143CAF3C184--

