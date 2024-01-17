Return-Path: <linux-fsdevel+bounces-8182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AE2830B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818DE1C24E7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E98224D3;
	Wed, 17 Jan 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dF3qxzIk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UEwAvDcT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dF3qxzIk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UEwAvDcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8A33FA;
	Wed, 17 Jan 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509220; cv=none; b=Q64rDuYBKWzBroYmTxcMWGJ0wRcMbsLH2kFW1W4nfo4A/X0mjSw1WjTdm17TOhLUJgFtQYzmg6pCdfvorTn9UQoR0GUDT2scMBLLemfWVZ2Mlc51G2kEQJ6SgqxGzDYKzmqlymAec4xYyA4nuwhIC4LXL6zSGv2w8/rkIdfPtqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509220; c=relaxed/simple;
	bh=RRdGsBPYxKIw5yQ5auuiyVXYfbGRxrn8l1FIc3G7yNM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=gwy81VqvHGz34N0PxUI2zzUlzHYgMQZ2YFiNxmB6P88gjOrEj7AWFp1Vsw9Lc5cNZPPxamm1JES8clT0rBPmoiDzONxOGR91mLYG7lsParz4mzUigE4W0oxv2YdbiKaNTtFiLRpHo0PE/mikap1VeV15qwKXUDzC2WbBaguP9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dF3qxzIk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UEwAvDcT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dF3qxzIk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UEwAvDcT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D05D822131;
	Wed, 17 Jan 2024 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705509216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5GTLvOBAfyQElFyDldGjCgb+GjuewTcWU4y3CRfw/k=;
	b=dF3qxzIkLpWU9iLerJX+rSb9My8h4cJ52YL8R7KBn0fUJk29+91glNXf2MqXFPqCEuA9jJ
	O8hFGBMoy0KJM7QFWrQbTdiYMNmQYZARXtCsRAh1RzjL8fATcUw0zLalYvXEppjTbA545o
	QA6nnKrwfsiC3uQ7HF6djkRQSotUcIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705509216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5GTLvOBAfyQElFyDldGjCgb+GjuewTcWU4y3CRfw/k=;
	b=UEwAvDcT2jJLNnb9epjx54MCW7ZyJMzAcCcf4ILZG34QowpHEyfkzyvYtq/xgF15f/wxYA
	JPTxCWE/TvCRWYDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705509216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5GTLvOBAfyQElFyDldGjCgb+GjuewTcWU4y3CRfw/k=;
	b=dF3qxzIkLpWU9iLerJX+rSb9My8h4cJ52YL8R7KBn0fUJk29+91glNXf2MqXFPqCEuA9jJ
	O8hFGBMoy0KJM7QFWrQbTdiYMNmQYZARXtCsRAh1RzjL8fATcUw0zLalYvXEppjTbA545o
	QA6nnKrwfsiC3uQ7HF6djkRQSotUcIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705509216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5GTLvOBAfyQElFyDldGjCgb+GjuewTcWU4y3CRfw/k=;
	b=UEwAvDcT2jJLNnb9epjx54MCW7ZyJMzAcCcf4ILZG34QowpHEyfkzyvYtq/xgF15f/wxYA
	JPTxCWE/TvCRWYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E6C13751;
	Wed, 17 Jan 2024 16:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rj1ML2ABqGULLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 16:33:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7886CA0803; Wed, 17 Jan 2024 17:33:36 +0100 (CET)
Date: Wed, 17 Jan 2024 17:33:36 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH DRAFT RFC 34/34] buffer: port block device access to
 files and get rid of bd_inode access
Message-ID: <20240117163336.glysm6rzsrbjatjt@quack3>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
 <ZZuNgqLNimnMBTIC@dread.disaster.area>
 <20240117161500.bibuljso32a2a26y@quack3>
 <20240117162423.GA3849@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117162423.GA3849@lst.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.84
X-Spamd-Result: default: False [-0.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[58.58%]
X-Spam-Flag: NO

On Wed 17-01-24 17:24:23, Christoph Hellwig wrote:
> On Wed, Jan 17, 2024 at 05:15:00PM +0100, Jan Kara wrote:
> > > >  	iomap->bdev = bdev;
> > > > +	BUG_ON(true /* TODO(brauner): This is the only place where we don't go from inode->i_sb->s_f_bdev for obvious reasons. Thoughts? */);
> > > 
> > > Maybe block devices should have their own struct file created when the
> > > block device is instantiated and torn down when the block device is
> > > trashed?
> > 
> > OK, but is there a problem with I_BDEV() which is currently used in
> > blkdev_iomap_begin()?
> 
> Well, blkdev_iomap_begin is always called on the the actual bdev fs
> inode that is allocated together with the bdev itself.  So we'll always
> be able to get to it using container_of variants.

Yes, that was exactly my point.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

