Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2495719
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 08:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfHTGGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 02:06:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:46661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTGGL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566281126;
        bh=IbMsxkjULl0sbI8PV+sJrFAWMn1HFEuAyJeB7Ap6EN4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B/otRjJsNNu1WXkg2xOb1+dXcEzwlT/KXuaC6iDJRm85tut56fvGRjttOR87+VVck
         tzRPwhKHtR+NH3eIeYGSkhz1SyC4Et6k2RT3BE73vo5epLihekPvgem4IEW2kgGMN0
         tTw5KRl3ceoQzSjgn7Xy44DvPTqHac+OfzWURlDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3bWr-1iPUjG227v-010adS; Tue, 20
 Aug 2019 08:05:26 +0200
Subject: Re: [PATCH] erofs: move erofs out of staging
To:     miaoxie@huawei.com, Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
References: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu> <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <698e2fa6-956b-b367-6f6a-3e6b09bfef5f@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <301ccbea-4140-3816-a1b3-5018ffb4036c@gmx.com>
Date:   Tue, 20 Aug 2019 14:04:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <698e2fa6-956b-b367-6f6a-3e6b09bfef5f@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3bJxyv1PvPqOyLfzZcRWdqjlgomhmdc78"
X-Provags-ID: V03:K1:oX7mHmiMsoFpvgiuoR/eWsBsLEEhaKf3hVRHMoPOsKwmopiQdZx
 rHjkE92dh7RDyRL6UdcW3WoefWsONT78p0UW33wTIary/kAgbR8mtj3+6saZsIXvncyle8f
 +4rUZ9C8kkO8pltGJVPaG962QBrktB+64wq8OH6oSIlDPTqOx4mEaIFB5tSO9QTbtTSM0EH
 g4pAtxYh7hcdR8YTiHF8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L8Dhug8qyvA=:NYnppo2JgU4b4Vt7CBjMhs
 YQnbQUIv4hD8BlNRUK9FohaJew7aaMZ53Ek615FLdqI+OjNA89p+Ra+lSxIL2l7qliHZe+RTI
 y6nmjMY0ARDe9EETSz1fXiu19JoqYjBGHvjmX2YwfTYaBQJakF5Ia10J8YtIdY9PHzmsRQ4fi
 GhB3EgyOheyl4H8nejoBDCYaTZW6QlwToAaSlVd0KOeS9VA2JAElRBE6OcN+VvQZHz7YOBT40
 Af3fJtaKOopRQW8WU8w30w3Pou0wVVw0qOg3dZH7TTGMXXEeGZ8xyzdM6qlhbLt94P4/9DVTM
 WHOkc9aTUovYIrWB3dDEd2MAEuMIp8yzImjM5UWTwb+x6EmcxWp+ri4qnyJQ9DmJOutk/0jVI
 /W+xIbrD461dV7F2bapP6OCpUwPTL5ihOsD0h9npx12x8FDcT65qnU5oyx2QFNh/LDvWoyz1l
 ZuIQtOU0C4HENpdCYeGILCBSFpXRPRgZI4/j66V8VJ3e/3ghNTEaeu/6rlpJW4vZ6AldPhWPb
 MwX7oUubEVj6R8GtrvDpv4h0q6Z8BmM22gOlLN9kxxY3aYE/yPbF4WSF1DUeu5Ub3KMm3wCh8
 6OkvYCyh7xUmU7/qiqPXb+NT00DL9nwiLcsjREnJAj+kvOnfxDlHpyB7eH254mPaI3rtAGiaI
 Pn7GPDWonmBhJ+GEVf/k1XsWuK37sD1MkB7H/dqBCJUOsYYesGXWEy0tLB9ld5Fsxhg6t3D25
 3K/bdT8m9nBKOqf55fpNU3WD+7YP6z0oREDNEiTvoa4S6fKCO5yHyvwE7ZSKrGLMGWRllF8B+
 R60SdGTjFPmFlnIunJPF6kaDbNGtyd68MqL1uuQRfswQTAg+qYqeoASJ5TVGL4Bet4cxCQpCh
 aizUybf98Fcm2JuniuwxwcdLfTDfR5O+ZmdVBTy+Krs2S3kMjv/uk0rNAixBMzehgUrMfbl7F
 9yoHFUxNc2xARXZCyO2+yT5G4RBfA6xnsSNJ32d6a21rkL2kTxUqg6g1zAZByGLx5IjzUHKNO
 2GnBAseSiUKRCVJ+vCsWcODW35+gL1Jn08oiH8XF83NG4rYScW2H5eHjhnECkrHD4XCValEa9
 IuWObXnnI1stKRHWlPEk/oU0eWkkKBQ5oueTEotfEKc8o60TDTekWjPMtjcfN1k1KBq2ww7wQ
 DgDMUtDkMzg0Wzgcaf6ecpxzOmuHcJT6D4HMUA5lyKfiwLcQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3bJxyv1PvPqOyLfzZcRWdqjlgomhmdc78
Content-Type: multipart/mixed; boundary="Olm72Ypg8nkRzM1mIhNGvCKobZrRVB0Ah";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: miaoxie@huawei.com, Gao Xiang <hsiangkao@aol.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Theodore Y. Ts'o"
 <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Chao Yu <yuchao0@huawei.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, devel <devel@driverdev.osuosl.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Amir Goldstein
 <amir73il@gmail.com>, linux-erofs <linux-erofs@lists.ozlabs.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Pavel Machek <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Message-ID: <301ccbea-4140-3816-a1b3-5018ffb4036c@gmx.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
