Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7195480
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 04:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfHTCk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 22:40:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:51943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbfHTCk1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566268768;
        bh=XFD/O+kTU7Pa5pUSpZUbhX3uJjyCLY7mxh4UOLO+LSU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hExBBJm9K6NDihDwGEqq9edxBBchzJpJyn/q5+NK5xkZHTCzBrIhbV/qMkqGKSAoi
         mAf4ROx3g1xP2s3jQboI4OzBWJOG5Jr0op87NoOGU9ZZoaCogY9lkjM6kV/N1d0/y1
         aaS9T6gomoFrekWF9ypD6dHLfmxDXbvL1ErPatfA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M9vnQ-1i6Wpj33HM-00B20h; Tue, 20
 Aug 2019 04:39:28 +0200
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
Message-ID: <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
Date:   Tue, 20 Aug 2019 10:38:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZcFaNUhdca516snD5gfrUpiGczpht7Jwk"
X-Provags-ID: V03:K1:c2p9VE+Oz1e5Qk9cae6kGxHfsuxDqRoZQNqi3EJlrAqBTozsbkj
 RBlyMfdf/CJR7aYqVvyczkHFhBenXqnIl54ITMgffRqrmjguV9f1rwyiGQg9XP/1f9QB8DL
 6kO0WCpSIuvb5IXUitktI/HUH005hVbc4xLcdSlr08IU+eFpzuTPGLQ0qSk1/CTJj0Bl7R3
 C0D4qu9/jbiVAAwN49EVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OXLcyGgh4uU=:6wlt1Yh+UQD8Cpyk1zXUK6
 iFtr/ngnL+V1EmLxSvtWcMF4RGV+v+AiPBFbNrN7D0bnML/jKibsYZUuUDNBOdP0vRaOgKckd
 dO91jWb6mzXknUy6BPWhT1tI2N1RkxOPhdmGK52IvvhK2TmeNN3vFPQUzyv09VEzCLHowgI6/
 HRrTo+b3lMd1Q/BJS6w8SVoWPN7xMrtc60Ux6DA0OpK8aTuWTYut7NcHpxrxAPzsKzqaFq3s8
 kYBpKnL6jQ2vIBi0jHyIBZCJlFQ57bL0XSF/Ov4MXReygnCaop8gwOoQqrzfmK8exvnTFOiY3
 nkOT3dzhmYHGJO0ampYxZHTQpINWuUAWknFIkYvACdblnUo/eEEhPAReOGZCkLTxBAbANH2jE
 vVmEfUkKm3VNZkakXCRvvaYo9U+DDCxMAJ6PZc9Uh8GjoSTGi8gJfjSWwddsNvMOdnGOYx5Ni
 aVfZzvZnlFKjUXWgqG2ASJiVfKvdRfFZk+JieoOzW+e7uujVHK0HDA1Ajx0L40q82VWNevkUo
 bIFaG2pZhE6GNjCR7owWSFwgvZLL2VdUCs4ojI/K7cHChtgP97UkY7tw7iV2HHQ0fCDmo/k/M
 BB6X/64+znw9k2hWLL7sxYcuKkI4w7/gPg25qnenrn5gmt0diV6Who376VG/40WLbTIOAvt3+
 Cv2ybuMsriLRq5CTNWSMu2UA8qc86niIU+BeoOfQPiKZvNjVwQBDUUz6daOMwq6FV4g+nGVVK
 tbgIZBTWHlrZ7cqeMbN7H6if6LExapfXOIWq9P7oTGzTWJ/LHjef/zVF49agrfSFuQwrvaA5L
 YyfFggK8k1mX7R2oplnKqybtO3VlTNtkeZcYVlazJZM3oyy9J92zOQJTXeyxesU8AI/7Biwp4
 ahtp7weBddkeA0WgTOfNU7RFv9Y5I0EUTxcmqZz5o57i7DqXbuU2AflecmCyHMeZfymFVaUuM
 WnPLMwNJeY3G7LBEDazDTYz5fDR3XNQcehnwj1pViVMu7ZF+/NaueOG+HbYPBzq+jGgktFNQT
 OrGI9ZntL5WC/vgnM28tFQX87I2dIi8Yp65mwTj7SV03gTk95cd93NEbDAWsPbJ4aZiCK+LN1
 pQRvDsx/RICVr0TCDkU2yNmAvUe76vwuXLPATRTqFDuDPB4oN1s7eKB+w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZcFaNUhdca516snD5gfrUpiGczpht7Jwk
Content-Type: multipart/mixed; boundary="KOLhSQdbj64o9tSdc1Tfy4Jf4WtOuzKjP";
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
Message-ID: <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
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
In-Reply-To: <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>

