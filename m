Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2810323BBBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgHDOGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgHDOGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:06:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616CDC06179E
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 07:06:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so16002478ejb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X3HxHy5S4PrUuz449H0o4Ag1oc/qbWvdkKBe/LVNW6o=;
        b=nshr+bmSps+Z7Uuy0tBMZmI5R64n0GR2pwPswja3xFrnVIu77A7IfAVGF+f+3jzyQr
         ou1xZrFIjDGUn416vFDrNmnmG7EHS773Qoi9IU4jFK+TXGJl+G+SxvxzS02kJGF0tyH1
         xw6qRfQ7OiDClfzyh3TRcSc2xzdPP6HiTHDmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X3HxHy5S4PrUuz449H0o4Ag1oc/qbWvdkKBe/LVNW6o=;
        b=CKeTorMrdXPNa7rjbHfCkk/fYN48STn78EB9Eax2QEGlQdABVHoom/AnMuTfVTuQBq
         6LPbLBjQzKg9I2gr1Mvpq4ct/41jU6v0m+mut1TwTcCRcXTqZF9/C5+BUUCxhM0pei7r
         4UJddRW202cMsd5IUQicgS0uOu/iG7fsIGXXOlSpy2sX+WmlVa/z8y+onuGyt/RpuROO
         IB+V36HH+/mEYA9a4E5vJFTxEtnlls9PzQjsbjQiD0TOln8wF/5EGag0xgCI3R6q+55v
         n78h7w7vqaS4PVCC6yhM1NIOpDhc9flt0mcA0zHXo+D7k2TTiBcb9vb8P3rRH9ysXHRX
         5ARQ==
X-Gm-Message-State: AOAM532qnIpxC045cbMz+yRgO+U3BoWXfiq9zFvVhnqmm/42CrSviM0W
        Dnj89A2+iWf+KaErmeUfgAAwZw==
