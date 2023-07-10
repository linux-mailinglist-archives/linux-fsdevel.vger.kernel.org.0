Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5274CCE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGJG3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 02:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGJG3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:29:07 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743301A8
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jul 2023 23:29:00 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230710062857epoutp02cab62d1fda7e8d75469e2c96e218507f~wbcFQtyiH1907619076epoutp02f
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 06:28:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230710062857epoutp02cab62d1fda7e8d75469e2c96e218507f~wbcFQtyiH1907619076epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688970537;
        bh=AkcllTXaBBgTvGpp8T6MAgMy3lqiAkEaH53w0AU+zOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aCqCm77vnKI3Sb57gV/tORBkqAOp27/tq1AorR3CCq0AtsstcywQEM5Ndi1mpwPRf
         MutVwrUedylonUAtm7CfSA0eU1QcXI3YOPxuuQ8+8wC4Mbh64Aiz+VShTEGkdcB+aQ
         kx7HFu+fpiQ+mMHdyNCXJ3kX4yFBcERdcozsdAUU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230710062856epcas5p2880af543580e2063d281acd332e97161~wbcEompir0427004270epcas5p2q;
        Mon, 10 Jul 2023 06:28:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QzvGb2Td5z4x9Q7; Mon, 10 Jul
        2023 06:28:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.14.44250.725ABA46; Mon, 10 Jul 2023 15:28:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230710061719epcas5p36b7be425517b0b09d73540b18fc17748~wbR7vCBu91195211952epcas5p3V;
        Mon, 10 Jul 2023 06:17:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230710061719epsmtrp1bebd27292cfbc5654c3251e1e80611db~wbR7t2fVC1310913109epsmtrp1d;
        Mon, 10 Jul 2023 06:17:19 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-96-64aba52792cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.2E.64355.F62ABA46; Mon, 10 Jul 2023 15:17:19 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230710061715epsmtip1965f1b463cf314395eb9ac24b4926cc0~wbR3v5VNB2634026340epsmtip1p;
        Mon, 10 Jul 2023 06:17:15 +0000 (GMT)
Date:   Mon, 10 Jul 2023 11:44:01 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
        djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
        dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <20230710061401.43uzki644sw5jagz@green245>
