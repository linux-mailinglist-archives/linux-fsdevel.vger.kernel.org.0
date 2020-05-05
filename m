Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CFC1C5583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgEEMgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 08:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEEMgb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 08:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70B07AB3D;
        Tue,  5 May 2020 12:36:31 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
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
From:   Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs Data & Performance
Message-ID: <bc2811dd-8d1e-f2ff-7a9b-326fe4270b96@suse.com>
Date:   Tue, 5 May 2020 08:36:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598DDEF9BF9BACA71A1041D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QCxjXmJIb3cmtZierbUqiktbM3SrmCMZ3"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QCxjXmJIb3cmtZierbUqiktbM3SrmCMZ3
Content-Type: multipart/mixed; boundary="kj7CSqKnFEG7s9mZj42es8yczA9qAG63h"

--kj7CSqKnFEG7s9mZj42es8yczA9qAG63h
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/5/20 3:55 AM, Johannes Thumshirn wrote:
> On 04/05/2020 23:59, Richard Weinberger wrote:
>> Eric already raised doubts, let me ask more directly.
>> Does the checksum tree really cover all moving parts of BTRFS?
>>
>> I'm a little surprised how small your patch is.
>> Getting all this done for UBIFS was not easy and given that UBIFS is t=
ruly
>> copy-on-write it was still less work than it would be for other filesy=
stems.
>>
>> If I understand the checksum tree correctly, the main purpose is prote=
cting
>> you from flipping bits.
>> An attacker will perform much more sophisticated attacks.
>=20
> [ Adding Jeff with whom I did the design work ]
>=20
> The checksum tree only covers the file-system payload. But combined wit=
h=20
> the checksum field, which is the start of every on-disk structure, we=20
> have all parts of the filesystem checksummed.

That the checksums were originally intended for bitflip protection isn't
really relevant.  Using a different algorithm doesn't change the
fundamentals and the disk format was designed to use larger checksums
than crc32c.  The checksum tree covers file data.  The contextual
information is in the metadata describing the disk blocks and all the
metadata blocks have internal checksums that would also be
authenticated.  The only weak spot is that there has been a historical
race where a user submits a write using direct i/o and modifies the data
while in flight.  This will cause CRC failures already and that would
still happen with this.

All that said, the biggest weak spot I see in the design was mentioned
on LWN: We require the key to mount the file system at all and there's
no way to have a read-only but still verifiable file system.  That's
worth examining further.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--kj7CSqKnFEG7s9mZj42es8yczA9qAG63h--

--QCxjXmJIb3cmtZierbUqiktbM3SrmCMZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAl6xXcgACgkQHntLYyF5
5bLD7hAAxbI4wvgOSMoos1hNp4kX/ldHeB/8zS3FGNN6+hG4I2D/Ua1a+kiDadVH
mo3vqtldIEJ581Rih0YCcXvBaTQYG0FwUVUcUI/SeAyvK9DA0kYqOY+G5VEyjlgm
PP1nz+LfphdJCF90wc577760eelnCFSJUvkj3Rt8fNfEfs8djJP8G57HMWS2u9WF
Lb6PZA10LdqZHoIIEHoH+CPX8rEukhtvQrmtA2AbgFh+vNbnfOwWTDdrvBrVCQ24
vdSast4jflMYBXji2Fv4Rw8ulkafGZpRbvkWoA4s/GP1tCJG3ppJsDw2lvMeHJ+0
m0KO0Q6xdqA+D7ekuu3csBwHvTbS4BDlkc5UQCg+uXLYtZDesmqOcxFJ9yHslbSU
MNWONyjwbBHMdCkHwKLaqxJtFbx+J+TUXr6HN6iYrexCZeHpBPcMoEM8mF66fIDN
qvFW3/DFqFaHpMWb+JnitZ5DFH1SP7+p5knaRByW2phUenIZTPHJph6Nh/axPvEe
WfFsAwfCQBMqsxlGafWvLx3H2e9Kz93KCvWUgVxKwJXGtVV7pmX/tbb5q+VjRMU2
BdaykW0ORblxEOiK+IoD+ia/qatoyoHv8EDUhAbpN1oziJ92BTcE2xql4RVw6ytd
dfrRWkNkmZqzdOpAALfGslhZlCjm1aUXfEzllnoZjDgsTwJB7Qo=
=5ruj
-----END PGP SIGNATURE-----

--QCxjXmJIb3cmtZierbUqiktbM3SrmCMZ3--
