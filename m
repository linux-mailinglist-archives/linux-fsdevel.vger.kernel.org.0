Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2216695A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfHTIrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 04:47:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:40111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfHTIrF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566290783;
        bh=EBVlGBCVrp4icYHnuaKiKD9FrToj2NDpH6MM6Vo97lc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JJV9v6iyMorgp+P5rIi/fp1UTsuXteW+REqL1lFQ/q9FwgPpyT1JeK9yrz0OcSCAi
         vdcpWM1l3ique3/6TbCXMVFJz0GHQbczRWeMATVE9gv8KPpZya7fJDHY2YA9Rg/9iN
         GEvYem0LAReXuvfXZ+98mad/N28Ah97KRAhKafeA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Ln897-1iTHBT1qFp-00hQ9d; Tue, 20
 Aug 2019 10:46:23 +0200
Subject: Re: [PATCH] erofs: move erofs out of staging
To:     Chao Yu <yuchao0@huawei.com>, Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
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
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
 <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
 <c9a27e20-33fa-2cad-79f2-ecc26f6f3490@huawei.com>
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
Message-ID: <735b8d15-bcb5-b11b-07c1-0617eb1e5ce9@gmx.com>
Date:   Tue, 20 Aug 2019 16:46:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9a27e20-33fa-2cad-79f2-ecc26f6f3490@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4LVjIQCVca5X3T5GkfFKKDlO5YDcA3qer"
X-Provags-ID: V03:K1:1wqXq/0in6IfAkHB8akysmuzP9uzNyxmHmhAzExPc371ksQFLD8
 Cdt5AwTNnmMiYFAbDW6BkoUQ5T8DnWNT9tDAzkbqTk5jP1Ob1r0WLgr4yca+Ns9SZwjDu2X
 vkxKKN+M7bd6AkuTNBtZViIGlYmC1n9zfAYzXFKoUFCyq4gfVULmvt90V+b5m6SmsjEaHRT
 hA/DT864MFqJJ5XBPvvZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VS2uBzGSQXA=:Njk4aHa8Y50tGMR18ReoZa
 NmXttE2l1C55nPmuFyQrrh62SYMRWm9X36GKiZEoIUeM8TB2xwBr0jydBQe2n05nQ2nbXHpcy
 6M6eFHMrxuABqWR5lj9RtTBm0ehpbuWw77o/BH+s6WubSMMUJFfBMvIcbFcX6EdMPhgCLVkV8
 6L/3zLFR0XSDO+betOYm8G2iqOMGuwxvFpGPDfET8a3gs+0fshyAM+RlE0bqUh0yoEYk6za2m
 kvADanb80T+n25MOow/jvMcAFgPLC/73EpuneQV7YAC6Br2oJm4J2g6TH5Mo35Qs6vZaOU3AJ
 pz/t+vHj/48pFWOmGaB7fiyVCNcjryKkjJGwVqKPrk3bDRFKTmRGjUxr2KKBYPuIJpxVrcd+z
 b8l1R/6W1FyGA28UG7HBFj8XjpK0gPyABhSP1Gh+4He+P9pVyU25oFuRg75NQ9mvG/gwSW/fk
 P+EMjqgLsWXozwz5HXCA0xvUoc4mNki53NocP9MphwEKhda/8d6Alfzs8b5w0BZF7sS+eCz0A
 B12SPsbAlkKJAZ4bfHP9Jh2ykxKTrnSn5sPgH+XXIS/5qqx7NXINDWBTfoWfZn3Qec4Jwz3pF
 gcQ6j6uhW/U5vQ04EKEpA22zisTLbtHQCiq5OqVuqDpYjAsPwTbEmWw5afnXdN+fVkKyn0Ske
 buM2LE7dprg0u4Pu4Pu4WTyI6sWB2N094Qx5g14v6Jp+O3zd3+b40IxZCWNORqo4l9MCgUzhb
 Reo94c+tLiLdQwdha4vGge3tUXmfFL5YkMScvWonoSu8oFiY3lNcwyfyqTNvg14xEA0zh5obT
 hBqsMEZ9a/ZQXf58+jSEboVH6xD2Rbx/nwRe18sruv6e2dNt5N8m+DnocbEt5QTeoNi7VIQ19
 Zm6t90xt8S3hy4KOgDo/5FgRMW4AfCpkCoVbM2cLDfnBWNoFrzGnECmze2P/CpKOD47fM3Ev/
 TM9tsKwb45PT7J3d+Z2Iv1J/DVz+jHxboSMOB7KRZv98Um/sFmLOHvV+vPUMo/dw+nfs/0wpW
 wI0RHzpmoCoSU8+hBb/TZySB6WmtIMYliISUA41rGk5osjB5ayEYG1doBHbMtRe3wMriP68g1
 kMV74UgROZsV4NuYqHFk4kOTQaBkNxLm2HUaNpGl0oJ3Cb5LmjolWsxtaFtR3yUobkc9sMRXt
 oMvejVAWWtRNLHha3Q4/6q+M3N6tAjcW3Voxz3hsTcpPuDIA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4LVjIQCVca5X3T5GkfFKKDlO5YDcA3qer
