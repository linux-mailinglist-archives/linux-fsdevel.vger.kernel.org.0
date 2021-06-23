Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B563B21BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWUXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 16:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWUXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:23:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F91C061574;
        Wed, 23 Jun 2021 13:20:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m15so2109958qvc.9;
        Wed, 23 Jun 2021 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=azW1zX+eO9gp+O2n94OxE29cfxyxIikc6yBHD+EhJ4A=;
        b=gf29hBMTVf7L5OOPMDNSJYasFrvwfKfm1PZKGTqPdKNtDPaNwoRQSGcJQKgrxHeLeJ
         p4H0WfGNvTNtfzVLzUzYtxjfKRGkyowmrZKqMR1yE2z54Zxzl9CBx52zhKRZ7dej2kzm
         LMaRgIUHtM9R1MTmnyNKK6wZkdxouhQDyNBIwr4qFF1rbZRpwqKM+8aAA1qDSM40gKbx
         Y2wL4LfZB/u+ofc7I6hKYF97mh87LyHqIZF1mLoU56AVPtmS8xsHAtnOW1jfmR8KGquJ
         3UUzb1uSgKzjTYVSSU0p9GRfyLc6+Ed99vf2iOFeamhAQtUh8XiBSB+p0dzl5lB1Fbgc
         6j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=azW1zX+eO9gp+O2n94OxE29cfxyxIikc6yBHD+EhJ4A=;
        b=fSep8zVPoUMov4fVEaYavTubI2MCRSRjpGl54TQNCCfnYr6zBc5YxspLPS/O8SpsOn
         mkszfRjqxkESzVhnTug38jq5BVl/NedE2KdC2hBImDk1coam4Vy41KKhrTd2w2A4EUWo
         JT1JuECOrNXDmTaAO2VhYkHpaHznGWBgH7IVAXtEaholEXsMuOLfekcV6RhgyI7aVHyU
         AO4vEdwDK3+QrIXGPG8Qcq0+dnrLoRMdu6czUa++cdaz9SUndmqZLJXIdFzX9g9LVGdc
         uzE00+HqvWNTmbpSVWEz2f8DnuPjnY9nGkIjaBi9st+lG4gt/fGtLRRLrK8ZxbiTjr/d
         2/hg==
X-Gm-Message-State: AOAM5300UA2hw4bCX+CihKwjpEhacEwzr4NHOLfsb85frLGBjLi+npki
        EvTF0eFgATvIza9sbuAg1lM=
X-Google-Smtp-Source: ABdhPJzKwsCpj7QvmWKxfyTmwDTTfJJiUhnXokn6nJJjvZbt1g82Lgenaw4lbAPj0tTRsol40A+dWg==
X-Received: by 2002:a05:6214:5b1:: with SMTP id by17mr1750452qvb.7.1624479654032;
        Wed, 23 Jun 2021 13:20:54 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 206sm697360qke.67.2021.06.23.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:20:53 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Wed, 23 Jun 2021 16:20:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Anton Suvorov <warwish@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 04/10] dm: reduce stack footprint dealing with block
 device names
Message-ID: <YNOXpHyBAD+C3Utt@redhat.com>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
 <20210602152903.910190-5-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602152903.910190-5-warwish@yandex-team.ru>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02 2021 at 11:28P -0400,
Anton Suvorov <warwish@yandex-team.ru> wrote:

