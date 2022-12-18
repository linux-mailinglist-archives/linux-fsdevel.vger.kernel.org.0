Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0364FE0C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 09:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiLRIKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 03:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLRIKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 03:10:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C33BE04;
        Sun, 18 Dec 2022 00:09:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so6071080wrv.10;
        Sun, 18 Dec 2022 00:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX4/d2jtorEGflGPBI+UvWQv06iASnyauI5jsQU7keQ=;
        b=lCWid6smh69XCEVpk+dE9GIboxbBNiv+RC1xy9Q3MGEFAtAQyE3dniOkRORjZSbs33
         Wz0DR5K8bD7j5+5x3Vyl2mXOoU6w0Px0J2laH1ISxzmPtnzwP4xiiF6njQdzXJqVGE2K
         5wLNQj+HNV4S1NqW1D5SY7YlEmPG80JTkGZxy4TBtIBMYtQFoRHbPku62DuliGy9DpjE
         NN0ZpIimcQTBUfl+61cOgRbhEAvdur7zM2g/i85IkZ37tdN2TwTcDK6SbPxoGejwldrE
         glxK2zSobqWBtqnZSz7HUwEvoCrmw1iGZfCfqNtgte1lvYlrz0e405T+3PvVPwQUQiIq
         7tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX4/d2jtorEGflGPBI+UvWQv06iASnyauI5jsQU7keQ=;
        b=bqeCv4809AO40XrYnrB0/czqyG3tx7iaF2OXleVerG0fvSSPlfBTpH/hJU3+T6MDxB
         Qq6wR2VXHQmFw4qnP+bKMBcpv7jnELx/ZAoJdAfok3YJMn6FexU2b7Ro8tapuEvHIM1W
         uBnVq1Sof3LHi5Q6m1R90fidmeB5IPN+6E1OSOUSSzSWoUi4qFSSwmEZYpvD9DJkjJSQ
         kh7ra69iX4CcAe+LpG3JddJYg3qk5PeU3hLJHWvKuNoBJiS/7a0mrc9yt0Bm/ME9qrel
         mvm7ij2Ncw3m2AxAAHBaorQ4bPSBOhHkdqSN/h8tFO7UUQXY131ymWysKqXwx+v6C174
         Xblg==
X-Gm-Message-State: ANoB5pkoxlmG6beqWk5VzkF/Z7O7ptpjlzDHMWjIPqiqADzbO9CwX3X/
        AmtNDZN8AQdkD4ubngG1CZg=
X-Google-Smtp-Source: AA0mqf7oZ/1qlGSWWeZAxPH0kRNJUiv2rXUL3V47oXEREpwibmwF2pXooa9tSebh8OBPyH+OH3gxfA==
X-Received: by 2002:adf:f68a:0:b0:242:43f3:8948 with SMTP id v10-20020adff68a000000b0024243f38948mr23323801wrp.26.1671350998223;
        Sun, 18 Dec 2022 00:09:58 -0800 (PST)
Received: from suse.localnet (host-79-53-46-69.retail.telecomitalia.it. [79.53.46.69])
        by smtp.gmail.com with ESMTPSA id l1-20020adffe81000000b0024242111a27sm6810128wrr.75.2022.12.18.00.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 00:09:57 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8] Convert reiserfs from b_page to b_folio
Date:   Sun, 18 Dec 2022 09:09:56 +0100
Message-ID: <3515948.LM0AJKV5NW@suse>
In-Reply-To: <Y55TTKG2tgWL7UsQ@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org> <11295613.F0gNSz5aLb@suse>
 <Y55TTKG2tgWL7UsQ@iweiny-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 18 Dec 2022, 00:40 Ira Weiny, <ira.weiny@intel.com> wrote:

On Sat, Dec 17, 2022 at 09:43:11PM +0100, Fabio M. De Francesco wrote:
> On venerd=EC 16 dicembre 2022 21:53:39 CET Matthew Wilcox (Oracle) wrote:
> > > These patches apply on top of
> > > https://lore.kernel.org/linux-fsdevel/20221215214402.3522366-1-willy@=
infradead
> > > .org/
> > >=20
> > > The non-trivial ones mostly revolve around uses of kmap()/kmap_atomic=
(),
> > > so review from the experts on those would be welcome.
> >
> > I took a quick look at your conversions and they made me recall that=20
> > months ago you converted to kmap_local_folio() a previous conversion fr=
om=20
> > kmap() to kmap_local_page() in ext2_get_page(): commit 37ce0b319b287=20
> > ("ext2: Use a folio in ext2_get_page()").
> >
> > So I just saw kmap_local_folio() again. Unfortunately, because of my=20
> > inexperience, I'm not able to understand on my own why we should prefer=
=20
> > the use of this function instead of kmap_local_page().
> >=20
> > Can you please tell me why and when we should prefer kmap_local_folio()=
 in=20
> > those cases too where kmap_local_page() can work properly? I'm asking
> > because these days I'm converting other *_get_page() from kmap()
> > (including the series to fs/ufs that I sent today).

