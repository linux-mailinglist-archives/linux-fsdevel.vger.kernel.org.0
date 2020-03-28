Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A792196496
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 09:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgC1IvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 04:51:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC1IvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fhR7EB9CQwk3ErjlTpRcVRAauXackCeAhtt/aGH2gL8=; b=Sdm4SMSRdWCHbd/PD4zZTd6qAe
        JHTzxZPLHlsdIxdbli64K2/zr6rUQfelIMGuoOy/t+IHt9Xf29/M0SPYezApQeR32YIsQAYK8XIfy
        SxrAv/DSem1vYWJGpJT7mNzpml++9zhOTcM4biEBBGnySi3evXvM82f3VFcB+OnsaHa6ibeNuouiW
        WL1ORgJqs0Cd2o+h4I1O6OgcOQs9eCWFGvdttsb+FT0mueDgPrgFBw8dNJA13CFhvZs70dEXgpmmt
        uvNi40fxygOl1srBQ56woFw1wTzygB5vOfBz01+s6/mM2tB2YbEHeRQUoRxraWZsPJaQVlJoicIrZ
        u2EzPL7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jI7BK-0004kL-C6; Sat, 28 Mar 2020 08:51:06 +0000
Date:   Sat, 28 Mar 2020 01:51:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200328085106.GA22315@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-7-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165012.34443-7-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Since zone reset and finish operations can be issued concurrently with
> writes and zone append requests, ensure a coherent update of the zone
> write pointer offsets by also write locking the target zones for these
> zone management requests.

While they can be issued concurrently you can't expect sane behavior
in that case.  So I'm not sure why we need the zone write lock in this
case.

> +++ b/drivers/scsi/sd.c
> @@ -1215,6 +1215,12 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  	else
>  		protect = 0;
>  
> +	if (req_op(rq) == REQ_OP_ZONE_APPEND) {
> +		ret = sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);
> +		if (ret)
> +			return ret;
> +	}

I'd move this up a few lines to keep all the PI related code together.

> +#define SD_ZBC_INVALID_WP_OFST	~(0u)
> +#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)

Given that this goes into the seq_zones_wp_ofst shouldn't the block
layer define these values?

> +struct sd_zbc_zone_work {
> +	struct work_struct work;
> +	struct scsi_disk *sdkp;
> +	unsigned int zno;
> +	char buf[SD_BUF_SIZE];
> +};

Wouldn't it make sense to have one work_struct per scsi device and batch
updates?  That is also query a decenent sized buffer with a bunch of
zones and update them all at once?  Also given that the other write
pointer caching code is in the block layer, why is this in SCSI?

> +	spin_lock_bh(&sdkp->zone_wp_ofst_lock);
> +
> +	wp_ofst = rq->q->seq_zones_wp_ofst[zno];
> +
> +	if (wp_ofst == SD_ZBC_UPDATING_WP_OFST) {
> +		/* Write pointer offset update in progress: ask for a requeue */
> +		ret = BLK_STS_RESOURCE;
> +		goto err;
> +	}
> +
> +	if (wp_ofst == SD_ZBC_INVALID_WP_OFST) {
> +		/* Invalid write pointer offset: trigger an update from disk */
> +		ret = sd_zbc_update_wp_ofst(sdkp, zno);
> +		goto err;
> +	}
> +
> +	wp_ofst = sectors_to_logical(sdkp->device, wp_ofst);
> +	if (wp_ofst + nr_blocks > sdkp->zone_blocks) {
> +		ret = BLK_STS_IOERR;
> +		goto err;
> +	}
> +
> +	/* Set the LBA for the write command used to emulate zone append */
> +	*lba += wp_ofst;
> +
> +	spin_unlock_bh(&sdkp->zone_wp_ofst_lock);

This seems like a really good use case for cmpxchg.  But I guess
premature optimization is the root of all evil, so let's keep this in
mind for later.

> +	/*
> +	 * For zone append, the zone was locked in sd_zbc_prepare_zone_append().
> +	 * For zone reset and zone finish, the zone was locked in
> +	 * sd_zbc_setup_zone_mgmt_cmnd().
> +	 * For regular writes, the zone is unlocked by the block layer elevator.
> +	 */
> +	return req_op(rq) == REQ_OP_ZONE_APPEND ||
> +		req_op(rq) == REQ_OP_ZONE_RESET ||
> +		req_op(rq) == REQ_OP_ZONE_FINISH;
> +}
> +
> +static bool sd_zbc_need_zone_wp_update(struct request *rq)
> +{
> +	if (req_op(rq) == REQ_OP_WRITE ||
> +	    req_op(rq) == REQ_OP_WRITE_ZEROES ||
> +	    req_op(rq) == REQ_OP_WRITE_SAME)
> +		return blk_rq_zone_is_seq(rq);
> +
> +	if (req_op(rq) == REQ_OP_ZONE_RESET_ALL)
> +		return true;
> +
> +	return sd_zbc_zone_needs_write_unlock(rq);

To me all this would look cleaner with a switch statement:

static bool sd_zbc_need_zone_wp_update(struct request *rq)

	switch (req_op(rq)) {
	case REQ_OP_ZONE_APPEND:
	case REQ_OP_ZONE_FINISH:
	case REQ_OP_ZONE_RESET:
	case REQ_OP_ZONE_RESET_ALL:
		return true;
	case REQ_OP_WRITE:
	case REQ_OP_WRITE_ZEROES:
	case REQ_OP_WRITE_SAME:
		return blk_rq_zone_is_seq(rq);
	default:
		return false;
	}
}

> +	if (!sd_zbc_need_zone_wp_update(rq))
> +		goto unlock_zone;

Split the wp update into a little helper?

> +void sd_zbc_init_disk(struct scsi_disk *sdkp)
> +{
> +	if (!sd_is_zoned(sdkp))
> +		return;
> +
> +	spin_lock_init(&sdkp->zone_wp_ofst_lock);

Shouldn't this lock also go into the block code where the cached
write pointer lives?