X-Google-Smtp-Source: ABdhPJzA1e2vU8ujQhGlEAruZavvrK8zeb9pU6jc/nq4dJTJ6iNsb8oAxzlQwmXFzPNyV8brMfMXQA==
X-Received: by 2002:a17:906:b082:: with SMTP id x2mr2563546ejy.349.1596549961631;
        Tue, 04 Aug 2020 07:06:01 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g25sm18338511ejh.110.2020.08.04.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:06:01 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:05:58 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] fsinfo: Add an attribute that lists all the
 visible mounts in a namespace [ver #21]
Message-ID: <20200804140558.GF32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646191446.1784947.11228235431863356055.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159646191446.1784947.11228235431863356055.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:38:34PM +0100, David Howells wrote:
> Add a filesystem attribute that exports a list of all the visible mounts in
> a namespace, given the caller's chroot setting.  The returned list is an
> array of:
> 
> 	struct fsinfo_mount_child {
> 		__u64	mnt_unique_id;
> 		__u32	mnt_id;
> 		__u32	parent_id;
> 		__u32	mnt_notify_sum;
> 		__u32	sb_notify_sum;
> 	};
> 
> where each element contains a once-in-a-system-lifetime unique ID, the
> mount ID (which may get reused), the parent mount ID and sums of the
> notification/change counters for the mount and its superblock.

The change counters are currently conditional on CONFIG_MOUNT_NOTIFICATIONS.
Is this is intentional?

> 
> This works with a read lock on the namespace_sem, but ideally would do it
> under the RCU read lock only.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fsinfo.c                 |    1 +
>  fs/internal.h               |    1 +
>  fs/namespace.c              |   37 +++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fsinfo.h |    4 ++++
>  samples/vfs/test-fsinfo.c   |   22 ++++++++++++++++++++++
>  5 files changed, 65 insertions(+)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index 0540cce89555..f230124ffdf5 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -296,6 +296,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
>  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
>  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT_FULL,	fsinfo_generic_mount_point_full),
>  	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
> +	FSINFO_LIST	(FSINFO_ATTR_MOUNT_ALL,		fsinfo_generic_mount_all),
>  	{}
>  };
>  
> diff --git a/fs/internal.h b/fs/internal.h
> index cb5edcc7125a..267b4aaf0271 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -102,6 +102,7 @@ extern int fsinfo_generic_mount_topology(struct path *, struct fsinfo_context *)
>  extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
>  extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
>  extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
> +extern int fsinfo_generic_mount_all(struct path *, struct fsinfo_context *);
>  
>  /*
>   * fs_struct.c
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 122c12f9512b..1f2e06507244 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4494,4 +4494,41 @@ int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
>  	return ctx->usage;
>  }
>  
> +/*
> + * Return information about all the mounts in the namespace referenced by the
> + * path.
> + */
> +int fsinfo_generic_mount_all(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct mnt_namespace *ns;
> +	struct mount *m, *p;
> +	struct path chroot;
> +	bool allow;
> +
> +	m = real_mount(path->mnt);
> +	ns = m->mnt_ns;
> +
> +	get_fs_root(current->fs, &chroot);
> +	rcu_read_lock();
> +	allow = are_paths_connected(&chroot, path) || capable(CAP_SYS_ADMIN);
> +	rcu_read_unlock();
> +	path_put(&chroot);
> +	if (!allow)
> +		return -EPERM;
> +
> +	down_read(&namespace_sem);
> +
> +	list_for_each_entry(p, &ns->list, mnt_list) {

This is missing locking and check added by commit 9f6c61f96f2d ("proc/mounts:
add cursor").

> +		struct path mnt_root;
> +
> +		mnt_root.mnt	= &p->mnt;
> +		mnt_root.dentry	= p->mnt.mnt_root;
> +		if (are_paths_connected(path, &mnt_root))
> +			fsinfo_store_mount(ctx, p, p == m);
> +	}
> +
> +	up_read(&namespace_sem);
> +	return ctx->usage;
> +}
> +
>  #endif /* CONFIG_FSINFO */
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> index 81329de6905e..e40192d98648 100644
> --- a/include/uapi/linux/fsinfo.h
> +++ b/include/uapi/linux/fsinfo.h
> @@ -37,6 +37,7 @@
>  #define FSINFO_ATTR_MOUNT_POINT_FULL	0x203	/* Absolute path of mount (string) */
>  #define FSINFO_ATTR_MOUNT_TOPOLOGY	0x204	/* Mount object topology */
>  #define FSINFO_ATTR_MOUNT_CHILDREN	0x205	/* Children of this mount (list) */
> +#define FSINFO_ATTR_MOUNT_ALL		0x206	/* List all mounts in a namespace (list) */
>  
>  #define FSINFO_ATTR_AFS_CELL_NAME	0x300	/* AFS cell name (string) */
>  #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
> @@ -128,6 +129,8 @@ struct fsinfo_mount_topology {
>  /*
>   * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
>   * - An extra element is placed on the end representing the parent mount.
> + *
> + * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_ALL).
>   */
>  struct fsinfo_mount_child {
>  	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
> @@ -139,6 +142,7 @@ struct fsinfo_mount_child {
>  };
>  
>  #define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
> +#define FSINFO_ATTR_MOUNT_ALL__STRUCT struct fsinfo_mount_child
>  
>  /*
>   * Information struct for fsinfo(FSINFO_ATTR_STATFS).
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index 374825ab85b0..596fa5e71762 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -365,6 +365,27 @@ static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
>  	       (unsigned long long)r->mnt_notify_sum, mp);
>  }
>  
> +static void dump_fsinfo_generic_mount_all(void *reply, unsigned int size)
> +{
> +	struct fsinfo_mount_child *r = reply;
> +	ssize_t mplen;
> +	char path[32], *mp;
> +
> +	struct fsinfo_params params = {
> +		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
> +		.request	= FSINFO_ATTR_MOUNT_POINT_FULL,
> +	};
> +
> +	sprintf(path, "%u", r->mnt_id);
> +	mplen = get_fsinfo(path, "FSINFO_ATTR_MOUNT_POINT_FULL", &params, (void **)&mp);
> +	if (mplen < 0)
> +		mp = "-";
> +
> +	printf("%5x %5x %12llx %10llu %s\n",
> +	       r->mnt_id, r->parent_id, (unsigned long long)r->mnt_unique_id,
> +	       r->mnt_notify_sum, mp);
> +}
> +
>  static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
>  {
>  	struct fsinfo_afs_server_address *f = reply;
> @@ -492,6 +513,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
>  	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
>  	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
>  	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
> +	FSINFO_LIST	(FSINFO_ATTR_MOUNT_ALL,		fsinfo_generic_mount_all),
>  
>  	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
>  	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
> 
> 
