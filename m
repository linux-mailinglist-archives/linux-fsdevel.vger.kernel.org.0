Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0A1F423F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgFIR33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 13:29:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40096 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgFIR3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:29:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so9049312pfh.7;
        Tue, 09 Jun 2020 10:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0OeLiDypwAI4S3gVXdOOM121C3htVuuP9lkSYSY9yfg=;
        b=RlEHJkeRXtywvGPDC2901D5+20ddROqtNsY1+h6j4oCsAD8B2yZ8ZMLxEk1LJ+ejDr
         XQTtNkyV616jPCRlFAJlZAMQvbYXr0VV8SmAee12gNYtv+u/ALuo2rU9HxYZF1WYaITe
         A0xVukhidYppLX+3scVcgxo2fhPm6v2XvhZsTYoWPu6IYNJA9BwOkB7cHRmxgR2a4Mt1
         HbGeGw+BnBj6Y2ju5/L8pZdtMzivjVyIozFOlo0jyO/iXq/baLZVK/PxwBjW9ygtCuWp
         GKMPJ/BaBZWjpHR5TLEa9sJyx9aCKO6P9RwsXF9vlr9ZpDipxqYwo4ZrmiXZCf2lz/o4
         6SZA==
X-Gm-Message-State: AOAM532N54heaMk5CedKpQQGJh/MO/nKGHq5b100oVHyIPsirBRpi04s
        qERC61kANPDlmRe/8iqNYNA=
X-Google-Smtp-Source: ABdhPJw7qyoggD4kTRMCmpjIgC5B/C5Ow+WGPUmYCS78BMRrwophWg5IQ1YAU2QskReoNULrHSPqYA==
X-Received: by 2002:a63:f502:: with SMTP id w2mr25064936pgh.321.1591723764725;
        Tue, 09 Jun 2020 10:29:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n1sm10777379pfd.156.2020.06.09.10.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:29:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7D342403AB; Tue,  9 Jun 2020 17:29:22 +0000 (UTC)
Date:   Tue, 9 Jun 2020 17:29:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200609172922.GP11244@42.do-not-panic.com>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609150602.GA7111@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I like this, more below.

On Tue, Jun 09, 2020 at 08:06:02AM -0700, Christoph Hellwig wrote:
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 432fa60e7f8808..44239f603379d5 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -492,34 +493,23 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	 */
>  	strreplace(buts->name, '/', '_');
>  
> -	/*
> -	 * We have to use a partition directory if a partition is being worked
> -	 * on. The same request_queue is shared between all partitions.
> -	 */
> -	if (bdev && bdev != bdev->bd_contains) {
> -		dir = bdev->bd_part->debugfs_dir;
> -	} else if (IS_ENABLED(CONFIG_CHR_DEV_SG) &&
> -		   MAJOR(dev) == SCSI_GENERIC_MAJOR) {
> +	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
> +	if (!bt)
> +		return -ENOMEM;
> +
> +	if (unlikely(!bdev)) {
>  		/*
> -		 * scsi-generic exposes the request_queue through the /dev/sg*
> -		 * interface but since that uses a different path than whatever
> -		 * the respective scsi driver device name may expose and use
> -		 * for the request_queue debugfs_dir. We have a dedicated
> -		 * dentry for scsi-generic then.
> +		 * When tracing something that is not a block device (e.g. the
> +		 * /dev/sg nodes), create debugfs directory on demand.  This
> +		 * directory will be remove when stopping the trace.

Is scsi-generic is the only unwanted ugly child blktrace has to deal
with? For some reason I thought drivers/md/md.c was one but it seems
like it is not. Do we have an easy way to search for these? I think
this would just affect how we express the comment only.

>  		 */
> -		dir = q->sg_debugfs_dir;
> +		dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> +		bt->dir = dir;

The other chicken and egg problem to consider at least in the comments
is that the debugfs directory for these types of devices *have* an
exposed path, but the data structure is rather opaque to the device and
even blktrace.  Fortunately given the recent set of changes around the
q->blk_trace and clarifications around its use we have made it clear now
that so long as hold the q->blk_trace_mutex *and* check q->blk_trace we
*should* not race against two separate creations of debugfs directories,
so I think this is safe, so long as these indpendent drivers don't end
up re-using the same path for some other things later in the future, and
since we have control over what goes under debugfsroot block / I think
we should be good.

But I think that the concern for race on names may still be worth
explaining a bit here.

  Luis
