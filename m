Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE891EF843
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgFEMrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 08:47:31 -0400
Received: from mout.web.de ([212.227.15.14]:56239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgFEMra (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591361222;
        bh=SN17IllDT+/NWqqllnTWBMfMqp5AhSBlFt21ZNtHUwc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fBgGe2WVoTJIxqubkLLd12TMPtSvUx3kLc3AzNWLIhKNGHX6EcjrPvON4peUZCy5p
         vs1X7mY04S3fshgrVCsM5d8wyhhTVIwCLGhl6AaZnyHGX9BU2fwTEOLQ0kJHtvDDJF
         rrDuJdrU/qvR0Vxf9a3SrSVrK2dmchudaT/qQ7Mk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRD0p-1jX2CH1e3T-00UYw6; Fri, 05
 Jun 2020 14:47:02 +0200
Subject: Re: block: Fix use-after-free in blkdev_get()
To:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam> <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111039.GL22511@kadam> <63e57552-ab95-7bb4-b4f1-70a307b6381d@web.de>
 <20200605114208.GC19604@bombadil.infradead.org>
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
Message-ID: <a050788f-5875-0115-af31-692fd6bf3a88@web.de>
Date:   Fri, 5 Jun 2020 14:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605114208.GC19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oIn+vpSz4b31UQrkyKzudYg8vSBCCfBxn4PdpTLdoQOkTOFgrub
 9pOfYpbQ9tOfovQR0ERqre3vjM1ceKwBta/82Oq4vSswYdvnUiv2rux1REPnVf9t4OStP9m
 syc+6CnJiIz8ApmhZ/Mqt/X3uvtAlV20uKf5R5+OqRH0I6Yzcjuk/NosyrOcy1HZdv7iAQJ
 omnb5musy5qc8Tin6Y2JA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cUBm0qZHOvE=:TAbGAthldnwGITdrVu2zjz
 /9mHmpEQMFivjrRPnL14l2Zibbk8QnhL5ceJKR5cOrkEKBLzsK1VAyGs4nIL5UdC291XAbTND
 a3+sp3rO1qQPBeqEPiG9Ka00N9H5nZ29ntdaEY3VFGw2N32xO0cjGxqf0+LreApURRA/QGLyp
 jdp4IyNGeru9GnQ1Lmk12u1ByKFhSFLZHv8PVk9UJG4mi23HmABG3Diqr8M88xlKvoQDQvRqh
 iwsNi0QZCPduYEwy3v1gYUbDNw4UUpAGvLbRz/ccyE6uyZgzogFpv44YawUo1zeTRts3jccyC
 GPpKXF+HS9+lbr5OEoDoC/LomMfCTXCNo8nNoceF3yjf86hqfGxlUZZTfDxhYxNEQsrroOmeJ
 TaQ6MGEb538OI/J7EBMeZH+tb0wZnyhnk4MgRtKDcvLnzkUcKNxlENvogwmVuW/+rllM5I5eJ
 epmyHHDRt9g6oHCBVXbE2HsSUUQwnSok+xn92oaxih2V6W33w4Z6+AWhDk+JOU3PEw4hF2cqt
 seQBbfURpCasndUd11qY0wLC+TKwK0Z0a6ZYWnypUWHd5/0GcAMViN703o6C9bWe2/FPtS9WR
 ACVFzAR7pliiLeFNp01rGBgx/SAxsgy5XQ7/1EZ7y1TwTnkAQXNq5ByRGzwfCHlwjpsBYFauV
 Ufz+HG1lAB4zxPcjTReJfUVO9hJOQHUpQeLPh7cnWO9LlG+zRMxg9niZwfGUn/POGCllJPJGe
 IZRgfB2xHZdGsL4gdwDWRsB2dKBZewfopy1t2YIniPTT+6G5Cl5DrSuANEX9SSWIcCcpFNgLE
 JN61KJusB5faV0X71SZpZpUkk1d01kBSCjLjB28b91Vm2vMJ1clNn/p+LtFGBNAzrXHUKtvuh
 XStbmzZjkJH3I1MRq90jqYOlJ1/si7+BqVhb8S5Hg4B/HXSHKu6NszeMBEA3HR6rn4U8+VWbP
 dm7gh8sxmdhGwSNawXYy0nnM6YvOYsxXMa4DlzeNCTY7GtWfPIvEcoQ0Nl0iporEJgZjyrNI9
 md2hYP7PHHBSJshNXq4NC7259Cf0gOYd+YvhewpLOzBYNOEXivXBy5bf2S58X9qTLd3/QHFTD
 9soGJYF+eYFcOPwY3xJPvB6zvclYF/AFWrKwfgH49W456zDGqB0GaUZcqf6Itt+SepwdPu59f
 uCn4EPaoaUUbZnfw4Gm0fnReZsf0giDkQtqn2xzRXBWQFN7BTIIj6w9QuCberYirYyJAzSgCX
 /wmI1dSUa0HI0mSzL
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Some developers found parts of my reviews helpful, didn't they?
>
> Overall you are a net negative to kernel development.

Which concrete items do you like less here?


> Please change how you contribute.

I am curious to find the details out which might hinder progress
in desirable directions (according to your views)?

Regards,
Markus
