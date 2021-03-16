Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B061D33D7CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhCPPjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 11:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhCPPjZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:39:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB205AD3B;
        Tue, 16 Mar 2021 15:39:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 98B531F2C4C; Tue, 16 Mar 2021 16:39:23 +0100 (CET)
Date:   Tue, 16 Mar 2021 16:39:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Performance improvement for fanotify merge
Message-ID: <20210316153923.GC23532@quack2.suse.cz>
References: <20210304104826.3993892-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304104826.3993892-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Thu 04-03-21 12:48:21, Amir Goldstein wrote:
> Jan,
> 
> Following is v2 for the fanotify_merge() performance improvements.
> 
> For more details on functional and performance tests please refer to
> v1 cover letter [1].
> 
> This version is much simpler than v1 using standard hlist.
> It was rebased and tested against 5.12-rc1 using LTP tests [2].

Thanks for the patches. I've just changed that one small thing, otherwise
the patches look fine so I've merged them to my tree.

								Honza

> 
> Thanks,
> Amir.
> 
> Chanes since v1:
> - Use hlist instead of multi notification lists
> - Handling all hashing within fanotify backend
> - Cram event key member together with event type
> - Remove ifdefs and use constant queue hash bits
> - Address other review comments on v1
> 
> [1] https://lore.kernel.org/linux-fsdevel/20210202162010.305971-1-amir73il@gmail.com/
> [2] https://github.com/amir73il/ltp/commits/fanotify_merge
> 
> Amir Goldstein (5):
>   fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
>   fanotify: reduce event objectid to 29-bit hash
>   fanotify: mix event info and pid into merge key hash
>   fsnotify: use hash table for faster events merge
>   fanotify: limit number of event merge attempts
> 
>  fs/notify/fanotify/fanotify.c        | 150 +++++++++++++++++++--------
>  fs/notify/fanotify/fanotify.h        |  46 +++++++-
>  fs/notify/fanotify/fanotify_user.c   |  65 ++++++++++--
>  fs/notify/inotify/inotify_fsnotify.c |   9 +-
>  fs/notify/inotify/inotify_user.c     |   7 +-
>  fs/notify/notification.c             |  64 ++++++------
>  include/linux/fsnotify_backend.h     |  23 ++--
>  7 files changed, 263 insertions(+), 101 deletions(-)
> 
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
