Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D776C427
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 06:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjHBEbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 00:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjHBEbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:31:24 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB81704
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 21:31:20 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230802043118epoutp03055eeefced8ab3c594e47b99f0e117c7~3dq7TQbJu1586515865epoutp03s
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:31:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230802043118epoutp03055eeefced8ab3c594e47b99f0e117c7~3dq7TQbJu1586515865epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690950678;
        bh=Gd76as/DzpDjYh3/r5rRA3x6waAAF+TrgBJUsPlPzNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Av3UfBpm0RHzBTVqQG7+I2QePSBQpK1TX6LNYVQa95m84lD8mXsl1XYsE/ds9go0g
         KL0FHIJE4oXGR2UWm6tQfoPuFd7NCp90VfaLTrqCFsATkN/IommLsPbAqooMOE3fYK
         eCI2TdUwX2MHk90mvdlsymjF9lopJrhdaQZyOYao=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230802043117epcas5p4f65a3af8f58ed9fbd09a0de76a1a6e98~3dq6q3CdP0307103071epcas5p4G;
        Wed,  2 Aug 2023 04:31:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RFzZD00jzz4x9Q8; Wed,  2 Aug
        2023 04:31:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.DF.06099.31CD9C46; Wed,  2 Aug 2023 13:31:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230801131020epcas5p39ed61d99f4711bb3275c06db551abe96~3RG0as1091260612606epcas5p3k;
        Tue,  1 Aug 2023 13:10:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230801131020epsmtrp120d0022b70a61a613b1e6a625a053500~3RG0YTEid1439414394epsmtrp1v;
        Tue,  1 Aug 2023 13:10:20 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-74-64c9dc13528b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.29.34491.C3409C46; Tue,  1 Aug 2023 22:10:20 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230801131015epsmtip2074fb69732b70a6432999c6e507196bd~3RGwMiLU92662426624epsmtip2c;
        Tue,  1 Aug 2023 13:10:15 +0000 (GMT)
