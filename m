Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D11105402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 15:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUOLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 09:11:53 -0500
Received: from mout.web.de ([217.72.192.78]:57563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUOLx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574345413;
        bh=t6HG9r5z5uOh+EyccYyFcQQXRYPM47FgwoCUoh+Yv/k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZMXz03pTMJj11ltPfcnRbMBbsTb1krYr6o92cnrpW3UIG4/AoXYXhVOUPlGBHD324
         NPFWAaBgu6uC81fWWTtBz+uu0tF5LZWuvw6Wnh5VhiB1yEp2N3tupLH24htBxpUUip
         t0YWXye4cyH9tLXgYqeMo5DCflVcggcR6eXxeTMY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lw0q9-1hmiMb3xoD-017nv4; Thu, 21
 Nov 2019 15:10:13 +0100
Subject: Re: [PATCH v4 06/13] exfat: add exfat entry operations
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
 <CGME20191121052918epcas1p284be629c57ced93afe88b94a35437cb2@epcas1p2.samsung.com>
 <20191121052618.31117-7-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bf2e73f2-08b3-5221-2702-524ba6a07497@web.de>
Date:   Thu, 21 Nov 2019 15:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121052618.31117-7-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nEfaKSk2+J5qvh+3P1884Lzwc0LDikXQZ0UNtqWZZfYdTCtMNA6
 Vbw/Y/l5q3GGkI27WsMXDFjkBEkWaFlseqgvlTZCveu+8jJ4N+aud+v6Ng9TUxR+NIqbMoo
 fjw/2YQRpI15iPkvXVlf9RNvprfnKlvFfp051Xym3z0Yd+OMZF6BTPmign7L6ndDi9Q6X2w
 Nc2V2yMseI1GQ/3p0q95w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HGl+44/Q948=:hXqFhCiMzb2SSDyNVNkZAB
 71P6dDKTJgKu/jjR7fgLNzf8tHFnlr1mMIPgcKuuW2ujRjSIJ2bPSGreqlHioIuiY0Yt/vJvu
 ORlWU72V52Pp+nQZPa7cgVwIlaxz/WcBMDUIkrfHQP+B86jNXWL4BoFdES26qujnkYN75IOSV
 HvycF6yqR1LNM6y58eRe26iXaRfxmN045SoVdLILF1nftcQwdvqxD9zFsVU7Sz89oONKs3xWK
 vqYAD9lbsDWSCHVQIzxD9K7In+aVxne8EaMJsVserVb9X89lYw5X02nTRynIYdlcuKsz7AbJZ
 ECBEUMSZR0GUyts+h+vOXpjm9fzQjN5XMA06Zp4/Qn/qMRm2dz7liDfJRaXtrDyOwTD3RXsDZ
 5mLjnlpmAE3esmoVaY6udCDL6SvCPkH8hbM1hESZ9IiS9TKCNa/Tg6LctFu8DGDKijEwhPQjK
 8Ux53a+mmIXKQjCFYkqPJhkpH46IhLR44XUjRe5Z4I1+MM4HcuI1+3v+psQZJrsqmibjwzAFj
 ImVLZAiL3ugaK446Q0W2F+GjkMFc5FFIVUjTxTowgSsDYQjk3MfMFFH18z169BVjZsvmPbvp6
 AWM+2BqU7cc7gbQc0JtNpiL/taidYlw7cafvt1UOMN5FhHbQZ0PqO/PpLywPKIV5yEdZNZ2b0
 bo/L2exEhx4Lw4Gtddwr5uFufdjkiFfQsVJE9vlnKOomCwcdfHwwY/grmPCuNJxeVkViLtGgh
 zlB2HGywcPC1v+2lKMOweqHzaT+dBqJmdh2kaiHuokJBW1hlRgVvhSOBaPv0dN9VhSvOj6UrL
 aB6v7ABI4oI+K8F8V0+8AzHIKR60tAB2Y+me47petNDxk2ohPDD/upYm8HepsOTEufHUrfksW
 GbPZq/EQ0zpsR818rcOHXHYox/3XGDsK5sHXRkm0oDHit0GOE1CF7nXIHpt+6kI76RnT/Y7T7
 L4eXK1PoV6PaYdu7ErmRKAmXx728LD8tJ+bm/p3tWHJ7h+8NNl2XaU9QSnZ0OUx+g2O6w2E1M
 UsNXCvDpJY5pnodfFRfedHXkkZaebEfsk8mWbDjLxqiZsN7idBDZMnYzkBIuDL/FtlwXy/YUU
 628H1USRu05pyVhDged9n98Xe5ynuUz0WryuI7Yjrw0MxNl9xe+s47OF4TWgJEvpSV+RA14Mw
 rkMqXMR2wOXRI9gEIJSCrVYZmebGqCw1zLTHlReh9YAPHwI+gcmM0BDqD7fjGutqlY79/cxFb
 maKWckSy2Hs5PGcF4yDZJ9IZ8bUQm1YBhCgxCALx2/yD9i7LFL85k3J6qp8A=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/fatent.c
=E2=80=A6
> +int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain=
)
> +{
=E2=80=A6
> +out:
> +	sbi->used_clusters -=3D num_clusters;

Can a label like =E2=80=9Cdecrement_counter=E2=80=9D be more helpful?


=E2=80=A6
> +int exfat_mirror_bh(struct super_block *sb, sector_t sec,
> +		struct buffer_head *bh)
> +{
=E2=80=A6
> +		if (!c_bh) {
> +			err =3D -ENOMEM;
> +			goto out;
> +		}

Can it be nicer to return directly?

=E2=80=A6
> +out:
> +	return err;
> +}

Would you like to omit such a label for this function implementation?

Regards,
Markus
