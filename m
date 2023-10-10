Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51A7BF227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377089AbjJJFWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 01:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjJJFWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:22:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70EA7
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 22:22:41 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231010052238epoutp02d63dfbda658ff4b9e9a6a050e3eb8323~Mp4caT8No1638316383epoutp02s
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 05:22:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231010052238epoutp02d63dfbda658ff4b9e9a6a050e3eb8323~Mp4caT8No1638316383epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696915358;
        bh=jOUVYTTmGfCy0WayWeEEgsbpCLdznKQKZ/VUIJ4/w18=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=EcrLRhBQnpJ/1Qkdm6ZXZhSZhjtKnevU15rRDbaKO9ikk0IxtlWKNid1ADYZS6cwU
         DKNl/h/MR/5weKtwjdsOUkVBGe4uUk/HLFUADeLIwdsWxTCfFSaGAznE+WgOUapYz4
         40RlNDWEiqPH8z914yM5iGlOD5s3hvowBPfL5/j4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231010052234epcas5p1cd90af22a0fdc1143638d0bbd4b851ad~Mp4Yban2_0987609876epcas5p19;
        Tue, 10 Oct 2023 05:22:34 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S4PRX2ZXdz4x9Pv; Tue, 10 Oct
        2023 05:22:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.02.09023.89FD4256; Tue, 10 Oct 2023 14:22:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231010052231epcas5p157317b63e880270707701e38a311455c~Mp4We0mFV0987109871epcas5p12;
        Tue, 10 Oct 2023 05:22:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231010052231epsmtrp1d11fa017961b17185c5533cb20b1ddf1~Mp4WeHzJq0684706847epsmtrp1N;
        Tue, 10 Oct 2023 05:22:31 +0000 (GMT)
X-AuditID: b6c32a44-c7ffa7000000233f-ce-6524df98ce34
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.A6.18916.79FD4256; Tue, 10 Oct 2023 14:22:31 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010052230epsmtip2895bced299be5640f880dc12491a7ebd~Mp4UtWKV02473924739epsmtip2r;
        Tue, 10 Oct 2023 05:22:29 +0000 (GMT)
