Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3A6D201B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjCaMXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjCaMXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:23:34 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD520609
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 05:23:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230331122236euoutp014b209baccb88e74a6f066a0d80963eaf~RgHBwEi4w0417504175euoutp01R
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 12:22:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230331122236euoutp014b209baccb88e74a6f066a0d80963eaf~RgHBwEi4w0417504175euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680265356;
        bh=hcuGDJry3da1akfsGf4g2A9Xv80OXlUoG+ekZfXmh3U=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=HkHTDHHmSA41uTSprLQ69X4AG+uE9Z/2Qulc4hPwEJHpUxIRnDwWYbofO4RGvMj3x
         c/RhO5eA3T0eCeZaw7sJr+T6y75Iw9HiNpQtT8V1UNf24OQlBLamqJYzfzQi1luQxI
         Ca4P/VK+caJtx0ZXjIPBggIVRC8jMzyr+bwbzcO0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230331122235eucas1p1a9a510d4bc8face99a131261e67a3fe5~RgHBKw3Qm1948519485eucas1p10;
        Fri, 31 Mar 2023 12:22:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CD.09.09966.B80D6246; Fri, 31
        Mar 2023 13:22:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230331122235eucas1p2208286ce210d9b01ea36a26bd3897b72~RgHAr05g82770927709eucas1p2v;
        Fri, 31 Mar 2023 12:22:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331122235eusmtrp26c22aae866cd012f4e7e50feaedb612a~RgHAqvH4p2795527955eusmtrp2U;
        Fri, 31 Mar 2023 12:22:35 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-cd-6426d08b6c09
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.16.08862.B80D6246; Fri, 31
        Mar 2023 13:22:35 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230331122235eusmtip2507df0accd5c684b8609aeab0cf06795~RgHAeTKQh2975929759eusmtip2b;
        Fri, 31 Mar 2023 12:22:35 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 31 Mar 2023 13:22:34 +0100
Date:   Fri, 31 Mar 2023 14:14:18 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        <linux-raid@vger.kernel.org>, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        <jfs-discussion@lists.sourceforge.net>, <cluster-devel@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <p.raghav@samsung.com>
Subject: Re: [PATCH 04/19] fs: buffer: use __bio_add_page to add single page
 to bio
