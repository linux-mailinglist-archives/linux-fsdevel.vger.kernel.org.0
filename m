Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5C26655F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgIKRAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:00:20 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:55127 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgIKQ7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:59:41 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id AD5A08222E;
        Fri, 11 Sep 2020 19:59:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1599843574;
        bh=4a3rFaNzCxJ2n7YDmv06byi58tSMon7Mb8hu7R3/ijc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=W4Urdn1r6QZPnFQGiFzusaSUBQoqkzVL8lRz1Wyp6ge7jXYnweglH8Z3YXFFCrzE7
         bLzmQ9lX3pUvtO2Oa8o4RKGGZegOzJKw1XJC7DiI4fwa/G7z/01U585gflb1jUKoea
         CpYtTBECVouxllWEkgqCcXqLdzDTuNzlK+Mu/rxA=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 11 Sep 2020 19:59:34 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 11 Sep 2020 19:59:34 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>
Subject: RE: [PATCH v3 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v3 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AQHWfUklkImnkcPlKk6YxFGcmZ/fxalYOsKAgAuCx5A=
Date:   Fri, 11 Sep 2020 16:59:34 +0000
Message-ID: <948ac894450d494ea15496c2e5b8c906@paragon-software.com>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-3-almaz.alexandrovich@paragon-software.com>
 <20200904120625.2af76ebfnacbzwug@pali>
In-Reply-To: <20200904120625.2af76ebfnacbzwug@pali>
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

From: linux-fsdevel-owner@vger.kernel.org <linux-fsdevel-owner@vger.kernel.=
org> On Behalf Of Pali Rohar
Sent: Friday, September 4, 2020 3:06 PM
>=20
> Hello Konstantin!
>=20
> On Friday 28 August 2020 07:39:30 Konstantin Komarov wrote:
> > +	if (nls_name[0]) {
> > +		sbi->nls =3D load_nls(nls_name);
> > +		if (!sbi->nls) {
> > +			ntfs_printk(sb, KERN_ERR "failed to load \"%s\"",
> > +				    nls_name);
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		sbi->nls =3D load_nls_default();
> > +		if (!sbi->nls) {
> > +			ntfs_printk(sb, KERN_ERR "failed to load default nls");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!strcmp(sbi->nls->charset, "utf8")) {
> > +		/*use utf16s_to_utf8s/utf8s_to_utf16s instead of nls*/
> > +		unload_nls(sbi->nls);
> > +		sbi->nls =3D NULL;
> > +	}
>=20
> You can slightly simplify this code to omit calling load_nls() for UTF-8.=
 E.g.:
>=20
>     if (strcmp(nls_name[0] ? nls_name : CONFIG_NLS_DEFAULT, "utf8") =3D=
=3D 0) {
>         /* For UTF-8 use utf16s_to_utf8s/utf8s_to_utf16s instead of nls *=
/
>         sbi->nls =3D NULL;
>     } else if (nls_name) {
>         sbi->nls =3D load_nls(nls_name);
>         if (!sbi->nls) {
>             /* handle error */
>         }
>     } else {
>         sbi->nls =3D load_nls_default();
>         if (!sbi->nls) {
>             /* handle error */
>         }
>     }

Hi Pali! Thanks! Applied, check out the v5 please.

Best regards
