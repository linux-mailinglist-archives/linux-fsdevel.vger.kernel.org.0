Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030FC2E03D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 02:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLVBYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 20:24:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:42076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgLVBYB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:24:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3206AAC7B;
        Tue, 22 Dec 2020 01:23:19 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Tue, 22 Dec 2020 12:23:11 +1100
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 1/3] vfs: Do not ignore return code from s_op->sync_fs
In-Reply-To: <20201221195055.35295-2-vgoyal@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-2-vgoyal@redhat.com>
Message-ID: <878s9qmy68.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 21 2020, Vivek Goyal wrote:

> Current implementation of __sync_filesystem() ignores the
> return code from ->sync_fs(). I am not sure why that's the case.
>
> Ignoring ->sync_fs() return code is problematic for overlayfs where
> it can return error if sync_filesystem() on upper super block failed.
> That error will simply be lost and sycnfs(overlay_fd), will get
> success (despite the fact it failed).
>
> Al Viro noticed that there are other filesystems which can sometimes
> return error in ->sync_fs() and these errors will be ignored too.
>
> fs/btrfs/super.c:2412:  .sync_fs        =3D btrfs_sync_fs,
> fs/exfat/super.c:204:   .sync_fs        =3D exfat_sync_fs,
> fs/ext4/super.c:1674:   .sync_fs        =3D ext4_sync_fs,
> fs/f2fs/super.c:2480:   .sync_fs        =3D f2fs_sync_fs,
> fs/gfs2/super.c:1600:   .sync_fs                =3D gfs2_sync_fs,
> fs/hfsplus/super.c:368: .sync_fs        =3D hfsplus_sync_fs,
> fs/nilfs2/super.c:689:  .sync_fs        =3D nilfs_sync_fs,
> fs/ocfs2/super.c:139:   .sync_fs        =3D ocfs2_sync_fs,
> fs/overlayfs/super.c:399:	.sync_fs        =3D ovl_sync_fs,
> fs/ubifs/super.c:2052:  .sync_fs       =3D ubifs_sync_fs,
>
> Hence, this patch tries to fix it and capture error returned
> by ->sync_fs() and return to caller. I am specifically interested
> in syncfs() path and return error to user.
>
> I am assuming that we want to continue to call __sync_blockdev()
> despite the fact that there have been errors reported from
> ->sync_fs(). So this patch continues to call __sync_blockdev()
> even if ->sync_fs() returns an error.
>
> Al noticed that there are few other callsites where ->sync_fs() error
> code is being ignored.
>
> sync_fs_one_sb(): For this it seems desirable to ignore the return code.
>
> dquot_disable(): Jan Kara mentioned that ignoring return code here is fine
> 		 because we don't want to fail dquot_disable() just beacuse
> 		 caches might be incoherent.
>
> dquot_quota_sync(): Jan thinks that it might make some sense to capture
> 		    return code here. But I am leaving it untouched for
> 		   now. When somebody needs it, they can easily fix it.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/sync.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/sync.c b/fs/sync.c
> index 1373a610dc78..b5fb83a734cd 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -30,14 +30,18 @@
>   */
>  static int __sync_filesystem(struct super_block *sb, int wait)
>  {
> +	int ret, ret2;
> +
>  	if (wait)
>  		sync_inodes_sb(sb);
>  	else
>  		writeback_inodes_sb(sb, WB_REASON_SYNC);
>=20=20
>  	if (sb->s_op->sync_fs)
> -		sb->s_op->sync_fs(sb, wait);
> -	return __sync_blockdev(sb->s_bdev, wait);
> +		ret =3D sb->s_op->sync_fs(sb, wait);
> +	ret2 =3D __sync_blockdev(sb->s_bdev, wait);
> +
> +	return ret ? ret : ret2;

I'm surprised that the compiler didn't complain that 'ret' might be used
uninitialized.

NeilBrown

>  }
>=20=20
>  /*
> --=20
> 2.25.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl/hSn8OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnsaA//YWWMsKDY6jkZLXCd9xREfvs97olNMgHgIUde
0YHq8em987RQMOrwYSbVo6vfZs+RkrfhxmubpHZ6fMBqrZCwiyLYAyJi3uRQrb6B
50L7MbaCZq0SGq/wvvFTEVdNILo5wNPfPc5Huo1mlrv//TCTmYo/rBhBKT10/08z
TifQq6eJhgnJHrOlI/9mc8ku/ODlQoXDAwY4XcEyyTcZ+ntbG4F1oV7v5NqZ45r3
F4jIhUyNtfghAHwmmW+gnkKbVBKd2TiWoe1EaCpAXLtdJY6GLdbv02HDqbZfKcrw
urhT1mj9YmIH3/y2TqFq6WSTfZYRu51Dn8oNoPKVcP+3SOq/t11FAjPRE4IfAKWQ
bT9bEa142joXdTduNaWWmUos69Fk3JAv7UJfGhzS0pCOEIU4ai8TjeJ4R2njKeup
pFngZPCwrAiZfaIwdH2rp9TJjr7gsvNkLmogYBT9ZzLMQmHuJdroYRMWyteLy2+/
Ocrn2agVkNXPcHvlqHQ6IkFfj+zMGHOAxNX78+8+cyVYjO66zKIlF051RLJ+g1wh
FnCyTai44liIE9nAieSskeMVEFLtNYDfQxPuHb4QHfYtFY6PzEI8LeehspoXJxio
+5BmBsDU+1DsGGicPZzPNrqg6JqX0Vw8ylHzWmBlXt26lZyNG9ts26UnAtEK/CoF
joOeRJY=
=+/BP
-----END PGP SIGNATURE-----
--=-=-=--
