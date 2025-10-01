Return-Path: <linux-fsdevel+bounces-63166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9AABB03F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 13:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9204A0929
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907452E6122;
	Wed,  1 Oct 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4yDCU+M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mandkC76";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4yDCU+M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mandkC76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FCB2E5437
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319687; cv=none; b=f00ChHLFUFK8lAT/YrnXUSkzDprCTlL1CWadCLWhMitQCZcouyOXgd/G1iioNtaA+82x2W98R7OWYEHwawjqm/STU+gYeBq0V9Ph+tJe04MYXXj5MFZoycavi42sSx6g59baxeWloxF5os6+4A44tV1oZubPzSyH382Kd/AJnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319687; c=relaxed/simple;
	bh=eceOft7iVf1QqLlUjiro4ALjppCYNaBU/yL+srNJpfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnEk0vi3L1Hi5FQjIRf46XWld9VT4ZNcZqsqHY741MxPgf3j7CQmhBPch5EHpufiIIYu+50d7fIgL/Q1LnsYRIhAF8EOA43p+XL2iIZ3KRUiANgsCuDcyDiTi8/nsp9rQuKIsmU6CZuKoJRG0CKuOuuE4Dha7++5eUHh20lXhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4yDCU+M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mandkC76; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4yDCU+M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mandkC76; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC52733740;
	Wed,  1 Oct 2025 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759319682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJUof6DYKG7xkyj5R+cKI6gQiWlfED7Ou7gM8c1BhxA=;
	b=n4yDCU+M8nzod9EOCWUEYuwenqyfrTNQM1Z6qUKjr5tCUh9qO/HUqKzspN9y+68atGhLgk
	1hItkGzeogMfbeWCLfL2cNJkI3sdhgOAy28fsKrpO3mZGr2zAY3yilVEb+7hfMQSFM1Cw0
	BEsrvHmtz7aF06hnVeN2gw+iZNQvdMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759319682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJUof6DYKG7xkyj5R+cKI6gQiWlfED7Ou7gM8c1BhxA=;
	b=mandkC76Ar3qf9stfBKWMyve4gW0uUo0JRXNShc7F0ql5BA9VM9cbQWrtWp/w1LsKiuw2d
	zdSt6Jdr2iQDEqAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n4yDCU+M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mandkC76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759319682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJUof6DYKG7xkyj5R+cKI6gQiWlfED7Ou7gM8c1BhxA=;
	b=n4yDCU+M8nzod9EOCWUEYuwenqyfrTNQM1Z6qUKjr5tCUh9qO/HUqKzspN9y+68atGhLgk
	1hItkGzeogMfbeWCLfL2cNJkI3sdhgOAy28fsKrpO3mZGr2zAY3yilVEb+7hfMQSFM1Cw0
	BEsrvHmtz7aF06hnVeN2gw+iZNQvdMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759319682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJUof6DYKG7xkyj5R+cKI6gQiWlfED7Ou7gM8c1BhxA=;
	b=mandkC76Ar3qf9stfBKWMyve4gW0uUo0JRXNShc7F0ql5BA9VM9cbQWrtWp/w1LsKiuw2d
	zdSt6Jdr2iQDEqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A14BA13A3F;
	Wed,  1 Oct 2025 11:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y09ZJ4IW3WgAcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 11:54:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EA97A0A2D; Wed,  1 Oct 2025 13:54:38 +0200 (CEST)
Date: Wed, 1 Oct 2025 13:54:38 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert ->i_lock held in __iget()
Message-ID: <u3hbbwmmzdk6w4xehqyutp3zd3bfnilgxk7wtpvb55upl7ar5n@upbub3qtjh4p>
References: <20250930235314.88372-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930235314.88372-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AC52733740
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

On Wed 01-10-25 01:53:14, Mateusz Guzik wrote:
> Also remove the now redundant comment.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> verified this booted with ext4 on root, no splats
> 
>  include/linux/fs.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9e9d7c757efe..4c773c4ee7aa 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3368,11 +3368,9 @@ static inline bool is_zero_ino(ino_t ino)
>  	return (u32)ino == 0;
>  }
>  
> -/*
> - * inode->i_lock must be held
> - */
>  static inline void __iget(struct inode *inode)
>  {
> +	lockdep_assert_held(&inode->i_lock);
>  	atomic_inc(&inode->i_count);
>  }
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

