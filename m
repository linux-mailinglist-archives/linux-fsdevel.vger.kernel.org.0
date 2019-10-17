Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61224DA780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405204AbfJQIj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 04:39:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388788AbfJQIj2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:39:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77B09B172;
        Thu, 17 Oct 2019 08:39:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 41AB51E485F; Thu, 17 Oct 2019 10:39:26 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:39:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/1] fs: call fsnotify_sb_delete after evict_inodes
Message-ID: <20191017083926.GD20260@quack2.suse.cz>
References: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
 <e71d3fbf-8b12-a650-e622-76bc9d4d6a98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e71d3fbf-8b12-a650-e622-76bc9d4d6a98@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-10-19 12:11:24, Eric Sandeen wrote:
> When a filesystem is unmounted, we currently call fsnotify_sb_delete()
> before evict_inodes(), which means that fsnotify_unmount_inodes()
> must iterate over all inodes on the superblock, even though it will
> only act on inodes with a refcount.  This is inefficient and can lead
> to livelocks as it iterates over many unrefcounted inodes.
> 
> However, since fsnotify_sb_delete() and evict_inodes() are working
> on orthogonal sets of inodes (fsnotify_sb_delete() only cares about nonzero
> refcount, and evict_inodes() only cares about zero refcount), we can swap
> the order of the calls.  The fsnotify call will then have a much smaller
> list to walk (any refcounted inodes).
> 
> This should speed things up overall, and avoid livelocks in 
> fsnotify_unmount_inodes().
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Thanks for the patch. It looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
> 
> I just did basic sanity testing here, but AFAIK there is no *notify
> test suite, so I'm not sure how to really give this a workout.

LTP has quite a few tests for inotify & fanotify.

								Honza

> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index ac9eb273e28c..426f03b6e660 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -57,6 +57,10 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  		 * doing an __iget/iput with SB_ACTIVE clear would actually
>  		 * evict all inodes with zero i_count from icache which is
>  		 * unnecessarily violent and may in fact be illegal to do.
> +		 *
> +		 * However, we should have been called /after/ evict_inodes
> +		 * removed all zero refcount inodes, in any case.  Test to
> +		 * be sure.
>  		 */
>  		if (!atomic_read(&inode->i_count)) {
>  			spin_unlock(&inode->i_lock);
> diff --git a/fs/super.c b/fs/super.c
> index cfadab2cbf35..cd352530eca9 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -448,10 +448,12 @@ void generic_shutdown_super(struct super_block *sb)
>  		sync_filesystem(sb);
>  		sb->s_flags &= ~SB_ACTIVE;
>  
> -		fsnotify_sb_delete(sb);
>  		cgroup_writeback_umount();
>  
> +		/* evict all inodes with zero refcount */
>  		evict_inodes(sb);
> +		/* only nonzero refcount inodes can have marks */
> +		fsnotify_sb_delete(sb);
>  
>  		if (sb->s_dio_done_wq) {
>  			destroy_workqueue(sb->s_dio_done_wq);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
