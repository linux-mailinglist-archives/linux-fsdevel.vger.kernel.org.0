Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6416DDAC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDKM3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDKM3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:29:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BCA2D67
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 05:29:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230411122924euoutp01dac9178275a00a611cc595a901ac20b9~U4TG9WoCZ0722007220euoutp01V
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 12:29:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230411122924euoutp01dac9178275a00a611cc595a901ac20b9~U4TG9WoCZ0722007220euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681216164;
        bh=DvzXYCaJ5Q0fdwKafbyMNE7N+U31tXNdAQI+N1ArKhk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cpUfdXKkgacCd1onEM74EdMfVClK6f/z/IzPRQ7bA46a6+xXC7lFAsB8muRTT7LN4
         VY++ziMpWqPF/xqikbJ8Ju5/rza3EzqoZSvAvbxLSM5Jfg1qkNb0vyWI1c/vFaZBb1
         Og2WzIsypypRwUPF1BLDBbPDlYnPt1hpF1ryFw0s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230411122923eucas1p105ae3144e61d4982fbf1fae19d0d609e~U4TFdrKMK3211032110eucas1p19;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E2.0E.09966.2A255346; Tue, 11
        Apr 2023 13:29:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230411122922eucas1p1ed50c7c4c98104f936e3057f975c72ac~U4TFBbyiL3209132091eucas1p1b;
        Tue, 11 Apr 2023 12:29:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230411122922eusmtrp22859a40e54dc94019889ccfa0d47cefe~U4TFApYvn0100601006eusmtrp2k;
        Tue, 11 Apr 2023 12:29:22 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-ce-643552a23b4d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.58.22108.2A255346; Tue, 11
        Apr 2023 13:29:22 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230411122922eusmtip13e56b97d24d41b1204d22176e4bfd42a~U4TEvxVN80543805438eusmtip1P;
        Tue, 11 Apr 2023 12:29:22 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, brauner@kernel.org, martin@omnibond.com,
        willy@infradead.org, hch@lst.de, minchan@kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk,
        akpm@linux-foundation.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        mcgrof@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 0/3] remove page_endio() v3
