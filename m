Return-Path: <linux-fsdevel+bounces-25555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8858794D657
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E5A1C20DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677D0155CBD;
	Fri,  9 Aug 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rKg0ti5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6215321A3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228605; cv=none; b=rmVBv9tt99ZVN3PTxAPlEPvu9ctkhnyizeRIY4lb+A0DFaSHQVoIBty9K9QPo5STeSB2Qr6ONpU7ZMzRgs7/DNXtB/g9TsSHGuE86nYeqiuEU88yYmGdW0OoIW9DxLRqZsfTeGVf4Q9mC1aOlCvVOFPzCor9sixbFhhc2iclVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228605; c=relaxed/simple;
	bh=ReZWiD8PBBObWE/f+6TY1Bh0qeipj/egbVCUk5IxUUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czBexd2LoUeinmI3yc+5+VGNx0qVMIjMFOdJ/Pa8nARTAK9HMRb9gbnJnwZamBImxH+j6HUbN7JBK74r0S1lRulWA6P1APBn68xu9aOCkE6xR2tYEPag5DnboumtllWmf560IcWjKtmx6nVEG2CWZ97lLWzQ07FuhMDkoubxu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rKg0ti5t; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1dcc7bc05so156001885a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723228602; x=1723833402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2qvMVaO+2tn16aUZgf387zYu7IZxhTnuN11dniOqrE=;
        b=rKg0ti5tBajANzUMaBIJ4DD0sWS9XxjlKzjcyFzQP4u5+ZWAHAmlIiEe4Pp3uxkBIm
         vlkkb1Tihydpl75XbJxdlt6pwsVx4IrxOOGqitJTjUS/NO17kCa4fh/7c6GlzLilQPPT
         joq3Tz0EReOQY1g/CHcpb+LujQ4e1mBFVfxUl4+VrPdbEXoKGUTaXA/NdNUo5806qkdG
         oTvxwGnu8Eu/16isCrWlTwmx3kpRO/gGa9f39DTBm4cMuS9hLOfYPaZQI8iFVqk3iUl8
         1dJo8/f/ut3oYIDPmKUeC1ZV9sIjz7gBuq4yS91ov6kuNijF3mWpe4BO2s3YaHQY6qiq
         op/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228602; x=1723833402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2qvMVaO+2tn16aUZgf387zYu7IZxhTnuN11dniOqrE=;
        b=LFIqjnsaqbW1Ue2fuAM5fw+VRjR3g4S6tZYw9PMw9LfVCY2BqImuptoaoB1qce0xpv
         B1gz8uG6VDoB5jojqWhFC5xJMG4XtUEWW5lAHN5MSPRioi5pdz72zbOwEL+2lqZSm5K3
         8ygZViSshDuCDDXBJ8EvF8XNJyRwvGsFduHaJVCncSGgV/251RE6QvvKY/qQYPR+TD9y
         FH1CkCRoerMmKy66Yh1oKc9n8bZI5IE+KPhWfwQf3aBw0Vd0L76HwIlmuvL6KXTn3m+D
         A/02AfWpj8wDlHg+wq5w2YQ16sdfaV7TaIZcalghTqQRMQUwYv6CoOhoyQ0LOdPuDagv
         wM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM3HhZOSVoFUZUWmbKDdCkZEOVzIPy8fHRu6+0abHfyVYfnMCSL02F+L88gU+7frtB45KBZpcghzog03oPO4k2SPmLC8Md+I1l6fJDUA==
X-Gm-Message-State: AOJu0YzDKHKWAzcuPbThW9NRpBMaARkxv52jzW/6Eyze38+F4vJP0fMg
	mymJx0UsYzCk7GD5DP5+HzI9M6d7zAzMbvDJ+W+i0Q/HRVC5Xio8jOphz9dY80g=
