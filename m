Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C83797A54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbjIGRhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbjIGRhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:37:48 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B535A199
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 10:37:25 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230907080925epoutp0414133b8d2fa5f8b856601436515f1ea4~Cj3pUG8Vs0207602076epoutp048
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 08:09:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230907080925epoutp0414133b8d2fa5f8b856601436515f1ea4~Cj3pUG8Vs0207602076epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694074165;
        bh=h8gqoFx6xNIOvMD5d4nEGAFaFhXVokzLtPrZZOAlYAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZlUrBoVoLL4dvsA98AKzuzHGSpCE305ls+m0bjK1BnWnZL/Y816K6haTTsRUtvHXr
         1c014WK47WnWBj1AubImZZ9GYX2GxwbPXv9RPr3HHahTBDE9Sr7F2vFs8RQnUFUDzG
         izeBwTHyBtB5MUdEQgQDVPFri5S5f3f9ePCv2L2I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230907080924epcas5p3c38899748366c9c27ecce9c419bec540~Cj3oiMSin3264132641epcas5p3W;
        Thu,  7 Sep 2023 08:09:24 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RhBjG0bdKz4x9Q0; Thu,  7 Sep
        2023 08:09:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.79.19094.13589F46; Thu,  7 Sep 2023 17:09:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230907071253epcas5p1f5c14bd39502dc980bd22fed521c94d0~CjGSiXLlN2713127131epcas5p1o;
        Thu,  7 Sep 2023 07:12:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230907071253epsmtrp23626d0ed0e460c4c5673ed1cc934dc7b~CjGShgjV01800518005epsmtrp2q;
        Thu,  7 Sep 2023 07:12:53 +0000 (GMT)
X-AuditID: b6c32a50-39fff70000004a96-a4-64f9853158fe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.9C.18916.5F779F46; Thu,  7 Sep 2023 16:12:53 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230907071249epsmtip1209314c69eb6489050c39289ccb1650c~CjGPFXsSQ2992529925epsmtip1M;
        Thu,  7 Sep 2023 07:12:49 +0000 (GMT)
