Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3C2B86B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKRVef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:34:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:52536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgKRVe3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:34:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4578DB018;
        Wed, 18 Nov 2020 21:34:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 94E761E132C; Wed, 18 Nov 2020 15:42:55 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:42:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/20] init: cleanup match_dev_by_uuid and
 match_dev_by_label
Message-ID: <20201118144255.GN1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-10-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:49, Christoph Hellwig wrote:
> Avoid a totally pointless goto label, and use the same style of
> comparism for both helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

OK. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  init/do_mounts.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index afa26a4028d25e..5879edf083b318 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -79,15 +79,10 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
>  	const struct uuidcmp *cmp = data;
>  	struct hd_struct *part = dev_to_part(dev);
>  
> -	if (!part->info)
> -		goto no_match;
> -
> -	if (strncasecmp(cmp->uuid, part->info->uuid, cmp->len))
> -		goto no_match;
> -
> +	if (!part->info ||
> +	    strncasecmp(cmp->uuid, part->info->uuid, cmp->len))
> +		return 0;
>  	return 1;
> -no_match:
> -	return 0;
>  }
>  
>  /**
> @@ -174,10 +169,9 @@ static int match_dev_by_label(struct device *dev, const void *data)
>  	const char *label = data;
>  	struct hd_struct *part = dev_to_part(dev);
>  
> -	if (part->info && !strcmp(label, part->info->volname))
> -		return 1;
> -
> -	return 0;
> +	if (!part->info || strcmp(label, part->info->volname))
> +		return 0;
> +	return 1;
>  }
>  
>  static dev_t devt_from_partlabel(const char *label)
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