> Stack usage reduced (measured with allyesconfig):
> 
> ./drivers/md/dm-cache-target.c	cache_ctr	392	328	-64
> ./drivers/md/dm-cache-target.c	cache_io_hints	208	72	-136
> ./drivers/md/dm-clone-target.c	clone_ctr	416	352	-64
> ./drivers/md/dm-clone-target.c	clone_io_hints	216	80	-136
> ./drivers/md/dm-crypt.c	crypt_convert_block_aead	408	272	-136
> ./drivers/md/dm-crypt.c	kcryptd_async_done	192	56	-136
> ./drivers/md/dm-integrity.c	integrity_metadata	872	808	-64
> ./drivers/md/dm-mpath.c	parse_priority_group	368	304	-64
> ./drivers/md/dm-table.c	device_area_is_invalid	216	80	-136
> ./drivers/md/dm-table.c	dm_set_device_limits	200	72	-128
> ./drivers/md/dm-thin.c	pool_io_hints	216	80	-136
> 
> Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
> ---
>  drivers/md/dm-cache-target.c | 10 ++++------
>  drivers/md/dm-clone-target.c | 10 ++++------
>  drivers/md/dm-crypt.c        |  6 ++----
>  drivers/md/dm-integrity.c    |  4 ++--
>  drivers/md/dm-mpath.c        |  6 ++----
>  drivers/md/dm-table.c        | 34 ++++++++++++++++------------------
>  drivers/md/dm-thin.c         |  8 +++-----
>  7 files changed, 33 insertions(+), 45 deletions(-)
> 

<snip>

> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 20f2510db1f6..d2fec41635ff 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -1781,8 +1781,8 @@ static void integrity_metadata(struct work_struct *w)
>  						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
>  			if (unlikely(r)) {
>  				if (r > 0) {
> -					char b[BDEVNAME_SIZE];
> -					DMERR_LIMIT("%s: Checksum failed at sector 0x%llx", bio_devname(bio, b),
> +					DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
> +						    bio->bi_bdev,
>  						    (sector - ((r + ic->tag_size - 1) / ic->tag_size)));
>  					r = -EILSEQ;
>  					atomic64_inc(&ic->number_of_mismatches);
> diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
> index bced42f082b0..678e5bb0fa5a 100644
> --- a/drivers/md/dm-mpath.c
> +++ b/drivers/md/dm-mpath.c
> @@ -900,10 +900,8 @@ static int setup_scsi_dh(struct block_device *bdev, struct multipath *m,
>  	if (m->hw_handler_name) {
>  		r = scsi_dh_attach(q, m->hw_handler_name);
>  		if (r == -EBUSY) {
> -			char b[BDEVNAME_SIZE];
> -
> -			printk(KERN_INFO "dm-mpath: retaining handler on device %s\n",
> -			       bdevname(bdev, b));
> +			pr_info("dm-mpath: retaining handler on device %pg\n",
> +				bdev);
>  			goto retain;
>  		}
>  		if (r < 0) {

Would appreciate it if you just left the arguments on the same line,
for this dm-mpath.c change and the dm-integrity.c change, don't worry
about 80 column.

Also, would prefer you use DMINFO() instead of pr_info().  DMINFO()
achieves the same but will add "device-mapper: multipath: " prefix for
you, also you then don't need to add the newline. So use:

     DMINFO("retaining handler on device %pg", bdev);


> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 7e88e5e06922..175b9c7b1c48 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -282,20 +281,20 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		return 0;
>  
>  	if (start & (logical_block_size_sectors - 1)) {
> -		DMWARN("%s: start=%llu not aligned to h/w "
> -		       "logical block size %u of %s",
> +		DMWARN("%s: start=%llu not aligned to h/w logical block size %u of %pg",
>  		       dm_device_name(ti->table->md),
>  		       (unsigned long long)start,
> -		       limits->logical_block_size, bdevname(bdev, b));
> +		       limits->logical_block_size,
> +		       bdev);
>  		return 1;
>  	}
>  
>  	if (len & (logical_block_size_sectors - 1)) {
> -		DMWARN("%s: len=%llu not aligned to h/w "
> -		       "logical block size %u of %s",
> +		DMWARN("%s: len=%llu not aligned to h/w logical block size %u of %pg",
>  		       dm_device_name(ti->table->md),
>  		       (unsigned long long)len,
> -		       limits->logical_block_size, bdevname(bdev, b));
> +		       limits->logical_block_size,
> +		       bdev);
>  		return 1;
>  	}
>  

Again, please just leave 'bdev' on the previous lines.

If you make those few tweaks, please add:

Acked-by: Mike Snitzer <snitzer@redhat.com>
