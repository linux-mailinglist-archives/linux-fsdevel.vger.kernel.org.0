Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA1278D93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgIYQEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 12:04:46 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:55249 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbgIYQEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:04:46 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 0744081E7A;
        Fri, 25 Sep 2020 19:04:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1601049883;
        bh=ywehzJ6YFxcIY8HSB5APcyLJlqfi+g+DhfY2lJn+4y0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=UgaFn6+zowNWoMqeDyAy3jPHEztWR5gigoafsIwMB0byCBmZedmo11UBpMS2LPRyz
         AWZXfKRmXrFygRToaYqGa2kB4kGDywgEXu02ulimJzVvB06a5/ecWYvo4I8ryuxn74
         xFWZNzV8R83RnlZY2kfnSfG3JtkxP6wYGBmGEiA8=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 25 Sep 2020 19:04:42 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 25 Sep 2020 19:04:42 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Joe Perches <joe@perches.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: RE: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Thread-Topic: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Thread-Index: AQHWiEVLqTuLvbWOTEKMmELjfZa26KlmuM8AgACEsICAB2PZsP//1JcAgAsjewA=
Date:   Fri, 25 Sep 2020 16:04:42 +0000
Message-ID: <930a4c89bf794cda9b5e21e68cc79ae9@paragon-software.com>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
 <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
 <20200914023845.GJ6583@casper.infradead.org>
 <1cb55e79c5a54feb82cf4850486890df@paragon-software.com>
 <20200918165434.GG32101@casper.infradead.org>
In-Reply-To: <20200918165434.GG32101@casper.infradead.org>
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

From: Matthew Wilcox <willy@infradead.org>
Sent: Friday, September 18, 2020 7:55 PM
> Subject: Re: [PATCH v5 03/10] fs/ntfs3: Add bitmap
>=20
> On Fri, Sep 18, 2020 at 04:35:11PM +0000, Konstantin Komarov wrote:
> > > That was only just renamed.  More concerningly, the documentation is
> > > quite unambiguous:
> > >
> > >  * This function is for filesystems to call when they want to start
> > >  * readahead beyond a file's stated i_size.  This is almost certainly
> > >  * not the function you want to call.  Use page_cache_async_readahead=
()
> > >  * or page_cache_sync_readahead() instead.
> >
> > Hi Matthew! it's not so clear for us by several reasons (please correct
> > if this is wrong):
> > page_cache_sync_readahead() seems applicable as a replacement, but
> > it doesn't seem to be reasonable as readahead in this case gives perf
> > improvement because of it's async nature. The 'async' function is incom=
patible
> > replacement based on the arguments list.
>=20
> I think the naming has confused you (so I need to clarify the docs).
> The sync function is to be called when you need the page which is being
> read, and you might want to take the opportunity to read more pages.
> The async version is to be called when the page you need is in cache,
> but you've noticed that you're getting towards the end of the readahead
> window.  Neither version waits for I/O to complete; you have to wait for
> the page to become unlocked and then you can check PageUptodate.
>=20
> Looking at what you're doing, you don't have a file_ra_state because
> you're just trying to readahead fs metadata, right?

Hi Matthew! Yes, correct.

> I think you want
> to call force_page_cache_readahead(mapping, NULL, start, nr_pages);
> The prototype for it is in mm/internal.h, but I think moving it to
> include/linux/pagemap.h is justifiable.

Seems like this. We decided to temporarily remove the ra usage iv V7, while=
 it's
not clear which of the public options is "our" case. Is there anything we c=
an
assist regarding the force_page_cache_readahead() move to
include/linux/pagemap.h?

Thanks.
