Return-Path: <linux-fsdevel+bounces-55688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64190B0DCC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651583A8621
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCDC1A2C25;
	Tue, 22 Jul 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhOPbIlX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wrsHXwIO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhOPbIlX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wrsHXwIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C92B9A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192917; cv=none; b=Opmf7LNNfF/eAr6ArrD/OD4uSLr/NRbgmlo5XsoW8YjTVmDbvCAl+M5DbnzuN4FEZilF5XIh73JXcAHxTrPynTdAFNISalE5EodK3auoKh5Yh0aILEXiYl05hjiuiFHnrQ/GduyBpcfzjwo7WvM/zobBjlskzFmNPvK/lUxUTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192917; c=relaxed/simple;
	bh=6oh3ipzIuFO2RoR7H6tz31C2ptyqOZu2H7hv+s9ZAhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWYxU55n/QA45d80YpkcFCTOY6kMaEsGlh4C/FHNsfaTgwD9nZqxAEDhnoSyQX9HqweKfKvupjDGBl+3bWcO5ff+ZGOqXrZNwr5JWqwR3nHNrFVrpNm7NncwEQmGUTAKdxg3kQbWkWvWWWu1NeGzV6KkYYC65jr6TJ0vzY498pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhOPbIlX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wrsHXwIO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhOPbIlX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wrsHXwIO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98B0B1F7CA;
	Tue, 22 Jul 2025 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753192913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkODbOycCQkvNJyn5ZmJoCtL96jTym6GZ2wTMcz56dQ=;
	b=nhOPbIlXvQgujC1InqjjNEnqqOZP7J/ElcMEtl0JwfQVUei7qHel+fZzMV4drvOdE1r3CO
	9o3EY8GDVMDraqNKiKazXJBwj6jMzBWROxtAqgZzSB8iUuIEYlK2Krvkk7L52B46I3aUR8
	bG/OiOchOfiCJ2lesI9V2knAnoV4gNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753192913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkODbOycCQkvNJyn5ZmJoCtL96jTym6GZ2wTMcz56dQ=;
	b=wrsHXwIOVtrwl5tiUUUsTLW724TjQ21DWB3FWBJxAQAPWvB8QPwB+uw+865r1Z/yMUGAYF
	PFs3VCd8ZlnMayBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753192913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkODbOycCQkvNJyn5ZmJoCtL96jTym6GZ2wTMcz56dQ=;
	b=nhOPbIlXvQgujC1InqjjNEnqqOZP7J/ElcMEtl0JwfQVUei7qHel+fZzMV4drvOdE1r3CO
	9o3EY8GDVMDraqNKiKazXJBwj6jMzBWROxtAqgZzSB8iUuIEYlK2Krvkk7L52B46I3aUR8
	bG/OiOchOfiCJ2lesI9V2knAnoV4gNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753192913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkODbOycCQkvNJyn5ZmJoCtL96jTym6GZ2wTMcz56dQ=;
	b=wrsHXwIOVtrwl5tiUUUsTLW724TjQ21DWB3FWBJxAQAPWvB8QPwB+uw+865r1Z/yMUGAYF
	PFs3VCd8ZlnMayBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E2DE13A32;
	Tue, 22 Jul 2025 14:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0wLGHtGZf2hIHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Jul 2025 14:01:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F33D3A0A9D; Tue, 22 Jul 2025 16:01:48 +0200 (CEST)
Date: Tue, 22 Jul 2025 16:01:48 +0200
From: Jan Kara <jack@suse.cz>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, amir73il@gmail.com, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH v4 1/3] fanotify: add support for a variable length
 permission event
Message-ID: <zliib52glfaw3vaook5xvv6h5opvnnrdo2mfh6wg26mqfouslm@etramyyx6tjb>
References: <20250711183101.4074140-1-ibrahimjirdeh@meta.com>
 <20250711183101.4074140-2-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711183101.4074140-2-ibrahimjirdeh@meta.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,toxicpanda.com,meta.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hello!

Sorry for a bit delayed reply I was busy with other work...

On Fri 11-07-25 11:30:59, Ibrahim Jirdeh wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> In preparation for pre-content events that report fid info + name,
> we need a new event type that is both variable length and can be
> put on a user response wait list.
> 
> Create an event type FANOTIFY_EVENT_TYPE_FID_NAME_PERM with is a
> combination of the variable length fanotify_name_event prefixed
> with a fix length fanotify_perm_event and they share the common
> fanotify_event memeber.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

