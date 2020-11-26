Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD432C5BEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 19:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404854AbgKZSWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 13:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:42928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404147AbgKZSWV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:22:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F7B7AF27;
        Thu, 26 Nov 2020 18:22:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8EEA81E10D0; Thu, 26 Nov 2020 19:22:19 +0100 (CET)
Date:   Thu, 26 Nov 2020 19:22:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 37/44] block: switch partition lookup to use struct
 block_device
Message-ID: <20201126182219.GC422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-38-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-38-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:15, Christoph Hellwig wrote:
>  struct hd_struct *disk_get_part(struct gendisk *disk, int partno)
>  {
> -	struct hd_struct *part;
> +	struct block_device *part;
>  
>  	rcu_read_lock();
>  	part = __disk_get_part(disk, partno);
> -	if (part)
> -		get_device(part_to_dev(part));
> -	rcu_read_unlock();
> +	if (!part) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
>  
> -	return part;
> +	get_device(part_to_dev(part->bd_part));
> +	rcu_read_unlock();
> +	return part->bd_part;
>  }

This is not directly related to this particular patch but I'm wondering:
What prevents say del_gendisk() from racing with disk_get_part(), so that
delete_partition() is called just after we fetched 'part' pointer and the
last 'part' kobject ref is dropped before disk_get_part() calls
get_device()? I don't see anything preventing that and so we'd hand out
'part' that is soon to be freed (after RCU grace period expires).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
