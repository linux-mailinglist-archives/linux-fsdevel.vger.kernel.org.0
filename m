Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8E1EF5E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFEK5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 06:57:10 -0400
Received: from mout.web.de ([212.227.15.14]:44467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgFEK5J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591354606;
        bh=rSnfjIPja85QGA/ERMsy+/tfFYjepZiJhqusKyxLkFk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l8UBnGn82p+OytB9mzehMWlXnE/c9Oa0oKX73nlwFOMmSxTUM9iuzbSB7c+Id8s+j
         /v35GLHuIdLc4VxYeMekQslvC3eOPaPeJyD1THYPzGRRjtgInVfW4LEh3dPqCk5/zN
         hIDrOsmTG4kNrAsghnmIQUrfzZT8vDZUBbBi3x8c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYcpr-1jTk0T2EPz-00Vgn7; Fri, 05
 Jun 2020 12:56:46 +0200
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     hulkci@huawei.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
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
Message-ID: <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
Date:   Fri, 5 Jun 2020 12:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605094353.GS30374@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dRd58kkRgO+FkYctmKLtqIsGHz847dnAboKzyJJI459iQb92L0I
 /jkxoCVcKUo2YN8Jdn5sB94LHb4rEp+TQwINI3ymXY1yYNAv4uZhga92XzKwEE4ThFmktgy
 5U+fmIQ+tyjvgTMseXshgs/sGCYHTkTMB4JGW7w16omFGY98I1cgJ02Dd8PAG23vJ0yFDtj
 eN3w9nWa8XUNgD0VH1R8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wCp/MjImjsw=:sbzqgK/Sbbg6Jvko1W2h/4
 JigwSaZnJBhV81llTnCKYWq6EBMeu1Hh1Oi3Wk+WrSq4/9B/1PEvVT6u5qL7kAn7kAzl9J8l2
 bnyjPoKAV6YaGliIS14j8MqxyFb9QUOiqS0JBcAfuac1nqWAqwXgm6h9oZgIl0fzLZJUX0Ym/
 IWuNpdRmnoPfcG9UPUCsh9z6RdRGIixeIsQDIgvOdf6gZBzO5wa3+SnSm4ZO3yOK8qQSh0yPl
 vDU7Kxwh4diiRBw+dbZvt21zcvTVvvKPOJkXy1j4ZqKVY6Y1M+ECwyPXaJPFiYAFuhk273DUb
 oRF6BTbNtRJxluJkEH5O+1LU6G3BHnrfvKxLLSsu8ZDqcHGZ8sYHL6lCDsU5zPOBVnMKuh6Vl
 I1S9A0b5VIN6thIY9Sp0MIWGml4aEVgoGxmS7imv5T1QB2GNMtZTfGAWOQyiZ3V2VN1I01o8F
 JqukmS0vQE4KZv0HdUXg9kG/95dOpDDDiv5buV4SGl8Kjs1s3pNTU5eZuO3vL8WVmO4dVMk1+
 S+n34TExgo+QQJG0492Q1wSotR6MYQciQIH/b+ZpsUpAy3dZCHjgKnPwWy0Nt42ps0ixefu+R
 S/t7SA65f8wU++dNcD0bDorIMDXmba5SGOSgPGuR3PLFBA7yNj4Q1L8Sa8tQlBTmkEoLY+mud
 hV63uIgCNm4a4uSLwMWDLDLsGl/relGKYviRZ0PNq/3vc2ZXp6soppcnD8KcfMTieEAC4wTHU
 +ulNjMdiIKK7jRWMNgY4B8aTWXuOpaHSsuW1stq7J5Ds6jMW6DTnMtMObs1eFzcR4liN9Zl+c
 i9yiXGTd+PJXkhEnJ8FV4wizcG0rhBIzh2uR+2c4bhAjoFJijB1hmsV5efwEWqE/88s1nKwFU
 kNUqFPXu1xoZ8zY/nlPeys5Ybr9peFx6y//yQbGjG84CefJXYemYo+IgfVAhLmFqGjx8Yk/Ko
 xPXLKWsrQligCeL7drWi3GmRxb9pSCIyhBZ3hjlJkiMG2j7K46seIYz/57jqQWBKNUUFJKl8K
 K19OBaoJ8efiQGf92Sa1okhvKP2FbaD5UnGcS+Z1MLBd9GxHjdSCy4DPltF0r9eDb7/MC+R87
 poD86MewSiElgrUsovAuQwJ4Q/ywHlTtbvPtPlm5omzpATckgiNKIfGr3fPpi4cbGPALLYnBM
 GO84m+sDfaGfn9FHlANNmiwdeaPVUORwnRP3gqoziLRmvpxkEqocd1V+7g4IUjyGg6uwHz8Mk
 6Hz6ReOfv4I357hFH
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> A lot of maintainers have blocked Markus and asked him to stop trying
> to help people write commit message.

I am trying to contribute a bit of patch review as usual.


> Saying "bdev" instead of "block device" is more clear

I find this view interesting.


> so your original message was better.

Does this feedback include reported spelling mistakes?


> The Fixes tag is a good idea though:
>
> Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_S=
ET_FD")

Thanks for your addition.

Regards,
Markus
