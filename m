Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349F73F9F11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhH0So7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 14:44:59 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:38312 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhH0So7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:44:59 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id BF4D9DE;
        Fri, 27 Aug 2021 21:44:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630089847;
        bh=4RAYrkn2SDObuvlkcIl8S0wOdjRVTtUb63ZLOYfg7Ls=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=CIUVvBtU9yMXX3oFwUkHx/4mKtnBnlXoUyDI6u63f/hqLMK39ktI4Ycd7zciyUrVU
         N7AT2fLCli7CdxXRL4NZ9MOKqHUa0Xb+xcbq1F5TtMcB9KGQwnztJeuR2XwLAcbO/g
         DFHffT+jMeIvRXjTVpw3OIucHNZP4ktIYPd5cnY4=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 21:44:07 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 21:44:07 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>
CC:     "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: RE: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Thread-Topic: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Thread-Index: AQHXlJD4Aw/BzjELzkaNCIdXoLLU5auCIX8AgAAFSYCABZaw8A==
Date:   Fri, 27 Aug 2021 18:44:07 +0000
Message-ID: <9dcbd4fb0dcf434f9241d2ef13763428@paragon-software.com>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-4-kari.argillander@gmail.com>
 <20210824080302.GC26733@lst.de>
 <20210824082157.umppqksjl2vvyd53@kari-VirtualBox>
In-Reply-To: <20210824082157.umppqksjl2vvyd53@kari-VirtualBox>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Kari Argillander <kari.argillander@gmail.com>
> Sent: Tuesday, August 24, 2021 11:22 AM
> To: Christoph Hellwig <hch@lst.de>
> Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@=
lists.linux.dev; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; Pali Roh=E1r <pali@kernel.org>; Matthew Wilcox <=
willy@infradead.org>; Christian Brauner
> <christian.brauner@ubuntu.com>
> Subject: Re: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
>=20
> On Tue, Aug 24, 2021 at 10:03:02AM +0200, Christoph Hellwig wrote:
> > > +	/*
> > > +	 * TODO: We should probably check some mount options does
> > > +	 * they all work after remount. Example can we really change
> > > +	 * nls. Remove this comment when all testing is done or
> > > +	 * even better xfstest is made for it.
> > > +	 */
> >
> > Instead of the TODO I would suggest a prep patch to drop changing of
> > any options in remount before this one and then only add them back
> > as needed and tested.
>=20
> This could be good option. I have actually tested nls and it will be
> problem so we definitely drop that. I will wait what Konstantin has
> to say about other.
>=20
> > The mechanics of the conversion look good to me.
>=20
> I have made quite few changes to make this series better and will
> send v3 in the near future.
>=20
> Main change is that we won't allocate sbi when remount. We can
> allocate just options. Also won't let nls/iocharset change.

Hi Kari, looking forward to have v3 series to pick up!

Best regards.
