Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A443FAD7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhH2Ryh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 13:54:37 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:60826 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhH2Ryh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:54:37 -0400
Date:   Sun, 29 Aug 2021 17:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630257571;
        bh=av0NQK53DTwWvhm77BFXmCSJeGiZ1e8OmGOoZPBG0xw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=EEENe+Nf1QYd/HPTGjjHzHo8SNMj4YxrorK/0oXgpyZHfbaJUY4pb97OoneLn2bas
         YDY/ne4O/jUWNmFESpmQq1qJqiR1Tsy93onDmq7ANRQlO4edJTJVEqonxts79C4/90
         vLgVKnSjgIMjEtav5VhJGUXg9lla/abBEJmQCf7M=
To:     Al Viro <viro@zeniv.linux.org.uk>
From:   "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Reply-To: "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: Re: [PATCH 2/3] fat: add the msdos_format_name() filename cache
Message-ID: <87k0k4w4mb.fsf@protonmail.com>
In-Reply-To: <YSunFyR1f9+MTmsk@zeniv-ca.linux.org.uk>
References: <20210829142459.56081-1-calebdsb@protonmail.com> <20210829142459.56081-3-calebdsb@protonmail.com> <YSujmt9vman41ecj@zeniv-ca.linux.org.uk> <YSunFyR1f9+MTmsk@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

"Al Viro" <viro@zeniv.linux.org.uk> writes:

> On Sun, Aug 29, 2021 at 03:11:22PM +0000, Al Viro wrote:
>> On Sun, Aug 29, 2021 at 02:25:29PM +0000, Caleb D.S. Brzezinski wrote:
>> > Implement the main msdos_format_name() filename cache. If used as a
>> > module, all memory allocated for the cache is freed when the module is
>> > de-registered.
>> >
>> > Signed-off-by: Caleb D.S. Brzezinski <calebdsb@protonmail.com>
>> > ---
>> >  fs/fat/namei_msdos.c | 35 +++++++++++++++++++++++++++++++++++
>> >  1 file changed, 35 insertions(+)
>> >
>> > diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>> > index 7561674b1..f9d4f63c3 100644
>> > --- a/fs/fat/namei_msdos.c
>> > +++ b/fs/fat/namei_msdos.c
>> > @@ -124,6 +124,16 @@ static int msdos_format_name(const unsigned char =
*name, int len,
>> >  =09unsigned char *walk;
>> >  =09unsigned char c;
>> >  =09int space;
>> > +=09u64 hash;
>> > +=09struct msdos_name_node *node;
>> > +
>> > +=09/* check if the name is already in the cache */
>> > +
>> > +=09hash =3D msdos_fname_hash(name);
>> > +=09if (find_fname_in_cache(res, hash))
>> > +=09=09return 0;
>>
>> Huh?  How could that possibly work, seeing that
>> =09* your hash function only looks at the first 8 characters
>> =09* your find_fname_in_cache() assumes that hash collisions
>> are impossible, which is... unlikely, considering the nature of
>> that hash function
>> =09* find_fname_in_cache(res, hash) copies at most 8 characters

>> Where does the extension come from?

I'll be honest, I don't have any. Before I started writing this code I
poked msdos_format_name() with a lot of sticks to make sure I understood
the behavior, and it never carried over extentions into the FAT system;
at least, not that I saw through this function.

> While we are at it, your "fast path" doesn't even look at opts
> argument...

My understanding is that opts is a semi-global/per-drive setting. If
that's wrong then again, yes, this won't function correctly, but it does
seem to work.

Thanks.
Caleb B.

--=20
"Come now, and let us reason together," Says the LORD
    -- Isaiah 1:18a, NASB

