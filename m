Return-Path: <linux-fsdevel+bounces-48087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D8BAA9502
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD97418928A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98492512E1;
	Mon,  5 May 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7m8MLe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645713D531
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453829; cv=none; b=fHHbSCAifW1/h0q3xgBCAIQTddcAmngFM0rPqwh3QP4eR5fqPGhEKj8ynpGyypbEBzCn5Wqjxbp47WEGWdEZhM7dG8gMfrVZlGVKVhvF5fv+Vah7V68sACMfS3Gc22ptNE7aQ4XJ8k4TsAYSjstVOpzyc7bRMB0hAnjGlAMPbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453829; c=relaxed/simple;
	bh=V/uKmHC8mfiJNdGzqiFBwM+C6/c1zlm6q8/0JceJZNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoXz08jSgExpLAgEgOiIPtQkTPMLWGRTljAJavvRsk8GLL0okbJ3JORzgOvXV78NWPoAOk39phMYRhrFOXKsQrNn9gucf9/2kTN5h8GPXs7Kx4yClhYyZtC5yyaNspSV9bczElSMXxwKL7vbakT0ZPXzydEFCnNijg7VJgvSXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7m8MLe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D3CC4CEE4;
	Mon,  5 May 2025 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746453828;
	bh=V/uKmHC8mfiJNdGzqiFBwM+C6/c1zlm6q8/0JceJZNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7m8MLe7MiCW8GtaB/EhgajDyP2USELGIM3VQSgRTdu28vLOAgDxLMrTySacGhyZC
	 f8+CxQIUBNnawWPDxtQzQJW6HzW6+PuIypmCc/H7YLq8dd9q3HNwqPcz09iGnGZH3y
	 JQTmATqcI6+Sk2MwdDjxCydJH0NipzbZU5Kx/+bwn1Z9eiY3aCO/34OqQFxQe4d1uq
	 l8p/I8U+SlM+o2gSxIvw2tRGPoybH4Hl2kppv8s7ZFMPd6C5zZdJ/7176zE2AOVi7s
	 Q7Gs0DnYH2O5S9wRKg56rBRja6OqZpk27IZSMh8qG6f6R+oB8H4HEIrr6vQYf28uU4
	 Q/Hd1QuCiZLwg==
Date: Mon, 5 May 2025 16:03:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Melissa Wen <mwen@igalia.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][CFT][RFC] sanitize handling of long-term internal mounts
Message-ID: <20250505-sitzen-anbauen-c7b82c65ac5d@brauner>
References: <20250503230251.GA2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503230251.GA2023217@ZenIV>

> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1258,6 +1258,15 @@ struct vfsmount *fc_mount(struct fs_context *fc)
>  }
>  EXPORT_SYMBOL(fc_mount);
>  
> +struct vfsmount *fc_mount_longterm(struct fs_context *fc)
> +{
> +	struct vfsmount *mnt = fc_mount(fc);
> +	if (!IS_ERR(mnt))
> +		real_mount(mnt)->mnt_ns = MNT_NS_INTERNAL;
> +	return mnt;
> +}
> +EXPORT_SYMBOL(fc_mount_longterm);
> +
>  struct vfsmount *vfs_kern_mount(struct file_system_type *type,
>  				int flags, const char *name,
>  				void *data)
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index dcc17ce8a959..9376d76dd61f 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -94,6 +94,7 @@ int mnt_get_write_access(struct vfsmount *mnt);
>  void mnt_put_write_access(struct vfsmount *mnt);
>  
>  extern struct vfsmount *fc_mount(struct fs_context *fc);
> +extern struct vfsmount *fc_mount_longterm(struct fs_context *fc);
>  extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
>  extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
>  				      int flags, const char *name,
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 35b4f8659904..daabf7f02b63 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -482,7 +482,7 @@ static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
>  	put_user_ns(fc->user_ns);
>  	fc->user_ns = get_user_ns(ctx->ipc_ns->user_ns);
>  
> -	mnt = fc_mount(fc);
> +	mnt = fc_mount_longterm(fc);
>  	put_fs_context(fc);
>  	return mnt;
>  }

All seems fine to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

