Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA87D952DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfHTA4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 20:56:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:46801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbfHTA4x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566262559;
        bh=k2K6YSTlIajPTv2Lr/mNkZv9MUudny3z0bMOKTfBl30=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Dx01quVHZZXQktsif4M9LnKM4DrddJjcDO9NVOcQiA5l62Sl/opm4MzMUDkDrC7yq
         9U8H7ekNAp3AKro1U7kmwAFN96O2EYIvu+1vxvcxLWUBFFC4U5q9pc2vx1mqseheJB
         KRBFMgvLQO8najVGYYhno1GOQv5xs9r5MUdmxoNM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MaJ3n-1hnTrR1IoP-00WGtm; Tue, 20
 Aug 2019 02:55:59 +0200
Subject: Re: [PATCH] erofs: move erofs out of staging
To:     Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
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
Message-ID: <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
Date:   Tue, 20 Aug 2019 08:55:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kc20TgGuw6sblKpmXo42EZMsKU6JoI52i"
X-Provags-ID: V03:K1:1DoALE6zLp0BOjDrRvwy8lSZ78vFXbxR00FDlf85TiEYMJ9fRzv
 6XSuXy6TmrRMX7d/lNibdo5X5dUYyxkSBc6XMnJ7CaywKHdYExKQwhCFSyi6RyWf41+ewyo
 jJPPRPhsfiT1Lhu2RVbRNg6dZskH+Z2OoECWBUs92KASIdG8hnoKSI1mqdHX8p7cGr80K7u
 TeKo+oN2AE01pQVBp2SFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qnJZy78ZZPA=:MFYdad16o5oGDiidcEGy4n
 nQ9xtDjAVStd+6cgIrdbbwojBJrd/2t2Qo2qIJMlKs7LA2j3Ks9AyD+4AczrQZYdhBVnkj5za
 q0oDp1w8hZyey/nAQZTUxPfJH6wbXI4FnMYEKka+a0hsYKqmTEH2C+lyo66MAQUVcyhWIWoqc
 UUIXA7elrtiYX1cnH1Ayw8aggFwFJJq1Rs/Sr+yjTHeyJOvmVLCHkKo/CUr/57NJ39mN/C8RV
 jMv96wmX4A/Ww56tlNukFFAG3yVHlMR+cf9PnQFDPp2/9D/NdpvVA3PVOMh60F++X/+geQD0l
 nG5hrP0MzEXHKIV91LIOolYuyuhb8te03mp+ONp6xGN6tjJX6giKtbUl3QV1jG2X5UYr+IKq7
 BIdEJeAvOtXL7GHKtD5dInLuoAI/29l+20JPcfXv6SiM19sMV45RCQY9B/8EcLVuweLG5NoE2
 XuMjl4Z/hkXSG0DAkD/ty4idWMZwPD2+GeKKYo9I7v+Y5dvk9kqgbGSBDkbbeHPbZwaTqOo35
 iG1chpFn7g7rh6jDf1Clqig4H4VGawMUSxwyUfYjcviwUYjp/YX7sQx7uyqp6oHE9zTdkXCsb
 X0ks7cF/9YoeQKvJpgcTjt3Dy7popeE3TgJph5+p87E3vMAVcw8kJxBfLk6zNKH8vxEPph+3k
 F4VKGcIK7/PqaCJ0dH7JgwZIdrD/aCguMr2Zm8uy1EYj8R8Lw9xLQQKB5LO7tmxCasHtsbrmA
 UteC/GjXJASV66dqG+KIKY38vNfE/ZeMuJzMy8VPToYK+K7ZkI9RCDPjijaE1nnC+MaEPq8vb
 V2BeIA1HkvWyPGmGJiB8uCmRLGzzaCtjaaltjFwbJYfm66x8oXWHuN9hjeOu0TZwQ8IICmBoR
 /aiM/24robn6ULOTmfYEdYBcLz68TgUaWg/XppU6GlQaBqAUY7ZMqlqEYpw8jzQoykTSTaMer
 O2JzTWdxr5cakkQxNVjCmXloblC4Pyf4qXlmtPQ7MeO2sZAGBgJlA8joFMsRin6WXD5ZvLzLh
 1rGfxRFmf3rgVvLT8czd1nuwu2353Q5ru6NZ/DqALHRuE+TGaelxvNb1zji1Utq1VF2ggXhjA
 +aDEP5zhhTmWjAvoNybrin8PmxZIu1ejuq4jUg0h2rkgmSxAmWFRWApwA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kc20TgGuw6sblKpmXo42EZMsKU6JoI52i
Content-Type: multipart/mixed; boundary="fjK6tUAQaCcRZsGhn3Ra1ToeeOFPMFrfF";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Gao Xiang <hsiangkao@aol.com>, "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Theodore Y. Ts'o"
 <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Chao Yu <yuchao0@huawei.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Amir Goldstein <amir73il@gmail.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Pavel Machek <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Message-ID: <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
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
In-Reply-To: <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>

