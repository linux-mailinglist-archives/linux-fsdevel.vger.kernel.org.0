Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881053EDAD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 18:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhHPQXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 12:23:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50886 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHPQXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:23:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3274821E9F;
        Mon, 16 Aug 2021 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629130982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DeIWxpGYWG8QNDvTyASnA4sH/7Z+87DoI/0JX4M0Sw=;
        b=vSR/Z7og/gvAQjGaVjujGy82XfvuWTXmduX+W6xYQ9S86MC0RQTWtkhP/m5/YlSw8m6pPo
        t5qUFl9gLUFJzf8sCpdXTtAum2PekDETREQh/D5Yi2mG5v44PpC0wxpTCexvrOZ3eDkf/G
        cmUnimshdMOPwiDe8ZcUqskESfFI2IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629130982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DeIWxpGYWG8QNDvTyASnA4sH/7Z+87DoI/0JX4M0Sw=;
        b=r1h9DnsAmlYX+Uk2gbtfUHaTur3mIqSW+nRLAP01EMMPBts7AzhcB13fxh1ukKfwWD9a4l
        Eysq4Obl4avP30AA==
Received: from quack2.suse.cz (jack.udp.ovpn1.prg.suse.de [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 1CAF2A3B88;
        Mon, 16 Aug 2021 16:23:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 022281E0426; Mon, 16 Aug 2021 18:23:01 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:23:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for
 error event
Message-ID: <20210816162301.GI30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-19-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:40:07, Gabriel Krisman Bertazi wrote:
> The Error info type is a record sent to users on FAN_FS_ERROR events
> documenting the type of error.  It also carries an error count,
> documenting how many errors were observed since the last reporting.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v5:
>   - Move error code here
> ---
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify.h      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
>  include/uapi/linux/fanotify.h      |  7 ++++++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index f5c16ac37835..b49a474c1d7f 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -745,6 +745,7 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
>  	spin_unlock(&group->notification_lock);
>  
>  	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +	fee->error = report->error;
>  	fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
>  
>  	fh_len = fanotify_encode_fh_len(inode);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 158cf0c4b0bd..0cfe376c6fd9 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -220,6 +220,7 @@ FANOTIFY_NE(struct fanotify_event *event)
>  
>  struct fanotify_error_event {
>  	struct fanotify_event fae;
> +	s32 error; /* Error reported by the Filesystem. */
>  	u32 err_count; /* Suppressed errors count */
>  
>  	struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 1ab8f9d8b3ac..ca53159ce673 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -107,6 +107,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_INFO_HDR_LEN \
>  	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> +#define FANOTIFY_INFO_ERROR_LEN \
> +	(sizeof(struct fanotify_event_info_error))
>  
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -130,6 +132,9 @@ static size_t fanotify_event_len(struct fanotify_event *event,
>  	if (!fid_mode)
>  		return event_len;
>  
> +	if (fanotify_is_error_event(event->mask))
> +		event_len += FANOTIFY_INFO_ERROR_LEN;
> +
>  	info = fanotify_event_info(event);
>  	dir_fh_len = fanotify_event_dir_fh_len(event);
>  	fh_len = fanotify_event_object_fh_len(event);
> @@ -176,6 +181,7 @@ static struct fanotify_event *fanotify_dup_error_to_stack(
>  	error_on_stack->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
>  	error_on_stack->err_count = fee->err_count;
>  	error_on_stack->sb_mark = fee->sb_mark;
> +	error_on_stack->error = fee->error;
>  
>  	error_on_stack->fsid = fee->fsid;
>  
> @@ -342,6 +348,28 @@ static int process_access_response(struct fsnotify_group *group,
>  	return -ENOENT;
>  }
>  
> +static size_t copy_error_info_to_user(struct fanotify_event *event,
> +				      char __user *buf, int count)
> +{
> +	struct fanotify_event_info_error info;
> +	struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
> +	info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
> +	info.hdr.pad = 0;
> +	info.hdr.len = FANOTIFY_INFO_ERROR_LEN;
> +
> +	if (WARN_ON(count < info.hdr.len))
> +		return -EFAULT;
> +
> +	info.error = fee->error;
> +	info.error_count = fee->err_count;
> +
> +	if (copy_to_user(buf, &info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return info.hdr.len;
> +}
> +
>  static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  			     int info_type, const char *name, size_t name_len,
>  			     char __user *buf, size_t count)
> @@ -505,6 +533,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	if (f)
>  		fd_install(fd, f);
>  
> +	if (fanotify_is_error_event(event->mask)) {
> +		ret = copy_error_info_to_user(event, buf, count);
> +		if (ret < 0)
> +			goto out_close_fd;
> +		buf += ret;
> +		count -= ret;
> +	}
> +
>  	/* Event info records order is: dir fid + name, child fid */
>  	if (fanotify_event_dir_fh_len(event)) {
>  		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 16402037fc7a..80040a92e9d9 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -124,6 +124,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_FID		1
>  #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
>  #define FAN_EVENT_INFO_TYPE_DFID	3
> +#define FAN_EVENT_INFO_TYPE_ERROR	4
>  
>  /* Variable length info record following event metadata */
>  struct fanotify_event_info_header {
> @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
>  	unsigned char handle[0];
>  };
>  
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +};
> +
>  struct fanotify_response {
>  	__s32 fd;
>  	__u32 response;
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