Date:   Tue, 1 Aug 2023 18:37:02 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <20230801130702.2taecrgn4v66ehtx@green245>
MIME-Version: 1.0
In-Reply-To: <20230720075050.GB5042@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH/d3bXi5s7a5Fth8PB1azKYbXhPKDlEcicVcwiJI5NpeUht4B
        AqVpy5jTbTyUhwo4ZG7reMhDKLDAKLihlI0ArgME4qowiDCeZkB4OpRB0BUuLP73yTnne545
        JC7QmdmQ0XI1o5RLY4WEBeentgNvO1k+6pC5NqyKUG3nbzhKubqOo+qhHALNtC0BdH3hXxxN
        tKQDZJzgo5Ff/VDz3PdcNNByG0P6klwMVVbfxVBuax9Akw81GGoePIiK08o4SN/cwUHGO/kE
        KiqfNEOX+xsJVGF4jqHWa6kYapxIBqhmZp6Dfh+0ReOXMwDqXTdw0dpKPuFvRxsfBNG3NUNm
        dO9wHYeu1zrSxu4EWleVSdD1ZV/STQNJBF2afY1LZ6XOEfTi5CCHnv/lIUFnN1QBur7rHP1E
        9yatm5jFQqgPY8RRjFTGKB0YeUS8LFoe6SMMCpUclniIXN2c3LyQp9BBLo1jfIQBx0KcjkTH
        mrYjdPhEGptgMoVIVSqhi69YGZ+gZhyi4lVqHyGjkMUq3BXOKmmcKkEe6Sxn1N5urq7veJgC
        w2Oiio2ruGL41U/rV0axJKC1uATMSUi5w/G0x8QlYEEKqCYAKwp7uRsOAbUEYPtoNOt4CmBR
        +7jZtqKmZQ1nHc0APqku2ZI/BnDpVjXYiOJQ+2BqgdEURZIEdRB2vSA3zLsoIZyc7gYb8ThV
        SsDxobHNcpaUN+xuHN3U8igRzK3/A2N5J+z4boKzweamPH+PD212YUXZwW9vLuNsR8PmMDn9
        BMsBsHRBy2HZEk4bGra6toFTOWlbnAgr87SbTUPqAoCafg1gHX7wYmfOZlKcioJ63Z9bgt3w
        684ajLXzYdbaBMbaebCxcJv3wh9qbxAsW8O+Z8nExvCQomGP8TC7oBEAMwc6wVVgr3lpNs1L
        5Vj2hpkLKVyNSY5TtrDiOcniAVh7x+UG4FYBa0ahiotkVB6KQ3Im8f+DR8TH6cDm8zgGNYKx
        kQXnVoCRoBVAEhfu4tmuGWQCnkx69jNGGS9RJsQyqlbgYbrVV7iNVUS86fvkaombu5eru0gk
        cvc6JHITvsGbuVggE1CRUjUTwzAKRrmtw0hzmyQs9f2s0BIrm9CCHz/WLBp+fs1wf0fXktno
        5GxYjstdcWre68II0vAij3v6GxFfa+CHd6/49ZxqX1bz35vi/+V6fvGR/x69ryh4RjYdeKYv
        cn6Hf1naUd7+ujpf3ok1mHWqKX+f2B4k8r08nkFe8v3V8LjgLzyrzt/MLz+pDxsP3m1VmSIQ
        g3dT6sbEMfb6mMYMiaSjedo8oGjNm5wtP5nKe3A25J+2paPa09r1fKvAdZv63KA5OnvlracL
        /mcMnj2DTu6rhbpi348srLPuZWb0LwbM7A0dXjnXtFKql17f33C8+njvnqaUe8wUmXzs0ufp
        RwIlYa98sKC9cuuCk10od+eykKOKkro54kqV9D+VmoMoxQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7bCSvK4Ny8kUgyOHBCzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFpMO
        XWO0eHp1FpPF3lvaFgvblrBY7Nl7ksXi8q45bBbzlz1lt+i+voPNYvnxf0wWhyY3M1nseNLI
        aLHu9XsWixO3pC0ed3cwWpz/e5zV4vePOWwOMh6Xr3h77Jx1l93j/L2NLB6bV2h5XD5b6rFp
        VSebx+Yl9R67bzaweSzum8zq0dv8js3j49NbLB7v911l8+jbsorRY/Ppao/Pm+Q8Nj15yxQg
        EMVlk5Kak1mWWqRvl8CVcWL/Z8aCCVwVSw+dZGlg/MLexcjJISFgIrHuwG/mLkYuDiGB3YwS
        LyZNg0pISiz7e4QZwhaWWPnvOTtE0RNGiWX9K1hAEiwCKhLNcy8DFXFwsAloS5z+zwESFhFQ
        knj66iwjSD2zwHI2iQWXN4ANEhawkji74yEjiM0rYCYxafMlJoihDxglej7dYINICEqcnPkE
        bAEzUNG8zQ/BFjALSEss/we2gBNo14vHd8EOFRWQkZix9CvzBEbBWUi6ZyHpnoXQvYCReRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDK0NLcwbh91Qe9Q4xMHIyHGCU4mJVEeKV/
        H08R4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwLRRRvvt
        jTsc388q2D+55KOQYXOwcfOeS+eM/yRb5P7wKWYtk1VWytf+GyZ0dV6cqJuU2J5DWy7efrTi
        +YRzr2OuXvxpd1ihqNB5oVf1+/9m4epam478m31wguKimAe7VIW9zryOD7K+ELqP137lmauH
        3mowp69yXVK8v0i5c+cx5aTCI/I15g8knt15Xvh2yikB05VLPOwXMk/84np3Qfud10kuF0/8
        T4/4/XrvjAXvZPT0WFvXVh/xXrZ0Uc3B8lkGnd/OWaQbvlZbLfWxl3nb67NTcqSe8VwvXHKo
        e57zR4tj9TuXZJ1T2Nv9vsBL+fO2pc0XH6x7Lf6nq1mn8DhD9valXcYix5O+HFRfc7zslRJL
        cUaioRZzUXEiADYZ85yIAwAA
X-CMS-MailID: 20230801131020epcas5p39ed61d99f4711bb3275c06db551abe96
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_17c6a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
        <20230627183629.26571-4-nj.shetty@samsung.com>
        <20230720075050.GB5042@lst.de>
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

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_17c6a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/07/20 09:50AM, Christoph Hellwig wrote:
>> +static void *blkdev_copy_alloc_buf(sector_t req_size, sector_t *alloc_size,
>> +		gfp_t gfp_mask)
>> +{
>> +	int min_size = PAGE_SIZE;
>> +	void *buf;
>> +
>> +	while (req_size >= min_size) {
>> +		buf = kvmalloc(req_size, gfp_mask);
>> +		if (buf) {
>> +			*alloc_size = req_size;
>> +			return buf;
>> +		}
>> +		/* retry half the requested size */
>> +		req_size >>= 1;
>> +	}
>> +
>> +	return NULL;
>
>Is there any good reason for using vmalloc instead of a bunch
>of distcontiguous pages?
>

kvmalloc seemed convenient for the purpose. 
We will need to call alloc_page in a loop to guarantee discontigous pages. 
Do you prefer that over kvmalloc?

>> +		ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
>> +		if (!ctx)
>> +			goto err_ctx;
>
>I'd suspect it would be better to just allocte a single buffer and
>only have a single outstanding copy.  That will reduce the bandwith
>you can theoretically get, but copies tend to be background operations
>anyway.  It will reduce the required memory, and thus the chance for
>this operation to fail on a loaded system.  It will also dramatically
>reduce the effect on memory managment.
>

Next version will have that change.

Thank You,
Nitesh Shetty

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_17c6a_
Content-Type: text/plain; charset="utf-8"


------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_17c6a_--
