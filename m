Return-Path: <linux-fsdevel+bounces-71831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088ECD696F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614B1306A2C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BD2F999F;
	Mon, 22 Dec 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xGclTYGz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="znIS3dyE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r1x6ydTJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n6mwVSJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6E308F07
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417780; cv=none; b=SfyuDzIuYkX+bLjWKwZStGMcRphEXl0xMRxXGhiMm4Fapc+ETCxYq+A2Yp8JQzF7cLs7sCXa77tZLR8abmu9knuzWxaDogTiiuObUwlj49j5JAOsHvZdc/gu1SQG7I5vk+7pjUP5AjVlohneli+V2pqlSN2FNjduw4/4Qhd3lEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417780; c=relaxed/simple;
	bh=lOqQG2EGhBnybfgMFM30ZXJMDMi1J18t4+jGfujyHr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U27jLsIX+/Ez2Yzmiel10goM8YN2gjbnrqQc6GPynQSJMmpYx4q9MH88MQ5l5DSlXUC78ptyKEQxuVX6WIzOxg0xf1erVHCgg3zayAtxYIMCXYvLKPlJGynsrmUBYOFY2grIEmi0w1vkgbOUbfO4lXFdwWmxYsNz3cgx0N+pIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xGclTYGz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=znIS3dyE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r1x6ydTJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n6mwVSJT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37D90336A0;
	Mon, 22 Dec 2025 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766417777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5h7+A5awHzkqbIHTSYYSLcXY7sXSCMhj2UcviA/ZOg=;
	b=xGclTYGzxgCAiGf2rsY5NSDnd662HC7W5T+5haLCTzllg0JJziFeZXZE0jdHW+fSve1nQj
	oWRKF6I9r+qz2BMeG9sChxD0HV7O1gMnDsorZvKgYVymvHYoUmnr7R0GfHAnwuieUKmnci
	bLaPLj55hKVQKfg/NUTHnX+Lr4+RxPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766417777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5h7+A5awHzkqbIHTSYYSLcXY7sXSCMhj2UcviA/ZOg=;
	b=znIS3dyEfdCGy/1NWT2t/Ae9DNQ6Y8fM6cJTddTiYnJ/oAcZL+cZXxKxmYGBmvoB4oFfCe
	ST60pL4AsrjrMaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766417775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5h7+A5awHzkqbIHTSYYSLcXY7sXSCMhj2UcviA/ZOg=;
	b=r1x6ydTJgRcyBOIqB9Y/qfRXG4JZwju7cDb7a4aAcNuhn9xtWepTqRjpCI9AzqZr38+ju6
	Rjmd9L6FPfcp+qTn6nYatl2KvMjL8+htiY+SemGC7V+D0b5v7p9tK6+g5Vbz+mXFhEAcI2
	8Pe0LVxH6EKm5OIQgM0k8vAuHMSf0Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766417775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5h7+A5awHzkqbIHTSYYSLcXY7sXSCMhj2UcviA/ZOg=;
	b=n6mwVSJTG3c7QIMaJFXCa9AuExDQWPM6eY4OJlyDPsIPRUDwEErF/MqsdOyavH/GU1hW/L
	gUV6CARDiHuCSCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DDA51364B;
	Mon, 22 Dec 2025 15:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QEgvC29lSWl9DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Dec 2025 15:36:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E7058A09CB; Mon, 22 Dec 2025 16:36:14 +0100 (CET)
Date: Mon, 22 Dec 2025 16:36:14 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, linux-ext4@vger.kernel.org, 
	jack@suse.cz, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <cunesvp5k37ocmz2nbkdov7ssu3djqvdii26d4gn6sj7sgtnca@b5mokxhvneay>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,vger.kernel.org,suse.cz,krisman.be,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Wed 17-12-25 18:03:11, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create some wrapper code around struct super_block so that filesystems
