Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B02C6A96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 18:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgK0R0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 12:26:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:55700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732204AbgK0R0n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:26:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3BEDAE91;
        Fri, 27 Nov 2020 17:26:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E315E1E1319; Fri, 27 Nov 2020 18:26:40 +0100 (CET)
Date:   Fri, 27 Nov 2020 18:26:40 +0100
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
Message-ID: <20201127172640.GA4276@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-38-hch@lst.de>
 <20201126182219.GC422@quack2.suse.cz>
 <20201127094842.GA15984@lst.de>
 <20201127124537.GC27162@quack2.suse.cz>
 <20201127153615.GA7524@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127153615.GA7524@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-11-20 16:36:15, Christoph Hellwig wrote:
> On Fri, Nov 27, 2020 at 01:45:37PM +0100, Jan Kara wrote:
> > > At this point the hd_struct is already allocated together with the
> > > block_device, and thus only freed after the last block_device reference
> > > goes away plus the inode freeing RCU grace period.  So the device model
> > > ref to part is indeed gone, but that simply does not matter any more.
> > 
> > Well, but once device model ref to part is gone, we're going to free the
> > bdev inode ref as well. Thus there's nothing which pins the bdev containing
> > hd_struct?
> > 
> > But now as I'm thinking about it you later switch the device model reference
> > to just pure inode reference and use igrab() which will reliably return
> > NULL if the inode is on it's way to be destroyed so probably we are safe in
> > the final state.
> 
> igrab always succeeds.  But we should switch to a tryget.

No. If the inode is I_FREEING or I_WILL_FREE, it will return NULL...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
