Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB781F63CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFKIkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 04:40:43 -0400
Received: from mout.web.de ([217.72.192.78]:58227 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgFKIkm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591864819;
        bh=zpUnNHx3y8WGBaVPPdHssJwROMHnN/kqwDTEvacxkS4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BDK5Iqdg1pY5TY88M4QE8pTgmnfUDHd5VRMUFfYfGQyZvu4qyI5FzIZD4Akwr+x6X
         L5HSnkJCUzAUofmoNYOpehoBfoMtwpn+0JTKJL8bq+z/R8A+JzXra9zu199rWFsG1t
         I8C90xHmOYb9cTBq67kYEoFz52C77Iz7UnTYwBZQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.66.14]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkyIj-1jAmko19QT-00ap8V; Thu, 11
 Jun 2020 10:40:19 +0200
Subject: Re: [PATCH v2] exfat: add missing brelse() calls on error paths
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <20200610172213.GA90634@mwanda>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <420560fd-51bf-2d17-7a49-ac56653ec779@web.de>
Date:   Thu, 11 Jun 2020 10:40:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610172213.GA90634@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mIWPchu3X/9IVg9sCJv01i56NsfoxFRahJhCNtrpmdMJYr39Wzs
 00BTrxHHIZ1PJV7KO0dezQdpUgwdmt9dvRKDHVUmw7uVygUzWQtzSCvgmc2wGIfJ9yqEl1J
 Yct8qpKYNAqkz/xyQQu1zULeVBUmuSuZln/P3s6C5r+Fmt96LL6AJzchp3RoPVoLjvL4KFo
 8UWynw4PQUKt+5d7f8Veg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ojKIIZhqF8=:SfZZKhLWR8QBExDqCOLSsk
 Ivtto0puV6BaId2NG3J8EL+VsGhHK7ScLourO0oVD3zLTKM2+CYNwc4ualpdXzP5lzeRpYek1
 H33dGdqXRPrL3s/xzQj0FasywshcashkffhxNn/xZRcoh7ZgYFmJxJHZo6AONkmRSPWUu5BYJ
 1L9U5P8TVyDhbntdU2Sq89obxFTzZKFN0EEwnHez0PRZRg+d+dUggzPoQby5ghTVsSnUfksGe
 tMdX4QVJhlpuod3E4MyQxtxDzpfDdHlMSWPtZPPW1WP79En9voJG68xy9mH2psjFEB7zzSIbA
 VVksyTj1ycUu4l+NvIJrAq1b1/Xcqy8i3E5goGzkJo1F3gBSJwRHeIPOy6ldaGivavMROTLY3
 nQ3SGsal4NnTQp6vZi5bXvdq5d6wCDJ2/494d55BNyJT+H4xE/zcIBUfwclLZz8Nc/R6HcILM
 +jzpKWx2EzSEKzA2FcWbOlCnhlZX21r8fkCfLYGHGpgSsjpdzKOGCKX5+jBXGZqmTsPPOvIt1
 LMoTiwVt8EWTlO2dRCuJvupczFB3paBsugnVOt/NppHGWpWx4KyAU+9UhxYllpmeBSL+ZP2RX
 wXfG58kR7Wh+WcbOMx0+58CMvlLiDkDFHvOYTUwYE2KY/eHesL8P8Q6MdKrPpqmgfyzapFsXM
 dWOoAfaowcekc099shHvycz0NgEVIyYSvpgPCmOXv8PHxhu/TzA4ZvgXV4aI5ad2iPZzkdx7O
 Qb7FrvYf1jUmO7xy5SjgM3ayaW9HCVsdPSC5zkNR7kUo5KxY3sgUGbgfn7K5EgZeWU3avisbj
 25Ca02YnieAKuKDVFLusext44YW7p0MLnjMUPGfbIk4ws0SlacPR4U/TQ5FzJn5Gx3rXgNIMc
 ZQ0L0uE0yvv46L7y/yQVs/xd0G4cxrINOS586mx5n4nTvtx9syeLDwDhh+piagUfWiWOHJEF6
 sV+qpBgYHX4ewjUH07jx9omXwbwt2SzUW6cJUEcLR/ZcKx7JunVaaY6bBbDYfOXEQrxhdTbT3
 DHQfwtWhjOmIkRYxNDYHmbr9S7CiysCXQqiAqZs4JRs/xLrFceBfYATWwoVUAw40+P6WGmXjb
 xd7dunzHSYIGmcuAkupUgbYdXPXXWjGzke9bFh7WNbrju23JoqZ0t3puMenAC1NLPi8k4ztbF
 O3V/cEJLqexQBhdxT9UGIiJDr+s6sPmbmuqHvjKCxLC4mqBWjL26LlhLR8IFzL3O7kU5HcpMe
 f+HM6Uxi3VjHOAOgU
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/namei.c
> @@ -1077,10 +1077,14 @@ static int exfat_rename_file(struct inode *inode=
, struct exfat_chain *p_dir,
>
>  		epold =3D exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh,
>  			&sector_old);
> +		if (!epold)
> +			return -EIO;
=E2=80=A6

Will there be a need to reconsider the indentation for function call param=
eters
in such source files?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3Db29482fde649c72441d5478a4ea2c52c=
56d97a5e#n93

Regards,
Markus
