Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD7742157
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 09:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjF2HsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 03:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjF2Hrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:47:32 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD92974
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 00:47:27 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230629074725epoutp04f4eb984576c69e48b61c18bffb6920db~tEadTRYra1869818698epoutp045
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 07:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230629074725epoutp04f4eb984576c69e48b61c18bffb6920db~tEadTRYra1869818698epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688024845;
        bh=bEnyTEmII6xaca+iNsVYjy6viqZWXFnJIZrx7zCVjP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tupVTkRLjt9OJG6Ai4n9BuIh1n2O/ONf7MdlJq7aTy+4COlwk4/+lMeHWY+cpgADU
         g1qasXFmeDm7IxXJRstx+33AVcgdyfES/uecmckX3VoivWz8G0yzB35Lhi3KYuWZtP
         0vY69s+3vCtSzKKNvOMLfAjcQNI/2f+3g3g+fX0M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230629074724epcas5p377d1eca0472f465e4e406badb25c08c4~tEacgdOPQ0843708437epcas5p3w;
        Thu, 29 Jun 2023 07:47:24 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qs9XC1NWkz4x9Q7; Thu, 29 Jun
        2023 07:47:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.62.55173.B073D946; Thu, 29 Jun 2023 16:47:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230628160713epcas5p36c081366246fbaec7e4a0c0f6923b4b1~s3ljk_4D62429624296epcas5p3j;
        Wed, 28 Jun 2023 16:07:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230628160713epsmtrp11aadd144fdb002419decec98bb14c3b9~s3ljigv9V0551805518epsmtrp1R;
        Wed, 28 Jun 2023 16:07:13 +0000 (GMT)
X-AuditID: b6c32a50-e61c07000001d785-59-649d370b7485
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.C2.34491.1BA5C946; Thu, 29 Jun 2023 01:07:13 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230628160702epsmtip232aea2d90a898b8697d094fe374ecf51~s3lZS98o93059830598epsmtip2l;
        Wed, 28 Jun 2023 16:07:01 +0000 (GMT)
