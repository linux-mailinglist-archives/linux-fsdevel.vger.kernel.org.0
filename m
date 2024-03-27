Return-Path: <linux-fsdevel+bounces-15392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EF388DC12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 12:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEE81C2184B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE54535BE;
	Wed, 27 Mar 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fSixAuR0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="66PZOpFq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7yDo+8N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJrxr+qq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398F47F54;
	Wed, 27 Mar 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537672; cv=none; b=Fqz0KWZ7oaTQfwdPvNxCnVnHQODi19PRck2sDXpvGu6Etftv4+WeG9RyNJbtLc6uZapsC3QiVeccKDJEYBpqYeaBIdF5XqweeIPFLYjOt0pFVG7ZmMD18r9p4AhaMQEE/ZU1Botm0ED/17DKL/7D7z7uoBAZq/JbUZyvyGtu4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537672; c=relaxed/simple;
	bh=1dfEPzKEVWNrUV+mI+nm5xlPo1AvEbflnqWdxVFdPr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw7WWLFHE8P7vnxECBgx+oNetcYDw9im4ls2HP5q36Y8Drcbr4S5jHqsxXGBKe8F5VKU55gVRRq8iD4zGvEnlIf6rnzZtXXfdKbIblV0PZTXZYY3ajD+TZtObzpXrO1uOqsKssvFMyrzWsnODO3yov6F+w5ipBdWrRghNhHuFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fSixAuR0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=66PZOpFq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7yDo+8N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJrxr+qq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C467601C5;
	Wed, 27 Mar 2024 11:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711537666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9dvSwHy3aUaIeYrbKESDJ8mg3ki8eUShcw8jBq9U+c=;
	b=fSixAuR0Vfz2BGwAQoU1fZRFfJd9us6s3Eyg7IKbS/V7gBiasg75oxKInIm21Y/jQDTi0f
	c8NgMQMTos7kt6hXYfB0d5fLo/i3jVhXH4NQhmT/TGF4NTY8Jk8BTTUFzkk/lMmmCpK9zu
	/c77ZlOSRT3oW1Ueb32zFXAs0mUFQsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711537666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9dvSwHy3aUaIeYrbKESDJ8mg3ki8eUShcw8jBq9U+c=;
	b=66PZOpFqwGh8AQIk8ieBmYqqdiLXOYwiFcMgRK8tGBezynGn7FDvVVse9Ieb6hrhvCMEWH
	48EZUp+h4XvMqFDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711537665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9dvSwHy3aUaIeYrbKESDJ8mg3ki8eUShcw8jBq9U+c=;
	b=X7yDo+8N78THRcjIBKyXkGNMe9pSFz+HtAwVPQ/yo7TQ+ZU/2ijEHSrCUcdyyoZNWzPASA
	y9M3OwOnsCQ/zF/e4jAoSxw3KhO6VpJPGTgBGQzd9nWXHpozu0W6WbLkHxYvtK/FhaiaxQ
	fOamA+NCqeOhFKXzQABwJqbcdpbQCOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711537665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9dvSwHy3aUaIeYrbKESDJ8mg3ki8eUShcw8jBq9U+c=;
	b=gJrxr+qqqGp5tvfUpf2wZlECuuzgTVHWgQpczx4J8Hp0hgBaaqo36XCwiys+laCOPgrdRb
	KSMIWt1Jq5KGg1Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4038A13215;
	Wed, 27 Mar 2024 11:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vYqmDwH+A2ZEIQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 27 Mar 2024 11:07:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9ABBA0812; Wed, 27 Mar 2024 12:07:40 +0100 (CET)
Date: Wed, 27 Mar 2024 12:07:40 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs,block: yield devices early
Message-ID: <20240327110740.dgdp5fclsa4yvw2j@quack3>
References: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
 <20240326223213.ytrsxxjsq3twfsxy@quack3>
 <20240327-befanden-morsen-9f691f5624f9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-befanden-morsen-9f691f5624f9@brauner>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux-foundation.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Wed 27-03-24 09:56:59, Christian Brauner wrote:
> On Tue, Mar 26, 2024 at 11:32:13PM +0100, Jan Kara wrote:
> > On Tue 26-03-24 13:47:22, Christian Brauner wrote:
> > > Currently a device is only really released once the umount returns to
> > > userspace due to how file closing works. That ultimately could cause
> > > an old umount assumption to be violated that concurrent umount and mount
> > > don't fail. So an exclusively held device with a temporary holder should
> > > be yielded before the filesystem is gone. Add a helper that allows
> > > callers to do that. This also allows us to remove the two holder ops
> > > that Linus wasn't excited about.
> > > 
> > > Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ...
> > > @@ -1012,6 +1005,29 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
> > >  }
> > >  EXPORT_SYMBOL(bdev_file_open_by_path);
> > >  
> > > +static inline void bd_yield_claim(struct file *bdev_file)
> > > +{
> > > +	struct block_device *bdev = file_bdev(bdev_file);
> > > +	struct bdev_inode *bd_inode = BDEV_I(bdev_file->f_mapping->host);
> > > +	void *holder = bdev_file->private_data;
> > > +
> > > +	lockdep_assert_held(&bdev->bd_disk->open_mutex);
> > > +
> > > +	if (WARN_ON_ONCE(IS_ERR_OR_NULL(holder)))
> > > +		return;
> > > +
> > > +	if (holder != bd_inode) {
> > > +		bdev_yield_write_access(bdev_file);
> > 
> > Hum, what if we teached bdev_yield_write_access() about special bd_inode
> > holder and kept bdev_yield_write_access() and bd_yield_claim() separate as
> > they were before this patch? IMHO it would make code a bit more
> > understandable. Otherwise the patch looks good.
> 
> Ok, see appended patch where I folded in your suggestion.

Thanks. The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

