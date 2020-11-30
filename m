Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4486B2C8795
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgK3PSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:18:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:59114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgK3PSX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:18:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62EECAB63;
        Mon, 30 Nov 2020 15:17:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CC8061E131B; Mon, 30 Nov 2020 16:17:41 +0100 (CET)
Date:   Mon, 30 Nov 2020 16:17:41 +0100
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
Subject: Re: [PATCH 30/45] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201130151741.GN11250@quack2.suse.cz>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-31-hch@lst.de>
 <20201130094421.GD11250@quack2.suse.cz>
 <20201130145150.GA24694@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130145150.GA24694@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 30-11-20 15:51:50, Christoph Hellwig wrote:
> On Mon, Nov 30, 2020 at 10:44:21AM +0100, Jan Kara wrote:
> > I know I'm like a broken record about this but I still don't understand
> > here... I'd expect the new code to be:
> > 
> > 	if (size == capacity ||
> > 	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> > 		return false;
> > 	pr_info("%s: detected capacity change from %lld to %lld\n",
> > 		disk->disk_name, size, capacity);
> > +	if (!capacity || !size)
> > +		return false;
> > 	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
> > 	return true;
> > 
> > At least that would be equivalent to the original functionality of
> > set_capacity_and_notify(). And if you indeed intend to change when
> > "RESIZE=1" events are sent, then I'd expect an explanation in the changelog
> > why this cannot break userspace (I remember we've already broken some udev
> > rules in the past by generating unexpected events and we had to revert
> > those changes in the partition code so I'm more careful now). The rest of
> > the patch looks good to me.
> 
> I explained that I think the GENHD_FL_UP is the more useful one here in
> reply to your last comment.   If the size changes to or from 0 during
> runtime we probably do want an event.

Ah, right, sorry, I missed that. And I agree that it might make sense for
changes to / from zero during runtime to send notification. But it still
seems as a thin ice with potential to breakage to me.

> But I'll add your hunk for now and we can discuss this separately.

OK, thanks. With that hunk feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
