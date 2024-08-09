Return-Path: <linux-fsdevel+bounces-25513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54C94CFB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB4CB232A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49164194136;
	Fri,  9 Aug 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtv54B8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5319147D;
	Fri,  9 Aug 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204834; cv=none; b=BR1zFiYWHXKBpkVQeJ1UwWZu4RyZr7D7EAqhkLcm7JzPc1X6gBqNoxIdqnTB/NUuy6GEH4IURs4AG/9h8xktYE7blBt0xxyAS6Wsr25cTs44t/zSy4eMP4yByCniZGrV/6ylhK/r6fEH/51AFV8ohBjhD91/TJ4n7MG5C28ykl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204834; c=relaxed/simple;
	bh=rA7QXJiuU0ojRZ+tgpnpFxX0BYP6BSa9IUEKBTXMlmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC3/VrsbbTY5qhHSir0dZbii+TuybFjLMoj9H3Z+0aZuLcmh4ZWi9MHLF24ZuJX+Y5u6OUXxVZ05jr2eLtjvQwMT1t74DiO33sucjvF3nOFQHdF7bkkxqjSZ910OoD5xQ4RKNfEGurBARMr/TU/Y8g2n0BuI3Vxf1EsXaV4CFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtv54B8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BE4C4AF0D;
	Fri,  9 Aug 2024 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204834;
	bh=rA7QXJiuU0ojRZ+tgpnpFxX0BYP6BSa9IUEKBTXMlmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vtv54B8mEgTkRhJEQimvDitDCsdE27In6e6HULBnlAYvCFRyjpPX1SOFgSIjnhlKS
	 eN9eHP9PnKWo6fYcqsJQqPZPMpDH2ijEP/FKeBdmqnadelFtDNqfmr13VzcOPO31yS
	 jdLAwTfb0dqbHWRmT/xWuH/tIDELwNCcOd7HSfEmQ1ubiGwfyACKL8xmTrfCiNtoIQ
	 RvvPqAdmAtOy6XiqweVcCjzCk7kbs1i9vswf3jEFOHUPAsn7oPjaDBzUiuws6zj3AO
	 +XJn6J6isv7T845HTM5joCd3jnfHYwnK/9E1MOy8o0QvUoHJEdTQIAZ1YXc8yIyod6
	 JfNaHa3jM1BZQ==
Date: Fri, 9 Aug 2024 14:00:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 06/16] fanotify: pass optional file access range in
 pre-content event
