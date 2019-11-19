Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E63102676
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 15:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfKSOTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 09:19:22 -0500
Received: from mout.web.de ([212.227.17.11]:36661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfKSOTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574173144;
        bh=F1eFRQWICY/CeVhO5yxvpBwc4XWNLA3Vzl/kqDF7wZ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ur6UaCa8DPI9H5Knj+Y0riQHhTz9O8vd9b9XlHOpbFel4Ke4Jg5kYHVc4ZfbaweRR
         vLe+UzHWUeBc0Cg5wF76owGW7357GyETMoOh1XmbDavP/kXc4J8slQ1u3sRXTsxkx8
         i6vpk72zs3vw05upee8KMgIWIskgzhZS17PRqqbc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.93.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MN4Oy-1iUqLg2OBU-006gt9; Tue, 19
 Nov 2019 15:19:04 +0100
Subject: Re: [PATCH v3 06/13] exfat: add exfat entry operations
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
 <CGME20191119094023epcas1p4976d19f4b9a859ba4bd5b3068cafa88a@epcas1p4.samsung.com>
 <20191119093718.3501-7-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <e427d4ad-aaa0-1d96-3aab-01be7703dd77@web.de>
Date:   Tue, 19 Nov 2019 15:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119093718.3501-7-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TFa5vHEcLyJf6l7clwoP7PlDtjIsKraXOIQBALsgLTxKDpO6UuX
 SFNBHDsqvhhDLPXNNGReTcPi6uXwED7kwA7OnJfWihez3WvQP/8I3L5LfFKiotCa/Jvn1Sa
 WsONHjfpLrHKeNWIp3D75m5m6N7Q3M2ruiVSKA4of4+isODUHoSg7NB6xtSnFNQTqTpbGUK
 eS1G52YTXDXh7qVy+FQdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dOveYPY5NWc=:UDqFIKDBXE1Nyldd7/1gdO
 Dy434XIwRJi3wS/K+l/MTS6l1QCpnc2e9Y9n/gfzIwwoMiKTK1WGVLLlzLwCiQqeMx/OXmY5k
 NE/4ThdOgJ1IajoHefuEG8CH5/UkMMnKtH0eOnPiFpw18vd2RujM6cjqZvhptoLfG6A8vA5yn
 xzzwKyyas/1kkoDYVXgygDrXOB2zV85GPTB8xroP70UpNuOP5QXrYCcRYCAHRz+DyQMLtYxBC
 r7r1ZAlAxUYNoOsdcSqSOxeYd1SCyp0SXPJI/ZGT9X6Rl7zV9VkutkTulld/EqhzdqMQgZZPI
 aleCVRkYfg6qrYNciP0tbAyliCO/1xqI7glHbMoR4XLSrMpLbdJy5pOwoXDMpGn+4iHyczKRc
 Ca3Cn4lVkruQzo1wQ/WKOw4KPTJAPiFl1DlSEbiyECh4xPtKZUopAO0WtGS2Whz/5g8q9oVRM
 N5EraCBjQ67mCAL6kJIVVYa8rbHkzI8GhRA1xrSevxk8g98qQJtj4cNblB9ZJFI231Encolw8
 UTBAsnnZZKGbyZAk27DNTEAvuAKbrzB3IJGDkwBxRraLQHuirJChYcVqt3iX55TtR7eILCk4X
 CU5B+cVTSFdD0j9QyDT7eA1MtqI7MOkkUuLh80khTsOJkMYrPVPBhcSmthgTe9nQZ/z5JCxJ+
 RSb1fdfoGO2tN8YHTLjaf/cn50tLZYGO6mIab6Uw7h5xLUad2hK1bzab8B+EcodBQqtuPvLJu
 wuU8OqSraR4Vv7eQDvd0bdPZf2KF74L8IIpUtHT33YF7huaZQVVgevMKh5W7vnAs9ynkQoSi+
 20hHgZJAhmR6VGHG6czJ18wvPCj6DnDF1KYEACyydf5KYcqtpqyqBf7x/3CzmeRMEwGxhc04j
 S6aRXk/xPKVhpzEDgWy5LKjbxjRPDmCQKnByvPdnrAWGo8K3Jgx4Zf+BFS1bsZp3MUu+Pzbg0
 ss4svJayT8DV6zU0k4MBXvXv856j9RezTrTTRnvG0H0/OOXtph/ShnDQSO8OYKoeu0DHFFCOL
 mxIA2V3rk61yN/JCUNZ17q8cai/LqjxzVff7DrGnHllbxAE9nBYc9R2HonFHnhKg4UnYGzOyY
 l1r6NV8Ggl1iqQCIALrqwSUe1I6WKKW7wCvohVHGf8H0XQX4XkPn1pOk3iNP2N4Xfnc9/wk1x
 VJJC5A4ouPGefo4JciZ9MqH3fsD5f5h6D4DV5kfTJCzrFXMVB83Kz0JIXPzx+SoMazyDsUFsl
 7++SVTr1Pz82xR0mMPwMb1cPtq33MJ6hZA4Y6vXAr0ODjBMjJORlUhOale/I=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/fatent.c
=E2=80=A6
> +int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
> +{
=E2=80=A6
> +error:
> +	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
> +		(unsigned long long)blknr);
=E2=80=A6

Can the label =E2=80=9Creport_failure=E2=80=9D be more helpful?


=E2=80=A6
> +int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
> +		struct exfat_chain *p_chain)
> +{
=E2=80=A6
> +error:
> +	if (num_clusters)
> +		exfat_free_cluster(inode, p_chain);

Can a label like =E2=80=9Ccheck_num_clusters=E2=80=9D be nicer?

Regards,
Markus
