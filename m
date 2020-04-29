Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0311BD793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgD2ItY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 04:49:24 -0400
Received: from mout.web.de ([212.227.15.3]:39479 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2ItX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588150104;
        bh=KB7NzKpDMptjCbP3+GDqut7U6+dc07DshmQkLhVBunw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=UqDUHvc5WxUxbi+oY2f9pZDNJsRCkEsmFlOsOZ8B25jq9lU4OmccVNF0SmIr6QWTN
         XfNyrs6Krzquzsz5MrNYK/Kf5t89DBC0wBOZk2cE6JQFQH5YvrBiMkvM7l7nzVIucJ
         mqAxv3alwVhHL9MdxKKxoyTegsHoVg7DEDy3Jw8w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfCyA-1jo6WL2o2c-00Opy5; Wed, 29
 Apr 2020 10:48:23 +0200
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ming Lei <ming.lei@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Omar Sandoval <osandov@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
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
Message-ID: <78375104-16a5-ea1d-f894-b09b1224d189@web.de>
Date:   Wed, 29 Apr 2020 10:48:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jKgAeRtX71p2UHMLLdhso1OOttNxhhTJDLKaJ/YZUekeX/IWw5Q
 OuXoTGIOlexakMSWjOQjcPfd+Q7Ro2EHfS6eJXzWMlUTKGf/ckEF8H5tCxNFpDXhkno8N2S
 HwFZBB8W/lxktym5HkUs6tb5AnFpm/UWomhCMAlDPVNj76DD1B9gqesW2iYYVOhY+c+/zlp
 +LLAdkXgNntbj6fOkTd5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tr6Gm8S4U6s=:LtiWerdvf5v4sRgaKGQ+ja
 c5uGiQR312vJQCjjf6IT14sGkjj5z+zEJ50/CSPHHA5z2xOwjpMJUGi6OgZOTAU/yc1WF5df7
 qPUV7OIi5wYkfEhb1IPEWKyvMo403ahBkPwlncUJarUQvH+Q3RL1wQ1rdXcVX1hVQ+OD6y49M
 iX3IR3AeRTklPD5ajksvU5krKoKOKw82C8x5jgXrNrgs8FZiN3YnyzOaZG7ckXpvhaxNVfp3p
 TbzZTRNkAWgoJRdl1mVj5njEDxb4kfjadh84TRwTVSm4WKupCHlW3dRvLkz7Ebo4zI3QyYjgR
 +9e5B/vXe/JPfTgDBjjadMxdKhq7V6vqWy+w19K2amhoB+MzuGk2RLuVBTEFL+OCSF1KBYdod
 UwzAa3ECk2VJYRoN4AeTkm37XnR1y22BrOnxvCsGkdeo/DDdxlL4F73mKmVxtzSsR9Ind3BWc
 I2EAm3mhrW42+XPMjErQ/8MD+g1GOLvktSISTkFv3mJqgRKRxYXd59Jjxkl2DDVL/4/6vHo3k
 6LVJP8bhtVCzqfXSgsswxDDq4q3quGjXl35SzG1eNPsVYCK1NNrY3aRuiL8stXlGNxfwWj9a6
 ypVCnnQ0ZpZ7fuX7U1WUwD2CDXkkBUCFo6uk6cncZ33mwsX//jfSfd6cNL7KT3t8sRr1rBOeg
 7E92g44du0YLFprs20Md3taLqTuz4p4hL/ALwcg2xZtD1I+sI7Z6XtgiRRMFR47EzfzO4gJtJ
 qXARgZ4UXNNpLxSeD55ehqQ2iZXtnp1heL53xZfMiOffT09UVB5T/STh49KtV+lEwEzEb5Yo3
 iZNuiG9kgtv530aw2n0c5LzQ5sYGa6VK7TQiyCSQbNKqOMz7yKYKJB/G4V32/brqAk/5ReZn0
 0yqtzdi6HeylGJF9UqZoKSDycE7fTe/aP364iDUXO1axBOewQW3oY/psHL/CWykrbUirhTez8
 6o03jJW00x1ShYPs/v7dHsXuPX4AJNSapxx19/hPuVQk+mw5XwQQHCdsql/eHHkIknpXrwuxe
 r3Mooghi/QQPccBbWKD3Bshq4N2GyFZ4kMjFadokPOW1lQu8q3tYB5NA73LwRZt5CBU/7DH8Y
 EXKhI22jpHCTv2LD+0j5yDAr0rotutNBwvzu/dwRwgfcCwtyngX8dFXQHvWJWhAOA5ghwRGOg
 y/C63HUNN3pJuoNZWWJNQt1V9PFyWB9qrFWxa27HaqtYH3XdG9cAqACvX2fFQy6YZr7SeiUa2
 CbwQSgpkZ9y6D1MOV
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6, but a misuse of debugfs within blktace.

How do you think about to avoid a typo here for the final change descripti=
on?

Regards,
Markus
