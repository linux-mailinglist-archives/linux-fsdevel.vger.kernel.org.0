Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A77734D35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFSIKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjFSIJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:09:51 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8581BD6
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 01:09:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230619080903euoutp01c7e998cec6f3ebd454d338f8452d9b39~qAQfLVK3t3117831178euoutp013
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 08:09:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230619080903euoutp01c7e998cec6f3ebd454d338f8452d9b39~qAQfLVK3t3117831178euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687162143;
        bh=0RiBzXViYev57qzFaEFn6uZf9JksWi4MG5BSsmyK/ho=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=DRR+MnsOa9JIpssTAxpYyQ0GA0in4MQ6LIrhTzWAjKEUd/Uk+ppjNFh7xvjGwznIx
         21l4UbLXjGONQjQZr6ToaPhnXNmiZdCw/d70P+PLmlAWTTds9MDxB6o0G8TutEZxVt
         SC7fcXJwr3louI3FMYrl5rxCiPDXtVZh+N0uncgw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230619080902eucas1p1ab7ab9ce51c9d687eedc699f33478518~qAQegsimU1347613476eucas1p1K;
        Mon, 19 Jun 2023 08:09:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.19.42423.E1D00946; Mon, 19
        Jun 2023 09:09:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67~qAQdMycnx0244102441eucas1p2Y;
        Mon, 19 Jun 2023 08:09:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230619080901eusmtrp2b7cc41676a8ba9a4d0b7c33b2c3ccc1f~qAQdMCURE0117001170eusmtrp2E;
        Mon, 19 Jun 2023 08:09:01 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-7f-64900d1e46f2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.E3.14344.D1D00946; Mon, 19
        Jun 2023 09:09:01 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230619080900eusmtip25f4fb56d3849cf1e0c88908d39b21a2b~qAQcdmB3w2848728487eusmtip2k;
        Mon, 19 Jun 2023 08:09:00 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 19 Jun 2023 09:08:58 +0100
Date:   Mon, 19 Jun 2023 10:08:57 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>, <p.raghav@samsung.com>,
        <gost.dev@samsung.com>
Subject: Re: [PATCH 6/7] mm/filemap: allocate folios with mapping blocksize
Message-ID: <20230619080857.qxx5c7uaz6pm4h3m@localhost>
MIME-Version: 1.0
In-Reply-To: <20230614114637.89759-7-hare@suse.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX+/63e/bu58O9FnpWxHHopE6IyMMa6FiH80ltvdb9V6kDt5
        Os2x9GjXCalcac2KiuzuxLkLnZREnjlPl7ZiGrYeWHU96Pqd8d/783m/X5+9v9uXJoXVbt50
        fPJ+RpEsTRRRPE5d0+DThX58rTz4xUd/sa62hhJbyvMJ8ZXqB4S4/n2g2FLfwhHbtF1I7BjQ
        UWu4EsPlAIm+KpuSPCx0cCTmd2pKYmhVSfr0flupaN4qOZMYf4BRLFq9hxfXbS2lUuqnHzpj
        M1BqNOqRg9xpwEtBV9qOchCPFuLLCC7kaFxDPwJTegfFDn0IKr70cP4iBkurG2tUIjDr7vxL
        nT35imQHI4KOoVzSiXCwP3RmqMcRmqZwABzP5jrXnlgEPZlWrjNP4jwCsu12wmlMxRFQ0X5i
        guXjUKjq+4ZY7QEtRZ0TNdzxEnhy9xmXrSQCteGxq14aPDK+J5xHAX+nocRhQ6yxHtJrvrr0
        VOhuNrrgGTBmukiwWgVdNgfJwukI8ky1lLM14JWgeZzozJA4Hq7Zv7jurAVtXgdiIwKw/fBg
        IwLIrztPsms+ZGUI2fQcqLZ/57DrGdDWK9AiUfF/Dyv+7z6rF0CZuZcqHidI7AOVozQr50Pt
        7UVlyK0KeTGpyqRYRrk4mTkYpJQmKVOTY4Nke5P0aPw/tY42995CJd09QVZE0MiKgCZFnvyo
        eo1cyJdLDx9hFHtjFKmJjNKKfGiOyIsfGNYiE+JY6X4mgWFSGMVfl6DdvdXElrkH32WGXjpl
        bbCUWmTReV2mLTAQclVffOP6+mBrXOS9I1tz1bI1GRpf4eusQZFi9/YO0yEYJYeyGpvJt6fD
        Px17WfRscsxvjPftLv84JdZcXXGd16i7YKz9nJY/FLlxW67vbS23dUOIOcz986bOAu+Zsg85
        DmNh/Af9WMrcBP25BbtGCnCQ4GVPpKrSUdIwHEEl3Fx48+fszb/8V7y52zTNcDRKP2kkqy36
        uDGzvF2yzlRT5Kc6MJOalWRriJOc9/49KWr5j1DdPE142vPcOf0R8vu24cbUiD6D3+mmhsYB
        q2/B8DLBzl8aZWCz6tGttDK7z1jNjo392y0OqX92nVTEUcZJFweQCqX0D9hWA3O+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7qyvBNSDOY0cFjMWb+GzWLPoklM
        FitXH2Wy2HtL22LP3pMsFjcmPGW0+P1jDpsDu8fmFVoem1Z1snmcmPGbxWP3zQY2j82nqz0+
        b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y/jwcjZTwS/hiosLHzE3MF7h72Lk5JAQMJHYvOc0axcjF4eQwFJGif+LXzBCJGQkNn65ygph
        C0v8udbFBmILCXxklPh9lQ+iYQujROuuY8wgCRYBVYknbQ1ADRwcbAJaEo2d7CBhEQEliY/t
        h9hB6pkF+pkkOu/dYwJJCAt4Syy73wTWyytgLrHq80tGiAWREq93djNCxAUlTs58wgJiMwvo
        SCzY/YkNZD6zgLTE8n8cIGFOASOJs/svsEPcqSTRsPkMC4RdK/H57zPGCYzCs5BMmoVk0iyE
        SQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERt22Yz+37GBc+eqj3iFGJg7GQ4wSHMxK
        IrxBe/tShHhTEiurUovy44tKc1KLDzGaAkNiIrOUaHI+MO7zSuINzQxMDU3MLA1MLc2MlcR5
        PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYzG4w+PeefcTuGFx4w9c6P8M6XvflKWmhN7MnKWSI
        PvJ+OifIcVKq38WNR06bvGoMzTr1ouC214cje6sXzP+4j1e0sP+jkE5mtSmLxxJ/uZ18petD
        uu9utisQLVy1ccFt6zKuXbK9sRPmqcb5JeyMWpRi8tnBMLxp/bFZr7Qnr/vxt/1p/oQpv3e2
        yknMWfNoaffTaZfUNSf8Pzil+sdi/p+nxcTWXwmsMp1wyq02Zu4Jzn1nHPn9StKt5B2mrjpR
        x3rxZVn8689bL9xw7kv58oxDqNd8HldMxf/lvN/lIj7PuuY8ZcedJRdEP/vz5jyas5IpIY4t
        55jyhk+2NY07S4NiHmw0mrixMb1TdHcyvxJLcUaioRZzUXEiAOyKiElDAwAA