Message-ID: <20240809-pufferzone-hallt-8825f2369b89@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <4b45f1d898fdb67c8e493b90d99ca85ce45fd8d9.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b45f1d898fdb67c8e493b90d99ca85ce45fd8d9.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:08PM GMT, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> We would like to add file range information to pre-content events.
> 
> Pass a struct file_range with optional offset and length to event handler
> along with pre-content permission event.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c    | 10 ++++++++--
>  fs/notify/fanotify/fanotify.h    |  2 ++
>  include/linux/fsnotify.h         | 17 ++++++++++++++++-
>  include/linux/fsnotify_backend.h | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index b163594843f5..4e8dce39fa8f 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -549,9 +549,13 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
>  	return &pevent->fae;
>  }
>  
> -static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
> +static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
> +							int data_type,
>  							gfp_t gfp)
>  {
> +	const struct path *path = fsnotify_data_path(data, data_type);
> +	const struct file_range *range =
> +			    fsnotify_data_file_range(data, data_type);
>  	struct fanotify_perm_event *pevent;
>  
>  	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
> @@ -565,6 +569,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
>  	pevent->hdr.len = 0;
>  	pevent->state = FAN_EVENT_INIT;
>  	pevent->path = *path;
> +	pevent->ppos = range ? range->ppos : NULL;
> +	pevent->count = range ? range->count : 0;
>  	path_get(path);
>  
>  	return &pevent->fae;
> @@ -802,7 +808,7 @@ static struct fanotify_event *fanotify_alloc_event(
>  	old_memcg = set_active_memcg(group->memcg);
>  
>  	if (fanotify_is_perm_event(mask)) {
> -		event = fanotify_alloc_perm_event(path, gfp);
> +		event = fanotify_alloc_perm_event(data, data_type, gfp);
>  	} else if (fanotify_is_error_event(mask)) {
>  		event = fanotify_alloc_error_event(group, fsid, data,
>  						   data_type, &hash);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index e5ab33cae6a7..93598b7d5952 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -425,6 +425,8 @@ FANOTIFY_PE(struct fanotify_event *event)
>  struct fanotify_perm_event {
>  	struct fanotify_event fae;
>  	struct path path;
> +	const loff_t *ppos;		/* optional file range info */
> +	size_t count;
>  	u32 response;			/* userspace answer to the event */
>  	unsigned short state;		/* state of the event */
>  	int fd;		/* fd we passed to userspace for this event */
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index a28daf136fea..4609d9b6b087 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -132,6 +132,21 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>  }
>  
>  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> +static inline int fsnotify_file_range(struct file *file, __u32 mask,
> +				      const loff_t *ppos, size_t count)
> +{
> +	struct file_range range;
> +
> +	if (file->f_mode & FMODE_NONOTIFY)
> +		return 0;
> +
> +	range.path = &file->f_path;
> +	range.ppos = ppos;
> +	range.count = count;
> +	return fsnotify_parent(range.path->dentry, mask, &range,
> +			       FSNOTIFY_EVENT_FILE_RANGE);
> +}
> +
>  /*
>   * fsnotify_file_area_perm - permission hook before access/modify of file range
>   */
> @@ -175,7 +190,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
>  	else
>  		return 0;
>  
> -	return fsnotify_file(file, fsnotify_mask);
> +	return fsnotify_file_range(file, fsnotify_mask, ppos, count);
>  }
>  
>  /*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 200a5e3b1cd4..276320846bfd 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -298,6 +298,7 @@ static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
>  /* When calling fsnotify tell it if the data is a path or inode */
>  enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_NONE,
> +	FSNOTIFY_EVENT_FILE_RANGE,
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
>  	FSNOTIFY_EVENT_DENTRY,
> @@ -310,6 +311,17 @@ struct fs_error_report {
>  	struct super_block *sb;
>  };
>  
> +struct file_range {
> +	const struct path *path;
> +	const loff_t *ppos;
> +	size_t count;
> +};
> +
> +static inline const struct path *file_range_path(const struct file_range *range)
> +{
> +	return range->path;
> +}
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  {
>  	switch (data_type) {
> @@ -319,6 +331,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  		return d_inode(data);
>  	case FSNOTIFY_EVENT_PATH:
>  		return d_inode(((const struct path *)data)->dentry);
> +	case FSNOTIFY_EVENT_FILE_RANGE:
> +		return d_inode(file_range_path(data)->dentry);
>  	case FSNOTIFY_EVENT_ERROR:
>  		return ((struct fs_error_report *)data)->inode;
>  	default:
> @@ -334,6 +348,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
>  		return (struct dentry *)data;
>  	case FSNOTIFY_EVENT_PATH:
>  		return ((const struct path *)data)->dentry;
> +	case FSNOTIFY_EVENT_FILE_RANGE:
> +		return file_range_path(data)->dentry;
>  	default:
>  		return NULL;
>  	}
> @@ -345,6 +361,8 @@ static inline const struct path *fsnotify_data_path(const void *data,
>  	switch (data_type) {
>  	case FSNOTIFY_EVENT_PATH:
>  		return data;
> +	case FSNOTIFY_EVENT_FILE_RANGE:
> +		return file_range_path(data);
>  	default:
>  		return NULL;
>  	}
> @@ -360,6 +378,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
>  		return ((struct dentry *)data)->d_sb;
>  	case FSNOTIFY_EVENT_PATH:
>  		return ((const struct path *)data)->dentry->d_sb;
> +	case FSNOTIFY_EVENT_FILE_RANGE:
> +		return file_range_path(data)->dentry->d_sb;
>  	case FSNOTIFY_EVENT_ERROR:
>  		return ((struct fs_error_report *) data)->sb;
>  	default:
> @@ -379,6 +399,18 @@ static inline struct fs_error_report *fsnotify_data_error_report(
>  	}
>  }
>  
> +static inline const struct file_range *fsnotify_data_file_range(
> +							const void *data,
> +							int data_type)
> +{
> +	switch (data_type) {
> +	case FSNOTIFY_EVENT_FILE_RANGE:
> +		return (struct file_range *)data;
> +	default:
> +		return NULL;

Wouldn't you want something like

case FSNOTIFY_EVENT_NONE
	return NULL;
default:
	WARN_ON_ONCE(data_type);
	return NULL;

to guard against garbage being passed to fsnotify_data_file_range()?

