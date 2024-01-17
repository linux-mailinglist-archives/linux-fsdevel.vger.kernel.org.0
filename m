Return-Path: <linux-fsdevel+bounces-8181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD5830B1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF6FB259DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2B224E3;
	Wed, 17 Jan 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nnUDxzxx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="trIQcW0W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FzVJHH7R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D/4R5JRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC7224DA;
	Wed, 17 Jan 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509178; cv=none; b=YS6PjbJb6lP4W3mFnfgpkw8NH4iQHE0yEqAONNSXiK5lHNA19P+c58eiQeFGP8mBRH45ZX4t8MNwNj3riBJg/joQ17rX0KsO4MHpGX+fp0z9ym4QXYx51j5h8d/mGXpcPr31R+rgtQevVA97l+1y08PfKz5qEPLYIMbzDV7BLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509178; c=relaxed/simple;
	bh=QDMADERWhSLEFwy2xIrFpCJfDjkB6RSzMMLfekgkE8U=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=SVPJJ5IvszTukSJvBGxko/C/BV1pI/vdbZNmcktVjE+JspYFvRfru1fXwaQVDDz92Ncl94xkBu/Pe7f56MiAQUviodReW8zW9ji6nzmHmva+WqUlzn/lmUeR72yAqlk3to5XWh72T0hvxXhZ8xsUF2FViiooQIEHbqQ9SG3GT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nnUDxzxx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=trIQcW0W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FzVJHH7R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D/4R5JRh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E855322131;
	Wed, 17 Jan 2024 16:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705509175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45oUgvP3tv7DWK6DdhwrA2hxTcqXhCFPNs5BD982RQQ=;
	b=nnUDxzxxSn3++GCs3063CPM0x0wrsrGqfxPZZmRqNPBnj6wiwVPXGgktXyHOGyidk6B2nM
	CfTUhyb8RY6PO0rnCm9PifxHyik44dX7R3hBp8rHs9UIZv4JVoFSK4Q5i3d/mDMPg+M5j0
	wmpQKe/18h7uxcLEIYLsXsna4C43bfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705509175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45oUgvP3tv7DWK6DdhwrA2hxTcqXhCFPNs5BD982RQQ=;
	b=trIQcW0WiYA0gIfPtR0Kwf5h7W2b6ccUpCSJPdCL6FomPlyNhtUParnl/Z0LKU8BjpVuFq
	DPa9Dr1j2a0aIsAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705509174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45oUgvP3tv7DWK6DdhwrA2hxTcqXhCFPNs5BD982RQQ=;
	b=FzVJHH7RqLAGnxOTyykPXXpoGkC4eatIO8o8e3x4Sqp2zq1XHLV5NrQgGgb6gy7bnWClgg
	DVQ4pL3WUJ4IGLB+fFMbdHVxt/ZTzyfO8z2rQkGjzi4NT8CC5sNlLoqHo4Qqc9+jcyX+68
	mpVIg4Wtq9jSRQXYEsbyZXAB91cH6pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705509174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45oUgvP3tv7DWK6DdhwrA2hxTcqXhCFPNs5BD982RQQ=;
	b=D/4R5JRhyaSqum1QZEups/AKbtOGLj9jkMGpM2ZOOLVEN9Uk1cahaFE2n12wu8QIkuK7t8
	1JvLpcmOLa1QA6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCC3413751;
	Wed, 17 Jan 2024 16:32:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /zvkNTYBqGXPLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 16:32:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89966A0803; Wed, 17 Jan 2024 17:32:54 +0100 (CET)
Date: Wed, 17 Jan 2024 17:32:54 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH DRAFT RFC 34/34] buffer: port block device access to
 files and get rid of bd_inode access
Message-ID: <20240117163254.xfcqpkpy3ok5blui@quack3>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FzVJHH7R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="D/4R5JRh"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.24%]
X-Spam-Score: -1.03
X-Rspamd-Queue-Id: E855322131
X-Spam-Flag: NO

> @@ -68,6 +69,7 @@ struct buffer_head {
>  	size_t b_size;			/* size of mapping */
>  	char *b_data;			/* pointer to data within the page */
>  
> +	struct file *f_b_bdev;
>  	struct block_device *b_bdev;
>  	bh_end_io_t *b_end_io;		/* I/O completion */
>   	void *b_private;		/* reserved for b_end_io */

It is kind of annoying to have bdev duplicated in every buffer_head.
Perhaps we can get rid of b_bdev?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

