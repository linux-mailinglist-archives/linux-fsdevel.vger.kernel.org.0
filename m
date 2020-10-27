Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A786629BB98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 17:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808754AbgJ0QVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 12:21:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:33198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1804983AbgJ0QAO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:00:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83C70ABE3;
        Tue, 27 Oct 2020 16:00:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 331EA1E10F5; Tue, 27 Oct 2020 17:00:12 +0100 (CET)
Date:   Tue, 27 Oct 2020 17:00:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca BRUNO <lucab@redhat.com>
Subject: Re: [PATCH] inotify: Increase default inotify.max_user_watches limit
 to 1048576
Message-ID: <20201027160012.GE16090@quack2.suse.cz>
References: <20201026204418.23197-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026204418.23197-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-10-20 16:44:18, Waiman Long wrote:
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
> Each watch point adds an inotify_inode_mark structure to an inode to be
> watched. Modeled after the epoll.max_user_watches behavior to adjust the
> default value according to the amount of addressable memory available,
> make inotify.max_user_watches behave in a similar way to make it use
> no more than 1% of addressable memory within the range [8192, 1048576].
> 
> For 64-bit archs, inotify_inode_mark should have a size of 80 bytes. That
> means a system with 8GB or more memory will have the maximum value of
> 1048576 for inotify.max_user_watches. This default should be big enough
> for most of the use cases.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

So I agree that 8192 watches seem to be a bit low today but what you
propose seems to be way too much to me. OTOH I agree that having to tune
this manually kind of sucks so I'm for auto-tuning of the default. If the
computation takes into account the fact that a watch pins an inode as Amir
properly notes (that's the main reason why the number of watches is
limited), I think limiting to 1% of pinned memory should be bearable. The
amount of space pinned by an inode is impossible to estimate exactly
(differs for different filesystems) but about 1k for one inode is a sound
estimate IMO.

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 186722ba3894..2da8b7a84b12 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -801,6 +801,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
>   */
>  static int __init inotify_user_setup(void)
>  {
> +	unsigned int watches_max;
> +	struct sysinfo si;
> +
> +	si_meminfo(&si);
> +	/*
> +	 * Allow up to 1% of addressible memory to be allocated for inotify
> +	 * watches (per user) limited to the range [8192, 1048576].
> +	 */
> +	watches_max = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
> +			sizeof(struct inotify_inode_mark);
> +	watches_max = min(1048576U, max(watches_max, 8192U));
> +
>  	BUILD_BUG_ON(IN_ACCESS != FS_ACCESS);
>  	BUILD_BUG_ON(IN_MODIFY != FS_MODIFY);
>  	BUILD_BUG_ON(IN_ATTRIB != FS_ATTRIB);
> @@ -827,7 +839,7 @@ static int __init inotify_user_setup(void)
>  
>  	inotify_max_queued_events = 16384;
>  	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
> -	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = 8192;
> +	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = watches_max;
>  
>  	return 0;
>  }
> -- 
> 2.18.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
