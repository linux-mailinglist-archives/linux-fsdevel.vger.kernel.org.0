Return-Path: <linux-fsdevel+bounces-45156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2946A73A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AF2179F14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F40217F32;
	Thu, 27 Mar 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFzXTpru";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PGyXI5XE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFzXTpru";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PGyXI5XE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33317BB21
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097021; cv=none; b=Na4eFcZaKREkOQLf1aXHJkTSNaktMy+2uIocOlM90EcnFr0Bn1WgC/LA4mc9NaEcdRpXnq8nJvT1IYbjejQeJ2J20asrPCLwd/xTnbzS3r3MxKF6OEqzhriick0LkDbkXzoiX0W8ttPjFGE2Uf4Ht67cWZcCELuNOle5204l7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097021; c=relaxed/simple;
	bh=wqok2mwu39XIR2tx0Czjn0j8wFvDi4FUWHbQvtR8wzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnxWlWPaxyucTylKwHLBhFKfF3Q24OUiEAMrAgKKuRw/Q2qPy3/n2uUUb8kfkqYAluGGJnLu8UNtRgLvdmaXl87YMOZepj/7V0lSdXgB0UepY5eLxsDzwOaCpf4ujtir1iPNou5Gy4Mqf095WSenDcaO+yRXYmJcCoM7Wb6LwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFzXTpru; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PGyXI5XE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFzXTpru; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PGyXI5XE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADE57211A8;
	Thu, 27 Mar 2025 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743097017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSbgfzUhBm/LMOi9frHrBZWTwUZbCrtDB24utmUTl4c=;
	b=LFzXTpruC5oQJ56IvjZx/lQ6zBOrPDWS67KQkm21dVPtkgQ4oDSJGpqOQmwzHaRt/bVD76
	8AOl06sUFp4EZJvumBBdvSGBc53uwfLzfDOKC/SoDv2KPpzHtN1yWcwlx3qrxYwHlEiXuV
	mMZiGzSFMI7+xhe1Uw5ESu4VkBuStOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743097017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSbgfzUhBm/LMOi9frHrBZWTwUZbCrtDB24utmUTl4c=;
	b=PGyXI5XEjUBSDSFm29UO03CcuvmielEaYpSozcrDIjrcWArsujD7GzNsTol9ZFN5IKwP0m
	h3oUeuYBJRHc4wCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LFzXTpru;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PGyXI5XE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743097017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSbgfzUhBm/LMOi9frHrBZWTwUZbCrtDB24utmUTl4c=;
	b=LFzXTpruC5oQJ56IvjZx/lQ6zBOrPDWS67KQkm21dVPtkgQ4oDSJGpqOQmwzHaRt/bVD76
	8AOl06sUFp4EZJvumBBdvSGBc53uwfLzfDOKC/SoDv2KPpzHtN1yWcwlx3qrxYwHlEiXuV
	mMZiGzSFMI7+xhe1Uw5ESu4VkBuStOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743097017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSbgfzUhBm/LMOi9frHrBZWTwUZbCrtDB24utmUTl4c=;
	b=PGyXI5XEjUBSDSFm29UO03CcuvmielEaYpSozcrDIjrcWArsujD7GzNsTol9ZFN5IKwP0m
	h3oUeuYBJRHc4wCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C5FC1376E;
	Thu, 27 Mar 2025 17:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nTLiJbmM5WcBHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Mar 2025 17:36:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4DB69A082A; Thu, 27 Mar 2025 18:36:57 +0100 (CET)
Date: Thu, 27 Mar 2025 18:36:57 +0100
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, jack@suse.cz, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [RFC PATCH 2/4] vfs: make sb_start_write freezable
Message-ID: <slyrgedp776oi4zhzqf4i4re5dwu2v4ubclh7rlopq6mfffve4@lpkqxjz36jcj>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-3-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327140613.25178-3-James.Bottomley@HansenPartnership.com>
X-Rspamd-Queue-Id: ADE57211A8
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 27-03-25 10:06:11, James Bottomley wrote:
> If a write happens on a frozen filesystem, the s_writers.rw_sem gets
> stuck in TASK_UNINTERRUPTIBLE and inhibits suspending or hibernating
> the system.  Since we want to freeze filesystems first then tasks, we
> need this condition not to inhibit suspend/hibernate, which means the
> wait has to have the TASK_FREEZABLE flag as well.  Use the freezable
> version of percpu-rwsem to ensure this.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dd84d1c3b8af..cbbb704eff74 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct super_block *sb, int level)
>  
>  static inline void __sb_start_write(struct super_block *sb, int level)
>  {
> -	percpu_down_read(sb->s_writers.rw_sem + level - 1);
> +	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
> +				   level == SB_FREEZE_WRITE);
>  }
>  
>  static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

