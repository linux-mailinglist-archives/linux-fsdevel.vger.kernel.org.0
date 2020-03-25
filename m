Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F3A192559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 11:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCYKVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 06:21:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgCYKVx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:21:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DDB26ABEA;
        Wed, 25 Mar 2020 10:21:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 883861E10FB; Wed, 25 Mar 2020 11:21:50 +0100 (CET)
Date:   Wed, 25 Mar 2020 11:21:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 14/14] fanotify: report name info for FAN_DIR_MODIFY
 event
Message-ID: <20200325102150.GG28951@quack2.suse.cz>
References: <20200319151022.31456-1-amir73il@gmail.com>
 <20200319151022.31456-15-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319151022.31456-15-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 19-03-20 17:10:22, Amir Goldstein wrote:
> Report event FAN_DIR_MODIFY with name in a variable length record similar
> to how fid's are reported.  With name info reporting implemented, setting
> FAN_DIR_MODIFY in mark mask is now allowed.
> 
> When events are reported with name, the reported fid identifies the
> directory and the name follows the fid. The info record type for this
> event info is FAN_EVENT_INFO_TYPE_DFID_NAME.
> 
> For now, all reported events have at most one info record which is
> either FAN_EVENT_INFO_TYPE_FID or FAN_EVENT_INFO_TYPE_DFID_NAME (for
> FAN_DIR_MODIFY).  Later on, events "on child" will report both records.

When looking at this, I keep wondering: Shouldn't we just have
FAN_EVENT_INFO_TYPE_DFID which would contain FID of the directory and then
FAN_EVENT_INFO_TYPE_NAME which would contain the name? It seems more
modular and following the rule "one thing per info record". Also having two
variable length entries in one info record is a bit strange although it
works fine because the handle has its length stored in it (but the name
does not so further extension is not possible).  Finally it is a bit
confusing that fanotify_event_info_fid would sometimes contain a name in it
and sometimes not.

OTOH I understand that directory FID without a name is not very useful so
it could be viewed as an unnecessary event stream bloat. I'm currently
leaning more towards doing the split but I'd like to hear your opinion...

								Honza

