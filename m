Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD71EF8E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgFENYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 09:24:05 -0400
Received: from mout.web.de ([212.227.15.3]:41993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgFENYE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591363423;
        bh=tuG0dZ1YiipXhKqpByGWLeDV+TUK9ozfY2PMN7JgfY0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZSlKtdDTbAsej8vgSsmeCzAeOeXKqASnz5uXWtDauAIQXvRrAezErr7Nolyyzqk1P
         X2gWxm4lf8y6K/EjyHHItJIyB0J09N/8tHUWDW2NK7vWpmQw5BNYp1ojQjdffN2aIc
         +PsIrDZ7Sky3kOs7wIa8PTQKaEUpvN+aW70Tv/Mk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MX0q4-1jV4p91lW0-00VxiJ; Fri, 05
 Jun 2020 15:23:43 +0200
Subject: Re: block: Fix use-after-free in blkdev_get()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam> <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111049.GA19604@bombadil.infradead.org>
 <b6c8ebd7-ccd3-2a94-05b2-7b92a30ec8a9@web.de>
 <20200605115158.GD19604@bombadil.infradead.org>
 <453060f2-80af-86a4-7e33-78d4cc87503f@web.de>
 <1d95e2f6-7cf8-f0d3-bf8a-54d0a99c9ba1@kernel.dk>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b642a81c-84cd-ca05-5708-c109dc2e5ea8@web.de>
Date:   Fri, 5 Jun 2020 15:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1d95e2f6-7cf8-f0d3-bf8a-54d0a99c9ba1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:BwE1qV5V3yoaN8alh2loRJYQ/SNkXOJw/is3lGQ+r33syBYM4rc
 7tZT4t8XdjBmX/Pko0yuAeYfpre4BQVQOX6GukHH8Ozp3tQd/PqNbT/VNYj1IE4B5jHyFPr
 FGDcqZHx1bq2oxmylMjbydGs2kt44oZEEcwsE5RZygiiElElHKZFJdhyo+Sq1572LbVSsPz
 4SjcToTf3mJGRwmRKbopA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iozseHijVFE=:ffGMyIeUiaLTrjIaP9Ukdo
 BHUF88Mw2P6UnEgz9e9WavSgrUb+6Ucv5WY5HS7Mjjt8oucC36Q26jMwzsh2sD6QZ3K+ytfWQ
 bbn1h9w8M0B0N2eCXmDVYuWffyoprKsCQRkPegyFazaX2Xr/HqpmqhQYb8DGguBc+ycGeuRtX
 AgAEvsccSX5SzCwrV3f9f53N0IYJ1t54FAw+XOl3HV2TrLZnQDGVAC518VWc1WI4wHx+nURT8
 4N3zsPYnywl54C/+o5M09fdaIYibYxeh7fTMDVdUIzVR4jMaPCWO2Dod8Aaqs7OlCIAh6hMVl
 mKKo1HzBixSQ7mch9gRRZ8TbFLaOtwA5u3/ACRGkDCwl7HY8OEsSkDPasxx9nUop5kRCDzAvR
 L72lPfBQewEEFbcwQxdpb7rG0v3K11jCZUWrJOIaE2SD1reqQagggqgMe07h9Jz9R4eBpXfny
 Xvacb974arGEmsDS02fx8GEGb1nwB6COrW50QAt8Cug2Lp0c/u6dqb5YO8rzxN2bmiuTbyGxd
 7fP0+m+q6vZtqoiYP942FaoA9eIL+JZ4A9rG7YZt/8anX4V5sgOA1EwNY/nC+jSYshE4ZURAy
 0yqvZ+I/G/gOwnskwapZk0Y6OkrxwysFJrcoCyr8EpbNTLuzTuXcupci7qDhrgTwddDSx5Acm
 DYcF3/PY79kpzmNlr7rQweuRUrulWXQnfPYfOWQg99g+bLOCxDZ3WdeAzzWl/KUkurWBvaZmJ
 DiBOyoBSouG9+lVLm0fdaANcBNn7mwJuJqem5rE3NSbFha1+56ZzUbjsp7XTVPjAbTRcjEFLl
 2wPK0ECkhoFjq2HOxkxptY8w++OpfF7hfu2lK3IMHSOi6Xa+WMcfIsnbCzgSS0R+WlTB+wEat
 dPpy4M1sjrykyVrMMgkVnuQMQnyKlwvye3PHVDBLEqbmJr43Dif25WNDnpXOFPL1XXQynNIU3
 mEEb1dBHZPVfEHkdi/2R8U9lZy1/F6uBT0YTXqMBBVk3hx7siDZkkG3wUuV0cwk1hIG9AUK2i
 Xxbo+Ct4vpHYJ3rChyJpXOAi0CQ39H7imbTx9olDZ7UvMaSPj9g2bQ5KYslSlE0LNgWcfFfyG
 MPtGFzgFKjMiBnh+ZJwB/JtVXiVaBEJBjdT7/f1BAiv2O9RTBIKORqlw4yPvcQBGS+kBcIlKB
 1fOGn+1Ix/KxDoyxlmOKKRonT6AbpCkNlKUUu7rYMcOeeMuBtDVTJXdLVxlJMMNF5jDtYEBNk
 0Ym1+aXaS64XShxPR
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Maintainers generally do change commit messages to improve them,
> if needed.

You have got a documented choice here.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=435faf5c218a47fd6258187f62d9bb1009717896#n468

Regards,
Markus
