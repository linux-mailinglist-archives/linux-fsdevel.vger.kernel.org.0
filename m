Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846DA6CBD9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 13:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjC1L1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 07:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjC1L13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:27:29 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F013910FA
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 04:27:22 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230328112720euoutp029860ee949914bc7315ea3352674b14a6~Qka6llwhQ3159331593euoutp02v
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230328112720euoutp029860ee949914bc7315ea3352674b14a6~Qka6llwhQ3159331593euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680002840;
        bh=mVt0esU6AYdO/3BpdSH3EjSwJzmaOVAOyp6U72Ql82c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hFeo+f30BHxHa2PaDsS37TiPMjfRONKR37n29S84sv8Qhl2gCGbZu1QCXaTM33WyO
         aWJdSYPjU6uyMNhrBBktr/rmwi43Kop00WJZnkFuNGxMHNez/qj8rEr2zW3bwo9mNg
         k519wt6+idwTnr97Wp2CwGDmdc/9BaPu/JqAN+uA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230328112718eucas1p1d6cdacc223a4a9da529cedb8ebfb4db9~Qka5GN6901588715887eucas1p1V;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 39.58.10014.61FC2246; Tue, 28
        Mar 2023 12:27:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230328112717eucas1p2eb9395b7e3334c08aa28740b0af46fe9~Qka4aThPJ3056630566eucas1p2Y;
        Tue, 28 Mar 2023 11:27:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230328112717eusmtrp1320acab2ed759067daec82e4f672c281~Qka4Zol2C0876308763eusmtrp1R;
        Tue, 28 Mar 2023 11:27:17 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-f8-6422cf16ffb3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DC.19.08862.51FC2246; Tue, 28
        Mar 2023 12:27:17 +0100 (BST)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230328112717eusmtip275994a46bcd3f06e91d3b024b2596c74~Qka4JjFw80132101321eusmtip26;
        Tue, 28 Mar 2023 11:27:17 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/5] remove page_endio()
