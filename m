Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14D3FAD6A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhH2RNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 13:13:01 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:10997 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhH2RNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:13:00 -0400
Date:   Sun, 29 Aug 2021 17:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630257126;
        bh=g8ovrn9TxlnMHd25HdXCOfQFAjbri5sLc5vEvUe/lSY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=nnxWTsDX4W1uX+UANf5bk3VhrPo4mNH8TJWLrdjHK0tVpSG6dPizRDD/IaYTRQb9v
         /AT/I2wZlk9K6sP6VrjhWgfy7vzaCV9sTVaJpt93d2+EIkSq9v+GJ8mDAirA0p0Ozn
         r1EY23i1CJYZU2fSqjRLBnK+cEMA+m4c9/exN3X0=
To:     Al Viro <viro@zeniv.linux.org.uk>
From:   "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Reply-To: "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: Re: [PATCH 2/3] fat: add the msdos_format_name() filename cache
Message-ID: <87o89gw4yy.fsf@protonmail.com>
In-Reply-To: <YSujmt9vman41ecj@zeniv-ca.linux.org.uk>
References: <20210829142459.56081-1-calebdsb@protonmail.com> <20210829142459.56081-3-calebdsb@protonmail.com> <YSujmt9vman41ecj@zeniv-ca.linux.org.uk>
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

> On Sun, Aug 29, 2021 at 02:25:29PM +0000, Caleb D.S. Brzezinski wrote:
>> Implement the main msdos_format_name() filename cache. If used as a
>> module, all memory allocated for the cache is freed when the module is
>> de-registered.
>>
>> Signed-off-by: Caleb D.S. Brzezinski <calebdsb@protonmail.com>
>> ---
>>  fs/fat/namei_msdos.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>> index 7561674b1..f9d4f63c3 100644
>> --- a/fs/fat/namei_msdos.c
>> +++ b/fs/fat/namei_msdos.c
>> @@ -124,6 +124,16 @@ static int msdos_format_name(const unsigned char *n=
ame, int len,
>>  =09unsigned char *walk;
>>  =09unsigned char c;
>>  =09int space;
>> +=09u64 hash;
>> +=09struct msdos_name_node *node;
>> +
>> +=09/* check if the name is already in the cache */
>> +
>> +=09hash =3D msdos_fname_hash(name);
>> +=09if (find_fname_in_cache(res, hash))
>> +=09=09return 0;

> Huh?  How could that possibly work, seeing that
> =09* your hash function only looks at the first 8 characters

My understanding was that the maximum length of the name considered when
passed to msdos_format_name() was eight characters; see:

=09=09while (walk - res < 8)

and

=09=09for (walk =3D res; len && walk - res < 8; walk++) {

If that's an incorrect understanding, then yes, it definitely wouldn't
work. A larger, more computationally intensive hash function would be
required, which would most likely cancel out the improved lookup from
the cache.

> =09* your find_fname_in_cache() assumes that hash collisions
> are impossible, which is... unlikely, considering the nature of
> that hash function

If the names are 8 character limited, then logically any name with the
exact same set of characters would "collide" into the same formatted
name. Again, if I misunderstood the constraints on the filenames, then
yes, this is unnecessary.

> Out of curiosity, how have you tested that thing?

I've used it on my own FAT32 drives for profiling, run it through
kmemleak, ksan, some stress tests, etc. for a few weeks. Like I said, I
benchmarked it and it shaved about 0.2ms of time off my most common use
case.

Thanks.
Caleb B.

--=20
"Come now, and let us reason together," Says the LORD
    -- Isaiah 1:18a, NASB

