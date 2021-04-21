Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB28366D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbhDUNrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 09:47:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhDUNrJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:47:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F14E5AF5B;
        Wed, 21 Apr 2021 13:46:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9043E1F2B69; Wed, 21 Apr 2021 15:46:34 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:46:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
Message-ID: <20210421134634.GT8706@quack2.suse.cz>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
 <20210415145235.GD2069063@infradead.org>
 <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
 <20210420130841.GA3618564@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420130841.GA3618564@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-04-21 14:08:41, Christoph Hellwig wrote:
> On Fri, Apr 16, 2021 at 04:00:48PM +0800, Zhang Yi wrote:
> > Now, we use already use "if (bdev->bd_super)" to prevent call into
> > ->bdev_try_to_free_page unless the super is alive, and the problem is
> > bd_super becomes NULL concurrently after this check. So, IIUC, I think it's
> > the same to switch to check the superblock is active or not. The acvive
> > flag also could becomes inactive (raced by umount) after we call into
> > bdev_try_to_free_page().
> 
> Indeed.
> 
> > In order to close this race, One solution is introduce a lock to synchronize
> > the active state between kill_block_super() and blkdev_releasepage(), but
> > the releasing page process have to try to acquire this lock in
> > blkdev_releasepage() for each page, and the umount process still need to wait
> > until the page release if some one invoke into ->bdev_try_to_free_page().
> > I think this solution may affect performace and is not a good way.
> > Think about it in depth, use percpu refcount seems have the smallest
> > performance effect on blkdev_releasepage().
> > 
> > If you don't like the refcount, maybe we could add synchronize_rcu_expedited()
> > in ext4_put_super(), it also could prevent this race. Any suggestions?
> 
> I really don't like to put a lot of overhead into the core VFS and block
> device code.  ext4/jbd does not own the block device inode and really
> has no business controlling releasepage for it.  I suspect the right
> answer might be to simply revert the commit that added this hook.

Indeed, after 12 years in kernel .bdev_try_to_free_page is implemented only
by ext4. So maybe it is not that important? I agree with Zhang and
Christoph that getting the lifetime rules sorted out will be hairy and it
is questionable, whether it is worth the additional pages we can reclaim.
Ted, do you remember what was the original motivation for this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
