Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0702D6E47E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjDQMga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDQMg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:36:27 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40555E5B
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 05:36:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230417123621euoutp01116777d7b55969dc592aee330e586cce~WuQ43eueI3176731767euoutp01q
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230417123621euoutp01116777d7b55969dc592aee330e586cce~WuQ43eueI3176731767euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681734981;
        bh=l9ZwGTLyjTf03DmTuJBHqfcQ6BV5RQlNjbV6Fd8eyBc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lmlsp8kJY85/VFc2JQlGyib4SN1qZX2fn1wXA04jOgrMKnGl2lHxfEzjNfpzyRtzg
         mjfD0LaOzKpu+bL6dn3dcaIey6cfhQ0d5vmCaCWWwMkEvrdsGoZVr4bEsZ/A3RJsED
         pRfggtECb1RNPd/hciC+bm49KuPkqvrPfm3Ckqu4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230417123620eucas1p2152a1bc5048dfaec7fcc0f2983c69765~WuQ4Eqxxa2223522235eucas1p2I;
        Mon, 17 Apr 2023 12:36:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 45.2D.09503.44D3D346; Mon, 17
        Apr 2023 13:36:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230417123620eucas1p229311e1b4c661bd493509135ba748300~WuQ3mmY_Y0718407184eucas1p2U;
        Mon, 17 Apr 2023 12:36:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230417123620eusmtrp11ec5b52bd13e6404df7ccad2c2736296~WuQ3l-V2L2401524015eusmtrp13;
        Mon, 17 Apr 2023 12:36:20 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-3c-643d3d44c5aa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.57.22108.44D3D346; Mon, 17
        Apr 2023 13:36:20 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230417123620eusmtip17198797c1b0e9da6546ebc842fb7ce03~WuQ3aQfr32161021610eusmtip1G;
        Mon, 17 Apr 2023 12:36:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/4] convert create_page_buffers to folio_create_buffers
