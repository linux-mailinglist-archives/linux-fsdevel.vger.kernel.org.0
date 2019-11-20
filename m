Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26024104545
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 21:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfKTUih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 15:38:37 -0500
Received: from mout.web.de ([212.227.15.14]:56757 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfKTUih (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574282287;
        bh=jVJpUYc3KtrWtxsU/1ucwpUjI/A3bmL7gzYAtLISS/0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Gz165cn02WeCW3uJ14OjWmEiI45BFKfSMLInWVPIZIHvD8Vt5wLwMNS4RAgZtpWtm
         3nxbYxHxIGAKf8PXlOw7yxcHCufRrHmAEhypWzXIHzlPtTI7FWjv9/uO/VY6jWgNgS
         Zx0IQtA4GnkUgSZsrU9af+9ZwXbWtgWACqqz1uKg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.176.80]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2uXO-1hg6u12CuM-00sfiX; Wed, 20
 Nov 2019 21:38:07 +0100
Subject: Re: [PATCH v3 07/13] exfat: add bitmap operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094024epcas1p3991c5d94c2cf40388d64c0bd9c30092d@epcas1p3.samsung.com>
 <20191119093718.3501-8-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7436291c-4e74-adcb-b421-56d49c90fa5e@web.de>
Date:   Wed, 20 Nov 2019 21:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119093718.3501-8-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0EIsmeXrWV/Og76lhBZU5E7iNcdSXdAyWKuhJoyLktIayvnrRXz
 GyKsQRUbY/cSoZ/kfp8oHzwzMC9ouuw8cFXdei8cPpFAvD+ywyAQvXUfkl0UKoaYw4I56xq
 OAzr8yw2DQtKGrF8owAXW5IdsE0mMc5nh9Zprn1tlwLcS/XydyqQ1x58Q2lH9Pb/sR8s4ZA
 wyPlu94ZphUQ+TQd2h7uA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lowWC1BOzJw=:4yv8zIn9OVCW343q8db9EC
 E0frXqC3AY53zwDFvaU4GCo/AChOSovt5Hmmac7m45jnqvmUQ+cO5ikvigKHDMFOSaLZ6zDBe
 09MlH95zR/2OT9E56H8Ea8vuOzNLmbyOchxxhJeGjDzJArzIHugFh+9RJRMwkYmw63gNk5MWB
 LV86iOkrWIhDQvvH9knk/W9lpDZqc0pJF11oY0guEa6MMvtarvh7eYXdJ7JfGAIHbUjBjiveg
 PpssG20hrjwPcOBUJvrnkgktsb58l9BKQB88kS4M2JBdKfox8A68i+aPn7GH0fc57jFcDC7lm
 XyC0wQgIGqU6j9v7QvkL4dJDMTw8zublsrZ7TxV/avAMOj42V3UAtDprA1D4/y6nM949HApHZ
 AuR5YYoA4WUOLQyMa9c+8o/UdMZkvAWNISVlZAlq1Xl2m6KtujS3V9vUM69DEbOVnLU01RrQc
 YzOJbSZCUL5Em1ZrOLgG60ONFwue4OxpNeViaVqZgBEqVDA3OBmXdEyVuGM3vCyc+SlyltyKX
 BiA6LY6sKktpiDcFT4RuVYwMn4UvV8styXeFWqOsKP5JhAZy4hxrFp9qlBsJR9W8tctDDNH5D
 wo9FykKqs5E+zlCfxsFA2W1RK7bV207n72XQHLj7UD67KuJ/KpgPxD+mZcC34eBxar8+xsKAg
 ZYgUmZbrV0xF0AirIBkgZsSoSjWfjt5APAbEG4KgU5RTmVU10WI3SPeSzzRXNB9EdJ7chM6h0
 LI+4lux+E3AobHtpi60vXn77hLLW6vbGzgYTxr8bNMUKbohplq7lYA6EWdebn+zVZwjGtcAHB
 wsc5OvLAAgREvb18YxP3eXTAaaXSeCiikXMW2x2rX5WriEQw9gYH9af5ZSweq7+zIrL2hV3kd
 zT8jLOziCnJAru0legXF5h1LVSztqBH1DhLA48qm92QETAioXUan3lYSssaVW19cJ44ZiRsYz
 Hvma4WeruWK54wVMw3XndMuRpTtj2R2dITQaAFrPzcfvnAyJA6+J4E0WIh10PXuSACUm2qp94
 BX4gx1R26ouM57uN/OkHzVURfO9PtzHQ6+9hPoj9URHk1Dez1SDQP86x+Ki9h7RwaD7uxNa6L
 qcfyLle37BS6P9eMcrIGhP8ok9WFY6tB+kvyJotJlBjLlrZHdvQFFr7QIDG26WEW8XDf/NSX4
 Wlh4ETW0n5QfrtlC07rVxBvtUpqB+g2kZAZkCpvrtMsj6jUQ+ESqedF/CJpSmnu8u3AnlS3Pk
 1ZV8LJZctb4d4+nW+mjqFWl09JCA3EZS6SuVzpaAxtUczTbBPss7w1NQfW2s=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/balloc.c
=E2=80=A6
> +int exfat_load_bitmap(struct super_block *sb)
> +{
=E2=80=A6
> +	struct exfat_dentry *ep =3D NULL;
=E2=80=A6
> +	while (clu.dir !=3D EOF_CLUSTER) {
> +		for (i =3D 0; i < sbi->dentries_per_clu; i++) {
> +			ep =3D exfat_get_dentry(sb, &clu, i, &bh, NULL);
> +			if (!ep)
> +				return -EIO;
=E2=80=A6

How do you think about to move the definition for the variable =E2=80=9Cep=
=E2=80=9D
to the beginning of the for loop so that the extra pointer initialisation
can be omitted?

Regards,
Markus
