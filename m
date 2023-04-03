Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8E6D4595
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjDCNWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjDCNWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:22:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E0CA0B
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:22:28 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230403132225euoutp01d0204acc0ef873d4faf21747af9fa16a~Sb3HMjbhJ1546015460euoutp01-
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 13:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230403132225euoutp01d0204acc0ef873d4faf21747af9fa16a~Sb3HMjbhJ1546015460euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680528145;
        bh=ObjzntybczC70XqbBMD54+/zmilnxb/jIpNihW2+Pg8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PHrFnw8L9nqSJlcUoH3v9Ir9e8GvPm21vpYA5JWvG99O4thmulUb9ock0LvcRWE0i
         hN2HNJI69WlEXJGypLBsc3X63dTXRrW/VzWphcii6Ne8lYmGaDZBrBfmJj5WC6PddF
         X/m82ghIxAUSXNrGFR9qreUfqCU5L5ckSUdxCOl8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230403132223eucas1p29eb1d990b50c925c97adeffdd348e752~Sb3FrThuy1872218722eucas1p2l;
        Mon,  3 Apr 2023 13:22:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.F4.09503.F03DA246; Mon,  3
        Apr 2023 14:22:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230403132223eucas1p28adb1d36d39add989d46e9f175c07986~Sb3FEGt8e2688526885eucas1p2R;
        Mon,  3 Apr 2023 13:22:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230403132223eusmtrp2fe9c8c3ae0a35135ff22db5353c2d44c~Sb3FDYXo80200802008eusmtrp2H;
        Mon,  3 Apr 2023 13:22:23 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-ad-642ad30f88e1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EA.16.08862.F03DA246; Mon,  3
        Apr 2023 14:22:23 +0100 (BST)
Received: from localhost (unknown [106.210.248.30]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230403132222eusmtip1ceffd813a58e2638c75300bc28fb0544~Sb3E097ue2319123191eusmtip1D;
        Mon,  3 Apr 2023 13:22:22 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de
Cc:     devel@lists.orangefs.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 0/5] remove page_endio()
Date:   Mon,  3 Apr 2023 15:22:16 +0200
Message-Id: <20230403132221.94921-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djP87r8l7VSDDqe61jMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBYrVx9lsmi/28dksfeWtsWevSdZLC7vmsNmcW/Nf1aLk+v/M1vc
        mPCU0WLZ1/fsFp+XtrBb7N64iM3i/N/jrBa/f8xhcxDymN1wkcVj8wotj8tnSz02repk89j0
        aRK7x4kZv1k8GqbeYvPYfbOBzePX7TusHn1bVjF6fN4k57HpyVumAJ4oLpuU1JzMstQifbsE
        row3V6cxFpzmrZj9/DB7A+M3ri5GTg4JAROJx9MPs4HYQgIrGCWef6zoYuQCsr8wSiyduIgd
        wvnMKLHh4hYmmI4Dn98wQSSWM0pM7tvKCuG8YJR4P+c5YxcjBwebgJZEYydYt4jALUaJNz2z
        wTqYBe4zSszbvZcJpEhYQFvixH1hkKksAqoSG6+tYwaxeQUsJZZ+Pc4IsU1eYv/Bs1BxQYmT
        M5+wgNjMQPHmrbOZQWZKCGznlGi5tRiqwUXi+ol9UKcKS7w6voUdwpaR+L9zPlS8WuLpjd9Q
        zS2MEv0717OBHCQhYC3RdyYHxGQW0JRYv0sfotxRYsGew4wQFXwSN94KQpzAJzFp23RmiDCv
        REebEES1ksTOn0+glkpIXG6awwJhe0hs/LueHRLSsRKblzazTWBUmIXksVlIHpuFcMMCRuZV
        jOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgWnx9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRFe
        1S6tFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1MWo6M
        a9+wOz69sEOTjTnqwIlTfH8PVzIZLjXZotfiamzf6eQ0mfuZOecmr+mfXhy5Wjx964SHbCHP
        o1Vf9Jc5XWE+o7h0iffqDy7LK9qdb05u/acgoHFPgd/K6YWemMpl7Yb7P+btPnlhKuutQ6+d
        exalKcXVMPO/T9CX28F1qqy96swvzrjKpF013z4aSO91rvcxWZnwXH5b3ckVKrWlrveOLP3M
        JfXjeTMPu5KtKp+y/J/NAnz+B4XL22+X7VFySFu5PjNylW2c0bcE3Utlq5Yd1Z7huMNKpnCp
        NP9DffZZig3sAsvynONDzv2XtHpwSfHbhwkdHp+FOWY+3lXy5qPLjcfTFIsuZ/36mTZLiaU4
        I9FQi7moOBEAIegt1/oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7r8l7VSDM7d4bCYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlvrk5jLDjNWzH7+WH2BsZv
        XF2MnBwSAiYSBz6/Yepi5OIQEljKKHFkwhI2iISExO2FTYwQtrDEn2tdbBBFzxglJm/4x9LF
        yMHBJqAl0djJDhIXAYkvu3CcBcRhFnjOKLFmym9mkCJhAW2JE/eFQQaxCKhKbLy2jhnE5hWw
        lFj69TjUAnmJ/QfPgpUzC2hKrN+lD1EiKHFy5hMWEJsZqKR562zmCYz8sxCqZiGpmoWkagEj
        8ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA+N127OfmHYzzXn3UO8TIxMF4iFGCg1lJhFe1
        SytFiDclsbIqtSg/vqg0J7X4EKMp0NUTmaVEk/OBCSSvJN7QzMDU0MTM0sDU0sxYSZzXs6Aj
        UUggPbEkNTs1tSC1CKaPiYNTqoFJ6cJ+8/4Duu9cVigfPf21oKLRJHTvhrUH05jYs363VP2Y
        d/rN7mvGWqfEuyOzDbK9p20+t/7+6j1eJX6d7+XUtone7o1Rkwz7UF2+a+VmnZCMFhHW+7Ey
        gdWP9zUcu5mfvO/hzqUzrh8Un3Vovcu1PUvK8uxD+edEZDy+dbD2+dNtIkunLuZV4gzbeS+4
        9Pmejwsvyz6Xus6rNKF/on5s/cWUzYe32qRa715QcjKb985jgfe1D5lLnKxZGE60b01uKurV
        2T1v1+3Gwq87P+tPbl7UO/lZ7J3jzSEduw98vfBO8G3ph5MPz7ImWjcxJs+7fetv//3GCWy3
        t05On77LgSnTO1lmechtnuad2/3O71FiKc5INNRiLipOBAC26QonaAMAAA==
