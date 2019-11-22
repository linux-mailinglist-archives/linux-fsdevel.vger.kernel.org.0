Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C659B106792
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKVIMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:12:25 -0500
Received: from mout.web.de ([212.227.15.3]:50327 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfKVIMY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574410263;
        bh=M0NbBfDQUkr/VgDzsbL81QG5vRwRapzFbAO9bUSc3kM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UfqJ+8+l1y+qSLRjScSjXU/0S0lwMXKblwz3OaIxj6wcDamh3RfBUcKXL3SexHcOd
         7zZv5Kl+78Ghfe8zvgNzHgD1e0ZZdprJCZb2GZUYhr69US1whCElSgQdoLQ7FFh9g7
         zRJD+NEPnghL7AyrY+Fdn2vAZzbnsjmiHv7R9los=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhvYQ-1i2bAL0IE6-00n8VA; Fri, 22
 Nov 2019 09:11:03 +0100
Subject: Re: [PATCH v4 04/13] exfat: add directory operations
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
 <CGME20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38@epcas1p2.samsung.com>
 <20191121052618.31117-5-namjae.jeon@samsung.com>
 <498a958f-9066-09c6-7240-114234965c1a@web.de>
 <004901d5a0e0$f7bf1030$e73d3090$@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0e17c0a7-9b40-12a4-3f3f-500b9abb66de@web.de>
Date:   Fri, 22 Nov 2019 09:11:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <004901d5a0e0$f7bf1030$e73d3090$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sprXqfhDPylyC+PS/I3B9RUW8MbH2DypxSRx8eC5UoR4qUZatvc
 524I2jtKfD2Rz1pOhGm2+4iyX6vZ7uiWMKaEHLnl818fckYxp1lteGKSUcg7O637QiGZ27g
 Ky5oQi+TFKUGoG+zL6i3x6k2CQiwCLZAmq0hIApG69q9ylyIhIYFMFAO1l2f3we2q8fURPM
 3NihE1Ssu3qeaW+FQNazQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Vw750mv/qc=:WOxz6T/NdpyQa6H9Dvjl1c
 yS8P/eoAhRnNkMMUzAOlVF2ZoeYHLcXLvlkt8YclCK/ATmV0EDuJzZMZNEh5/TWg4kKsW/1bD
 m1qO5m1/rCTEcZcM74yYKxcsE6LeQqlVyTq5MvMVQjYHRZNl76pjUSZ4XfznhmdTLK0s5bKAf
 ED5p2Pk+BEzhVwPi0PEBriWw/yTD85FrgVRIE+Gt/sKqpUlqHqXrZEk/TtfKQ6y38GGbn3nQs
 pALbVnPht1KCssyTllx0kOZGLXcEC4Gmcuvo18RLElma3H3qb9ZDpNuRfH9PDSGIDLrLlRkwj
 XQoOHJWauKiDQ1NqIUbLqPgFB59BslKLku/xWs+fpqBODnKBYwW6dxSEj0eQSqTnro7hDqHvq
 uGuOnwwudnlqqxvnO5DrCq4aHVUU7g6YeGpkCamJIXs3DcGtqjWDFtmO3oGkWkfLeyvC96kQF
 nM/WVfV+4Q37tWd7LzPCHRTvmArZf/Adtd1KpiIr/U+QgAo/uPORY3X78HqcUlgehRMZQkyQ+
 A0J8kpOAjajZPH20EMHGVgUFsf29adk5Zaw5koMJD21yN3gwQwFSqfl2NmPAhyte0BZPRl5tg
 BlZGEHlJQ/u2W0s0QgXCk6GoYKC3At9Q5mzDGxSE3SDuXQaMOGDS0uyox5tPnwJyuLM5Xx5Ep
 Vt5cIVgX4BFPa+bJT0xA3qTjocl+qkRTpEPPJSPu3DROECY+Hiuyqg/CVsGj0auyhEnEyKnrm
 dAatC67uzO/UUM1T6tskNMCEvARk99VXQQs2X/qSb9xHaDB4hUt+G7WnGG7EW9Ywmtq7ER0S7
 ynlSwx0OdSJ8UUBrUNOWBfePT+F99/T49+OFJbVxJNpXWc+uuzkpGs6ULkFWpWNY7U87zL4yv
 +mHzq0SdmQnSHd9g7qGYbg+I74u+krjntQRtI41M+pGA2FFli0OLutnICv53hK7c+ZZlwQEYR
 Ml2TvJ1VcbEK7dqPjXcGOKnZLCWdwusgZJ4iixz1rWb8+J7OHwJUfnErBhuZ455cC6KDKRiH9
 9mKwy9lAmd/+y7ttiMN5hO45yUxBsXwXCwJhMhi/fiZToW1EDVXeT16s8t253FJleSoBoWrbw
 4LEs1FNHHD1kefJkyOW/giFjgLSpNpoAq7618RJqN5ewdonLn8hjEmyrh1s8IrIhL5JMY9spB
 ihEp8l4mSklwFdzdFdCAsBlxnXCC+tTbXYQ/3thEqUuDu6ITAN7ut7s8v5WsF60i/WgvHs9wj
 Ybz+I9ZGNPkApLetadAoYog1doT7YF8yD57koUtpji11sjyleJ5v1vhyU68k=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> =E2=80=A6
>>> +++ b/fs/exfat/dir.c
>> =E2=80=A6
>>> +static int exfat_readdir(struct inode *inode, struct exfat_dir_entry
>> *dir_entry)
>>> +{
>> =E2=80=A6
>>> +			if (!ep) {
>>> +				ret =3D -EIO;
>>> +				goto free_clu;
>>> +			}
>>
>> How do you think about to move a bit of common exception handling code
>> (at similar places)?
> Not sure it is good.

The software development opinions can vary also for this change pattern
according to different design goals.
Is such a transformation just another possibility to reduce duplicate
source code a bit?

Regards,
Markus