X-Google-Smtp-Source: AGHT+IFLq42sgusckEYcM6sbKQDeN9I3kZboPnMR/0/fVu9drp9t9SgRXq5Ld+Bgl0uuODyPzBjEhw==
X-Received: by 2002:a05:620a:28d5:b0:79e:fef3:ba3 with SMTP id af79cd13be357-7a4c1792161mr276645785a.3.1723228601550;
        Fri, 09 Aug 2024 11:36:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d78c78sm3721285a.56.2024.08.09.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:36:41 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:36:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 06/16] fanotify: pass optional file access range in
 pre-content event
Message-ID: <20240809183640.GA772468@perftesting>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <4b45f1d898fdb67c8e493b90d99ca85ce45fd8d9.1723144881.git.josef@toxicpanda.com>
 <20240809-pufferzone-hallt-8825f2369b89@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-pufferzone-hallt-8825f2369b89@brauner>

On Fri, Aug 09, 2024 at 02:00:29PM +0200, Christian Brauner wrote:
> On Thu, Aug 08, 2024 at 03:27:08PM GMT, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> > 
> > We would like to add file range information to pre-content events.
> > 
> > Pass a struct file_range with optional offset and length to event handler
> > along with pre-content permission event.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c    | 10 ++++++++--
> >  fs/notify/fanotify/fanotify.h    |  2 ++
> >  include/linux/fsnotify.h         | 17 ++++++++++++++++-
> >  include/linux/fsnotify_backend.h | 32 ++++++++++++++++++++++++++++++++
> >  4 files changed, 58 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index b163594843f5..4e8dce39fa8f 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -549,9 +549,13 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
> >  	return &pevent->fae;
> >  }
> >  
> > -static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
> > +static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
> > +							int data_type,
> >  							gfp_t gfp)
> >  {
> > +	const struct path *path = fsnotify_data_path(data, data_type);
> > +	const struct file_range *range =
> > +			    fsnotify_data_file_range(data, data_type);
> >  	struct fanotify_perm_event *pevent;
> >  
> >  	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
> > @@ -565,6 +569,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
> >  	pevent->hdr.len = 0;
> >  	pevent->state = FAN_EVENT_INIT;
> >  	pevent->path = *path;
> > +	pevent->ppos = range ? range->ppos : NULL;
> > +	pevent->count = range ? range->count : 0;
> >  	path_get(path);
> >  
> >  	return &pevent->fae;
> > @@ -802,7 +808,7 @@ static struct fanotify_event *fanotify_alloc_event(
> >  	old_memcg = set_active_memcg(group->memcg);
> >  
> >  	if (fanotify_is_perm_event(mask)) {
> > -		event = fanotify_alloc_perm_event(path, gfp);
> > +		event = fanotify_alloc_perm_event(data, data_type, gfp);
> >  	} else if (fanotify_is_error_event(mask)) {
> >  		event = fanotify_alloc_error_event(group, fsid, data,
> >  						   data_type, &hash);
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > index e5ab33cae6a7..93598b7d5952 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -425,6 +425,8 @@ FANOTIFY_PE(struct fanotify_event *event)
> >  struct fanotify_perm_event {
> >  	struct fanotify_event fae;
> >  	struct path path;
> > +	const loff_t *ppos;		/* optional file range info */
> > +	size_t count;
> >  	u32 response;			/* userspace answer to the event */
> >  	unsigned short state;		/* state of the event */
> >  	int fd;		/* fd we passed to userspace for this event */
> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index a28daf136fea..4609d9b6b087 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -132,6 +132,21 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
> >  }
> >  
> >  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> > +static inline int fsnotify_file_range(struct file *file, __u32 mask,
> > +				      const loff_t *ppos, size_t count)
> > +{
> > +	struct file_range range;
> > +
> > +	if (file->f_mode & FMODE_NONOTIFY)
> > +		return 0;
> > +
> > +	range.path = &file->f_path;
> > +	range.ppos = ppos;
> > +	range.count = count;
> > +	return fsnotify_parent(range.path->dentry, mask, &range,
> > +			       FSNOTIFY_EVENT_FILE_RANGE);
> > +}
> > +
> >  /*
> >   * fsnotify_file_area_perm - permission hook before access/modify of file range
> >   */
> > @@ -175,7 +190,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
> >  	else
> >  		return 0;
> >  
> > -	return fsnotify_file(file, fsnotify_mask);
> > +	return fsnotify_file_range(file, fsnotify_mask, ppos, count);
> >  }
> >  
> >  /*
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> > index 200a5e3b1cd4..276320846bfd 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -298,6 +298,7 @@ static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
> >  /* When calling fsnotify tell it if the data is a path or inode */
> >  enum fsnotify_data_type {
> >  	FSNOTIFY_EVENT_NONE,
> > +	FSNOTIFY_EVENT_FILE_RANGE,
> >  	FSNOTIFY_EVENT_PATH,
> >  	FSNOTIFY_EVENT_INODE,
> >  	FSNOTIFY_EVENT_DENTRY,
> > @@ -310,6 +311,17 @@ struct fs_error_report {
> >  	struct super_block *sb;
> >  };
> >  
> > +struct file_range {
> > +	const struct path *path;
> > +	const loff_t *ppos;
> > +	size_t count;
> > +};
> > +
> > +static inline const struct path *file_range_path(const struct file_range *range)
> > +{
> > +	return range->path;
> > +}
> > +
> >  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
> >  {
> >  	switch (data_type) {
> > @@ -319,6 +331,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
> >  		return d_inode(data);
> >  	case FSNOTIFY_EVENT_PATH:
> >  		return d_inode(((const struct path *)data)->dentry);
> > +	case FSNOTIFY_EVENT_FILE_RANGE:
> > +		return d_inode(file_range_path(data)->dentry);
> >  	case FSNOTIFY_EVENT_ERROR:
> >  		return ((struct fs_error_report *)data)->inode;
> >  	default:
> > @@ -334,6 +348,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
> >  		return (struct dentry *)data;
> >  	case FSNOTIFY_EVENT_PATH:
> >  		return ((const struct path *)data)->dentry;
> > +	case FSNOTIFY_EVENT_FILE_RANGE:
> > +		return file_range_path(data)->dentry;
> >  	default:
> >  		return NULL;
> >  	}
> > @@ -345,6 +361,8 @@ static inline const struct path *fsnotify_data_path(const void *data,
> >  	switch (data_type) {
> >  	case FSNOTIFY_EVENT_PATH:
> >  		return data;
> > +	case FSNOTIFY_EVENT_FILE_RANGE:
> > +		return file_range_path(data);
> >  	default:
> >  		return NULL;
> >  	}
> > @@ -360,6 +378,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
> >  		return ((struct dentry *)data)->d_sb;
> >  	case FSNOTIFY_EVENT_PATH:
> >  		return ((const struct path *)data)->dentry->d_sb;
> > +	case FSNOTIFY_EVENT_FILE_RANGE:
> > +		return file_range_path(data)->dentry->d_sb;
> >  	case FSNOTIFY_EVENT_ERROR:
> >  		return ((struct fs_error_report *) data)->sb;
> >  	default:
> > @@ -379,6 +399,18 @@ static inline struct fs_error_report *fsnotify_data_error_report(
> >  	}
> >  }
> >  
> > +static inline const struct file_range *fsnotify_data_file_range(
> > +							const void *data,
> > +							int data_type)
> > +{
> > +	switch (data_type) {
> > +	case FSNOTIFY_EVENT_FILE_RANGE:
> > +		return (struct file_range *)data;
> > +	default:
> > +		return NULL;
> 
> Wouldn't you want something like
> 
> case FSNOTIFY_EVENT_NONE
> 	return NULL;
> default:
> 	WARN_ON_ONCE(data_type);
> 	return NULL;
> 
> to guard against garbage being passed to fsnotify_data_file_range()?

We don't do this in any of the other helpers, and this is used generically in
fanotify_alloc_perm_event(), which handles having no range properly.  Thanks,

Josef

