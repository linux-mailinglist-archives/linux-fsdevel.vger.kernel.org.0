Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6060875EB41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 08:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGXGLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGXGLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:11:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8361B2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 23:11:14 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230724061111epoutp0400c29727443f4a043b2a346b9518746e~0uOkMK-qs2682426824epoutp04C
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 06:11:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230724061111epoutp0400c29727443f4a043b2a346b9518746e~0uOkMK-qs2682426824epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690179071;
        bh=wTF0Ru9o1qX1XpvkpWa3mKHhkbLaktTkpAUnB1hI0DQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pGzoCpXs1UOQ+l3asEdG8DArz1Syln55BBDbmu2SPssX7NAmvlsjNwHBxzcuhQQWj
         CxG6DVMTl+TTlscFhStH+wFX3j38d+bpojDrzobtlpjsDLbIb/Vgr44md4/fUoSJSS
         ySiQqvXB5ZQdS6B1yohx1LRduHCNBtouAz//wb9Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230724061110epcas5p2503ac4c4ac74bf7d8c202484a6932147~0uOjZHrS53020830208epcas5p2e;
        Mon, 24 Jul 2023 06:11:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R8VCc0BLhz4x9QK; Mon, 24 Jul
        2023 06:11:08 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.B5.06099.BF51EB46; Mon, 24 Jul 2023 15:11:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230724054922epcas5p4cdcf4bdb7ddc57eac4d687b40d9633b9~0t7hBWhw70396703967epcas5p4_;
        Mon, 24 Jul 2023 05:49:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230724054922epsmtrp1589ea7b455f628dab9e4898d7d32032a~0t7g8VLIR2266822668epsmtrp1C;
        Mon, 24 Jul 2023 05:49:22 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-66-64be15fb2893
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.24.34491.1E01EB46; Mon, 24 Jul 2023 14:49:21 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230724054918epsmtip2e23bc6255b974fdc88465d963a53ae7e~0t7da5FbA1810118101epsmtip2U;
        Mon, 24 Jul 2023 05:49:18 +0000 (GMT)
Date:   Mon, 24 Jul 2023 11:16:06 +0530
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
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <20230724054606.y6ibtn4mwupmziii@green245>
MIME-Version: 1.0
In-Reply-To: <20230720075710.GC5042@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zTVxTHvb9f+2vBFX8gZBdwSso2Awzk7UVAmRr9GRaHcZGMZWGV/tIy
        oO36QDfH5DFwgjwrwhCEqeO9Eh6RZxmUTAbqWIJUJYOVWdx4isgEBcpaCov/fe73nO+5956T
        w8ZtVCwHdrRITktFvFguYcm41ePi4r5s18n37C4IQHX9t3GUnLOKo5qRbAJN9cwDdGXuJY70
        XRcAGtRbId3PB5B69ioTPepqxVDH9TwMVdX8gqE8jRag8aEiDKmH3dAPaTcZqEPdx0CDbcUE
        Ki0fZ6GMBy0Equg1YEijTMFQiz4JINXUUwb6ddgRDaz2MtHyUjER4kgN3g+lWotGWNTAaD2D
        aqx0pQbvKaiG6osE1XjzPNX+KJGgbmQpmVRmyixBPRsfZlBPO4cIKqupGlCNd85Rzxt2Ug36
        GSyMjIgJEtI8Pi11okVRYn60SBDMDT0ZeSjSz9/Ty90rAO3lOol4cXQw9/AHYe5HomONjeE6
        xfNiFUYpjCeTcffsD5KKFXLaSSiWyYO5tIQfK/GVeMh4cTKFSOAhouX7vDw9vf2MiZ/FCAv/
        XCIkw7Znr313n5kI8q3TgQUbkr5wvqqGSAeWbBuyHcDBxb+ZpoANOQ9getMGvwBQP/r+pqEs
        UwvMBjWA/9TlM8yHJwDmXl7ATVkM8h2YVZxsLMtmE6QbvLPGNsm2JBeOT95bN+PkChN26VQs
        U2A7yYPNhqx15pD+cCzpD4aZrWHf9/p1tjDWaSg2ABPbkTtg4Y//4qZCkNRawIKk2yzz8w7D
        W30GzMzb4WRv04buACey0zb4DKy6XEmYzd8CWPSgCJgDB2Bqf/b6D3BSCMvWcplm/S2Y36/C
        zLoVzFzWb1zAgS3XNtkZ1taVEWa2h9rFpA2m4ETGw41+6QBcUfeycsCuotd+V/TafWbeBy/O
        JRuZbWRHWGFgm9EF1rXtKQPMamBPS2RxAlrmJ/ER0Wf+n3iUOK4BrC+Oa2gL+Es356EBGBto
        AGTjXFuOQNDGt+HweV9+RUvFkVJFLC3TAD/jtHJxB7sosXHzRPJIL98AT19/f3/fAB9/L+6b
        nKnUEr4NKeDJ6RialtDSTR/GtnBIxHCWOm1hx/GVj1+uvfc4jyNICFl0vZB6vEDn9vm2uBsl
        22q5swYifMtC3vmjzhrlifmMsZHcoyFqZFknvxTfXsZrVZ4mXhW7PMyoYTXz8U9P5lSJG3da
        frgQ99yn4OLXuu6+SmX44Ee7I0ruHns79QV/fzbLetoqRNVcypgejZ4OrV7kDBysfKVl2v/+
        jEXqV9sSjukC1bXyptSfRr0jQpQ559asl4IStgi8w8McXGaY7m/s0paf6p2cqAqcU36Rdvrx
        oY69nb9lpxxMKZ/55En41qsK58Ka4Qj+qbOl7wYG7earvHsyhfr4KItL3elHZk4kfTNUX3H9
        rtX82NjWegssSq3iMmRCnpcrLpXx/gMaI2auwQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCSvO5DgX0pBl1frSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFpMO
        XWO0eHp1FpPF3lvaFgvblrBY7Nl7ksXi8q45bBbzlz1lt+i+voPNYvnxf0wWhyY3M1nseNLI
        aLHu9XsWixO3pC3O/z3OavH7xxw2B2mPy1e8PXbOusvucf7eRhaPzSu0PC6fLfXYtKqTzWPz
        knqP3Tcb2DwW901m9ehtfsfm8fHpLRaP9/uusnn0bVnF6LH5dLXH501yHpuevGUKEIjisklJ
        zcksSy3St0vgypi6Yyt7QY9QxZ5nW1kaGB/ydTFyckgImEgs6L3G2MXIxSEksJtR4tG2g2wQ
        CUmJZX+PMEPYwhIr/z1nhyh6wihxe+E2VpAEi4CqRN+cJqAGDg42AW2J0/85QMIiAkoST1+d
        BRvKLNDAJtFz7zVYvbBAosT2f33sIDavgJnEw8Y7LBBDHzBKTJ+3nREiIShxcuYTFhCbGaho
        3uaHzCALmAWkJZb/A1vACbRr05x/YOWiAjISM5Z+ZZ7AKDgLSfcsJN2zELoXMDKvYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIThRamjsYt6/6oHeIkYmD8RCjBAezkghvevquFCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1M83ICDkiefP1R
        w3f+1xd/hGd6HXtQsEm0IlftwdFXJTXxMbynCjoevkpv/Z+yL/fX+Xy3zNBcBsG0c9rfTgTn
        tu9bPWtlULFBbthBSx5H/wPP57FE/GbcvHZ18AOpW1xznmXzXas74aSqV6tVd9Hw7+2bFVKS
        x52Nb87efqBxB+PD6wd9ZJ4uvH7JYEFD/P/UmfP+rHSVi9/za064KZ+SZTqra0rvtpPN7csD
        bv5R2mD9Z9qswDDm3mmJh9XrW9pEufOmPZ2xu5Ct5ayEgUXN8/SOZOb0eXx692fz6so0Xb87
        d1np/yNawmaGBxY1PVBt+le0OjWMbVex1n0R3Q8zvR/fusHw8tZT8yx7ic1CSizFGYmGWsxF
        xYkASAGQ3YMDAAA=
