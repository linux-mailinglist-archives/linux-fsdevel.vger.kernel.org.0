Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB577B94E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjHNNBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 09:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjHNNBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:01:43 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878C1710
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 06:01:22 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230814130113epoutp01ee192971eb7a728c232384c519041b95~7QXkJH8Wc0677906779epoutp01P
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 13:01:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230814130113epoutp01ee192971eb7a728c232384c519041b95~7QXkJH8Wc0677906779epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692018073;
        bh=jM2VGHFb+JlqR9zjYuZhlEYqAEqGzpivCMEb/22+bAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N8/b2hifmH6DnilUQOTgvOjptWpBYi1PeG915VClLEOR/R/6/rdJG/aaLNjVQnyiz
         OUI9tV46PMiqEqNySUcrcLf3zSdMgRQPLVWjgZiqULI/OrOtHDVz4vc3ihf84O1ywz
         zunoJIyBFMXsfEWUNFxZn1lUKQPEBBNIKcTryMoc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230814130112epcas5p4911f9a9e6f010a347b48734a3237a9e6~7QXjHSw3B3072830728epcas5p4X;
        Mon, 14 Aug 2023 13:01:12 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RPZK22WlHz4x9Pr; Mon, 14 Aug
        2023 13:01:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.C3.55522.6952AD46; Mon, 14 Aug 2023 22:01:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230814121319epcas5p32e02f82561b4040f8e3fb7c7410b6de5~7PtvgeQaE2140321403epcas5p3E;
        Mon, 14 Aug 2023 12:13:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230814121319epsmtrp2479bbf33206258a34d03825743a7e8e3~7PtvfUa9o0884008840epsmtrp2I;
        Mon, 14 Aug 2023 12:13:19 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-83-64da2596b55e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.55.30535.E5A1AD46; Mon, 14 Aug 2023 21:13:18 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230814121315epsmtip264aaea99f00073a95cc0b32dd5a0ebd7~7PtsahaFA0358203582epsmtip2d;
        Mon, 14 Aug 2023 12:13:15 +0000 (GMT)
