Return-Path: <linux-fsdevel+bounces-10323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C11849CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE4281633
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCC2C19C;
	Mon,  5 Feb 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2nMsNcPL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WjICKJUx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2nMsNcPL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WjICKJUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1B2C183;
	Mon,  5 Feb 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142760; cv=none; b=nfGY7R1isPLSWt14H6SEwW56jhiHxwa6OB7ToQV6TmELepAJ7x6OPiQQsDf7gY3pRKrG+x2Ku/8lbQMNfEsfzc5A7B/nnhMyzeAg6ywRIn+miZ8ChZcZhNP9mDWHTTNHzrfkQ1Mpp0rc58tVaV23shNlwvSyZ1gK7Ai96rVsk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142760; c=relaxed/simple;
	bh=wL7f3/q9wLuR8kbR26+8p0Wa2ib3IFx0iIqAMfT3Ab0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T45lufXx1B8OUbHcXPFA+zi58oXhy0m3KlTKh45LaGvnVmbtvQzYcytxWts0caIjvWmseWK4e/3qU8m48HbmJMaWd55O0svqGT6j8+JjGRRH3zJEXEqTYJ93Iz64xiEmXxAJLrcG1lnR35ES5NffkytLHgabGvoaXrmEpuZ3akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2nMsNcPL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WjICKJUx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2nMsNcPL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WjICKJUx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48E181F37C;
	Mon,  5 Feb 2024 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707142756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBuD2w214FrX4bQ1rAZNvdA6it7oOTmTdw3JUrl60T0=;
	b=2nMsNcPLTbESKwOSwuBRBjkuQZCfhXPPtG5XrVhmc+xHHTROjNGwJqqC8kj1ufY8DO3xJ3
	6CI1AGmYnFE/8Q2R8uRniKNwa/nFEWjv/CzqT7jXQw507c2rxKJf5xilzYsxvQUKsj/M+F
	MpjMo0ouKB9kei6xJ0XyGNveWISpKKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707142756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBuD2w214FrX4bQ1rAZNvdA6it7oOTmTdw3JUrl60T0=;
	b=WjICKJUxp0x5vEfN56Af6YLEk07IiHzPlqJl8Qoi3n9yLk/1QJb7uVqKvsbzVLttbxYdPM
	LaWBsN1KKtPaHjCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707142756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBuD2w214FrX4bQ1rAZNvdA6it7oOTmTdw3JUrl60T0=;
	b=2nMsNcPLTbESKwOSwuBRBjkuQZCfhXPPtG5XrVhmc+xHHTROjNGwJqqC8kj1ufY8DO3xJ3
	6CI1AGmYnFE/8Q2R8uRniKNwa/nFEWjv/CzqT7jXQw507c2rxKJf5xilzYsxvQUKsj/M+F
	MpjMo0ouKB9kei6xJ0XyGNveWISpKKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707142756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBuD2w214FrX4bQ1rAZNvdA6it7oOTmTdw3JUrl60T0=;
	b=WjICKJUxp0x5vEfN56Af6YLEk07IiHzPlqJl8Qoi3n9yLk/1QJb7uVqKvsbzVLttbxYdPM
	LaWBsN1KKtPaHjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D847136F5;
	Mon,  5 Feb 2024 14:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ChoAD2TuwGVJbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 14:19:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5627A0809; Mon,  5 Feb 2024 15:19:11 +0100 (CET)
Date: Mon, 5 Feb 2024 15:19:11 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240205141911.vbuqvjdbjw5pq2wc@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240205-biotechnologie-korallen-d2b3a7138ec0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205-biotechnologie-korallen-d2b3a7138ec0@brauner>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2nMsNcPL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WjICKJUx
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 48E181F37C
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

Hi!

On Mon 05-02-24 12:55:18, Christian Brauner wrote:
> On Tue, Jan 23, 2024 at 02:26:17PM +0100, Christian Brauner wrote:
> > Hey Christoph,
> > Hey Jan,
> > Hey Jens,
> > 
> > This opens block devices as files. Instead of introducing a separate
> > indirection into bdev_open_by_*() vis struct bdev_handle we can just
> > make bdev_file_open_by_*() return a struct file. Opening and closing a
> > block device from setup_bdev_super() and in all other places just
> > becomes equivalent to opening and closing a file.
> > 
> > This has held up in xfstests and in blktests so far and it seems stable
> > and clean. The equivalence of opening and closing block devices to
> > regular files is a win in and of itself imho. Added to that is the
> > ability to do away with struct bdev_handle completely and make various
> > low-level helpers private to the block layer.
> > 
> > All places were we currently stash a struct bdev_handle we just stash a
> > file and use an accessor such as file_bdev() akin to I_BDEV() to get to
> > the block device.
> > 
> > It's now also possible to use file->f_mapping as a replacement for
> > bdev->bd_inode->i_mapping and file->f_inode or file->f_mapping->host as
> > an alternative to bdev->bd_inode allowing us to significantly reduce or
> > even fully remove bdev->bd_inode in follow-up patches.
> > 
> > In addition, we could get rid of sb->s_bdev and various other places
> > that stash the block device directly and instead stash the block device
> > file. Again, this is follow-up work.
> > 
> > Thanks!
> > Christian
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> 
> With all fixes applied I've moved this into vfs.super on vfs/vfs.git so
> this gets some exposure in -next asap. Please let me know if you have
> quarrels with that.

No quarrels really. I went through the patches and all of them look fine to
me to feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I have just noticed that in "bdev: make struct bdev_handle private to the
block layer" in bdev_open() we are still leaking the handle in case of
error. This is however temporary (until the end of the series when we get
rid of handles altogether) so whatever.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

