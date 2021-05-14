Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7A380E2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhENQ3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 12:29:48 -0400
Received: from verein.lst.de ([213.95.11.211]:51108 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhENQ3s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 12:29:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD8A96736F; Fri, 14 May 2021 18:28:33 +0200 (CEST)
Date:   Fri, 14 May 2021 18:28:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <20210514162833.GA11873@lst.de>
References: <20210512131545.495160-1-hch@lst.de> <20210512131545.495160-13-hch@lst.de> <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me> <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com> <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com> <20210514162612.GA2706199@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514162612.GA2706199@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 09:26:12AM -0700, Keith Busch wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7febdb57f690..d40a9331daf7 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -419,6 +419,11 @@ static void nvme_requeue_work(struct work_struct *work)
>  		 * path.
>  		 */
>  		bio_set_dev(bio, head->disk->part0);
> +
> +		if (bio->bi_opf & REQ_POLLED) {
> +			bio->bi_opf &= ~REQ_POLLED;
> +			bio->bi_cookie = BLK_QC_T_NONE;
> +		}
>  		submit_bio_noacct(bio);
>  	}
>  }
> --
> 
> This should fix the hang since requeued bio's will use an interrupt
> driven queue, but it doesn't fix the warning. The recent commit
> "nvme-multipath: reset bdev to ns head when failover" looks like it
> makes preventing the polling thread from using the non-MQ head disk
> not possible.

Yes.  Althought I'd rather move the code together with the bio stealing
in nvme_failover_req (and possibly move it into a block layer helper
as it is too subtle to be open coded in drivers).
