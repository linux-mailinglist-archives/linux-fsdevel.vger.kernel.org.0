Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD471EF882
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgFENCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 09:02:13 -0400
Received: from mout.web.de ([212.227.15.14]:49079 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgFENCM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591362106;
        bh=O+67Zqc7BNPiu0Riju17L/rB8Wen0+rCWIN/C3IARsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bpRq8asb7ONNLj9JMLNnm1sqWwvuzAjoCclzRrLLSFj7GK3yf0zTmuH4IWYUcbt6s
         /TxCET2YfXFrR5ZqyXB05Ax5eQ0H7bnI4uA8IKA4BozbPX1t/NIfbbFyOrcHxb0MvK
         TGyKS3+sBUV+6PWSO4uy3GyY4C01A0tqCDmjAzR8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXpqx-1jUnuv0A1H-00WqRL; Fri, 05
 Jun 2020 15:01:46 +0200
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
 <20200605111049.GA19604@bombadil.infradead.org>
 <b6c8ebd7-ccd3-2a94-05b2-7b92a30ec8a9@web.de>
 <20200605115158.GD19604@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <83062e23-cfcc-13c9-62f3-cdb474de4a8d@web.de>
Date:   Fri, 5 Jun 2020 15:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605115158.GD19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0KBUHlg/cfGbADFqdBGcQEuSDYrIMb+iJJX4tEwEXP8qw+lYyPk
 uEatsxaGATdDocmBSffHLl/qH91Vdd2Q0uIoU4oU7hk/YdH3VjfLUqlmDlJQ9N+DnUBbxem
 0DD5YksNgIvDK2IichGwY4+pSMIB98dMQlOqdHahsgQiN010ksZBXRDLQCxDEPOgXyjJpS0
 c5Ta5V1D9uJ6GZ9p0gsuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZH2Xx6ovcdk=:B1r/fcyTw+fFlcwoKu4tG/
 YgxONeycCyHlA8Sv7VWAPg64WwQR02SacmfwWuVfIIwHcFiuWuglHdE6YtWm1JKkZh4OgwNrn
 c39hg3zVKdqGHFECCV27W5HYEQ7K5W/qhZFOzZk4xTuxXQbbylZoxZzrIRzwFdvagoV0kCddN
 hL6RusODbSJ91PZW41TriqOCkNptY1B4Yax86e76jsAVnT4fLrbQZGZH01j+VA1CQt1Jvgjkq
 XuWPZtmki/z4Zn735KVuW18t7O8CeRccq4YfDz7RsuylT/xL3TnWi0U34hPzqX41+oadKYlG9
 rXcfWe1fxrsxZuPvGIiOa3zqGbyFL0NjKQPBpKECvljfy5PA4CZ20SnO6nYQJr3BFSVryZ/XS
 DGOGsij/y/4+rAWkK++GRqq5kRT4FEC9JF4x4sCSOZfdFb3sDK0NjRhPAum7bO+NR8STtC9us
 R9xfWc7oh2OI4V9YHNmxpoUgSoLwbkJk/7H2bRqq1d6vRu/PoqWpvXGhCybltonppyhSigMZD
 ohY/hYIIGq5z6tuIyqXZ7cdW08VSMC84f79ymFs0inq+mqfvXLID/YA6kmpNUMNiGXYJaYyrG
 jqHajXQyZHbMLBp2WtrvaFGAAPkySHuKIhXgKDex0COzMd8y5dQuVL2VFTW9UDoSnNUBe1GdY
 SPzsBoDqLKQKrAQt8prpLD9dYMhPqPQiOoLNuwQlziZzSTuAyKxEBg5CLCQLbSt8q7ifVwbZ9
 SgR6M6bT2cuQzpsjlf0+Jx+kBxN3g5lKELT1//vSw99k2VULmUaLB8J1qqYpZxenYSa1YXfZs
 pUTuHAEjI1kDZU5xyapGIX5q2B2vtmG+ia2twmPShsq8Y+yoYYV2xjadtKEaSkFMOR3VEAHBc
 JkmWcRObF5UTzHsr9KD4jxVcozyORMiFt3wbKSBGTtmZSb2dQsdV10XAkRkO7SDnWjev0+8Vt
 trnhC1qSDZdweCwd4gCktKzzJbNXF1MWU7wcmBNGseWIbcq1NjlTsKm19d8nNnKgiS4OEN7iJ
 HHuPwl9r0tGnguVdn4aRzq9quW76sn4HzW4Ax0fCnxj8a5MkmzkO9ddOjw6S3gKLFg8My/jxY
 g97kiDZ4Xc6H3YUq1ibCDyghEyNReedRx+3CbBxnGC/OkVPOI9pwFpEIvJpSm6XtDuut+MlXZ
 jyY4/keFbXU3SwAVwXRhFrvk3VoAmTC8SyWQHhZGACRkMxJTw3G/HSOMtebNs7VDGoggFWObW
 bQ/HXaGYkcdqeYZzx
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> The details can vary also for my suggestions.
>> Would you point any more disagreements out on concrete items?
>
> That's exactly the problem with many of your comments.
> They're vague to the point of unintelligibility.

Was is so vague about possibilities which I point out for patch reviews
(for example)?
* Spelling corrections
* Additional wording alternatives


>>> But refcount -> reference count is not particularly interesting.
>>
>> Can a wording clarification become helpful also for this issue?
>
> This is a great example.  I have no idea what this sentence means.

Some developers usually prefer to use abbreviations at specific places
while I dare to propose the usage of another well-known term
for commit messages.

Regards,
Markus
