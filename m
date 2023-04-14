Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361ED6E21BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDNLIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDNLIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:08:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60471E6B
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 04:08:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230414110826euoutp01fa3d1ea00950eae48d045594203ab216~VyIRczt3Q1043810438euoutp01h
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:08:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230414110826euoutp01fa3d1ea00950eae48d045594203ab216~VyIRczt3Q1043810438euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681470506;
        bh=ruVO44Xm7S0hzAbgY2i3Oo5sjo+xMT5oybMi6DD7RXc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UgGc/0p0LwyuCv7oKYEUmekDv2L2FYUDGUgj7xRLi/XBJhnOmwDN57RxXNmkCYhA9
         WL+uYD/eTPh/TzoOh+QlC1JQGR46/P/Ozkg8sNTLV2PmesmznZhmnskRtYnTNeRg7v
         3dkL802nrOY1/oqGKxuSsu7hflCnKEjzWST52eek=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230414110825eucas1p21fdd751ca71c03c3451ce9f115e12d2e~VyIQmO-Sk0896208962eucas1p2U;
        Fri, 14 Apr 2023 11:08:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.25.09966.92439346; Fri, 14
        Apr 2023 12:08:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d~VyIQMS3Rj2214822148eucas1p1u;
        Fri, 14 Apr 2023 11:08:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230414110825eusmtrp1c2b4d631c12ee590a3efb275fb589b29~VyIQLtiec3053530535eusmtrp1Y;
        Fri, 14 Apr 2023 11:08:25 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-e3-643934292f92
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.78.22108.92439346; Fri, 14
        Apr 2023 12:08:25 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230414110825eusmtip11a66d34285144c8be31b895d63d417b6~VyIP93LY22918529185eusmtip1y;
        Fri, 14 Apr 2023 11:08:25 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     brauner@kernel.org, willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com, hare@suse.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Date:   Fri, 14 Apr 2023 13:08:17 +0200
Message-Id: <20230414110821.21548-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87qaJpYpBvfaNS3mrF/DZvH68CdG
        i5sHdjJZ7Fk0CUjsPclicXnXHDaLGxOeMlp8XtrCbnH+73FWi98/5rA5cHlsXqHlsWlVJ5vH
        iRm/WTz6tqxi9Nh8utrj8yY5j01P3jIFsEdx2aSk5mSWpRbp2yVwZRw+eoG94BVXxZFOrQbG
        6xxdjJwcEgImEo/2zGLvYuTiEBJYwSjxYUI/O0hCSOALo8SBFcEQic+MEj/v/GGB6fh64R0r
        RGI5o8TM91egnJeMEn0vf7J1MXJwsAloSTR2soOYIgKJEjffK4CUMAssYJS4dfs92AZhATeJ
        j/tbmEBsFgFViaV/XzGC2LwClhI3+yYyQyyTl9h/8CwzRFxQ4uTMJ2BHMAPFm7fOZgYZKiFw
        hUPi1OvFbBANLhJ7tm+AulRY4tXxLewQtozE6ck9UPFqiac3fkM1tzBK9O9cD3a0hIC1RN+Z
        HBCTWUBTYv0ufYhyR4m+y/sYISr4JG68FYQ4gU9i0rbpzBBhXomONiGIaiWJnT+fQC2VkLjc
        NAdqqYdEy8QfzJCwjZW43/6IaQKjwiwkj81C8tgshBsWMDKvYhRPLS3OTU8tNspLLdcrTswt
        Ls1L10vOz93ECExJp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nw/nAxTRHiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXAtPWggsc/kdap/7ds1SkJ85BbKcV4
        7MAv+73n9shm5MRLGJkYdj5g6nk0LdzzeYSFk981oQLj1D1+Mu0da+w/T15ukf3gTuPUkwwL
        A9a0vYm3FS2a9dllT+TK1Ey77Ftvbrc8aH14/PKGs9xf3X5s2LXPS7OPt6nYy7SEaUGx3MTZ
        zBI+7Z9vVX076zHbgM2l/F9QrXTc6+5AmdOpxperd7GrnROxcZb/a6564YFQ30snxpdPzXjf
        CM94sUQ62urPla1/87ldW3dWbVk/v+HL7gWNbefPnRT/Oy3Rbo5bnFvz3iuMH+wMGvs6uLWa
        Nij5hqibuSsu8zNdcuzds/qdF7j7kq9a3Ip8OzVFYaWtEktxRqKhFnNRcSIADFWv5bgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7qaJpYpBpf3CFrMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQyzh89AJ7wSuuiiOdWg2M1zm6GDk5JARMJL5eeMfaxcjF
        ISSwlFHi9LHzjBAJCYnbC5ugbGGJP9e62CCKnjNKHJ60nLmLkYODTUBLorGTHaRGRCBV4vSJ
        j2A1zALLGCXWzH3BBpIQFnCT+Li/hQnEZhFQlVj69xXYUF4BS4mbfROZIRbIS+w/eBZsJrOA
        psT6XfoQJYISJ2c+YQGxmYFKmrfOZp7AyD8LoWoWkqpZSKoWMDKvYhRJLS3OTc8tNtQrTswt
        Ls1L10vOz93ECIyebcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4f7iYpgjxpiRWVqUW5ccXleak
        Fh9iNAW6eiKzlGhyPjB+80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4
        OKUamNLXpFxN1Yvfa/mzPy4pbD6ne/GVX9p/+Q69b/5vxHjO788/381+9551hibYnyyv/rRu
        btkq7pONjc++S/S8eptyeeI9l+9OzfYd6btd/k6WMqv693raVI3yf6WLQjaUqG6SX7JN7WB/
        4qTFPbOM/t2/vOgee3uR0M3H0nKS34TjvBLtS7f3b3t1Rql24hkZf4ctoe8ZLG9uUE8SnHln
        7gexKS8Fv5am714aWfPuydLgrjlCa0/9snfrmsNTJnZ39et72bc8pntcnFL+2qSgvk28dMb0
        iWv3RMwKKwub6nJqu5CTzroFUQ7LkoJWfvzyw7jYborXjCKX0OhPtjxccxJPdk09tyfjhvFK
        pqnz2NcpsRRnJBpqMRcVJwIA3tSlDScDAAA=
X-CMS-MailID: 20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
create_folio_buffers but didn't get to it yet, so I decided to take a
shot.

No functional changes introduced.

OI:
- I don't like the fact that I had to introduce
  folio_create_empty_buffers() as create_empty_buffers() is used in
  many parts of the kernel. Should I do a big bang change as a part of
  this series where we convert create_empty_buffers to take a folio and
  change the callers to pass a folio instead of a page?

- I split the series into 4 commits for clarity. I could squash them
  into one patch if needed.

[1] https://lore.kernel.org/all/ZBnGc4WbBOlnRUgd@casper.infradead.org/

Pankaj Raghav (4):
  fs/buffer: add set_bh_folio helper
  buffer: add alloc_folio_buffers() helper
  fs/buffer: add folio_create_empty_buffers helper
  fs/buffer: convert create_page_buffers to create_folio_buffers

 fs/buffer.c                 | 131 +++++++++++++++++++++++++++++++++---
 include/linux/buffer_head.h |   4 ++
 2 files changed, 125 insertions(+), 10 deletions(-)

-- 
2.34.1

