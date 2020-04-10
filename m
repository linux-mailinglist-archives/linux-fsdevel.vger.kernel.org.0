Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D71A42F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 09:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDJHXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 03:23:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJHXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pwGUM0zdAck10dQ3/49UHLyFEOFG8ji5ZKBbl+Vxo6s=; b=VKdxF/N3TYIzZ8sepAsoBcg83n
        Ob4wKA8YvlyH1KYHoHZpsmEq6hDte59CpT3lbwjUivhGQe0UmN5E3RlVnY4nJbzz8VAnedvIKDU4v
        TP0gl+YWattpdSUbLVCIA0MEA14KcL4DU6wmZwwNlfyZRiTCRy+Zcl/VcR0TEEpp4m7msChWynQdL
        dgb6/jAFyolgRetIUA74Q/sEZMEftRk+0AuDrqiXdGOcuXDIzZ/P0Kf/39GL2aXoBeH29xJRHLp4E
        fn4nJH/JNqoLNuWHT28KyI7YKOr7TRIXeTBp/6NbaKSzHchKyaQG5j7j4BnaD60jpD3VnqnofQ4SJ
        SYrF81PA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMo14-0007fC-GD; Fri, 10 Apr 2020 07:23:54 +0000
Date:   Fri, 10 Apr 2020 00:23:54 -0700
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
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200410072354.GB13404@infradead.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165352.2126-8-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
> +
> +	wp_ofst = sdkp->zones_wp_ofst[zno];
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

Maybe I'm a little too clever for my own sake, but what about something
like:

	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
	switch (wp_ofst) {
	case SD_ZBC_INVALID_WP_OFST:
		if (scsi_device_get(sdkp->device)) {
			ret = BLK_STS_IOERR;
			break;
		}
		sdkp->zones_wp_ofst[zno] = SD_ZBC_UPDATING_WP_OFST;
		schedule_work(&sdkp->zone_wp_ofst_work);
		/*FALLTHRU*/
	case SD_ZBC_UPDATING_WP_OFST:
		ret = BLK_STS_DEV_RESOURCE;
		break;
	default:
		wp_ofst = sectors_to_logical(sdkp->device, wp_ofst);
		if (wp_ofst + nr_blocks > sdkp->zone_blocks) {
			ret = BLK_STS_IOERR;
			break;
		}

		*lba += wp_ofst;
	}
	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
	if (ret)
		blk_req_zone_write_unlock(rq);
	return ret;
}

>  	int result = cmd->result;
> @@ -294,7 +543,18 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
>  		 * so be quiet about the error.
>  		 */
>  		rq->rq_flags |= RQF_QUIET;
> +		goto unlock_zone;
>  	}
> +
> +	if (sd_zbc_need_zone_wp_update(rq))
> +		good_bytes = sd_zbc_zone_wp_update(cmd, good_bytes);
> +
> +
> +unlock_zone:

why not use a good old "else if" here?