As a procedural note, this patch should have your Signed-off-by as well
Ibrahim, when you resend it as part of your patch set.

Now to the content: Amir, this looks quite hacky to me and I think we can
do better. How about:

struct fanotify_perm_event { 
        struct fanotify_event fae;                      
        const loff_t *ppos;             /* optional file range info */
        size_t count;
        u32 response;                   /* userspace answer to the event */
        unsigned short state;           /* state of the event */
        int fd;         /* fd we passed to userspace for this event */
        union { 
                struct fanotify_response_info_header hdr;
                struct fanotify_response_info_audit_rule audit_rule;
        };      
	union {
	        struct path path;
		struct {
			__kernel_fsid_t fsid;
			struct fanotify_info info;
		};
	};
};              

This actually doesn't grow struct fanotify_perm_event and should make
things more or less bussiness as usual.

								Honza


> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index bfe884d624e7..34acb7c16e8b 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -582,20 +582,13 @@ static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp_t gfp)
>  	return &pevent->fae;
>  }
>  
> -static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
> -							int data_type,
> -							gfp_t gfp)
> +static void fanotify_init_perm_event(struct fanotify_perm_event *pevent,
> +				     const void *data, int data_type)
>  {
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	const struct file_range *range =
>  			    fsnotify_data_file_range(data, data_type);
> -	struct fanotify_perm_event *pevent;
> -
> -	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
> -	if (!pevent)
> -		return NULL;
>  
> -	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH_PERM;
>  	pevent->response = 0;
>  	pevent->hdr.type = FAN_RESPONSE_INFO_NONE;
>  	pevent->hdr.pad = 0;
> @@ -606,6 +599,20 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
>  	pevent->ppos = range ? &range->pos : NULL;
>  	pevent->count = range ? range->count : 0;
>  	path_get(path);
> +}
> +
> +static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
> +							int data_type,
> +							gfp_t gfp)
> +{
> +	struct fanotify_perm_event *pevent;
> +
> +	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
> +	if (!pevent)
> +		return NULL;
> +
> +	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH_PERM;
> +	fanotify_init_perm_event(pevent, data, data_type);
>  
>  	return &pevent->fae;
>  }
> @@ -636,11 +643,12 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
>  							struct inode *child,
>  							struct dentry *moved,
>  							unsigned int *hash,
> -							gfp_t gfp)
> +							gfp_t gfp, bool perm)
>  {
>  	struct fanotify_name_event *fne;
>  	struct fanotify_info *info;
>  	struct fanotify_fh *dfh, *ffh;
> +	struct fanotify_perm_event *pevent;
>  	struct inode *dir2 = moved ? d_inode(moved->d_parent) : NULL;
>  	const struct qstr *name2 = moved ? &moved->d_name : NULL;
>  	unsigned int dir_fh_len = fanotify_encode_fh_len(dir);
> @@ -658,11 +666,26 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
>  		size += FANOTIFY_FH_HDR_LEN + dir2_fh_len;
>  	if (child_fh_len)
>  		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
> +	if (perm) {
> +		BUILD_BUG_ON(offsetof(struct fanotify_perm_event, fae) +
> +			     sizeof(struct fanotify_event) != sizeof(*pevent));
> +		size += offsetof(struct fanotify_perm_event, fae);
> +	}
>  	fne = kmalloc(size, gfp);
>  	if (!fne)
>  		return NULL;
>  
> -	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
> +	/*
> +	 * fanotify_name_event follows fanotify_perm_event and they share the
> +	 * fae member.
> +	 */
> +	if (perm) {
> +		pevent = (void *)fne;
> +		fne = FANOTIFY_NE(&pevent->fae);
> +		fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME_PERM;
> +	} else {
> +		fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
> +	}
>  	fne->fsid = *fsid;
>  	*hash ^= fanotify_hash_fsid(fsid);
>  	info = &fne->info;
> @@ -757,6 +780,7 @@ static struct fanotify_event *fanotify_alloc_event(
>  	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
> +	bool perm = fanotify_is_perm_event(mask);
>  	struct mem_cgroup *old_memcg;
>  	struct dentry *moved = NULL;
>  	struct inode *child = NULL;
> @@ -842,14 +866,18 @@ static struct fanotify_event *fanotify_alloc_event(
>  	/* Whoever is interested in the event, pays for the allocation. */
>  	old_memcg = set_active_memcg(group->memcg);
>  
> -	if (fanotify_is_perm_event(mask)) {
> +	if (name_event && (file_name || moved || child || perm)) {
> +		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
> +						  moved, &hash, gfp, perm);
> +		if (event && perm) {
> +			fanotify_init_perm_event(FANOTIFY_PERM(event),
> +						 data, data_type);
> +		}
> +	} else if (perm) {
>  		event = fanotify_alloc_perm_event(data, data_type, gfp);
>  	} else if (fanotify_is_error_event(mask)) {
>  		event = fanotify_alloc_error_event(group, fsid, data,
>  						   data_type, &hash);
> -	} else if (name_event && (file_name || moved || child)) {
> -		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
> -						  moved, &hash, gfp);
>  	} else if (fid_mode) {
>  		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
>  	} else if (path) {
> @@ -1037,6 +1065,13 @@ static void fanotify_free_perm_event(struct fanotify_event *event)
>  	kmem_cache_free(fanotify_perm_event_cachep, FANOTIFY_PERM(event));
>  }
>  
> +static void fanotify_free_name_perm_event(struct fanotify_event *event)
> +{
> +	path_put(fanotify_event_path(event));
> +	/* Variable length perm event */
> +	kfree(FANOTIFY_PERM(event));
> +}
> +
>  static void fanotify_free_fid_event(struct fanotify_event *event)
>  {
>  	struct fanotify_fid_event *ffe = FANOTIFY_FE(event);
> @@ -1084,6 +1119,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
>  	case FANOTIFY_EVENT_TYPE_FID_NAME:
>  		fanotify_free_name_event(event);
>  		break;
> +	case FANOTIFY_EVENT_TYPE_FID_NAME_PERM:
> +		fanotify_free_name_perm_event(event);
> +		break;
>  	case FANOTIFY_EVENT_TYPE_OVERFLOW:
>  		kfree(event);
>  		break;
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index b78308975082..f6d25fcf8692 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -240,6 +240,7 @@ static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>  enum fanotify_event_type {
>  	FANOTIFY_EVENT_TYPE_FID, /* fixed length */
>  	FANOTIFY_EVENT_TYPE_FID_NAME, /* variable length */
> +	FANOTIFY_EVENT_TYPE_FID_NAME_PERM, /* variable length perm event */
>  	FANOTIFY_EVENT_TYPE_PATH,
>  	FANOTIFY_EVENT_TYPE_PATH_PERM,
>  	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
> @@ -326,7 +327,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_FID)
>  		return &FANOTIFY_FE(event)->fsid;
> -	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
> +	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME ||
> +		 event->type == FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
>  		return &FANOTIFY_NE(event)->fsid;
>  	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
>  		return &FANOTIFY_EE(event)->fsid;
> @@ -339,7 +341,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_FID)
>  		return &FANOTIFY_FE(event)->object_fh;
> -	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
> +	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME ||
> +		 event->type == FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
>  		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
>  	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
>  		return &FANOTIFY_EE(event)->object_fh;
> @@ -350,7 +353,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
>  static inline struct fanotify_info *fanotify_event_info(
>  						struct fanotify_event *event)
>  {
> -	if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
> +	if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME ||
> +	    event->type == FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
>  		return &FANOTIFY_NE(event)->info;
>  	else
>  		return NULL;
> @@ -435,7 +439,6 @@ FANOTIFY_ME(struct fanotify_event *event)
>   * user response.
>   */
>  struct fanotify_perm_event {
> -	struct fanotify_event fae;
>  	struct path path;
>  	const loff_t *ppos;		/* optional file range info */
>  	size_t count;
> @@ -446,6 +449,11 @@ struct fanotify_perm_event {
>  		struct fanotify_response_info_header hdr;
>  		struct fanotify_response_info_audit_rule audit_rule;
>  	};
> +	/*
> +	 * Overlaps with fanotify_name_event::fae when type is
> +	 * FANOTIFY_EVENT_TYPE_FID_NAME_PERM - Keep at the end!
> +	 */
> +	struct fanotify_event fae;
>  };
>  
>  static inline struct fanotify_perm_event *
> @@ -487,7 +495,8 @@ static inline const struct path *fanotify_event_path(struct fanotify_event *even
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
>  		return &FANOTIFY_PE(event)->path;
> -	else if (event->type == FANOTIFY_EVENT_TYPE_PATH_PERM)
> +	else if (event->type == FANOTIFY_EVENT_TYPE_PATH_PERM ||
> +		 event->type == FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
>  		return &FANOTIFY_PERM(event)->path;
>  	else
>  		return NULL;
> -- 
> 2.47.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

