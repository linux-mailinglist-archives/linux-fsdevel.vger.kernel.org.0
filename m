Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33387ABEC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjIWINR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjIWINQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:13:16 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180F197
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 01:13:09 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230923081305epoutp02d8432e6f34bf61ae249dcfeb5f0b0c07~HePaWIjux2604926049epoutp02j
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 08:13:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230923081305epoutp02d8432e6f34bf61ae249dcfeb5f0b0c07~HePaWIjux2604926049epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695456785;
        bh=TLE/Sy/4Fa+njmqsxxYakkAuq43NHPAgx52dBzDfrZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h/BWI4DfmcnNaHBy6QEQOVpke8+msZ4Ysg5JXgqBpX/KOBzL2t0KTNKyTU7BW30VN
         9FjXB5laHJDm7pt9AU3Mcf9q7skaptZLcmsQeiCICp4QRz4db4PP2Mte6G3yKiqKgk
         w2Y4rvlrH8jV2WumXnyYSD87oeAmQXNLS6y4Lqhc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230923081303epcas5p1556a5e37929a332e7b59407ddb854315~HePY2SkX20487904879epcas5p1i;
        Sat, 23 Sep 2023 08:13:03 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rt22449bnz4x9Pr; Sat, 23 Sep
        2023 08:13:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.26.09638.C0E9E056; Sat, 23 Sep 2023 17:13:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230922111746epcas5p204bf631f0d45f43c5fb13bad26b2c798~HNHYET5c51000710007epcas5p2q;
        Fri, 22 Sep 2023 11:17:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230922111746epsmtrp22f04a152ad73f84d56629c97edbd2234~HNHYDC8w22146921469epsmtrp2S;
        Fri, 22 Sep 2023 11:17:46 +0000 (GMT)
X-AuditID: b6c32a4a-92df9700000025a6-78-650e9e0ca620
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.D3.08649.AD77D056; Fri, 22 Sep 2023 20:17:46 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230922111742epsmtip1dfbf7bb7f35d2f16f25d65543eb97821~HNHU3SCWc2955729557epsmtip1A;
        Fri, 22 Sep 2023 11:17:42 +0000 (GMT)
Date:   Fri, 22 Sep 2023 16:41:41 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "anuj1072538@gmail.com" <anuj1072538@gmail.com>,
        SSDR Gost Dev <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v16 03/12] block: add copy offload support
Message-ID: <20230922111141.GA14640@green245>
MIME-Version: 1.0
In-Reply-To: <20230922095650epcms2p8e25340eff5de01f8b3ce63ae81266881@epcms2p8>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta1AbVRTHvbvLJlBhFgp6oa8QhikPoaRCeqFA1aJuHzJ0HL/otJCBFRBI
        0jzEWrWJGJRSXi1YDYWCpKWkD8ojhT5SGQJEYBhUCBSQSiV0FAZog9KhLWjCUqfffud/z/+e
        e86Zy8U99BwfbrpYwcjEokw+6UJcMwUGhbxY6caEdVZ4o/qeLhw9/OcJgb4sXsbRxfEiEs2Y
        bABZ274GyDhX7oRG2q5j6NYPJzFUd7ETQwVFBhKdbB8CaMqixZBxNBhV5+oIdMvYTaCBG2dI
        dPb8FAflD7eSqNa8gqE7xVMAtVrVAF2ZmSfQT6MbUP+y2ek1b/q6dpxD999tIOiBPiXdqM8j
        6SbdMfrmiIqkawpPOdEFOXMk/XBqlKDnb1tIurBZD+im3qP0QuNmutE6iyW4vZ8RncaIUhgZ
        jxEnS1LSxakx/H3vJu5OjBCGCUIEkWgHnycWZTEx/Lj9CSFvpWfaB8HnfSzKVNqlBJFczt8W
        Gy2TKBUML00iV8TwGWlKpjRcGioXZcmV4tRQMaOIEoSFbY+wJyZlpI2MDRJSi+sni5NdmApo
        1h0HzlxIhcOWjnnsOHDhelA3ARw7YSHYwAbgX7OTOBssAriy1GJP465a1LOfsboRwJmSPzls
        cB9Ai6bHyXEvQfnDwrYywmEgqWDY+y/XgZ7UK1Cj93Ok45SFC+uWdcCRvp6KhcaKCY6DXakQ
        2GVuwFh2h93fWwkHO1PxMD+3k3SwF+UH266ZV58NqV+d4Y+LlzlsP3GwtL6DYHk9nDY3r+k+
        cGHOSLKcDetKL5Cs+SsAtcNawB7sgpqeItzBOJUGqwyDa+ZNsKznCsbqbrDgiRVjdVfYWvmM
        /eCl+qq1At5w6JF6jWnYp+lYG+MjADV3zZxisEX7XHfa5+qxHArvlJWSLG+BOYZyXGufHk5t
        gLUrXBYDYf2NbVWA1ANvRirPSmXkEdLtYib7/+0nS7IaweqnCdrbCu5NPAhtBxgXtAPIxfme
        rsk2F8bDNUV05FNGJkmUKTMZeTuIsC+uBPfxSpbYf51YkSgIjwwLFwqF4ZGvCgX8l11nNBUp
        HlSqSMFkMIyUkT3zYVxnHxX2+bmMYeneMMPhxyaf6taDns3nbg9dUI0nHzp9zFDEU0WRfceZ
        rQMpI9IXeny/2CeY9n2Qv6Qs+e1sXuLwh5yl2Z0V/o+jbLrdJ3IPtgR8kDjHCypTGKItObJ7
        0l1/cy5vVMcFwKtHevM+sjWW+/k3Ly/Z6g0G9/x37g81WLBfLIFtHeNjnm9+txFdOjxfm+Be
        VJyR9w01Yg2uqQowbXV7w+Np7Ns1uqSOmAp96B8HTh0YMlkLCo82CcnuQ5w9vpPZzi9p3dZN
        q3uf7ijoUKUaJN+OnFboDJ7qPf34VX7371VJ4z+bPJU74/fHD545vyCUvC6srJ7YvEk71GKt
        9Ip9T12r4BPyNJEgCJfJRf8BApbBjb0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7bCSnO6tct5Ug94+Vov1p44xW3z8+pvF
        omnCX2aL1Xf72SxeH/7EaPHkQDujxd53s1ktbh7YyWSxZ9EkJouVq48yWfT2b2WzmHToGqPF
        06uzmCz23tK2WNi2hMViz96TLBaXd81hs5i/7Cm7Rff1HWwWy4//Y7K4MeEpo8WOJ42MFute
        v2exOHFL2uL83+OsDpIeO2fdZfc4f28ji8fls6Uem1Z1snlsXlLvsftmA5vH4r7JrB69ze/Y
        PD4+vcXi8X7fVTaPvi2rGD02n672+LxJzmPTk7dMAXxRXDYpqTmZZalF+nYJXBnPXy9kK/jE
        VXH3eh9zA+M+ji5GDg4JAROJxrc1XYxcHEICuxklum4sYuxi5ASKS0os+3uEGcIWllj57zk7
        RNETRon9h06wgSRYBFQl+g5MZQEZxCagLXH6P9hMEQEdidZVyiDlzAK3OSSen+9lBSkXFrCT
        2Dv3ATuIzSugK3Hs+EYmiJnfGSU+z33NApEQlDg58wmYzQw0aOfWO2wgQ5kFpCWW/+OACMtL
        NG+dDXYbp4CfRHfbUbBzRAWUJQ5sO840gVFoFpJJs5BMmoUwaRaSSQsYWVYxSqYWFOem5yYb
        FhjmpZbrFSfmFpfmpesl5+duYgQnDS2NHYz35v/TO8TIxMF4iFGCg1lJhDf5E1eqEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KLYLJMHJxSDUw8pTu/rag/wGq6M8Qo
        Z3a54I399ipzfzQd3fQyQJpxSzjLKl/l5UnGD++fnXtqQbHA7OgZj3jXyLpn7b/tPve7rVHj
        +s2bnn34lbdR98SW5wK2O9RXFXB0Sc7JWTvlRdu5zitrX79kqcmLzJOcMnfxh5dChgLRwt4b
        tW9Kh9mqfXFYalUTfKx8gpuA/8+vMvwG865f63qyfs6XinyR70t/NbQZPPh+dXZI+deT/au2
        pmU+3iFlyL5vDxszb8j3IL4FnzXnekQpXXlS05Ba+uWW65pXIZInTz7M9RB5dzlyV/tsEbGj
        HMYbOCzv3jywwlV70cOIa8f9lwa/ETi5OcDmjqLHtz05XCtjplXqGpeKK7EUZyQaajEXFScC
        AFPrTUWJAwAA
