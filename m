Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D2C2C68CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgK0PgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 10:36:21 -0500
Received: from verein.lst.de ([213.95.11.211]:37927 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbgK0PgV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:36:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5CA0168B05; Fri, 27 Nov 2020 16:36:16 +0100 (CET)
Date:   Fri, 27 Nov 2020 16:36:15 +0100
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
Message-ID: <20201127153615.GA7524@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-38-hch@lst.de> <20201126182219.GC422@quack2.suse.cz> <20201127094842.GA15984@lst.de> <20201127124537.GC27162@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127124537.GC27162@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 01:45:37PM +0100, Jan Kara wrote:
> > At this point the hd_struct is already allocated together with the
> > block_device, and thus only freed after the last block_device reference
> > goes away plus the inode freeing RCU grace period.  So the device model
> > ref to part is indeed gone, but that simply does not matter any more.
> 
> Well, but once device model ref to part is gone, we're going to free the
> bdev inode ref as well. Thus there's nothing which pins the bdev containing
> hd_struct?
> 
> But now as I'm thinking about it you later switch the device model reference
> to just pure inode reference and use igrab() which will reliably return
> NULL if the inode is on it's way to be destroyed so probably we are safe in
> the final state.

igrab always succeeds.  But we should switch to a tryget.
