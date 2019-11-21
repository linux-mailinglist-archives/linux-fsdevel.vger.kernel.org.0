Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC91104F7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 10:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKUJmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 04:42:22 -0500
Received: from mout.web.de ([212.227.15.4]:43043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKUJmW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574329241;
        bh=YIoQTG4bDJnKMejs3T7ERV32Zk7VF12+dw41Hf+WY34=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XS6pFtakM7xygGm3VV1wbVc2vQcRaQREjrAtuKh5fYK0wPBd9/qFpSNFL4UP4MSl2
         l5ciExFgOpAUoIelKdDbPj7Nx9PiszZlx4YCy3l16a0Fr3EmWDGyELOAbmwMHeUATa
         tk8XPQxlwGiazHaA1jEPd2htX45mA8BSHGE5S2pE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJCR8-1iZMZv2XVK-002mUf; Thu, 21
 Nov 2019 10:40:41 +0100
Subject: Re: [PATCH v4 02/13] exfat: add super block operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
 <CGME20191121052915epcas1p30f42f12990926942d24aa514ebc437ac@epcas1p3.samsung.com>
 <20191121052618.31117-3-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <177371e7-9f52-407c-4f9b-ec9efb15f4a8@web.de>
Date:   Thu, 21 Nov 2019 10:40:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121052618.31117-3-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R1qBJGD04r4jJmDhih46YCu5L63wsz8Wovz29qWssmwhoW69GdB
 +MuYe62XOQNuOduaul5SpxHvEGx5dEN3+WF9wEhrWIXozbjzwnnasvIbQ7FHukmQjZSCHdc
 1t7WACxEyec2t6SljebB39ELasNathu3S9U7bIpsxZlgUaVs7qyNnFgn/tDq+mQSuPZr5FK
 bVejRx6FelN+klLZPG1Mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mJzi07PvMXQ=:nwfIfXIiriwYwJIpQiNnb8
 HWPHXzD191YUsvg+EadngBPE32OKRUgp4Qif3xJi1HbIcPqZkAXhhdNhNVodN62Yw6IYYKcyv
 T6pNQb5rhtmxRTM2fwiG0z9/glH7L08uSeok7NxDcnjHN/5i/kgemrwfIYN9xc7705bPbgD8n
 Cmo29g1WNWmHRaKkWf7zBEPNnmSWpWH5jnCrcTf7QXPG2OUrQoqKakobhEFvTt/RhKB3xwwTw
 5Qlk/iiLWmMDxqNoUl+IImfjzf5tsDFht7q3PXAjLqWxuY91s3p043uCclo0VPguGPf5j6j6k
 68a9t0GDwA05YI17LGlpIZjuoBFxtUN6aak+llX4/r2LP4Zdt1kHtF1gedZh4hWjLwZPNW/Ff
 T10Lqw4Fi68ODeNXYdxcQNVrC27nZgmvt5rKcKRwTQmYf2TSJRee7eFtRDvizCoH6fp93XO1x
 b34USURAKiVXgtJ7g/I6NzB50DzjtiMXtgsTv6gc4vm4SeQkAxh6V3sBPm8QlG7efhpf1v+Wa
 oPWoxiz6HYycN09OuSGaEfXE+jJ8s67NnKPN0znKX7SZKQ+ooFh8f+0gwPU3To09mKVPUuz87
 y+dpRYFhbpbOCu4TyLa/y+u9fvGj9ylcmgq7KFXgf1ROPjrtrgfxDbZbKB/vZLOScfmPKfka6
 UCyy0hB4oH3Y6hoIK94Bs4lnJM3b6dzvl/jtsw5nQJETaT8lgRGWIQeDzrA6US3PpMXS3vTdZ
 QMCQ7zMwViYug0RxKaYq+7Hs9uv5yLKKgbLXIbMVAqZ0XUBAE/7X5w72VcV56bnEoPROqlZ9p
 w14yLVhDTtEZwfyMvEU/DxymWso/Gdw4+s3gletEJWQgw1vIqMfYVKE0k78DnPDoKI13sanZ3
 unbq+sdfFfUYEScwRVc6sjjywr2FtUwD+Zl0esnA/5d2BjyeGYypmcjZi9w7ylxQSbmAQ4qWY
 h04X6wzk2CDEXv9JMmye62yz3mbxdsBFCjsrpd937B5eDeWDsl4hV08pCzFqFJnnv8YwDEzQR
 CGiZCpg6EzFInRwF8Ij9o/fRGgq18NdoNg0QpHdLTgU7wTRmy7GeBbryWx3M27hd/kBTdXDYx
 /SiYDnOHE7vCrY5YoEKdV0x6zxrPmBP+3sT4FglgRKl/yfxZnR2jFyuHe2rkGr9XoPHfSva8N
 EoR8AMq3WJDwztbHomyRr/FFGaY8ByQmNB+faDYXrFtfg2GrZ0nPX+5UEIddDeoOaCtvALHZv
 qAHwkaPiNTuSKI4BltMb9ZmDmu5M4Xryx8763n/3ch3xOM820DlxQI0GkUjo=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/super.c
=E2=80=A6
> +static int __init init_exfat_fs(void)
> +{
=E2=80=A6
> +	err =3D -ENOMEM;
> +	exfat_inode_cachep =3D kmem_cache_create("exfat_inode_cache",
> +			sizeof(struct exfat_inode_info),
> +			0, SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD,
> +			exfat_inode_init_once);
> +	if (!exfat_inode_cachep)
> +		goto shutdown_cache;

Should such an error code assignment be performed only after a failed func=
tion call?

Regards,
Markus
