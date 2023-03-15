Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6016BB232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 13:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjCOMeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjCOMeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:34:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2279F23F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 05:32:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230315123236euoutp0212ea21843cdc15c98a549e2d6a781632~Ml7MVAAC72616226162euoutp02d
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 12:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230315123236euoutp0212ea21843cdc15c98a549e2d6a781632~Ml7MVAAC72616226162euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678883556;
        bh=ykKPRIypeSKVaDre01XbjaH9/YVIiqKYL9EWvo/S2nY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VoKw1Tcp4cjWDG2KDq6FYtdu1ywDgF0UiIGe0sZKPUTD3Z7RguFTgEOJIdf3Fj6Lp
         HMmUj54qlqQBWU/zytXodhQK/PpDSc+qFIfODc+NV3WPsWot5VVZ4tKtGpuVu6xCdr
         yrLSUnxbq0K38hgRS+XL/Gxkiaaoj542Yaza3DDg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230315123234eucas1p2b5b92251f39ab613d887dd832d91d5e7~Ml7Ky7IgR1509115091eucas1p2r;
        Wed, 15 Mar 2023 12:32:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0C.70.09503.2EAB1146; Wed, 15
        Mar 2023 12:32:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230315123234eucas1p179bf8c0583a71d91bef7e909d7ec6504~Ml7KWawqf2754127541eucas1p1-;
        Wed, 15 Mar 2023 12:32:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230315123234eusmtrp13d1335c93e077877fca4327b447c8295~Ml7KVrG131056310563eusmtrp1t;
        Wed, 15 Mar 2023 12:32:34 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-15-6411bae22586
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.AF.09583.2EAB1146; Wed, 15
        Mar 2023 12:32:34 +0000 (GMT)
Received: from localhost (unknown [106.210.248.172]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230315123234eusmtip1ee33ed5ffeb24bba0305d7a1d80dec28~Ml7KEHbZD0648506485eusmtip1z;
        Wed, 15 Mar 2023 12:32:34 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC PATCH 0/3] convert page_endio to folio_endio
