Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A887A3A9DE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhFPOoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbhFPOoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:44:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6161C061767
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 07:41:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso4155768pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xnm+WYpnOqXtkZdMWzoHLGjqCi4LOFWzGjFsrgoSRP0=;
        b=lrTVnbws/VPuEimwOb3YT0iDmqjnOYczffUh/Kv58vesKqMDTvMYbZJlToeNNPZAhV
         4Xy6XPsxIik88Qh+qEI8tlkRAALocVx3aaCxZj5FXWVdQADSSsTVrzwdmrKGCmfbwngX
         VJ19V7sYPzY2FIe5MofHco2b/0JWT0cVUBZV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xnm+WYpnOqXtkZdMWzoHLGjqCi4LOFWzGjFsrgoSRP0=;
        b=CIr/N35Qe+/J8OZijGkBHtr4sFc3FxPxu412XfrOQG1rLtGLb3KTPKBOnriuuo+qtT
         FJtJxjyBaoxSu6/sS+DSOb5IUpZ4AvWA6cU4rqx9aECd6g9KcInyz4J0+DrOtMHE2aF/
         RaOcxqLxSL/VHZ2g8wDCjrsJGPVeYiRvoq5Ov5NwgzHu92PQaxy7naklcvDrBX+tLmrc
         2TnEkabHsqDALhOA7n+5EZ37jq4bTpS99HrghxSAVuQUbVhs8TUmCEdPGkIuVTzrUh8P
         t7URZ04fMl94j+GB53lMz24Rwjd/PDa4yZ98qOO3eHDWmqNy+H+czmbeEx2WwiAgiXoZ
         ksMQ==
X-Gm-Message-State: AOAM530clFgZNtZ/7Kd3C4qkZdu1otwh/vwfwjXkz/nmmXt6GGqf95+V
        pUSACqTRwSuJqAA05JFzCH6YTA==
X-Google-Smtp-Source: ABdhPJwwUS8UE4ZeWh9OoJ7tApiFkdOVNzxHHc1QvWSodOw2AyXOFizKKx/GS/9aqBotRNv22WlaBQ==
X-Received: by 2002:a17:902:22d:b029:11f:2db4:4c01 with SMTP id 42-20020a170902022db029011f2db44c01mr19568plc.29.1623854514214;
        Wed, 16 Jun 2021 07:41:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm2434305pjr.48.2021.06.16.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:41:53 -0700 (PDT)
Date:   Wed, 16 Jun 2021 07:41:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        gmpy.liaowx@gmail.com, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] pstore/blk: Include zone in pstore_device_info
Message-ID: <202106160737.B0B8882B@keescook>
References: <20210615212121.1200820-1-keescook@chromium.org>
 <20210615212121.1200820-4-keescook@chromium.org>
 <20210616040247.GD25873@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616040247.GD25873@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 06:02:47AM +0200, Christoph Hellwig wrote:
> > +#define verify_size(name, alignsize, enabled) {				\
> > +		long _##name_;						\
> > +		if (enabled)						\
> > +			_##name_ = check_size(name, alignsize);		\
> > +		else							\
> > +			_##name_ = 0;					\
> > +		/* synchronize visible module parameters to result. */	\
> > +		name = _##name_ / 1024;					\
> > +		dev->zone.name = _##name_;				\
> > +	}
> 
> The formatting here looks weird between the two-tab indent and the
> opening brace on the macro definition line.

I can adjust that, sure.

> 
> > -	if (!dev || !dev->total_size || !dev->read || !dev->write) {
> > +	if (!dev || !dev->zone.total_size || !dev->zone.read || !dev->zone.write) {
> >  		if (!dev)
> > -			pr_err("NULL device info\n");
> > +			pr_err("NULL pstore_device_info\n");
> >  		else {
> > -			if (!dev->total_size)
> > +			if (!dev->zone.total_size)
> >  				pr_err("zero sized device\n");
> > -			if (!dev->read)
> > +			if (!dev->zone.read)
> >  				pr_err("no read handler for device\n");
> > -			if (!dev->write)
> > +			if (!dev->zone.write)
> >  				pr_err("no write handler for device\n");
> >  		}
> 
> This still looks odd to me.  Why not the somewhat more verbose but
> much more obvious:
> 
> 	if (!dev) {
> 		pr_err("NULL pstore_device_info\n");
> 		return -EINVAL;
> 	}
> 	if (!dev->zone.total_size) {
> 		pr_err("zero sized device\n");
> 		return -EINVAL;
> 	}
> 	...

Will do.

> > -	dev.total_size = i_size_read(I_BDEV(psblk_file->f_mapping->host)->bd_inode);
> > +	dev->zone.total_size = i_size_read(I_BDEV(psblk_file->f_mapping->host)->bd_inode);
> 
> This is starting to be unreadable long.  A local variable for the inode
> might be nice, as that can also be used in the ISBLK check above.

Fair enough; will change.

> > +	if (!pstore_device_info && best_effort && blkdev[0]) {
> > +		struct pstore_device_info *best_effort_dev;
> > +
> > +		best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
> > +		if (!best_effort) {
> > +			ret = -ENOMEM;
> > +			goto unlock;
> > +		}
> > +		best_effort_dev->zone.read = psblk_generic_blk_read;
> > +		best_effort_dev->zone.write = psblk_generic_blk_write;
> > +
> > +		ret = __register_pstore_blk(best_effort_dev,
> > +					    early_boot_devpath(blkdev));
> > +		if (ret)
> > +			kfree(best_effort_dev);
> > +		else
> > +			pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
> > +				blkdev, best_effort_dev->zone.total_size);
> 
> Maybe split this into a little helper?
> 
> > +	/* Unregister and free the best_effort device. */
> > +	if (psblk_file) {
> > +		struct pstore_device_info *dev = pstore_device_info;
> > +
> > +		__unregister_pstore_device(dev);
> > +		kfree(dev);
> > +		fput(psblk_file);
> > +		psblk_file = NULL;
> >  	}
> 
> Same.

I guess? I don't feel strongly one way or another.

> 
> > +	/* If we've been asked to unload, unregister any registered device. */
> > +	if (pstore_device_info)
> > +		__unregister_pstore_device(pstore_device_info);
> 
> Won't this double unregister pstore_device_info?

No, __unregister_pstore_device() will NULL pstore_device_info.

> 
> >  struct pstore_device_info {
> > -	unsigned long total_size;
> >  	unsigned int flags;
> > -	pstore_zone_read_op read;
> > -	pstore_zone_write_op write;
> > -	pstore_zone_erase_op erase;
> > -	pstore_zone_write_op panic_write;
> > +	struct pstore_zone_info zone;
> >  };
> 
> Given that flags is only used inside of __register_pstore_device
> why not kill this struct and just pass it explicitly?

Because of the mess pstore's internal APIs used to be. :) It's likely
other things will get added here in the future, and I don't want to
have to repeat the kind of argument passing games that used to exist in
this code.

-- 
Kees Cook
