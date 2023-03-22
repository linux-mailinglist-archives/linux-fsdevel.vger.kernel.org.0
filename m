Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB26C4C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCVNu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCVNup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:50:45 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136C637E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 06:50:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230322135017euoutp01863e52178e2ab626167c6ec381b51701~OwgBQcxrn2152621526euoutp01G
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230322135017euoutp01863e52178e2ab626167c6ec381b51701~OwgBQcxrn2152621526euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679493017;
        bh=iG+1DdU06kh10oa77gtH+/W7kfUUhaVZeJUTc2eavXY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kMKBBxTeGERCD3E6kZ7HmeqRZkpaTxK9KAvDJn+sgG9ICYRGiUb5CONyogNhXhyeq
         b6q6fUlKZGWrkii3jaHPDNJH+l9C24+ZSFeCGuJkcKVFUIaskIYstr1y3oBk/Oh0SY
         0sx81b+xL+g+CcIGJJyHk1wSQgdx/6/hCgRxAiV4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230322135015eucas1p28f23e7d968ab3d49dca4bf1f662abb97~Owf-f4rhS0617106171eucas1p20;
        Wed, 22 Mar 2023 13:50:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.28.10014.7970B146; Wed, 22
        Mar 2023 13:50:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c~Owf-BrYp-2739627396eucas1p2W;
        Wed, 22 Mar 2023 13:50:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230322135015eusmtrp2af36a9248db51625e24ac5b646d9e85d~Owf-AgzBl0670606706eusmtrp2R;
        Wed, 22 Mar 2023 13:50:15 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-0b-641b0797f2a7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.52.08862.7970B146; Wed, 22
        Mar 2023 13:50:15 +0000 (GMT)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230322135015eusmtip2f1f96c9fda556d617f54da47c1cb62ae~Owf_y2n0A2592425924eusmtip24;
        Wed, 22 Mar 2023 13:50:14 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     mcgrof@kernel.org, devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 0/5] remove page_endio()
Date:   Wed, 22 Mar 2023 14:50:08 +0100
Message-Id: <20230322135013.197076-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87rT2aVTDE7d1LaYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DK6P2uXjCRp2Lt
        v8+MDYznObsYOTkkBEwkfk87w9TFyMUhJLCCUeLcualsEM4XRokrTXdYIZzPjBKvdj1ggWk5
        +vg5VGI5o8TGA79ZIJyXjBLz7zwEynBwsAloSTR2soPERQTOMEpMaZrBCNLNLHCfUeL0XrBJ
        wgKaEu9OXmIDsVkEVCVmHjkPFucVsJK4eW4PM8Q2eYn9B88yQ8QFJU7OfMICMUdeonnrbGaQ
        BRIC8zkl/r7/wwrR4CJxaulERghbWOLV8S3sELaMxP+d85kg7GqJpzd+QzW3MEr071zPBnK1
        hIC1RN+ZHBCTGei49bv0IcodJfZsPs8KUcEnceOtIMQJfBKTtk1nhgjzSnS0CUFUK0ns/PkE
        aqmExOWmOdBw85C41fgeLC4kECvx68VL9gmMCrOQPDYLyWOzEG5YwMi8ilE8tbQ4Nz212Dgv
        tVyvODG3uDQvXS85P3cTIzAFnv53/OsOxhWvPuodYmTiYDzEKMHBrCTC68YskSLEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qBKSfwk5+RvOP3c/uFLT87
        Ls6dNresVHTGKbs53/x7qncm9IWcvSBYFPbwp69Goy/366vy98stzrBOKvfTCZFU21rssG6O
        XPKcVOY1c2dneR39GnPMIH13VcE7tV2rHCQ/PC8QvhK6/Wj51OTNez6ukl6gcnzD8uXrZLw2
        y21oOy/X6bTyYUmipUFt1M+l0et6E62M2ndvV72p1ymbpFf4kKOSw8j+VezDpDjh7y/XXPGV
        Om326qmPz9wbjKXpXqvOz88J2HToUM+Lv0Via4N6NLkifSftXbXeat/PL1cmc80Mev9Cv/tl
        y8Uo16OLH6WYBFz2XpP2es8bfv6/lmbn70zzu3T431kJ76SGo24WkUosxRmJhlrMRcWJAOCD
        AXjwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7rT2aVTDNa85LSYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL6P2uXjCRp2Ltv8+MDYznObsYOTkkBEwkjj5+
        ztrFyMUhJLCUUWLphVVsEAkJidsLmxghbGGJP9e62CCKnjNK/Po4ESjBwcEmoCXR2MkOUiMi
        cINRon2VHkgNM0jN5aezmUESwgKaEu9OXgIbyiKgKjHzyHkWEJtXwEri5rk9zBAL5CX2HzzL
        DDKTGah+/S59iBJBiZMzn4CVMwOVNG+dzTyBkX8WQtUsJFWzkFQtYGRexSiSWlqcm55bbKhX
        nJhbXJqXrpecn7uJERip24793LyDcd6rj3qHGJk4GA8xSnAwK4nwujFLpAjxpiRWVqUW5ccX
        leakFh9iNAW6eiKzlGhyPjBV5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB
        9DFxcEo1ME2XPvz6hWHQtanGkp/PzbyhUtDmdSLeW+Dh1eOvUtkmOrKlTo5Yka6/Vbrxt8c0
        hqtFskpsZ1c+Nd/sd8pfun9SX37+XWfumLx3+oX3o4TnO7+94HhH4dpdoxdz+UtCwllnz77q
        ENrLOUVfouQOh8aOV10teW5J9cs8F/oZHXPz/J9uNpHnTWWggca9TzmlNs8nzXsZ/2rylzk/
        H6j0t/fVTrm5YO2/+MVHp91bVVG9821w9PbaF4Gn1PqDHpWpyoqmfBcU6q83bzsScfdc7anO
        T6bKGfo8326l18lPdl096a1GkOA0Y4cT3J9t3Nf+W5lepLD4ureV5KrQvyxFzNMcZ22TKLln
        s8lz2xOhEiWW4oxEQy3mouJEAITDTapdAwAA
X-CMS-MailID: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

mpage changes were tested with a simple boot testing. zram and orangefs is
only build tested. No functional changes were introduced as a part of
this AFAIK.

Open questions:
- Willy pointed out that the calls to folio_set_error() and
  folio_clear_uptodate() are not needed anymore in the read path when an
  error happens[2]. I still don't understand 100% why they aren't needed
  anymore as I see those functions are still called in iomap. It will be
  good to put that rationale as a part of the commit message.

[1] https://lore.kernel.org/linux-mm/ZBHcl8Pz2ULb4RGD@infradead.org/
[2] https://lore.kernel.org/linux-mm/ZBSH6Uq6IIXON%2Frh@casper.infradead.org/

Pankaj Raghav (5):
  zram: remove zram_page_end_io function
  orangefs: use folios in orangefs_readahead
  mpage: split bi_end_io callback for reads and writes
  mpage: use folios in bio end_io handler
  filemap: remove page_endio()

 drivers/block/zram/zram_drv.c | 13 +----------
 fs/mpage.c                    | 44 ++++++++++++++++++++++++++++-------
 fs/orangefs/inode.c           |  9 +++----
 include/linux/pagemap.h       |  2 --
 mm/filemap.c                  | 30 ------------------------
 5 files changed, 42 insertions(+), 56 deletions(-)

-- 
2.34.1