Message-ID: <28f21f46-60f1-1651-e6a9-938fd2340ff5@samsung.com>
Date:   Tue, 10 Oct 2023 10:52:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer
 bio->bi_ioprio bits
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231005194129.1882245-2-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmuu6M+yqpBi9P8lu8/HmVzWL13X42
        i2kffjJbrHoQbvFgv73FytVHmSzmnG1gsth7S9tiz96TLBbd13ewWSw//o/J4sGfx+wOPB6X
        r3h77Jx1l93j8tlSj02rOtk8dt9sYPP4+PQWi0ffllWMHp83yXm0H+hmCuCMyrbJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpXSaEsMacUKBSQWFys
        pG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcXhdH2vBWv6K
        VVPvMjYw7uTpYuTkkBAwkbh1oI25i5GLQ0hgN6PEqrOHGCGcT4wSZy99Z4Nz1jVNYoVpmb+0
        lwnEFhLYySix8nI4RNFbRonuryfZQBK8AnYSt7fPYAexWQRUJQ6//8gMEReUODnzCQuILSqQ
        JPHr6hxGEFtYIFZi4cc5YPXMAuISt57MB1sgIuAm0XB1F9gVzAJvmSQebjkAdAUHB5uApsSF
        yaUgNZwCVhJH9u1mhOiVl9j+dg7YPxICRzgkVv3ewAhSLyHgIvF5EwfEA8ISr45vYYewpSRe
        9rdB2ckSl2aeY4KwSyQe7zkIZdtLtJ7qZwYZwwy0dv0ufYhVfBK9v58wQUznlehoE4KoVpS4
        N+kpNKjEJR7OWAJle0hsv3GQBRJUexklHqy7xzKBUWEWUqjMQvL9LCTfzELYvICRZRWjZGpB
        cW56arJpgWFeajk8vpPzczcxghOzlssOxhvz/+kdYmTiYDzEKMHBrCTC+yhTJVWINyWxsiq1
        KD++qDQntfgQoykweiYyS4km5wNzQ15JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2amp
        BalFMH1MHJxSDUzLT4iFhLv9i72t1H1eQ9VocXDUHy77dwoSnyQ7dwhPeL6Z7UXOw5Tnmj0L
        GMLeFLz7ULeTTc1Z1fodt9rp+itFelXy4j+WS1RcetC3f83+oORfRpv2R7rEz5dM0rsh6br6
        dOfP/zwOeRfXu96o4zlU/kzpadbma51HwmVsGXSYxAP/epWESfpf4Pq1bx/PrOSfO0/0n77J
        LdrQuXYR85NZh9M3JC5PKbvZMU9FwpfF4f9rvWUnNhy+58KYNWnT2u1zN12aJKfJln5Nf9un
        F0UfC2/asskb7e7ckPJB3FFgWVKsZ7HUcmXXUgGBiolHV92trRSfs7Vti1PN569/z/IFhHT5
        tIscMlWPuXspv0aJpTgj0VCLuag4EQAjYzV2VQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvO70+yqpBs8WmVq8/HmVzWL13X42
        i2kffjJbrHoQbvFgv73FytVHmSzmnG1gsth7S9tiz96TLBbd13ewWSw//o/J4sGfx+wOPB6X
        r3h77Jx1l93j8tlSj02rOtk8dt9sYPP4+PQWi0ffllWMHp83yXm0H+hmCuCM4rJJSc3JLEst
        0rdL4Mo4vK6PtWAtf8WqqXcZGxh38nQxcnJICJhIzF/ay9TFyMUhJLCdUeLy81PMEAlxieZr
        P9ghbGGJlf+es0MUvWaU2Ly1nQUkwStgJ3F7+wywIhYBVYnD7z8yQ8QFJU7OfAJWIyqQJLHn
        fiMTiC0sECux8OMcsHpmoAW3nswHi4sIuEk0XN3FBrKAWeAtk8SElstQJ+1llJj2Zw7QVA4O
        NgFNiQuTS0EaOAWsJI7s280IMchMomtrF5QtL7H97RzmCYxCs5DcMQvJvllIWmYhaVnAyLKK
        UTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzgCtYJ2MC5b/1fvECMTB+MhRgkOZiUR3keZKqlC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTItNC1nqPln+
        tUx2Nz2h9r/DdNObuWkbUhIfWhvENLB/nO3LYW0x/1jT14bo5aK7uq7+jOu8EXH9bp7T0Zlz
        W0KlNr6bMOP87+Y9LSlaHSdOa7vJfwyqL/93n/HpqocXDsvUf3HefO2GEYsyyy+21qNit6oD
        eqds8PomcFTeQ2xFULDETasrc078WLnivuSv1zcmam6/e2aqQ8GOgg3XqsM8dIrcJ9za6z7T
        e8+DGe88RM65Fa9ZZHiy2bVm3tFnV3XNLu05/frBzc9ct4uWT4id0J3vHZfXOjPu8zTuF/9P
        au7aX2WR+nGdhlWvi+DpD9On7de643JK8G1zyR92q6hTqlteJsh9rOHo4ue2qn2oxFKckWio
        xVxUnAgALeD+6S8DAAA=
X-CMS-MailID: 20231010052231epcas5p157317b63e880270707701e38a311455c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e
References: <20231005194129.1882245-1-bvanassche@acm.org>
        <CGME20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e@epcas5p1.samsung.com>
        <20231005194129.1882245-2-bvanassche@acm.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/2023 1:10 AM, Bart Van Assche wrote:
> A later patch will store the data lifetime in the bio->bi_ioprio member
> before bio_set_ioprio() is called. Make sure that bio_set_ioprio()
> doesn't clear more bits than necessary.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq.c         |  3 ++-
>   include/linux/ioprio.h | 10 ++++++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2d11183f62e..bc086660ffd3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2926,7 +2926,8 @@ static void bio_set_ioprio(struct bio *bio)
>   {
>   	/* Nobody set ioprio so far? Initialize it based on task's nice value */
>   	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
> -		bio->bi_ioprio = get_current_ioprio();
> +		ioprio_set_class_and_level(&bio->bi_ioprio,
> +					   get_current_ioprio());
>   	blkcg_set_ioprio(bio);
>   }
>   
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 7578d4f6a969..f2e768ab4b35 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -71,4 +71,14 @@ static inline int ioprio_check_cap(int ioprio)
>   }
>   #endif /* CONFIG_BLOCK */
>   
> +#define IOPRIO_CLASS_LEVEL_MASK ((IOPRIO_CLASS_MASK << IOPRIO_CLASS_SHIFT) | \
> +				 (IOPRIO_LEVEL_MASK << 0))
> +
> +static inline void ioprio_set_class_and_level(u16 *prio, u16 class_level)
> +{
> +	WARN_ON_ONCE(class_level & ~IOPRIO_CLASS_LEVEL_MASK);
> +	*prio &= ~IOPRIO_CLASS_LEVEL_MASK;
> +	*prio |= class_level;

Return of get_current_ioprio() will touch all 16 bits here. So 
user-defined value can alter whatever was set in bio by F2FS (patch 4 in 
this series). Is that not an issue?

And what is the user interface you have in mind. Is it ioprio based, or 
write-hint based or mix of both?