Date:   Tue, 11 Apr 2023 14:29:17 +0200
Message-Id: <20230411122920.30134-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUwTZxzOe3e9OxgtRzHhDZBNm2giSHFMl9dMNllwO5f9YXTOj22ZF3sB
        swLa2k38iBWNDGUFGbhZKrNEKFJMpQVGQYJ8bNAxVFYnbV1lutqBGyNCXeq6ybhdzfzv+T0f
        7+/5JS+Ny3+VJNO7C/fxmkJOrSBjiY5vH1/PqN+0WrWygUImWwuJrP4KEv02MAtQr6MaQ96r
        TgxdtH6DoVK/AUM9vnR0pcdFIHeXiUR3WuYlyGWbx5Gn8j5AjY9mKDTXcJxC3a31JLr+z5AE
        RcImcp2crdWPEayjKY11j+pYe3MZydpnqyh2+MsIweprfCTb7dWT7F+3f5KwhrZmwM7Zn2ft
        gWlsY9yO2LUqXr37Y16T+erO2PzZa13knon4/T//MEjoQaX0JIihIbMKto+48ZMglpYzTQA+
        qm+UiEMIwGDJlagyB6AtdAN/Gml6OImJggVAl9VEisMUgI6QZSFP0ySTBo+WUQK/iPEBeH7u
        JhAGnJkA8K7vO0p4KpFRwl86q0gBE8xSeOlSBAhYyqyBhsv3KHHdC7C3bxQX+QToOhsgBIwv
        8Mfaa//rBxlHDGwrnybFQC50D9dGw4nwwVBbFKfCeedXmIgPwvueSDR8HMAKp40UakPmFWj4
        Xi1AnFkObV2Zoj0HWiY6JaJDBj3TCWIFGazq+AIXaSn89IRcdCug83EguhRCd4mJEC0svHAm
        V6DlzAcw4LwhqQSLjc/cZXzmLuP/Fc4DvBkk8TptQR6vzSrkP1FquQKtrjBPuauowA4W/uLI
        k6FQJ7A8eKjsBxgN+gGkccUiaTh3tUouVXHFB3hN0YcanZrX9oMUmlAkSdOzXbvkTB63j/+I
        5/fwmqcqRsck6zFj/I7Pzyi29KW/XbFyw8vhkYLDKZT6og+7YO64Y5UazpmP1I2teTPc9V7W
        aA/2eum7A/cON3pk7eObxrJaDnLvXE5x3kzdf2wyjqs53Z/VOWMeL/Kr4qx93XdLq10zhhy8
        vHwqhwyOXi1+zrI8tTXxa69sc/bW4N6X/hw8Ml3stZ47dPRH84GUhNnsgfag2rNZ55x0FG0/
        pSQmM5LLLAr/G8GMqcxeYL+1c/3439qlSVuqqfrT+a6+20uMJXVh84r3S1O921/zly+7RW/Q
        /7F+nWxwLMD6jJ81rFi2+ETk2sCTmrWrTmWa65q1b6W3xofPJhLVGw+lDbMUF/p9yd6mbU4F
        oc3nXkzDNVruX3EivV76AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7qLgkxTDE7ulbKYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmfzu1iK7jPX/Hg0hGWBsYJ
        vF2MnBwSAiYSKz6+YOpi5OIQEljKKNEwexILREJC4vbCJkYIW1jiz7UuNoii54wSr86+Zu9i
        5OBgE9CSaOxkB4mLCDxjlJi9YQsrSAMzSNGvR2AbhAX0JB7vmMQGYrMIqEqsXfsbbCivgKVE
        34ZH7BAL5CX2HzzLDDKTWUBTYv0ufYgSQYmTM5+wQIyUl2jeOpt5AiP/LISqWUiqZiGpWsDI
        vIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwfrcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4f3h
        YpoixJuSWFmVWpQfX1Sak1p8iNEU6OqJzFKiyfnABJJXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cC0qcUqvPbtn773JXs/PLQuv/NGt4jf6X7giQ1Nkb3f2ete
        TtY1P3PQImx5p64Og5/SrPjnmovO6JYrsm1bvq8n4Fz/nhmzQ7u/Fzy7tTnQN+uG/1S3WA3H
        6FUhNbErGsMSJu72vumx9A6z9C6dWY/Zy4s7QhZyc3NdfuYfVt6fEZc4Q1RT+GKj4tPPu3OW
        H1xs1172Me+EsNbkIw7LOxc2aZ5w0FZ2Ehc8kJlj9ed+lfTD7tcSf7unNLyMfHypy/nGifRK
        0+3/Tz198bRw96Xk2Jemymu/bn7wdbvYsZc7JOKnlX0Wq0q43jCLye+9Q5S6iNny60t6H35/
        9qjL5j6z6UXJianJsQ11ySWO518rsRRnJBpqMRcVJwIAvUqrsWgDAAA=
X-CMS-MailID: 20230411122922eucas1p1ed50c7c4c98104f936e3057f975c72ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230411122922eucas1p1ed50c7c4c98104f936e3057f975c72ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230411122922eucas1p1ed50c7c4c98104f936e3057f975c72ac
References: <CGME20230411122922eucas1p1ed50c7c4c98104f936e3057f975c72ac@eucas1p1.samsung.com>
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

As Christoph is doing ZRAM cleanups[4] which will get rid of
page_endio() function usage, I removed the final patch that removes
page_endio()[5]. I will send it separately after rc-1 once the zram
cleanups are merged.

mpage changes were tested with a simple boot testing and running a fio
workload on ext2 filesystem. orangefs was tested by Mike Marshall
(No code changes since he tested).

Changes since v2:
- Dropped the zram patch
- Dropped the patch that removes page_endio() function from filemap
- Also split mpage_submit_bio into read and write counterparts (Christoph)

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
[4] https://lore.kernel.org/linux-block/20230404150536.2142108-1-hch@lst.de/T/#t
[5] https://lore.kernel.org/lkml/20230403132221.94921-6-p.raghav@samsung.com/

Pankaj Raghav (3):
  orangefs: use folios in orangefs_readahead
  mpage: split submit_bio and bio end_io handler for reads and writes
  mpage: use folios in bio end_io handler

 fs/mpage.c          | 66 +++++++++++++++++++++++++++++++--------------
 fs/orangefs/inode.c |  9 ++++---
 2 files changed, 51 insertions(+), 24 deletions(-)

-- 
2.34.1

