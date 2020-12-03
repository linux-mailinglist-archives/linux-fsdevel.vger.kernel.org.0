Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245F62CD998
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLCOxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 09:53:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:57208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgLCOxC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:53:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1375AABCE;
        Thu,  3 Dec 2020 14:52:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8A85B1E12FF; Thu,  3 Dec 2020 15:52:20 +0100 (CET)
Date:   Thu, 3 Dec 2020 15:52:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] fsnotify fixes and cleanups
Message-ID: <20201203145220.GH11854@quack2.suse.cz>
References: <20201202120713.702387-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Wed 02-12-20 14:07:06, Amir Goldstein wrote:
> I was working on some non urgent cleanups and stumbled on a bug,
> so flushing my patch queue as is.
> 
> Patches 1-2 are cleanups needed for the bug fix in patch 3.
> This [1] LTP test demonstrates the bug.
> 
> Patches 4-5 are pretty simple cleanups that you may or may not like
> to apply without the work that they build up to (I started this as
> prep work for subtree marks iterator).
> 
> Patches 6-7 are optimizations related to ignored mask which we
> discussed in the past.  I have written them a while back and had put
> them aside because I have no means to run performance tests that will
> demonstrate the benefit, which is probably not huge.
> 
> Since you suggested those optimizations (at least the first one),
> I decided to post and let you choose what to do with them.

Thanks for the fixes and optimizations. For now I've picked up patches 1-3
to my tree (with smaller fixups we talked about - plus I'm not sure where
you've got the "Fixes" tag commit ID from - I've fixed that as well). For
cleanups 4-5, I have no problem with them but also at this point don't see
a strong reason to merge them. I do like optimizations 6-7 but I'd like to
see some numbers on them so I didn't queue them just yet either.

								Honza

> [1] https://github.com/amir73il/ltp/commits/fsnotify-fixes
> 
> Amir Goldstein (7):
>   fsnotify: generalize handle_inode_event()
>   inotify: convert to handle_inode_event() interface
>   fsnotify: fix events reported to watching parent and child
>   fsnotify: clarify object type argument
>   fsnotify: separate mark iterator type from object type enum
>   fsnotify: optimize FS_MODIFY events with no ignored masks
>   fsnotify: optimize merging of marks with no ignored masks
> 
>  fs/nfsd/filecache.c                  |   2 +-
>  fs/notify/dnotify/dnotify.c          |   2 +-
>  fs/notify/fanotify/fanotify.c        |  16 +--
>  fs/notify/fanotify/fanotify_user.c   |  44 +++++---
>  fs/notify/fsnotify.c                 | 147 +++++++++++++++++----------
>  fs/notify/group.c                    |   2 +-
>  fs/notify/inotify/inotify.h          |   9 +-
>  fs/notify/inotify/inotify_fsnotify.c |  47 ++-------
>  fs/notify/inotify/inotify_user.c     |   7 +-
>  fs/notify/mark.c                     |  30 +++---
>  include/linux/fsnotify_backend.h     |  92 +++++++++++------
>  kernel/audit_fsnotify.c              |   2 +-
>  kernel/audit_tree.c                  |   2 +-
>  kernel/audit_watch.c                 |   2 +-
>  14 files changed, 233 insertions(+), 171 deletions(-)
> 
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
