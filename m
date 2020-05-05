Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CDA1C55CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEEMlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 08:41:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgEEMlO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 08:41:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88E92AB3D;
        Tue,  5 May 2020 12:41:13 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
 <SN4PR0401MB3598DDEF9BF9BACA71A1041D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <bc2811dd-8d1e-f2ff-7a9b-326fe4270b96@suse.com>
 <6d15c666-c7c8-8667-c25c-32bb89309b6d@gmx.com>
From:   Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs Data & Performance
Message-ID: <f48ae201-cb4a-9bd3-5dd0-2d79db5019af@suse.com>
Date:   Tue, 5 May 2020 08:41:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6d15c666-c7c8-8667-c25c-32bb89309b6d@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4djyIkxyrxBdIGRdTeZoevndhN9GeB8yN"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4djyIkxyrxBdIGRdTeZoevndhN9GeB8yN
Content-Type: multipart/mixed; boundary="yz9sDuggSuKl7dLkjBAx2fsEMVl9Hp80n"

--yz9sDuggSuKl7dLkjBAx2fsEMVl9Hp80n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/5/20 8:39 AM, Qu Wenruo wrote:
>=20
>=20
> On 2020/5/5 =E4=B8=8B=E5=8D=888:36, Jeff Mahoney wrote:
>> On 5/5/20 3:55 AM, Johannes Thumshirn wrote:
>>> On 04/05/2020 23:59, Richard Weinberger wrote:
>>>> Eric already raised doubts, let me ask more directly.
>>>> Does the checksum tree really cover all moving parts of BTRFS?
>>>>
>>>> I'm a little surprised how small your patch is.
>>>> Getting all this done for UBIFS was not easy and given that UBIFS is=
 truly
>>>> copy-on-write it was still less work than it would be for other file=
systems.
>>>>
>>>> If I understand the checksum tree correctly, the main purpose is pro=
tecting
>>>> you from flipping bits.
>>>> An attacker will perform much more sophisticated attacks.
>>>
>>> [ Adding Jeff with whom I did the design work ]
>>>
>>> The checksum tree only covers the file-system payload. But combined w=
ith=20
>>> the checksum field, which is the start of every on-disk structure, we=
=20
>>> have all parts of the filesystem checksummed.
>>
>> That the checksums were originally intended for bitflip protection isn=
't
>> really relevant.  Using a different algorithm doesn't change the
>> fundamentals and the disk format was designed to use larger checksums
>> than crc32c.  The checksum tree covers file data.  The contextual
>> information is in the metadata describing the disk blocks and all the
>> metadata blocks have internal checksums that would also be
>> authenticated.  The only weak spot is that there has been a historical=

>> race where a user submits a write using direct i/o and modifies the da=
ta
>> while in flight.  This will cause CRC failures already and that would
>> still happen with this.
>>
>> All that said, the biggest weak spot I see in the design was mentioned=

>> on LWN: We require the key to mount the file system at all and there's=

>> no way to have a read-only but still verifiable file system.  That's
>> worth examining further.
>=20
> That can be done easily, with something like ignore_auth mount option t=
o
> completely skip hmac csum check (of course, need full RO mount, no log
> replay, no way to remount rw), completely rely on bytenr/gen/first_key
> and tree-checker to verify the fs.

But then you lose even bitflip protection.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--yz9sDuggSuKl7dLkjBAx2fsEMVl9Hp80n--

--4djyIkxyrxBdIGRdTeZoevndhN9GeB8yN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAl6xXuMACgkQHntLYyF5
5bKvkxAAtvwkh0G0sQQxBbeHiBEbs1KXvPPH08EdLmSJjZherzz2etRibGRgbeXF
xTkAUKwz0Iw8NOFb6o5BvsUrU6mrsfGcceI6BIXdO073fmFT79IIxstOWKkd3rzs
JMLtxg4Cu8scal9BMZmZ1F4IcTnw0aGE6xBwyRuJHpx/vOiBGwln5fnIwCE+nMOM
MvSuGyeYP8+OojCPMQlZlj9fbkxliTJi7Avck4rWymEToQvCWyuVaNCT/Xn3Wuat
AdaOL6tBkIG6j8kOwc9iUZ2pPVq19ZZfGDYpzzp7I2JhK7eEipwFuIuBbjFYMs8m
BOlREC+ZiLltjbl9MCwXKBwXYhcMets4CtNyztJ7pUjvPGwivaHJGMzduF0flCNs
mQEB/4my8QwMnmgO5AVvxRLKEpzh/hdnags31N6oD7Z5Kqc27yrcRO8/y1bie8/W
V5GO3fZKX1l057dpk91LGi6xZCCRXQrLS5K4CEDVITtBL2tZshPwUJHBZDahd3lE
mU3lh8ES2dcB6VOJGWFDlDYRDvTPi8ZDkRRJqYpRGmaeRD64oZFLTgdPPFDMYNmY
jyZPQ1lWtKFBzBLefOQybgi9Hpwx2FI5t7KCTjsd6QiNnYxm4x0F5bmNGtsMLcc2
jDuUv92r++1FOcd+lM50ZEvjiruSEei6oW+USepQvl1IqAgHuJE=
=Eawi
-----END PGP SIGNATURE-----

--4djyIkxyrxBdIGRdTeZoevndhN9GeB8yN--
