Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87BE1EF31D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFEIaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 04:30:46 -0400
Received: from mout.web.de ([212.227.15.14]:34623 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFEIaq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591345837;
        bh=YMUSygJK/1CfsirIVydQxFMpeFiWKiHb6Bd0D6hIBWE=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=hINNALY5Shh3lbAOMWoQ0H9xw525JMbvHdlX0B/VmElK4rNiwH1RMcL3SLsZdQrjd
         TlwTHRYYgahurH6PQPL48uYOuM37r0eRL48obD7y5YulhiWMkI/vjs0OEIQRYuVKnd
         MEJCrvxjXKBT6GvPgx54xgocZfKNbTWcskQbCzjs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnBTZ-1j2ryr42yj-00hKtz; Fri, 05
 Jun 2020 10:30:37 +0200
To:     Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     hulkci@huawei.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
Date:   Fri, 5 Jun 2020 10:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pZTNExEyMmWyixWDPTWYbdbk4w3QJ76Wkvj+qIgO/VkU/p2Z0Z2
 gxv6hZJ30bWF9sKOW/2jpnMYFq4L9l8F5jLD/QOquAajZw4UE9zFh0ojVSJFqOVNtUY5qII
 Z8jaHhi7Ultr2agz+pLni3IPxtWOgh9yTQT3KDYPYt9H0QaH05C74Kz2+od3UNV66wiwQV/
 lBbmE/pRjEvzDCD6Oi1dg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cXpuJYfXKGE=:5mIHmeYz+SPaOqdGZJMV0S
 f3j6l4Py283kfFVq7utFNC2vVGohXgjBcUe29Af55kK6fIL8ssIYFwqXQb78FQzTZfhVW04nZ
 fwt1OjrD5KcTCKpDGODW18rsvpi0eY0/opOSSgsDCGZFbSROIbphQF/qLhPl9VhJZzQStpgmB
 2XMy3+c9xKn+H7ESbezc6nyaPTHlDEcKgLRB60Qc5aAerjKgrf5lbYjKM3nMsHm42MctwfLb4
 or7hf8MY9loQyTV7d/EjXvXIm+YCq9uo4S26ncfop71rWF3L4vaT6WzXiWxPvi9dALHG4B3Di
 d+eJshatv/5hWl+LkDIXIiOSJ52yf1wynL5eYx4dEuwBd8Hs426L0qPxN6HppZP1K0N5jmOmz
 63gg3KllmUq47iP02JuQRzlHDAEPhPpZQHGj3tLaB+Laog6FWkc/xjvsNgk4843BnrhthiWjQ
 20tOyIxahCgG3oWCghM85AsX+DqqAbo0WumYXi54g4h/x9KJfJLaoSWdXxmHdAWSWHJbUJD8z
 XIjK+88Ik3hEtINTaF28YBKmC/Pr06rMY755AKFlRI+snfk0uVxeQouGtilOEPqPrPcG8HI+Q
 HjlVb+R4IuhgWwlfQhaIgLe9ltQomHJ5LvX01wKbgsSYQdcg/560tkxj69drw5MuXKrDxJQTO
 6/s+wUoZToOpTysKGg92VCJRB0u7BnCVdhTXVJ8zPV+QVWcyPVb2HJUkvXMO1MRCA469KuZHE
 0JQqDOXX1oGKJXlXHYTk6FdpEBVIGtn53TTLz89ZIgKeiBfHox8LEAyjd72EM+na7HHDhjO++
 /AF6oS7xrn4wIh8J/8fZTM61s04n+Mdrb6mV8+SKS369eC7kDUl98qENUuwWttIhNZJCV+vzP
 xE2R+nrN2m7mto/4enRGQp1nr9ocC1WIqPXIHc/x7m7xcxF8PN5jyj7+Y1F2UOPSldgYQpF84
 M7MaBQxj4FhSv+ZTixAvEuUoLbWXtj0j4J4neIS5qFpmdCWQS5SvI+JcOxEkhK8EdHGX56nrg
 +UJq4UiRd20c9oeGWC3zOb/gbDmZftqandceGlTQ+1ax/9l0sx9t9dO+atovPEH7VOwt0q2xZ
 lPdf2oJx03WnNnPMtR1kGgTNgJO3VLmMp3ZWuU7bAudXAqn2JCiDQPpNAbC3BooNchvi6DKZ1
 nfkBEP3c/GJ7uqr6FGVtS3sP9TPv4XK3/147MFPtZjL3Lk9JUY5BszzBEFsEm8jxtuhnR8Vem
 H+NQDXwscDb/OQxN3
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6 released the refcount of the bdev (actually the refcount of
> the bdev inode).

Wording adjustments:
=E2=80=A6 released the reference count of the block device inode.


> =E2=80=A6 access bdev after =E2=80=A6

=E2=80=A6 access block device after =E2=80=A6


> accually bdev is =E2=80=A6

bdev is =E2=80=A6


> =E2=80=A6 This may leads to use-after-free if the refcount is =E2=80=A6

=E2=80=A6 This results in an use after free if the reference count =E2=80=
=A6


> following scenerio:

following scenario:


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
