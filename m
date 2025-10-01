Return-Path: <linux-fsdevel+bounces-63168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDACBB0466
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 14:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279502A0349
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9CA2E8E11;
	Wed,  1 Oct 2025 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TfrZCOlK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pw+A4C39";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TfrZCOlK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pw+A4C39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243B19DF4A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320435; cv=none; b=AX8EeBgvLWToMASnp5CrdtKI+gZ6zdud5SVIz15d0azYLGjhejeBvxmGuJJMWhV5hRV2DMmb6bG14l+/2cbdZkrOeuJcRMsWToxIlTG8QbteI3Qi8G8mVJoZzYNNVMzDDcQlPlIjSzvsuWpE469nk6qKxVZ64Mq1PRYFP4FN2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320435; c=relaxed/simple;
	bh=PMsduM/6z+JqtRD3Y4rmGbS2bcyBHNftc8HUzgankOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRsgGh+myl8jkK4T6Hgf5OxBWIl6h8S+5hJf9JPu6QadDUCGnSR4WXMRGgxmMWLQKCIHsDxjhE63DwYEt93C2su2JaTK+IjNurIG7NHJA/i+EbpN+/JQcGCpYvWvfMIoY3LjgeM7mzjI89o1h3omYkuJvqT8EEAEWBB83COAw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TfrZCOlK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pw+A4C39; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TfrZCOlK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pw+A4C39; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 747B91FB6C;
	Wed,  1 Oct 2025 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759320416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW89xEydgZ+WxtO4hft0LbkOLNl7Q/1THQ9ue6In+A8=;
	b=TfrZCOlKi+zXGI8OwJKn8y793UNkIJvRCc2ucm2QVIetowHblHPW6szL+lDnz0Z+zJOVhE
	EIbwNMRWUdxfegSyRUV39F4vdOtZfxBLKl7CGlkbM2xQ28cQHd4toR8S7CnZtvwsk+Tp/D
	PSI4hyRlsCnXH2gCISZ17hXQ0hqoofU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759320416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW89xEydgZ+WxtO4hft0LbkOLNl7Q/1THQ9ue6In+A8=;
	b=pw+A4C395CWAKI15RnWknR59SxkUsU5rEtwuGkSnBRw9e4bE+j1EPNnyk96Rozk8H6FOPO
	r/zdn7Q+ppdZ6nBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TfrZCOlK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pw+A4C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759320416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW89xEydgZ+WxtO4hft0LbkOLNl7Q/1THQ9ue6In+A8=;
	b=TfrZCOlKi+zXGI8OwJKn8y793UNkIJvRCc2ucm2QVIetowHblHPW6szL+lDnz0Z+zJOVhE
	EIbwNMRWUdxfegSyRUV39F4vdOtZfxBLKl7CGlkbM2xQ28cQHd4toR8S7CnZtvwsk+Tp/D
	PSI4hyRlsCnXH2gCISZ17hXQ0hqoofU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759320416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW89xEydgZ+WxtO4hft0LbkOLNl7Q/1THQ9ue6In+A8=;
	b=pw+A4C395CWAKI15RnWknR59SxkUsU5rEtwuGkSnBRw9e4bE+j1EPNnyk96Rozk8H6FOPO
	r/zdn7Q+ppdZ6nBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 577F613A42;
	Wed,  1 Oct 2025 12:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MixQFWAZ3WgLdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 12:06:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FD06A0A2D; Wed,  1 Oct 2025 14:06:56 +0200 (CEST)
Date: Wed, 1 Oct 2025 14:06:56 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert on ->i_count in iput_final()
Message-ID: <zvd5obgxrkbqeifnuvvvhhjeh7t4cveziipwoii3hjaztxytpa@qlcxp4l2r5jg>
References: <20251001010010.9967-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001010010.9967-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 747B91FB6C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 01-10-25 03:00:10, Mateusz Guzik wrote:
> Notably make sure the count is 0 after the return from ->drop_inode(),
> provided we are going to drop.
> 
> Inspired by suspicious games played by f2fs.

Whoo, those are indeed interesting.

> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> boots on ext4 without splats
> 
>  fs/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index ec9339024ac3..fa82cb810af4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1879,6 +1879,7 @@ static void iput_final(struct inode *inode)
>  	int drop;
>  
>  	WARN_ON(inode->i_state & I_NEW);
> +	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);

This seems pointless given when iput_final() is called...

>  	if (op->drop_inode)
>  		drop = op->drop_inode(inode);
> @@ -1893,6 +1894,12 @@ static void iput_final(struct inode *inode)
>  		return;
>  	}
>  
> +	/*
> +	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
> +	 * Note we only execute this if the verdict was to drop the inode.
> +	 */
> +	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
> +

I'm not sure this can catch much but OK...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

