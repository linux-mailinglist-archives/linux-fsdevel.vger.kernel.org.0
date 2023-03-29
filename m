Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7546CECEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjC2Pbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjC2Pbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:31:45 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4720B40C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 08:31:42 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230329153140epoutp0477b0e3da876b49d942b41a4a2e394df5~Q7ZicvxHU1740817408epoutp04g
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 15:31:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230329153140epoutp0477b0e3da876b49d942b41a4a2e394df5~Q7ZicvxHU1740817408epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680103900;
        bh=UJUKVfQ/UMYa2jURB4MqD0TrqqmgwmxyPe0j+HVQPTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ExNLJ4EmVbpideHnnONL78STgMxGCbvokJSw7rA7BV3Vkba1imroUv7l+TbMXoYbd
         e8X0P3+o0US1Mq0+DAA9P2fzLnzWR9BBWlvO+pGctaVTttQymIFyJqF8GJM5RGmhK9
         l0UE2l1GQo2JnKVmFQ55mGdSYmPzqA17z0exqhnE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230329153140epcas5p2187b6222977220b478707e4110832287~Q7Zh4Jy120206202062epcas5p2p;
        Wed, 29 Mar 2023 15:31:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PmrBL3fRcz4x9Pp; Wed, 29 Mar
        2023 15:31:38 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.35.55678.AD954246; Thu, 30 Mar 2023 00:31:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230329122332epcas5p18d8fb49860b4f620c83d864f983dc318~Q41RtmV-v3011130111epcas5p1S;
        Wed, 29 Mar 2023 12:23:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230329122332epsmtrp285677189ce45d399a733d85b41537988~Q41Rsdqha1377213772epsmtrp2A;
        Wed, 29 Mar 2023 12:23:32 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-0d-642459da83eb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.61.31821.4CD24246; Wed, 29 Mar 2023 21:23:32 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230329122329epsmtip1d7e903ca9345c0a0898a40661b608708~Q41OSH1Cq1731717317epsmtip1Y;
        Wed, 29 Mar 2023 12:23:28 +0000 (GMT)