Date:   Wed, 15 Mar 2023 13:32:30 +0100
Message-Id: <20230315123233.121593-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7qPdgmmGEydq28xZ/0aNovVd/vZ
        LF4f/sRosX/zFCaLmwd2Mlm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovPS1vYLXZvXMRmcf7vcVaL3z/msDkIesxuuMjisXmFlsfls6Uem1Z1snls+jSJ3ePE
        jN8sHg1Tb7F5/Lp9h9Wjb8sqRo/Pm+Q8Nj15yxTAHcVlk5Kak1mWWqRvl8CV8X7FZ/aCuewV
        7Z82szQw7mHtYuTkkBAwkdi+dgVbFyMXh5DACkaJzX8/MUI4Xxglvs6ZxQThfGaUaD+0jL2L
        kQOs5dsGZ4j4ckaJu1NWsUI4Lxkldv9exwhSxCagJdHYyQ4SFxE4wyjxpGUi2A5mgfuMEteb
        frODLBcWsJKY+Xg/E4jNIqAq0f1oOSOIzQsUn3NnKTvEgfIS+w+eZYaIC0qcnPmEBcRmBoo3
        b53NDDJUQmAxp8SKh1uhPnKRWH1vM1SzsMSr41ugbBmJ05N7WCDsaomnN35DNbcwSvTvXM8G
        8Zu1RN+ZHBCTWUBTYv0ufYhyR4kLuzuYICr4JG68FYQ4gU9i0rbpzBBhXomONiGIaiWJnT+f
        QC2VkLjcNAdqqYfE8YeLwD4UEoiVmPZ8BvsERoVZSB6bheSxWQg3LGBkXsUonlpanJueWmyY
        l1quV5yYW1yal66XnJ+7iRGYBE//O/5pB+PcVx/1DjEycTAeYpTgYFYS4Q1nEUgR4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwBSxkj3lhkroci775Zdf
        bzkzMX/5+yKu2RK8R3bWe09zv2yzQF8znaWpkyMtZfL2zEPqQncDBY5Uf1WadrW6nI1VrPdT
        V5SXnGRw4fwL5gtedd/nmfT728ZlMWG5m0TNg87lb9hxpDr5501LnpikCZwL354QMv7UmJkv
        kimuobLj1crlhSx3fqa5ldyKm27Y+E6qsvHWijWcHg+m5xW4lKw8f01DuYF1GcfRvg0i/o2C
        Muoz9wjyXWk/r/frFsemNQzz1j9ua9+hOVW1vbxO8oRI14+Hq5MvarQWnRQJz6tf2LROhIl9
        SZdAesbFJWeubNqsk6TF0nhZS5jp0bsLqvWnt/109Khe7KMtt0b2rRJLcUaioRZzUXEiAJyp
        NpLxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7qPdgmmGLSdErSYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeL/iM3vBXPaK9k+bWRoY97B2MXJwSAiYSHzb
        4NzFyMUhJLCUUeLT+qPMXYycQHEJidsLmxghbGGJP9e62CCKnjNK3NsxixGkmU1AS6Kxkx0k
        LiJwg1Fi6qVfjCAOM0jRs5t3WEG6hQWsJGY+3s8EYrMIqEp0P1oONpUXKD7nzlJ2iA3yEvsP
        nmUGGcosoCmxfpc+RImgxMmZT1hAbGagkuats5knMPLPQqiahaRqFpKqBYzMqxhFUkuLc9Nz
        i430ihNzi0vz0vWS83M3MQJjdduxn1t2MK589VHvECMTB+MhRgkOZiUR3nAWgRQh3pTEyqrU
        ovz4otKc1OJDjKZAV09klhJNzgcmi7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTU
        gtQimD4mDk6pBqYFdr/1JpWtC6/lbCuys/l178+W3CULf51bZjKjsl42ML7PsDHyjd/n61oJ
        YjYqagJPmlZEnS2LcX7tbrFrdw/P+TK7G965lu3yvz/N0bCcxVqhwVGeIVXI4LVN9kSSruQW
        e/XzvjxfL/TenBWa+VTZJFVZWHVm7rGsFp7Urt47krlqSsFil5XnPxcTtGSPPXvJraPD+fY3
        y/p5QurPrJW3uW3UWK5a35l6gPPKe5tVuQf4MjgMem9p3JxsuyBl6dHg5d2TUrnzTetbDey1
        HnzSMngyf83ikFv8EV75n29PTgl/aNIbYiET8lH+SpFd1W62Ly4NHPrSKa1FXl4PxZJc7RNk
        AkNc4xQS5iuxFGckGmoxFxUnAgDOtCM3XgMAAA==
X-CMS-MailID: 20230315123234eucas1p179bf8c0583a71d91bef7e909d7ec6504
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315123234eucas1p179bf8c0583a71d91bef7e909d7ec6504
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123234eucas1p179bf8c0583a71d91bef7e909d7ec6504
References: <CGME20230315123234eucas1p179bf8c0583a71d91bef7e909d7ec6504@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

page_endio() already works on folios by converting a page in to a folio as
the first step. This small series converts page_endio() to take a folio as
the first parameter instead of a page, and use native folio API at the
callee site to simplify the call to the converted folio_endio()
function.

mpage changes were tested with a simple boot testing. zram and orangefs is
only build tested. No functional changes were introduced as a part of
this AFAIK.

Pankaj Raghav (3):
  filemap: convert page_endio to folio_endio
  mpage: use bio_for_each_folio_all in mpage_end_io()
  orangefs: use folio in orangefs_readahead()

 drivers/block/zram/zram_drv.c |  2 +-
 fs/mpage.c                    | 11 ++++-------
 fs/orangefs/inode.c           |  8 ++++----
 include/linux/pagemap.h       |  2 +-
 mm/filemap.c                  |  8 +++-----
 5 files changed, 13 insertions(+), 18 deletions(-)

-- 
2.34.1

