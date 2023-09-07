Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D949797C5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjIGSvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243710AbjIGSvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:51:42 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F28CC
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 11:50:56 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230907080933epoutp01544b31953dfd6c23e6be32f4a7b1f09b~Cj3wnJIgd0328403284epoutp01W
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 08:09:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230907080933epoutp01544b31953dfd6c23e6be32f4a7b1f09b~Cj3wnJIgd0328403284epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694074173;
        bh=V6wr2bHKFf1JJGBntBJklQKl0KYjTY7rWeAV22neHUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FuIsvGFBvEa3mSAuwbudLT13WTEF4irSeTJwTLS02ZR1lw4VXAkTtF7Mp51f/FSdv
         4FsOsII2UFfacQCYclmXd/ERK+PuP7Dwzw1kKP7v8NGj2jOzCZdkT5/Z4KdjQ7Eeb+
         em53o6sbb4Vimt9FBI1xdjZ+xsanhssjNly3gvzU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230907080932epcas5p29191997c30b6c069da4ec6098457f9ed~Cj3v7N0E82859528595epcas5p27;
        Thu,  7 Sep 2023 08:09:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RhBjQ5pMQz4x9Q6; Thu,  7 Sep
        2023 08:09:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.40.09638.A3589F46; Thu,  7 Sep 2023 17:09:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230907071936epcas5p1ae555e75c8ee278f08e4537d0839cc72~CjMJf8lev2653926539epcas5p1y;
        Thu,  7 Sep 2023 07:19:36 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230907071936epsmtrp17265aa18f417f5e035967b86ea7c0b17~CjMJe6os_1235812358epsmtrp1B;
        Thu,  7 Sep 2023 07:19:36 +0000 (GMT)
X-AuditID: b6c32a4a-92df9700000025a6-ff-64f9853a35a9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.0D.18916.88979F46; Thu,  7 Sep 2023 16:19:36 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230907071933epsmtip2c2f2ef6298194cfcf6c7db10e2733a19~CjMGmu15-2489124891epsmtip2B;
        Thu,  7 Sep 2023 07:19:32 +0000 (GMT)
