Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5277B952
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjHNNCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjHNNBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:01:48 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0FE5F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 06:01:27 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230814130116epoutp02b8f4e78191d218f7bd4effe9828dc74a~7QXnily3i2338223382epoutp02x
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 13:01:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230814130116epoutp02b8f4e78191d218f7bd4effe9828dc74a~7QXnily3i2338223382epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692018076;
        bh=TtSCb9KBJ2XHwOfKwyT3tCYK0FFVQAC/FyEVAI9BMkA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dhkdcAXLXQFgzYOEVb2yzKfCYyD3S3NWEjnr7pFpSbknHIaJih2dcolLX6+6rKE/Y
         EpOe33Qa0gOPkDzOUnKfvLXnXUFqjRE3CYKtOCAAJVHhLUw+P7ot9IurrXQsP+ALGJ
         7Tc1i8LqnIoxwU8pChb/x4hxaYfhtDPCW1aebtg8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230814130116epcas5p174c4ae8fa6883c326483da4c005b41ca~7QXm56LGG0176601766epcas5p1A;
        Mon, 14 Aug 2023 13:01:16 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RPZK61vZgz4x9Pq; Mon, 14 Aug
        2023 13:01:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.21.57354.A952AD46; Mon, 14 Aug 2023 22:01:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230814122212epcas5p37453fdef19909077528971ee54ed26e7~7P1gNwF260611606116epcas5p3C;
        Mon, 14 Aug 2023 12:22:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814122212epsmtrp14a1aafb5de1203698ae6790f4309bb83~7P1gMve2K1933719337epsmtrp1B;
        Mon, 14 Aug 2023 12:22:12 +0000 (GMT)
X-AuditID: b6c32a44-007ff7000001e00a-3f-64da259aa015
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.07.64355.47C1AD46; Mon, 14 Aug 2023 21:22:12 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230814122209epsmtip2edb1c9a304e2560d48518e12f30945ff~7P1dR_UgZ0493104931epsmtip24;
        Mon, 14 Aug 2023 12:22:09 +0000 (GMT)
Date:   Mon, 14 Aug 2023 17:48:53 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-doc@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy
 offload in block and request layer.
