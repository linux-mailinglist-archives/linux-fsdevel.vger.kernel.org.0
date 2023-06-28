Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1D74215C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjF2HtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 03:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjF2Hrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:47:35 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1830EA
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 00:47:32 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230629074731epoutp011921c5e04bb517dc45867ad6452955fe~tEaiRjQlP2523425234epoutp01U
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 07:47:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230629074731epoutp011921c5e04bb517dc45867ad6452955fe~tEaiRjQlP2523425234epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688024851;
        bh=ktDHIDFWFuTKWQizhATZ3opFM/42wTLAbJI1J9UNv5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NYZzcEg2EAaZTirFa464ov/GwiHPTu7Zez//Aso8Dw+PnsNkVGBkGukEtBoFKR3wH
         yeAE6qfZkTRRLty1QC3TpyjdimKYJ2goEjqaqwcZuz82+rG/+EHXWLpnqY0086CyRM
         OHVgvia48awF2DQxxtobeNBpakvRTksBJIN9SM1g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230629074730epcas5p1757c69cf1c0b167cb842f822b63f6c4b~tEahfXtAV3101931019epcas5p1h;
        Thu, 29 Jun 2023 07:47:30 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qs9XJ1SDvz4x9Px; Thu, 29 Jun
        2023 07:47:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.62.55173.F073D946; Thu, 29 Jun 2023 16:47:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230628161340epcas5p411a64c804db74c49dc1422826b0e738a~s3rLyhXFJ1535215352epcas5p4W;
        Wed, 28 Jun 2023 16:13:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230628161340epsmtrp2ca5526b17aaf8cbe80823878e6175145~s3rLxYezi1270712707epsmtrp2a;
        Wed, 28 Jun 2023 16:13:40 +0000 (GMT)
X-AuditID: b6c32a50-e61c07000001d785-63-649d370f21f0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.56.64355.43C5C946; Thu, 29 Jun 2023 01:13:40 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230628161336epsmtip24012f214e598ff559a5b000f7979953c~s3rIJcCF83058030580epsmtip2E;
        Wed, 28 Jun 2023 16:13:36 +0000 (GMT)
Date:   Wed, 28 Jun 2023 21:40:31 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <dlemoal@kernel.org>
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
        bvanassche@acm.org, ming.lei@redhat.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <20230628161031.snidi5qcpiffl2bx@green245>
