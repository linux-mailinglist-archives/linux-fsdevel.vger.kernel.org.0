Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC956CC7B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjC1QRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjC1QRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:17:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68FBDD1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:17:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230328161715euoutp018da4add1f25d0250ee1412c7483d6262~QoYC8mT4B2949429494euoutp01x
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 16:17:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230328161715euoutp018da4add1f25d0250ee1412c7483d6262~QoYC8mT4B2949429494euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680020235;
        bh=mqLdRjs5YCQMtwNo6iN1eWz3Bgl+agNA8ISno6XaIPg=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=WYxOq+kwk7VUFdcCKV9Yen8Bm5utlrcKFTrH7FgZE1ZS8ez7qAN4QOVyaKYpXI8+b
         Yvd9QgMFijBu/sxxRSDnx75/hMhBWOIWDKX2xhjMwa4a/bvi52/XM93rlcO1fwPN4D
         xHvTiWz/AzJGdzoK2om5MZn82pSyqDoh2SV5tRB4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230328161714eucas1p24ad41a96092cf0b451efd29aa33f047b~QoYCAI75o2141921419eucas1p2B;
        Tue, 28 Mar 2023 16:17:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.72.09503.A0313246; Tue, 28
        Mar 2023 17:17:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230328161713eucas1p263e3a9167f956e10e522c91ae316b244~QoYBmJhZk1672516725eucas1p2N;
        Tue, 28 Mar 2023 16:17:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230328161713eusmtrp2aefa500222b07e9fb50fbfd5a23e1f5c~QoYBlbmRk1088210882eusmtrp26;
        Tue, 28 Mar 2023 16:17:13 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-78-6423130a41e6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 81.97.08862.90313246; Tue, 28
        Mar 2023 17:17:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230328161713eusmtip11c9b253d7b3c5c5f3a304baaefc01afc~QoYBZuuzm1480014800eusmtip1a;
        Tue, 28 Mar 2023 16:17:13 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.108) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 28 Mar 2023 17:17:12 +0100
