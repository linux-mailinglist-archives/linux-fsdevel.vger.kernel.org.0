Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37952A037F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 11:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJ3K6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 06:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJ3K57 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:57:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B635AB0E;
        Fri, 30 Oct 2020 10:57:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0B5C21E12D9; Fri, 30 Oct 2020 11:57:52 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:57:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca BRUNO <lucab@redhat.com>
Subject: Re: [PATCH v3] inotify: Increase default inotify.max_user_watches
 limit to 1048576
Message-ID: <20201030105752.GB19757@quack2.suse.cz>
References: <20201029194256.7954-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029194256.7954-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-10-20 15:42:56, Waiman Long wrote:
> The default value of inotify.max_user_watches sysctl parameter was set
> to 8192 since the introduction of the inotify feature in 2005 by
> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
> small for many modern usage. As a result, users have to explicitly set
> it to a larger value to make it work.
> 
> After some searching around the web, these are the
> inotify.max_user_watches values used by some projects:
>  - vscode:  524288
>  - dropbox support: 100000
>  - users on stackexchange: 12228
>  - lsyncd user: 2000000
>  - code42 support: 1048576
>  - monodevelop: 16384
>  - tectonic: 524288
>  - openshift origin: 65536
> 
> Each watch point adds an inotify_inode_mark structure to an inode to
> be watched. It also pins the watched inode.
> 
> Modeled after the epoll.max_user_watches behavior to adjust the default
> value according to the amount of addressable memory available, make
> inotify.max_user_watches behave in a similar way to make it use no more
> than 1% of addressable memory within the range [8192, 1048576].
> 
> For 64-bit archs, inotify_inode_mark plus 2 vfs inode have a size that
> is a bit over 1 kbytes (1284 bytes with my x86-64 config).  That means
> a system with 128GB or more memory will likely have the maximum value
> of 1048576 for inotify.max_user_watches. This default should be big
> enough for most use cases.
> 
> [v3: increase inotify watch cost as suggested by Amir and Honza]
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Overall this looks fine. Some remaining nits below.

> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 186722ba3894..f8065eda3a02 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -37,6 +37,15 @@
>  
>  #include <asm/ioctls.h>
>  
> +/*
> + * An inotify watch requires allocating an inotify_inode_mark structure as
> + * well as pinning the watched inode. Doubling the size of a VFS inode
> + * should be more than enough to cover the additional filesystem inode
> + * size increase.
> + */
> +#define INOTIFY_WATCH_COST	(sizeof(struct inotify_inode_mark) + \
> +				 2 * sizeof(struct inode))
> +
>  /* configurable via /proc/sys/fs/inotify/ */
>  static int inotify_max_queued_events __read_mostly;
>  
> @@ -801,6 +810,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
>   */
>  static int __init inotify_user_setup(void)
>  {
> +	unsigned int watches_max;
> +	struct sysinfo si;
> +
> +	si_meminfo(&si);
> +	/*
> +	 * Allow up to 1% of addressible memory to be allocated for inotify
			     ^^^^ addressable

> +	 * watches (per user) limited to the range [8192, 1048576].
> +	 */
> +	watches_max = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
> +			INOTIFY_WATCH_COST;
			^^^ So for machines with > 1TB of memory
watches_max would overflow. So you probably need to use ulong for that.


> +	watches_max = min(1048576U, max(watches_max, 8192U));
			^^^ use clamp() here?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
