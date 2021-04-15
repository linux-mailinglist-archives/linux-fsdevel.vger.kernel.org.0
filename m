Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2D360A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 15:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhDONMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 09:12:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhDONMX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:12:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A1CCB062;
        Thu, 15 Apr 2021 13:11:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1E24F1F2B65; Thu, 15 Apr 2021 15:11:59 +0200 (CEST)
Date:   Thu, 15 Apr 2021 15:11:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210415131159.GA31418@quack2.suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
 <20210414000113.GG63242@dread.disaster.area>
 <20210414122319.GD31323@quack2.suse.cz>
 <20210414215739.GH63242@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414215739.GH63242@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-04-21 07:57:39, Dave Chinner wrote:
> On Wed, Apr 14, 2021 at 02:23:19PM +0200, Jan Kara wrote:
> > Regarding the name: How about i_pages_rwsem? The lock is protecting
> > invalidation of mapping->i_pages and needs to be held until insertion of
> > pages into i_pages is safe again...
> 
> I don't actually have a good name for this right now. :(
> 
> The i_pages structure has it's own internal locking, so
> i_pages_rwsem implies things that aren't necessarily true, and
> taking a read lock for insertion for something that is named like a
> structure protection lock creates cognitive dissonance...
> 
> I keep wanting to say "lock for invalidation" and "lock to exclude
> invalidation" because those are the two actions that we need for
> coherency of operations. But they are way too verbose for an actual
> API...
> 
> So I want to call this an "invalidation lock" of some kind (no need
> to encode the type in the name!), but haven't worked out a good
> shorthand for "address space invalidation coherency mechanism"...

So "invalidate_lock" was just next on my list of things to suggest so I'm
fine with that name. Or maybe block_invalidate_lock, block_remove_lock,
map_remove_lock, ... Dunno :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