Date:   Thu, 7 Sep 2023 12:39:24 +0530
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
Subject: Re: [PATCH v15 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20230907070924.mtsydl6oqj6uxjql@green245>
MIME-Version: 1.0
In-Reply-To: <d2c3a257-0505-4d3e-ae71-28015952cef6@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUdRTH+e3dx11yl8si9AtK4drEKIEsLctFgVSQbpONUFQjY+Id7h2W
        gX10dzd6zNQKLCiJIsYYi4DkA4F4rYCALNEy8hxxGsSQIbVkmYpAHmNMJtI+wPrvc76/8z3n
        /M5vfigiyRX4oukqHcOqqEyc785t690aGCw1/k2H5v0ZQTQO9SFEdtEKQtT9fJJPzPQuAmKq
        Jx8QlrkyHnGnp4NDdH1bzCFq6q5ziGLrbUDYxkwcwjIRRFTlXeASXZZBLjHaeZZPVF6yCYjq
        /qccYrzIBoiGmYdcYmDCj7i50s/b5U3evNvMJUdv6Elz7TE+eeXCl+S1OwY+ef7EaR5ZmDPH
        JxdsE1zyYfcYnzzRUgvIK8Ofk0vmTaR5apaTIErOiFIwFM2w/owqVU2nq9Ki8bfeTYlNCZeH
        SoOlkUQE7q+ilEw0HrcvITg+PdN+X9z/YypTb5cSKK0W3x4Txar1OsZfodbqonFGQ2dqZJoQ
        LaXU6lVpISpGt0MaGhoWbk88nKFYHc0HmgHJJyWVl4EB1HgUACEKMRk0VY2AAuCOSrAuAM+W
        LvJdwSKAHe1VnGfB4INmzrrlaH0H13XQAWB3Rf2aZRrAnrYj9gBFudjLsLMlxoF8LAgOr6IO
        70YMhwv5VoEjHcGMPPi4btFZ1As7DEcaup0swuSwva9J4GJPOFg6xXWwENsJV6stTt0bexF+
        c/ER4igEsdNCWH7+InA0g1gcHMoNdA3qBf/obxG42BcuzVn4Ls6CNV9f5ru8uQCafjIB18Hr
        0Dh0EnHUQTAFzGt7xSW/BEuGGpyzIZgYFv4ztbYIEWyvWOct8LvGc2v1X4C3l4+sMQkr7o2u
        LWsewK7JPF4R2Gz6391M/7UzOVvsgMfms3ku2Q9WP0VduBU2dm4/B3i1wJfRaJVpTGq4Rhqs
        YrKePXiqWmkGzu+wLaEd1DWthFgBBwVWAFEE3yia2/wXLRHR1KefMaw6hdVnMlorCLc/1SnE
        1ztVbf9PKl2KVBYZKpPL5bLI1+RS/HnRjLGclmBplI7JYBgNw677OKjQ18AR73u7GQj2tA6d
        CbG1hSXR9R9suRQVkMweLa38cNLHK6y149Z7bvPvK8OsXxk9p5Mj71sGDon3q2JyEqU23Uev
        9pXFJ/VmHyi+b4r3g1cf3a32KTq0N1mv5y71Xd0t6XsS4pdYbrix1ONX2TCpiQvbzabn35od
        3Xmm0Bj7/X5NfJXBUGJIOp7wzrLslFA0LVbIH2+4zkZT3b/GjTMH7v2ek4G0f5GxJ1EkEIwH
        ULSP57KZHone1PtbLC3buxzRiXvEzAYpnrBLg7ty39jAFlrM1T8ed09u+8GDeq4XDxAWKHRj
        6fMP3A7+UqOnr2WJlWVvzraIWwPZY6qFEZ7bwaZhnKtVUNJtCKul/gX7fUEDlwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSnO7X8p8pBs8PKFisP3WM2aJpwl9m
        i9V3+9ksXh/+xGjx5EA7o8Xed7NZLW4e2MlksWfRJCaLlauPMllMOnSN0eLp1VlMFntvaVss
        bFvCYrFn70kWi8u75rBZzF/2lN1i+fF/TBY3JjxltFj3+j2LxYlb0hbn/x5ndRD1OH9vI4vH
        5bOlHptWdbJ5bF5S77H7ZgObx+K+yawevc3v2Dw+Pr3F4vF+31U2j74tqxg9Np+u9vi8Sc5j
        05O3TAG8UVw2Kak5mWWpRfp2CVwZDz7tZS/4xV/xsfMxSwPjV54uRk4OCQETiY61O1m6GLk4
        hAS2M0q86J3MApGQlFj29wgzhC0ssfLfc3aIoieMEnu+TWftYuTgYBFQkdi1xQ7EZBPQljj9
        nwOkXERASeJj+yGwcmaBdlaJ/gWvGEESwgIJEufW7WMCsXkFzCR2HNsANfMDo8SX5tusEAlB
        iZMzn4AdwQxUNG/zQ2aQBcwC0hLL/4Et4BSwlvi/fC87iC0qICMxY+lX5gmMgrOQdM9C0j0L
        oXsBI/MqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOBo1grawbhs/V+9Q4xMHIyHGCU4mJVE
        eN/Jf0sR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYBL9
        M2Huixl/Jxhr7Mrp0WN16NocaKLu8sskUuro/X8WE/9V/fjcvZDxtU2hT+6cj71sZW36L3Se
        tjsF/ZoSufDE9Cmf54bwTN9UvyA7rWdJSNCixurT/x9WP241svycZvJDIGOFo5T0YW+t1xMW
        cYZfYE/fon1EYMY7hWxe/cXcfmJpWeGPV926eu9XimtMrj3zKiuG2a5FsdFKr+MnbXj2T/u/
        uOzqGs62NZdq8xYznulrZmX/tP/X6zDJpXfC+Vecn3wiwf7GxTBJpmaHhntSXIdyV5RIuSSf
        45CuaXgccEOoxNZualJOukvam6Vms6O53+cd6sw/njWr5cME7ylHrLt5o0TF0njfXDropMRS
        nJFoqMVcVJwIAMN+l0tVAwAA
X-CMS-MailID: 20230907071253epcas5p1f5c14bd39502dc980bd22fed521c94d0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_cace7_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164303epcas5p1c2d3ec21feac347f0f1d68adc97c61f5
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164303epcas5p1c2d3ec21feac347f0f1d68adc97c61f5@epcas5p1.samsung.com>
        <20230906163844.18754-3-nj.shetty@samsung.com>
        <d2c3a257-0505-4d3e-ae71-28015952cef6@suse.de>
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

------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_cace7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 07/09/23 07:39AM, Hannes Reinecke wrote:
>On 9/6/23 18:38, Nitesh Shetty wrote:
>>We add two new opcode REQ_OP_COPY_SRC, REQ_OP_COPY_DST.
>>Since copy is a composite operation involving src and dst sectors/lba,
>>each needs to be represented by a separate bio to make it compatible
>>with device mapper.
>>We expect caller to take a plug and send bio with source information,
>>followed by bio with destination information.
>>Once the src bio arrives we form a request and wait for destination
>>bio. Upon arrival of destination we merge these two bio's and send
>>corresponding request down to device driver.
>>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>>---
>>  block/blk-core.c          |  7 +++++++
>>  block/blk-merge.c         | 41 +++++++++++++++++++++++++++++++++++++++
>>  block/blk.h               | 16 +++++++++++++++
>>  block/elevator.h          |  1 +
>>  include/linux/bio.h       |  6 +-----
>>  include/linux/blk_types.h | 10 ++++++++++
>>  6 files changed, 76 insertions(+), 5 deletions(-)
>>
>Having two separate bios is okay, and what one would expect.
>What is slightly strange is the merging functionality;
>That could do with some more explanation why this approach was taken.

Combining the two bios is necessary to form a single copy command.
And that's what we do by putting two bios in the single request, and send
this down to the driver.
This helps to avoid putting payload (token) in the request.
This change came as a feedback, as sending payload that is not data to the
device is considered a bad idea [1].
Current approach is similar to bio merging in discard.

>And also some checks in the merging code to avoid merging non-copy 
>offload  bios.
blk_copy_offload_mergable takes care of this, as this checks REQ_OP_COPY_SRC
and REQ_OP_COPY_DST

[1] https://lore.kernel.org/lkml/20230605121732.28468-1-nj.shetty@samsung.com/T/#mfa7104c5f5f8579cd20f668a9d5e83b4ac8bc58a
 
Thank You,
Nitesh Shetty


------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_cace7_
Content-Type: text/plain; charset="utf-8"


------Ax27aEWlRRTyCTKvLJGz44CsYuK4yEI58Kfkn8Ic_yMAot59=_cace7_--
