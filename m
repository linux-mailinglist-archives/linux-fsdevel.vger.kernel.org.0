Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282436DD451
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDKHej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 03:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDKHei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:34:38 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C6C1734
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 00:34:35 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230411073431euoutp0218ab4684f3b591ffa4f4016d047a171a~U0Rozu8gH2753927539euoutp02e
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 07:34:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230411073431euoutp0218ab4684f3b591ffa4f4016d047a171a~U0Rozu8gH2753927539euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681198471;
        bh=X+jdKU4xw4Un+0c7KH8qE8WrAcEXou9UQOU2NwQYVi0=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=oLBL5hMn9jiIaBexfmz9C9xNitXR+FltuatBkivqxTYRWRhReQ/cP0fpujbTHsd9T
         x4ifStWdRuYXOK1h9ChVlxLum+7ic8AH7DtUjzVk/mqm9ocuDaJRfs1+oASzkQba2l
         UZz6dSLYm8YveCXQKHHqXo5mMUl3Hiz93XIejvHc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230411073431eucas1p2523d7c21307cc8059da978db00bb0d33~U0RofiWDk1126411264eucas1p2L;
        Tue, 11 Apr 2023 07:34:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.34.09503.68D05346; Tue, 11
        Apr 2023 08:34:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230411073430eucas1p12e18f698b015722e0dc3220b1b9e3ccb~U0RoHGIMb1585815858eucas1p1k;
        Tue, 11 Apr 2023 07:34:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230411073430eusmtrp2eae57b1167013985d654a43bf0263dbe~U0RoGWGd82156721567eusmtrp2L;
        Tue, 11 Apr 2023 07:34:30 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-63-64350d8665df
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4B.03.34412.68D05346; Tue, 11
        Apr 2023 08:34:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230411073430eusmtip1571b0e58454b1e1ebfc3f2d9ae1cdd28~U0Rn3jYWb2380123801eusmtip1k;
        Tue, 11 Apr 2023 07:34:30 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 11 Apr 2023 08:34:29 +0100
