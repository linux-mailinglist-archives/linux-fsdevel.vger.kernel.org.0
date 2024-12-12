Return-Path: <linux-fsdevel+bounces-37187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4399EF005
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786F9189745F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BF20969B;
	Thu, 12 Dec 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozy8hxYS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSB+brn2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozy8hxYS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSB+brn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAB22F381
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019457; cv=none; b=CMOvv6Acn9kqFWVYIcDwGvVqnCnbnnJSLfkNX2iTCyYRq7BwC09SF8oZ9WBWFew3l3tSY7O19V5yAczH8VFZVLJJZfwjEADIxvajm5hXe5sxgZR8NBfAqnleIX49R7aKJ9s6XbAe+UWF08Q+QpvAJgdjuCKzxu5K5KirPibCxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019457; c=relaxed/simple;
	bh=n1r701hjvnJiWF1Wy2T257A/uhEz7OjTO5Xf5DscDwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP9SwTFmF2qSofWIQjF0IpOeac3xPqeJk+3hbyQACxGGYtST9DW+F2XZ8jyzH1LR6w8POnv7w7HbY6cS//gAHcW7y4L4piBDsZdAqHA7JlxNEIfsZPNtVqPOXEbRmtBYxBXAzoBCz2lzcssVuU5L2T7B/m50jOP+VAjJiOTfrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozy8hxYS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSB+brn2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozy8hxYS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSB+brn2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB52321167;
	Thu, 12 Dec 2024 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734019451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcXtKjRptCfVgEY3is8UgfpjJCs5PQGls8jkfKnhVps=;
	b=ozy8hxYSc1M2FxzPXoelBlXtqqlqeC2BB646XjQkpfACrrNs7vCWY2dEzAgSXuYsTuPFVQ
	yhfurXZ5Ux/D5LsTJOIElDps1bg+u6WR8C6Vcu2d/VdvJbkJC+fL8RpEV+ZjRn8rxcLEXU
	eT4T3T4EEXN9q63WDkjW1cyFwo/MXb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734019451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcXtKjRptCfVgEY3is8UgfpjJCs5PQGls8jkfKnhVps=;
	b=zSB+brn2YVR2Vg3U5wrfsBD5B69T0SPoRXehGBXwX6CLErrN3MKYZ9HcNPxCihsy3811fp
	3aHNw4kX4UMYTzAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734019451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcXtKjRptCfVgEY3is8UgfpjJCs5PQGls8jkfKnhVps=;
	b=ozy8hxYSc1M2FxzPXoelBlXtqqlqeC2BB646XjQkpfACrrNs7vCWY2dEzAgSXuYsTuPFVQ
	yhfurXZ5Ux/D5LsTJOIElDps1bg+u6WR8C6Vcu2d/VdvJbkJC+fL8RpEV+ZjRn8rxcLEXU
	eT4T3T4EEXN9q63WDkjW1cyFwo/MXb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734019451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcXtKjRptCfVgEY3is8UgfpjJCs5PQGls8jkfKnhVps=;
	b=zSB+brn2YVR2Vg3U5wrfsBD5B69T0SPoRXehGBXwX6CLErrN3MKYZ9HcNPxCihsy3811fp
	3aHNw4kX4UMYTzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA43F13939;
	Thu, 12 Dec 2024 16:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 86eLKXsJW2eqDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Dec 2024 16:04:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 52184A0894; Thu, 12 Dec 2024 17:04:11 +0100 (CET)
Date: Thu, 12 Dec 2024 17:04:11 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
Message-ID: <20241212160411.xzdp64o3v2ilxsf5@quack3>
References: <20241211153709.149603-1-mszeredi@redhat.com>
 <20241212112707.6ueqp5fwgk64bry2@quack3>
 <CAJfpeguN6bfPa1rBWHFcA4HhCCkHN_CatGB4cC-z6mKa_dckWA@mail.gmail.com>
 <CAOQ4uxhNCg53mcNpzDyos3BV5dmL=2FVAipb4YKYmK3bvEzaBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhNCg53mcNpzDyos3BV5dmL=2FVAipb4YKYmK3bvEzaBQ@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 12-12-24 16:02:16, Amir Goldstein wrote:
> On Thu, Dec 12, 2024 at 1:45 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, 12 Dec 2024 at 12:27, Jan Kara <jack@suse.cz> wrote:
> >
> > > Why not:
> > >         if (p->prev_ns == p->mnt_ns) {
> > >                 fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> > >                 return;
> > >         }
> >
> > I don't really care, but I think this fails both as an optimization
> > (zero chance of actually making a difference) and as a readability
> > improvement.

I was just staring at the code trying to understand why you special-case
the situations with non-existent prev / current ns until I understood
there's no real reason. But I agree it's a matter of a taste so I'm fine
with keeping things as you have them.

> > > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > > > index 24c7c5df4998..a9dc004291bf 100644
> > > > --- a/fs/notify/fanotify/fanotify.c
> > > > +++ b/fs/notify/fanotify/fanotify.c
> > > > @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
> > > >       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> > > >               return fanotify_error_event_equal(FANOTIFY_EE(old),
> > > >                                                 FANOTIFY_EE(new));
> > > > +     case FANOTIFY_EVENT_TYPE_MNT:
> > > > +             return false;
> > >
> > > Perhaps instead of handling this in fanotify_should_merge(), we could
> > > modify fanotify_merge() directly to don't even try if the event is of type
> > > FANOTIFY_EVENT_TYPE_MNT? Similarly as we do it there for permission events.
> >
> > Okay.
> 
> Actually, I disagree.
> For permission events there is a conceptual reason not to merge,
> but this is not true for mount events.
> 
> Miklos said that he is going to add a FAN_MOUNT_MODIFY event
> for changing mount properties and we should very much merge multiple
> mount modify events.
>
> Furthermore, I wrote my comment about not merging mount events
> back when the mount event info included the parent mntid.
> Now that the mount event includes only the mount's mntid itself,
> multiple mount moves *could* actually be merged to a single move
> and a detach + attach could be merged to a move.
> Do we want to merge mount move events? that is a different question
> I guess we don't, but any case this means that the check should remain
> where it is now, so that we can check for specific mount events in the
> mask to decide whether or not to merge them.

Ok, fair enough. What triggered this request was that currently we just
look at each event in the queue, ask for each one "can we merge" only to
get "cannot" answer back. Which seemed dumb. But if we are going to add
events that can be merged, this reason obviously doesn't hold anymore. So
I'm retracting my objection :)