Date:   Wed, 28 Jun 2023 21:33:54 +0530
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
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 2/9] block: Add copy offload support infrastructure
Message-ID: <20230628160354.lfzwxyb2i32tkp7d@green245>
MIME-Version: 1.0
In-Reply-To: <e1b0c3d4-1f47-9b12-fdf3-190a9c6b427e@kernel.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHd99rX4uk5PFDuSsTWZlTIPyoFrggCHMGXgbLyNAsc1nwhb5Q
        BrS1LYKyKOJkAgLKjwULCE4Zv1QmuK0yEEZ1/IrBDSkRAxIt6ACpwuYgFVjLg8X/Pud7vufc
        e87N5eMOV3lCfqJcw6jkdLKI2MD5We+x3ds2sFLql2/moqa+33GUdXYJR42jhQSa1s8B9N2L
        RRwZO78FaNBoh8Y7wlD7bDkXPei8iaG274swVN94B0NFXQaAJoa0GGof8UIXsy9zUFt7LwcN
        tlYQqOqHCR7KG9YRqLZ7GUNdxScxpDOeAOjatImDekZc0MBSNxeZFyqIcBdq8H4UdVM7yqMG
        xq5zqJY6T2rwbirV3JBDUC2Xj1O/PsgkqEsFxVwq/+QsQb2cGOFQpltDBFVwowFQLf0Z1Hyz
        K9VsfI7FkAeSQmQMLWVUbow8XiFNlCeEiqJi4z6M8w/wE3uLg1CgyE1OpzChor3RMd4RicmW
        xYjcDtPJqRYphlarRb67Q1SKVA3jJlOoNaEiRilNVkqUPmo6RZ0qT/CRM5pgsZ/fDn+L8WCS
        bLjVXTnplf53XVwmqHTPBTZ8SErglUojNxds4DuQbQA++yOPYIM5AGfL6jA2eAWg6UkJd73k
        +ayOwybaAVy4vcJjg0kAc0z5HKuLQ26FU7fKLMznE6QX7F/hW2UnchssLW4DVj9O5hKwp6px
        tasjGQXra3SrfgEZAOv+XJUFpD3sPW9cbWlD7obDp2eAlTeS78Cymn9wax9IjtjAM6ZJzFoL
        yb1wZdiTvagjnOq+wWNZCP8qzF7jNFhfUkewtd8AqB3WAjYRBk/1FeJWxkkZ1C9UEay+GZb2
        XcNY3Q7mm40Yqwug7sI6u8MrTdVr/reh4d8Ta0zB61oDzi5oHsAnA5d4Z8EW7RvDad84j+Vg
        mPMii6u1zIOTLrB2mc+iB2xq9a0G3AYgZJTqlAQm3l8p9pYzaf8/eLwipRms/hvPGB1o/HHJ
        pwtgfNAFIB8XOQkezpRLHQRS+shRRqWIU6UmM+ou4G95rHO4cGO8wvLx5Jo4sSTITxIQECAJ
        2hkgFjkLxiJzpA5kAq1hkhhGyajW6zC+jTAT20J9cO/LQ65zYt+2odi7o1SYODjW9umx9M2T
        Pac2HTJMFnOKQkp6z3zk+LEr5Ty2v9Bs/ko63j9hSlSdeTZ3NPwAL+jpW5UunTvHIhp2qe30
        +/S954M5sQ4XaLVtesG4XGDe5x5ePJ2CCtoXH3mQj4l85Sdmp6/tuaVJ20Vpsl3vm+mCit/a
        ajx++dSGqXZtSCmpbHETSkY3vcoY0w1r3n08897p5CLFHdvajhFTOS9d7TOIjrw2T7XbJ6A8
        50ah4aHzuOHi5wXHIl5yoyfmf/LauuNR5O3Ac1f1Zl125P1Fl/DjHlmePR3TkUP0vYzlPQc/
        69mf+vqwzbYM+ovolsCOEBFHLaPFnrhKTf8HLnPXj8AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCSvO7GqDkpBvNXy1msP3WM2aJpwl9m
        i9V3+9ksXh/+xGgx7cNPZosnB9oZLS4/4bN4sN/eYu+72awWNw/sZLLYs2gSk8XK1UeZLCYd
        usZo8fTqLCaLvbe0LRa2LWGx2LP3JIvF5V1z2CzmL3vKbtF9fQebxfLj/5gsDk1uZrLY8aSR
        0WLd6/csFiduSVuc/3uc1eL3jzlsDtIel694e+ycdZfd4/y9jSwem1doeVw+W+qxaVUnm8fm
        JfUeu282sHks7pvM6tHb/I7N4+PTWywe7/ddZfPo27KK0WPz6WqPz5vkPDY9ecsUIBDFZZOS
        mpNZllqkb5fAlbF4RiNTwQzNip4F+g2MLxW6GDk5JARMJN6+28HSxcjFISSwm1Hi75K3TBAJ
        SYllf48wQ9jCEiv/PWeHKHrCKLF8yVVWkASLgKrEq30zgLo5ONgEtCVO/+cACYsIqEtMnbyH
        EaSeWaCHTeLWteMsIAlhAW+JlUt3gNXzCphJrLjECjHzM6PEvK5usMW8AoISJ2c+AatnBqqZ
        t/khM0g9s4C0xPJ/YPM5Bewkrne8YQSxRQVkJGYs/co8gVFwFpLuWUi6ZyF0L2BkXsUomVpQ
        nJueW2xYYJiXWq5XnJhbXJqXrpecn7uJEZwktDR3MG5f9UHvECMTB+MhRgkOZiUR3ttvZqcI
        8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYCrj3nZstfa/
        OgmPTvPKJ0vyKottlHgMlnsZy64ovXru1veHrBK22x0ar8euf1ZdKJ34JfQYZ52KUVr24olH
        A2un8zNsinVdxLW57nTXulzXzuPTy6s8us2dFNPzhbd/q0m006gqnXVK4syRtl/VE349eed1
        zqTi38uP9isFyi5E3ipeeC93ymam195f5i5+oPS9cpXvL3OLbTWLrWb7Saeabr0yafaf6+rH
        zxgs9rvGZG6+5lBSwrX16y4rJfxRC9pr1x6oZ9h1721bxvYJnuc+1Yo90O1f8Lj1k47ZpnrL
        mVvPr7+qtuf6ujkGEat2hp/ruBTPNUfuH+sarq/L3ilfb9iwVuDBv9fBnMI7SlcrsRRnJBpq
        MRcVJwIAraR+hIEDAAA=
X-CMS-MailID: 20230628160713epcas5p36c081366246fbaec7e4a0c0f6923b4b1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_961cb_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9@epcas5p4.samsung.com>
        <20230627183629.26571-3-nj.shetty@samsung.com>
        <e1b0c3d4-1f47-9b12-fdf3-190a9c6b427e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_961cb_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/06/28 03:45PM, Damien Le Moal wrote:
>On 6/28/23 03:36, Nitesh Shetty wrote:
>> Introduce blkdev_copy_offload which takes similar arguments as
>> copy_file_range and performs copy offload between two bdevs.
>
>I am confused... I thought it was discussed to only allow copy offload only
>within a single bdev for now... Did I missi something ?
>

Yes, you are right. copy is supported within single bdev only.
We will update this.

