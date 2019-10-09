Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05AAD1B84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJIWRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 18:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbfJIWRV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:17:21 -0400
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32AFB206BB;
        Wed,  9 Oct 2019 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570659440;
        bh=K+k72fcp+4Bp9jdYOpjx7BxUtFXIveVOtK1lbT5mR0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S990ZtpDdrW7y3rQw34PT+ReoELxPvgGK9t9BRJhik6B/vPr79r7xOnUltJb2qJKe
         0+mSjjhsfj0ZOXSQsgpK4NbbIhV4KpYb7GHpiW7tzuuNHeVjuIfmB2r68nbBWTHagv
         P3MT4dSOtAuE8NK1D3e+Fb0lKB5A5tetQzLdzU7E=
Date:   Thu, 10 Oct 2019 07:17:16 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 03/12] nvmet: add return value to
  nvmet_add_async_event()
Message-ID: <20191009221716.GD3009@washi1.fujisawa.hgst.com>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-4-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:25:20PM -0600, Logan Gunthorpe wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> Change the return value for nvmet_add_async_event().
> 
> This change is needed for the target passthru code which will
> submit async events on namespaces changes and can fail the command
> should adding the event fail (on -ENOMEM).
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [logang@deltatee.com:
>  * fleshed out commit message
>  * change to using int as a return type instead of bool
> ]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Looks fine, but let's remove the version comments out of commit log if
we're applying this one.

Reviewed-by: Keith Busch <kbusch@kernel.org>

>  drivers/nvme/target/core.c  | 6 ++++--
>  drivers/nvme/target/nvmet.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3a67e244e568..d6dcb86d8be7 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -173,14 +173,14 @@ static void nvmet_async_event_work(struct work_struct *work)
>  	}
>  }
>  
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +int nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>  		u8 event_info, u8 log_page)
>  {
>  	struct nvmet_async_event *aen;
>  
>  	aen = kmalloc(sizeof(*aen), GFP_KERNEL);
>  	if (!aen)
> -		return;
> +		return -ENOMEM;
>  
>  	aen->event_type = event_type;
>  	aen->event_info = event_info;
> @@ -191,6 +191,8 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>  	mutex_unlock(&ctrl->lock);
>  
>  	schedule_work(&ctrl->async_event_work);
> +
> +	return 0;
>  }
>  
>  static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index c51f8dd01dc4..3d313a6452cc 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -441,7 +441,7 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>  		struct nvmet_subsys *subsys);
>  void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>  		struct nvmet_host *host);
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +int nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>  		u8 event_info, u8 log_page);
>  
>  #define NVMET_QUEUE_SIZE	1024
> -- 
> 2.20.1
> 
