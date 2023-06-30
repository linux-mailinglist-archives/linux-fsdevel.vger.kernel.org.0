Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A91743B5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjF3MCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3MCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:02:47 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486C1FCC
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 05:02:44 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230630120241epoutp04e2d9ce1b3822f2b3afd0f645a0252eb6~tbin6CqhR1844518445epoutp04I
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 12:02:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230630120241epoutp04e2d9ce1b3822f2b3afd0f645a0252eb6~tbin6CqhR1844518445epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688126561;
        bh=zZubjPAKe4tJnP79rh7RaaQDYvtmoDCtXsGDKlJ0uFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mfshBycpvotrExq2m0BfCgxTNRVu78AGdZbgkTTKze+GZKQOwRURXGW1hTGfKUrZe
         zm2oJZqdd/yTj4QLaCbp+j7ZDivfd3I/TcqCAcRAxDI2Pqkk069kLOF0ncu3zjqEXA
         4hfB2hIz4tFIAr7mfvYYzrMWKwanER58x5e+432M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230630120240epcas5p3d08ca980d5065aa551daa2fd10006566~tbim_nHMD0126501265epcas5p3B;
        Fri, 30 Jun 2023 12:02:40 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qsv8H1L2xz4x9Pt; Fri, 30 Jun
        2023 12:02:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.E6.06099.F54CE946; Fri, 30 Jun 2023 21:02:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230630112545epcas5p1746ef2fc966c04b3a8163e0dff21fb4b~tbCXgpz0S0278302783epcas5p18;
        Fri, 30 Jun 2023 11:25:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230630112545epsmtrp100ac18072070bde82f83c688a8d35218~tbCXeO08n3247532475epsmtrp1R;
        Fri, 30 Jun 2023 11:25:45 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-cb-649ec45f75e7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.DC.34491.9BBBE946; Fri, 30 Jun 2023 20:25:45 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230630112540epsmtip25264414e861bfa35bbcaec8407f2f7ff~tbCTNRWsE1020410204epsmtip2Y;
        Fri, 30 Jun 2023 11:25:40 +0000 (GMT)
