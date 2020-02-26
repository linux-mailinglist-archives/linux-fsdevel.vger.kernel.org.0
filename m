Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7116FBFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 11:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBZKX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 05:23:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:56832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgBZKX4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:23:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 789EAB028;
        Wed, 26 Feb 2020 10:23:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 27CEA1E0EA2; Wed, 26 Feb 2020 11:23:54 +0100 (CET)
Date:   Wed, 26 Feb 2020 11:23:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200226102354.GE10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-12-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131455.31107-12-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-02-20 15:14:50, Amir Goldstein wrote:
> For some events, we are going to encode both child and parent fid's,
> so we need to do a little refactoring of struct fanotify_event and fid
> helper functions.
> 
> Move fsid member from struct fanotify_fid out to struct fanotify_event,
> so we can store fsid once for two encoded fid's (we will only encode
> parent if it is on the same filesystem).
> 
> This does not change the size of struct fanotify_event because struct
> fanotify_fid is still bigger than struct path on 32bit arch and is the
> same size as struct path (16 bytes) on 64bit arch.
> 
> Group fh_len and fh_type as struct fanotify_fid_hdr.
> Pass struct fanotify_fid and struct fanotify_fid_hdr to helpers
> fanotify_encode_fid() and copy_fid_to_user() instead of passing the
> containing fanotify_event struct.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> @@ -327,16 +327,18 @@ init: __maybe_unused
>  		event->pid = get_pid(task_pid(current));
>  	else
>  		event->pid = get_pid(task_tgid(current));
> -	event->fh_len = 0;
> +	event->fh.len = 0;
> +	if (fsid)
> +		event->fsid = *fsid;
>  	if (id && FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
>  		/* Report the event without a file identifier on encode error */
>  		event->fh_type = fanotify_encode_fid(event, id, gfp, fsid);
			^^^^
This should be event->fh, shouldn't it? I wonder how come 0-day didn't
catch this...

> +struct fanotify_fid_hdr {
> +	u8 type;
> +	u8 len;
> +};
> +
>  struct fanotify_fid {
> -	__kernel_fsid_t fsid;
>  	union {
>  		unsigned char fh[FANOTIFY_INLINE_FH_LEN];
>  		unsigned char *ext_fh;
>  	};
>  };
...
> @@ -63,13 +81,13 @@ struct fanotify_event {
>  	u32 mask;
>  	/*
>  	 * Those fields are outside fanotify_fid to pack fanotify_event nicely
> -	 * on 64bit arch and to use fh_type as an indication of whether path
> +	 * on 64bit arch and to use fh.type as an indication of whether path
>  	 * or fid are used in the union:
>  	 * FILEID_ROOT (0) for path, > 0 for fid, FILEID_INVALID for neither.
>  	 */
> -	u8 fh_type;
> -	u8 fh_len;
> +	struct fanotify_fid_hdr fh;
>  	u16 pad;

The 'pad' here now looks rather bogus. Let's remove it and leave padding on
the compiler. It's in-memory struct anyway...

> +	__kernel_fsid_t fsid;
>  	union {
>  		/*
>  		 * We hold ref to this path so it may be dereferenced at any

Here I disagree. IMO 'fsid' should be still part of the union below because
the "object identification" is either struct path or (fsid + fh). I
understand that you want to reuse fsid for the other file handle. But then
I believe it should rather be done like:

struct fanotify_fh {
  	union {
  		unsigned char fh[FANOTIFY_INLINE_FH_LEN];
  		unsigned char *ext_fh;
  	};
};

struct fanotify_fid {
	__kernel_fsid_t fsid;
	struct fanotify_fh object;
	struct fanotify_fh dir;
}

BTW, is file handle length and type guaranteed to be the same for 'object' and
'dir'? Given how filehandles try to be rather opaque sequences of bytes,
I'm not sure we are safe to assume that... 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