> 
> There are several ways that an application can use this information:
> 
> 1. When watching a single directory, the name is always relative to
> the watched directory, so application need to fstatat(2) the name
> relative to the watched directory.
> 
> 2. When watching a set of directories, the application could keep a map
> of dirfd for all watched directories and hash the map by fid obtained
> with name_to_handle_at(2).  When getting a name event, the fid in the
> event info could be used to lookup the base dirfd in the map and then
> call fstatat(2) with that dirfd.
> 
> 3. When watching a filesystem (FAN_MARK_FILESYSTEM) or a large set of
> directories, the application could use open_by_handle_at(2) with the fid
> in event info to obtain dirfd for the directory where event happened and
> call fstatat(2) with this dirfd.
> 
> The last option scales better for a large number of watched directories.
> The first two options may be available in the future also for non
> privileged fanotify watchers, because open_by_handle_at(2) requires
> the CAP_DAC_READ_SEARCH capability.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      |   2 +-
>  fs/notify/fanotify/fanotify_user.c | 109 +++++++++++++++++++++++------
>  include/linux/fanotify.h           |   3 +-
>  include/uapi/linux/fanotify.h      |   1 +
>  4 files changed, 90 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 22e198ab2687..c07b1891a720 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -526,7 +526,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
>  	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, mask, data,
>  					 data_type);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 2eff2cfa88ce..95256baeb808 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -51,22 +51,35 @@ struct kmem_cache *fanotify_path_event_cachep __read_mostly;
>  struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>  
>  #define FANOTIFY_EVENT_ALIGN 4
> +#define FANOTIFY_INFO_HDR_LEN \
> +	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
>  
> -static int fanotify_fid_info_len(int fh_len)
> +static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> -	return roundup(sizeof(struct fanotify_event_info_fid) +
> -		       sizeof(struct file_handle) + fh_len,
> -		       FANOTIFY_EVENT_ALIGN);
> +	int info_len = fh_len;
> +
> +	if (name_len)
> +		info_len += name_len + 1;
> +
> +	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
>  }
>  
>  static int fanotify_event_info_len(struct fanotify_event *event)
>  {
> +	int info_len = 0;
>  	int fh_len = fanotify_event_object_fh_len(event);
>  
> -	if (!fh_len)
> -		return 0;
> +	if (fh_len)
> +		info_len += fanotify_fid_info_len(fh_len, 0);
>  
> -	return fanotify_fid_info_len(fh_len);
> +	if (fanotify_event_name_len(event)) {
> +		struct fanotify_name_event *fne = FANOTIFY_NE(event);
> +
> +		info_len += fanotify_fid_info_len(fne->dir_fh.len,
> +						  fne->name_len);
> +	}
> +
> +	return info_len;
>  }
>  
>  /*
> @@ -206,23 +219,32 @@ static int process_access_response(struct fsnotify_group *group,
>  	return -ENOENT;
>  }
>  
> -static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> -			    char __user *buf)
> +static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> +			     const char *name, size_t name_len,
> +			     char __user *buf, size_t count)
>  {
>  	struct fanotify_event_info_fid info = { };
>  	struct file_handle handle = { };
>  	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
>  	size_t fh_len = fh ? fh->len : 0;
> -	size_t len = fanotify_fid_info_len(fh_len);
> +	size_t info_len = fanotify_fid_info_len(fh_len, name_len);
> +	size_t len = info_len;
> +
> +	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
> +		 __func__, fh_len, name_len, info_len, count);
>  
> -	if (!len)
> +	if (!fh_len || (name && !name_len))
>  		return 0;
>  
> -	if (WARN_ON_ONCE(len < sizeof(info) + sizeof(handle) + fh_len))
> +	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
>  		return -EFAULT;
>  
> -	/* Copy event info fid header followed by vaiable sized file handle */
> -	info.hdr.info_type = FAN_EVENT_INFO_TYPE_FID;
> +	/*
> +	 * Copy event info fid header followed by variable sized file handle
> +	 * and optionally followed by variable sized filename.
> +	 */
> +	info.hdr.info_type = name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> +					FAN_EVENT_INFO_TYPE_FID;
>  	info.hdr.len = len;
>  	info.fsid = *fsid;
>  	if (copy_to_user(buf, &info, sizeof(info)))
> @@ -230,6 +252,9 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  
>  	buf += sizeof(info);
>  	len -= sizeof(info);
> +	if (WARN_ON_ONCE(len < sizeof(handle)))
> +		return -EFAULT;
> +
>  	handle.handle_type = fh->type;
>  	handle.handle_bytes = fh_len;
>  	if (copy_to_user(buf, &handle, sizeof(handle)))
> @@ -237,9 +262,12 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  
>  	buf += sizeof(handle);
>  	len -= sizeof(handle);
> +	if (WARN_ON_ONCE(len < fh_len))
> +		return -EFAULT;
> +
>  	/*
> -	 * For an inline fh, copy through stack to exclude the copy from
> -	 * usercopy hardening protections.
> +	 * For an inline fh and inline file name, copy through stack to exclude
> +	 * the copy from usercopy hardening protections.
>  	 */
>  	fh_buf = fanotify_fh_buf(fh);
>  	if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
> @@ -249,14 +277,28 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  	if (copy_to_user(buf, fh_buf, fh_len))
>  		return -EFAULT;
>  
> -	/* Pad with 0's */
>  	buf += fh_len;
>  	len -= fh_len;
> +
> +	if (name_len) {
> +		/* Copy the filename with terminating null */
> +		name_len++;
> +		if (WARN_ON_ONCE(len < name_len))
> +			return -EFAULT;
> +
> +		if (copy_to_user(buf, name, name_len))
> +			return -EFAULT;
> +
> +		buf += name_len;
> +		len -= name_len;
> +	}
> +
> +	/* Pad with 0's */
>  	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
>  	if (len > 0 && clear_user(buf, len))
>  		return -EFAULT;
>  
> -	return 0;
> +	return info_len;
>  }
>  
>  static ssize_t copy_event_to_user(struct fsnotify_group *group,
> @@ -298,17 +340,38 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
>  		goto out_close_fd;
>  
> +	buf += FAN_EVENT_METADATA_LEN;
> +	count -= FAN_EVENT_METADATA_LEN;
> +
>  	if (fanotify_is_perm_event(event->mask))
>  		FANOTIFY_PERM(fsn_event)->fd = fd;
>  
> -	if (f) {
> +	if (f)
>  		fd_install(fd, f);
> -	} else if (fanotify_event_has_fid(event)) {
> -		ret = copy_fid_to_user(fanotify_event_fsid(event),
> -				       fanotify_event_object_fh(event),
> -				       buf + FAN_EVENT_METADATA_LEN);
> +
> +	/* Event info records order is: dir fid + name, child fid */
> +	if (fanotify_event_name_len(event)) {
> +		struct fanotify_name_event *fne = FANOTIFY_NE(event);
> +
> +		ret = copy_info_to_user(fanotify_event_fsid(event),
> +					&fne->dir_fh, fne->name, fne->name_len,
> +					buf, count);
>  		if (ret < 0)
>  			return ret;
> +
> +		buf += ret;
> +		count -= ret;
> +	}
> +
> +	if (fanotify_event_object_fh_len(event)) {
> +		ret = copy_info_to_user(fanotify_event_fsid(event),
> +					fanotify_event_object_fh(event),
> +					NULL, 0, buf, count);
> +		if (ret < 0)
> +			return ret;
> +
> +		buf += ret;
> +		count -= ret;
>  	}
>  
>  	return metadata.event_len;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index b79fa9bb7359..3049a6c06d9e 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -47,7 +47,8 @@
>   * Directory entry modification events - reported only to directory
>   * where entry is modified and not to a watching parent.
>   */
> -#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
> +#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
> +				 FAN_DIR_MODIFY)
>  
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
>  #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 615fa2c87179..2b56e194b858 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -117,6 +117,7 @@ struct fanotify_event_metadata {
>  };
>  
>  #define FAN_EVENT_INFO_TYPE_FID		1
> +#define FAN_EVENT_INFO_TYPE_DFID_NAME	2
>  
>  /* Variable length info record following event metadata */
>  struct fanotify_event_info_header {
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