X-CMS-MailID: 20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----VNgDLSb4c7ZKb-8DtXAfXWqOiEfz7BS1m7F6.Sab_7Xb42PA=_11bbf7_"
X-RootMTR: 20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67
References: <20230614114637.89759-1-hare@suse.de>
        <20230614114637.89759-7-hare@suse.de>
        <CGME20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------VNgDLSb4c7ZKb-8DtXAfXWqOiEfz7BS1m7F6.Sab_7Xb42PA=_11bbf7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Hannes,
On Wed, Jun 14, 2023 at 01:46:36PM +0200, Hannes Reinecke wrote:
> The mapping has an underlying blocksize (by virtue of
> mapping->host->i_blkbits), so if the mapping blocksize
> is larger than the pagesize we should allocate folios
> in the correct order.
> 
Network filesystems such as 9pfs set the blkbits to be maximum data it
wants to transfer leading to unnecessary memory pressure as we will try
to allocate higher order folios(Order 5 in my setup). Isn't it better
for each filesystem to request the minimum folio order it needs for its
page cache early on? Block devices can do the same for its block cache.

I have prototype along those lines and I will it soon. This is also
something willy indicated before in a mailing list conversation.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122..031935b78af7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -245,7 +245,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			continue;
>  		}
>  
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask, mapping_get_order(mapping));
>  		if (!folio)
>  			break;
>  		if (filemap_add_folio(mapping, folio, index + i,

Did you turn on CONFIG_DEBUG_VM while testing? I don't think we are
incrementing the counter in this function correctly as this function
assumes order 0. We might need something like this:

-               ractl->_nr_pages++;
+               ractl->_nr_pages += folio_nr_pages(folio);
+               i += folio_nr_pages(folio) - 1;
> @@ -806,7 +806,7 @@ void readahead_expand(struct readahead_control *ractl,
>  		if (folio && !xa_is_value(folio))
>  			return; /* Folio apparently present */
>  
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask, mapping_get_order(mapping));
>  		if (!folio)
>  			return;
>  		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
> @@ -833,7 +833,7 @@ void readahead_expand(struct readahead_control *ractl,
>  		if (folio && !xa_is_value(folio))
>  			return; /* Folio apparently present */
Same here:
-               ractl->_nr_pages++;
+               ractl->_nr_pages += folio_nr_pages(folio);

>  
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask, mapping_get_order(mapping));
>  		if (!folio)
>  			return;
>  		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
> -- 
> 2.35.3
> 

------VNgDLSb4c7ZKb-8DtXAfXWqOiEfz7BS1m7F6.Sab_7Xb42PA=_11bbf7_
Content-Type: text/plain; charset="utf-8"


------VNgDLSb4c7ZKb-8DtXAfXWqOiEfz7BS1m7F6.Sab_7Xb42PA=_11bbf7_--