>> Introduce REQ_OP_COPY_DST, REQ_OP_COPY_SRC operation.
>> Issue REQ_OP_COPY_DST with destination info along with taking a plug.
>> This flows till request layer and waits for src bio to get merged.
>> Issue REQ_OP_COPY_SRC with source info and this bio reaches request
>> layer and merges with dst request.
>> For any reason, if request comes to driver with either only one of src/dst
>> info we fail the copy offload.
>>
>> Larger copy will be divided, based on max_copy_sectors limit.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  block/blk-core.c          |   5 ++
>>  block/blk-lib.c           | 177 ++++++++++++++++++++++++++++++++++++++
>>  block/blk-merge.c         |  21 +++++
>>  block/blk.h               |   9 ++
>>  block/elevator.h          |   1 +
>>  include/linux/bio.h       |   4 +-
>>  include/linux/blk_types.h |  21 +++++
>>  include/linux/blkdev.h    |   4 +
>>  8 files changed, 241 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 99d8b9812b18..e6714391c93f 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -796,6 +796,11 @@ void submit_bio_noacct(struct bio *bio)
>>  		if (!q->limits.max_write_zeroes_sectors)
>>  			goto not_supported;
>>  		break;
>> +	case REQ_OP_COPY_SRC:
>> +	case REQ_OP_COPY_DST:
>> +		if (!blk_queue_copy(q))
>> +			goto not_supported;
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index e59c3069e835..10c3eadd5bf6 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -115,6 +115,183 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>  }
>>  EXPORT_SYMBOL(blkdev_issue_discard);
>>
>> +/*
>> + * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
>> + * This must only be called once all bios have been issued so that the refcount
>> + * can only decrease. This just waits for all bios to make it through
>> + * blkdev_copy_(offload/emulate)_(read/write)_endio.
>> + */
>> +static ssize_t blkdev_copy_wait_io_completion(struct cio *cio)
>> +{
>> +	ssize_t ret;
>> +
>> +	if (cio->endio)
>> +		return 0;
>> +
>> +	if (atomic_read(&cio->refcount)) {
>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>> +		blk_io_schedule();
>> +	}
>> +
>> +	ret = cio->comp_len;
>> +	kfree(cio);
>> +
>> +	return ret;
>> +}
>> +
>> +static void blkdev_copy_offload_read_endio(struct bio *bio)
>> +{
>> +	struct cio *cio = bio->bi_private;
>> +	sector_t clen;
>> +
>> +	if (bio->bi_status) {
>> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
>> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
>> +	}
>> +	bio_put(bio);
>> +
>> +	if (!atomic_dec_and_test(&cio->refcount))
>> +		return;
>> +	if (cio->endio) {
>> +		cio->endio(cio->private, cio->comp_len);
>> +		kfree(cio);
>> +	} else
>> +		blk_wake_io_task(cio->waiter);
>
>Curly brackets around else missing.
>

Acked.

>> +}
>> +
>> +/*
>> + * __blkdev_copy_offload	- Use device's native copy offload feature.
>> + * we perform copy operation by sending 2 bio.
>> + * 1. We take a plug and send a REQ_OP_COPY_DST bio along with destination
>> + * sector and length. Once this bio reaches request layer, we form a request and
>> + * wait for src bio to arrive.
>> + * 2. We issue REQ_OP_COPY_SRC bio along with source sector and length. Once
>> + * this bio reaches request layer and find a request with previously sent
>> + * destination info we merge the source bio and return.
>> + * 3. Release the plug and request is sent to driver
>> + *
>> + * Returns the length of bytes copied or error if encountered
>> + */
>> +static ssize_t __blkdev_copy_offload(
>> +		struct block_device *bdev_in, loff_t pos_in,
>> +		struct block_device *bdev_out, loff_t pos_out,
>> +		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)
>> +{
>> +	struct cio *cio;
>> +	struct bio *read_bio, *write_bio;
>> +	sector_t rem, copy_len, max_copy_len;
>> +	struct blk_plug plug;
>> +
>> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
>> +	if (!cio)
>> +		return -ENOMEM;
>> +	atomic_set(&cio->refcount, 0);
>> +	cio->waiter = current;
>> +	cio->endio = endio;
>> +	cio->private = private;
>> +
>> +	max_copy_len = min(bdev_max_copy_sectors(bdev_in),
>> +			bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
>
>According to patch 1, this can end up being 0, so the loop below will be infinite.
>

Agreed. As you suggested earlier, once we remove copy_offload parameter
and checking copy_max_sector to identify copy offload capabilty should
solve this.

Thank you,
Nitesh Shetty

------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_961cb_
Content-Type: text/plain; charset="utf-8"


------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_961cb_--
