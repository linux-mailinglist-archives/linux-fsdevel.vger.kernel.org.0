Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4A7A786A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjITKA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjITKAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:00:21 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32EFCF
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 03:00:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230920100013euoutp02fa54f5b5dff9237922b42f8be095e9dd~GkxGDpvkp1967619676euoutp02m
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:00:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230920100013euoutp02fa54f5b5dff9237922b42f8be095e9dd~GkxGDpvkp1967619676euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695204013;
        bh=JtBYsHN8h541EBRzlr1y0mzkDzP9gFTfHIXNRWvnYrs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=a0rXS9PnsBLdcAai9TRqkGdfrEGllNHbHgiYLk7bd3A6pTWFBb8gx+laef0ZRAuGV
         9dbFEh1ZcT2rUKoh2c8kXxM/FJYs5OBNT1v9UmYQtDDfxaV9tmE7J0lVkL3Y67rf+L
         idzp0179QVhAN7/4t5jzIBZqyesURL/TSgQ1CM44=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230920100012eucas1p22ae8579a8303bc7100e92ddc6f39f8de~GkxF012Cx2310123101eucas1p2m;
        Wed, 20 Sep 2023 10:00:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C3.F8.37758.CA2CA056; Wed, 20
        Sep 2023 11:00:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230920100012eucas1p1f44530cfdd1ff8ed668bfe0c088d31ce~GkxFeABk71972619726eucas1p1Z;
        Wed, 20 Sep 2023 10:00:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920100012eusmtrp28e809b95a24cde10b6f8dbde3fc8ff5b~GkxFdVslq2580425804eusmtrp2A;
        Wed, 20 Sep 2023 10:00:12 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-a7-650ac2ac9406
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.16.14344.CA2CA056; Wed, 20
        Sep 2023 11:00:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920100012eusmtip1237da79744bb0d19877f7844c975d504~GkxFTCBuO2867928679eusmtip1F;
        Wed, 20 Sep 2023 10:00:12 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 20 Sep 2023 11:00:11 +0100
Date:   Wed, 20 Sep 2023 12:00:11 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <gfs2@lists.linux.dev>,
        <linux-nilfs@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>, <ntfs3@lists.linux.dev>,
        <ocfs2-devel@lists.linux.dev>, <reiserfs-devel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCH 03/26] ext4: Convert to folio_create_empty_buffers
