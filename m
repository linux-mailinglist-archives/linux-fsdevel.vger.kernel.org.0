Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6F4084AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbhIMG33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 02:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhIMG32 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:29:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09A0160FC0;
        Mon, 13 Sep 2021 06:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631514491;
        bh=JV9RZ7EErzNlYAw0A/uXNJiRmBcBN/9BrP+lNa3euYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTqqGY90fkIrFjXckNWGz/Z5seWChRrfUY6uYIPfaJfdXUC0voqKAzW5oIFxUf4i/
         zKXIsSbxMVGP262QM+DEo7ejYUM8TGcMx+co3nsJ7+Gw4LmBhbIOjv+kNdWg/aJF30
         vVzTwo0fY2Z5EGd8WyZFApJcv7B6EbktCxJFBihg=
Date:   Mon, 13 Sep 2021 08:27:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <YT7vZthsMCM1uKxm@kroah.com>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:21AM +0200, Christoph Hellwig wrote:
> Trivial conversion to the seq_file based sysfs attributes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_stats.c | 24 +++++-------
>  fs/xfs/xfs_stats.h |  2 +-
>  fs/xfs/xfs_sysfs.c | 96 +++++++++++++++++++++++-----------------------
>  3 files changed, 58 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
> index 20e0534a772c9..71e7a84ba0403 100644
> --- a/fs/xfs/xfs_stats.c
> +++ b/fs/xfs/xfs_stats.c
> @@ -16,10 +16,9 @@ static int counter_val(struct xfsstats __percpu *stats, int idx)
>  	return val;
>  }
>  
> -int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
> +void xfs_stats_format(struct xfsstats __percpu *stats, struct seq_file *sf)
>  {
>  	int		i, j;
> -	int		len = 0;
>  	uint64_t	xs_xstrat_bytes = 0;
>  	uint64_t	xs_write_bytes = 0;
>  	uint64_t	xs_read_bytes = 0;
> @@ -58,13 +57,12 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
>  	/* Loop over all stats groups */
>  
>  	for (i = j = 0; i < ARRAY_SIZE(xstats); i++) {
> -		len += scnprintf(buf + len, PATH_MAX - len, "%s",
> -				xstats[i].desc);
> +		seq_printf(sf, "%s", xstats[i].desc);
> +
>  		/* inner loop does each group */
>  		for (; j < xstats[i].endpoint; j++)
> -			len += scnprintf(buf + len, PATH_MAX - len, " %u",
> -					counter_val(stats, j));
> -		len += scnprintf(buf + len, PATH_MAX - len, "\n");
> +			seq_printf(sf, " %u", counter_val(stats, j));
> +		seq_printf(sf, "\n");
>  	}
>  	/* extra precision counters */
>  	for_each_possible_cpu(i) {
> @@ -74,18 +72,14 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
>  		defer_relog += per_cpu_ptr(stats, i)->s.defer_relog;
>  	}
>  
> -	len += scnprintf(buf + len, PATH_MAX-len, "xpc %Lu %Lu %Lu\n",
> +	seq_printf(sf, "xpc %Lu %Lu %Lu\n",
>  			xs_xstrat_bytes, xs_write_bytes, xs_read_bytes);
> -	len += scnprintf(buf + len, PATH_MAX-len, "defer_relog %llu\n",
> -			defer_relog);
> -	len += scnprintf(buf + len, PATH_MAX-len, "debug %u\n",
> +	seq_printf(sf, "defer_relog %llu\n", defer_relog);
>  #if defined(DEBUG)
> -		1);
> +	seq_printf(sf, "debug 1\n");
>  #else
> -		0);
> +	seq_printf(sf, "debug 0\n");
>  #endif
> -
> -	return len;
>  }

That is a sysfs file?  What happened to the "one value per file" rule
here?

Ugh.

Anyway, I like the idea, but as you can see here, it could lead to even
more abuse of sysfs files.  We are just now getting people to use
sysfs_emit() and that is showing us where people have been abusing the
api in bad ways.

Is there any way that sysfs can keep the existing show functionality and
just do the seq_printf() for the buffer returned by the attribute file
inside of the sysfs core?  That would allow us to keep all of the
existing attribute file functions as-is, and still get rid of the sysfs
core usage here?

thanks,

greg k-h
