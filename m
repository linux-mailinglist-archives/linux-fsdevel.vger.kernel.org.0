Return-Path: <linux-fsdevel+bounces-27602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D54962C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103861F24B82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3D1A38EF;
	Wed, 28 Aug 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eQSIr+9y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McydTb1b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qafg0vVc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D3mwNydd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58913D8B4;
	Wed, 28 Aug 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859069; cv=none; b=GbCtdNBkWg7uVLQbkeZ7X+U/dj7fBJqiLFBUMNb+6kkX7gE74mkccvx72ZhiAJ9Km8gs1nj+ce4fVufXzX5D73ozoVtbLT1hmnF6KEW7XffycisPYbEPtZbqEAQLwCCCwppS2cR+8lZdcBooeycMnx/EFIzB4ZOMef6tiosiCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859069; c=relaxed/simple;
	bh=b+k29GysQ7R3bruZV4HT9pMcZKn6eKuFi5vbwqLjxyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1d5Wb3oSsOGCVqyZN49hMjMv09YoHGkeCuMo6Qs7jRgduELQIiR0YpCJs4Ym2WM0RCWOSeV3jLhXeHBXuv/AL6m+fcks3EEXeENI8T4x7zQbb3EEAbPJxumJns0iDIId6Ro5LBwvBIaWe8vdOtHtTN8v+p8mOCVJo+dEP5fqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eQSIr+9y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McydTb1b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qafg0vVc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D3mwNydd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDE921FC31;
	Wed, 28 Aug 2024 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724859066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GllTruHW3XoQ0H3fzpZDxViaLpqzGacRC6r1YXyznc=;
	b=eQSIr+9yRwKF/L1QWf9YwxWbDj7H4NAbo7ZfMaCMaKJV56uOmXxSSDPJuGyUh1+hgxK+4o
	TXgeAeBTcc80bO6nBkdM3R54PLXU5KSqWICikz+vgvL+d0G63YdVVqmdJSs9eGewNT0Ew+
	95GBsVCJ6SmEkKUHgZOmT2XP2fUEq0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724859066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GllTruHW3XoQ0H3fzpZDxViaLpqzGacRC6r1YXyznc=;
	b=McydTb1bSyyIVr1158BSJOoylK6SPD+pilFZteRTR/Icx0VAlunDKdyDMnUtdNud/v86nA
	MG922/QJIO25hIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qafg0vVc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D3mwNydd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724859065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GllTruHW3XoQ0H3fzpZDxViaLpqzGacRC6r1YXyznc=;
	b=qafg0vVcekSAf7iJlLFNknjS4SejN5uv7eJA8jLdyq3YD31zFgY+Ry5n8k7eLdrMxBO10P
	MwHoLj3olsP+ofnQejgrSTSu2xwvL57kCKhrsDF08y//pcMLBZEhK4V60lnAblzSJ9eNSB
	j7mZcdG3WZb0x72y2wV57KIIObU/9uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724859065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GllTruHW3XoQ0H3fzpZDxViaLpqzGacRC6r1YXyznc=;
	b=D3mwNyddM6osPBA5WP/7nl7dvRAWJ2NQNNb3QnIXJ5KsJ5sX83BjNsy5j/thFrj07NIgKz
	7QgnpAzd4NvmMUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E24DA138D2;
	Wed, 28 Aug 2024 15:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cO83N7lCz2a9UQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 15:31:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78644A0965; Wed, 28 Aug 2024 17:31:05 +0200 (CEST)
Date: Wed, 28 Aug 2024 17:31:05 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/6] ext4: remove tracing for FALLOC_FL_NO_HIDE_STALE
Message-ID: <20240828153105.ccvfoppoljdyowry@quack3>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-3-hch@lst.de>
X-Rspamd-Queue-Id: EDE921FC31
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 27-08-24 08:50:46, Christoph Hellwig wrote:
> FALLOC_FL_NO_HIDE_STALE can't make it past vfs_fallocate (and if the
> flag does what the name implies that's a good thing as it would be
> highly dangerous).  Remove the dead tracing code for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/ext4.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cc5e9b7b2b44e7..156908641e68f1 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -91,7 +91,6 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
>  #define show_falloc_mode(mode) __print_flags(mode, "|",		\
>  	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
>  	{ FALLOC_FL_PUNCH_HOLE,		"PUNCH_HOLE"},		\
> -	{ FALLOC_FL_NO_HIDE_STALE,	"NO_HIDE_STALE"},	\
>  	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
>  	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