Date:   Thu, 7 Sep 2023 12:46:11 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 03/12] block: add copy offload support
Message-ID: <20230907071611.rgukw7fory2xh5sy@green245>
MIME-Version: 1.0
In-Reply-To: <b0f3d320-047b-4bd8-a6fc-25b468caf5b3@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVCTdRzA+z3Psxc8V09D7AdU0rC7kAM32uYzYuAp1z2XdQennlndwWKP
        jGNsuz0bYHY1UUC4YIoUMKlAKN6E5SCP9yMMgVHxh4GAQsIxDZD3GyIEtLHh+d/n+/52XzbK
        TWf5sBNUOkqrkil5zF3YrdsBAUGh6c/k/KKcAMJsvYMSaZc3UKJm1MgkZm4vAWKyIxMQbXPX
        GMRwRxNCtF7PQ4iqmi6EyOscBIRtwIQQbSOBRGlGOUa0tvVixN3mYibx4882FlHRvYkQQ5dt
        gKibmceInhFfon+jm3HYi+wfu4mRd//Uk5bqLCZZX/412TJsYJJluVcZZM6FOSa5aBvByPn2
        ASaZ21ANyPq+c+Sy5U3SMjmLRHE+SQxTUDI5pfWjVHFqeYIqXso7djzmaIxIzBcECSTEIZ6f
        SpZESXmRH0YFvZ+gdMzL80uWKfUOVZSMpnkHw8O0ar2O8lOoaZ2UR2nkSo1QE0zLkmi9Kj5Y
        RelCBXx+iMjhGJuoWMtewDRbrNTKrCamATxgZgMPNsSFMGtzGMsGu9hcvAXAjMe/sFzCEoDz
        tR3M54J9ogzZCbHPNCIuQxOABXPDLKeBiz8CsH5ht5MxfD+8uLHlcGKzmXgg7NtiO9V7cB5c
        zOzcroDi6Qy4VrO0ndQTD4cTK5sMJ3NwMZw5X4q6+FXYWzSJOdkDfw8aV8e3+/bCX4eFP9lR
        ZyKIF3jA8sJld3eRsLBpg+FiTzjd3cBysQ+cMma4OQVW5VcyXcEXATTdMwGXIQKmW43blVFc
        AZ9MjWIu/RvwW2sd4tK/DHPWJ93FOLDxhx32hzfMJe6tesPBp+fdTMLJp7XuDS0AaJg9chns
        M70wnOmFci4OhVkLaQyTY3ko7gsrNtkuDIDm5oMlgFENvCkNnRRP0SJNiIpKeX7xOHWSBWz/
        w4EPGsH4w4XgToCwQSeAbJS3hzO3b0XO5chlZ7+gtOoYrV5J0Z1A5DjWFdTHK07teCiVLkYg
        lPCFYrFYKHlXLOC9xplJ/17OxeNlOiqRojSUdicOYXv4GJCKa/nWM/cubJmjuoo2PFdQ6+/B
        x0kpdyTTctJ66I93vO/M7R8fM0R+XDAsT/4r9p/kmOK6hvw6USkbiCZ+WzxWzIe3lKsaq2BN
        n9N+OjmCHp2iLPd9bxR+FVGWUlVVuTeyR3Ip/mZT34DhvwKPElq43nzWOK1t7Xmr2Jb25Du7
        f8RLVv+EL0uiU/8+9XaYRa7g9knW1yOH8kJ7uNgle605rpKCD6dbVsnBX7m+it2nsgIrTCfO
        zfZa64zBA4+vPLDY+s+kfrRy+v7ecE7XSqv5aOx63pD18HUzEv5o6pV/2zLJT9ujk77xlEQf
        ORlSNPbs6mcnYtOW2+yoVPN5wqI0l4fRCpngAKqlZf8D0vdD9ZgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvG5H5c8Ug52beS3WnzrGbNE04S+z
        xeq7/WwWrw9/YrR4cqCd0WLvu9msFjcP7GSy2LNoEpPFytVHmSwmHbrGaPH06iwmi723tC0W
        ti1hsdiz9ySLxeVdc9gs5i97ym6x/Pg/JosbE54yWqx7/Z7F4sQtaYvzf4+zOoh6nL+3kcXj
        8tlSj02rOtk8Ni+p99h9s4HNY3HfZFaP3uZ3bB4fn95i8Xi/7yqbR9+WVYwem09Xe3zeJOex
        6clbpgDeKC6blNSczLLUIn27BK6M8613WAs2slYc3dnE1sC4gqWLkZNDQsBE4uvrHUxdjFwc
        QgLbGSWezX3KDJGQlFj29wiULSyx8t9zdhBbSOAJo8TyPVEgNouAikTL3/9AzRwcbALaEqf/
        c4CERQSUJD62H2IHmcks0M4q0b/gFSNIQljATuLRt3+sIDavgJnE68aFzBCLPzBKXNp+kxki
        IShxcuYTsOuYgYrmbX7IDLKAWUBaYvk/sAWcAtYS/T8esoHYogIyEjOWfmWewCg4C0n3LCTd
        sxC6FzAyr2IUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIjmatoB2My9b/1TvEyMTBeIhRgoNZ
        SYT3nfy3FCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQYm
        psVGUjocv0PKF1veYZ6r5CabX2m7J+v1ubSIoFPLQiZPSBackunI5m6f/aTmt5Csv8qiRuby
        fYdsMlgPZThaXf/x13umoG4Qw4d/i/+GRTnsZJJL6LmXxsCXyHo9dVXFIc2+2MaQsLOK2TJu
        PpdSXB5kHMvvPzlvW2GI8sPbpqpJX97oRK1JeV1W0H6U+bHzwvnch6cp5Vrcj/kRnBH4+O67
        NYI1D7eLP/68patKUlN/xY9p7d7HjtawHlBOenbhwTaeN+yZ91M29xubxqS6MoYobvfu3s0V
        zyAaJmBn9jk+MuJ4e8GM/+ZS3g8M1hmeuvL5/auvU9Yd5JrsviNBdkb5+4Rjfw7d4mRqalRi
        Kc5INNRiLipOBABGGkG3VQMAAA==
X-CMS-MailID: 20230907071936epcas5p1ae555e75c8ee278f08e4537d0839cc72
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----1B4_PwnuBgjs5al8.ARo7bB9J1Y4sbiuOmsCUR3u7pWcBekA=_3ae06_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3@epcas5p3.samsung.com>
        <20230906163844.18754-4-nj.shetty@samsung.com>
        <b0f3d320-047b-4bd8-a6fc-25b468caf5b3@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------1B4_PwnuBgjs5al8.ARo7bB9J1Y4sbiuOmsCUR3u7pWcBekA=_3ae06_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 07/09/23 07:49AM, Hannes Reinecke wrote:
>On 9/6/23 18:38, Nitesh Shetty wrote:
>
>Hmm. That looks a bit odd. Why do you have to use wait_for_completion?

wait_for_completion is waiting for all the copy IOs to complete,
when caller does not pass endio handler.
Copy IO submissions are still async, as in previous revisions.

>Can't you submit the 'src' bio, and then submit the 'dst' bio from the 
>endio handler of the 'src' bio?
We can't do this with the current bio merging approach.
'src' bio waits for the 'dst' bio to arrive in request layer.
Note that both bio's should be present in request reaching the driver,
to form the copy-cmd.

Thank You,
Nitesh Shetty

------1B4_PwnuBgjs5al8.ARo7bB9J1Y4sbiuOmsCUR3u7pWcBekA=_3ae06_
Content-Type: text/plain; charset="utf-8"


------1B4_PwnuBgjs5al8.ARo7bB9J1Y4sbiuOmsCUR3u7pWcBekA=_3ae06_--
