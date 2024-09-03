Return-Path: <linux-fsdevel+bounces-28344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128AE969A22
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AE22846F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034841B982E;
	Tue,  3 Sep 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ic10XAO0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JgXQN2OW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NaWH4SqZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JtAWOSzV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5211B9826
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359320; cv=none; b=a/v+kNPiS0iki5qpdx+k/2ftLbvJm09BGF+8RdEk2tseqLMSWmp0oVbkdMC40ld7QeMPjkXdTJ7iJ+VTGvcOuJ4JkIdzd3H7A7qaP4vMf8p14x9LTCc+xcXgELbKqU1jz+svCJqxWLFWWbvjB1g/GN92s9Uz6wb83TDYkK/SPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359320; c=relaxed/simple;
	bh=H4cmpC3h8SIJcjrKu7Wg0V34ZTEqPEOh6tSU5asf5ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvA0OGFfWMa0PUP5cZkIcgZkqRTBRc12e8NYY05eYxZsn8F/UgNfd26gMaIlJ0B0VnLwC2LrxkyaiL8sIHS5jq6iXValm2Cnr39j0q3lKcWfr8mMrwYH+4InqTzA6PjWFtqoYKztFhl9rjvtvRdLT2P0OsDko3YdkBDb/eeM9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ic10XAO0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JgXQN2OW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NaWH4SqZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JtAWOSzV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7B0D1FCFD;
	Tue,  3 Sep 2024 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85MbVOlcwyoqCGbjVpH0iDxkOizKtR5lJyqicgbuNkc=;
	b=ic10XAO0H/XYb3E/+oTHI4nz0mRNFpL8td7qOUBYIN9tk+Re6AKvAyqV84H+jXFW+aTQPF
	l9R0eVV3r8Y4ouZ888LOLxVgmLgomhehL+afsjIzFMDNcnFA2eFLXbsjn9/22IpY+YWwsW
	S66fR8BhinGA284WcnwL+Ggo4WgMVkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85MbVOlcwyoqCGbjVpH0iDxkOizKtR5lJyqicgbuNkc=;
	b=JgXQN2OW+ehqgzX3W+Hu2Avpo2GSTVNqD5VIeMF919w7J5QV+tQZrJw7EfxJ2yJ6oSstdj
	mNqM4xAvhufLfYCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85MbVOlcwyoqCGbjVpH0iDxkOizKtR5lJyqicgbuNkc=;
	b=NaWH4SqZMlU064E59rSSOMrrRZnztIKbFW83EA5kyGFZFxdDv8Jhvm4/08mDwj6nbSmxeY
	JAcEZuC+TQxFJqpJb9mioCVUr7id5Ne0NrClo1Eut1cPYA5pz+h7nj880klb3P84Big7pi
	SlD8/OcMfYUMnDAAVaidrGQBai0si7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85MbVOlcwyoqCGbjVpH0iDxkOizKtR5lJyqicgbuNkc=;
	b=JtAWOSzVhU74H/uv0QN+bclzPa+rwOaLG94AbPueZ65OQQlvkLQ8zdyLDVjDV3hazWISBb
	Tv2X8Ie6r2YgULAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC48413A80;
	Tue,  3 Sep 2024 10:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NVbbMdTk1mbjDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 10:28:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E1D6A096C; Tue,  3 Sep 2024 12:28:21 +0200 (CEST)
Date: Tue, 3 Sep 2024 12:28:21 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 01/20] file: remove pointless comment
Message-ID: <20240903102821.j7odwt2i7klkjivs@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-1-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-1-6d3e4816aa7b@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:04:42, Christian Brauner wrote:
> There's really no need to mention f_version.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 3ef558f27a1c..bf1cbe47c93d 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -159,7 +159,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	mutex_init(&f->f_pos_lock);
>  	f->f_flags = flags;
>  	f->f_mode = OPEN_FMODE(flags);
> -	/* f->f_version: 0 */
>  
>  	/*
>  	 * We're SLAB_TYPESAFE_BY_RCU so initialize f_count last. While
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

