Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9481AD79C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgDQHmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 03:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:52670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgDQHmc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:42:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CCB5DAECE;
        Fri, 17 Apr 2020 07:42:29 +0000 (UTC)
Date:   Fri, 17 Apr 2020 09:42:28 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200417074228.jxqk2znfqjfhrwf2@carbon>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
 <20200415090513.5133-5-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415090513.5133-5-johannes.thumshirn@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:05:06PM +0900, Johannes Thumshirn wrote:
> @@ -1206,6 +1219,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  	bool no_tag = false;
>  	int errors, queued;
>  	blk_status_t ret = BLK_STS_OK;
> +	LIST_HEAD(zone_list);
>  
>  	if (list_empty(list))
>  		return false;
> @@ -1264,6 +1278,16 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
>  			blk_mq_handle_dev_resource(rq, list);
>  			break;
> +		} else if (ret == BLK_STS_ZONE_RESOURCE) {
> +			/*
> +			 * Move the request to zone_list and keep going through
> +			 * the dispatch list to find more requests the drive can
> +			 * accept.
> +			 */
> +			blk_mq_handle_zone_resource(rq, &zone_list);
> +			if (list_empty(list))
> +				break;
> +			continue;
>  		}

Stupid question. At the end of this function I see:

	/*
	 * If the host/device is unable to accept more work, inform the
	 * caller of that.
	 */
	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
		return false;

Why is BLK_STS_ZONE_RESOURCE missing?

