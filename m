Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC521680B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgBUOtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 09:49:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55363 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgBUOtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:49:03 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j59br-0006f5-C5; Fri, 21 Feb 2020 14:48:55 +0000
Date:   Fri, 21 Feb 2020 15:48:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/19] vfs: Add mount change counter [ver #16]
Message-ID: <20200221144854.cdneyjekgljmoevz@wittgenstein>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204552812.3299825.2343288163181726758.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158204552812.3299825.2343288163181726758.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:05:28PM +0000, David Howells wrote:
> Add a change counter on each mount object so that the user can easily check
> to see if a mount has changed its attributes or its children.
> 
> Future patches will:
> 
>  (1) Provide this value through fsinfo() attributes.
> 
>  (2) Implement a watch_mount() system call to provide a notification
>      interface for userspace monitoring.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/mount.h     |   22 ++++++++++++++++++++++
>  fs/namespace.c |   11 +++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 711a4093e475..a1625924fe81 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -72,6 +72,7 @@ struct mount {
>  	int mnt_expiry_mark;		/* true if marked for expiry */
>  	struct hlist_head mnt_pins;
>  	struct hlist_head mnt_stuck_children;
> +	atomic_t mnt_change_counter;	/* Number of changed applied */

Nit: "Number of changes applied"?

>  } __randomize_layout;
>  
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
> @@ -153,3 +154,24 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
>  {
>  	return ns->seq == 0;
>  }
> +
> +/*
> + * Type of mount topology change notification.
> + */
> +enum mount_notification_subtype {
> +	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
> +	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
> +	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
> +	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
> +	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
> +	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
> +	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
> +};
> +
> +static inline void notify_mount(struct mount *changed,
> +				struct mount *aux,
> +				enum mount_notification_subtype subtype,
> +				u32 info_flags)
> +{
> +	atomic_inc(&changed->mnt_change_counter);
> +}
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 85b5f7bea82e..5c84aadb6aa1 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -498,6 +498,8 @@ static int mnt_make_readonly(struct mount *mnt)
>  	smp_wmb();
>  	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
>  	unlock_mount_hash();
> +	if (ret == 0)
> +		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0x10000);

Why is 0x10000 hard-coded here?
Hm, maybe for future patches where this will be replaced with a #define
but not sure...

>  	return ret;
>  }
>  
> @@ -506,6 +508,7 @@ static int __mnt_unmake_readonly(struct mount *mnt)
>  	lock_mount_hash();
>  	mnt->mnt.mnt_flags &= ~MNT_READONLY;
>  	unlock_mount_hash();
> +	notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0);
>  	return 0;
>  }
>  
> @@ -819,6 +822,7 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
>   */
>  static void umount_mnt(struct mount *mnt)
>  {
> +	notify_mount(mnt->mnt_parent, mnt, NOTIFY_MOUNT_UNMOUNT, 0);
>  	put_mountpoint(unhash_mnt(mnt));
>  }
>  
> @@ -1453,6 +1457,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>  		p = list_first_entry(&tmp_list, struct mount, mnt_list);
>  		list_del_init(&p->mnt_expire);
>  		list_del_init(&p->mnt_list);
> +
>  		ns = p->mnt_ns;
>  		if (ns) {
>  			ns->mounts--;
> @@ -2078,7 +2083,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  		lock_mount_hash();
>  	}
>  	if (moving) {
> +		notify_mount(source_mnt->mnt_parent, source_mnt,
> +			     NOTIFY_MOUNT_MOVE_FROM, 0);
>  		unhash_mnt(source_mnt);
> +		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_MOVE_TO, 0);
>  		attach_mnt(source_mnt, dest_mnt, dest_mp);
>  		touch_mnt_namespace(source_mnt->mnt_ns);
>  	} else {
> @@ -2087,6 +2095,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  			list_del_init(&source_mnt->mnt_ns->list);
>  		}
>  		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
> +		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT, 0);
>  		commit_tree(source_mnt);
>  	}
>  
> @@ -2464,6 +2473,7 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
>  	mnt->mnt.mnt_flags = mnt_flags;
>  	touch_mnt_namespace(mnt->mnt_ns);
>  	unlock_mount_hash();
> +	notify_mount(mnt, NULL, NOTIFY_MOUNT_SETATTR, 0);
>  }
>  
>  static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
> @@ -2898,6 +2908,7 @@ void mark_mounts_for_expiry(struct list_head *mounts)
>  		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
>  			propagate_mount_busy(mnt, 1))
>  			continue;
> +		notify_mount(mnt, NULL, NOTIFY_MOUNT_EXPIRY, 0);
>  		list_move(&mnt->mnt_expire, &graveyard);
>  	}
>  	while (!list_empty(&graveyard)) {
> 
> 
