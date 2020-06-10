Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048A71F5EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgFJXbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 19:31:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45066 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:31:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id d8so1565408plo.12;
        Wed, 10 Jun 2020 16:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nLAVxDouIonl+NxnXy9izk4hkTc9wtd8s/XB6HrhmVA=;
        b=j5GBy1OMkSxkQ02bXmBbEHuH8F9w5nXbP+zhnQRaH0gkmqNiO5fVbwEpzapdk7N1uB
         SpSpFhze/3wfl4LmBOxYMz9wExFw+5xQsVAEheDECGKaY7dMujARZR0zbqiN6WSoEwoq
         TTYvh4l/ld6jD+cWqD4xemJ/PjsORGKkiepIKA0eIX1AYjkmrKoLffY+IURNhZF5RVRc
         2/+JbInOOqDURL2KgtHxbH4bvsjf8wphgeye8SCyGFF6BYH+u6dOPNDlRNTUY6MPvqQi
         w54XRtM5VrYpkXciQz0Gw8Vgv3ksf/M9EfRvYjaDSGW/myBR2gDDwSlnTLjO8JrCQhu1
         q1og==
X-Gm-Message-State: AOAM5320SoIEQ4iNxSXX0fd8ctR1oFOSDxPnHFPyEnmpvLDvQQQzAiCe
        rwuJfxcHDARqhIejti5wW0I=
X-Google-Smtp-Source: ABdhPJz+UPFZOp6/BRwEwReJX9C8Yy4GUmeqrckOmUSZxHzlyj90URXkBUNXgoK4npNvGJdH/OqrTg==
X-Received: by 2002:a17:90a:642:: with SMTP id q2mr5562016pje.71.1591831878095;
        Wed, 10 Jun 2020 16:31:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m7sm1026289pfb.1.2020.06.10.16.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 16:31:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0FDAA403AB; Wed, 10 Jun 2020 23:31:16 +0000 (UTC)
Date:   Wed, 10 Jun 2020 23:31:16 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200610233116.GI13911@42.do-not-panic.com>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
 <20200609172922.GP11244@42.do-not-panic.com>
 <20200609173218.GA7968@infradead.org>
 <20200609175359.GR11244@42.do-not-panic.com>
 <20200610064234.GB24975@infradead.org>
 <20200610210917.GH11244@42.do-not-panic.com>
 <20200610215213.GH13911@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610215213.GH13911@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:52:13PM +0000, Luis Chamberlain wrote:
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 7ff2ea5cd05e..5cea04c05e09 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -524,10 +524,16 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!bt->msg_data)
>  		goto err;
>  
> -	ret = -ENOENT;
> -
> -	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> -	if (!dir)
> +	/*
> +	 * When tracing whole make_request drivers (multiqueue) block devices,
> +	 * reuse the existing debugfs directory created by the block layer on
> +	 * init. For request-based block devices, all partitions block devices,
> +	 * and scsi-generic block devices we create a temporary new debugfs
> +	 * directory that will be removed once the trace ends.
> +	 */
> +	if (queue_is_mq(q))

And this should be instead:

if (queue_is_mq(q) && bdev && bdev == bdev->bd_contains)

> +		dir = q->debugfs_dir;
> +	else
>  		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
>  
>  	bt->dev = dev;
> @@ -565,8 +571,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  
>  	ret = 0;
>  err:
> -	if (dir && !bt->dir)
> -		dput(dir);
>  	if (ret)
>  		blk_trace_free(bt);
>  	return ret;
