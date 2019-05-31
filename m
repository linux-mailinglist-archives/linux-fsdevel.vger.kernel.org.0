Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DE3083C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 08:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfEaGBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 02:01:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:49001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfEaGBt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 02:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559282498;
        bh=wdjyp8LxQUexU/JnkGl2p4FH3k562B3lM/o97kkiAkc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=AlC/tIxm9twBYrfAXdxNZBdovXSionCJeLsDZObtVB2578HKHARF18JTyz3NUr7Y9
         vBVX5XNHfomN35EEexjAd8gBFkUbLAOXW5wJXZywxXbbWlAqTyJqi8TTdcuKqJlIXS
         qa1/QX8EvBE0fWUlFfn+Gz1NpjzNqfTCIwHaJKxw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M54L0-1gf46b3EmU-00zI1P; Fri, 31
 May 2019 08:01:38 +0200
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20190528082154.6450-1-wqu@suse.com>
 <3ee71943-70f3-67c9-92ed-3a8719aee7f8@oracle.com>
 <9218c153-f452-a4bc-f36b-d400bd835c86@gmx.com>
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
Message-ID: <bf97dd01-6d9c-4a8e-cc5a-1448adc47705@gmx.com>
Date:   Fri, 31 May 2019 14:01:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9218c153-f452-a4bc-f36b-d400bd835c86@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0epWDmvW75sFqiIKEsoOdN4Mg1GWzAtoc"
X-Provags-ID: V03:K1:CFpto+PxMy1Vnn/ifnjs9J4D3oF1of/snUcaj9gsoS50aW+4PsE
 8OeS1+6lGUU9pOsqRz+Ihxc4oNev6xEmIQ1FoYE5a09v0yOFHtNyNTzjuKsBQNPWCu6vSYV
 XeYfGe6lez60qrrTJkQH/445kkTPWBNGbJINaCXKrGh6DknxLm7rpCFEsLNvCM2RsWT5/rN
 IwWQHZveE9SczDWlM8ydw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0yRWkOxDSMo=:7UTJjWZfvVBujEUm87DWVw
 pX4co7eBEQ/Ps/+5/snSB+y1xZihToHJ0DBmcpepqgTVB+IXeNnefGb+PMYAu09qH564booCW
 L+yxxJp3Y0CZSFbsxCW//OwsTeRA+N0/frTsaAjqsU2JAhvmlyVKvGpR+chzpwyHPwYbzLzOZ
 9X6oLafBVi2dVWlMfaRGSMyNqBH+IEDgrxwa7dJDiXShY/rjX8JEyP79mS6Z4A4IstWfjppt1
 5/faZfcILgpJLJeESXwdrLH7W+ZrFixoIdG71FQi/rZ/zy7YSTNJZ+/ABUcxPj/kr2IDd06wF
 AHVTL+s9YM0ePSvL2I87pW4QYSWx9wAnRqNv6+NJ6jPinbXU8T6adJ7UxKjfqlRW+DaBdxrxb
 riFD2QqB/4CVQcpm3oJAKbJImZX2hcg81VBtYLUztmkEpGSGbY39a6LXHhmoEBWYyHjHAGoVz
 ADcfxa19zfm9MFWr0324ufIC5BWgGhleCKKCHP+OQpucftrolqRXOnRq6ltrynVbRd+p+ZxOE
 a3XS0XO8V6eoxgpXNrM1xls8Y0QiB9Bkc9M6SjC+HYXQH07OPpIxa7s6audnJtboQhi9cQYP4
 mIU8FkVbLBqzF/RBZVoIVfSdmxpfpxfQSaVBnXUTSG1u+o3qjalV7G9eMQFc8956mi+MXDvyh
 uQiT+y9mRZcYawumWpvF8r2wuQvw07tNCR1LmGg9RQQ1KuzkESnvSX4Z0Kea/DKsOMIPAYZkn
 S3tymSbGWSNKjdz9cd08wzWuMvv83ASz8gY6iJpTJrrG3ni7CEUoroyIEOfIGIerZEL0Wrcaz
 yV4Lz1SBOJ6wthMImNfnBk2YOXBHrbe+rPHVjux5qhzC3CTC+P0Ap7y5UQY88m7v5asTJAoFo
 BsNQB/CqjAcWO90206IvMYlWzT1ZNj+cy4b3oFa0SJ6qV8BqGkBl8Xu7PIwg176idgKBVvcbs
 m4Sdw6BSc8WEc5dbMAZ2U14ODQd3GeTQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0epWDmvW75sFqiIKEsoOdN4Mg1GWzAtoc
Content-Type: multipart/mixed; boundary="mCYkYq9N2HiaVHNZ3ZLEsksY5narTGd2N";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <bf97dd01-6d9c-4a8e-cc5a-1448adc47705@gmx.com>
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
References: <20190528082154.6450-1-wqu@suse.com>
 <3ee71943-70f3-67c9-92ed-3a8719aee7f8@oracle.com>
 <9218c153-f452-a4bc-f36b-d400bd835c86@gmx.com>
