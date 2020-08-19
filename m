Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66454249BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgHSLjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 07:39:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:56597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSLjh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597837155;
        bh=003kVwM1Xe4L+XuwubolYpogwWTvdXK7IBjIg6uIKao=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NPrj7Yy2ODMEdMBHkVolNthaxSd3Xhydgsi9J0dcRa1EWzFuhSz4C2FsleeAWnl29
         6zMH5FJSo4d/81iWQg103DyWES82SE8oB6JL01ChEzl46EYe7PDvM3jH5CMQgUsRXe
         k0+r7TNOmM2f5GLukJmisIfy11MbHfrKR2BrsSfg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JmN-1k85Jr1soL-000OM6; Wed, 19
 Aug 2020 13:39:15 +0200
Subject: Re: Is there anyway to ensure iov iter won't break a page copy?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5a2d6a48-9407-7c81-f12a-9e66abdf927f@gmx.com>
 <20200819112252.GZ17456@casper.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <47cbeb82-fb2d-0092-d104-53d1c8180d48@gmx.com>
Date:   Wed, 19 Aug 2020 19:39:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819112252.GZ17456@casper.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1y62Bgh4nhgLo0z8jKyWn0jdRtrs2jOgS"
X-Provags-ID: V03:K1:8PlYqd1h0tq1pgLFofDajSkAGnu2BBW3pcHU7flk9hPSAdghIAK
 yy9VuouSDvEX0/rj4yc476WW2buBJf722dbsHNILihEAAemaxnnEKP6DTVgYloxOD9KkKe4
 r/5BSHUlI1mgteVHxvSIEp+G41kE8ORS7WUAoa9T1JYh06yweq1x6Eec342T2HiVphR/tgk
 jd7yHUQjb9S+S3OE6UUZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ucv64hTJpLY=:i7+F6dVqqFZRcFcpTk3Nzd
 2eNLrnE4e4QWnZ0IJSHLk6RGWUip/YxScmAo66yNaHdKjdPPy2Yb1GgBV4FPpBSR/VDdQO807
 JE0+O7TJJFpZH4wv4YC2+QRWZsgSyTVWDvsG3vXEAvwSEoSOXVVTY7U5gTCElzlEmb4+zbnP0
 s7Z94Jzs2NNdh9QOQn+gju8/GOsAe+Yls2pN7aOWQ2hFFx4mbatMObvJNZK57ui2peWJkxOl7
 fLPOHLBxLDOtjldolvciT3dSd4ZL/U1xjBapePILM9rvnS4Rh9QaMTVooaPiG+XYDdT1MIob0
 zZrhXCt8qgsdmyleRnrm02/zHbGjjRv/XtyrjIKMnMUjd3s31xe0n9thabtJOVjeazqauKH++
 xRpc7rrxSAtF1u8Ze35dEPUqyGV0J9m4nxphi1eSZOUSESjT7lRYC31jeTcVM9DnCVplmQbpW
 jX0UDaxFB6PgfyrP3p9W0LZngaelgWd+0ITKZQ6oc1wNlxMtXGGhMMkzOpwEO0i2GvRMdESwc
 Zi8jC+w53ceayYfWMWUXH9RWkMvndZoFrGMwrNMucHdlwL6lGIeP3mlycbPEg+E2WWiW4s1hZ
 9jgLuwyOP8AnhYXQmB2zr5PEEGNHXRneGbaKBVv2CAByMAR5AnMUKHDby9g1DWPJy7D6VooKf
 84JAb90JAYsRQsxvy9WEe4kjc91Hr2aCD0xJMj8baR/NTrkWSc88zUTdeuEvJAV6IFdDAaab/
 fIW5ZhUFasECg2CV1rbZWS2gj15eDgstHcCFJufjVYYR++FTqluMMdQINDsZsaEj9AaAiVJhI
 yNw3CdxUrN0L60XOYtTA0Jv0Y8G7Z5mVsnlxXOHiTybTdus/Mq8egHVD8fRC6cUmRDA09HFVy
 7NlLfnfZ2IcHjx6UgRoDvTnjutJMuICx++oTCJac1RM3PWCDd7UchWoJY4abLHLiFl8yJVKqh
 qe5Its8SJ/gGxsK5RwqejHDtzGSKv4BlZEFGDTAJSY7kh0+ZXefGleyyMM0qGNKgoshIlJYQT
 YmFqqAlM6QSAB4Lobb17j2fWRTU7C9BPwrCxWWHjlcHEyIxBHDMEZde4kmc/3MYBizZsVzDYY
 Mt89H1FOeHWDC8GvDg3me2ZvBu8zioPRcdOevdHh0C52KNLO5Z3DwJ8Z65RvdTAQWPoDgyQIS
 JEklBghsHrOLIH4FOP1QnG6HsI7swtorHiSa1GhTpUPlF58A6Gqh/In25msZXNeLTl/4sVFSi
 azTGUF9t9BwDi66Mv6fJ83WRNz+44rHziT7ukxQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1y62Bgh4nhgLo0z8jKyWn0jdRtrs2jOgS