Message-ID: <20230814121853.ms4acxwr56etf3ph@green245>
MIME-Version: 1.0
In-Reply-To: <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVDTdRi/7357A5v9HCDfzQpugaIGbDrmF4Ighe53acnlnV3xxxjsd4wY
        29qYUCcniBggCPkWG8ooMV6PwSREXmpCtgaRL8TEeRZXUAmCCAcCHaOxQfnf53mez+d5vYeJ
        sQsZXGaqIoNUKyRyHt2T2ta7PShYH2iX8s/e2ICMfT9g6HjZMoYaHpbS0UTvDEAXphcxNGr+
        DKCR76JR91QFDd03X6eguoabFHSmxwbQ2JCegrrtO9GXJ6upqKvbSkWDHRfpyPD1GAPVWBwU
        NFw2BlDTxBMq+tG+Bd1attBiNhODv+wnbv3aQiUGB7SEqb6QTlytPkZ03s+hE5dPn6URJXlT
        dOLpmJ1KPPl2iE6cbq0HxKzpFcI0OkmJZ32YFikjJVJS7U8qkpXSVEVKFG//IfE+cZiILwgW
        hKM9PH+FJJ2M4sUeiA9+K1XunJnnf0Qi1zpd8RKNhhf6RqRaqc0g/WVKTUYUj1RJ5SqhKkQj
        SddoFSkhCjIjQsDn7wpzEhPTZO1WHUNlZ2Q5/u7EcsBtehHwYEJcCJuXnoEi4Mlk450Amno6
        qG5jBsDpWdv/xrDFRluX5Fb/TF3FbPw6gFar2E36E8DylvMuEhUPhJWnzIwiwGTS8Z2wf4W5
        6vbGg+D8SI0rKYbraLCtsRJbDXjhaVD3wObqiYWL4InZhzQ33gStulFXMQ/8dXjj4oKL44O/
        BMuvzGGriSD+hQe8/Uc/WC0G8VjY9X2Qu1EvOG5pZbgxFz4qPbmGM2HduVq6W3sCQP09PXAH
        omF+X6mrIQyXwaJ7BWuCl+H5viaK278RlvwzSnH7WbC9ch2/ChuNVWtL5UDbs9w1TMDyqWsU
        94amAextKMbKgJ/+ueH0z9Vz4whYOH2cpnfOg+FbYI2D6YbbobEjtArQ6gGHVGnSU8jkMJVA
        QWb+d/FkZboJuH5iR2w7GDY4QnoAhQl6AGRiPG9WMcsuZbOkkk8+JdVKsVorJzU9IMx5rM8x
        rk+y0vlUigyxQBjOF4pEImH4bpGA58uayL8kZeMpkgwyjSRVpHpdR2F6cHMo/MW8OP7e2mWv
        vXX5nm8L75yytSWRFexS3e9dw2SxQSR4MaBumJNfNjc0GXro8KaqloitWZGc7NwQ7wDla7a8
        Rt9mSYzFGCeDhYMb5NkrWRRObWLFZXHCzK7Jgy8MFORVd8f3Jrb6VH7VdHNk1I9m4XKWzk08
        np+O6jL9thx46bBuYGXbNcf7ez6eR1s/esfcKN/t6Zta49/SXGJO7yzQMrOFuKFdcZV6cOOB
        C7PY5sdHOt40JWdb/e4u9S5GrzC01Plxx5Lxp6TOOG5uQsL4B2ZDwz7de0cXLLyWp0MBfyVN
        ZX6TYyw4OiHZ9kB55m6/d8yxO48QsVhoqEqYezfvygKPqpFJBDswtUbyL9O+GpucBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvG6JzK0UgyUT+SzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFg/221vsfTeb1eLmgZ1MFitXH2WymHToGqPF06uzmCz2
        3tK2WNi2hMViz96TLBaXd81hs5i/7Cm7xfLj/5gsbkx4ymix7vV7FosTt6Qtzv89zuog5nH5
        irfH+XsbWTwuny312LSqk81j85J6j903G9g8FvdNZvXobX7H5vHx6S0Wj/f7rrJ59G1Zxejx
        eZOcx6Ynb5kCeKO4bFJSczLLUov07RK4Mo6tbmQp6GGt2DbhLlMD4xyWLkZODgkBE4nGJeeA
        bC4OIYHtjBKXe5+yQSQkJZb9PcIMYQtLrPz3nB2i6AmjxP7bB5lAEiwCqhLzug8AJTg42AS0
        JU7/5wAJiwhoSHx7sBxsKLPAXFaJZb/Ps4MkhAWyJe4eWw+2gFfATKLl811WiKEfGCW+zbnE
        CpEQlDg58wnYecxARfM2P2QGWcAsIC2x/B/YAk4Ba4mDc36AzREVkJGYsfQr8wRGwVlIumch
        6Z6F0L2AkXkVo2hqQXFuem5ygaFecWJucWleul5yfu4mRnBcawXtYFy2/q/eIUYmDsZDjBIc
        zEoivD28t1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUa
        mDzCpxpc3h/7Y5X+wzeb9jlvt+M4Fh7brem0xSfksmxoImecvveU2fN5b32Ukm86HtVxrHRS
        x47vF4V7nvBcWLxIt1OsKbzqnmn8liknMjLNreu8uP7GR3GulX4iKa2q8+KWD18+t9bvFK1D
        Etvua1mr9l/k+7WiMG8qz9aQD2xqn6bEyf3/FG72Tt+SOU3WmmNL6DWPr3t6VbnypRoMjq01
        uyOmKXhkg7uVoFitUsbiXewddnfv33bZeWJ35ZnkIzHTN7q8WmPCoMK4YOqDHOFP4mz3hDqb
        unYtDJvX/9w1lumlXGsqn/SplOnnrNxD9uzwPXN6efaRyxscPC43PPc+vFHFP6zzzQoeYdZk
        JZbijERDLeai4kQAwZ9RKVoDAAA=
X-CMS-MailID: 20230814122212epcas5p37453fdef19909077528971ee54ed26e7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_54933_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
        <20230811105300.15889-3-nj.shetty@samsung.com>
        <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_54933_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/08/11 02:25PM, Bart Van Assche wrote:
>On 8/11/23 03:52, Nitesh Shetty wrote:
>>diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>index 0bad62cca3d0..de0ad7a0d571 100644
>>+static inline bool op_is_copy(blk_opf_t op)
>>+{
>>+	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
>>+		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
>>+}
>>+
>
>The above function should be moved into include/linux/blk-mq.h below the
>definition of req_op() such that it can use req_op() instead of 
>open-coding it.
>
We use this later for dm patches(patch 9) as well, and we don't have request at
that time.

Thank you,
Nitesh Shetty

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_54933_
Content-Type: text/plain; charset="utf-8"


------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_54933_--