--fjK6tUAQaCcRZsGhn3Ra1ToeeOFPMFrfF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>>> I have made a simple fuzzer to inject messy in inode metadata,
>>> dir data, compressed indexes and super block,
>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git=
/commit/?h=3Dexperimental-fuzzer
>>>
>>> I am testing with some given dirs and the following script.
>>> Does it look reasonable?
>>>
>>> # !/bin/bash
>>>
>>> mkdir -p mntdir
>>>
>>> for ((i=3D0; i<1000; ++i)); do
>>> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>=
&1
>>
>> mkfs fuzzes the image? Er....
>=20
> Thanks for your reply.
>=20
> First, This is just the first step of erofs fuzzer I wrote yesterday ni=
ght...
>=20
>>
>> Over in XFS land we have an xfs debugging tool (xfs_db) that knows how=

>> to dump (and write!) most every field of every metadata type.  This
>> makes it fairly easy to write systematic level 0 fuzzing tests that
>> check how well the filesystem reacts to garbage data (zeroing,
>> randomizing, oneing, adding and subtracting small integers) in a field=
=2E
>> (It also knows how to trash entire blocks.)

The same tool exists for btrfs, although lacks the write ability, but
that dump is more comprehensive and a great tool to learn the on-disk
format.


And for the fuzzing defending part, just a few kernel releases ago,
there is none for btrfs, and now we have a full static verification
layer to cover (almost) all on-disk data at read and write time.
(Along with enhanced runtime check)

We have covered from vague values inside tree blocks and invalid/missing
cross-ref find at runtime.

Currently the two layered check works pretty fine (well, sometimes too
good to detect older, improper behaved kernel).
- Tree blocks with vague data just get rejected by verification layer
  So that all members should fit on-disk format, from alignment to
  generation to inode mode.

  The error will trigger a good enough (TM) error message for developer
  to read, and if we have other copies, we retry other copies just as
  we hit a bad copy.

- At runtime, we have much less to check
  Only cross-ref related things can be wrong now. since everything
  inside a single tree block has already be checked.

In fact, from my respect of view, such read time check should be there
from the very beginning.
It acts kinda of a on-disk format spec. (In fact, by implementing the
verification layer itself, it already exposes a lot of btrfs design
trade-offs)

Even for a fs as complex (buggy) as btrfs, we only take 1K lines to
implement the verification layer.
So I'd like to see every new mainlined fs to have such ability.

>=20
> Actually, compared with XFS, EROFS has rather simple on-disk format.
> What we inject one time is quite deterministic.
>=20
> The first step just purposely writes some random fuzzed data to
> the base inode metadata, compressed indexes, or dir data field
> (one round one field) to make it validity and coverability.
>=20
>>
>> You might want to write such a debugging tool for erofs so that you ca=
n
>> take apart crashed images to get a better idea of what went wrong, and=

>> to write easy fuzzing tests.
>=20
> Yes, we will do such a debugging tool of course. Actually Li Guifu is n=
ow
> developping a erofs-fuse to support old linux versions or other OSes fo=
r
> archiveing only use, we will base on that code to develop a better fuzz=
er
> tool as well.

Personally speaking, debugging tool is way more important than a running
kernel module/fuse.
It's human trying to write the code, most of time is spent educating
code readers, thus debugging tool is way more important than dead cold co=
de.

Thanks,
Qu
>=20
> Thanks,
> Gao Xiang
>=20
>>
>> --D
>>
>>> 	umount mntdir
>>> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
>>> 	for j in `find mntdir -type f`; do
>>> 		md5sum $j > /dev/null
>>> 	done
>>> done
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>


--fjK6tUAQaCcRZsGhn3Ra1ToeeOFPMFrfF--

--kc20TgGuw6sblKpmXo42EZMsKU6JoI52i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1bRQQACgkQwj2R86El
/qj2cwf9ElVncfkkFaQj51k9ujZukPC9oqBVE8mfeOLjhEOCT5xPdPXvMY5BXtln
OFTFnouVpBanQEXFpiTCh3JIyFWzsMQJ136GEsWGZ0KOklgLtlDUrl1xPAlRRkvg
+Z5CL0BO3ujxeLxhRJWyRNHypE7tzKIPhM/k/9Od/4zzpuQpgS09GqFtINhlO7Ub
ftY5FpJngDfPMAfh7EPqZcRcT7q4A6PRME5sVQDPiTiivdExliODTDC4HkVi9O4Z
UPGsHQnZmyJM7r14FFmguIL3UMmwOpXfL8uKy8Enb0Kl+tNFxRwNbBGXVQZP2wSG
QOiJjuO9VFuuY0PIlIQmpY/Pdakx9g==
=WMVP
-----END PGP SIGNATURE-----

--kc20TgGuw6sblKpmXo42EZMsKU6JoI52i--