X-CMS-MailID: 20230403132223eucas1p28adb1d36d39add989d46e9f175c07986
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230403132223eucas1p28adb1d36d39add989d46e9f175c07986
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403132223eucas1p28adb1d36d39add989d46e9f175c07986
References: <CGME20230403132223eucas1p28adb1d36d39add989d46e9f175c07986@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It was decided to remove the page_endio() as per the previous RFC
discussion[1] of this series and move that functionality into the caller
itself. One of the side benefit of doing that is the callers have been
modified to directly work on folios as page_endio() already worked on
folios.

mpage changes were tested with a simple boot testing. orangefs was
tested by Mike Marshall (No code changes since he tested).
A basic testing was performed for the zram changes with fio and writeback to
a backing device.

Changes since v1:
- Always chain the IO to the parent as it can never be NULL (Minchan)
- Added reviewed and tested by tags

Changes since RFC 2[2]:
- Call bio_put in zram bio end io handler (Still not Acked by hch[3])
- Call folio_set_error in mpage read endio error path (Willy)
- Directly call folio->mapping in mpage write endio error path (Willy)

[1] https://lore.kernel.org/linux-mm/ZBHcl8Pz2ULb4RGD@infradead.org/
[2] https://lore.kernel.org/linux-mm/20230322135013.197076-1-p.raghav@samsung.com/
[3] https://lore.kernel.org/linux-mm/8adb0770-6124-e11f-2551-6582db27ed32@samsung.com/

Pankaj Raghav (5):
  zram: always chain bio to the parent in read_from_bdev_async
  orangefs: use folios in orangefs_readahead
  mpage: split bi_end_io callback for reads and writes
  mpage: use folios in bio end_io handler
  filemap: remove page_endio()

 drivers/block/zram/zram_drv.c | 16 +++------------
 fs/mpage.c                    | 38 +++++++++++++++++++++++++++--------
 fs/orangefs/inode.c           |  9 +++++----
 include/linux/pagemap.h       |  2 --
 mm/filemap.c                  | 30 ---------------------------
 5 files changed, 38 insertions(+), 57 deletions(-)

-- 
2.34.1

