Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF43BCD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbfFJT2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:28:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfFJT2s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:28:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9FFB120D7;
        Mon, 10 Jun 2019 19:28:23 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A734160C47;
        Mon, 10 Jun 2019 19:28:04 +0000 (UTC)
Date:   Mon, 10 Jun 2019 15:28:03 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        mst@redhat.com, jasowang@redhat.com, willy@infradead.org,
        rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org,
        jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com,
        imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com,
        riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com,
        david@redhat.com, david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
        rdunlap@infradead.org
Subject: Re: [PATCH v11 4/7] dm: enable synchronous dax
Message-ID: <20190610192803.GA29002@redhat.com>
References: <20190610090730.8589-1-pagupta@redhat.com>
 <20190610090730.8589-5-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610090730.8589-5-pagupta@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 10 Jun 2019 19:28:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10 2019 at  5:07am -0400,
Pankaj Gupta <pagupta@redhat.com> wrote:

>  This patch sets dax device 'DAXDEV_SYNC' flag if all the target
>  devices of device mapper support synchrononous DAX. If device
>  mapper consists of both synchronous and asynchronous dax devices,
>  we don't set 'DAXDEV_SYNC' flag.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/md/dm-table.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 350cf0451456..c5160d846fe6 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -890,10 +890,17 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
>  			start, len);
>  }
>  
> +static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
> +				       sector_t start, sector_t len, void *data)
> +{
> +	return dax_synchronous(dev->dax_dev);
> +}
> +
>  bool dm_table_supports_dax(struct dm_table *t, int blocksize)
>  {
>  	struct dm_target *ti;
>  	unsigned i;
> +	bool dax_sync = true;
>  
>  	/* Ensure that all targets support DAX. */
>  	for (i = 0; i < dm_table_get_num_targets(t); i++) {
> @@ -906,7 +913,14 @@ bool dm_table_supports_dax(struct dm_table *t, int blocksize)
>  		    !ti->type->iterate_devices(ti, device_supports_dax,
>  			    &blocksize))
>  			return false;
> +
> +		/* Check devices support synchronous DAX */
> +		if (dax_sync &&
> +		    !ti->type->iterate_devices(ti, device_synchronous, NULL))
> +			dax_sync = false;
>  	}
> +	if (dax_sync)
> +		set_dax_synchronous(t->md->dax_dev);
>  
>  	return true;
>  }
> -- 
> 2.20.1
> 

dm_table_supports_dax() is called multiple times (from
dm_table_set_restrictions and dm_table_determine_type).  It is strange
to have a getter have a side-effect of being a setter too.  Overloading
like this could get you in trouble in the future.

Are you certain this is what you want?

Or would it be better to refactor dm_table_supports_dax() to take an
iterate_devices_fn arg and have callers pass the appropriate function?
Then have dm_table_set_restrictions() caller do:

     if (dm_table_supports_dax(t, device_synchronous, NULL))
     	  set_dax_synchronous(t->md->dax_dev);

(NULL arg implies dm_table_supports_dax() refactoring would take a int
*data pointer rather than int type).

Mike
