Return-Path: <linux-fsdevel+bounces-78450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAZyCgQKoGm4fQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:53:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 816051A2EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BCE31214DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D15395DAD;
	Thu, 26 Feb 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiSsZ5YY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F1396B61;
	Thu, 26 Feb 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095710; cv=none; b=HeUY2ez7/kas5wYBqK/LD7zjoM3I/qkIn85azywGKSQL5zDuSN+zN93bXrU+4KF0uHk2KMmT1hBDcSMK85WAVTKj0dgKSwpslZuJuhJRbFAbhUDpOOT5x0lwiHGNlVNQGv2dogkAr/1h6USkHJL3q2aMEoFPHii0ASgSopT7Hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095710; c=relaxed/simple;
	bh=w4oVPVQRMVcLrJZ9FE68GA/q3tGqL3PF88KSsK03EaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQKLcroxNG/Bv3OSiofSG8jOXe8PHvIlzHYX0NoITosYeMN1P0ZBvctxDXGB8UYB5o64mLuPMnMlFBN1IcRXisXP2OIE27jDADBW+bOhl03iCIURroytAK7zdhJoPO49NQH0NiQRwKxd0/2TV51SmSBY5zkcpHCyEiCJSOF6Hrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiSsZ5YY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE446C19425;
	Thu, 26 Feb 2026 08:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772095709;
	bh=w4oVPVQRMVcLrJZ9FE68GA/q3tGqL3PF88KSsK03EaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiSsZ5YYuKxaWZM6sd4kOli6PcyX95Q/98BaXY6hhtk1sgAkD587FShCq4l5RXBhw
	 jU/RKIyw7dZiXOuR73Vfkr6dCI80yhPEoAXeNb92NU1SAC5+RCkWJ+oqQelPQfwePE
	 HRgM1DJlEZVfTzD3ZY+RaPTKIDFzg4BX948BjA6MfZnnRFrK8nVb4zBR+vbdzhjH80
	 cNeayPzW06T5LPfaWvUhf8l4ejlQtrqfiB/Z3VjF7UIRb3jStq7N+6qQscYbyPvFjA
	 Wo6gsnB7f6fMpvd2cHNT//yxPFGg5KJFjE6yNrz0Q9KTopnirFgGmBClyjg05A7Xhe
	 oRt9fLNKrfyRw==
Date: Thu, 26 Feb 2026 09:48:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>, Jan Kara <jack@suse.com>, 
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
Message-ID: <20260226-alimente-kunst-fb9eae636deb@brauner>
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224163908.44060-2-cel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78450-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,gmail.com];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 816051A2EEB
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:39:06AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Kernel subsystems occasionally need notification when a filesystem
> is unmounted. Until now, the only mechanism available is the fs_pin
> infrastructure, which has limited adoption (only BSD process
> accounting uses it) and VFS maintainers consider it deprecated.
> 
> Add an SRCU notifier chain that fires during mount teardown,
> following the pattern established by lease_notifier_chain in
> fs/locks.c. The notifier fires after processing stuck children but
> before fsnotify_vfsmount_delete(), at which point SB_ACTIVE is
> still set and the superblock remains fully accessible.

What I don't understand is why you need this per-mount especially
because you say above "when a filesystem is mounted. Could you explain
this in some more details, please?

Also this should take namespaces into account somehow, right? As Al
correctly observed anything that does CLONE_NEWNS and inherits your
mountable will generate notifications. Like, if systemd spawns services,
if a container runtime start, if someone uses unshare you'll get
absolutely flooded with events. I'm pretty sure that is not what you
want and that is defo not what the VFS should do...

Another thing: These ad-hoc notifiers are horrific. So I'm pitching
another idea and I hope that Jan and Amir can tell me that this is
doable...

Can we extend fsnotify so that it's possible for a filesystem to
register "internal watches" on relevant objects such as mounts and
superblocks and get notified and execute blocking stuff if needed.

Then we don't have to add another set of custom notification mechanisms
but have it available in a single subsystem and uniformely available.