Content-Type: multipart/mixed; boundary="slQR6rSH5UnNorxY9BmaW69TgYDvJmTLN";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Chao Yu <yuchao0@huawei.com>, Gao Xiang <hsiangkao@aol.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Theodore Y. Ts'o"
 <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 Miao Xie <miaoxie@huawei.com>, devel <devel@driverdev.osuosl.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Amir Goldstein
 <amir73il@gmail.com>, linux-erofs <linux-erofs@lists.ozlabs.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Pavel Machek <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Message-ID: <735b8d15-bcb5-b11b-07c1-0617eb1e5ce9@gmx.com>
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
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
 <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
 <c9a27e20-33fa-2cad-79f2-ecc26f6f3490@huawei.com>
In-Reply-To: <c9a27e20-33fa-2cad-79f2-ecc26f6f3490@huawei.com>

--slQR6rSH5UnNorxY9BmaW69TgYDvJmTLN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> Yeah, it looks like we need searching more levels mapping to find the f=
inal
> physical block address of inode/node/data in btrfs.
>=20
> IMO, in a little lazy way, we can reform and reuse existed function in
> btrfs-progs which can find the mapping info of inode/node/data accordin=
g to
> specified ino or ino+pg_no.

Maybe no need to go as deep as ino.

What about just go physical bytenr? E.g. for XFS/EXT* choose a random
bytenr. Then verify if that block is used, if not, try again.

If used, check if it's metadata. If not, try again.
(feel free to corrupt data, in fact btrfs uses some data as space cache,
so it should make some sense)

If metadata, corrupt that bytenr/bytenr range in the metadata block,
regenerate checksum, call it a day and let kernel suffer.

For btrfs, just do extra physical -> logical convert in the first place,
then follow the same workflow.
It should work for any fs as long as it's on single device.

>=20
>>
>> It may depends on the granularity. But definitely a good idea to do so=

>> in a generic way.
>> Currently we depend on super kind student developers/reporters on such=

>=20
> Yup, I just guess Wen Xu may be interested in working on a generic way =
to fuzz
> filesystem, as I know they dig deep in filesystem code when doing fuzz.=


Don't forget Yoon Jungyeon, I see more than one times he reported fuzzed
images with proper reproducer and bugzilla links.
Even using his personal mail address, not school mail address.

Those guys are really awesome!

> BTW,
> which impresses me is, constructing checkpoint by injecting one byte, a=
nd then
> write a correct recalculated checksum value on that checkpoint, making =
that
> checkpoint looks valid...

IIRC F2FS guys may be also investigating a similar mechanism, as they
also got a hard fight against reports from those awesome reporters.

So such fuzzed image is a new trend for fs development.

Thanks,
Qu

>=20
> Thanks,
>=20


--slQR6rSH5UnNorxY9BmaW69TgYDvJmTLN--

--4LVjIQCVca5X3T5GkfFKKDlO5YDcA3qer
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1bs0sACgkQwj2R86El
/qiHxgf9EuNDrR5H/dHCixK+MxIhu42YyiGiZIYxH9qGLoZN6JLd1FkWYuzGJrlv
96F5Y50vW6iPslAnlmp3tFdmeEI6IMCiELXZAKjZOzbaba2bdzJWJUG75ZGpdxay
IUaBIbOsiGealuKPcoEkeU9yzq9CtzoXgbLDt9Y5osokp0cRdzfzRVEUSQ/gj4QE
EzOVDdNwTZbaaZboFlaSD4hbEgkNFxnq9C3qn4trxe4pVp7oaeK17wi3I1KHXo0Q
I3griKjozf0Cp6rka4a3nCpZ/ML3busRZclXsLlnbHKGA0gQFpPkUqTrrojZORx4
wBuwYdhYEWzsLK0+NcDgCe2z/ZRCog==
=VtSx
-----END PGP SIGNATURE-----

--4LVjIQCVca5X3T5GkfFKKDlO5YDcA3qer--