Date:   Wed, 29 Mar 2023 17:52:48 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] null_blk: add support for copy offload
Message-ID: <20230329122248.GD11932@green5>
MIME-Version: 1.0
In-Reply-To: <71d9f461-a708-341f-d012-d142086c026e@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc99rX1uTbm8g8VpA2GNqAMEWWrxswMQR8jJxYyMmwMJYQ1+A
        Fdqur1UnGFHEn1OQX0ohAkrmAIFYmZZf4mCAxTG28ENkMmFCtglFfsQtyhhrfbD43+ec7zn3
        3HNOjhB3uiSQCFM1BkavUaZRxDrezU5vH7/RuLdU0ocFEtTQ242jo3nLOKodyyXQdOcCQMVz
        z3G01NePo7bZUj56cKcJQ62X8zFUXduFoZbKeQx1rdgIlN8xDNDUkAlDbaO+qLXNykMDzWUE
        Kv96SoA6CrIxZJk8AlD99FMeujvqih6fOQlQ/3IPfyekBwZ306ZHfQTdZBoT0P2/XufRA31G
        2lxziqBvVB2mWx5kEfTZ7Fl7QM4jPv309hBBn2usAfSNexn0onkTbZ60YdGvx6tDUhilitF7
        MpokrSpVkxxK7Y5JfC9RESSV+cmC0Q7KU6NMZ0KpiKhov8jUNPscKM99yjSj3RWtZFlqe1iI
        Xms0MJ4pWtYQSjE6VZpOrvNnlemsUZPsr2EMb8uk0gCFPfAzdcrMH8U8nVV2oK7wFMgCFVtP
        A5EQknLY8P0SOA3WCZ3IFgDvd1r5nLEA4G/to6vGIoBtAyfxtZSBvFmCE5oBzF20EQ7BiZwE
        MOcnDwfzyM2wfHpKcBoIhQTpC++tCB3u9aQC2r7K4TlycbKPD39oGuQ7BGdyF6xqvQYcLLbH
        l49/x+f4DWgtmeQ5WERGwoIT1QIHu5Be8M7NHszxECRvieA/piKM+10EHFso5nHsDJ/0NAo4
        lsDF2TaC4/2wuvAbgks+BqDpvglwwrswpzf3ZZs4mQpXRur5nN8dFvXWY5z/NXh2aXK1mBha
        Lq2xF7zWULFaYCMc/vvIKtOwOn9odVwvAJyoKwJ5wMP0SnemV+pxvA1WtCwQJvv0cNIVXv1X
        yKE3bGjeXgH4NWAjo2PTkxlWoQvQMPv/X3mSNt0MXh6Kz/sWMDE+598BMCHoAFCIU+vFS8OU
        ykmsUn55kNFrE/XGNIbtAAr7ts7jEpckrf3SNIZEmTxYKg8KCpIHBwbJqA3iraHWJCcyWWlg
        1AyjY/RreZhQJMnCUhfmlz4q871bDcJn/jrY1NUqLdnTv3dzzVhY8Ljt88vdIvWuedeiiFww
        JQ3/1OA2Uui25eKWhM5Qs2iwXiTPdBFoJlwP/2m71Us56+SJ8guWAxsCSzNWLC61E8t1YTPe
        or1hQ1/E2lTPLdOfxGvVj48H2T6OUVe+yMAl+T/Lb+f+2N9UzT5UYVk9x85EvXm9/dnMibDY
        iPodFd2bEnS8uItuYl3U+bLhK6LBuV9CCmbKDrWHj3lVJgf6x4pKE9Ilma77bCUftn9Q5Zp8
        pczcabE8cXc/qjTjxqs+x62/b0tcnmBTGyP37AyISvFWeLzjHhN4YeZQ9reZTtJn8XEjPp4S
        isemKGU+uJ5V/gcPX30/sQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xSYRjHe885HI4W64iWb1ps0M1Zatf1rqVp63K2Plhfu0pxBoYXBmJW
        W2lZlHYh2SqxZnahxK6aRQpdMAU1M2eillor6WYSxWyVFxJZq2//Pb/f/3neDy+F83uIMCo5
        LYNVpolTRGQgcbdGJIh6EjVDMm+gcja62VCHo/3aYRyVdZ8gUV/Nd4BOuX/haLCpGUcWVxEH
        dT66jyHzhQIMlZbVYqi65BuGar39JCqwOgBytukxZHk5B5kt9QRqrTpLomKDk4usugMYMvXm
        AHSj7yuB7C/D0bv8wwA1D9s48ZBpfbGW0b9uIpn7+m4u09xzm2Bam9RMufEIyVRc2sdUd2aT
        zLEDrlHh4GsO8/VBG8kcv2METEXjHsZTLmDKe/uxdRM3BC6TsCnJmawyJi4pUHbx8y7FoZgs
        j/Ming1+zMgDARSkF8FWrYvMA4EUnzYB+PDmHcIPpkDD8BPcn4Nh6cgHrl96C2BhUSXmAwQ9
        Exb3OUcBRZH0HNjopXzjEHox7D96kPD5ON3CgbrK72N+ML0CXjJfA77MG/WL3zzm+Jf+BtDW
        9YLjB0GwvrB37BU4HQk7Rj5hvgM4HQ6vjIwdCKBXQ52mlOvLk+jp8NFdG6YFQfr/2vr/2vp/
        7fMAN4IprEKVKk1VzVcsSGN3RqvEqSp1mjR6e3pqORj7ApGRJmA2uqOtAKOAFUAKF4XwBh0i
        CZ8nEe/azSrTtyrVKazKCsIpQhTKe55Xv5VPS8UZrJxlFazyL8WogLBsLHkbP3b8UndSRvDA
        qx5NXNahz12sV7yj7ENO7G3epoVGy1SNZ0irsT8jr7cMiO0rQ7/sNk1M6AobaqqIyOl1Jsji
        GvrGVdUsjNfZDLHVRaGNBn6n5+nk6to6pz6hIMVxLiLZsdEl3xZ22TO9SqAxk9ulQSMyaYsu
        wt7xwLkoPsiYk+kWyGWy3/I1lgX17lXLo9o3tF1NzDI1TNsxOb3jmMz5cEtu4T2hN/R9TPuN
        pJ+iPWf653qeBdsEe9XGzCPC9e23hK7MxSE/Srne0yV12hKedudVXeJmh2QwWsHIc4Udue0Z
        LsMs4VN7wcdG9ckJRkX+UPeSXHzl7DP78xUiQiUTz4/ElSrxH5nrAAZxAwAA
