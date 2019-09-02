Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57FA5201
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 10:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfIBIkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 04:40:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39009 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfIBIkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:40:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 28B04813BA; Mon,  2 Sep 2019 10:40:07 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:40:20 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190902084020.GB19557@amd>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20190829095954.GB20598@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +struct erofs_super_block {
> > +/*  0 */__le32 magic;           /* in the little endian */
> > +/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > +/*  8 */__le32 features;        /* (aka. feature_compat) */
> > +/* 12 */__u8 blkszbits;         /* support block_size =3D=3D PAGE_SIZE=
 only */
>=20
> Please remove all the byte offset comments.  That is something that can
> easily be checked with gdb or pahole.

I don't think I agree. gdb will tell you byte offsets _on one
architecture_. But filesystem is supposed to be portable between them.=20

> > +/* 64 */__u8 volume_name[16];   /* volume name */
> > +/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
> > +
> > +/* 84 */__u8 reserved2[44];
> > +} __packed;                     /* 128 bytes */
>=20
> Please don't add __packed.  In this case I think you don't need it
> (but double check with pahole), but even if you would need it using
> proper padding fields and making sure all fields are naturally aligned
> will give you much better code generation on architectures that don't
> support native unaligned access.

This is on-disk structure, right?

drivers/staging/erofs/super.c:	struct erofs_super_block *layout;
drivers/staging/erofs/super.c:	layout =3D (struct erofs_super_block
*)((u8 *)bh->b_data

So __packed is right thing to do. If architecture accesses that
slowly, that's ungood, but different structures between architectures
would be really bad.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1s1XQACgkQMOfwapXb+vK1qgCeMhRodxdCMHktGBYzM6YZ0upo
P8IAnRXsAoM5UyuAx4MPbJJVq8NtKIG8
=L04e
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
