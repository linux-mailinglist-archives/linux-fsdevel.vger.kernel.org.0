Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23813D8EAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 15:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhG1NMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 09:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhG1NMV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AE4760FED;
        Wed, 28 Jul 2021 13:12:16 +0000 (UTC)
Date:   Wed, 28 Jul 2021 15:12:13 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11] btrfs: use automount to bind-mount all subvol
 roots.
Message-ID: <20210728131213.pgu3r4m4ulozrcav@wittgenstein>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546558.32498.1901201501617899416.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162742546558.32498.1901201501617899416.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> All subvol roots are now marked as automounts.  If the d_automount()
> function determines that the dentry is not the root of the vfsmount, it
> creates a simple loop-back mount of the dentry onto itself.  If it
> determines that it IS the root of the vfsmount, it returns -EISDIR so
> that no further automounting is attempted.
> 
> btrfs_getattr pays special attention to these automount dentries.
> If it is NOT the root of the vfsmount:
>  - the ->dev is reported as that for the rest of the vfsmount
>  - the ->ino is reported as the subvol objectid, suitable transformed
>    to avoid collision.
> 
> This way the same inode appear to be different depending on which mount
> it is in.
> 
> automounted vfsmounts are kept on a list and timeout after 500 to 1000
> seconds of last use.  This is configurable via a module parameter.
> The tracking and timeout of automounts is copied from NFS.
> 
> Link: https://lore.kernel.org/r/162742546558.32498.1901201501617899416.stgit@noble.brown
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/btrfs/btrfs_inode.h |    2 +
>  fs/btrfs/inode.c       |  108 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/super.c       |    1 
>  3 files changed, 111 insertions(+)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index a4b5f38196e6..f03056cacc4a 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -387,4 +387,6 @@ static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
>  			mirror_num);
>  }
>  
> +void btrfs_release_automount_timer(void);
> +
>  #endif
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 02537c1a9763..a5f46545fb38 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -31,6 +31,7 @@
>  #include <linux/migrate.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iomap.h>
> +#include <linux/fs_context.h>
>  #include <asm/unaligned.h>
>  #include "misc.h"
>  #include "ctree.h"
> @@ -5782,6 +5783,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
>  	struct btrfs_iget_args *args = p;
>  
>  	inode->i_ino = args->ino;
> +	if (args->ino == BTRFS_FIRST_FREE_OBJECTID)
> +		inode->i_flags |= S_AUTOMOUNT;
>  	BTRFS_I(inode)->location.objectid = args->ino;
>  	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
>  	BTRFS_I(inode)->location.offset = 0;
> @@ -5985,6 +5988,101 @@ static int btrfs_dentry_delete(const struct dentry *dentry)
>  	return 0;
>  }
>  
> +static void btrfs_expire_automounts(struct work_struct *work);
> +static LIST_HEAD(btrfs_automount_list);
> +static DECLARE_DELAYED_WORK(btrfs_automount_task, btrfs_expire_automounts);
> +int btrfs_mountpoint_expiry_timeout = 500 * HZ;
> +static void btrfs_expire_automounts(struct work_struct *work)
> +{
> +	struct list_head *list = &btrfs_automount_list;
> +	int timeout = READ_ONCE(btrfs_mountpoint_expiry_timeout);
> +
> +	mark_mounts_for_expiry(list);
> +	if (!list_empty(list) && timeout > 0)
> +		schedule_delayed_work(&btrfs_automount_task, timeout);
> +}
> +
> +void btrfs_release_automount_timer(void)
> +{
> +	if (list_empty(&btrfs_automount_list))
> +		cancel_delayed_work(&btrfs_automount_task);
> +}
> +
> +static struct vfsmount *btrfs_automount(struct path *path)
> +{
> +	struct fs_context fc;
> +	struct vfsmount *mnt;
> +	int timeout = READ_ONCE(btrfs_mountpoint_expiry_timeout);
> +
> +	if (path->dentry == path->mnt->mnt_root)
> +		/* dentry is root of the vfsmount,
> +		 * so skip automount processing
> +		 */
> +		return ERR_PTR(-EISDIR);
> +	/* Create a bind-mount to expose the subvol in the mount table */
> +	fc.root = path->dentry;
> +	fc.sb_flags = 0;
> +	fc.source = "btrfs-automount";
> +	mnt = vfs_create_mount(&fc);
> +	if (IS_ERR(mnt))
> +		return mnt;

Hey Neil,

Sorry if this is a stupid question but wouldn't you want to copy the
mount properties from path->mnt here? Couldn't you otherwise use this to
e.g. suddenly expose a dentry on a read-only mount as read-write?

Christian