References: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu> <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <698e2fa6-956b-b367-6f6a-3e6b09bfef5f@huawei.com>
In-Reply-To: <698e2fa6-956b-b367-6f6a-3e6b09bfef5f@huawei.com>

--Olm72Ypg8nkRzM1mIhNGvCKobZrRVB0Ah
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>> The same tool exists for btrfs, although lacks the write ability, but
>> that dump is more comprehensive and a great tool to learn the on-disk
>> format.
>>
>>
>> And for the fuzzing defending part, just a few kernel releases ago,
>> there is none for btrfs, and now we have a full static verification
>> layer to cover (almost) all on-disk data at read and write time.
>> (Along with enhanced runtime check)
>>
>> We have covered from vague values inside tree blocks and invalid/missi=
ng
>> cross-ref find at runtime.
>>
>> Currently the two layered check works pretty fine (well, sometimes too=

>> good to detect older, improper behaved kernel).
>> - Tree blocks with vague data just get rejected by verification layer
>>   So that all members should fit on-disk format, from alignment to
>>   generation to inode mode.
>>
>>   The error will trigger a good enough (TM) error message for develope=
r
>>   to read, and if we have other copies, we retry other copies just as
>>   we hit a bad copy.
>>
>> - At runtime, we have much less to check
>>   Only cross-ref related things can be wrong now. since everything
>>   inside a single tree block has already be checked.
>>
>> In fact, from my respect of view, such read time check should be there=

>> from the very beginning.
>> It acts kinda of a on-disk format spec. (In fact, by implementing the
>> verification layer itself, it already exposes a lot of btrfs design
>> trade-offs)
>>
>> Even for a fs as complex (buggy) as btrfs, we only take 1K lines to
>> implement the verification layer.
>> So I'd like to see every new mainlined fs to have such ability.
>=20
> It is a good idea. In fact, we already have a verification layer which =
was implemented
> as a device mapper sub-module. I think it is enough for a read-only fil=
esystem because
> it is simple, flexible and independent(we can modify the filesystem lay=
out without
> verification module modification).

If you're talking about dm-verity, then IMHO they are with completely
different objective.

For dm-verity it's more like authentication. Without proper key
(authentication), no one can modify the data without being caught.
That's why I hate such thing, it's not open at all, *as bad as locked
bootloader*.

While the tree-checker (the layer in btrfs) is more like a sensitive and
sometimes overreacting detector, find anything wrong, then reject the
offending tree block.

The original objective of tree-checker is to free coder from defensive
coding, providing a centralized verification service, thus we don't need
to verify tree blocks randomly using ugly BUG_ON()s.
(But unfortunately, a lot of BUG_ON()s are still kept as is, as it takes
more time to persuade reviewers that those BUG_ON()s are impossible to
hit anymore)

Tree-checker can not only detect suspicious metadata (either caused by
mem bit flip or poorly crafted image), but also bad *kernel* behavior or
even runtime bitflip. (Well, it only works for RW fs, so not really
helpful for a RO fs).

And performance is another point.
That tree-checker in btrfs is as fast/slow as CRC32.
Not sure how it would be for dm-verity, but I guess it's slower than
CRC32 if using any strong hash.

Anyway, for a RO fs, if it's relying on dm-verify then that's OK for
real-world usage.
But as a standalone fs, even it's RO, a verification layer would be a
great plus.

At least when new student developers try fuzzed images on the fs, it
would be a good surprise other than tons of new bug reports.

>=20
> =20
>>>
[...]
>>>
>>> Yes, we will do such a debugging tool of course. Actually Li Guifu is=
 now
>>> developping a erofs-fuse to support old linux versions or other OSes =
for
>>> archiveing only use, we will base on that code to develop a better fu=
zzer
>>> tool as well.
>>
>> Personally speaking, debugging tool is way more important than a runni=
ng
>> kernel module/fuse.
>> It's human trying to write the code, most of time is spent educating
>> code readers, thus debugging tool is way more important than dead cold=
 code.
>=20
> Agree, Xiang and I have no time to developing this feature now, we are =
glad very much if you could help
> us to do it ;)

In fact, since the fs is a RO fs, it could be pretty good educational
example for any fs newbies. Thus a debug tool which can show the full
metadata of the fs can really be helpful.

In fact, btrfs-debug-tree (now "btrfs ins dump-tree") leads my way to
btrfs, and still one of my favourite tool to debug.

Thanks,
Qu



--Olm72Ypg8nkRzM1mIhNGvCKobZrRVB0Ah--

--3bJxyv1PvPqOyLfzZcRWdqjlgomhmdc78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1bjX4ACgkQwj2R86El
/qhLkwf/QvNM5Jdv2JgYzivaLSTXBKPyCLWpUqZ+dIfb+1eG+ZdCEl3yn0n1oqQA
6yaSa43H9AHVAU4vvB2JSsF9+O5twW163Wt1xv9hnDmI13N15jkPyyzh204XsTCc
9VwqcUOjEJO0IjO+y711kR0nai8SwRhXDvlNx0PpINrO1XDZtz1rnEBD/I5OgDiL
2CaGcdiILui3WW+5GWBeU1lGAaZZOEz8PYas2VeUTP4Zpidps9ClmquyPo7WH19C
QpKDnYayXRF9xB45qCXD+2hcm2PN5D0U+rGe1bCQmOroJjJ1bW0tFlh5kEkyZXNi
mNmvtLVY/lVtvOt3xw9S3UXreStBhQ==
=G385
-----END PGP SIGNATURE-----

--3bJxyv1PvPqOyLfzZcRWdqjlgomhmdc78--