X-CMS-MailID: 20230724054922epcas5p4cdcf4bdb7ddc57eac4d687b40d9633b9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_dd00a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184029epcas5p49a29676fa6dff5f24ddfa5c64e525a51
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184029epcas5p49a29676fa6dff5f24ddfa5c64e525a51@epcas5p4.samsung.com>
        <20230627183629.26571-5-nj.shetty@samsung.com>
        <20230720075710.GC5042@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_dd00a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/07/20 09:57AM, Christoph Hellwig wrote:
>> +/* Copy source offset from source block device to destination block
>> + * device. Returns the length of bytes copied.
>> + */
>> +ssize_t blkdev_copy_offload_failfast(
>> +		struct block_device *bdev_in, loff_t pos_in,
>> +		struct block_device *bdev_out, loff_t pos_out,
>> +		size_t len, gfp_t gfp_mask)
>
>This is an odd and very misnamed interface.
>
>Either we have a klkdev_copy() interface that automatically falls back
>to a fallback (maybe with an opt-out), or we have separate
>blkdev_copy_offload/blkdev_copy_emulated interface and let the caller
>decide.  But none of that really is "failfast".
>
>Also this needs to go into the helpers patch and not a patch that is
>supposed to just wire copying up for block device node.
>
Acked.

>> index b07de77ef126..d27148a2543f 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -1447,7 +1447,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>>  		return -EOVERFLOW;
>>
>>  	/* Shorten the copy to EOF */
>> -	size_in = i_size_read(inode_in);
>> +	size_in = i_size_read(file_in->f_mapping->host);
>
>generic_copy_file_checks needs to be fixed to use ->mapping->host both
>or inode_in and inode_out at the top of the file instead of this
>band aid.  And that needs to be a separate patch with a Fixes tag.
>
Addressed below.

>> @@ -1708,7 +1709,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>>  	/* Don't copy dirs, pipes, sockets... */
>>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>>  		return -EISDIR;
>> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
>> +
>> +	if ((!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode)) &&
>> +		(!S_ISBLK(inode_in->i_mode) || !S_ISBLK(inode_out->i_mode)))
>
>This is using weird indentation, and might also not be doing
>exactly what we want.  I think the better thing to do here is to:
>
> 1) check for the accetable types only on the in inode
> 2) have a check that the mode matches for the in and out inodes
>
>And please do this as a separate prep patch instead of hiding it here.
>
Agreed. We will send a separate patch, that enables copy_file_range on
block devices.

Thank you,
Nitesh Shetty

------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_dd00a_
Content-Type: text/plain; charset="utf-8"


------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_dd00a_--
