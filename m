Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E541D213D25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgGCQCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 12:02:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCQCc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:02:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3C9CAD79;
        Fri,  3 Jul 2020 16:02:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F88B1E12EB; Fri,  3 Jul 2020 18:02:29 +0200 (CEST)
Date:   Fri, 3 Jul 2020 18:02:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/20] fanotify: move event name into fanotify_fh
Message-ID: <20200703160229.GF21364@quack2.suse.cz>
References: <20200612093343.5669-1-amir73il@gmail.com>
 <20200612093343.5669-20-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612093343.5669-20-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-06-20 12:33:42, Amir Goldstein wrote:
> An fanotify event name is always recorded relative to a dir fh.
> Move the name_len members of fanotify_name_event into unused space
> in struct fanotify_fh.
> 
> We add a name_offset member to allow packing a binary blob before
> the name string in the variable size buffer. We are going to use
> that space to store the child fid.

So how much is this packing going to save us? Currently it is 1 byte for
name events (modulo that fanotify_alloc_name_event_bug() you mention
below). With the additional fanotify_fh in the event, we'll save two more
bytes by the packing. So that doesn't really seem to be worth it to me.
Am I missing some other benefit?

Maybe your main motivation (which is not mentioned in the changelog at all
BTW) is that the whole game of inline vs out of line file handles is
pointless when we kmalloc() the event anyway because of the name? And it's
actively wasteful in case handles don't fit in the inline space. I agree
with that and it's good observation. But I'd rather leave fanotify_fh
struct alone for the cases where we want to bother with inline vs out of line
file handles and define new way of partitioning space at the end of the
event among one or two file handles and name. Something like:

struct fanotify_dynamic_info {
	u8 dirfh_len;
	u8 filefh_len;
	u8 name_len;
	unsigned char buf[];
};

And at appropriate offsets (0, dirfh_len, dirfh_len + filefh_len) there
would be additional info (e.g. type + fh for file handles). Maybe this
format will require some tweaking so that processing of both storage types
of file handles can be reasonably uniform but at this point it seems
cleaner than what you try to do fanotify_fh with combining lenghts and
offsets and some blobs in the middle...