MIME-Version: 1.0
In-Reply-To: <cdd190e3-d510-f4f3-46ee-3570f0317501@kernel.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUdRTH/d3dvVyYlrki6q8FkZYYE+Kxwi4/GFgrUG5hDWbRjOnAyt6A
        gGXbhTRrkkeooLwDcUHA0oBFQR4yvB9LSSwqxFOewrRQk8YiCKYMGHCx/O9zvuec33nNj2CZ
        VBrwiBBZJK2QScL4uBG7um33G3akyyWp48Iwhsq0t1goNnWZhUrGUnD0oG0OoKzZpyykazkD
        UK/OGE0070WNMzkcNNRSi6GGH9IxVFzyC4bSNQMATfWrMNQ4bIsun77CRg2NHWzUW5eLo/yf
        pgzQucEaHBW2r2BIkxGHoRpdDEClD/Rs9OuwGfr93FmAupbbOWjpn1z8LXOqt8+HqlWNGVBd
        4+VsqrLIhuq9E0VVqBNwqvLKKap+KBqnfkzO4FBJcTM49WhqmE3pm/pxKrlKDajKzq+p+QoL
        qkL3N+ZLHg51D6YlUlphScsCI6QhsiAPvs8hf09/ochRYCdwRS58S5kknPbgex3wtdsfEra6
        Hb7ll5KwqFXJV6JU8h3E7oqIqEjaMjhCGenBp+XSMLmz3F4pCVdGyYLsZXSkm8DRcY9wNTAg
        NFh7cYojz7c40ajuwKNBFUwEhgQkneH86T48ERgRJmQDgE8yRjaMOQDbhv7838j+uZn1IiX+
        XhKHcdQCqO/QsBhjGsCllZ71KDZpDR+3FLETAUHgpC3sfE6syabkLpiZ0QDWmEWW47Dn9sk1
        3kK6wTs1k+s6lxTBpvpSnOHNsOOijr3GhqQY9i8mrOtbSXOYfXVho6FhQ1iaeohhL5j57CGb
        4S3wr/YqA4Z5cH6mEWf4OCz+vmh9Mkh+B6BqUAUYx14Yr01hMc0Fw4GZ2xsP7YCZ2lKM0Y1h
        0pIOY3QurMl7wVbwWlnBRoFX4cCTGHxtdkhS8G6vJ7OfeQAHH01zUsFO1UuzqV4qx7AbTJiN
        5ahW01mkGSxcIRjcDcvqHAoARw14tFwZHkQHCuUCOxl9/L+LB0aEV4D132PjWwNKbizbawBG
        AA2ABItvyh15mCM14UolX52kFRH+iqgwWqkBwtVbpbF4WwMjVr+fLNJf4Ozq6CwSiZxdnUQC
        /nbuuHeC1IQMkkTSoTQtpxUv8jDCkBeNfUNY1/XnoT8K/E4luOdYxx2Y97kQ1DRy12aSN6Ft
        CRfPgIO6G/e7F/espHUcSRzL/e3z959qy/0Ob7c4mHMvNsAOn1C/krxPcKlLfX/aQZgX09l8
        zHDyk66YkMK+8dfaL3ykdHrcrRe2bfPfsaAdzRzLzttpfDUn3UX9oXjUIuvto2ZGbifcN1uP
        WsWH9zy/Kaut1oid3IXXRK2zacWfeYtHry838F4v/LSeN7tvTv+em9yXqyduefO43RnnNy2I
        5nZJF8aPpCS9GWCLzrDnBZc/9nLeVGyk57iKF7+NJ/0+SKve/65uW/FRo4HSL9rPdx+zuump
        zDJfaH0WZtr/zvV+0/xWPlsZLBHYsBRKyb8fXSBQxgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCSvK5JzJwUg6fbRS3WnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFpMO
        XWO0eHp1FpPF3lvaFgvblrBY7Nl7ksXi8q45bBbzlz1lt+i+voPNYvnxf0wWhyY3M1nseNLI
        aLHu9XsWixO3pC0ed3cwWpz/e5zV4vePOWwOMh6Xr3h77Jx1l93j/L2NLB6bV2h5XD5b6rFp
        VSebx+Yl9R67bzaweSzum8zq0dv8js3j49NbLB7v911l8+jbsorRY/Ppao/Pm+Q8Nj15yxQg
        EMVlk5Kak1mWWqRvl8CVMe3ZZraCi9IVfftFGhgbxLoYOTkkBEwkWm/0snYxcnEICWxnlFh6
        diUjREJSYtnfI8wQtrDEyn/P2SGKnjBKLPx+mgUkwSKgKvHlwAogm4ODTUBb4vR/DpCwiIC6
        xNTJexhB6pkFNrNJLL21mgkkISxgJXF2x0OwBbwCZhL7dq9jgxj6mVHi2YFnTBAJQYmTM5+A
        LWAGKpq3+SEzyAJmAWmJ5f/AFnAK2Elc/dbJBmKLCshIzFj6lXkCo+AsJN2zkHTPQuhewMi8
        ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4UWgF7WBctv6v3iFGJg7GQ4wSHMxKIry338xO
        EeJNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamBaq/flwrJp
        21uDS+OnbxWYc0N8jm1H8I51rqL7/duM+05P1jdPWRhjPVNjjq1yzjrn5TWlMz59ulSx6OCl
        o1dm3LQ33LzlvMXLudfV5+9PdfI2vuHxKEhh9TSFoNDpGhxTxObaG06wiIo/9kAs8izDq4zv
        0j3X6grmRwoF7uXlTZ7BdWDllCd+em6VUUnxb6/vyZC1i+Se8LRJbL0Nx2PbK9f33g83lvq7
        rWJDnn2QrFOwfUTKtgxvGbfDzFzreb7X3GUQ9zvXv2aWm6D/4cj9LH2blE+sM12kwf/e+WFf
        U5Vy+3zT7AA9Jt5di9Lmsx2u+9pWeOy1DqvI395q9pTrSy1qBW7OdZqqxnmi4agSS3FGoqEW
        c1FxIgAlx8mFgwMAAA==
