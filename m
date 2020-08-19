Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E387249B4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 13:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgHSK74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 06:59:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:56299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSK7x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597834792;
        bh=SrqxU0xbsavoq0YcefrpDo4RCPiBfZRQw4lftp6v4FY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Z/VPW/KcrWDqvHjehbNx3p0fZGbfbbEBFcS5//DzgpTBpQWrXyu+KZk1Cq1Ok6SVm
         ApAV4kphc+yjEPcOJxWGE1NExN5G0u7eIQe0SMvoJxsraApxD/vllmZBy4m5A0corZ
         FR/CaGdRRhjuDQdJZSHDevYIdpec72WVUJIZvAF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC34X-1jw14k1EjN-00CUCp; Wed, 19
 Aug 2020 12:59:51 +0200
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Is there anyway to ensure iov iter won't break a page copy?
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
Message-ID: <5a2d6a48-9407-7c81-f12a-9e66abdf927f@gmx.com>
Date:   Wed, 19 Aug 2020 18:59:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YS3LfMq7Obc17Cgw34F1pmMF3e0U1OOEF"
X-Provags-ID: V03:K1:Wo0KMuPMJ4G11sGCSnRPfQykVw55DQiYJ31DztLx7B5n0rn/K9n
 Yhmc9otx+tP5OL+RlhwpxoR4mbQmT7wD8t9j+DLmIHdNiJV4vceMqeN61KjGJBADaglnsRC
 62AGkpyFQM26Vev4hLS+GpLEXczsCQC6OlBfe0B0qotq/k0O+/8TuCGdsv9YBGwOS1NnWmY
 ySqYztBnsonnX8e+8x1Mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1bOYJQBHhpg=:tm7svYcAMaFupeBhwSiS0Y
 feWMK9pXKtcxfvSNJrrgXufyjHuZEKmf/2/bj6GguSJSYt2gGU52IbHQwoZ0jGJnZM6BkFPqT
 3RAyA4otb2oALEh3u9+dObo4hBD+0R0JjozoYTYmuMQgTYD2WRiv485JtDbaJHlJ+tzgBVz+c
 NyUFmLO2lfiK6rd8i2oXlIs+xQvPt3I2AlydP5nw3Gi8EyhWQV5RIiXdn4scN5dD1xxQoaaup
 WFjamAy4+RCn8TeDMEP6socW/pfnq9rO+W5JoCHV+MzlL2bnV2BBSiDjKMDA8r8Z9EnHGGNc/
 YeD2mNLib5gam8AU6DErncGmVV1pvwJi6QuwEBxz40jmtYjtsTacm6JH50sriHupSX3qHdVQS
 Hd95AQtaKx+9dv/y7L1FRq5Y/MThWtJ8rMPZYCl55sDq2ciYFrK/Zf2RlaJ2mjvJ/CW1HWA24
 q6fIbvICl5S9PWr+4QrOWf0sRs7xUEx9ZzVOFtdUY/Jq+0ZYio5CPuuS52UusKAl1XNLhGMaO
 kJ/5HWmMJTMDxbqiOwiYz8rLjmbEmjrRM0ABQzUOkd+XSMhc9Vj06sPLnTi5I2VBh/z16+p0T
 y6s7kEZB8pY9YFZXA8yNi/FM1d21ux7BvzidHcz9b/tE0udIA9HOFbeu+ZpgyTXWDQUbKIN2P
 6h7T3IY/osNWVZF+s4ZW6Kmf93Pj/x9Kl8kBeaLylCHDJhH61yckmOosupAHyJi8QtByTrc09
 IdtnZbeQ7uvVkVnpYGhVFgf2L7ti2Trmff8MVtrXV6jMJnWKGUTekwTmD3Ke8/sgmNJnkM+zn
 K17f9G4AJs42fKceoTQhEul8I5sDk1cpxPVu2u6I9oDWZIOAEt19isl7Op6fPiJYUtVej/utF
 auhzPWAQS0Vx9B5XdeUNWrziMdFXvRYyDyDlI8uU/ESQ9xcZ+VPA3+eY/N0iA4AvP2AzQIrdw
 PLGK/wXg1rsVTwMMb+Qzt4ymS3HNVRNgY35ixurC+4EOltIlYw9UFtX96pDqNVgRfRIhtwqUW
 s1k0lTQxpJL1JRTe/ufeBidwAUsd209ZJiExNkSs8ZB7Krz8uBuFlrMu5HqsmHu/VNkwE6o5F
 8HFoTtKXgj/VDNXqbplDmKxqLOiQEJg7ZOSPL0D7TRiSwcvGQ41WjGfL76F0vbNiVy2MQ+/uJ
 jLbkI7BvyUGUSqTZ6cq2quTqimbRXQXDuBS4KwkBA7mu+f5GfNu6Hpc7PjJaC3YpGjww3WMJm
 1pEmCe/cYemzq/ZcNsFRBr4OvOg4E9F8TMzZ+qw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YS3LfMq7Obc17Cgw34F1pmMF3e0U1OOEF
Content-Type: multipart/mixed; boundary="Eq7kZzjyncPjVc5jCZKNwXX3H6yTyCHsT"

--Eq7kZzjyncPjVc5jCZKNwXX3H6yTyCHsT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

There are tons of short copy check for iov_iter_copy_from_user_atomic(),
from the generic_performan_write() which checks the copied in the
write_end().

To iomap, which checks the copied in its iomap_write_end().

But I'm wondering, all these call sites have called
iov_iter_falut_in_read() to ensure the range we're copying from are
accessible, and we prepared the pages by ourselves, how could a short
copy happen?

Is there any possible race that user space can invalidate some of its
memory of the iov?

If so, can we find a way to lock the iov to ensure all its content can
be accessed without problem until the iov_iter_copy_from_user_atomic()
finishes?

Thanks,
Qu


--Eq7kZzjyncPjVc5jCZKNwXX3H6yTyCHsT--

--YS3LfMq7Obc17Cgw34F1pmMF3e0U1OOEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl89BiQACgkQwj2R86El
/qhcfQf/dLPdQdDNcgzc5E1TqOrvKcZCHmoQoN3+jP4fPxkyEPQ44KAfGdvuREdi
ZNy6pNU+VNTXXM5uo42ThjUiazQnMoQUGFux2n95fsY4qMwu6Fl++1l1wu1SARWN
zkPLqLvicZRReoxauvwRHRVxAOeDij1SCy+QFEobzC+Qk7gkoacc+4fQcS/bOtGp
tIwyWkWOo6+QIZ+8ihoE2ql/oJCHg/LA6f9VvaFoMptxxxTb/b59P94JziI6OT4B
LAEXHRwpU6CP9Aqwlm3Lkx2pggruL4R6R785CLJKbUhsxfpMy+lFiWNm4G+F+HIt
xb3wsG9ZgiXjH5WiSwKLloWq2St9Yg==
=UoDH
-----END PGP SIGNATURE-----

--YS3LfMq7Obc17Cgw34F1pmMF3e0U1OOEF--
