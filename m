Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F2012C0A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 06:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfL2F2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 00:28:19 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38926 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfL2F2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 00:28:18 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Dec 2019 00:28:18 EST
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4E862546552; Sun, 29 Dec 2019 00:22:40 -0500 (EST)
Date:   Sun, 29 Dec 2019 00:22:40 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     fdmanana@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, darrick.wong@oracle.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] Btrfs: make deduplication with range including the
 last block work
Message-ID: <20191229052240.GG13306@hungrycats.org>
References: <20191216182656.15624-1-fdmanana@kernel.org>
 <20191216182656.15624-3-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
In-Reply-To: <20191216182656.15624-3-fdmanana@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 06:26:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Since btrfs was migrated to use the generic VFS helpers for clone and
> deduplication, it stopped allowing for the last block of a file to be
> deduplicated when the source file size is not sector size aligned (when
> eof is somewhere in the middle of the last block). There are two reasons
> for that:
>=20
> 1) The generic code always rounds down, to a multiple of the block size,
>    the range's length for deduplications. This means we end up never
>    deduplicating the last block when the eof is not block size aligned,
>    even for the safe case where the destination range's end offset matches
>    the destination file's size. That rounding down operation is done at
>    generic_remap_check_len();
>=20
> 2) Because of that, the btrfs specific code does not expect anymore any
>    non-aligned range length's for deduplication and therefore does not
>    work if such nona-aligned length is given.
>=20
> This patch addresses that second part, and it depends on a patch that
> fixes generic_remap_check_len(), in the VFS, which was submitted ealier
> and has the following subject:
>=20
>   "fs: allow deduplication of eof block into the end of the destination f=
ile"
>=20
> These two patches address reports from users that started seeing lower
> deduplication rates due to the last block never being deduplicated when
> the file size is not aligned to the filesystem's block size.
>=20
> Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5d=
q.dFFD/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Should these patches be marked for stable (5.0+, but see below for
caveats about 5.0)?  The bug affects 5.3 and 5.4 which are still active,
and dedupe is an important feature for some users.

> ---
>  fs/btrfs/ioctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 3418decb9e61..c41c276ff272 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3237,6 +3237,7 @@ static void btrfs_double_extent_lock(struct inode *=
inode1, u64 loff1,
>  static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
>  				   struct inode *dst, u64 dst_loff)
>  {
> +	const u64 bs =3D BTRFS_I(src)->root->fs_info->sb->s_blocksize;
>  	int ret;
> =20
>  	/*
> @@ -3244,7 +3245,7 @@ static int btrfs_extent_same_range(struct inode *sr=
c, u64 loff, u64 len,
>  	 * source range to serialize with relocation.
>  	 */
>  	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
> -	ret =3D btrfs_clone(src, dst, loff, len, len, dst_loff, 1);
> +	ret =3D btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);

A heads-up for anyone backporting this to 5.0:  this patch depends on

	57a50e2506df Btrfs: remove no longer needed range length checks for dedupl=
ication

Simply resolving the git conflict without including 57a50e2506df produces
a kernel where dedupe rounds the size of the dst file up to the next
block boundary.  This is because 57a50e2506df changes the value of
"len".  Before 57a50e2506df, "len" is equivalent to "ALIGN(len, bs)"
at the btrfs_clone line; after 57a50e2506df, "len" is the unaligned
dedupe request length passed to the btrfs_extent_same_range function.
This changes the semantics of the btrfs_clone line significantly.

57a50e2506df is in 5.1, so 5.1+ kernels do not require any additional
patches.

4.20 and earlier don't have the bug, so don't need a fix.

>  	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
> =20
>  	return ret;
> --=20
> 2.11.0
>=20

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXgg4IAAKCRCB+YsaVrMb
nFY0AJ0fIi9yEzH1FwUObJW7SQl3uNevCACeIca5z3SPIG29//ckhcA5JgBwf8Y=
=cmLe
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