In-Reply-To: <9218c153-f452-a4bc-f36b-d400bd835c86@gmx.com>

--mCYkYq9N2HiaVHNZ3ZLEsksY5narTGd2N
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 2019/5/31 =E4=B8=8B=E5=8D=881:56, Qu Wenruo wrote:
>=20
>=20
> On 2019/5/31 =E4=B8=8B=E5=8D=881:35, Anand Jain wrote:
>> On 5/28/19 4:21 PM, Qu Wenruo wrote:
>>> Normally the range->len is set to default value (U64_MAX), but when i=
t's
>>> not default value, we should check if the range overflows.
>>>
>>> And if overflows, return -EINVAL before doing anything.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> fstests patch
>> =C2=A0=C2=A0 https://patchwork.kernel.org/patch/10964105/
>> makes the sub-test like [1] in generic/260 skipped
>>
>> [1]
>> -----
>> fssize=3D$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"=C2=A0=
 | awk
>> '{print $3}')
>> beyond_eofs=3D$((fssize*2048))
>> fstrim -o $beyond_eofs $SCRATCH_MNT <-- should_fail
>> -----
>=20
> As I mentioned in the commit message and offline, the idea of *end of
> filesystem* is not clear enough.
>=20
> For regular fs, they have almost every byte mapped directly to its bloc=
k device
> (except external journal).
> So its end of filesystem is easy to determine.
> But we can still argue, how to trim the external journal device? Or
> should the external journal device contribute to the end of the fs?
>=20
>=20
> Now for btrfs, it's a dm-linear space, then dm-raid/dm-linear for each
> chunk. Thus we can argue either the end of btrfs is U64MAX (from
> dm-linear view), or the end of last block group (from mapped chunk view=
).
>=20
> Further more, how to define end of a filesystem when the fs spans acros=
s
> several devices?
>=20
> I'd say this is a good timing for us to make the fstrim behavior more c=
lear.

Also add fsdevel list into the discussion.

>=20
> Thanks,
> Qu
>=20
>>
>> Originally [1] reported expected EINVAL until the patch
>> =C2=A0 6ba9fc8e628b btrfs: Ensure btrfs_trim_fs can trim the whole fil=
esystem
>>
>> Not sure how will some of the production machines will find this as,
>> not compatible with previous versions? Nevertheless in practical terms=

>> things are fine.
>>
>> =C2=A0Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>> Thanks, Anand
>>
>>> ---
>>> =C2=A0 fs/btrfs/extent-tree.c | 14 +++++++++++---
>>> =C2=A0 1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index f79e477a378e..62bfba6d3c07 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -11245,6 +11245,7 @@ int btrfs_trim_fs(struct btrfs_fs_info
>>> *fs_info, struct fstrim_range *range)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_device *device;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *devices;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 group_trimmed;
>>> +=C2=A0=C2=A0=C2=A0 u64 range_end =3D U64_MAX;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 end;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 trimmed =3D 0;
>>> @@ -11254,16 +11255,23 @@ int btrfs_trim_fs(struct btrfs_fs_info
>>> *fs_info, struct fstrim_range *range)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int dev_ret =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check range overflow if range->len is set=
=2E
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The default range->len is U64_MAX.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (range->len !=3D U64_MAX && check_add_overflow=
(range->start,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 range->len, &range_end))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache =3D btrfs_lookup_first_block_gro=
up(fs_info, range->start);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; cache; cache =3D next_block_gro=
up(cache)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache->key.objectid >=
=3D (range->start + range->len)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache->key.objectid >=
=3D range_end) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_put_block_group(cache);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start =3D=
 max(range->start, cache->key.objectid);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D min(range->start =
+ range->len,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cache->key.objectid + cache->key.offset);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D min(range_end, ca=
che->key.objectid + cache->key.offset);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end=
 - start >=3D range->minlen) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!block_group_cache_done(cache)) {
>>>
>>
>=20


--mCYkYq9N2HiaVHNZ3ZLEsksY5narTGd2N--

--0epWDmvW75sFqiIKEsoOdN4Mg1GWzAtoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzwwzkACgkQwj2R86El
/qi+Bwf/TdKn05UfFXEdAwtBpCQ2NI2ZTXL6FBnYZGdOY7v/gcr6anGsUP2aZCGT
/wb8Tuz5ILMoPQSMbmh+wSPfuSu2G6wMSs+SX161fNI7nZtfWzIyOKfs1kFgm4Kt
CNalIq6tMwRDsH8AighQB/2LXSnOfZhezaxzYsMqvdTsZ9h/j2vDkqPzC3l1Dy5G
IPL+dsv9+jNNlYKOlEfdxHFNEoK1rkzXCYJWcm1Id73WYN+yCu+9SMDesnZOveA+
xOnYDqa9lA6Q5nUJcAUOJ7t/3/62GU7UuqyUrpimLtLJ1jP3Pbs8DQfEiBN9p20S
4aaV/ey+ioobiCN+3heZjdn9hyLPuA==
=k0Zi
-----END PGP SIGNATURE-----

--0epWDmvW75sFqiIKEsoOdN4Mg1GWzAtoc--
