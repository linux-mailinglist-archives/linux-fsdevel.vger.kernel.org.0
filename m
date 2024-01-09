Return-Path: <linux-fsdevel+bounces-7589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678FC82826C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 09:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A5DB2771B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD052940E;
	Tue,  9 Jan 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqiACj9W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="et8nrS9U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqiACj9W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="et8nrS9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A2250F5;
	Tue,  9 Jan 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39FD32203B;
	Tue,  9 Jan 2024 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704789988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWvl7eezGmltSZjw39tiyFLG6FsLZbKyWsaU4tY+K2I=;
	b=kqiACj9WEF6XijEuJ5RyuWmxZnAfDNlHl4gcf1NBfO9nZVbblmrtbDIkhd/ilUBbknYBH4
	eBqB1eyLrbAYVoWxma+5m0ycspQ/EguE8pbznrDNKjK/liM8PyfbkBYDdWPujYb8CnjXAT
	UI0NGp51RrItTmx+NXVQa+cEmbYWhMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704789988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWvl7eezGmltSZjw39tiyFLG6FsLZbKyWsaU4tY+K2I=;
	b=et8nrS9UMemS7A6J9sTHFHmnzfMsqckLLn0okmBnbsCHL/1cCA2cg13O9Laa9ucPql3FBI
	BljOfNblaN8Hy6Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704789988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWvl7eezGmltSZjw39tiyFLG6FsLZbKyWsaU4tY+K2I=;
	b=kqiACj9WEF6XijEuJ5RyuWmxZnAfDNlHl4gcf1NBfO9nZVbblmrtbDIkhd/ilUBbknYBH4
	eBqB1eyLrbAYVoWxma+5m0ycspQ/EguE8pbznrDNKjK/liM8PyfbkBYDdWPujYb8CnjXAT
	UI0NGp51RrItTmx+NXVQa+cEmbYWhMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704789988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWvl7eezGmltSZjw39tiyFLG6FsLZbKyWsaU4tY+K2I=;
	b=et8nrS9UMemS7A6J9sTHFHmnzfMsqckLLn0okmBnbsCHL/1cCA2cg13O9Laa9ucPql3FBI
	BljOfNblaN8Hy6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 285E0134E8;
	Tue,  9 Jan 2024 08:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0qsbCeQHnWUzcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Jan 2024 08:46:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA2A7A07EB; Tue,  9 Jan 2024 09:46:27 +0100 (CET)
Date: Tue, 9 Jan 2024 09:46:27 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 00/34] Open block devices as files & a bd_inode
 proposal
Message-ID: <20240109084627.p6nekbvq6wpiqq3x@quack3>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240108162641.GA7842@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108162641.GA7842@lst.de>
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kqiACj9W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=et8nrS9U
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[23.58%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 39FD32203B
X-Spam-Flag: NO

On Mon 08-01-24 17:26:41, Christoph Hellwig wrote:
> On Wed, Jan 03, 2024 at 01:54:58PM +0100, Christian Brauner wrote:
> > I wanted to see whether we can make struct bdev_handle completely
> > private to the block layer in the next cycle and unexport low-level
> > helpers such as bdev_release() - formerly blkdev_put() - completely.
> 
> I think we can actually kill bdev_handle entirely.  We can get the
> bdev from the bdev inode using I_BDEV already, so no need to store
> the bdev.  We don't need the mode field as we known an exlusive
> open is equivalent to having a holder.  So just store the older in
> file->private_data and the bdev_handle can be removed again.

Well, we also need the read-write mode of the handle in some places but that
could be stored in file->f_mode (not sure if it really gets stored there
in this patch set - still need to read the details) so in principle I agree
that bdev_handle should not be necessary.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