> > > > @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> > > >       pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
> > > >                __func__, iter_info->report_mask, event_mask, data, data_type);
> > > >
> > > > -     if (!fid_mode) {
> > > > +     if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> > > > +     {
> > >
> > > Unusual style here..
> >
> > Yeah, fixed.
> >
> > > Now if we expect these mount notification groups will not have more than
> > > these two events, then probably it isn't worth the hassle. If we expect
> > > more event types may eventually materialize, it may be worth it. What do
> > > people think?
> >
> > I have a bad feeling about just overloading mask values.  How about
> > reserving a single mask bit for all mount events?  I.e.
> >
> > #define FAN_MNT_ATTACH 0x00100001
> > #define FAN_MNT_DETACH 0x00100002
> 
> This is problematic.
> Because the bits reported in event->mask are often masked
> using this model makes assumptions that are not less risky
> that the risk of overloading 0x1 0x2 IMO.
> 
> I was contemplating deferring the decision about overloading for a while
> by using high bits for mount events.
> fanotify_mark() mask is already 64bit with high bits reserved
> and fanotify_event_metadata->mask is also 64bit.

Oh, right, fanotify API actually has a plenty of bits. I forgot that the
type is different from the generic one in fsnotify. Thanks for reminding
me!

> The challenge is that all internal fsnotify code uses __u32 masks
> and so do {i,sb,mnt}_fsnotify_mask.

Yeah, including struct fanotify_event.
 
> However, as I have already claimed, maintaining the mount event bits
> in the calculated object mask is not very helpful IMO.
> 
> Attached demo patch that sends all mount events to group IFF
> group has a mount mark.
> 
> This is quite simple, but could also be extended later with a little
> more work to allow sb/mount mark to actually subscribe to mount events
> or to ignore mount events for a specific sb/mount, if we think this is useful.

So I like the prospect of internal event type eventually becoming 64-bit
but I don't think we should tie it to this patch set given we still have 7
bits left in the internal mask. Also if we do the conversion, I'd like to
go full 64-bit except for the very few places that have a good reason so
stay 32-bit. Because otherwise it's very easy to loose the upper bits
somewhere. So what we could do is to allocate the new FAN_MNT_ constants
from the upper 32 bits, for now leave FS_MNT_ in the lower 32 bits, and do
the conversions as I've mentioned. When we really start running out of
internal mask bits, we can implement the 64-bit event constant handling in
fsnotify core and move FS_MNT_ constants in the upper bits.

								Honza

> From 01295be4df1053b83a33c80fda138ec5734ac858 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Thu, 12 Dec 2024 15:11:28 +0100
> Subject: [PATCH] fsnotify: demo send all mount events to mount watchers
> 
> Should be changed to send mount event to all groups with mntns
> marks on the respective mntns.
> ---
>  fs/notify/fanotify/fanotify.c    | 23 +++++++++++++++++------
>  fs/notify/fsnotify.c             | 16 +++++++++-------
>  include/linux/fsnotify_backend.h |  8 +++++---
>  3 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 95646f7c46ca..d1c05e2a12da 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -296,7 +296,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
>   */
>  static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  				     struct fsnotify_iter_info *iter_info,
> -				     u32 *match_mask, u32 event_mask,
> +				     u32 *match_mask, u64 event_mask,
>  				     const void *data, int data_type,
>  				     struct inode *dir)
>  {
> @@ -309,10 +309,14 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	bool ondir = event_mask & FAN_ONDIR;
>  	int type;
>  
> -	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
> +	pr_debug("%s: report_mask=%x mask=%llx data=%p data_type=%d\n",
>  		 __func__, iter_info->report_mask, event_mask, data, data_type);
>  
> -	if (!fid_mode) {
> +	if (event_mask & FS_MOUNT_EVENTS) {
> +		/* Mount events are not about a specific path */
> +		if (path)
> +			return 0;
> +	} else if (!fid_mode) {
>  		/* Do we have path to open a file descriptor? */
>  		if (!path)
>  			return 0;
> @@ -326,6 +330,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	}
>  
>  	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> +		if (type == FSNOTIFY_ITER_TYPE_VFSMOUNT)
> +			marks_mask |= FS_MOUNT_EVENTS;
>  		/*
>  		 * Apply ignore mask depending on event flags in ignore mask.
>  		 */
> @@ -720,7 +726,7 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  
>  static struct fanotify_event *fanotify_alloc_event(
>  				struct fsnotify_group *group,
> -				u32 mask, const void *data, int data_type,
> +				u64 mask, const void *data, int data_type,
>  				struct inode *dir, const struct qstr *file_name,
>  				__kernel_fsid_t *fsid, u32 match_mask)
>  {
> @@ -826,6 +832,11 @@ static struct fanotify_event *fanotify_alloc_event(
>  						  moved, &hash, gfp);
>  	} else if (fid_mode) {
>  		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
> +	} else if (mask & FS_MOUNT_EVENTS) {
> +		mask <<= 32;
> +		struct path null_path = {};
> +		/* XXX: allocate mount event */
> +		event = fanotify_alloc_path_event(&null_path, &hash, gfp);
>  	} else {
>  		event = fanotify_alloc_path_event(path, &hash, gfp);
>  	}
> @@ -892,7 +903,7 @@ static void fanotify_insert_event(struct fsnotify_group *group,
>  	hlist_add_head(&event->merge_list, hlist);
>  }
>  
> -static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
> +static int fanotify_handle_event(struct fsnotify_group *group, u64 mask,
>  				 const void *data, int data_type,
>  				 struct inode *dir,
>  				 const struct qstr *file_name, u32 cookie,
> @@ -934,7 +945,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	if (!mask)
>  		return 0;
>  
> -	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
> +	pr_debug("%s: group=%p mask=%llx report_mask=%x\n", __func__,
>  		 group, mask, match_mask);
>  
>  	if (fanotify_is_perm_event(mask)) {
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 8ee495a58d0a..e1833d7b9b3c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -372,13 +372,13 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>  					   dir, name, cookie);
>  }
>  
> -static int send_to_group(__u32 mask, const void *data, int data_type,
> +static int send_to_group(__u64 mask, const void *data, int data_type,
>  			 struct inode *dir, const struct qstr *file_name,
>  			 u32 cookie, struct fsnotify_iter_info *iter_info)
>  {
>  	struct fsnotify_group *group = NULL;
> -	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> -	__u32 marks_mask = 0;
> +	__u64 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> +	__u64 marks_mask = 0;
>  	__u32 marks_ignore_mask = 0;
>  	bool is_dir = mask & FS_ISDIR;
>  	struct fsnotify_mark *mark;
> @@ -398,13 +398,15 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>  
>  	/* Are any of the group marks interested in this event? */
>  	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> +		if (type == FSNOTIFY_ITER_TYPE_VFSMOUNT)
> +			marks_mask |= FS_MOUNT_EVENTS;
>  		group = mark->group;
>  		marks_mask |= mark->mask;
>  		marks_ignore_mask |=
>  			fsnotify_effective_ignore_mask(mark, is_dir, type);
>  	}
>  
> -	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
> +	pr_debug("%s: group=%p mask=%llx marks_mask=%llx marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
>  		 __func__, group, mask, marks_mask, marks_ignore_mask,
>  		 data, data_type, dir, cookie);
>  
> @@ -533,7 +535,7 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>   *		reported to both.
>   * @cookie:	inotify rename cookie
>   */
> -int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> +int fsnotify(__u64 mask, const void *data, int data_type, struct inode *dir,
>  	     const struct qstr *file_name, struct inode *inode, u32 cookie)
>  {
>  	const struct path *path = fsnotify_data_path(data, data_type);
> @@ -545,7 +547,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	struct dentry *moved;
>  	int inode2_type;
>  	int ret = 0;
> -	__u32 test_mask, marks_mask;
> +	__u64 test_mask, marks_mask;
>  
>  	if (path)
>  		mnt = real_mount(path->mnt);
> @@ -583,7 +585,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  
>  	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
>  	if (mnt)
> -		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
> +		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask) | FS_MOUNT_EVENTS;
>  	if (inode)
>  		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
>  	if (inode2)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 0d24a21a8e60..58b5ac75f5f4 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -106,6 +106,8 @@
>   */
>  #define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD)
>  
> +#define FS_MOUNT_EVENTS (0xfUL << 32)
> +
>  /* Events that can be reported to backends */
>  #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
>  			     FS_EVENTS_POSS_ON_CHILD | \
> @@ -162,7 +164,7 @@ struct mem_cgroup;
>   *		userspace messages that marks have been removed.
>   */
>  struct fsnotify_ops {
> -	int (*handle_event)(struct fsnotify_group *group, u32 mask,
> +	int (*handle_event)(struct fsnotify_group *group, u64 mask,
>  			    const void *data, int data_type, struct inode *dir,
>  			    const struct qstr *file_name, u32 cookie,
>  			    struct fsnotify_iter_info *iter_info);
> @@ -605,7 +607,7 @@ struct fsnotify_mark {
>  /* called from the vfs helpers */
>  
>  /* main fsnotify call to send events */
> -extern int fsnotify(__u32 mask, const void *data, int data_type,
> +extern int fsnotify(__u64 mask, const void *data, int data_type,
>  		    struct inode *dir, const struct qstr *name,
>  		    struct inode *inode, u32 cookie);
>  extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> @@ -906,7 +908,7 @@ static inline int fsnotify_pre_content(const struct path *path,
>  	return 0;
>  }
>  
> -static inline int fsnotify(__u32 mask, const void *data, int data_type,
> +static inline int fsnotify(__u64 mask, const void *data, int data_type,
>  			   struct inode *dir, const struct qstr *name,
>  			   struct inode *inode, u32 cookie)
>  {
> -- 
> 2.34.1
> 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

