Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A2764F91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjG0JYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 05:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjG0JXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:23:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1AD7A8D
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:14:06 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230727091405euoutp0235266c8da6f08a221522fcd84af4d069~1rqHk8vFu1121811218euoutp02I
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 09:14:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230727091405euoutp0235266c8da6f08a221522fcd84af4d069~1rqHk8vFu1121811218euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690449245;
        bh=0cXnpVGBxmhdJMmaYwcwbcH1i+EYtVarejvMg08tUEU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=o8EvI3oJPSzJmaw4QQ9eZlGB34eQ2iUHfmsYdW/EvXAWSOHD1BuI6VqjfqqcVMp2+
         YwbnqSondbnxWS+iP8aZnZ9Eo63iZlcdaNhOzwJNB6EYLlHBOQSydmBnwPpz79L+H6
         fDeiGbfPeXnvP8oCqlE8WnJRjNe4H785ZE5JWexk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230727091405eucas1p2f0cf4841ed09c937a4790a1ea0c85c00~1rqHQtllF1076710767eucas1p2L;
        Thu, 27 Jul 2023 09:14:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.CF.37758.D5532C46; Thu, 27
        Jul 2023 10:14:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230727091404eucas1p2cbc14ec51eb1442496b1a4c30cd04803~1rqGwZ52s0918209182eucas1p2A;
        Thu, 27 Jul 2023 09:14:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230727091404eusmtrp1620d5fe01aaff3faf74f6cc965cb1d73~1rqGvtzXx0747907479eusmtrp1k;
        Thu, 27 Jul 2023 09:14:04 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-77-64c2355dff9f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A3.49.14344.C5532C46; Thu, 27
        Jul 2023 10:14:04 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230727091404eusmtip1a4ebbfaa152885d175508f032d78b685~1rqGkcS5t2832928329eusmtip1z;
        Thu, 27 Jul 2023 09:14:04 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 27 Jul 2023 10:14:03 +0100