> The SRCU notifier type is chosen because:
>  - Unmount is relatively infrequent, so the overhead of SRCU
>    registration and unregistration is acceptable
>  - Callbacks run in process context and may sleep
>  - No cache bounces occur during chain traversal
> 
> NFSD requires this mechanism to revoke NFSv4 state (opens, locks,
> delegations) and release cached file handles when a filesystem is
> unmounted, avoiding EBUSY errors that occur when client state pins
> the mount.
> 
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/namespace.c        | 69 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mount.h |  4 +++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ebe19ded293a..269e007e9312 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -34,6 +34,7 @@
>  #include <linux/mnt_idmapping.h>
>  #include <linux/pidfs.h>
>  #include <linux/nstree.h>
> +#include <linux/notifier.h>
>  
>  #include "pnode.h"
>  #include "internal.h"
> @@ -73,6 +74,70 @@ static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
>  
> +/*
> + * Kernel subsystems can register to be notified when a filesystem is
> + * unmounted. This is used by (e.g.) nfsd to revoke state associated
> + * with files on the filesystem being unmounted.
> + */
> +static struct srcu_notifier_head umount_notifier_chain;
> +
> +/**
> + * umount_register_notifier - register for unmount notifications
> + * @nb: notifier_block to register
> + *
> + * Registers a notifier to be called when any filesystem is
> + * unmounted. The callback is invoked after stuck children are
> + * processed but before fsnotify_vfsmount_delete(), while SB_ACTIVE
> + * is still set and the superblock remains fully accessible.
> + *
> + * Callback signature:
> + *   int (*callback)(struct notifier_block *nb,
> + *                   unsigned long val, void *data)
> + *
> + *   @val:  always 0 (reserved for future extension)
> + *   @data: struct super_block * for the unmounting filesystem
> + *
> + * Callbacks run in process context and may sleep. Return
> + * NOTIFY_DONE from the callback; return values are ignored and
> + * cannot prevent unmount. Callbacks must handle their own error
> + * recovery internally.
> + *
> + * The notification fires once per mount instance. Bind mounts of
> + * the same filesystem trigger multiple callbacks with the same
> + * super_block pointer; callbacks must handle duplicate
> + * notifications idempotently.
> + *
> + * The super_block pointer is valid only for the duration of the
> + * callback. Callbacks must not retain this pointer for
> + * asynchronous use; to access the filesystem after the callback
> + * returns, acquire a separate reference (e.g., via an open file)
> + * during callback execution.
> + *
> + * Returns: 0 on success, negative error code on failure.
> + */
> +int umount_register_notifier(struct notifier_block *nb)
> +{
> +	return srcu_notifier_chain_register(&umount_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(umount_register_notifier);
> +
> +/**
> + * umount_unregister_notifier - unregister an unmount notifier
> + * @nb: notifier_block to unregister
> + *
> + * Unregisters a previously registered notifier. This function may
> + * block due to SRCU synchronization.
> + *
> + * Must not be called from within a notifier callback; doing so
> + * causes deadlock. Must be called before module unload if the
> + * notifier_block resides in module memory.
> + */
> +void umount_unregister_notifier(struct notifier_block *nb)
> +{
> +	srcu_notifier_chain_unregister(&umount_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(umount_unregister_notifier);
> +
>  /* Don't allow confusion with old 32bit mount ID */
>  #define MNT_UNIQUE_ID_OFFSET (1ULL << 31)
>  static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
> @@ -1307,6 +1372,8 @@ static void cleanup_mnt(struct mount *mnt)
>  		hlist_del(&m->mnt_umount);
>  		mntput(&m->mnt);
>  	}
> +	/* Notify registrants before superblock deactivation */
> +	srcu_notifier_call_chain(&umount_notifier_chain, 0, mnt->mnt.mnt_sb);
>  	fsnotify_vfsmount_delete(&mnt->mnt);
>  	dput(mnt->mnt.mnt_root);
>  	deactivate_super(mnt->mnt.mnt_sb);
> @@ -6189,6 +6256,8 @@ void __init mnt_init(void)
>  {
>  	int err;
>  
> +	srcu_init_notifier_head(&umount_notifier_chain);
> +
>  	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
>  			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
>  
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index acfe7ef86a1b..9a46ab40dffd 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -21,6 +21,7 @@ struct file_system_type;
>  struct fs_context;
>  struct file;
>  struct path;
> +struct notifier_block;
>  
>  enum mount_flags {
>  	MNT_NOSUID	= 0x01,
> @@ -109,4 +110,7 @@ extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
>  
>  extern int cifs_root_data(char **dev, char **opts);
>  
> +int umount_register_notifier(struct notifier_block *nb);
> +void umount_unregister_notifier(struct notifier_block *nb);
> +
>  #endif /* _LINUX_MOUNT_H */
> -- 
> 2.53.0
> 

