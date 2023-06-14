Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71A72FF0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbjFNMuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 08:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244741AbjFNMuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:50:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6CA1FF9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 05:50:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230614125008euoutp021a9850fdd4a0baf5f0a3fda10f32c3d3~oh3e2Xslr0523005230euoutp02J
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 12:50:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230614125008euoutp021a9850fdd4a0baf5f0a3fda10f32c3d3~oh3e2Xslr0523005230euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686747008;
        bh=x4HzTa9SIIp6LPrxayFrjz8ZFMGQT5wN+9HpYQnRahM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Faj0RzZzsJeMlG3BJe529tJ9SckRG1vi6C5DJyXnjBld3dibpaoITHwLw8UcmlGqa
         d1xWDUijtHGi1haTRAee/9Wf6+35cfNIyIAB7TSlhhE0qVLfJjPXSHMyURa3pTZjf/
         WTnNadaZ3AY/QY/c6iBUDfDTXpAPityFfoqd/d9Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230614125008eucas1p20c39cf30d53d3efa811bc89abe7acff6~oh3elDT4i0306303063eucas1p2f;
        Wed, 14 Jun 2023 12:50:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E0.47.37758.087B9846; Wed, 14
        Jun 2023 13:50:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230614125007eucas1p17dc48775a66fa68597a132faeb95b866~oh3eNiRFy1157611576eucas1p1T;
        Wed, 14 Jun 2023 12:50:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230614125007eusmtrp2aa949ec9804b7f6452ea01de88513077~oh3eM6vy30505005050eusmtrp2u;
        Wed, 14 Jun 2023 12:50:07 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-40-6489b78028b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 32.88.10549.F77B9846; Wed, 14
        Jun 2023 13:50:07 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230614125007eusmtip18a9c0616eb607c1eb0b072c3cb20381d~oh3d_-VxJ1306813068eusmtip1G;
        Wed, 14 Jun 2023 12:50:07 +0000 (GMT)