> have a standard way to queue filesystem metadata and file I/O error
> reports to have them sent to fsnotify.
> 
> If a filesystem wants to provide an error number, it must supply only
> negative error numbers.  These are stored internally as negative
> numbers, but they are converted to positive error numbers before being
> passed to fanotify, per the fanotify(7) manpage.  Implementations of
> super_operations::report_error are passed the raw internal event data.
> 
> Note that we have to play some shenanigans with mempools and queue_work
> so that the error handling doesn't happen outside of process context,
> and the event handler functions (both ->report_error and fsnotify) can
> handle file I/O error messages without having to worry about whatever
> locks might be held.  This asynchronicity requires that unmount wait for
> pending events to clear.
> 
> Add a new callback to the superblock operations structure so that
> filesystem drivers can themselves respond to file I/O errors if they so
> desire.  This will be used for an upcoming self-healing patchset for
> XFS.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good to me. Besides the nits Christoph commented on just two comments:

> +static inline struct fserror_event *fserror_alloc_event(struct super_block *sb,
> +							gfp_t gfp_flags)
> +{
> +	struct fserror_event *event = NULL;
> +
> +	/*
> +	 * If pending_errors already reached zero or is no longer active,
> +	 * the superblock is being deactivated so there's no point in
> +	 * continuing.
> +	 */
> +	if (!refcount_inc_not_zero(&sb->s_pending_errors))
> +		return NULL;

It would be good here or in the above comment explicitely mention that the
ordering of s_pending_errors check and SB_ACTIVE check is mandated by the
ordering in generic_shutdown_super() and that the barriers are implicitely
provided by the refcount manipulations here and in fserror_unmount().

> +	if (!(sb->s_flags & SB_ACTIVE))
> +		goto out_pending;
> +
> +	event = mempool_alloc(&fserror_events_pool, gfp_flags);
> +	if (!event)
> +		goto out_pending;
> +
> +	/* mempool_alloc doesn't support GFP_ZERO */
> +	memset(event, 0, sizeof(*event));
> +	event->sb = sb;
> +	INIT_WORK(&event->work, fserror_worker);
> +
> +	return event;
> +
> +out_pending:
> +	fserror_pending_dec(sb);
> +	return NULL;
> +}
> +
> +/**
> + * fserror_report - report a filesystem error of some kind
> + *
> + * Report details of a filesystem error to the super_operations::report_error
> + * callback if present; and to fsnotify for distribution to userspace.  @sb,
> + * @gfp, @type, and @error must all be specified.  For file I/O errors, the
> + * @inode, @pos, and @len fields must also be specified.  For file metadata
> + * errors, @inode must be specified.  If @inode is not NULL, then @inode->i_sb
> + * must point to @sb.
> + *
> + * Reporting work is deferred to a workqueue to ensure that ->report_error is
> + * called from process context without any locks held.  An active reference to
> + * the inode is maintained until event handling is complete, and unmount will
> + * wait for queued events to drain.
> + *
> + * @sb:		superblock of the filesystem
> + * @inode:	inode within that filesystem, if applicable
> + * @type:	type of error encountered
> + * @pos:	start of inode range affected, if applicable
> + * @len:	length of inode range affected, if applicable
> + * @error:	error number encountered, must be negative
> + * @gfp:	memory allocation flags for conveying the event to a worker,
> + *		since this function can be called from atomic contexts
> + */
> +void fserror_report(struct super_block *sb, struct inode *inode,
> +		    enum fserror_type type, loff_t pos, u64 len, int error,
> +		    gfp_t gfp)
> +{
> +	struct fserror_event *event;
> +
> +	/* sb and inode must be from the same filesystem */
> +	WARN_ON_ONCE(inode && inode->i_sb != sb);
> +
> +	/* error number must be negative */
> +	WARN_ON_ONCE(error >= 0);

Since the error reporting is kind of expensive now (allocation & queueing
work) it would be nice to check somebody actually cares about the error
events at all. We can provide a helper from fsnotify for that, I'm not sure
about ->report_error hook since it didn't get used in this series at all in
the end...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

