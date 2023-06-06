Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491247245A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjFFOTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbjFFOTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:19:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A010EC
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 07:19:15 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230606141912epoutp041b8e2833029a80de7ee8bce8e1f82d2a~mF69xXHC61194011940epoutp04L
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 14:19:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230606141912epoutp041b8e2833029a80de7ee8bce8e1f82d2a~mF69xXHC61194011940epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686061152;
        bh=UOxM1GwH4N78/5VcZmRi0SOFUE4InTqlB4yboWdBops=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PZw1PRsP3Vrqe4rBgl2Q+llmA+X/Y64Mgt62j0rqVIiINQHQz37xv9cTHbe78woTb
         5BxEesBBycF+gggWT9A5ORabSDHqm0HgkJVRO6OoIW9+f+7OZdJFEDgW6HO58kUDBK
         ZFYVIHdSenb57diO3bEYFPfETDlbB5mJcxWAs+jM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230606141911epcas5p3feaf4868278ede2a218037055402778a~mF68ppvKo0226602266epcas5p3G;
        Tue,  6 Jun 2023 14:19:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QbCJt3gbnz4x9Pp; Tue,  6 Jun
        2023 14:19:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.0D.04567.E504F746; Tue,  6 Jun 2023 23:19:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230606113849epcas5p20436fd9c3a47354fc4f5264540cd9887~mDu7kpk5C1243112431epcas5p2V;
        Tue,  6 Jun 2023 11:38:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230606113849epsmtrp1037164b0d5a6cfbe44a01819ba98ed2b~mDu7i-Kls0420604206epsmtrp1I;
        Tue,  6 Jun 2023 11:38:49 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-f9-647f405ec85f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.47.28392.9CA1F746; Tue,  6 Jun 2023 20:38:49 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230606113842epsmtip230b93d2fae8d0d35d5b4cfcfbf869ead~mDu1DVgJ-2435324353epsmtip29;
        Tue,  6 Jun 2023 11:38:42 +0000 (GMT)
