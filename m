Return-Path: <linux-fsdevel+bounces-66479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118EC2071E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D83CD4EF571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75ED24A047;
	Thu, 30 Oct 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UjaNAKl5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQjFMs18";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UjaNAKl5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQjFMs18"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0422688C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832773; cv=none; b=iIxRTcZVJqQWLsYnh36Xq0LmR7+4K+knbzxuO3ehsXTJoPrRXHBNPdaZto3ngs4hADV7yW4DG5ujI98cPV5YbTC6M6K/N2L1+j4X3f1L7zcaNv68iEct5rbNIhscB1gBAYF4rUYZGseBxZ3OCm+320RUFERdF13GEGnnRedjnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832773; c=relaxed/simple;
	bh=hgsiqmDWhHoZHjwGUaEjK7RM5ZAq7jwGVqCm55p9KVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP9zp/yaO+3xT95e29UUmFuCpRlDed8blMmV89qZuGrUuYTXd0lQrr/uCKbYXAw9dM++8c6ybiaRso6Xc2bWcz1hNy+qdPJgwzLFLREkEba/AOwyfkdwrJAeG9KXlrjF4hnNqowXpillNEiR6aO9x/sTbk1RA43ZZgq88NC5ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UjaNAKl5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQjFMs18; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UjaNAKl5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQjFMs18; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDE5C336A1;
	Thu, 30 Oct 2025 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761832769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QnmvYrMdG6h8cX3cV2Qij99AzARsSnQ9fweTyX+DmU=;
	b=UjaNAKl5QPaSg3kDvac7vmNQC3+WezmWWWjAjLZl05mCWKogTOhbc4kkf7wXVZua0zP5Rw
	d0UvZGw9YFLOZd/5IqpT3jDdxY8QKjbC+lBvAmUUUwszQJIcmEzlGYZ9Rf/6i5WIERGD5L
	oLGV9DNPY3SDF63Dn5AY8LSysTEJe2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761832769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QnmvYrMdG6h8cX3cV2Qij99AzARsSnQ9fweTyX+DmU=;
	b=pQjFMs1819YS+Fo5wqn6clcl776TM2uH/iDDJnlrG108SGIhP3CBCbBo06/wwAvMIvFYFa
	3ZtalPH57QanzCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761832769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QnmvYrMdG6h8cX3cV2Qij99AzARsSnQ9fweTyX+DmU=;
	b=UjaNAKl5QPaSg3kDvac7vmNQC3+WezmWWWjAjLZl05mCWKogTOhbc4kkf7wXVZua0zP5Rw
	d0UvZGw9YFLOZd/5IqpT3jDdxY8QKjbC+lBvAmUUUwszQJIcmEzlGYZ9Rf/6i5WIERGD5L
	oLGV9DNPY3SDF63Dn5AY8LSysTEJe2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761832769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QnmvYrMdG6h8cX3cV2Qij99AzARsSnQ9fweTyX+DmU=;
	b=pQjFMs1819YS+Fo5wqn6clcl776TM2uH/iDDJnlrG108SGIhP3CBCbBo06/wwAvMIvFYFa
	3ZtalPH57QanzCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C34D31396A;
	Thu, 30 Oct 2025 13:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 81euL0FvA2nkAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 13:59:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C58CA0AD6; Thu, 30 Oct 2025 14:59:25 +0100 (CET)
Date: Thu, 30 Oct 2025 14:59:25 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in putname()
Message-ID: <tn2kke5jquwjydr4hmi5h2adm4iio53yvsylmohxtebaazwcqy@i74mtkxq233x>
References: <20251029134952.658450-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029134952.658450-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 29-10-25 14:49:52, Mateusz Guzik wrote:
> 1. we already expect the refcount is 1.
> 2. path creation predicts name == iname
> 
> I verified this straightens out the asm, no functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> random annoyance i noticed while profiling
> 
>  fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index ba29ec7b67c5..4692f25e7cd9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -282,7 +282,7 @@ void putname(struct filename *name)
>  		return;
>  
>  	refcnt = atomic_read(&name->refcnt);
> -	if (refcnt != 1) {
> +	if (unlikely(refcnt != 1)) {
>  		if (WARN_ON_ONCE(!refcnt))
>  			return;
>  
> @@ -290,7 +290,7 @@ void putname(struct filename *name)
>  			return;
>  	}
>  
> -	if (name->name != name->iname) {
> +	if (unlikely(name->name != name->iname)) {
>  		__putname(name->name);
>  		kfree(name);
>  	} else
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

