Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD351EFC71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFEPZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 11:25:58 -0400
Received: from mout.web.de ([212.227.15.4]:49115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgFEPZ6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591370729;
        bh=T0/VPTYXlqhfSmrj9VAFxCAw+LSQ/ts2H1JhtSXbBhg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LAHsA8AlHU4xWoDR/zaCG2hhQLMgHEUewqfpF6Rb7sKwxbARkdsnSnYYzQmcpW0Oc
         VsObCDptM6R3D8k0iZZFD6qVJ71WIWvZArAubfbO13Uq0itW+/+2HM9oyIz8fpiYii
         eLIXWoUmiQMzm+CF1iGzVL5FXhpB/iyfZrId6RCM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9GcY-1joM1H03wM-00Cl3D; Fri, 05
 Jun 2020 17:25:29 +0200
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
 <a050788f-5875-0115-af31-692fd6bf3a88@web.de>
 <20200605125209.GG19604@bombadil.infradead.org>
 <366e055b-6a00-662e-2e03-f72053f67ae6@web.de>
 <20200605151537.GH19604@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f9a73f54-8f4e-175a-b16b-486fec5c7f9e@web.de>
Date:   Fri, 5 Jun 2020 17:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605151537.GH19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eg14ewh6Vb8ouXqGBjZ4ZjoYR32d+E4JC6W6cYSHlwaPiISp0UE
 mK5rKF/L2t+McONDFSqgVGJj0ZKmP+fp9JEClEXq2D8rqkciT+73NR1rI3huGmnysOGoq64
 TGD/k2mL+DxBNfqi8R8Tr+zTPmuKgbTP8G8pUt/MI3dlLyauC8aHVaKglD1XzuMdV7qHiRr
 8W4dMqM41F/gXJCpVYYaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HvNglLEILxY=:MCNabvEo+xo3+lwMPmnv/G
 +WKcPzN9d2OfGQsy5xJwwJGmxFCHa4PqggutLhuNEzVtzYZkVGa761DyLFj/wnume0/prrCjP
 2W3J9mr41pR0R6F9Jc5MMQDnC9G8yxkDB4BGBaUxHTNhZQPpx3mKifQSVgjKoDggInLZ9KvRs
 jMZ4ZhGhYRKVT0GuuuO1WJoRJZQmLnGYp3UNA4qqa5sr6d4DPWVc7XFg811Os/GxWoKOB9vXJ
 bicfiqhCyMSaJ4xZynr520EO2PXVgxMywJVB7y0yolWtP7oNtcyEwAJbmwLK4Z8kcAGu/gbeI
 CPI/qyQs26Emg6ppBHbvwkXi8n170LcBuFJhex1hlrwLbzaaRbqm5WxtiRPH7+pLbV0p5GhuH
 6oEJko07DDFjhy6+NxcNQpvYdjeP/ocjtY2oycnqY0mWP90B75VW/TsbTHdiQKVj6wBRQcNMW
 KpEU7FZX6BvzTW1TRzBX4R3d1RbMjLBhnkMixL9RNdPYrxjJiNQkvncSjpd7Cre/bo7s//b2w
 6osXkoQ7aTPzbNtlafL7dKbiVAZu7/+WurNWa/tEGsMk27CYYAcg4CQvu50oEOTwYV5zLCsGM
 +KD2i3bVCWqPQTXnCdy7qQKpRnBN16J4h1maWrCq8rjrW3gwrEQNlpnUDh412r6BaXLA6Qwzt
 wSqzFIu2AKMebx+Jir/ZwRug1ez9E0BR2loIu15gQEJYy3GW9KhG6kzaqIkOHIQ+x708EsixK
 EIKKsdB6rjXZM25GpstalAd0ShJmNa3l/PxuZnzbF+J3nFY98M95tMwOSdPZ2NMCw4nuVl9ip
 1tWtnjSlIfLPbSS+m9B//4rKEyAOmMle5NO6u3hwVXoUXkV9lF93yKdBbzV7pCRiITAMlgHHX
 NfufWsN7gXNov9C0LPXPJxIj5SmD4bBBX6Wh1suNPzrRK4s3KUvRYdG+JYx3o7RtpoayMW3t7
 P0MZSkB2psdqZjdrzyn027Lxthstw6y+KcolGlEq6ifL6zf8PyB9UDBXOxtVW/uIRgT5Y5SW1
 xlzDjhV+tKmp8gzgEQA/cq5cVMJbo/P8eb0tgATwUimwTe6WtiKS0WxIR0Q+Hnr6GylihhWRe
 JFOQBIzeFSyuh+w8awtWoAoNvgIevF1isfgVRHJUp3fCi1PZbL9qSdoWX6uuirpRWnVNWF+F6
 p8enaKrH6S3NSsrb6Dibaa8t6Y17ar2wei6zdTOzLiFPVP8r+PgqrNoBj07/Jq9rps8BMxHlI
 N4Cq7JUEgFUm94wBU
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Do you find proposed spelling corrections useful?
>
> To commit messages?  No.

Are you really going to tolerate wording weaknesses there?
https://lore.kernel.org/linux-block/20200605104558.16686-1-yanaijie@huawei=
.com/
https://lore.kernel.org/patchwork/patch/1252648/


> You do not seem to progress, and making spelling corrections to
> changelog messages is a level of nitpicking that just isn't helpful.

I got obviously an other software development understanding
(also in this area).

Regards,
Markus
