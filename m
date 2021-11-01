Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804F8441E29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 17:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhKAQbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 12:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232643AbhKAQbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635784124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSSeiEsgy4ZRAwPPYMh123Zf4LHs8XHr2NNVii6Qq7o=;
        b=B/NwU0o58fLXbTMlti+I7ffXdMsWyQ5HnLkEYk1alyJsBxTQFKspG6psJxtmt+6ECOC5cW
        UD4FTDgJwz0+/ryyjycKK5Uxd7cFPD3S0lXeEz7wfNnZFMBl3fcZevgLSMseytbMjfYvhs
        m3nk1wSUGhiPorTh+hc0J/KzjXG1vtw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-pqc7XfgINHSV9dB9sefrRw-1; Mon, 01 Nov 2021 12:28:41 -0400
X-MC-Unique: pqc7XfgINHSV9dB9sefrRw-1
Received: by mail-qk1-f199.google.com with SMTP id bl10-20020a05620a1a8a00b004624f465b6eso10829881qkb.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 09:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSSeiEsgy4ZRAwPPYMh123Zf4LHs8XHr2NNVii6Qq7o=;
        b=b9xN4z3lu3HVkYP1yW7wxH187cr5huHGi6MsKf0AQJvUakJanNK7AzwMztfX7nqAUw
         onCZBKSis0p+ECo3Ehu4CpBfpSqXrlPKUKTPs9TnA9Wkaw45kF541zGmRxFN5e+jCl1g
         Wtcvw1KXrTIlcILmnKK5v3G0x3aEJHy5Ydh+spDbDm//c9ba4BgtjSe9NgLI5eHtoEz7
         e0irVJclvrnZAInHn2y4Wu9aQpUsOF+G0g1/uL+thWbJlT6XabHdR3AojVFFhvt2Tn8A
         BNjvRVceoZM4jJ/ZdcquBnhIw9zAYZUK1UG0qyi/CvXLPmU4+6veuwQOOHHcXWWt40jx
         DZ0g==
X-Gm-Message-State: AOAM531XPFLRNdWLIoTwWtQvHpS8e2krxm4uGMC44DnxLh+T5ytJMCSA
        BodH1Z2iJJwF3veqrmgCKD7oBaSrDpYkHvxaayCaby/OseEa7/QzMxxJZojzYlhsN40q2/RNbU2
        fXS/mjST5IWQqQEu7Ym/cVi/B
X-Received: by 2002:a05:6214:e4a:: with SMTP id o10mr29863859qvc.58.1635784120280;
        Mon, 01 Nov 2021 09:28:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnnToYfIdlwewHO/8stJwOwIrIwZDJizj1Vl7BOinzg8bNzbcfCyJ9R9K4APUV9a9jX59VOw==
X-Received: by 2002:a05:6214:e4a:: with SMTP id o10mr29863844qvc.58.1635784120140;
        Mon, 01 Nov 2021 09:28:40 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u185sm10250817qkd.48.2021.11.01.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:28:39 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:28:38 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 03/11] dax: simplify the dax_device <-> gendisk
 association
Message-ID: <YYAVtv6kiqVHDjQH@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018044054.1779424-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18 2021 at 12:40P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Replace the dax_host_hash with an xarray indexed by the pointer value
> of the gendisk, and require explicitl calls from the block drivers that
> want to associate their gendisk with a dax_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 79737aee516b1..a0a4703620650 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1683,6 +1683,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  	bioset_exit(&md->io_bs);
>  
>  	if (md->dax_dev) {
> +		dax_remove_host(md->disk);
>  		kill_dax(md->dax_dev);
>  		put_dax(md->dax_dev);
>  		md->dax_dev = NULL;
> @@ -1784,10 +1785,11 @@ static struct mapped_device *alloc_dev(int minor)
>  	sprintf(md->disk->disk_name, "dm-%d", minor);
>  
>  	if (IS_ENABLED(CONFIG_FS_DAX)) {
> -		md->dax_dev = alloc_dax(md, md->disk->disk_name,
> -					&dm_dax_ops, 0);
> +		md->dax_dev = alloc_dax(md, &dm_dax_ops, 0);
>  		if (IS_ERR(md->dax_dev))
>  			goto bad;
> +		if (dax_add_host(md->dax_dev, md->disk))
> +			goto bad;
>  	}
>  
>  	format_dev_t(md->name, MKDEV(_major, minor));

Acked-by: Mike Snitzer <snitzer@redhat.com>