Date:   Mon, 17 Apr 2023 14:36:14 +0200
Message-Id: <20230417123618.22094-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7outrYpBu1XVC3mrF/DZvH68CdG
        i5sHdjJZ7Fk0CUjsPclicXnXHDaLGxOeMlp8XtrCbnH+73FWi98/5rA5cHlsXqHlsWlVJ5vH
        iRm/WTz6tqxi9Nh8utrj8yY5j01P3jIFsEdx2aSk5mSWpRbp2yVwZUz/uJSpoJWzYveL5WwN
        jLvZuxg5OSQETCT+LpzM0sXIxSEksIJRor1hLxOE84VRYsnUVYwQzmdGiaWNDYwwLZubV0NV
        LWeUeL3sPhuE85JR4vG7y0CDOTjYBLQkGjvBdogIJEos3tMNNolZYAGjxJM/a5hBaoQFPCTm
        3+QBqWERUJVYfGA9E4jNK2ApseXXNxaIZfIS+w+eZYaIC0qcnPkELM4MFG/eOpsZZKaEwAUO
        iUWtX1ghGlwkln9bxARhC0u8Or4F6lEZidOTe6CGVks8vfEbqrmFUaJ/53o2kIMkBKwl+s7k
        gJjMApoS63fpQ5Q7SnR86WaBqOCTuPFWEOIEPolJ26YzQ4R5JTrahCCqlSR2/nwCtVRC4nLT
        HKilHhJNy/6CHSkkECvxbeJJ1gmMCrOQPDYLyWOzEG5YwMi8ilE8tbQ4Nz212DAvtVyvODG3
        uDQvXS85P3cTIzAtnf53/NMOxrmvPuodYmTiYDzEKMHBrCTCe8bVKkWINyWxsiq1KD++qDQn
        tfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDU3BSAt/5llsiHG+yLCbt3L30y8Hi
        tXVt5VuMF5bxKtSIXheNKvx5Nfm6dFHapMQkhjfTdkb4TrHSuyVjKrrFqX2Tz4OFc3/9W7Kx
        ac7snb/fBNwWNn/vuyvhk/wLrSh+lRtfH5wRup2w9UFalYvD7ZMTckIvbIwxdvOcsP2Jn/+r
        8/tPLee49euZ1WLWeR1NU1yiF/wOD7t2cVlc8bxP8k/la/cXrZirduTcqedei34bxt9gmluR
        usAkQ3WafffLsx9fbM88MSddpy53etcLTtYThb/nytwo2Bii5DiNjzV2sWagT4JC/eYjXr++
        6mbX/Qo7zSclnTQ/ac8/S0bD1rzrreuiN6//bT3NOWXvvUwlluKMREMt5qLiRAA1CK2JugMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7outrYpBisfcVrMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy5j+cSlTQStnxe4Xy9kaGHezdzFyckgImEhsbl7NBGIL
        CSxllNjYaQ4Rl5C4vbCJEcIWlvhzrYuti5ELqOY5o8StmfuAGjg42AS0JBo7weaICKRKrPhz
        B6yGWWAZo8Th73eZQWqEBTwk5t/kAalhEVCVWHxgPdguXgFLiS2/vrFAzJeX2H/wLFg5s4Cm
        xPpd+hAlghInZz4BK2EGKmneOpt5AiP/LISqWUiqZiGpWsDIvIpRJLW0ODc9t9hQrzgxt7g0
        L10vOT93EyMwdrYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4T3japUixJuSWFmVWpQfX1Sak1p8
        iNEU6OqJzFKiyfnA6M0riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCU
        amA6xZo+bVvA7PDQKP/wzXMNUm32JpXob5CeIXNmH/NjR4vucyE7IixdLzNbTlFIn8DUrXra
        VshT63NYpJmq0vMk14ZvTqsd1+Sm6/m7vjmz9b3rDyb+vIzM1vm+Lx0vSVjvCtjP3PPOIGiq
        3H93l7A3qe252v9VvsauyNv+UG/1jl93eC9rzA9f+3/RfTaLRW4flu5Rfz9n36cwp67ZS541
        LRXj+Nn9bHWGelW5Yti74zwcLi8zMj98yT3bVllqYXGIUd9tWdE5xSmHmlSf8D4sm3U/apIC
        q6rR0Tozm6el1kz1ArenBT1s9UwIzZjaE3ODTeTWj59iWya/Y+zIPdwv/+XdqvjipfsW6P9n
        FFdiKc5INNRiLipOBAD5qwgAJgMAAA==
X-CMS-MailID: 20230417123620eucas1p229311e1b4c661bd493509135ba748300
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230417123620eucas1p229311e1b4c661bd493509135ba748300
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230417123620eucas1p229311e1b4c661bd493509135ba748300
References: <CGME20230417123620eucas1p229311e1b4c661bd493509135ba748300@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the first kernel panic we hit when we try to increase the
block size > 4k is inside create_page_buffers()[1]. Even though buffer.c
function do not support large folios (folios > PAGE_SIZE) at the moment,
these changes are required when we want to remove that constraint.

Willy had already mentioned that he wanted to convert create_page_buffers to
folio_create_buffers but didn't get to it yet, so I decided to take a
shot.

No functional changes introduced.

Changes since RFC[2]:
- Renaming the helpers with folio_*
- Calling folio_* helper version inside the *page* helper.

[1] https://lore.kernel.org/all/ZBnGc4WbBOlnRUgd@casper.infradead.org/
[2]https://lore.kernel.org/lkml/20230414110821.21548-1-p.raghav@samsung.com/

Pankaj Raghav (4):
  fs/buffer: add folio_set_bh helper
  buffer: add folio_alloc_buffers() helper
  fs/buffer: add folio_create_empty_buffers helper
  fs/buffer: convert create_page_buffers to folio_create_buffers

 fs/buffer.c                 | 89 +++++++++++++++++++++++++------------
 include/linux/buffer_head.h |  6 +++
 2 files changed, 66 insertions(+), 29 deletions(-)

-- 
2.34.1