Message-ID: <5865a840-cb5e-ead1-f168-100869081f84@samsung.com>
Date:   Tue, 28 Mar 2023 18:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH 1/5] zram: remove the call to page_endio in the bio
 end_io handler
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <martin@omnibond.com>, <axboe@kernel.dk>, <minchan@kernel.org>,
        <akpm@linux-foundation.org>, <hubcap@omnibond.com>,
        <viro@zeniv.linux.org.uk>, <senozhatsky@chromium.org>,
        <brauner@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <mcgrof@kernel.org>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-mm@kvack.org>, <devel@lists.orangefs.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZCMFcTHkTe/1WapL@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.108]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djP87pcwsopBl/ucVrMWb+GzWL13X42
        i9eHPzFa7N88hcli5eqjTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3WL3xkVsFuf/Hme1+P1jDpuDgMfshossHptXaHlcPlvqsWlVJ5vHpk+T2D1OzPjN4tEw
        9Rabx+6bDWwev27fYfX4vEnOY9OTt0wB3FFcNimpOZllqUX6dglcGZs2n2Ep+MJW0XPoNnMD
        4z7WLkZODgkBE4ldi36ydTFycQgJrGCUmLLlASuE84VRYsn2dkYI5zOjxJoXfXAtX+b2sEMk
        ljNKfNs9gRmuasrRr1DDdjNKHDq4gQmkhVfATuLF9NXMIDaLgKrEzcZJbBBxQYmTM5+wgNii
        AlESfbc3ga0QFoiQOPR2OyOIzSwgLnHryXywOSICHhL//+wC28Ys0MMs8W3KVqAEBwebgJZE
        Yyc7iMkJdN6sE7kQrZoSrdt/s0PY8hLb385hBimREFCW+H3eH+KZWolTW24xgUyUEHjHKXFu
        0yV2iISLxL3f51ggbGGJV8e3QMVlJP7vhDhHQqBa4umN38wQzS2MEv0717NBLLCW6DuTA1Hj
        KPF4+05WiDCfxI23ghDn8ElM2jadeQKj6iykgJiF5OFZSD6YheSDBYwsqxjFU0uLc9NTiw3z
        Usv1ihNzi0vz0vWS83M3MQLT4ul/xz/tYJz76qPeIUYmDsZDjBIczEoivL+vKaUI8aYkVlal
        FuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYNKu8Z3VdVhr0ZXqSv9q
        j/n6S6L8rrK+1GU852PwroW7RmR6MMc1e2YBv9YzOtF78/OLrQ7tUMuU8lNOLlnxsM1xloHi
        CXuxC3tZlF+uzZiZNGlX8nyBU9NfHeXjXBdct+p9zZrvTX/a+jTlTWbd0Q84u9VF8b2uyrNr
        h4trEwt2nDmmdMRm4vI7vB9EJ/Uddm5/9fn0tlnBU3bf0Y90KbDa6CL1wHf6rrDtkq3X1QNC
        vj9OW/RdZ9eZbwV2ekvrJ4n801xb8fLOD56NRy3PScyUmaC/3M770FuxZT/m6xbOnxEeqd5w
        WO6GMvvDTye2lsga/M7YcqR228Xc1+rJWqmPJ8d9X5HYb/FbqLm0qVeJpTgj0VCLuag4EQB0
        Dd9x+gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsVy+t/xu7qcwsopBq33dC3mrF/DZrH6bj+b
        xevDnxgt9m+ewmSxcvVRJov2u31MFntvaVvs2XuSxeLyrjlsFvfW/Ge1OLn+P7PFjQlPGS2W
        fX3PbrF74yI2i/N/j7Na/P4xh81BwGN2w0UWj80rtDwuny312LSqk81j06dJ7B4nZvxm8WiY
        eovNY/fNBjaPX7fvsHp83iTnsenJW6YA7ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1D
        Y/NYKyNTJX07m5TUnMyy1CJ9uwS9jE2bz7AUfGGr6Dl0m7mBcR9rFyMnh4SAicSXuT3sXYxc
        HEICSxkldlxbwwaRkJH4dOUjO4QtLPHnWhcbRNFHRokL3w+yQji7GSWm7F0M1sErYCfxYvpq
        ZhCbRUBV4mbjJKi4oMTJmU9YQGxRgSiJzwdawKYKC0RILJ0wFayeWUBc4taT+UwgtoiAh8T/
        P7uYQRYwC/QwS3ybspUJYttzRomGPVeBVnNwsAloSTR2soOYnEA/zDqRCzFHU6J1+292CFte
        YvvbOcwgJRICyhK/z/tDPFMr8fnvM8YJjKKzkFw3C8kVs5BMmoVk0gJGllWMIqmlxbnpucWG
        esWJucWleel6yfm5mxiByWTbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd7f15RShHhTEiurUovy
        44tKc1KLDzGaAoNoIrOUaHI+MJ3llcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphak
        FsH0MXFwSjUwcYQlLegyS4trW/1dx+j8tFe8n058DIzYMGPv922t++f53mJNNL+RVJzQqKPF
        pr9wL/uzpbvtfjIdkLTMcFq4v9XyjdXG0/YL1L+EhKh5ZB9Lkjv0Jffj/AOVvA4OMSy+5lzs
        N5Yr3oub/6Hj8l31RZomek9vrZDmUi/bdo5zw9SC/dqFkXeMDvC6T33pwbUsZfe7D9MmRtzO
        XJ5fkuxZ9rZZurF26+QOk0VTKyZ+N110yF979gSzuvn1XSbzr17wblVh3sbyMjTLZFbzRYsf
        IjpBKulcP9odPJTbg0WVOx81nbvVZ6FllaMsdGPil+OtEz5s6PZUV7vkwbTqfuTyK/+DEiY7
        MOc33hD3+D1RiaU4I9FQi7moOBEA8MWRRq8DAAA=
X-CMS-MailID: 20230328161713eucas1p263e3a9167f956e10e522c91ae316b244
X-Msg-Generator: CA
X-RootMTR: 20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com>
        <20230328112716.50120-2-p.raghav@samsung.com>
        <ZCMFcTHkTe/1WapL@casper.infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-28 17:19, Matthew Wilcox wrote:
> On Tue, Mar 28, 2023 at 01:27:12PM +0200, Pankaj Raghav wrote:
>> -static void zram_page_end_io(struct bio *bio)
>> +static void zram_read_end_io(struct bio *bio)
>>  {
>> -	struct page *page = bio_first_page_all(bio);
>> -
>> -	page_endio(page, op_is_write(bio_op(bio)),
>> -			blk_status_to_errno(bio->bi_status));
>>  	bio_put(bio);
>>  }
>>  
>> @@ -635,7 +631,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>>  	}
>>  
>>  	if (!parent)
>> -		bio->bi_end_io = zram_page_end_io;
>> +		bio->bi_end_io = zram_read_end_io;
> 
> Can we just do:
> 
> 	if (!parent)
> 		bio->bi_end_io = bio_put;
> 

Looks neat. I will wait for Christoph to comment whether just a bio_put() call
is enough in this case for non-chained bios before making this change for the
next version.

Thanks.
