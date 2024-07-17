Return-Path: <linux-fsdevel+bounces-23826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979CA933E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AFA1F22912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348A180A95;
	Wed, 17 Jul 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhJoGjtm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ff9a7CoP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hggP5z9+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3dSse0RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9396179A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225283; cv=none; b=CyYQysjW0TJWSicH/UxcefFZMPdrjyO/blvk9LtgYCLM0ZPxU4vWpwacQ/uLvGFdKS6HA9m3FPHPtyptSdRFpWG3GywKTPzrGz0iN/Woy2GIqrgXyoY91uvUBwKJiFs0OJ1N4FmAlvkGJgiyITQk9RgHSZAwOSSPQbo3Nram4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225283; c=relaxed/simple;
	bh=sqlEHnuaFgA3KXYFL0a9xJGyi23qb2JWlG2ZcxboMM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvT0AD7jC21HHlCQwzLvkHx+wF2tc/8Adf7XUUOaAmMj8nkRst0HdRdxwN37g0GaHoRYIMG9S+yRyYxViqxL45QhSJ8XbZfPIZNlMPaZASlLglhKuqRHMtGAmf90IqCYLMZN4THnIaR3h5qizcLvQn7a8n/RwfoEc+UR5evMZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhJoGjtm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ff9a7CoP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hggP5z9+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3dSse0RX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0ED41FB3F;
	Wed, 17 Jul 2024 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721225280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UETz7VJsOwnTS9lDjn2Caudu2CxF14r/st14F+SE00=;
	b=fhJoGjtmfEYUbsNZFtvFreeH3sYHXdMUD0HqN8PAFPIz6LVWIuT3EBu5MClbgu5iGQ7zxi
	nRwBD1Eh3CZ5eJ0MP7RzHUKfwjl1orzd9Lzk6nzUmorZ20eFqSVwP6p83Kd/HAozuYJZCx
	F/pJP2Kz2ceNyXcLPNgj+JHsosOLPws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721225280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UETz7VJsOwnTS9lDjn2Caudu2CxF14r/st14F+SE00=;
	b=Ff9a7CoPodAvT6l0rmavA/x4xVIhY+1CZYhrXwy6s1jbpbLMF2m7P2bbpvPCVu+LXg8iQP
	kiWtJY9bvj3+CvBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hggP5z9+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3dSse0RX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721225279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UETz7VJsOwnTS9lDjn2Caudu2CxF14r/st14F+SE00=;
	b=hggP5z9+LC0wGVilIAPMtK+pTGE1OaTb+tATpmKHaOfSX9Wi4xEpqg6hBRGhxGl91i8g6t
	JtlEG1p6xiLpVOf/p9mZhxWU2+79o53aKVVHkluuRBxE+08Yh4YKKSmMkzEAR/fv0fnvAa
	qzl3oxeuvhpMYjWZ+UuoMCQdomACJo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721225279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UETz7VJsOwnTS9lDjn2Caudu2CxF14r/st14F+SE00=;
	b=3dSse0RXVdTqK3Y2uR0dfU593QMnoUK1fjxCSysdo/1kEM6vPoI15a4o9BXk5YBaSM+cfL
	v9Wic0RM9Z5PDUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2C5A1368F;
	Wed, 17 Jul 2024 14:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xcFjMz/Ql2ahAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 14:07:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8CE06A0987; Wed, 17 Jul 2024 16:07:59 +0200 (CEST)
Date: Wed, 17 Jul 2024 16:07:59 +0200
From: Jan Kara <jack@suse.cz>
To: cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, aris@redhat.com, jack@suse.cz,
	brauner@kernel.org, akpm@linux-foundation.org, hughd@google.com
Subject: Re: [PATCH] shmem_quota: Build the object file conditionally to the
 config option
Message-ID: <20240717140759.7xftvcljzushifre@quack3>
References: <20240717063737.910840-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717063737.910840-1-cem@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: E0ED41FB3F

On Wed 17-07-24 08:37:27, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Initially I added shmem-quota to obj-y, move it to the correct place and
> remove the uneeded full file #ifdef
> 
> Sugested-by: Aristeu Rozanski <aris@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Sure. Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/Makefile      | 3 ++-
>  mm/shmem_quota.c | 3 ---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/Makefile b/mm/Makefile
> index 8fb85acda1b1c..c3cc1f51bc721 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -52,7 +52,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>  			   readahead.o swap.o truncate.o vmscan.o shrinker.o \
>  			   shmem.o util.o mmzone.o vmstat.o backing-dev.o \
>  			   mm_init.o percpu.o slab_common.o \
> -			   compaction.o show_mem.o shmem_quota.o\
> +			   compaction.o show_mem.o \
>  			   interval_tree.o list_lru.o workingset.o \
>  			   debug.o gup.o mmap_lock.o $(mmu-y)
>  
> @@ -139,3 +139,4 @@ obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
>  obj-$(CONFIG_EXECMEM) += execmem.o
> +obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index ce514e700d2f6..d1e32ac01407a 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -34,8 +34,6 @@
>  #include <linux/quotaops.h>
>  #include <linux/quota.h>
>  
> -#ifdef CONFIG_TMPFS_QUOTA
> -
>  /*
>   * The following constants define the amount of time given a user
>   * before the soft limits are treated as hard limits (usually resulting
> @@ -351,4 +349,3 @@ const struct dquot_operations shmem_quota_operations = {
>  	.mark_dirty		= shmem_mark_dquot_dirty,
>  	.get_next_id		= shmem_get_next_id,
>  };
> -#endif /* CONFIG_TMPFS_QUOTA */
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

