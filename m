Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3521E28E428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgJNQPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387838AbgJNQPm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:15:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A159AC87;
        Wed, 14 Oct 2020 16:15:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A61F1E1338; Wed, 14 Oct 2020 18:15:38 +0200 (CEST)
Date:   Wed, 14 Oct 2020 18:15:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
Message-ID: <20201014161538.GA27613@quack2.suse.cz>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
 <20201010142355.741645-2-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010142355.741645-2-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 10-10-20 22:23:51, Chengguang Xu wrote:
> Currently there is no notification api for kernel about modification
> of vfs inode, in some use cases like overlayfs, this kind of notification
> will be very helpful to implement containerized syncfs functionality.
> As the first attempt, we introduce marking inode dirty notification so that
> overlay's inode could mark itself dirty as well and then only sync dirty
> overlay inode while syncfs.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

So I like how the patch set is elegant however growing struct inode for
everybody by struct blocking_notifier_head (which is rwsem + pointer) is
rather harsh just for this overlayfs functionality... Ideally this should
induce no overhead on struct inode if the filesystem is not covered by
overlayfs. So I'd rather place some external structure into the superblock
that would get allocated on the first use that would track dirty notifications
for each inode. I would not generalize the code for more possible
notifications at this point.

Also now that I'm thinking about it can there be multiple overlayfs inodes
for one upper inode? If not, then the mechanism of dirtiness propagation
could be much simpler - it seems we could be able to just lookup
corresponding overlayfs inode based on upper inode and then mark it dirty
(but this would need to be verified by people more familiar with
overlayfs). So all we'd need to know for this is the superblock of the
overlayfs that's covering given upper filesystem...

								Honza
> ---
>  fs/fs-writeback.c  | 4 ++++
>  fs/inode.c         | 5 +++++
>  include/linux/fs.h | 6 ++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 1492271..657cceb 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2246,9 +2246,13 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	int dirtytime;
> +	int copy_flags = flags;
>  
>  	trace_writeback_mark_inode_dirty(inode, flags);
>  
> +	blocking_notifier_call_chain(
> +		&inode->notifier_lists[MARK_INODE_DIRTY_NOTIFIER],
> +		0, &copy_flags);
>  	/*
>  	 * Don't do this for I_DIRTY_PAGES - that doesn't actually
>  	 * dirty the inode itself
> diff --git a/fs/inode.c b/fs/inode.c
> index 72c4c34..84e82db 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -388,12 +388,17 @@ void address_space_init_once(struct address_space *mapping)
>   */
>  void inode_init_once(struct inode *inode)
>  {
> +	int i;
> +
>  	memset(inode, 0, sizeof(*inode));
>  	INIT_HLIST_NODE(&inode->i_hash);
>  	INIT_LIST_HEAD(&inode->i_devices);
>  	INIT_LIST_HEAD(&inode->i_io_list);
>  	INIT_LIST_HEAD(&inode->i_wb_list);
>  	INIT_LIST_HEAD(&inode->i_lru);
> +	for (i = 0; i < INODE_MAX_NOTIFIER; i++)
> +		BLOCKING_INIT_NOTIFIER_HEAD(
> +			&inode->notifier_lists[MARK_INODE_DIRTY_NOTIFIER]);
>  	__address_space_init_once(&inode->i_data);
>  	i_size_ordered_init(inode);
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7519ae0..42f0750 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -607,6 +607,11 @@ static inline void mapping_allow_writable(struct address_space *mapping)
>  
>  struct fsnotify_mark_connector;
>  
> +enum {
> +	MARK_INODE_DIRTY_NOTIFIER,
> +	INODE_MAX_NOTIFIER,
> +};
> +
>  /*
>   * Keep mostly read-only and often accessed (especially for
>   * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -723,6 +728,7 @@ struct inode {
>  #endif
>  
>  	void			*i_private; /* fs or device private pointer */
> +	struct	blocking_notifier_head notifier_lists[INODE_MAX_NOTIFIER];
>  } __randomize_layout;
>  
>  struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
> -- 
> 1.8.3.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
