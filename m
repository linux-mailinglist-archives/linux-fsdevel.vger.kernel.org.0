Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0362D7AF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 17:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406741AbgLKQ3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 11:29:33 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:53838 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395169AbgLKQ26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:28:58 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CF3E91CC;
        Fri, 11 Dec 2020 19:28:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1607704095;
        bh=gaJXBhrA6SVgI+3Xva2LJf27yCKYkaztXkIgb/m62UE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=gfsbqWdBz205WU5aFgkDWM/z1yDKf0m8O6Dysa4s5rl7+OMd2vn64tjqMmKaygUIT
         z+4i09kAqZ5m9IGzea7Og6IHkqLDw0nDKcmElqdVfZ2dwAG96M7RO4/ELWkgupuVQG
         BRBrCiPCAEreTkYlMqkSIbxQnGSev4qaQzGHLWJk=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 11 Dec 2020 19:28:15 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 11 Dec 2020 19:28:15 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v14 06/10] fs/ntfs3: Add compression
Thread-Topic: [PATCH v14 06/10] fs/ntfs3: Add compression
Thread-Index: AQHWylTdIpZR6rup4EqAA/Bg1BTo06nnEmaAgAsMS3A=
Date:   Fri, 11 Dec 2020 16:28:15 +0000
Message-ID: <d5b485fa9ced4923a47704c9ec19552e@paragon-software.com>
References: <20201204154600.1546096-1-almaz.alexandrovich@paragon-software.com>
 <20201204154600.1546096-7-almaz.alexandrovich@paragon-software.com>
 <X8qCLXJOit0M+4X7@sol.localdomain>
In-Reply-To: <X8qCLXJOit0M+4X7@sol.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@kernel.org>
Sent: Friday, December 4, 2020 9:39 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de
> Subject: Re: [PATCH v14 06/10] fs/ntfs3: Add compression
>=20
> On Fri, Dec 04, 2020 at 06:45:56PM +0300, Konstantin Komarov wrote:
> > This adds compression
> >
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software=
.com>
> > ---
> >  fs/ntfs3/lib/common_defs.h       | 196 +++++++++++
> >  fs/ntfs3/lib/decompress_common.c | 314 +++++++++++++++++
> >  fs/ntfs3/lib/decompress_common.h | 558 +++++++++++++++++++++++++++++++
> >  fs/ntfs3/lib/lzx_common.c        | 204 +++++++++++
> >  fs/ntfs3/lib/lzx_common.h        |  31 ++
> >  fs/ntfs3/lib/lzx_constants.h     | 113 +++++++
> >  fs/ntfs3/lib/lzx_decompress.c    | 553 ++++++++++++++++++++++++++++++
> >  fs/ntfs3/lib/xpress_constants.h  |  23 ++
> >  fs/ntfs3/lib/xpress_decompress.c | 165 +++++++++
> >  fs/ntfs3/lznt.c                  | 452 +++++++++++++++++++++++++
> >  10 files changed, 2609 insertions(+)
> >  create mode 100644 fs/ntfs3/lib/common_defs.h
> >  create mode 100644 fs/ntfs3/lib/decompress_common.c
> >  create mode 100644 fs/ntfs3/lib/decompress_common.h
> >  create mode 100644 fs/ntfs3/lib/lzx_common.c
> >  create mode 100644 fs/ntfs3/lib/lzx_common.h
> >  create mode 100644 fs/ntfs3/lib/lzx_constants.h
> >  create mode 100644 fs/ntfs3/lib/lzx_decompress.c
> >  create mode 100644 fs/ntfs3/lib/xpress_constants.h
> >  create mode 100644 fs/ntfs3/lib/xpress_decompress.c
> >  create mode 100644 fs/ntfs3/lznt.c
>=20
> This really could use a much better commit message.  Including mentioning=
 where
> the LZX and XPRESS decompression code came from
> (https://github.com/ebiggers/ntfs-3g-system-compression).
>=20

Hi Eric! Fixed in V15!

> Also note you've marked the files as "SPDX-License-Identifier: GPL-2.0",
> but they really are "SPDX-License-Identifier: GPL-2.0-or-later".
>=20

Thanks, fixed as well.

> Also I still think you should consider using the simpler version from
> ntfs-3g-system-compression commit 3ddd227ee8e3, which I had originally in=
tended
> to be included in NTFS-3G itself.  That version was fewer lines of code a=
nd
> fewer files, as it was simplified for decompression-only.  The latest ver=
sion
> (the one you're using) is shared with a project that also implements comp=
ression
> (so that I can more easily maintain both projects), so it's more complex =
than
> needed for decompression-only support.  But in the kernel context it may =
make
> sense to go with a simpler version.  There are a few performance optimiza=
tions
> you'd miss by going with the older version, but they weren't too signific=
ant,
> and probably you don't need to squeeze out every bit of performance possi=
ble
> when reading XPRESS and LZX-compressed files in this context?
>=20
> - Eric

We used the newest code initially. Looking at the commit you've pointed out=
, but it will
take some time as needs to pass full set of tests with new code. On the dif=
ferences you've
mentioned between the first and latest code in ntfs-3g system compression: =
we've removed
the optimizations (needed to go into kernel), also the reparse points stuff=
 is being parsed by
ntfs3 driver itself. Given this, doesn't seems there are many differences r=
emain.
Also, we'll follow your recommendations, if you highly recommend to stick t=
o the commit
you've mentioned (but at this moment it seems "newer=3Dbetter" formula stil=
l valid).

Thanks!
