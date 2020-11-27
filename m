Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD712C65E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 13:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgK0Mpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 07:45:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:54230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgK0Mpj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:45:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 280CAABD7;
        Fri, 27 Nov 2020 12:45:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4AC6D1E1318; Fri, 27 Nov 2020 13:45:37 +0100 (CET)
Date:   Fri, 27 Nov 2020 13:45:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20201127124537.GC27162@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-38-hch@lst.de>
 <20201126182219.GC422@quack2.suse.cz>
 <20201127094842.GA15984@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127094842.GA15984@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-11-20 10:48:42, Christoph Hellwig wrote:
> On Thu, Nov 26, 2020 at 07:22:19PM +0100, Jan Kara wrote:
> > On Thu 26-11-20 14:04:15, Christoph Hellwig wrote:
> > >  struct hd_struct *disk_get_part(struct gendisk *disk, int partno)
> > >  {
> > > -	struct hd_struct *part;
> > > +	struct block_device *part;
> > >  
> > >  	rcu_read_lock();
> > >  	part = __disk_get_part(disk, partno);
> > > -	if (part)
> > > -		get_device(part_to_dev(part));
> > > -	rcu_read_unlock();
> > > +	if (!part) {
> > > +		rcu_read_unlock();
> > > +		return NULL;
> > > +	}
> > >  
> > > -	return part;
> > > +	get_device(part_to_dev(part->bd_part));
> > > +	rcu_read_unlock();
> > > +	return part->bd_part;
> > >  }
> > 
> > This is not directly related to this particular patch but I'm wondering:
> > What prevents say del_gendisk() from racing with disk_get_part(), so that
> > delete_partition() is called just after we fetched 'part' pointer and the
> > last 'part' kobject ref is dropped before disk_get_part() calls
> > get_device()? I don't see anything preventing that and so we'd hand out
> > 'part' that is soon to be freed (after RCU grace period expires).
> 
> At this point the hd_struct is already allocated together with the
> block_device, and thus only freed after the last block_device reference
> goes away plus the inode freeing RCU grace period.  So the device model
> ref to part is indeed gone, but that simply does not matter any more.

Well, but once device model ref to part is gone, we're going to free the
bdev inode ref as well. Thus there's nothing which pins the bdev containing
hd_struct?

But now as I'm thinking about it you later switch the device model reference
to just pure inode reference and use igrab() which will reliably return
NULL if the inode is on it's way to be destroyed so probably we are safe in
the final state.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