Message-ID: <2f718a2e-9fbd-831a-a505-cecb32140ab7@samsung.com>
Date:   Tue, 11 Apr 2023 09:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/5] zram: always chain bio to the parent in
 read_from_bdev_async
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <minchan@kernel.org>, <martin@omnibond.com>,
        <hubcap@omnibond.com>, <brauner@kernel.org>,
        <viro@zeniv.linux.org.uk>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>, <hch@lst.de>,
        <devel@lists.orangefs.org>, <mcgrof@kernel.org>,
        <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZCw9Dxdd0C95EUza@infradead.org>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djP87ptvKYpBv97rS3mrF/DZrH6bj+b
        xevDnxgt9m+ewmRxesIiJouVq48yWbTf7WOy2HtL22LP3pMsFpd3zWGzuLfmP6vFyfX/mS1u
        THjKaLHs63t2i90bF7FZnP97nNXi9485bA6CHrMbLrJ4bF6h5XH5bKnHplWdbB6bPk1i9zgx
        4zeLR8PUW2weu282sHn8un2H1ePzJjmPTU/eMgVwR3HZpKTmZJalFunbJXBlrPj6mq2gibni
        3fEexgbGzUxdjJwcEgImEr9+PWDuYuTiEBJYwShx9OVTdpCEkMAXRom/h70hEp8ZJebd28IM
        07Hs+SkmiKLljBKr39nBFR3oPMQCkdjJKDFldxiIzStgJ/Hs3QewqSwCqhJT3vQwQcQFJU7O
        fAJWLyoQJdF3exMriC0MZJ8/cIYNxBYR0JS4tbwd7Dxmgc3MElPezwYrYhYQl7j1ZD7QIA4O
        NgEticZOsPmcAroSO5ddYoMokZfY/nYO1NGKEpNuvmeFsGslTm25xQQyU0LgE6fE+pvfoRIu
        Ehu3PYJqEJZ4dXwLO4QtI/F/53xoeFVLPL3xmxmiuYVRon/nejaQIyQErCX6zuSAmMxAR6/f
        pQ8RdZRYud0CwuSTuPFWEOIyPolJ26YzT2BUnYUUELOQ/DULyQOzEGYuYGRZxSieWlqcm55a
        bJiXWq5XnJhbXJqXrpecn7uJEZgYT/87/mkH49xXH/UOMTJxMB5ilOBgVhLh/frfOEWINyWx
        siq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDE0/03ZLkxafmNbju
        mJ0j/dP4xdL4Zp7AKpuIksgVa3ddf8jJsSi80053qohtxeHi/VoKrtMFP+mUyAdKn3PSab+9
        PnfZzal7Qm10eM8dtbwgezTOX2JCdNx+HifB3FkK83k4xLaq3znhqR53+8KMiam5hz/LMWxK
        37Mydr4U646EJhE1p1vKy/jnG+o451249vV5/Y1ZCfvfzX8Vui3S5gPj3JhZk7RZu969TXvk
        lPSRw6Q4UUx1gf/5kimPS44mqj50DOc4P/lL/dxJ0znsZxmV34u8WFXKwyFf2XUiWbGE9XkI
        867O47tYHIwu+yTb6VW0ajj/bGY8xJ6bwOndqOQz9av8yvhneqFNq9YqsRRnJBpqMRcVJwIA
        XOfx0fsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsVy+t/xu7ptvKYpBp07ZC3mrF/DZrH6bj+b
        xevDnxgt9m+ewmRxesIiJouVq48yWbTf7WOy2HtL22LP3pMsFpd3zWGzuLfmP6vFyfX/mS1u
        THjKaLHs63t2i90bF7FZnP97nNXi9485bA6CHrMbLrJ4bF6h5XH5bKnHplWdbB6bPk1i9zgx
        4zeLR8PUW2weu282sHn8un2H1ePzJjmPTU/eMgVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlro
        GZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrPj6mq2gibni3fEexgbGzUxdjJwcEgImEsue
        nwKyuTiEBJYySryds5YFIiEjsfHLVVYIW1jiz7UuNoiij4wSd9/PhOrYySixYedGRpAqXgE7
        iWfvPrCD2CwCqhJT3vQwQcQFJU7OfAI2VVQgSuLzgRawGmEg+/yBM2wgtoiApsSt5e3MIEOZ
        BTYzS0x5P5sVYsMDRok9f6+CbWAWEJe49WQ+0FQODjYBLYnGTrBBnAK6EjuXXWKDKNGUaN3+
        mx3ClpfY/nYOM8QLihKTbr6HeqdW4vPfZ4wTGEVnIblvFpINs5CMmoVk1AJGllWMIqmlxbnp
        ucVGesWJucWleel6yfm5mxiBqWXbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd6v/41ThHhTEiur
        Uovy44tKc1KLDzGaAgNpIrOUaHI+MLnllcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGan
        phakFsH0MXFwSjUwGWbuFHxy0Hy10PK6CSYSLvON5c+/3TLT971Tglrmyj9zrP9tYNhwJKE3
        4dHLFvfbX31br//cXR/ofKzWsmPmwlu/LzkIShx5qlYldn/1UaX8NR9S68P3f9UNlS2r/xOo
        Jv/himCk1P/8cBulStsIjueaHN+kNtzhPWr0bkaRkUpNenDA9r1Hpsl5l7t7aeVxngiTPOq2
        5ZPcPNVpfomzvrzjjT+xrOvDEvOOqFKFOP61Ys9VprhoHE098zWt+6T9/qUTdizqqL5e4Peo
        gD2i8OifRSodUh09n6X18/yfr/l633FVvEurhURB+YKm7XHHyyymhAcIx3II9b3jeClx4pzK
        lqN3l2qWTZX95f5eiaU4I9FQi7moOBEABa4n3rYDAAA=
X-CMS-MailID: 20230411073430eucas1p12e18f698b015722e0dc3220b1b9e3ccb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f
References: <20230403132221.94921-1-p.raghav@samsung.com>
        <CGME20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f@eucas1p2.samsung.com>
        <20230403132221.94921-2-p.raghav@samsung.com>
        <ZCw9Dxdd0C95EUza@infradead.org>
X-Spam-Status: No, score=-8.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> It will obviously conflict with this patch, so maybe the best thing is
> to get the other page_endio removals into their respective maintainer
> trees, and then just do the final removal of the unused function after
> -rc1.

Alright, I will drop the last patch that removes the page_endio function, and
send it after rc1. I will make the other changes as suggested by you.