Received: from [172.17.167.92] (106.210.248.64) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 14 Jun 2023 13:50:06 +0100
Message-ID: <25657702-19a7-6523-21bd-c671935c2c2e@samsung.com>
Date:   Wed, 14 Jun 2023 14:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH 1/7] brd: use XArray instead of radix-tree to index
 backing pages
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.de>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Luis Chamberlain" <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZIm2fqesAKAHHh5j@casper.infradead.org>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.64]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87oN2ztTDP61C1vMWb+GzWLPoklM
        FitXH2Wy2HtL22LP3pMsFjcmPGW0+P1jDpsDu8fmFVoem1Z1snmcmPGbxWP3zQY2j82nqz0+
        b5ILYIvisklJzcksSy3St0vgyri68zpzwVzWiisb1zE3MDazdDFyckgImEj83NrO3MXIxSEk
        sIJRYvGVjYwQzhdGiZbG/0wQzmdGiZ339jHDtMzb9RDMFhJYzijx+LsoXNHrmSfZIBK7GCUW
        rFIBsXkF7CT6/pxkArFZBFQl2hYsZ4KIC0qcnPkE7A5RgWiJ1mX3wXqFBcIltuy9A2YzC4hL
        3HoyH6xeRMBD4v+l5SwQ8d2MElde6nQxcnCwCWhJNHayg4Q5gW5bOm0DM0SJvMT2t3OgblaS
        OL7jOpRdK3Fqyy2wxyQEmjklVmzsYYRIuEisOTQRGi7CEq+Ob2GHsGUk/u+EuEFCoFri6Y3f
        zBDNLYwS/TvXs4EcISFgLdF3JgfEZBbQlFi/Sx8i6ijxdI06hMknceOtIMRlfBKTtk1nnsCo
        OgspHGYh+XcWkgdmIcxcwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzAFnf53/OsO
        xhWvPuodYmTiYDzEKMHBrCTC+1SjPUWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTE
        ktTs1NSC1CKYLBMHp1QDk/7kjuXt7bdEHvu2LZwyWeC8xWY1K+am4tObCr/5TPq+6uCD0K1N
        pzlYnfcqbNSc9vTF7fuZBvt5j/FXVNS5Pp0gp/J1jvf6B5rnlG6FxDYF5jhxXyrVuHHkhU1L
        fs0U++cTUhLU3lani/Rof2uczv35d5rOxt53jbINsrKPrPivca7dZ/N8yizZ09vfK3z/Wp0a
        rJsj1Oyz7OOJqI9Vydqx275d1Pm/xpKtQ9Thu/6GBcabLx7gbIxjLPHRdXsoGVN7aI9VgYVD
        /Px7rIGKYnvVZlheU32Ufvpt4QGpxKL9Na1lUn+n/D6gwRek/5dhqeWdt/NuxC9eaWbwTMvf
        O7hxw5wqt/WT1m9k7LETV2Ipzkg01GIuKk4EAPwhnu2wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7r12ztTDDrum1jMWb+GzWLPoklM
        FitXH2Wy2HtL22LP3pMsFjcmPGW0+P1jDpsDu8fmFVoem1Z1snmcmPGbxWP3zQY2j82nqz0+
        b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y7i68zpzwVzWiisb1zE3MDazdDFyckgImEjM2/WQuYuRi0NIYCmjxN0Xb6ASMhIbv1xlhbCF
        Jf5c62KDKPrIKLHw6AGojl2MEvc/T2cGqeIVsJPo+3OSCcRmEVCVaFuwnAkiLihxcuYTsKmi
        AtESqz9fAJsqLBAusWXvHTYQm1lAXOLWk/lg9SICHhL/Ly1ngYjvZpS48lIHYtl1RokFz5ax
        dzFycLAJaEk0drKD1HACvbB02gZmiHpNidbtv9khbHmJ7W/nMEN8oCRxfMd1KLtW4vPfZ4wT
        GEVnITlvFpIzZiEZNQvJqAWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY3jbsZ+bdzDO
        e/VR7xAjEwfjIUYJDmYlEd6nGu0pQrwpiZVVqUX58UWlOanFhxhNgWE0kVlKNDkfmETySuIN
        zQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYZISstB7Kb/x4LCG6XUdg
        W9rU1/6JASc934htNjKf0Dbr76sk26fXjqza+XL5Ll2+teaBDP0Hai3Tzv2dFKuaf33hbY52
        ncUzJ9eYbbrUWTFz0U2eh6kTb+o5tC7ecTHvQOexvDm7L87cJZgiM3l3vPxvrd+SXGox4Sr2
        YV8kOtLN9zWu7ohftutElty37723rJ/WhLe3OKUu0fu3Q6TE9mnqiWm7C0UWmxpbb2Nln/Hl
        mghfp7r+j80RgZoRHbsOiWhkMPw9H/5HO0hg77f7mfltbcqXO610dXbvfHdwSov3Kb+486bu
        n6cLMipFF/Cvqb2twhOfyb43qybk/DypFs76qcJLWdw3CvPL37dRYinOSDTUYi4qTgQAgQlo
        JmoDAAA=
X-CMS-MailID: 20230614125007eucas1p17dc48775a66fa68597a132faeb95b866
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230614124605eucas1p13e57b1da46266467a71f124e40ab8252
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230614124605eucas1p13e57b1da46266467a71f124e40ab8252
References: <20230614114637.89759-1-hare@suse.de>
        <20230614114637.89759-2-hare@suse.de>
        <CGME20230614124605eucas1p13e57b1da46266467a71f124e40ab8252@eucas1p1.samsung.com>
        <ZIm2fqesAKAHHh5j@casper.infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>  
>> -		/*
>> -		 * It takes 3.4 seconds to remove 80GiB ramdisk.
>> -		 * So, we need cond_resched to avoid stalling the CPU.
>> -		 */
>> -		cond_resched();
>> +	xa_for_each(&brd->brd_pages, idx, page) {
>> +		__free_page(page);
>> +		cond_resched_rcu();
> 
> This should be a regular cond_resched().  The body of the loop is run
> without the RCU read lock held.  Surprised none of the bots have noticed
> an unlock-underflow.  Perhaps they don't test brd ;-)
> 
> With that fixed,
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This patch is already queued up for 6.5 in Jens's tree.
I will send this as a fix soon. Thanks.
