Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817F2C6238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgK0Jsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 04:48:46 -0500
Received: from verein.lst.de ([213.95.11.211]:37093 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgK0Jsq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:48:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9707D68B05; Fri, 27 Nov 2020 10:48:42 +0100 (CET)
Date:   Fri, 27 Nov 2020 10:48:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 37/44] block: switch partition lookup to use struct
 block_device
Message-ID: <20201127094842.GA15984@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-38-hch@lst.de> <20201126182219.GC422@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126182219.GC422@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 07:22:19PM +0100, Jan Kara wrote:
> On Thu 26-11-20 14:04:15, Christoph Hellwig wrote:
> >  struct hd_struct *disk_get_part(struct gendisk *disk, int partno)
> >  {
> > -	struct hd_struct *part;
> > +	struct block_device *part;
> >  
> >  	rcu_read_lock();
> >  	part = __disk_get_part(disk, partno);
> > -	if (part)
> > -		get_device(part_to_dev(part));
> > -	rcu_read_unlock();
> > +	if (!part) {
> > +		rcu_read_unlock();
> > +		return NULL;
> > +	}
> >  
> > -	return part;
> > +	get_device(part_to_dev(part->bd_part));
> > +	rcu_read_unlock();
> > +	return part->bd_part;
> >  }
> 
> This is not directly related to this particular patch but I'm wondering:
> What prevents say del_gendisk() from racing with disk_get_part(), so that
> delete_partition() is called just after we fetched 'part' pointer and the
> last 'part' kobject ref is dropped before disk_get_part() calls
> get_device()? I don't see anything preventing that and so we'd hand out
> 'part' that is soon to be freed (after RCU grace period expires).

At this point the hd_struct is already allocated together with the
block_device, and thus only freed after the last block_device reference
goes away plus the inode freeing RCU grace period.  So the device model
ref to part is indeed gone, but that simply does not matter any more.
