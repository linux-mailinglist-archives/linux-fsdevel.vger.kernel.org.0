Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5C2E2BBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Dec 2020 15:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgLYO2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Dec 2020 09:28:32 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:48190 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbgLYO2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:28:32 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8E6201D60;
        Fri, 25 Dec 2020 17:27:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1608906469;
        bh=a3vCXtOVAq0v1LpHhX/gxZhzzONc9DA9mRBJasl+8Xc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=jqzGJ2VTkSERNY2Hb41cKzgmgnp3CWicIg1xf77UEQtpCBWysq4K+XA6ZImnAfacr
         nAgxr9XFUP8pY4hWe2vQ6A4x8TLc6quUGqoeUn0910q6MDrl6VnmeTt0h18wGCIQNj
         MiU1pspk4jU5vC9p4RsXcPb2Nki3/KsRo1d1AZWk=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 25 Dec 2020 17:27:49 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 25 Dec 2020 17:27:49 +0300
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
Subject: RE: [PATCH v14 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Topic: [PATCH v14 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Index: AQHWylTc0sqKo6zsN0SFUheHXUqDgannEzcAgAsNYqCAFd5qAA==
Date:   Fri, 25 Dec 2020 14:27:48 +0000
Message-ID: <b831c93b507f4c06905abac95f3d5ff2@paragon-software.com>
References: <20201204154600.1546096-1-almaz.alexandrovich@paragon-software.com>
 <20201204154600.1546096-5-almaz.alexandrovich@paragon-software.com>
 <X8qC3NaNv1kmCO4c@sol.localdomain>
 <229c4a26f2834f8dabf566823936d3e4@paragon-software.com>
In-Reply-To: <229c4a26f2834f8dabf566823936d3e4@paragon-software.com>
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

Sent: Friday, December 11, 2020 7:31 PM
> To: 'Eric Biggers' <ebiggers@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de
> Subject: RE: [PATCH v14 04/10] fs/ntfs3: Add file operations and implemen=
tation
>=20
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Friday, December 4, 2020 9:42 PM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kerne=
l@vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> > aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perche=
s.com; mark@harmstone.com; nborisov@suse.com;
> > linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@o=
racle.com; hch@lst.de
> > Subject: Re: [PATCH v14 04/10] fs/ntfs3: Add file operations and implem=
entation
> >
> > On Fri, Dec 04, 2020 at 06:45:54PM +0300, Konstantin Komarov wrote:
> > > +/* external compression lzx/xpress */
> > > +static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const cha=
r *cmpr,
> > > +				 size_t cmpr_size, void *unc, size_t unc_size,
> > > +				 u32 frame_size)
> > > +{
> > > +	int err;
> > > +	void *ctx;
> > > +
> > > +	if (cmpr_size =3D=3D unc_size) {
> > > +		/* frame not compressed */
> > > +		memcpy(unc, cmpr, unc_size);
> > > +		return 0;
> > > +	}
> > > +
> > > +	err =3D 0;
> > > +	ctx =3D NULL;
> > > +	spin_lock(&sbi->compress.lock);
> > > +	if (frame_size =3D=3D 0x8000) {
> > > +		/* LZX: frame compressed */
> > > +		if (!sbi->compress.lzx) {
> > > +			/* Lazy initialize lzx decompress context */
> > > +			spin_unlock(&sbi->compress.lock);
> > > +			ctx =3D lzx_allocate_decompressor(0x8000);
> > > +			if (!ctx)
> > > +				return -ENOMEM;
> > > +			if (IS_ERR(ctx)) {
> > > +				/* should never failed */
> > > +				err =3D PTR_ERR(ctx);
> > > +				goto out;
> > > +			}
> > > +
> > > +			spin_lock(&sbi->compress.lock);
> > > +			if (!sbi->compress.lzx) {
> > > +				sbi->compress.lzx =3D ctx;
> > > +				ctx =3D NULL;
> > > +			}
> > > +		}
> > > +
> > > +		if (lzx_decompress(sbi->compress.lzx, cmpr, cmpr_size, unc,
> > > +				   unc_size)) {
> > > +			err =3D -EINVAL;
> > > +		}
> > > +	} else {
> > > +		/* XPRESS: frame compressed */
> > > +		if (!sbi->compress.xpress) {
> > > +			/* Lazy initialize xpress decompress context */
> > > +			spin_unlock(&sbi->compress.lock);
> > > +			ctx =3D xpress_allocate_decompressor();
> > > +			if (!ctx)
> > > +				return -ENOMEM;
> > > +
> > > +			spin_lock(&sbi->compress.lock);
> > > +			if (!sbi->compress.xpress) {
> > > +				sbi->compress.xpress =3D ctx;
> > > +				ctx =3D NULL;
> > > +			}
> > > +		}
> > > +
> > > +		if (xpress_decompress(sbi->compress.xpress, cmpr, cmpr_size,
> > > +				      unc, unc_size)) {
> > > +			err =3D -EINVAL;
> > > +		}
> > > +	}
> > > +	spin_unlock(&sbi->compress.lock);
> > > +out:
> > > +	ntfs_free(ctx);
> > > +	return err;
> > > +}
> >
> > Decompression is a somewhat heavyweight operation.  Not the type of thi=
ng that
> > should be done while holding a spin lock.
> >
> > - Eric
>=20
> Hi Eric! We plan to swap spinlock to mutex in the next version.
>=20
> Best regards!

Hi Eric! Changed the global spinlock to the mutexes for each type of compre=
ssion.
This should resolve the problem. Please check out the V16.

Thanks!