Date:   Tue, 6 Jun 2023 17:05:35 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <20230606113535.rjbhe6eqlyqk4pqq@green245>
MIME-Version: 1.0
In-Reply-To: <ZH3mjUb+yqI11XD8@infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1STZRzHz/O+493QZq9c6nGUcN44JtiAGeADSKChvQEVzTpd/gB2tvcw
        AradjYlmHW4KAnJRWycWxEUuAiUIZBNEcURDkYAQCPJCBmgQ90MoKLS50fG/z/P9/b7P7/n9
        fufh4DZX2TxOtCyeUcpEsRSxgXWhzWU7PzwwUeJRnmmHaq//gqOUvCc4qrmdS6DJtnmAvp59
        hKPR1nSA+kY3oZErAahl+lsrNNR6EUOXSk9hqDOvFENVNe0Yai6Zw9BftxbYqH1tikCn9AMA
        jfVrMdQyvAOVpJWx0KWWayzU11RAoKKKMTbKGtQRqNKwiiH96VQM6UaTATo3OcNCHcMOqPuJ
        wQqtPCwgAh3pvpshtPZuF0Ff1N5m0913zrPohrOudF+Xmq6vziDohrJEunkoiaDP5Jy2orNT
        pwl6bmyYRc9c7ifonMZqQDd0HqEX6reGbf40ZreUEUkYpRMjE8sl0bIofyrkQMSbEV7eHgK+
        wAftopxkojjGnwoKDePvj441DotyOiiKVRulMJFKRbm/sVspV8czTlK5Kt6fYhSSWIWnwk0l
        ilOpZVFuMibeV+DhsdPLmBgZIzUMlrIVDQ6HBpYfWiWBKy9kAmsOJD1hT2EFy8Q2ZDOAustv
        ZYINRp4HMD9LA8yHBQCLu/uxdcdEVwZhDjQB2N8+ZMkaB3B5rR2YslikM2w7M2d0cDgEuQN2
        rnFMsh3pAocr03ET42Q1G7auUia2Jf3gyODkU51LesM/0qosvBleyx9lma6xJvlwOPsjk2xP
        vgS/KV/ETWUh+a81LO4xtwDJIFjSfhI3sy2cMDSyzcyDf+emWTgBVn11ljCbjwKoHdQCcyAA
        Hruea3mcFJb0j1v0l6Hm+jnMrG+C2Sujlklwoe67dX4Ffl9bTJh5CxxYSrYwDc/3PLZM6x6A
        bSl6LA84ap9pTvtMPTP7wozZFCutsWmcdICVqxwzusDaJvdiYFUNtjAKVVwUo/JSCGRMwv8L
        F8vj6sHTv+T6tg7cHpl10wOMA/QAcnDKjvtZQKLEhisRHf6cUcojlOpYRqUHXsZdncR59mK5
        8TPK4iMEnj4ent7e3p4+r3sLqBe5r/pfE9uQUaJ4JoZhFIxy3YdxrHlJGHK4eKFWfMc2fJnn
        5yzgCJMNB/bZP256b3DJdwCbC+w3iBxDHgiXeoM9uxf9Auq8KiUYN0WhGj9xaT6O3Lq2Udgb
        Tsn5edJmeye+5uO6LKFPTfmhB7d0E9s60MC+XceL7FM06SNTWWq334lk/s8rFUKe+7bUHu6j
        9B9GkjUn6HcTZB/8s1odmX/0tRs81nxP4dXf9nwZoqZCe9N6/YV2+p2FU6HHfrxboJvR7V3I
        HZ2ua5wUf7gH3P9kY2pZuziHf397/g2NRurc4WbI/fMWCH4nKPL9sKidrUXJVZ0d+MzzB8ti
        vgheFFXcvGc35PTcfuGuw4yj8CdSefwI8WtE3VoYxVJJRQJXXKkS/Qe0f8wY1AQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZdlhJXvekVH2KwYpt8hbrTx1jtmia8JfZ
        YvXdfjaL14c/MVpM+/CT2eLJgXZGi8tP+Cwe7Le32PtuNqvFzQM7mSz2LJrEZHF6wiImi5Wr
        jzJZ7F74kcni8Z3P7BZH/79ls5h06BqjxdOrs5gs9t7StljYtoTFYs/ekywWl3fNYbOYv+wp
        u0X39R1sFsuP/2OyODS5mclix5NGRot1r9+zWJy4JW1x/u9xVovfP+awOch7XL7i7THr/lk2
        j52z7rJ7nL+3kcVj8wotj8tnSz02repk89i8pN5j980GNo/FfZNZPXqb37F5fHx6i8Xj/b6r
        bB59W1Yxemw+Xe3xeZNcgGAUl01Kak5mWWqRvl0CV8afTztYC55KVBx5vZi5gbFbpIuRk0NC
        wETi1dlONhBbSGAHo8SvmxYQcUmJZX+PMEPYwhIr/z1n72LkAqp5wihx9vpeFpAEi4CKxOHF
        H5m6GDk42AS0JU7/5wAJiwhoStxa3s4MUs8ssI5d4uvWa2CDhAWsJR5cfw1m8wqYSdxuW8kM
        MfQRo8T/I8ugEoISJ2c+AVvADFQ0b/NDZpAFzALSEsv/cYCYnAK6Erd6w0EqRAVkJGYs/co8
        gVFwFpLmWUiaZyE0L2BkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJEZxMtLR2MO5Z
        9UHvECMTB+MhRgkOZiUR3l1e1SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnN
        Tk0tSC2CyTJxcEo1MLU+OaWufuTyRoVPCv08vlE7nq07MuF4bcMm/o60vvMlbcm7Pl/1mLd9
        ztH9l+72c6ee+DXFKzvLa+ZxCT/JZIblbzofX2vVkWUO0L/6SClK5h6Xs/ilnIlPQ9XXn3vq
        az1NPSqi7N2O30XznC8Hlk7YfTvg9nRR5xtOV+4Giql2/vgsmRWz+OOxyODJgvZWjS8c5py8
        fTj96Y+iY/HVKw/4199n3rhRdOf3isRqnWVybZllKaqa1/bfevKp3m99aAznpTviSy66L308
        TyX0j4DyhcYmmVbBc4zz9NRN+5Z379TodNuh9HDxt9N7zy5+5bJ37v2m09OYj1kk+FwXNmN1
        bHg75X/8fTv5DyZ9PSFKLMUZiYZazEXFiQAmhJ86lQMAAA==
