Return-Path: <linux-fsdevel+bounces-49571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF676ABF153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD217EB33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E425B67E;
	Wed, 21 May 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChPHYc9R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6OUEUHnu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChPHYc9R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6OUEUHnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376EB23BCEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822689; cv=none; b=jJs5hE0AI15Qdw3c4lrKnL24HuA0sCsh+qtgWNm06GjCje1wVTJyAOZ2IBl9Sj50QqHuDfwuabIATDeZmO1uDSMEP8zBY5lyJECDeOKNisH0qaHh5bqH9+MPtSz8HQbdGSqG/KByyLcSr/7VIVqDyrhfH8C+XAIDxmJR0R93Tb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822689; c=relaxed/simple;
	bh=gyP7T2gYNDzUnBvgtchq1IV0P0eLd31su3RI2zfImUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f90/7T/YEBX6mtMpC4QZqp4AAvkFJNRf0amylg/0WulkXU9IoeSTHBRvs9nIFgxszXRcpyHVWqY/LihvEL4ob/At5CbfsWhODJRI29MI8vbY8serFEBfKPIMUBxxFfU2SjzPZgwkVBdLoF+s7K9gD9TkTOlzXxdYCwCsELznowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChPHYc9R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6OUEUHnu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChPHYc9R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6OUEUHnu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92DCE2091D;
	Wed, 21 May 2025 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747822686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zb+gy3OnOeAJiXOJUGuELVv/ERPmXTwFKGQaPp2GxE=;
	b=ChPHYc9RCAMiBpEJw5PHulyviwNxqbn9Evc8tws245w2c9c1lLq8PDyEKxLS8HUBv76HO9
	H2IFqiUVhwUawwKsBfYiqSj7vQ3bNOrX65A4j5SYPm6i3ai/jyG5uowJVXrFso+56wNdi4
	uq1x8dv1+2vKPJ5i385m/68PrgpXfH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747822686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zb+gy3OnOeAJiXOJUGuELVv/ERPmXTwFKGQaPp2GxE=;
	b=6OUEUHnuKx8dQIySzKT/WbfyrzBiWOz4Fo/KJXQF+3zEwqpTadZ79Do4AahbffNQchb6so
	+uY2xxWW4jvdigDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747822686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zb+gy3OnOeAJiXOJUGuELVv/ERPmXTwFKGQaPp2GxE=;
	b=ChPHYc9RCAMiBpEJw5PHulyviwNxqbn9Evc8tws245w2c9c1lLq8PDyEKxLS8HUBv76HO9
	H2IFqiUVhwUawwKsBfYiqSj7vQ3bNOrX65A4j5SYPm6i3ai/jyG5uowJVXrFso+56wNdi4
	uq1x8dv1+2vKPJ5i385m/68PrgpXfH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747822686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zb+gy3OnOeAJiXOJUGuELVv/ERPmXTwFKGQaPp2GxE=;
	b=6OUEUHnuKx8dQIySzKT/WbfyrzBiWOz4Fo/KJXQF+3zEwqpTadZ79Do4AahbffNQchb6so
	+uY2xxWW4jvdigDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8994013AA0;
	Wed, 21 May 2025 10:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VgmMIV6oLWilTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 May 2025 10:18:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3FB5BA09DE; Wed, 21 May 2025 12:18:06 +0200 (CEST)
Date: Wed, 21 May 2025 12:18:06 +0200
From: Jan Kara <jack@suse.cz>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520123544.4087208-1-senozhatsky@chromium.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 20-05-25 21:35:12, Sergey Senozhatsky wrote:
> Once reply response is set for all outstanding requests
> wake_up_all() of the ->access_waitq waiters so that they
> can finish user-wait.  Otherwise fsnotify_destroy_group()
> can wait forever for ->user_waits to reach 0 (which it
> never will.)
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

We don't use exclusive waits with access_waitq so wake_up() and
wake_up_all() should do the same thing?

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 87f861e9004f..95a3b843cbbf 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1046,8 +1046,8 @@ static int fanotify_release(struct inode *ignored, struct file *file)
>  	}
>  	spin_unlock(&group->notification_lock);
>  
> -	/* Response for all permission events it set, wakeup waiters */
> -	wake_up(&group->fanotify_data.access_waitq);
> +	/* Response for all permission events is set, wakeup waiters */
> +	wake_up_all(&group->fanotify_data.access_waitq);
>  
>  	/* matches the fanotify_init->fsnotify_alloc_group */
>  	fsnotify_destroy_group(group);
> -- 
> 2.49.0.1101.gccaa498523-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

