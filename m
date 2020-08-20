Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54224B72E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgHTKs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 06:48:58 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:33814 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731233AbgHTKsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:48:53 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 3A701223;
        Thu, 20 Aug 2020 13:48:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1597920530;
        bh=9cTYIIJs4bB6m90q1Q33yf9+CsB+AZVqOTe8LJv4/ww=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=aVOB/NFoG4pG0LP5c29U+0JbKiEmNLTgguYMcNnw8D/mSNHFjhy86Frui5j9mCU4B
         x0jgGpZW/4eUidx3C0zPQbegivfE93OMslZzvamvQtg0qT5BjfxFpV0wRB14lCxG5n
         aWSXN7XhoMwCZUDeNtxZRyvL02/gtiAqN4dgIF4g=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 20 Aug 2020 13:48:49 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 20 Aug 2020 13:48:49 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Topic: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Index: AdZyNcmjSkpkGje7R9K6YobJrVDyZwA6EcIAAPAHtmA=
Date:   Thu, 20 Aug 2020 10:48:49 +0000
Message-ID: <a8fa5b2b31b349f2858306af01269eda@paragon-software.com>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
 <20200815190642.GZ2026@twin.jikos.cz>
In-Reply-To: <20200815190642.GZ2026@twin.jikos.cz>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Sterba <dsterba@suse.cz>
Sent: Saturday, August 15, 2020 10:07 PM
>=20
> 1. check existing support in kernel
>=20
> There is fs/ntfs with read-only support from Tuxera, last change in the
> git tree is 3 years ago. The driver lacks read-write support so there's
> not 100% functionality duplication but there's still driver for the same
> filesystem.
>=20
> I don't know what's the feature parity, how much the in-kernel driver is
> used (or what are business relations of Tuxera and Paragon), compared to
> the FUSE-based driver, but ideally there's just one NTFS driver in linux
> kernel.
>=20
> The question I'd ask:
>=20
> - what are users of current fs/ntfs driver going to lose, if the driver
>   is going to be completely replaced by your driver
>=20
>   If the answer is 'nothing' then, the straightfowrad plan is to just
>   replace it. Otherwise, we'll have to figure that out.

Hi! Regarding the comparison with fs/ntfs driver - we of course did the ana=
lysis. There are two main points which make the difference: full read-write=
 support (including compressed/sparse files) and journal replaying. The one=
 thing which is missing in fs/ntfs3 in the inital patch is the appropriate =
processing of hybernated volumes (mounting them read-only to avoid corrupti=
ons). This, however, is considered as trivial change and will be added eith=
er in v2, or in v3. In general, we want to have the community's feedback on=
 the topic, and if it's more suitable for the Linux Kernel not to have two =
implementations in Kernel, then the 'fs/ntfs' may be replaced. =20

>=20
> 2. split the patch
>=20
> One patch of 27k lines of code is way too much to anybody to look at.

The patch will be splitted in v2 file-wise. Wasn't clear initially which wa=
y will be more convenient to review.

> 3. determine support status
>=20
> You state intentions to work on the driver and there's a new entry in
> MAINTAINERS file with 'Supported', so that's a good sign that it's not
> just one-time dump of code. Fixing bugs or adding functionality is
> expected.
>=20
> 4. development git tree
>=20
> Once the filesystem is merged, you'd be getting mails from people
> running eg. static checkers, build tests, sending cleanups or other
> tree-wide changes.  The entry in MAINTAINER file does not point to any
> git tree, so that's not clear to me what's the expected way to get the
> fixes to Linus' tree or where are people supposed to look for 'is this
> fixed already'.

The external git repo for the code is currently being prepared, so it's the=
 matter of time to have it. Will add the appropriate links to the MAINTERS =
once done.