X-CMS-MailID: 20230329122332epcas5p18d8fb49860b4f620c83d864f983dc318
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118cd0_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084331epcas5p2510ed79d04fe3432c2ec84ce528745c6
References: <20230327084103.21601-1-anuj20.g@samsung.com>
        <CGME20230327084331epcas5p2510ed79d04fe3432c2ec84ce528745c6@epcas5p2.samsung.com>
        <20230327084103.21601-10-anuj20.g@samsung.com>
        <71d9f461-a708-341f-d012-d142086c026e@opensource.wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118cd0_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 29, 2023 at 06:04:49PM +0900, Damien Le Moal wrote:
> On 3/27/23 17:40, Anuj Gupta wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> > 
> > Implementaion is based on existing read and write infrastructure.
> > 
> > Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> > ---
> >  drivers/block/null_blk/main.c     | 94 +++++++++++++++++++++++++++++++
> >  drivers/block/null_blk/null_blk.h |  7 +++
> >  2 files changed, 101 insertions(+)
> > 
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> > index 9e6b032c8ecc..84c5fbcd67a5 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -1257,6 +1257,81 @@ static int null_transfer(struct nullb *nullb, struct page *page,
> >  	return err;
> >  }
> >  
> > +static inline int nullb_setup_copy_read(struct nullb *nullb,
> > +		struct bio *bio)
> > +{
> > +	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
> > +
> > +	memcpy(token->subsys, "nullb", 5);
> > +	token->sector_in = bio->bi_iter.bi_sector;
> > +	token->nullb = nullb;
> > +	token->sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline int nullb_setup_copy_write(struct nullb *nullb,
> > +		struct bio *bio, bool is_fua)
> > +{
> > +	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
> > +	sector_t sector_in, sector_out;
> > +	void *in, *out;
> > +	size_t rem, temp;
> > +	unsigned long offset_in, offset_out;
> > +	struct nullb_page *t_page_in, *t_page_out;
> > +	int ret = -EIO;
> > +
> > +	if (unlikely(memcmp(token->subsys, "nullb", 5)))
> > +		return -EOPNOTSUPP;
> > +	if (unlikely(token->nullb != nullb))
> > +		return -EOPNOTSUPP;
> > +	if (WARN_ON(token->sectors != bio->bi_iter.bi_size >> SECTOR_SHIFT))
> > +		return -EOPNOTSUPP;
> 
> EOPNOTSUPP is strange. These are EINVAL, no ?.
> 
acked, will update in next revision.

> > +
> > +	sector_in = token->sector_in;
> > +	sector_out = bio->bi_iter.bi_sector;
> > +	rem = token->sectors << SECTOR_SHIFT;
> > +
> > +	spin_lock_irq(&nullb->lock);
> > +	while (rem > 0) {
> > +		temp = min_t(size_t, nullb->dev->blocksize, rem);
> > +		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
> > +		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
> > +
> > +		if (null_cache_active(nullb) && !is_fua)
> > +			null_make_cache_space(nullb, PAGE_SIZE);
> > +
> > +		t_page_in = null_lookup_page(nullb, sector_in, false,
> > +			!null_cache_active(nullb));
> > +		if (!t_page_in)
> > +			goto err;
> > +		t_page_out = null_insert_page(nullb, sector_out,
> > +			!null_cache_active(nullb) || is_fua);
> > +		if (!t_page_out)
> > +			goto err;
> > +
> > +		in = kmap_local_page(t_page_in->page);
> > +		out = kmap_local_page(t_page_out->page);
> > +
> > +		memcpy(out + offset_out, in + offset_in, temp);
> > +		kunmap_local(out);
> > +		kunmap_local(in);
> > +		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
> > +
> > +		if (is_fua)
> > +			null_free_sector(nullb, sector_out, true);
> > +
> > +		rem -= temp;
> > +		sector_in += temp >> SECTOR_SHIFT;
> > +		sector_out += temp >> SECTOR_SHIFT;
> > +	}
> > +
> > +	ret = 0;
> > +err:
> > +	spin_unlock_irq(&nullb->lock);
> > +	return ret;
> > +}
> > +
> >  static int null_handle_rq(struct nullb_cmd *cmd)
> >  {
> >  	struct request *rq = cmd->rq;
> > @@ -1267,6 +1342,14 @@ static int null_handle_rq(struct nullb_cmd *cmd)
> >  	struct req_iterator iter;
> >  	struct bio_vec bvec;
> >  
> > +	if (rq->cmd_flags & REQ_COPY) {
> > +		if (op_is_write(req_op(rq)))
> > +			return nullb_setup_copy_write(nullb, rq->bio,
> > +						rq->cmd_flags & REQ_FUA);
> > +		else
> 
> No need for this else.
> 

acked

> > +			return nullb_setup_copy_read(nullb, rq->bio);
> > +	}
> > +
> >  	spin_lock_irq(&nullb->lock);
> >  	rq_for_each_segment(bvec, rq, iter) {
> >  		len = bvec.bv_len;
> > @@ -1294,6 +1377,14 @@ static int null_handle_bio(struct nullb_cmd *cmd)
> >  	struct bio_vec bvec;
> >  	struct bvec_iter iter;
> >  
> > +	if (bio->bi_opf & REQ_COPY) {
> > +		if (op_is_write(bio_op(bio)))
> > +			return nullb_setup_copy_write(nullb, bio,
> > +							bio->bi_opf & REQ_FUA);
> > +		else
> 
> No need for this else.
> 

acked

> > +			return nullb_setup_copy_read(nullb, bio);
> > +	}
> > +
> >  	spin_lock_irq(&nullb->lock);
> >  	bio_for_each_segment(bvec, bio, iter) {
> >  		len = bvec.bv_len;
> > @@ -2146,6 +2237,9 @@ static int null_add_dev(struct nullb_device *dev)
> >  	list_add_tail(&nullb->list, &nullb_list);
> >  	mutex_unlock(&lock);
> >  
> > +	blk_queue_max_copy_sectors_hw(nullb->disk->queue, 1024);
> > +	blk_queue_flag_set(QUEUE_FLAG_COPY, nullb->disk->queue);
> 
> This should NOT be unconditionally enabled with a magic value of 1K sectors. The
> max copy sectors needs to be set with a configfs attribute so that we can
> enable/disable the copy offload support, to be able to exercise both block layer
> emulation and native device support.
> 

acked

> > +
> >  	pr_info("disk %s created\n", nullb->disk_name);
> >  
> >  	return 0;
> > diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> > index eb5972c50be8..94e524e7306a 100644
> > --- a/drivers/block/null_blk/null_blk.h
> > +++ b/drivers/block/null_blk/null_blk.h
> > @@ -67,6 +67,13 @@ enum {
> >  	NULL_Q_MQ	= 2,
> >  };
> >  
> > +struct nullb_copy_token {
> > +	char subsys[5];
> > +	struct nullb *nullb;
> > +	u64 sector_in;
> > +	u64 sectors;
> > +};
> > +
> >  struct nullb_device {
> >  	struct nullb *nullb;
> >  	struct config_item item;
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
> 
Thank you,
Nitesh Shetty

------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118cd0_
Content-Type: text/plain; charset="utf-8"


------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118cd0_--