--KOLhSQdbj64o9tSdc1Tfy4Jf4WtOuzKjP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/20 =E4=B8=8A=E5=8D=8810:24, Chao Yu wrote:
> On 2019/8/20 8:55, Qu Wenruo wrote:
>> [...]
>>>>> I have made a simple fuzzer to inject messy in inode metadata,
>>>>> dir data, compressed indexes and super block,
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.g=
it/commit/?h=3Dexperimental-fuzzer
>>>>>
>>>>> I am testing with some given dirs and the following script.
>>>>> Does it look reasonable?
>>>>>
>>>>> # !/bin/bash
>>>>>
>>>>> mkdir -p mntdir
>>>>>
>>>>> for ((i=3D0; i<1000; ++i)); do
>>>>> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null =
2>&1
>>>>
>>>> mkfs fuzzes the image? Er....
>>>
>>> Thanks for your reply.
>>>
>>> First, This is just the first step of erofs fuzzer I wrote yesterday =
night...
>>>
>>>>
>>>> Over in XFS land we have an xfs debugging tool (xfs_db) that knows h=
ow
>>>> to dump (and write!) most every field of every metadata type.  This
>>>> makes it fairly easy to write systematic level 0 fuzzing tests that
>>>> check how well the filesystem reacts to garbage data (zeroing,
>>>> randomizing, oneing, adding and subtracting small integers) in a fie=
ld.
>>>> (It also knows how to trash entire blocks.)
>>
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
> Out of curiosity, it looks like every mainstream filesystem has its own=

> fuzz/injection tool in their tool-set, if it's really such a generic
> requirement, why shouldn't there be a common tool to handle that, let s=
pecified
> filesystem fill the tool's callback to seek a node/block and supported =
fields
> can be fuzzed in inode.

It could be possible for XFS/EXT* to share the same infrastructure
without much hassle.
(If not considering external journal)

But for btrfs, it's like a regular fs on a super large dm-linear, which
further builds its chunks on different dm-raid1/dm-linear/dm-raid56.

So not sure if it's possible for btrfs, as it contains its logical
address layer bytenr (the most common one) along with per-chunk physical
mapping bytenr (in another tree).

It may depends on the granularity. But definitely a good idea to do so
in a generic way.
Currently we depend on super kind student developers/reporters on such
fuzzed images, and developers sometimes get inspired by real world
corruption (or his/her mood) to add some valid but hard-to-hit corner
case check.

Thanks,
Qu

> It can help to avoid redundant work whenever Linux
> welcomes a new filesystem....
>=20
> Thanks,
>=20
>>
>>>
>>> Actually, compared with XFS, EROFS has rather simple on-disk format.
>>> What we inject one time is quite deterministic.
>>>
>>> The first step just purposely writes some random fuzzed data to
>>> the base inode metadata, compressed indexes, or dir data field
>>> (one round one field) to make it validity and coverability.
>>>
>>>>
>>>> You might want to write such a debugging tool for erofs so that you =
can
>>>> take apart crashed images to get a better idea of what went wrong, a=
nd
>>>> to write easy fuzzing tests.
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
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> --D
>>>>
>>>>> 	umount mntdir
>>>>> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
>>>>> 	for j in `find mntdir -type f`; do
>>>>> 		md5sum $j > /dev/null
>>>>> 	done
>>>>> done
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Gao Xiang
>>>>>>
>>


--KOLhSQdbj64o9tSdc1Tfy4Jf4WtOuzKjP--

--ZcFaNUhdca516snD5gfrUpiGczpht7Jwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1bXUAACgkQwj2R86El
/qjkEAf/VTTYOgUl4tgxaElwD2C7rGAHcRYrpcwv9PjSrWg84AQX+xrkZP0sJORB
LakpTHdqA/18MdWz5gIZUtxsSxylPL6Uyj5CPKGoNl8sjIz0tuvN85iv1zzC+nrA
H8CMwH/LJzfnG+35fSmc5B0l1mndGYJJsF90nndbjHvHBvGJ+F78LYnexV4/KAgM
9fECezanTTdL8dUmHsfQGd0dSiFoxs6qSXcumMvJuHjQoxAJXvHc8BXr2k2f9V/C
M6FEc98KgXUq5QW9Ak9vRoizH62sIKBFEmBUlXJKzfgxmOC+gTjwlM478n3g4J90
P9LVZkt+/5zj2dtV5XbuGCoIM2jY1A==
=0v8N
-----END PGP SIGNATURE-----

--ZcFaNUhdca516snD5gfrUpiGczpht7Jwk--
