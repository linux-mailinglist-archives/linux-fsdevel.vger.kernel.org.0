Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2811EAE1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgFASvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 14:51:11 -0400
Received: from mout.web.de ([212.227.15.14]:52049 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgFASFK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591034691;
        bh=AfJiGJg78m8Js1ZhWKrIp+lskfOB1RmhdU4kJhaFugQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kwKLvn5tNMaiQAiafDJD7xJ/diLb5G61tWzLzo9UvmIyDcdBSCRJwE6VQbHK09EpQ
         R2JuRL4bsuItO2e/2mpbjR4vau/ewhqa43KhZrEYeg7c9RMdLaoEDhBk8m6lUvkT8O
         DMXjinle6pqwGUCvdSVgamm3rbT/aSqtJk6xmzKY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M69CU-1inSrx2Fdy-00yAX6; Mon, 01
 Jun 2020 20:04:51 +0200
Subject: Re: [v2] afs: Fix memory leak in afs_put_sysnames()
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Yi Zhang <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org
References: <779b327f-b0fa-e21f-cbf6-5cadeca58581@web.de>
 <1346217.1591031323@warthog.procyon.org.uk>
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
Message-ID: <a28fd20e-1f9e-d070-4d2e-2bee89f39154@web.de>
Date:   Mon, 1 Jun 2020 20:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1346217.1591031323@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9TF8chhx3e7KOl5TRPQBMeghMFpWpX6Wv1yiA0vFwXKu4JEtfhd
 64GJUcMea4PIFD21L+PrLDn07s5ogeMxBaDo6yVLxWT809RbCVvNSIWBN4qYPSgLAf2eIwG
 LxkAVvpna5eEhy9wQpAZPf371UVDFHbwhyPxBbk8xdQdfIsLhTe36E9ROr4fxxqCNAG2toj
 sWVQrD24ZdgIUecC1PT0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pBMP6c7uVhc=:6a3YoPXt7R4zHeGESoADRS
 l5yV7NgLHHpLOyJHUrJ/Yyuaup3mrOcCLa+nerfoCMkSfE5AbuoQeeBbJjkbxFh+JhGnROZHs
 iATWApEW0Vs+0d2aGCP3o8Wi8bbN3cAZO1j2f0ueGkHMqV0IFfw3AMSF+TZHduWgb6yZi4KQx
 6mIyKhGcr0uFFPIrzwPy0ximKi8yNiyBwMqqQ1Pqj/xHhkdlnTHL5QqOIuxyZxSyKiOu1i05q
 UKGVfrKodkSKwABmEWPz71F3BPC0yOsl7P4V3f6e73fkMiAWPjMKHaXJi+P5PmwQ9vltAlb+9
 mFGBDBBZc2aUYjp8L+gG46o/PUki1k8IV6ITyodCdIgrfGb3lzaVyGioDCVI5f4oyWk8RawlH
 UayO0WTbCSkHca4zvZkxzaGFonRGAxoA/kib0T/FpH57GV7Nmat8Qnhlf3weCaAJPPQTUpHas
 RQ5KH4eIbyAqHamSVp7JhduLRR+SjYeaOoPdLFvolYNdIbmP4dRorvQfed60ijNEuF4QfEwNU
 BzZEfp8AKmeUJFXXVJKtrN+0U7tAEkHCsnn9d+kobunYZpgeazjpraYk71VcmG7vVMlbt3eTz
 jTLxOouCiz2EbpBmy9Wk4mRiU6fwAgOc3mUDSYPGMEwfLWsygjcRw3eKBD0ylYFM6gWTxkMQe
 pmIggLOfQC8/2tQS9WuDZw2iAaekTA2F+VwgoRZp32BteBrHMrEvzTNL6FtIwK+Hggb5T9Bct
 Q3C99mbTyYfC7VmM27hneANPqzITUJFakuGDSBWyzx9FQv1RMA72xf+EB5PlIPifjB9FIMF0t
 Sh+05CO0Vwl0Ez3yn9lazQKhLipMONYRZu2eKfXFcTg7G6VoWw+/nqo8fCL5eRuB0dhLgVQKt
 bnRIyAePXBSTqPW5mqeu1OtSJeUZgsiOPvgc7cskkgZSoSh1T2pHlvkVjlF7ZBIZks+k3tlr/
 NV933XSAnI2OgJVrGf7BCv70A8AjnIwOAj7ed4oP7dvu/aAwW/Ad0bL8qruSVetS0+wEUafmB
 /M8Acm7OjN5eemc/8kUhZMgfciqkHwNDUESPTenKqBc7JyQG4xbLTDywHNvZ3KU+c5c4o7nfn
 1mQrGEWuqjiDt70AFH4h4e93edaxaBoK7qrUUz6w3/Brmyxe7qI9UULJ+qqlHr/lYGJL06dUC
 enhuX1naIrb7UbDSf3jGUNBAPDP9Uy6O4znrQV95k5Wo+UdKtwM+cmTGdFKjVvHa58pbIrcXz
 m6hSfqNjFuXMpyY/h
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Perhaps something like:
>
> 	Fix afs_put_sysnames() to actually free the specified afs_sysnames
> 	object after its reference count has been decreased to zero and its
> 	contents have been released.

* How do you think about to omit the word "Fix" because of the provided ta=
g?

* Is freeing and releasing an item a duplicate operation anyhow?


>> Will it matter to mention the size of the data structure "afs_sysnames"=
?
>
> Why is it necessary to do so?

I suggest to express the impact of the missed function call "kfree".

Regards,
Markus