> Fabio kmap_local_folio() works on folios and handles determining which pa=
ge=20
> in the folio is the correct one to map.

Ira, I understand that pages are parts of folios and that, for mapping, we=
=20
need to determine the right page to map. Correct?

I think that I was not able to ask my question clearly. Please, let me rewo=
rk=20
with other words how I went to my question and reword the question itself...

It all started when months ago I saw a patch from Matthew about the convers=
ion=20
from kmap_local_page() to kmap_local_folio() in ext2_get_page().

Here I wanted to comment on the xfstests failures but, when I read patch 2/=
8=20
of this series and saw kmap() converted to kmap_local_folio(), I thought to=
=20
also use this opportunity to ask about why and when kmap_local_folio() shou=
ld=20
be preferred over kmap_local_page().

Obviously, I have nothing against these conversions. I would only like to=20
understand what are the reasons behind the preference for the folio functio=
n.

Mine is a general question about design, necessity, opportunity: what were =
the=20
reasons why, in the above-mentioned cases, the use of kmap_local_folio() ha=
s=20
been preferred over kmap_local_page()?=20

I saw that this series is about converting from b_page to b_folio, therefor=
e=20
kmap_local_folio() is the obvious choice here.

But my mind went back again to ext2_get_page :-)

It looks to me that ext2_get_page() was working properly with=20
kmap_local_page() (since you made the conversion from kmap()). Therefore I=
=20
could not understand why it is preferred to call read_mapping_folio() to ge=
t a=20
folio and then map a page of that folio with kmap_local_folio().=20

I used to think that read_mapping_page() + kmap_local_page() was all we=20
needed. ATM I have not enough knowledge of VFS/filesystems to understand on=
 my=20
own what we gain from the other way to local map pages.   =20

I hope to having been clearer this time...
Can you and/or Matthew please say some words about this?=20

> AFAICT (from a quick grep) fs/ufs does not have folio support.

I was not specifically talking about the fs/ufs conversion. Other conversio=
ns =20
are in my queue (e.g., fs/sysv is next according to Al's suggestions, and i=
n=20
January others will be added to the same queue).

> I am sure Mathew would appreciate converting fs/ufs to folios if you have=
=20
> the time and want to figure it out.

About a year ago Matthew provided me with precious help when I was converti=
ng =20
a Unisys driver from IDR to XArray, so I guess he would be helpful with thi=
s=20
task too :-)

I'd really like to work on converting fs/ufs to folios but you know that I'=
ll=20
have enough time to work on other projects only starting by the end of=20
January.=20

AFAIK this task has mainly got to do with the conversions of the address sp=
ace=20
operations (correct?). I know too little to be able to estimate how much ti=
me=20
it takes but I'm pretty sure it needs more than I currently can set aside.

Instead I could easily devolve the time it is needed for making the =20
memcpy_{to|from}_folio() helpers you talked about in a patch of this series=
,=20
unless you or Matthew prefer to do yourselves. Please let me know.

Thanks,

=46abio

> Ira
>=20
> > If these all look
> > good to people, I can pass them off to Andrew for the 6.3 merge window.
> >=20
> > Running xfstests against reiserfs gives me 313/701 failures before and
> > after this set of patches.
>=20
> It has happened several times to me too. Some patches of mine have failur=
es=20
> from xfstests whose amounts and types don't change with or without my=20
changes.
>=20
> Several of them have already been merged. I guess that if they don't add=
=20
> further failures everything is alright.
>=20
> However, something is broken for sure... xfstests or the filesystems? :-/=
=20
>=20
> Thanks,
>=20
> Fabio
>=20
> > I don't have a huge amount of confidence
> > that we're really getting good coverage from that test run!
> >=20
> > Matthew Wilcox (Oracle) (8):
> >   reiserfs: use b_folio instead of b_page in some obvious cases
> >   reiserfs: use kmap_local_folio() in _get_block_create_0()
> >   reiserfs: Convert direct2indirect() to call folio_zero_range()
> >   reiserfs: Convert reiserfs_delete_item() to use kmap_local_folio()
> >   reiserfs: Convert do_journal_end() to use kmap_local_folio()
> >   reiserfs: Convert map_block_for_writepage() to use kmap_local_folio()
> >   reiserfs: Convert convert_tail_for_hole() to use folios
> >   reiserfs: Use flush_dcache_folio() in reiserfs_quota_write()
> >=20
> >  fs/reiserfs/inode.c           | 73 +++++++++++++++++------------------
> >  fs/reiserfs/journal.c         | 12 +++---
> >  fs/reiserfs/prints.c          |  4 +-
> >  fs/reiserfs/stree.c           |  9 +++--
> >  fs/reiserfs/super.c           |  2 +-
> >  fs/reiserfs/tail_conversion.c | 19 ++++-----
> >  6 files changed, 59 insertions(+), 60 deletions(-)
> >=20
> > --
> > 2.35.1
>=20
>=20
>=20
>=20