Content-Type: multipart/mixed; boundary="fwS9MYtZgszSXGhxRexlDjJoOJrsfU5cT"

--fwS9MYtZgszSXGhxRexlDjJoOJrsfU5cT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/19 =E4=B8=8B=E5=8D=887:22, Matthew Wilcox wrote:
> On Wed, Aug 19, 2020 at 06:59:48PM +0800, Qu Wenruo wrote:
>> There are tons of short copy check for iov_iter_copy_from_user_atomic(=
),
>> from the generic_performan_write() which checks the copied in the
>> write_end().
>>
>> To iomap, which checks the copied in its iomap_write_end().
>>
>> But I'm wondering, all these call sites have called
>> iov_iter_falut_in_read() to ensure the range we're copying from are
>> accessible, and we prepared the pages by ourselves, how could a short
>> copy happen?
>=20
> Here's how it happens.  The system is low on memory.  We fault in the
> range that we're interested in, which (for the sake of argument is a
> file mapping; similar things can happen for anonymous memory) allocates=

> page cache pages and fills them with data.  Now another task runs and
> also allocates memory.  The pages we want get reclaimed (we don't have
> a refcount on them, so this can happen).  Now when we go to access
> them again, they're not there.

Thanks a lot for the example! That solves my question instantly!

>=20
>> Is there any possible race that user space can invalidate some of its
>> memory of the iov?
>>
>> If so, can we find a way to lock the iov to ensure all its content can=

>> be accessed without problem until the iov_iter_copy_from_user_atomic()=

>> finishes?
>=20
> Probably a bad idea.  The I/O might be larger than all of physical memo=
ry,
> so we might not be able to pin all of the pages for the duration of
> the I/O.

That looks reasonably enough.

Thanks,
Qu


--fwS9MYtZgszSXGhxRexlDjJoOJrsfU5cT--

--1y62Bgh4nhgLo0z8jKyWn0jdRtrs2jOgS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl89D14ACgkQwj2R86El
/qjd6wf/TknPRG7GLyGHzPY7kN4jvbrrfr7Pib9odPPPai3M7c6spa6ddyDRGTlp
0yYddQtMEB81jYewE7w1fZc4Nwiy817JYBETMtwI0kxY8V9zeyUbtYar0KwtKwbt
h3/It9DDX3FDzO+Ei2NjDIR15JEBX8jkXL1azl6SZH4KGRTYT/izZ9kCDl972sp2
/epoaypFiDYHqgmyncIx8zPAfVqnsYV80y4fLGACfONzj+eFTi86hl+01u65fkNU
jSOwknPsWP1ME1SinF7sAGJAses4LKu5VqtP7Qmcist7l8n78/fjGpCFly3x/sU8
dSvQSg3Txg3l8M1EhIKH8TYdsFPzDg==
=3FSV
-----END PGP SIGNATURE-----

--1y62Bgh4nhgLo0z8jKyWn0jdRtrs2jOgS--