X-CMS-MailID: 20230628161340epcas5p411a64c804db74c49dc1422826b0e738a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_96484_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
        <20230627183629.26571-4-nj.shetty@samsung.com>
        <cdd190e3-d510-f4f3-46ee-3570f0317501@kernel.org>
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

------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_96484_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/06/28 03:50PM, Damien Le Moal wrote:
>On 6/28/23 03:36, Nitesh Shetty wrote:
>> For the devices which does not support copy, copy emulation is added.
>> It is required for in-kernel users like fabrics, where file descriptor is
>> not available and hence they can't use copy_file_range.
>> Copy-emulation is implemented by reading from source into memory and
>> writing to the corresponding destination asynchronously.
>> Also emulation is used, if copy offload fails or partially completes.
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>  block/blk-lib.c           | 183 +++++++++++++++++++++++++++++++++++++-
>>  block/blk-map.c           |   4 +-
>>  include/linux/blk_types.h |   5 ++
>>  include/linux/blkdev.h    |   3 +
>>  4 files changed, 192 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 10c3eadd5bf6..09e0d5d51d03 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -234,6 +234,180 @@ static ssize_t __blkdev_copy_offload(
>>  	return blkdev_copy_wait_io_completion(cio);
>>  }
>>
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
>
>Kind of obvious :)

Acked. will remove.

>
>> +		req_size >>= 1;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static void blkdev_copy_emulate_write_endio(struct bio *bio)
>> +{
>> +	struct copy_ctx *ctx = bio->bi_private;
>> +	struct cio *cio = ctx->cio;
>> +	sector_t clen;
>> +
>> +	if (bio->bi_status) {
>> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
>> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
>> +	}
>> +	kfree(bvec_virt(&bio->bi_io_vec[0]));
>> +	bio_map_kern_endio(bio);
>> +	kfree(ctx);
>> +	if (atomic_dec_and_test(&cio->refcount)) {
>> +		if (cio->endio) {
>> +			cio->endio(cio->private, cio->comp_len);
>> +			kfree(cio);
>> +		} else
>> +			blk_wake_io_task(cio->waiter);
>
>Curly brackets.
>
acked

>> +	}
>> +}
>> +
>> +static void blkdev_copy_emulate_read_endio(struct bio *read_bio)
>> +{
>> +	struct copy_ctx *ctx = read_bio->bi_private;
>> +	struct cio *cio = ctx->cio;
>> +	sector_t clen;
>> +
>> +	if (read_bio->bi_status) {
>> +		clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT) -
>> +						cio->pos_in;
>> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
>> +		kfree(bvec_virt(&read_bio->bi_io_vec[0]));
>> +		bio_map_kern_endio(read_bio);
>> +		kfree(ctx);
>> +
>> +		if (atomic_dec_and_test(&cio->refcount)) {
>> +			if (cio->endio) {
>> +				cio->endio(cio->private, cio->comp_len);
>> +				kfree(cio);
>> +			} else
>> +				blk_wake_io_task(cio->waiter);
>
>Same.

acked

>
>> +		}
>> +	}
>> +	schedule_work(&ctx->dispatch_work);
>
>ctx may have been freed above.

acked, will fix this.

>
>> +	kfree(read_bio);
>> +}
>> +
>> +static void blkdev_copy_dispatch_work(struct work_struct *work)
>> +{
>> +	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
>> +			dispatch_work);
>
>Please align the argument, or even better: split the line after "=".


acked.

Thank you
Nitesh Shetty

------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_96484_
Content-Type: text/plain; charset="utf-8"


------PcSJ1RlEyPKfjXIiTsweH-7MCPtMf9v3nlMrb72LWO-fIHxy=_96484_--