Message-ID: <20230331121418.mch3y43pbt3pahc5@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56321f8ef1e70e9e541074593575b74d3e25ade2.1680108414.git.johannes.thumshirn@wdc.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djPc7rdF9RSDI4907LYtm43u8Xqu/1s
        FidXP2azaG3/xmSx991sVosLPxqZLPYsmsRksXL1USaLix9bmSz+dt1jsnh6dRZQyS1ti0uP
        V7Bb7Nl7ksXi3pr/rBbt83cxWhya3Mxk0TW7lc3i9p0fzBYnbklbHF/+l83i9485bA5iHptX
        aHlcPlvqsWlVJ5vHpk+T2D12L/jM5LH7ZgObR2/zOzaP9/uusnms33KVxWPz6WqPz5vkPNoP
        dDMF8ERx2aSk5mSWpRbp2yVwZUy/dYa5YB1Lxd2pN9gaGI8xdzFycEgImEgs2u3RxcjFISSw
        glFiwcm5rBDOF0aJ843X2SCcz4wSUx8sZIHpeHbdEiK+nFFi66Q9LHBF2680MkI4WxglHm9Y
        wgjSwSKgKtF92QrEZBPQkmjsZO9i5OQQETCWuPJ9IVgvs8B9VolLR6aBlQsLhEqsWh8EUsML
        tKtzzltWCFtQ4uTMJywgNrOAjsSC3Z/YQMqZBaQllv/jAAlzCiRKnLkwC6xEQkBJomHzGSi7
        VuLUlltMIKskBP5xSkzZ844VIuEi0Ta/hRHCFpZ4dXwLO4QtI/F/53wmCLta4umN38wQzS2M
        Ev0717NBAsJaou9MDkSNo8T2xbcZIcJ8EjfeCkKcyScxadt0aEDzSnS0CUFUq0nsaNrKOIFR
        eRaSx2YheWwWwmMLGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKbN0/+Of9nBuPzV
        R71DjEwcjIcYJTiYlUR4C41VU4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzatueTBYSSE8sSc1O
        TS1ILYLJMnFwSjUwbZLscdAMvKSRfNrp6aT6Q89z9M4xi2vcLU7+sphJ/WPwP76uDyx6HgG5
        ey0CZn4TvMynYbrPwPjR7jCds86TVmoJeC6d28Po5rf55fYnyjwnL75Jux12NXhRju7rqLJt
        JmkJlhv9ti1i/Tr7VNvCGQcvTT4ufMA5QPFMUnCr4/1fsgcuFXF/U1TVFGfalcr9N2NxT6LO
        a//lp1iZ9j7y/fbCm2X/e62DgidFv05ZrjI1RLLpRZFpT84RRtup/LaVFhequqL3r2n2e3h0
        koTKj6zAFd+vtZnvPpD104HPlOtago60hUH1xqjPYbEaUryLerzl1ecr/Z5ledNt6+QJx6ra
        vcWv+XN86lIvYzVSYinOSDTUYi4qTgQA/sdKXgoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xe7rdF9RSDHbc5bDYtm43u8Xqu/1s
        FidXP2azaG3/xmSx991sVosLPxqZLPYsmsRksXL1USaLix9bmSz+dt1jsnh6dRZQyS1ti0uP
        V7Bb7Nl7ksXi3pr/rBbt83cxWhya3Mxk0TW7lc3i9p0fzBYnbklbHF/+l83i9485bA5iHptX
        aHlcPlvqsWlVJ5vHpk+T2D12L/jM5LH7ZgObR2/zOzaP9/uusnms33KVxWPz6WqPz5vkPNoP
        dDMF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        ZUy/dYa5YB1Lxd2pN9gaGI8xdzFycEgImEg8u27ZxcjFISSwlFFi8uoV7F2MnEBxGYlPVz5C
        2cISf651sUEUfWSUuHjmGhOEs4VR4uCEJnaQSSwCqhLdl61ATDYBLYnGTrBeEQFjiSvfF7KA
        lDML3GeVWPVlDhNIjbBAqMSq9UEgNbxAN3TOecsKMXIKo0RL9ycmiISgxMmZT1hAbGYBHYkF
        uz+xgfQyC0hLLP/HARLmFEiUOHNhFgvEnUoSDZvPQNm1Ep//PmOcwCg8C8mkWUgmzUKYtICR
        eRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgAtl27OfmHYzzXn3UO8TIxMF4iFGCg1lJhLfQ
        WDVFiDclsbIqtSg/vqg0J7X4EKMpMCAmMkuJJucDU1heSbyhmYGpoYmZpYGppZmxkjivZ0FH
        opBAemJJanZqakFqEUwfEwenVAPThPJ5nAGnFlnq/50p4F7+Pvm5oDzze7HQLufooAPH5YSu
        TNeOdTHPOjFt23a33qaZjzJm/1b75Ts/djdHyp89mxfafj105NXLezzVYhvmd3QbHZ6ouv2u
        yR63AjsrjoetMzlndmxd8ztcu7bB9s66aVwS4Yl9Z4tmssSGbJP7tjH41/SZt1aInVJv/dY/
        /ZlF5YYZMzZsk3R0dT8jbiytWKvSKhswbeNkHf/CTeaeB0Wesbo/WpOo3rbOU+RhA0fB64uX
        GGc12J0WClvwjPHutcvygmVR10oeO/atlasK5/G+nF/AIZYx21DOcFLpin6/NpYbyw40n7l4
        T/1HQWbnj8AZwSJujJWNXp9ifK2UWIozEg21mIuKEwEieVEeqQMAAA==
X-CMS-MailID: 20230331122235eucas1p2208286ce210d9b01ea36a26bd3897b72
X-Msg-Generator: CA
X-RootMTR: 20230331122235eucas1p2208286ce210d9b01ea36a26bd3897b72
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230331122235eucas1p2208286ce210d9b01ea36a26bd3897b72
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
        <56321f8ef1e70e9e541074593575b74d3e25ade2.1680108414.git.johannes.thumshirn@wdc.com>
        <CGME20230331122235eucas1p2208286ce210d9b01ea36a26bd3897b72@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:05:50AM -0700, Johannes Thumshirn wrote:
> The buffer_head submission code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
