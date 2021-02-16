Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA731CD13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 16:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBPPk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 10:40:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:52066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhBPPk0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:40:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39806AC90;
        Tue, 16 Feb 2021 15:39:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 068E61F2AA7; Tue, 16 Feb 2021 16:39:44 +0100 (CET)
Date:   Tue, 16 Feb 2021 16:39:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] fanotify: mix event info into merge key hash
Message-ID: <20210216153943.GD21108@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202162010.305971-7-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-02-21 18:20:09, Amir Goldstein wrote:
> Improve the balance of hashed queue lists by mixing more event info
> relevant for merge.
> 
> For example, all FAN_CREATE name events in the same dir used to have the
> same merge key based on the dir inode.  With this change the created
> file name is mixed into the merge key.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c | 33 +++++++++++++++++++++++++++------
>  fs/notify/fanotify/fanotify.h | 20 +++++++++++++++++---
>  2 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6d3807012851..b19fef1c6f64 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
...
> @@ -476,8 +485,11 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
>  
>  	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
>  	ffe->fsid = *fsid;
> -	fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id),
> -			   gfp);
> +	fh = &ffe->object_fh;
> +	fanotify_encode_fh(fh, id, fanotify_encode_fh_len(id), gfp);
> +
> +	/* Mix fsid+fid info into event merge key */
> +	ffe->fae.info_hash = full_name_hash(ffe->fskey, fanotify_fh_buf(fh), fh->len);

Is it really sensible to hash FID with full_name_hash()? It would make more
sense to treat it as binary data, not strings...

>  	return &ffe->fae;
>  }
> @@ -517,6 +529,9 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  	if (file_name)
>  		fanotify_info_copy_name(info, file_name);
>  
> +	/* Mix fsid+dfid+name+fid info into event merge key */
> +	fne->fae.info_hash = full_name_hash(fne->fskey, info->buf, fanotify_info_len(info));
> +

Similarly here...

>  	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
>  		 __func__, id->i_ino, size, dir_fh_len, child_fh_len,
>  		 info->name_len, info->name_len, fanotify_info_name(info));
> @@ -539,6 +554,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	struct mem_cgroup *old_memcg;
>  	struct inode *child = NULL;
>  	bool name_event = false;
> +	unsigned int hash = 0;
> +	struct pid *pid;
>  
>  	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
>  		/*
> @@ -606,13 +623,17 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	 * Use the victim inode instead of the watching inode as the id for
>  	 * event queue, so event reported on parent is merged with event
>  	 * reported on child when both directory and child watches exist.
> -	 * Reduce object id to 32bit hash for hashed queue merge.
> +	 * Reduce object id and event info to 32bit hash for hashed queue merge.
>  	 */
> -	fanotify_init_event(event, hash_ptr(id, 32), mask);
> +	hash = event->info_hash ^ hash_ptr(id, 32);
>  	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> -		event->pid = get_pid(task_pid(current));
> +		pid = get_pid(task_pid(current));
>  	else
> -		event->pid = get_pid(task_tgid(current));
> +		pid = get_pid(task_tgid(current));
> +	/* Mix pid info into event merge key */
> +	hash ^= hash_ptr(pid, 32);

hash_32() here?

> +	fanotify_init_event(event, hash, mask);
> +	event->pid = pid;
>  
>  out:
>  	set_active_memcg(old_memcg);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 2e856372ffc8..522fb1a68b30 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -115,6 +115,11 @@ static inline void fanotify_info_init(struct fanotify_info *info)
>  	info->name_len = 0;
>  }
>  
> +static inline unsigned int fanotify_info_len(struct fanotify_info *info)
> +{
> +	return info->dir_fh_totlen + info->file_fh_totlen + info->name_len;
> +}
> +
>  static inline void fanotify_info_copy_name(struct fanotify_info *info,
>  					   const struct qstr *name)
>  {
> @@ -138,7 +143,10 @@ enum fanotify_event_type {
>  };
>  
>  struct fanotify_event {
> -	struct fsnotify_event fse;
> +	union {
> +		struct fsnotify_event fse;
> +		unsigned int info_hash;
> +	};
>  	u32 mask;
>  	enum fanotify_event_type type;
>  	struct pid *pid;

How is this ever safe? info_hash will likely overlay with 'list' in
fsnotify_event.

> @@ -154,7 +162,10 @@ static inline void fanotify_init_event(struct fanotify_event *event,
>  
>  struct fanotify_fid_event {
>  	struct fanotify_event fae;
> -	__kernel_fsid_t fsid;
> +	union {
> +		__kernel_fsid_t fsid;
> +		void *fskey;	/* 64 or 32 bits of fsid used for salt */
> +	};
>  	struct fanotify_fh object_fh;
>  	/* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
>  	unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
> @@ -168,7 +179,10 @@ FANOTIFY_FE(struct fanotify_event *event)
>  
>  struct fanotify_name_event {
>  	struct fanotify_event fae;
> -	__kernel_fsid_t fsid;
> +	union {
> +		__kernel_fsid_t fsid;
> +		void *fskey;	/* 64 or 32 bits of fsid used for salt */
> +	};
>  	struct fanotify_info info;
>  };

What games are you playing here with the unions? I presume you can remove
these 'fskey' unions and just use (void *)(event->fsid) at appropriate
places? IMO much more comprehensible...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
