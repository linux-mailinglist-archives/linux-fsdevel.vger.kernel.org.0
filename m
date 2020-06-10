Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36F01F5865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgFJPy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:54:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:42498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgFJPy5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:54:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6512FAD09;
        Wed, 10 Jun 2020 15:55:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5BB501E1283; Wed, 10 Jun 2020 17:54:56 +0200 (CEST)
Date:   Wed, 10 Jun 2020 17:54:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Martijn Coenen <maco@android.com>,
        tj@kernel.org
Subject: Re: [PATCH 2/3] writeback: Fix sync livelock due to b_dirty_time
 processing
Message-ID: <20200610155456.GB20677@quack2.suse.cz>
References: <20200601091202.31302-1-jack@suse.cz>
 <20200601091904.4786-2-jack@suse.cz>
 <20200610150614.GB21733@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610150614.GB21733@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-06-20 08:06:14, Christoph Hellwig wrote:
> On Mon, Jun 01, 2020 at 11:18:56AM +0200, Jan Kara wrote:
> > When we are processing writeback for sync(2), move_expired_inodes()
> > didn't set any inode expiry value (older_than_this). This can result in
> > writeback never completing if there's steady stream of inodes added to
> > b_dirty_time list as writeback rechecks dirty lists after each writeback
> > round whether there's more work to be done. Fix the problem by using
> > sync(2) start time is inode expiry value when processing b_dirty_time
> > list similarly as for ordinarily dirtied inodes. This requires some
> > refactoring of older_than_this handling which simplifies the code
> > noticeably as a bonus.
> 
> Looks sane, but if you touch all the older_than_this users can we
> rename it to something more reasonable like oldest or oldest_jif?

OK, I can certainly rename this. I've just realized that 'oldest' is really
misleading since we are in fact processing inodes that were dirtied before
the given time. So maybe name that 'dirtied_before'?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