MIME-Version: 1.0
In-Reply-To: <ZIKphgDavKVPREnw@infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH+d3b3hYZ5gISf+ADcjed4MDWlfJDYC6DmOtwhCmbi1nCOnpH
        EWibPsacMVIY76f4GHSggiDPQaBsAwHHygAFtFuYNBJgMAuLNhPkoSIKoy26/fc553tev3Py
        4+LOXRx3bqxUxSikoniK2MD6sdvL2+fNyjoxr2neATX29+IoueAFjurG8glk7p4D6MLsEo5M
        XekADZk2oomf96POh9+x0d2uNgx1lBdiaKCgHEM1dT0Yai97hKF7o/Mc1LP6D4EK9cMATd3R
        YqhzZDcqS6tgoY7Omyw0dK2EQJeuTnFQtrGVQFV9KxjSn03BUKtJA1CDeYaFboxsQYYXfWy0
        /LSEeNeDHvojjNb+eYug27RjHNow3sSiddXe9NAtNd1cm0nQuorTdPvdJIK+kneWTeemPCTo
        R1MjLHrm+h2CzmupBbRu4CQ937w9wulYXJCEEYkZhScjjZaJY6UxwVTYkaiQKD8hj+/DD0D+
        lKdUlMAEU6GHInwOxMavLYvy/FIUr15zRYiUSmrPO0EKmVrFeEpkSlUwxcjF8XKB3FcpSlCq
        pTG+Uka1j8/j7fVbC/wsTjKgKcLkTx2/KikewZLArw5ZgMuFpACOzLlkgQ1cZ7IdwNkryWyb
        MQdgzfVlziujP28WzwL21oyczEHcJrQBeL/XaBWcyWkAMxY/sTCL3AEXdSssSwuC3A0HVrkW
        9ybSC45UpVtzcbKbA58YilkWwYUMhBNGs7WOIymE2fUGzMZO8GaxyRpjT/rAwccTwMKu5FZY
        VLloLQTJOXs4+ff8+nShsOeqFrOxC3zQ18KxsTu8n5+2zomw5lw1YUv+BkCtUQtswn6Y2p+P
        W6bGSQkcngm2ubfB8/0N1po4uRHmLpvW6zvC1osv+XVY33iZsLEbHH6iWWcaNv32nLBtawWD
        5uUfsALgof3f47T/tdNaW+yDmbPJbJt7C6xa4drQCzZe23MZsGuBGyNXJsQwSj/5XimT+Ore
        0bKEZmD9St7vt4LJiVlfPcC4QA8gF6c2Ocp/qRU7O4pFJ75mFLIohTqeUeqB39qtzuDurtGy
        tb8oVUXxBQE8gVAoFAS8LeRTmx3NqaViZzJGpGLiGEbOKF7mYVx79ySsdGYq91N1JL388cKR
        3oPZ7gsZnP4Wu2ctAceCawsCW9+KvMjmrvIwVkiVUWoXdO40Si2Qbf0w6EEF5jTuOlgtonSB
        C4KsRVMa16xVSwKC83cuOZQ3VxY+X5R8UaSXq/yLPndr1LdFnH+syPn+g8EAu9SyjNLbyyEd
        r9HhodsPjrJ+H50rOZk4tC3mRgN2KezZEl4J+KW5FMPfWRZ5RvfRYXZ2UPqpbz3uaVKO4yeK
        04iJo+7e0dm7Mu1NRr15MHDVkFQhv3D7Df3h5hQwm6n5Kyd9TK6pPz5t7KIivfJDDUen/fm8
        0r7xWKV/1S5TuND1lH3ET+FZZYd2vDc1udmBYiklIr43rlCK/gWa8eSm0wQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCSnG7+otUpBnP36VmsP3WM2aJpwl9m
        i9V3+9ksXh/+xGgx7cNPZosnB9oZLS4/4bN4sN/eYu+72awWNw/sZLLYs2gSk8XpCYuYLFau
        PspksXvhRyaLx3c+s1sc/f+WzWLSoWuMFk+vzmKy2HtL22Jh2xIWiz17T7JYXN41h81i/rKn
        7Bbd13ewWSw//o/J4tDkZiaLHU8aGS3WvX7PYnHilrTF+b/HWS1+/5jD5iDvcfmKt8es+2fZ
        PHbOusvucf7eRhaPzSu0PC6fLfXYtKqTzWPzknqP3Tcb2DwW901m9ehtfsfm8fHpLRaP9/uu
        snn0bVnF6LH5dLXH501yAYJRXDYpqTmZZalF+nYJXBnXTnUzF6ziruhqbGBvYJzA2cXIySEh
        YCLR03mGuYuRi0NIYDujxP97e9kgEpISy/4eYYawhSVW/nvODmILCTxhlJizyAjEZhFQlfi6
        +R9LFyMHB5uAtsTp/xwgYREBTYlby9vBZjILHGeX2LF5BwtIQljAWuLB9ddgM3kFzCS615xn
        gljcxCxx4HgXK0RCUOLkzCdgDcxARfM2P2QGWcAsIC2x/B/YAk4BXYkz3x4wgtiiAjISM5Z+
        ZZ7AKDgLSfcsJN2zELoXMDKvYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAhOI1pBOxiXrf+r
        d4iRiYPxEKMEB7OSCG/BwVUpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NT
        C1KLYLJMHJxSDUzMh+RcBTh2ehzl4HRosmI99OVHYN3f5oS0m1JfDv7ZoOeWq5//6o3VgbIb
        E66/TKi7+lSF52+9gAWfXli8gXBX/Z7Pny9Hxe+WnRKvuT7kU+PNFc3zhN5EuV1LO+z/Wj1r
        J+dNz1XeUgVOdbf0Oo7JzN+0KfvR7fNnOp/nvBQqNV93uMEwOluwUrSR/4PjSffmZU9Yrh02
        POe4e/H0u+pBJ3LOG55k9HylE9T+9DFnm3vEcr0bnk92fHa99c84MjO8e+/M7ftUBR+xSeun
        7Nh62kr/oUiac9gM40n27xrjpb/kbfVYscvqZqbH/phTBcIyf/Re3HDzS3nSkSx2uO7+erP7
        v3daugYtqBOaX6rEUpyRaKjFXFScCACXJ/QPkgMAAA==
X-CMS-MailID: 20230710061719epcas5p36b7be425517b0b09d73540b18fc17748
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_b1f2d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
        <20230605121732.28468-6-nj.shetty@samsung.com>
        <ZH3mjUb+yqI11XD8@infradead.org> <20230606113535.rjbhe6eqlyqk4pqq@green245>
        <ZIAt7vL+/isPJEl5@infradead.org> <20230608120817.jg4xb4jhg77mlksw@green245>
        <ZIKphgDavKVPREnw@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_b1f2d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/06/08 09:24PM, Christoph Hellwig wrote:
>On Thu, Jun 08, 2023 at 05:38:17PM +0530, Nitesh Shetty wrote:
>> Sure, we can do away with subsys and realign more on single namespace copy.
>> We are planning to use token to store source info, such as src sector,
>> len and namespace. Something like below,
>>
>> struct nvme_copy_token {
>> 	struct nvme_ns *ns; // to make sure we are copying within same namespace
>> /* store source info during *IN operation, will be used by *OUT operation */
>> 	sector_t src_sector;
>> 	sector_t sectors;
>> };
>> Do you have any better way to handle this in mind ?
>
>In general every time we tried to come up with a request payload that is
>not just data passed to the device it has been a nightmare.
>
>So my gut feeling would be that bi_sector and bi_iter.bi_size are the
>ranges, with multiple bios being allowed to form the input data, similar
>to how we implement discard merging.
>
>The interesting part is how we'd match up these bios.  One idea would
>be that since copy by definition doesn't need integrity data we just
>add a copy_id that unions it, and use a simple per-gendisk copy I/D
>allocator, but I'm not entirely sure how well that interacts stacking
>drivers.

V13[1] implements that route. Please see if that matches with what you had
in mind?

[1] https://lore.kernel.org/linux-nvme/20230627183629.26571-1-nj.shetty@samsung.com/

Thank you, 
Nitesh Shetty

------RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_b1f2d_
Content-Type: text/plain; charset="utf-8"


------RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_b1f2d_--
