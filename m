Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768013F9C24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbhH0QJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:09:26 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:43506 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245500AbhH0QJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:09:25 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 05F6782090;
        Fri, 27 Aug 2021 19:08:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630080515;
        bh=nD33TNXGbeVwtfqT0HqayU2dyuRSJU6rquy3c3fui+A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=WXcjg/KBKuMlhtBAPGOOBYsOV3DS8S7ezzCfYPWuzGoKfg/uAxqk/j6XDWxTi92gS
         Q88/ng5/y4wgS3l7Z/TJ30APBleuNB+kPfKoTv2e/cKyQ6gFEV09VlCb9kHbkgQWky
         eNNHYBp5ViKVc38Rw/q1D0gmW7woL63GzEhNXQpg=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 19:08:34 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 19:08:34 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] fs/ntfs3: Use linux/log2 is_power_of_2 function
Thread-Topic: [PATCH] fs/ntfs3: Use linux/log2 is_power_of_2 function
Thread-Index: AQHXkorR1aO5dQA04k2VH8WfP//lc6uHllhQ
Date:   Fri, 27 Aug 2021 16:08:34 +0000
Message-ID: <215724bb79f24c7281731b6637fe7164@paragon-software.com>
References: <20210816103732.177207-1-kari.argillander@gmail.com>
In-Reply-To: <20210816103732.177207-1-kari.argillander@gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Kari Argillander <kari.argillander@gmail.com>
> Sent: Monday, August 16, 2021 1:38 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@=
lists.linux.dev
> Cc: Kari Argillander <kari.argillander@gmail.com>; linux-kernel@vger.kern=
el.org; linux-fsdevel@vger.kernel.org
> Subject: [PATCH] fs/ntfs3: Use linux/log2 is_power_of_2 function
>=20
> We do not need our own implementation for this function in this
> driver. It is much better to use generic one.
>=20
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  fs/ntfs3/ntfs_fs.h | 5 -----
>  fs/ntfs3/run.c     | 3 ++-
>  fs/ntfs3/super.c   | 9 +++++----
>  3 files changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 0c3ac89c3115..c8ea6dd38c21 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -972,11 +972,6 @@ static inline struct buffer_head *ntfs_bread(struct =
super_block *sb,
>  	return NULL;
>  }
>=20
> -static inline bool is_power_of2(size_t v)
> -{
> -	return v && !(v & (v - 1));
> -}
> -
>  static inline struct ntfs_inode *ntfs_i(struct inode *inode)
>  {
>  	return container_of(inode, struct ntfs_inode, vfs_inode);
> diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
> index 5cdf6efe67e0..ce6bff3568df 100644
> --- a/fs/ntfs3/run.c
> +++ b/fs/ntfs3/run.c
> @@ -9,6 +9,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/buffer_head.h>
>  #include <linux/fs.h>
> +#include <linux/log2.h>
>  #include <linux/nls.h>
>=20
>  #include "debug.h"
> @@ -376,7 +377,7 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, C=
LST lcn, CLST len,
>  			if (!used) {
>  				bytes =3D 64;
>  			} else if (used <=3D 16 * PAGE_SIZE) {
> -				if (is_power_of2(run->allocated))
> +				if (is_power_of_2(run->allocated))
>  					bytes =3D run->allocated << 1;
>  				else
>  					bytes =3D (size_t)1
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 6be13e256c1a..c1b7127f5e61 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -29,6 +29,7 @@
>  #include <linux/exportfs.h>
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/nls.h>
>  #include <linux/parser.h>
> @@ -735,13 +736,13 @@ static int ntfs_init_from_boot(struct super_block *=
sb, u32 sector_size,
>=20
>  	boot_sector_size =3D (u32)boot->bytes_per_sector[1] << 8;
>  	if (boot->bytes_per_sector[0] || boot_sector_size < SECTOR_SIZE ||
> -	    !is_power_of2(boot_sector_size)) {
> +	    !is_power_of_2(boot_sector_size)) {
>  		goto out;
>  	}
>=20
>  	/* cluster size: 512, 1K, 2K, 4K, ... 2M */
>  	sct_per_clst =3D true_sectors_per_clst(boot);
> -	if (!is_power_of2(sct_per_clst))
> +	if (!is_power_of_2(sct_per_clst))
>  		goto out;
>=20
>  	mlcn =3D le64_to_cpu(boot->mft_clst);
> @@ -757,14 +758,14 @@ static int ntfs_init_from_boot(struct super_block *=
sb, u32 sector_size,
>  	/* Check MFT record size */
>  	if ((boot->record_size < 0 &&
>  	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
> -	    (boot->record_size >=3D 0 && !is_power_of2(boot->record_size))) {
> +	    (boot->record_size >=3D 0 && !is_power_of_2(boot->record_size))) {
>  		goto out;
>  	}
>=20
>  	/* Check index record size */
>  	if ((boot->index_size < 0 &&
>  	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
> -	    (boot->index_size >=3D 0 && !is_power_of2(boot->index_size))) {
> +	    (boot->index_size >=3D 0 && !is_power_of_2(boot->index_size))) {
>  		goto out;
>  	}
>=20
> --
> 2.30.2

Hi Kari! Thanks for the patch, applied.

Best regards.
