Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851771A4AA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDJTi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 15:38:28 -0400
Received: from mout.web.de ([212.227.17.11]:56425 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgDJTi2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586547440;
        bh=PGEeqxNlVBCsSOG4LIqFOF2BvoLw4Q31E+UCkpke5aA=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=FzwYaxzvptZn7OAXoibSOtHQglzrbu9Q404Q6WbomdRhGmd/q7Q+UXjil5U+Dw/2J
         JOA+rKrp/nuQy3efkyVK1XVrgIr2uiCynGKQ9OyHvjGgH7hiBHwISQR985GlFJ36Ix
         f5SwiIq/+I7AQjXAZBqvBnDPSgFhdpuRDdjurOHs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.110.107]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhvpu-1iseZu1Q9a-00nBTJ; Fri, 10
 Apr 2020 21:37:20 +0200
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Omar Sandoval <osandov@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yu Kuai <yukuai3@huawei.com>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/5] blktrace: fix debugfs use after free
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
Message-ID: <ccc51229-ae0c-4c41-842b-f267eed96843@web.de>
Date:   Fri, 10 Apr 2020 21:37:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:SqcB46BVWuHcsp34+t7mjQ4lYXatYFAbVT0yn5wReMaLmawsuKa
 nmZa04tGZABhR4ZvIl6hLcs4eMfbCEkuTLn9rrGpujiMhGUEglOB5bcIa4OkLvEyw0O3AGO
 cDkTMM1gVq4zbHZjHxoKRIgHyFY2kEfHAVlJHDu2E0WGLyqOj6eoYoh7B+RX56fmPBKOnb1
 8Lm3lvGxYqQaeyd5Ldoaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hy4Do2hsiqw=:xA7n8QnkZxeSx8p4Cloh4C
 q33RG+if7wj0s8c0xcKLmFRsg7uw+zT3Ya8CjMz3uJzkG5AyhpLMvWbyIhl0ORbAZ5fHHvaNH
 etOK2G0QO5FpOQoPsZUA79zJvKBhpG8hxA49JVGZuJlGwYUysUD5AVj7LBdRtWhtEOXoOtft9
 DJ3gM6vTSWz9I9Kf0ELav3wo6hZhGoOF8dblZaM0qO+JuIQZO/KF51JXR8x9/B6+pP7K2P1CV
 DuM9geZgfvaAfrAPYvLTts7yfYJqhKa36J70MV2EwmrOxF4sb4wCIEjCa1pX2q/SLH8yB5D2f
 D9KC9lo4YYfO3+l37rRQCsVB+SveaxRdh3VwGHEo7ZMf8Zbx8qi3KUiXweaKZeBc28v8lvCte
 D5e97yBiD+zb084CqjvU/rwQdWfMR3UJltXSHGZAX2tHJ0AxwTS0xvJ8ApNeBpPPU3awN7d2l
 oSjJtxZT7hNb4s0znAMxAYbUzJc0M8uYktYqyCmRRmUrpxPLtSdOclzp0I7AFkEtJRBEjiOpZ
 ZKSfR3HjJ9W15DvJvhMFIpXiXuQxsZBXYAyenAyV+oAqffdWPfQXr7QS+SLi8Fy7RUw0wQcoM
 fJkJbKtwPb1odnh4koB94Nc9pC20Br3ml0NKNwlesipehRdGVmerMvuOukb0vU3IdrLAAYihY
 aTlkIl2J4+orlP9QzZQ5Kiw7sU4+BiW6URTXumYjqDohQWbVmxhqMxzkCfOWV2x09glTMnV4B
 CZc1kaZIC8pFNgqNhspMzBNcEAir7YRIbVOHs4ua2b3lCYywyPYwfawRgR0rVUZvjNybUpfbD
 JFWQWCQea9ZNeUCuZh8ZU5cEIXDGcq76DZ4jorszGuOSCePVTegDW/t/DnyNwR+C2W8gOJdTN
 9Ud+kwhNRd7l615bd0QLH8bu8FaDkg1TwSRS5gupVWfaawwY13RtIamB31gnXqmOuFlLIpTj1
 WuyuIN7uAv8rK61tSbX+CsuWqW/pm0beUwFOSuRGW/VUt2EjIDzuL2Q+fLuNSn/lEG6kvOUh+
 YaPkynKNoF6UtBNZoQDMvTe2VdEuZVu5rsl98hmcriqMSYGScRXE9PPfnIuW7kYi+TJvNewRN
 dXnXU9Tyl3G/rxQhNu7mY+noq5Il0mErH6F9i2W+Rk5G1cw3nwwL2q6GlzXRNJGVysYR9IwI0
 rH8gl7fRhTbgiGY56g733JT2JkzmZLzM63KRt2eH2Sw5cPHz3fruDOFPP203a/3aV6Nw31X8A
 Jl0MeTrwRoewM83bu
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Fiexes: 6ac93117ab00 ("blktrace: use existing disk debugfs directory")

Please avoid a typo for this tag.

Regards,
Markus
