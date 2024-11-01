Return-Path: <linux-fsdevel+bounces-33456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72949B900D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B90282BFD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0DB19924A;
	Fri,  1 Nov 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BS4NLzw0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QYYpkd0C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BS4NLzw0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QYYpkd0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767211946C4;
	Fri,  1 Nov 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459654; cv=none; b=nu8GyHpmK1bftoBgUbOL+IcCbLAilTpq6HvHeC5U006GGj8xf+fdM2ZmhC29ynzvATCKNdM8A0Uas88crmhSWai/hXTpC6XC62PRB38CNNEZM6x7ejYw6uAW/9aKVOgzIDDeh697IDtPIbRAqlrAIL8aNjYPeuxHhQhFvpJbO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459654; c=relaxed/simple;
	bh=h/zb5oZ2xfAJZ5EiO7dNGMWaq1y9SO/DI0yoTd4CXF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvOELTe/JpBUV24OxI7op/7a04t0a9zizqvgUnnEiQee0LU7W46iZ2VdwRx8WrJrS1qJjBHsRHMo96az81kSkV7BP/Cs0JFo0aOQisd81BEvKyAXfGHgiuwhdLE9Jo58vccNyYpuCvMbCKFxrECDBSn7+Lasi+jlqE+bOp5N7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BS4NLzw0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QYYpkd0C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BS4NLzw0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QYYpkd0C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9867021E38;
	Fri,  1 Nov 2024 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyyL/RD0X1cI6UUcW1ht+DqU0NPJSmQpscXuunL1J/E=;
	b=BS4NLzw0XU/muMoq/5yvtwqScxZfMxl1B9olDrVwNdQL1Ir/NIzk38BW2XWJKV+S1Z5viQ
	u8U9QDrtGTw961/3n3jRx/LPtAVjXZr4z88O7ZnHPZkuB1bMnGRy/L0CZD72lOnaB0WpV5
	tGPjALejIJZ2K8keW3NdZllUDHlguvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyyL/RD0X1cI6UUcW1ht+DqU0NPJSmQpscXuunL1J/E=;
	b=QYYpkd0C2wgXSoTIyU9/Ap9mtVdOipP2rYxVuf6WfxQzzBAKLjs3oS5Qs7n5c20VEjja3M
	eqzVqEY0UBMG5eCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BS4NLzw0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QYYpkd0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyyL/RD0X1cI6UUcW1ht+DqU0NPJSmQpscXuunL1J/E=;
	b=BS4NLzw0XU/muMoq/5yvtwqScxZfMxl1B9olDrVwNdQL1Ir/NIzk38BW2XWJKV+S1Z5viQ
	u8U9QDrtGTw961/3n3jRx/LPtAVjXZr4z88O7ZnHPZkuB1bMnGRy/L0CZD72lOnaB0WpV5
	tGPjALejIJZ2K8keW3NdZllUDHlguvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyyL/RD0X1cI6UUcW1ht+DqU0NPJSmQpscXuunL1J/E=;
	b=QYYpkd0C2wgXSoTIyU9/Ap9mtVdOipP2rYxVuf6WfxQzzBAKLjs3oS5Qs7n5c20VEjja3M
	eqzVqEY0UBMG5eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BCC7136D9;
	Fri,  1 Nov 2024 11:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9RkeIgK4JGdxVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Nov 2024 11:14:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C06CA0AF4; Fri,  1 Nov 2024 12:14:06 +0100 (CET)
Date: Fri, 1 Nov 2024 12:14:06 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ext4: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <20241101111406.tldgl7rdfieqpq3o@quack3>
References: <cover.1730437365.git.ritesh.list@gmail.com>
 <d8f73bc9fef19dd90de537376f11f9f26daccbeb.1730437365.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f73bc9fef19dd90de537376f11f9f26daccbeb.1730437365.git.ritesh.list@gmail.com>
X-Rspamd-Queue-Id: 9867021E38
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 01-11-24 12:20:53, Ritesh Harjani (IBM) wrote:
> FS needs to add the fmode capability in order to support atomic writes
> during file open (refer kiocb_set_rw_flags()). Set this capability on
> a regular file if ext4 can do atomic write.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index a7b9b9751a3f..96d936f5584b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -898,6 +898,9 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>  			return ret;
>  	}
> 
> +	if (ext4_inode_can_atomic_write(inode))
> +		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
> +
>  	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
>  	return dquot_file_open(inode, filp);
>  }
> --
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