Date:   Tue, 28 Mar 2023 13:27:11 +0200
Message-Id: <20230328112716.50120-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87pi55VSDC5/VbKYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DK+DBtK2vBAZ6K
        f/N1GxjbuboYOTkkBEwk7hw/wdLFyMUhJLCCUWLxhfNMEM4XRon2j1OgnM9AzncQhwOsZcnV
        OpBuIYHljBJHWxIgal4ySnw8cZQVpIZNQEuisZMdJC4icAZo6vJGNhCHWeA+o8S3lyArODmE
        BTQkTr+ZzQ5iswioSuzafg0szitgKbFuwRRGiPvkJfYfPMsMEReUODnzCQuIzQwUb946mxlk
        qITAYk6JW/tXMUM0uEg8On6YHcIWlnh1fAuULSNxenIPC4RdLfH0xm+o5hZGif6d69kgXrOW
        6DuTA2IyC2hKrN+lD1HuKDHt6AtmiAo+iRtvBSFO4JOYtG06VJhXoqNNCKJaSWLnzydQSyUk
        LjfNgVrqIdFz+jgLJNxiJTb8O8M8gVFhFpLHZiF5bBbCDQsYmVcxiqeWFuempxYb56WW6xUn
        5haX5qXrJefnbmIEJsDT/45/3cG44tVHvUOMTByMhxglOJiVRHg3eyumCPGmJFZWpRblxxeV
        5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamCKVPqUt/HlBy2raXO2vpObMume
        0doM4yZ9DsVWXfb3Po03Ts3p1mL5LzWJQXPWoUnafpfKuu/MzlypcfvNCa4t5gJxe688NOMT
        dlh3+MWbkMOPvCRerAsq7Fg7Pd5/inua1zJfk7jE1G1T2GyU+Kco3HPetiF60crHjA1nJgjK
        m660O7Ll2XnLhZLrqi/puXEoxKtJu1kp/rSXnc5St6V2yb53gtwdcpNCX+V/CU2t7/Vv1kr+
        ueupt63u2Ud6awWtBMM22Irsc+08cTvSoHyydOLGpNW3POyEnQ683Xvxvd+uE806NY/WW7eE
        Jv7nd+Mwvs55LfYVO9eHr+HHm6ZOkl8SsNoxUKbp8ZuKtjQlluKMREMt5qLiRADhCIVM7wMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7qi55VSDC4tNbaYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL+DBtK2vBAZ6Kf/N1GxjbuboYOTgkBEwkllyt
        62Lk4hASWMoo8WfGL+YuRk6guITE7YVNjBC2sMSfa11sEEXPGSW2vu9lB2lmE9CSaOxkB4mL
        CNxglFj79BcriMMMUnR332tWkG5hAQ2J029ms4PYLAKqEru2X2MCsXkFLCXWLZgCtUFeYv/B
        s8wgQ5kFNCXW79KHKBGUODnzCQuIzQxU0rx1NvMERv5ZCFWzkFTNQlK1gJF5FaNIamlxbnpu
        saFecWJucWleul5yfu4mRmCkbjv2c/MOxnmvPuodYmTiYDzEKMHBrCTCu9lbMUWINyWxsiq1
        KD++qDQntfgQoynQ1ROZpUST84GpIq8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1
        ILUIpo+Jg1Oqganv/FXmP8u5rQ3E5mfXWDSclEu90q0WdKXxwM8cnRPacWJb76zySF3f+63J
        42zZJPfygIQ7lW/SEwX/ixtVLl717qve1XP/TtxyNwgw1nIOjljhJi8Z86+RO+uLC+fv7cFs
        7/9t/brCN21Lg5L9vvlP8qcGK4hHf69VeRLgxlSWnMilOP+2iWPbt+lmZlPOzBNr/bxQmEPg
        XGEtd99JgdyEb9++/5Df8eNbWfx68cNPZ1fXVizINSwPs3d0eZyefdxPr+Gv54ubf/xlbVUj
        H8XKKHy89OBtkLX1jPIus0/2cVvjl7xuePLGW9N5q5frPs65ZrHPv23yu9H/YF90QNwjX6Zj
        z102XYv/ncMQp8RSnJFoqMVcVJwIAEsU01ldAwAA
X-CMS-MailID: 20230328112717eucas1p2eb9395b7e3334c08aa28740b0af46fe9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230328112717eucas1p2eb9395b7e3334c08aa28740b0af46fe9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112717eucas1p2eb9395b7e3334c08aa28740b0af46fe9
References: <CGME20230328112717eucas1p2eb9395b7e3334c08aa28740b0af46fe9@eucas1p2.samsung.com>
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
tested by Mike Marshall (No code changes since he tested). Zram was
only build tested. No functional changes were introduced as a part of
this AFAIK.

Changes since RFC 2[2]:
- Call bio_put in zram bio end io handler (Still not Acked by hch[3])
- Call folio_set_error in mpage read endio error path (Willy)
- Directly call folio->mapping in mpage write endio error path (Willy)

[1] https://lore.kernel.org/linux-mm/ZBHcl8Pz2ULb4RGD@infradead.org/
[2] https://lore.kernel.org/linux-mm/20230322135013.197076-1-p.raghav@samsung.com/
[3] https://lore.kernel.org/linux-mm/8adb0770-6124-e11f-2551-6582db27ed32@samsung.com/

Pankaj Raghav (5):
  zram: remove the call to page_endio in the bio end_io handler
  orangefs: use folios in orangefs_readahead
  mpage: split bi_end_io callback for reads and writes
  mpage: use folios in bio end_io handler
  filemap: remove page_endio()

 drivers/block/zram/zram_drv.c |  8 ++------
 fs/mpage.c                    | 38 +++++++++++++++++++++++++++--------
 fs/orangefs/inode.c           |  9 +++++----
 include/linux/pagemap.h       |  2 --
 mm/filemap.c                  | 30 ---------------------------
 5 files changed, 37 insertions(+), 50 deletions(-)

-- 
2.34.1