Date:   Fri, 30 Jun 2023 16:52:27 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, dlemoal@kernel.org, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <20230630112227.6ctls2vt4cy7vbxo@green245>
MIME-Version: 1.0
In-Reply-To: <ZJ1B1k0KifZrGRIp@ovpn-8-26.pek2.redhat.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTHee69vS3EumuR+PCikOKyAQGpQPdAYAo6d5fuAwl+GQnild5R
        BNqmLbJhIqDAFAaoDDIrVFQcbwoIbOF1smIFMYwZBgisDLWgkw0QAnbjZWspLH77nZf/eZ5z
        Tg4PFzRxXXgJcg2rkjNJQtKB+KHby8s39r5O6n+nioPq+x7g6OzFNRzVGgtJNNO9AFDJ/N84
        MnV9BdCgaTuavHcAdc5e5aDRrlYMddy4jKHqWgOGLuuHAZoa0mKoc8wHXc+pIFBH50MCDbaV
        kujad1NclDfSQqLKnnUM6YvOYajFlAlQ3cwcgXrHXNHzvPMADaz1cNCKuZQ86EYP/iqhW7VG
        Lj0wcZegm6q86cH+FLqx5gJJN1Wk0+2jGSR9s6CIQ+efmyXp11NjBD334xBJFzTXALrp0Wl6
        sXEP3Wj6C4ukohNDZSwjZVUerDxOIU2Qx4cJJVGxh2KDxP4iX1Ew+kDoIWeS2TDh4U8jfY8k
        JFmmI/Q4xSSlWFyRjFot3PdhqEqRomE9ZAq1JkzIKqVJykCln5pJVqfI4/3krCZE5O+/P8iS
        eDxRtpRXzlW2v/NF5YtpbgaY3pYL7HmQCoTmxwOcXODAE1DtAPYuPN40FgBcLMzg2oxlAK/U
        FHC2JOONGYQt0AngvZf6jYCAmgbQ3MO3MkG9CyuHG7BcwOORlA989C/P6t5JCaHRWLtRFKca
        SGhu1QFrwJEKgf0tTzeYT4mh4Y6JtPEO+PCKibCyPRUMl1oLNnKcKDf47a0l3FoIUhP2cNE4
        RNp+dxhWzHUDGzvCVz3NXBu7wD8KczY5FVZ/U0XaxFkAake0m4IDMLuvELcyTslgaVfOZtHd
        sLivDrP5t8P8FRNm8/Nhi26LPeHt+vLNfGc4/CaTtHYPKRr+PHjINq1ZAMuyzOAicNe+1Zz2
        redsHAIvzJ/laC1ynHKFles8G3rB+rZ95YBTA5xZpTo5nlUHKQPkbOr/G49TJDeCjevxlrSA
        Z5PzfnqA8YAeQB4u3Mkf//OqVMCXMl+msSpFrColiVXrQZBlWZdwF6c4heX85JpYUWCwf6BY
        LA4MDhCLhLv4M9llUgEVz2jYRJZVsqotHcazd8nANA4nRj0V2n9eP2HuS4fpQ8y17OcnigPS
        QrcB2ctaQ0Xd57WrU8fOdBuIVrl+Ojy8Yeyzto71sdB6CbM3Ji0r3e6ozAeMjTwZdwrnJEDt
        s5xbxE9NveHQdfrosEi3WMyPaCgZmpw9VimOOZ3/0asju93PVHut+N3NNK7Z0+k6Ea7LFGZH
        /fbidqFZEfsLmHVE73F6eKsRhvdvzpRN1msT4DixMEDWudn9nvwxJ0CSejI6Ke+kU9GNXMpw
        3TPMrrtr//n2Zuc9gqf9S4IYgelg+C6qaHnCveT74xE7HpDmiYBTfsuhzXtDRJ9wJZdWdctz
        jYOi6PT5KMPMG8HXzgNCQi1jRN64Ss38B0n6FerGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7bCSvO7O3fNSDC7d4bBYf+oYs0XThL/M
        Fqvv9rNZvD78idFi2oefzBZPDrQzWlx+wmfxYL+9xd53s1ktbh7YyWSxZ9EkJouVq48yWUw6
        dI3R4unVWUwWe29pWyxsW8JisWfvSRaLy7vmsFnMX/aU3aL7+g42i+XH/zFZHJrczGSx40kj
        o8W61+9ZLE7ckrZ43N3BaHH+73FWi98/5rA5yHhcvuLtsXPWXXaP8/c2snhsXqHlcflsqcem
        VZ1sHpuX1HvsvtnA5rG4bzKrR2/zOzaPj09vsXi833eVzaNvyypGj82nqz0+b5Lz2PTkLVOA
        QBSXTUpqTmZZapG+XQJXxvr+e2wFb3kqZu16ztrAuImri5GTQ0LAROL2pgaWLkYuDiGB3YwS
        Ddu+skEkJCWW/T3CDGELS6z895wdougJo0THuTlgRSwCqhLLr21g6mLk4GAT0JY4/Z8DJCwi
        oCRx9+5qsHpmgU1sEn/PvWQESQgLWEmc3fEQzOYVMJM4uvYJG8TQd4wSVy41MEEkBCVOznzC
        AmIzAxXN2/yQGWQBs4C0xPJ/YAs4BSwlvu7sA5sjKiAjMWPpV+YJjIKzkHTPQtI9C6F7ASPz
        KkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4JShpbmDcfuqD3qHGJk4GA8xSnAwK4nw
        3n4zO0WINyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDk7rf
        o41LXDk7Q6xd7wi3M/Qv4tP0F2fSWcqmyn15Q7P23BkLLn7RWj5p447Ne5/fudDZ+Oxcy8wO
        g9WNRcznxJeKHvFuuJj113Ll+tIviwL8Vdv3h2+6Wx4S3tAQt/Oq9GUR48nXfjy7sU/deMNN
        NiWXGl+uqTIT4v5vW8QcrTaxJ4UvvLL5+i1+PqWNhkEzlXfdE/T98ohLVHaGx+xzpnOb5Mv4
        1Bh2q1YdUgv6/+bXxJPHuW9PE3j/QfKft/JjbW3Fh4G8TtyPFgT1KX4SdJHuEGvhMhLT0/l0
        ZydPvNA1tetW96z8Z6jUa6fmH3Sc/mcpy+ntC1xqvR7t+Op+1Obws8wE1luBaq//lU6yV2Ip
        zkg01GIuKk4EAIi1iPiIAwAA
X-CMS-MailID: 20230630112545epcas5p1746ef2fc966c04b3a8163e0dff21fb4b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_26e0b_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
        <20230627183629.26571-4-nj.shetty@samsung.com>
        <ZJ1B1k0KifZrGRIp@ovpn-8-26.pek2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_26e0b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/06/29 04:33PM, Ming Lei wrote:
>Hi Nitesh,
>
>On Wed, Jun 28, 2023 at 12:06:17AM +0530, Nitesh Shetty wrote:
>> For the devices which does not support copy, copy emulation is added.
>> It is required for in-kernel users like fabrics, where file descriptor is
>
>I can understand copy command does help for FS GC and fabrics storages,
>but still not very clear why copy emulation is needed for kernel users,
>is it just for covering both copy command and emulation in single
>interface? Or other purposes?
>
>I'd suggest to add more words about in-kernel users of copy emulation.
>

As you mentioned above, we need a single interface for covering both
copy command and emulation.
This is needed in fabrics cases, as we expose any non copy command
supported target device also as copy capable, so we fallback to emulation
once we recieve copy from host/initator.
Agreed, we will add more description to covey the same info.

>> not available and hence they can't use copy_file_range.
>> Copy-emulation is implemented by reading from source into memory and
>> writing to the corresponding destination asynchronously.
>> Also emulation is used, if copy offload fails or partially completes.
>
>Per my understanding, this kind of emulation may not be as efficient
>as doing it in userspace(two linked io_uring SQEs, read & write with
>shared buffer). But it is fine if there are real in-kernel such users.
>

We do have plans for uring based copy interface in next phase,
once curent series is merged.
With current design we really see the advantage of emulation in fabrics case.

Thank you,
Nitesh Shetty

------zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_26e0b_
Content-Type: text/plain; charset="utf-8"


------zUAFM1k0MeHfMyR4CoO9aTysOnQiUYGsRe6BfqD0GhfqR3ws=_26e0b_--