> It also fixes a bug in fanotify_alloc_name_event() which used an
> allocation size 7 bytes bigger than required size, because it used
> sizeof(struct fanotify_name_event) without deducting that 7 bytes
> alignment padding.

								Honza
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 27 ++++++++-----
>  fs/notify/fanotify/fanotify.h      | 62 +++++++++++++++++++++++-------
>  fs/notify/fanotify/fanotify_user.c | 23 +++++------
>  3 files changed, 75 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 3885bf63976b..3a2d48edaddd 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -52,15 +52,20 @@ static bool fanotify_fid_event_equal(struct fanotify_fid_event *ffe1,
>  static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
>  				      struct fanotify_name_event *fne2)
>  {
> +	struct fanotify_fh *dfh1 = &fne1->dir_fh;
> +	struct fanotify_fh *dfh2 = &fne2->dir_fh;
> +
>  	/* Do not merge name events without dir fh */
> -	if (!fne1->dir_fh.len)
> +	if (!dfh1->len)
>  		return false;
>  
> -	if (fne1->name_len != fne2->name_len ||
> -	    !fanotify_fh_equal(&fne1->dir_fh, &fne2->dir_fh))
> +	if (dfh1->name_len != dfh2->name_len ||
> +	    dfh1->name_offset != dfh2->name_offset ||
> +	    !fanotify_fh_equal(dfh1, dfh2))
>  		return false;
>  
> -	return !memcmp(fne1->name, fne2->name, fne1->name_len);
> +	return !memcmp(fanotify_fh_name(dfh1), fanotify_fh_name(dfh2),
> +		       dfh1->name_len);
>  }
>  
>  static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
> @@ -284,8 +289,7 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	void *buf = fh->buf;
>  	int err;
>  
> -	fh->type = FILEID_ROOT;
> -	fh->len = 0;
> +	fanotify_fh_init(fh);
>  	if (!inode)
>  		return;
>  
> @@ -314,6 +318,10 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  
>  	fh->type = type;
>  	fh->len = bytes;
> +	if (fh->len > FANOTIFY_INLINE_FH_LEN)
> +		fh->name_offset = FANOTIFY_INLINE_FH_LEN;
> +	else
> +		fh->name_offset = fh->len;
>  
>  	return;
>  
> @@ -401,6 +409,7 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  						 gfp_t gfp)
>  {
>  	struct fanotify_name_event *fne;
> +	struct fanotify_fh *dfh;
>  
>  	fne = kmalloc(sizeof(*fne) + file_name->len + 1, gfp);
>  	if (!fne)
> @@ -408,9 +417,9 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  
>  	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
>  	fne->fsid = *fsid;
> -	fanotify_encode_fh(&fne->dir_fh, id, gfp);
> -	fne->name_len = file_name->len;
> -	strcpy(fne->name, file_name->name);
> +	dfh = &fne->dir_fh;
> +	fanotify_encode_fh(dfh, id, gfp);
> +	fanotify_fh_copy_name(dfh, file_name);
>  
>  	return &fne->fae;
>  }
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 1b2a3bbe6008..8cb062eefd3e 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -23,13 +23,24 @@ enum {
>   * stored in either the first or last 2 dwords.
>   */
>  #define FANOTIFY_INLINE_FH_LEN	(3 << 2)
> +#define FANOTIFY_FH_HDR_LEN	offsetof(struct fanotify_fh, buf)
>  
>  struct fanotify_fh {
> -	unsigned char buf[FANOTIFY_INLINE_FH_LEN];
>  	u8 type;
>  	u8 len;
> +	u8 name_offset;
> +	u8 name_len;
> +	unsigned char buf[FANOTIFY_INLINE_FH_LEN];
>  } __aligned(4);
>  
> +static inline void fanotify_fh_init(struct fanotify_fh *fh)
> +{
> +	fh->type = FILEID_ROOT;
> +	fh->len = 0;
> +	fh->name_offset = 0;
> +	fh->name_len = 0;
> +}
> +
>  static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
>  {
>  	return fh->len > FANOTIFY_INLINE_FH_LEN;
> @@ -37,6 +48,7 @@ static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
>  
>  static inline char **fanotify_fh_ext_buf_ptr(struct fanotify_fh *fh)
>  {
> +	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN % 4);
>  	BUILD_BUG_ON(__alignof__(char *) - 4 + sizeof(char *) >
>  		     FANOTIFY_INLINE_FH_LEN);
>  	return (char **)ALIGN((unsigned long)(fh->buf), __alignof__(char *));
> @@ -52,6 +64,35 @@ static inline void *fanotify_fh_buf(struct fanotify_fh *fh)
>  	return fanotify_fh_has_ext_buf(fh) ? fanotify_fh_ext_buf(fh) : fh->buf;
>  }
>  
> +static inline int fanotify_fh_blob_len(struct fanotify_fh *fh)
> +{
> +	if (fh->name_offset <= fh->len)
> +		return 0;
> +
> +	/* Is there a space between end of fh_buf and start of name? */
> +	return fh->name_offset - fh->len;
> +}
> +
> +static inline void *fanotify_fh_blob(struct fanotify_fh *fh)
> +{
> +	if (fh->name_offset <= fh->len)
> +		return NULL;
> +
> +	return fh->buf + fh->len;
> +}
> +
> +static inline const char *fanotify_fh_name(struct fanotify_fh *fh)
> +{
> +	return fh->name_len ? fh->buf + fh->name_offset : NULL;
> +}
> +
> +static inline void fanotify_fh_copy_name(struct fanotify_fh *fh,
> +					 const struct qstr *name)
> +{
> +	fh->name_len = name->len;
> +	strcpy(fh->buf + fh->name_offset, name->name);
> +}
> +
>  /*
>   * Common structure for fanotify events. Concrete structs are allocated in
>   * fanotify_handle_event() and freed when the information is retrieved by
> @@ -93,12 +134,16 @@ FANOTIFY_FE(struct fanotify_event *event)
>  	return container_of(event, struct fanotify_fid_event, fae);
>  }
>  
> +/*
> + * This is identical to struct fanotify_fid_event, but allocated with variable
> + * size kmalloc and should have positive value of dir_fh.name_len.
> + * Keeping the separate struct definition for semantics and type safety -
> + * an event should be cast to this type IFF it was allocated using kmalloc.
> + */
>  struct fanotify_name_event {
>  	struct fanotify_event fae;
>  	__kernel_fsid_t fsid;
>  	struct fanotify_fh dir_fh;
> -	u8 name_len;
> -	char name[];
>  };
>  
>  static inline struct fanotify_name_event *
> @@ -142,17 +187,6 @@ static inline int fanotify_event_object_fh_len(struct fanotify_event *event)
>  	return fh ? fh->len : 0;
>  }
>  
> -static inline bool fanotify_event_has_name(struct fanotify_event *event)
> -{
> -	return event->type == FANOTIFY_EVENT_TYPE_FID_NAME;
> -}
> -
> -static inline int fanotify_event_name_len(struct fanotify_event *event)
> -{
> -	return fanotify_event_has_name(event) ?
> -		FANOTIFY_NE(event)->name_len : 0;
> -}
> -
>  struct fanotify_path_event {
>  	struct fanotify_event fae;
>  	struct path path;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 42b8cc51cb3f..af8268b44c68 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -68,17 +68,14 @@ static int fanotify_event_info_len(struct fanotify_event *event)
>  {
>  	int info_len = 0;
>  	int fh_len = fanotify_event_object_fh_len(event);
> +	struct fanotify_fh *dfh = fanotify_event_dir_fh(event);
> +
> +	if (dfh)
> +		info_len += fanotify_fid_info_len(dfh->len, dfh->name_len);
>  
>  	if (fh_len)
>  		info_len += fanotify_fid_info_len(fh_len, 0);
>  
> -	if (fanotify_event_name_len(event)) {
> -		struct fanotify_name_event *fne = FANOTIFY_NE(event);
> -
> -		info_len += fanotify_fid_info_len(fne->dir_fh.len,
> -						  fne->name_len);
> -	}
> -
>  	return info_len;
>  }
>  
> @@ -305,6 +302,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  {
>  	struct fanotify_event_metadata metadata;
>  	struct path *path = fanotify_event_path(event);
> +	struct fanotify_fh *dfh = fanotify_event_dir_fh(event);
>  	struct file *f = NULL;
>  	int ret, fd = FAN_NOFD;
>  
> @@ -346,13 +344,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  		fd_install(fd, f);
>  
>  	/* Event info records order is: dir fid + name, child fid */
> -	if (fanotify_event_name_len(event)) {
> -		struct fanotify_name_event *fne = FANOTIFY_NE(event);
> -
> -		ret = copy_info_to_user(fanotify_event_fsid(event),
> -					fanotify_event_dir_fh(event),
> -					fne->name, fne->name_len,
> -					buf, count);
> +	if (dfh) {
> +		ret = copy_info_to_user(fanotify_event_fsid(event), dfh,
> +					fanotify_fh_name(dfh),
> +					dfh->name_len, buf, count);
>  		if (ret < 0)
>  			return ret;
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