Date:   Thu, 27 Jul 2023 11:14:02 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] block: use iomap for writes to block devices
Message-ID: <20230727091402.3j5f7t22upvr4lvz@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230720140452.63817-6-hch@lst.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7qxpodSDO7OYreYs34Nm8Xqu/1s
        Fo3vlC0uP+GzWLn6KJPF3lvaFnv2nmSxuLxrDpvFvTX/WS12/dnBbvH7xxw2B26Pv3M/Mnts
        XqHlcflsqcemVZ1sHps+TWL3ODHjN4vH7psNbB6fN8kFcERx2aSk5mSWpRbp2yVwZZzf+pe9
        4B9jxZW9G9kaGC8xdjFyckgImEh0Hn3I1MXIxSEksIJR4uendywgCSGBL4wSU5akQNifGSWO
        reeEadh0ZAUbRMNyRonTTQtZ4Yr6PlpBJLYwSky4fp8JJMEioCpx/XcTcxcjBwebgJZEYyc7
        SFhEQEni6auzjCD1zAL3mSQ+7DsIdpKwgKvEvJa9zCA2r4C5xNW/b5ggbEGJkzOfgF3HLKAj
        sWD3JzaQmcwC0hLL/3GAhDkFDCSmrj8A9ZmSRMPmMywQdq3EqS23wL6UEJjOKXFv9jk2iISL
        ROfqNlYIW1ji1fEt7BC2jMTpyT1QzdUST2/8ZoZobmGU6N+5HmyxhIC1RN+ZHAjTUaLlpT2E
        ySdx460gxJV8EpO2TWeGCPNKdLQJQQxUk1h97w3LBEblWUj+moXkr1kIfy1gZF7FKJ5aWpyb
        nlpsnJdarlecmFtcmpeul5yfu4kRmKBO/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuE1jNmXIsSb
        klhZlVqUH19UmpNafIhRmoNFSZxX2/ZkspBAemJJanZqakFqEUyWiYNTqoHJ0MBxzpHWhxGP
        TuqmH3orK8BXczGq5PqxJzkrgnfPPv9plutiS8Zjn1Lrte7Gt/978PqsvqP1nTcT1u2/L2x4
        czbvrhJ725D11u6q+y46xrXeyJKrObLhy2Xv7kOtXYkvPH1DNBpvbi1cxfGOL/TRBhWhletD
        V+RH9u5Ou3S1dmX3ap+pGuuDHVfc2eBfx2r3+NrWAPP7DytLbIriD21N80+rVC5/wqHIyLN0
        qkSAbSan1L0pD0pvLZm18xuXtVLN43+X70TGbTFytUntu+u18n2grdTNjt2a8SFdPLcqrCyW
        rLsw22OG89sZMtd1ldjvzndvso0x5xN+cvjJnKMyMbuanvnXiS5XY9WMTTZUYinOSDTUYi4q
        TgQA9/RpsL8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7oxpodSDGa2KVrMWb+GzWL13X42
        i8Z3yhaXn/BZrFx9lMli7y1tiz17T7JYXN41h83i3pr/rBa7/uxgt/j9Yw6bA7fH37kfmT02
        r9DyuHy21GPTqk42j02fJrF7nJjxm8Vj980GNo/Pm+QCOKL0bIryS0tSFTLyi0tslaINLYz0
        DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ms5v/cte8I+x4srejWwNjJcYuxg5OSQE
        TCQ2HVnB1sXIxSEksJRR4szDJUwQCRmJjV+uskLYwhJ/rnVBFX1klPj27DUjhLOFUeLmhOVg
        o1gEVCWu/25i7mLk4GAT0JJo7GQHCYsIKEk8fXUWrJ5Z4D6TxId9B8HqhQVcJea17GUGsXkF
        zCWu/n0DtllIIFRi2tkZrBBxQYmTM5+wgNjMAjoSC3Z/YgOZzywgLbH8HwdImFPAQGLq+gNQ
        3yhJNGw+wwJh10p8/vuMcQKj8Cwkk2YhmTQLYdICRuZVjCKppcW56bnFRnrFibnFpXnpesn5
        uZsYgfG67djPLTsYV776qHeIkYmD8RCjBAezkgivYcy+FCHelMTKqtSi/Pii0pzU4kOMpsCQ
        mMgsJZqcD0wYeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTOsC
        5rA/n+4Rwimx+M+39548U58V3Ta8e3qT3Ryl74YP9z1yrJJTC5p2x+XPa41zp3czrzqVu9+M
        46jq8b2bjmz43T71tkp8TPGVo6XrA64F/rnZLxr68a4eM/eJT/4789ecnv25/bO8Hrdyv1ee
        tbyQpvGN418Dn7w4+v/b+biML50XNmca3k4obN0q91Wj7rbgsqf3QxZ+e7mzIPNxzJxmBkeO
        yyfWX1RTMlt5I0va0/XwD/Wgbb5Rd2ZGZq/8GjdTJFrwTar4F+9/ps8uncgKCIh4Z/7yyF+b
        gpnHGs75bSqR0Hef8cu0/ai2hWzrtOSJWdNdlmzYdFSnZAX/2aYQqUfHOB1Op8QKsuxYKW6l
        xFKckWioxVxUnAgANNCESGADAAA=
X-CMS-MailID: 20230727091404eucas1p2cbc14ec51eb1442496b1a4c30cd04803
X-Msg-Generator: CA
X-RootMTR: 20230727091404eucas1p2cbc14ec51eb1442496b1a4c30cd04803
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230727091404eucas1p2cbc14ec51eb1442496b1a4c30cd04803
References: <20230720140452.63817-1-hch@lst.de>
        <20230720140452.63817-6-hch@lst.de>
        <CGME20230727091404eucas1p2cbc14ec51eb1442496b1a4c30cd04803@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:04:51PM +0200, Christoph Hellwig wrote:
> Use iomap in buffer_head compat mode to write to block devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