Date:   Mon, 14 Aug 2023 17:39:59 +0530
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
Message-ID: <20230814120959.ridr6xptirlcjkty@green245>
MIME-Version: 1.0
In-Reply-To: <355bb623-9cd9-fe33-106e-1f091c09fb32@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVCTdRzv9zzPxjO6eY+86M9pOudxF/NANsb6ARKmnD1l3XF1epVXa7In
        IGCbe1GyTKA0kFchSEaCprxtxFtmBI10KEzAzCPexoFcB2oguKBI4sU2Njr/+/w+n+/n9327
        L4l7ZXjwyHiljtEo5YkCtidxpc1fGFDkZ1MEDf3uieo623GUlreEI9NwLhtNts0AVGSfx9HY
        1S8AGv05EpmnS1ho8OqPGKo23cBQvqUPoPFeA4bMtu3owqlLBPrJfJNAPc1fs1FZxbgHquxY
        xtBA3jhAtZOPCGS1bUS3lzpYu9bRPb/to2+PNBB0zy093WjMYNPfXTpBtwymsOmLOQUsOvuz
        aTb957iNoB+19rLpnMtGQM82bqYbx6awaO47CTvjGLmC0fAZZYxKEa+MjRDse1O2RxYiDRIF
        iELRCwK+Up7ERAiiXosO2Buf6OhZwD8iT9Q7qGi5VivY8eJOjUqvY/hxKq0uQsCoFYlqiTpQ
        K0/S6pWxgUpGFyYKChKHOALfT4hb7F/A1AMeyaXzuewUcJ19GnBISElg5UiBA3uSXlQLgLbM
        +8ApeFEzALYN6V3CHICWr9I9Vh1D6Rcxl2AGcH6iELge9wAcaq5gOaMIyg8au1IdDpJkU9th
        1xPSSftQz8O50UrCGY9TxSx4paYUdwreVAIsHupjO+O5lBTmFx5z0lxqLbxZPEY4MYcKh2Vd
        uStF+FKb4Nnyv3HnP5Aq48CHlnPAVV0UNFrbcRf2hhMdl91V8+DstNnd81FY/WUV22X+HEBD
        v8FtjoQnO3NXzDgVB+sHUwkX/xws7KzFXPwamL0whrl4LmwqXcXbYE3deXeCDbDvn1Q3puHZ
        6R/c47IDWGu6QOSBLYanujM8lc+Fw2CGPY1lcAwDpzbCymXSBf1hXfOO84BlBBsYtTYpltGG
        qEVK5uj/G49RJTWClZsQvtIEhkftgRaAkcACIIkLfLhZXJvCi6uQf3SM0ahkGn0io7WAEMey
        zuA83xiV46iUOplIEhokkUqlktBgqUiwnjt58pzCi4qV65gEhlEzmlUfRnJ4KdjahUy/V2+x
        eM+W/5HVY/DZOtEQpEonDe0fK6vEr8+Wt5B+rd8WNE8tYMH2w38txr0XwLdydr8UnN/9iZWo
        3rqFOvxr8ofcT5OzxLrQTtMHp5U6vO7I/g7ZxIGa3vB3eQcfm4yl166X8Eus7WnNsvBD/45P
        HJT+chzOmk/cW79mc/39499vUgq9aWyyVSx6IyH+Wk/2tidC/yru3EDF2w/8Ti0bxTK0J18W
        2t2Ssq6nIZR150xaXf/eJt+CIXuaOCxYQd+JGYm8awpTdz4wSHb5iQYjD1hfPiSa4vDrH6bu
        Ll9sNM1kBmu6jbpvHnOFz+RY7y7diGrU1yikRftZb9ntwwJCGycXCXGNVv4fIjC6FJwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG+c45OzsbrY7T6stZxigqLS/d/CqpIKFTUa3yrwprupOGbo4d
        L2kXraBU8lJh2MrKtEmTNKd0U0unTkvUcDnymLZoVjC8l2Cp5ZSo/x6e5/e87wsvhUubCU/q
        pCaO1WmUMXJSTDypl3uvCfPkVQGFuUGo7I0FRxdyJnFU0pNNImf9CEA3hsZx5Ki9DJD91TZU
        M3BLgLpqn2PoYUkjhq6ZbQD1deoxVMP7ooJLRQSqrnlNIOuL2yS6a+gTouKmKQy9z+kDqNQ5
        SKBmXobaJ5sE2xcw1nd7mPbecoKxtsYzJmM6yVQUpTBVXakkU5h1XcBkXhwgmeE+nmAGX3aS
        TFalETCjpiWMydGPKSSHxcEqNuZkAqvz33pcHPXyUQ+mzRCcuj9URqSCHCIDiChIr4fdaYWY
        S0vpKgD570Gz/iJomGzAZ7U7fDj1VZgBxNOMA8DeiRcCV0DQy6Gx5fx0QFEk7QtbflMu24Ne
        CcfsxYSLx+l8ATT8ahe6Anc6GvZYykgXL6E3wmu5ybN7hwBML5G4tIR2g69vOmZuw6eROxWf
        cBeO0zJYPDUzXkRvgXdbsmcmzqe9YN6DH3gOcNP/19b/19b/a98DuBEsYrWcOlLNBWrXathE
        P06p5uI1kX4RsWoTmHm2j88zUG0c8jMDjAJmAClc7iG5IuFVUolKmZTM6mKP6eJjWM4MZBQh
        XygZc2aqpHSkMo6NZlktq/ubYpTIMxV7mqgcEb1VN9l2997XH4lIaPj4pWvNwitz8RSvmHyH
        uGNj4NIC61Zt9+5d4QX+AT/P7Wz9LFzKJeKnbXHFy5zNAzvEO1PeVde5BY+TQb11wtDFzpAW
        +SN9NRbybd9wYaOhU73y00FrnW17XIjHruxR/ucHWV5Wh/fR7vB+fxPY43598MSgXbicfxW7
        7kHlPHXyY7/9mzu9z2rj+TSp/mZER+Ot1hL7aH158yHmRumWkbdG7Z2OOUkKUbTF98yGhAlq
        27ngtLzQ1YccbUGbci+nZTR8bpPFEulcRL5FETUC7Ap/g1kxrvgtnuCLpAcyhfTzMI3Xiqur
        inItvO3g3io5wUUpA31wHaf8A6ifNtlbAwAA
X-CMS-MailID: 20230814121319epcas5p32e02f82561b4040f8e3fb7c7410b6de5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_548ca_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
        <20230811105300.15889-3-nj.shetty@samsung.com>
        <355bb623-9cd9-fe33-106e-1f091c09fb32@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_548ca_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/08/11 02:58PM, Bart Van Assche wrote:
>On 8/11/23 03:52, Nitesh Shetty wrote:
>>We expect caller to take a plug and send bio with source information,
>>followed by bio with destination information.
>>Once the src bio arrives we form a request and wait for destination
>>bio. Upon arrival of destination we merge these two bio's and send
>>corresponding request down to device driver.
>
>Is the above description up-to-date? In the cover letter there is a 
>different description of how copy offloading works.
>
Acked, This description is up to date.
We need to update this description in cover letter.

Thank you,
Nitesh Shetty

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_548ca_
Content-Type: text/plain; charset="utf-8"


------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_548ca_--
