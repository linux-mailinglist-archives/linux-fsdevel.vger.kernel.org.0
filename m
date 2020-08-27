Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAB254A83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH0QUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:20:18 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:47886 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgH0QUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:20:18 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 64150820D7;
        Thu, 27 Aug 2020 19:20:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598545215;
        bh=NKcHa36mTiyxo7usyWNgEjGp32om2cafUFtZv4TBocM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=PA/KZnR+HRLHjnelp11zCWvTgHh6NZV4Fw5OMmSaiCOlk3x4bgLySkWRXNTxX0V7N
         IfghciA2DCPMe43MB7Lp+Ebep5mUcdOA2eBt3n0vhBlzk3vo4czEK+3s/fC5VqR6/w
         22u61x+unzDbL01DjTJC4djcNiYi4x40Z4Z7Jxe4=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 19:20:14 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 19:20:14 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AdZ30tAfM9dNSlAKR92rLVrbgJq3AABR4GEAANzhXxA=
Date:   Thu, 27 Aug 2020 16:20:14 +0000
Message-ID: <208746d50bbf4ffc8de599a4e10befd8@paragon-software.com>
References: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
 <20200823095500.ug5vibiv3hy3luqs@pali>
In-Reply-To: <20200823095500.ug5vibiv3hy3luqs@pali>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pali Roh=E1r <pali@kernel.org>
Sent: Sunday, August 23, 2020 12:55 PM
>=20
> On Friday 21 August 2020 16:25:03 Konstantin Komarov wrote:
> > +		case Opt_nls:
> > +			match_strlcpy(nls_name, &args[0], sizeof(nls_name));
> > +			break;
> > +
> > +		/* unknown option */
> > +		default:
> > +			if (!silent)
> > +				ntfs_error(
> > +					sb,
> > +					"Unrecognized mount option \"%s\" or missing value",
> > +					p);
> > +			//return -EINVAL;
> > +		}
> > +	}
> > +
> > +out:
> > +	if (nls_name[0]) {
> > +		sbi->nls =3D load_nls(nls_name);
> > +		if (!sbi->nls) {
> > +			/* critical ?*/
> > +			ntfs_error(sb, "failed to load \"%s\"\n", nls_name);
> > +			//return -EINVAL;
>=20
> Well, I think it is a fatal error if user supplied NLS encoding cannot
> be loaded. If user via mount parameter specify that wants encoding XYZ
> and kernel loads different (e.g. default one) then userspace would be
> confused as it would expect encoding XYZ.
>=20

Agreed. Will be fixed in V3.

> > +		}
> > +	}
> > +
> > +	if (!sbi->nls) {
> > +		sbi->nls =3D load_nls_default();
> > +		if (!sbi->nls) {
> > +			/* critical */
> > +			ntfs_error(sb, "failed to load default nls");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