X-CMS-MailID: 20230606113849epcas5p20436fd9c3a47354fc4f5264540cd9887
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_4db83_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
        <20230605121732.28468-6-nj.shetty@samsung.com>
        <ZH3mjUb+yqI11XD8@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_4db83_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/06/05 06:43AM, Christoph Hellwig wrote:
>>  		break;
>>  	case REQ_OP_READ:
>> -		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
>> +		if (unlikely(req->cmd_flags & REQ_COPY))
>> +			nvme_setup_copy_read(ns, req);
>> +		else
>> +			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
>>  		break;
>>  	case REQ_OP_WRITE:
>> -		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
>> +		if (unlikely(req->cmd_flags & REQ_COPY))
>> +			ret = nvme_setup_copy_write(ns, req, cmd);
>> +		else
>> +			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
>
>Yikes.  Overloading REQ_OP_READ and REQ_OP_WRITE with something entirely
>different brings us back the horrors of the block layer 15 years ago.
>Don't do that.  Please add separate REQ_COPY_IN/OUT (or maybe
>SEND/RECEIVE or whatever) methods.
>

Downside will be duplicating checks which are present for read, write in
block layer, device-mapper and zoned devices.
But we can do this, shouldn't be an issue.

>> +	/* setting copy limits */
>> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, q))
>
>I don't understand this comment.
>

It was a mistake. Comment is misplaced and it should have been
"setting copy flag" instead of "setting copy limits".
Anyway now we feel this comment is redundant, will remove it.
Also, we should have used blk_queue_flag_set to enable copy offload.

>> +struct nvme_copy_token {
>> +	char *subsys;
>> +	struct nvme_ns *ns;
>> +	sector_t src_sector;
>> +	sector_t sectors;
>> +};
>
>Why do we need a subsys token?  Inter-namespace copy is pretty crazy,
>and not really anything we should aim for.  But this whole token design
>is pretty odd anyway.  The only thing we'd need is a sequence number /
>idr / etc to find an input and output side match up, as long as we
>stick to the proper namespace scope.
>

The idea behind subsys is to prevent copy across different subsystem.
For example, copy across nvme subsystem and the scsi subsystem. [1]
At present, we don't support inter-namespace(copy across NVMe namespace),
but after community feedback for previous series we left scope for it.
About idr per namespace, it will be similar to namespace check that
we are doing to prevent copy across namespace.
We went with current structure for token, as it was solving above
issues as well as provides a placeholder for storing source LBA and
number of sectors.
Do have any suggestions on how we can store source info, if we go with
idr based approach ?

[1] https://lore.kernel.org/all/alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com/T/#m407f24fb4454d35c3283a5e51fdb04f1600463af

>> +	if (unlikely((req->cmd_flags & REQ_COPY) &&
>> +				(req_op(req) == REQ_OP_READ))) {
>> +		blk_mq_start_request(req);
>> +		return BLK_STS_OK;
>> +	}
>
>This really needs to be hiden inside of nvme_setup_cmd.  And given
>that other drivers might need similar handling the best way is probably
>to have a new magic BLK_STS_* value for request started but we're
>not actually sending it to hardware.

Sure we will add new BLK_STS_* for completion and move the snippet.

Thank you,
Nitesh Shetty

------JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_4db83_
Content-Type: text/plain; charset="utf-8"


------JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_4db83_--
