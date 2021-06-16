Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ACA3A904A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 06:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhFPEE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 00:04:56 -0400
Received: from verein.lst.de ([213.95.11.211]:52296 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhFPEE4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:04:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A23E468AFE; Wed, 16 Jun 2021 06:02:47 +0200 (CEST)
Date:   Wed, 16 Jun 2021 06:02:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] pstore/blk: Include zone in pstore_device_info
Message-ID: <20210616040247.GD25873@lst.de>
References: <20210615212121.1200820-1-keescook@chromium.org> <20210615212121.1200820-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615212121.1200820-4-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +#define verify_size(name, alignsize, enabled) {				\
> +		long _##name_;						\
> +		if (enabled)						\
> +			_##name_ = check_size(name, alignsize);		\
> +		else							\
> +			_##name_ = 0;					\
> +		/* synchronize visible module parameters to result. */	\
> +		name = _##name_ / 1024;					\
> +		dev->zone.name = _##name_;				\
> +	}

The formatting here looks weird between the two-tab indent and the
opening brace on the macro definition line.

> -	if (!dev || !dev->total_size || !dev->read || !dev->write) {
> +	if (!dev || !dev->zone.total_size || !dev->zone.read || !dev->zone.write) {
>  		if (!dev)
> -			pr_err("NULL device info\n");
> +			pr_err("NULL pstore_device_info\n");
>  		else {
> -			if (!dev->total_size)
> +			if (!dev->zone.total_size)
>  				pr_err("zero sized device\n");
> -			if (!dev->read)
> +			if (!dev->zone.read)
>  				pr_err("no read handler for device\n");
> -			if (!dev->write)
> +			if (!dev->zone.write)
>  				pr_err("no write handler for device\n");
>  		}

This still looks odd to me.  Why not the somewhat more verbose but
much more obvious:

	if (!dev) {
		pr_err("NULL pstore_device_info\n");
		return -EINVAL;
	}
	if (!dev->zone.total_size) {
		pr_err("zero sized device\n");
		return -EINVAL;
	}
	...
		

> -	dev.total_size = i_size_read(I_BDEV(psblk_file->f_mapping->host)->bd_inode);
> +	dev->zone.total_size = i_size_read(I_BDEV(psblk_file->f_mapping->host)->bd_inode);

This is starting to be unreadable long.  A local variable for the inode
might be nice, as that can also be used in the ISBLK check above.

> +	if (!pstore_device_info && best_effort && blkdev[0]) {
> +		struct pstore_device_info *best_effort_dev;
> +
> +		best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
> +		if (!best_effort) {
> +			ret = -ENOMEM;
> +			goto unlock;
> +		}
> +		best_effort_dev->zone.read = psblk_generic_blk_read;
> +		best_effort_dev->zone.write = psblk_generic_blk_write;
> +
> +		ret = __register_pstore_blk(best_effort_dev,
> +					    early_boot_devpath(blkdev));
> +		if (ret)
> +			kfree(best_effort_dev);
> +		else
> +			pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
> +				blkdev, best_effort_dev->zone.total_size);

Maybe split this into a little helper?

> +	/* Unregister and free the best_effort device. */
> +	if (psblk_file) {
> +		struct pstore_device_info *dev = pstore_device_info;
> +
> +		__unregister_pstore_device(dev);
> +		kfree(dev);
> +		fput(psblk_file);
> +		psblk_file = NULL;
>  	}

Same.

> +	/* If we've been asked to unload, unregister any registered device. */
> +	if (pstore_device_info)
> +		__unregister_pstore_device(pstore_device_info);

Won't this double unregister pstore_device_info?

>  struct pstore_device_info {
> -	unsigned long total_size;
>  	unsigned int flags;
> -	pstore_zone_read_op read;
> -	pstore_zone_write_op write;
> -	pstore_zone_erase_op erase;
> -	pstore_zone_write_op panic_write;
> +	struct pstore_zone_info zone;
>  };

Given that flags is only used inside of __register_pstore_device
why not kill this struct and just pass it explicitly?