Message-ID: <20230920100011.zpzagd35gjpn5gzu@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230919045135.3635437-4-willy@infradead.org>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87prDnGlGnxpMrOYs34Nm8Xu6f9Y
        LWbOu8NmsWfvSRaLP9NNLNo75jBarHy8lcni0L2rrBazt65gtvj9Yw6bA5fH5hVaHidm/Gbx
        eLF5JqPH7gWfmTw+b5ILYI3isklJzcksSy3St0vgyljeN5e14BtLxfej7WwNjBNYuhg5OSQE
        TCT2r9nJ2MXIxSEksIJRovfjN1YI5wujxOa3K9ghnM9AmXev2GBaJrw+zgKRWM4o8XPGLWa4
        qtmf7jNBOFsYJeYvOsgM0sIioCrxZ+NBoC0cHGwCWhKNnewgYREBY4mJy/ezgdQzCxxnkth7
        7RcLSI2wgJvEkU3RIDW8AuYSE/r2MkLYghInZz4BO5xZQEdiwe5PbCDlzALSEsv/cYCEOQWs
        Je7/X8QOcaiSRMPmM1B/1krsbT4A9o2EwH8OiX1fFzNDJFwkbq45AGULS7w6vgWqWUbi/875
        TBB2tcTTG7+ZIZpbGCX6d64HWywBtK3vTA5EjaPEz3nHWCHCfBI33gpCnMknMWnbdGaIMK9E
        R5sQRLWaxOp7b1gmMCrPQvLYLCSPzUJ4bAEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95Pzc
        TYzAJHT63/GvOxhXvPqod4iRiYPxEKMEB7OSCG+uGleqEG9KYmVValF+fFFpTmrxIUZpDhYl
        cV5t25PJQgLpiSWp2ampBalFMFkmDk6pBiaVr+dnrv3p7fnY9b7lx/Lvmpc5TnM/DYmLb5pd
        YXAy1Kwr2S1bLfLgYc77m//orDHZqPJ/c0/B2dkLqpqm8tvcFdiy97y92J+9m9csPf5hWop5
        Z2dbNNP89TdaunTSbxw3vXDXymjxi63Mvt4XU8yd9GbfCdsfNDXgnVW9qcl93Y4Hb1nD/rB/
        TptdYPH9+Ke6UIYrydFf/KzmeB+4FfnGWjmZNcd9mbPZ7GK71i96BhK2J2yMdC7eEBMuVL9p
        tn/DBM7QHIYlfHnFvYJz9Q9pvL1v3KL6Zsf+sKPqP5mCfKVN2qo2i1VZXZ+wTDvy2xTm5ReM
        +s+f3JOv8vfjxluHLjy/Wtp+Vp7ZeAXHgl4lluKMREMt5qLiRAAdQQuAsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7prDnGlGixaImsxZ/0aNovd0/+x
        Wsycd4fNYs/ekywWf6abWLR3zGG0WPl4K5PFoXtXWS1mb13BbPH7xxw2By6PzSu0PE7M+M3i
        8WLzTEaP3Qs+M3l83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7G8by5rwTeWiu9H29kaGCewdDFyckgImEhMeH0cyObiEBJYyijRs+wn
        G0RCRmLjl6usELawxJ9rXWwQRR8ZJTZs/coM4WxhlOg8fgasikVAVeLPxoOMXYwcHGwCWhKN
        newgYREBY4mJy/eDNTMLHGeS2HvtFwtIjbCAm8SRTdEgNbwC5hIT+vYygthCAtkSEyd+YoeI
        C0qcnPkE7FJmAR2JBbs/sYG0MgtISyz/xwES5hSwlrj/fxE7xJ1KEg2bz0A9VivR+eo02wRG
        4VlIJs1CMmkWwqQFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmNx27GfW3Ywrnz1Ue8Q
        IxMH4yFGCQ5mJRHeXDWuVCHelMTKqtSi/Pii0pzU4kOMpsCAmMgsJZqcD0wGeSXxhmYGpoYm
        ZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTNxLFBwOTnjAlHhkVmLX55vlm44W
        ypzhfMl07dHinery2/lF1NvmbArYVdFjlX4sLzr20Pa1z6SXb0zltLt37oWZ41lRycNOLXo5
        txl2f1u8TjrgfPoy68+1VuwLXpff57kV+vjMa4O3P+/fffONyf9y2J2+Ssl62/BIt2e8mRZy
        9Zt52NjfHvJY8nyqel9wbEmjZ97E8inXXkTseikr7ZTP8tTc+5XCq8ln5K9K9zWe2GNxNHuB
        6c3qhNfzAmfm656euX3ygwOnijb845oe9ULObr+PRoXLLF+b5WeiVwvNfiVSobSu5pnAZjbW
        FW5SPjMehzwqWR/luc6pjds/ZddZTj1Ltvfc3jvFxfWvXFFiKc5INNRiLipOBAAjH+TKTgMA
        AA==
X-CMS-MailID: 20230920100012eucas1p1f44530cfdd1ff8ed668bfe0c088d31ce
X-Msg-Generator: CA
X-RootMTR: 20230920100012eucas1p1f44530cfdd1ff8ed668bfe0c088d31ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230920100012eucas1p1f44530cfdd1ff8ed668bfe0c088d31ce
References: <20230919045135.3635437-1-willy@infradead.org>
        <20230919045135.3635437-4-willy@infradead.org>
        <CGME20230920100012eucas1p1f44530cfdd1ff8ed668bfe0c088d31ce@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:51:12AM +0100, Matthew Wilcox (Oracle) wrote:
> Remove an unnecessary folio->page->folio conversion and take advantage
> of the new return value from folio_create_empty_buffers().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/inode.c       | 14 +++++---------
>  fs/ext4/move_extent.c | 11 +++++------
>  2 files changed, 10 insertions(+), 15 deletions(-)
> 
I had a similar cleanup that I sent a while ago:
https://lore.kernel.org/linux-ext4/20230512125243.73696-1-p.raghav@samsung.com/

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