X-CMS-MailID: 20230922111746epcas5p204bf631f0d45f43c5fb13bad26b2c798
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----r74_f6S_OIQxXK41.4aq6v4zMY6akVoN.sMgyBemj3VfQZgP=_119e9_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081447epcas5p144e631c5b8c72acf64d38b04d6c2c925
References: <20230920080756.11919-4-nj.shetty@samsung.com>
        <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081447epcas5p144e631c5b8c72acf64d38b04d6c2c925@epcms2p8>
        <20230922095650epcms2p8e25340eff5de01f8b3ce63ae81266881@epcms2p8>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------r74_f6S_OIQxXK41.4aq6v4zMY6akVoN.sMgyBemj3VfQZgP=_119e9_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Fri, Sep 22, 2023 at 06:56:50PM +0900, Jinyoung Choi wrote:
> > +/*
> > + * This must only be called once all bios have been issued so that the refcount
> > + * can only decrease. This just waits for all bios to complete.
> > + * Returns the length of bytes copied or error
> > + */
> > +static ssize_t blkdev_copy_wait_io_completion(struct blkdev_copy_io *cio)
> 
> Hi, Nitesh,
> 
> don't functions waiting for completion usually set their names to 'wait_for_completion_'?
> (e.g. blkdev_copy_wait_for_completion_io)
> 
> 
> > +ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
> > +                            loff_t pos_out, size_t len,
> > +                            void (*endio)(void *, int, ssize_t),
> > +                            void *private, gfp_t gfp)
> > +{
> > +        struct blkdev_copy_io *cio;
> > +        struct blkdev_copy_offload_io *offload_io;
> > +        struct bio *src_bio, *dst_bio;
> > +        ssize_t rem, chunk, ret;
> > +        ssize_t max_copy_bytes = bdev_max_copy_sectors(bdev) << SECTOR_SHIFT;
> 
> wouldn't it be better to use size_t for variables that don't return?
> values such as chunk and max_copy_bytes may be defined as 'unsigned'.

Agree, we will keep ret as ssize_t and move others to size_t.
Acked for all other comments, will address them in next version.

Thank You,
Nitesh Shetty

------r74_f6S_OIQxXK41.4aq6v4zMY6akVoN.sMgyBemj3VfQZgP=_119e9_
Content-Type: text/plain; charset="utf-8"


------r74_f6S_OIQxXK41.4aq6v4zMY6akVoN.sMgyBemj3VfQZgP=_119e9_--
