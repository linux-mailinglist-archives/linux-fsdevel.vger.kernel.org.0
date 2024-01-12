Return-Path: <linux-fsdevel+bounces-7865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D125882BEF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46EF1C24516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E660ED4;
	Fri, 12 Jan 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pmhBq5eE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HpGVRyDB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pmhBq5eE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HpGVRyDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FED61675
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AA471FC31;
	Fri, 12 Jan 2024 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705057781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyPZaJmiZu98CJI9g8kGq7Jiju1If2+sjDun7ryQyos=;
	b=pmhBq5eEzkh5DdM90yMfIEdbNKs2wpIn/AIuTPRGimQKW3VMGDo5alX+W1XcrZbm6f1oNr
	iUoBqtuIIYr6lyr3XDOVjHhV+2tWeeuHIYRkpVeMJJkTmeH+YZnqoxYRJRWbOogEVosC62
	x65/ExiXsg5048Yzh6QZIQQ3MZXR67g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705057781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyPZaJmiZu98CJI9g8kGq7Jiju1If2+sjDun7ryQyos=;
	b=HpGVRyDBE2CwWbt4olmfcfx4MYf46e+glOvJ4EB2NUVyxh52WC1LJuyVFOvkoVH9kUL8Ch
	qMvvFbtBWqye7fAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705057781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyPZaJmiZu98CJI9g8kGq7Jiju1If2+sjDun7ryQyos=;
	b=pmhBq5eEzkh5DdM90yMfIEdbNKs2wpIn/AIuTPRGimQKW3VMGDo5alX+W1XcrZbm6f1oNr
	iUoBqtuIIYr6lyr3XDOVjHhV+2tWeeuHIYRkpVeMJJkTmeH+YZnqoxYRJRWbOogEVosC62
	x65/ExiXsg5048Yzh6QZIQQ3MZXR67g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705057781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyPZaJmiZu98CJI9g8kGq7Jiju1If2+sjDun7ryQyos=;
	b=HpGVRyDBE2CwWbt4olmfcfx4MYf46e+glOvJ4EB2NUVyxh52WC1LJuyVFOvkoVH9kUL8Ch
	qMvvFbtBWqye7fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EFC5136A4;
	Fri, 12 Jan 2024 11:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7MsnF/UdoWUCUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Jan 2024 11:09:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9832A0802; Fri, 12 Jan 2024 12:09:36 +0100 (CET)
Date: Fri, 12 Jan 2024 12:09:36 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event
 watchers
Message-ID: <20240112110936.ibz4s42x75mjzhlv@quack3>
References: <20240111152233.352912-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111152233.352912-1-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pmhBq5eE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HpGVRyDB
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6AA471FC31
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> optimized the case where there are no fsnotify watchers on any of the
> filesystem's objects.
> 
> It is quite common for a system to have a single local filesystem and
> it is quite common for the system to have some inotify watches on some
> config files or directories, so the optimization of no marks at all is
> often not in effect.
> 
> Content event (i.e. access,modify) watchers on sb/mount more rare, so
> optimizing the case of no sb/mount marks with content events can improve
> performance for more systems, especially for performance sensitive io
> workloads.
> 
> Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
> events in their mask exist and use that flag to optimize out the call to
> __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> -static inline int fsnotify_file(struct file *file, __u32 mask)
> +static inline int fsnotify_path(const struct path *path, __u32 mask)
>  {
> -	const struct path *path;
> +	struct dentry *dentry = path->dentry;
>  
> -	if (file->f_mode & FMODE_NONOTIFY)
> +	if (!fsnotify_sb_has_watchers(dentry->d_sb))
>  		return 0;
>  
> -	path = &file->f_path;
> +	/* Optimize the likely case of sb/mount/parent not watching content */
> +	if (mask & FSNOTIFY_CONTENT_EVENTS &&
> +	    likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &&
> +	    likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
> +		/*
> +		 * XXX: if SB_I_CONTENT_WATCHED is not set, checking for content
> +		 * events in s_fsnotify_mask is redundant, but it will be needed
> +		 * if we use the flag FS_MNT_CONTENT_WATCHED to indicate the
> +		 * existence of only mount content event watchers.
> +		 */
> +		__u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
> +				   dentry->d_sb->s_fsnotify_mask;
> +
> +		if (!(mask & marks_mask))
> +			return 0;
> +	}

So I'm probably missing something but how is all this patch different from:

	if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))) {
		__u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
			path->mnt->mnt_fsnotify_mask |
			dentry->d_sb->s_fsnotify_mask;
		if (!(mask & marks_mask))
			return 0;
	}

I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent events
(read & write) we care about. In Jens' case

	!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
	!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)

is true as otherwise we'd go right to fsnotify_parent() and so Jens
wouldn't see the performance benefit. But then with your patch you fetch
i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
difference to what I suggest above is the path->mnt->mnt_fsnotify_mask
fetch but that is equivalent to sb->s_iflags (or wherever we store that
bit) fetch?

So that would confirm that the parent handling costs in fsnotify_parent()
is what's really making the difference and just avoiding that by checking
masks early should be enough?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

