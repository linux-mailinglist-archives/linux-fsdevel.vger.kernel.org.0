Return-Path: <linux-fsdevel+bounces-12580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02979861371
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06012837C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A48E7F46E;
	Fri, 23 Feb 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2E8P1CS+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mrfuW1qE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2E8P1CS+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mrfuW1qE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A476039;
	Fri, 23 Feb 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696748; cv=none; b=aTEYPri1Qm+aXUaL3KrCqU2GYb/NFLWPcm4k1W0XGq8ng0HP0jyfhz+/2Vs9svLH5Ip76mhYq8mlskQA7394aUYVREDWj1JRJR1rJlgXk70jyMe8r8k9O5iN3/u77VZ52vv7gFumlkHvvItHTMk0zkgKtQXstaLnsy1tjRTfbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696748; c=relaxed/simple;
	bh=uSOD4jTUtvh8sor/7J66udolNY1wrJubY0glUQRD1pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfH5Za/FkigV0WxdgXy79EPjqbBXcooBD7lROtbOCQ1yzpWsF61ToIj6OpBqhZOCmG18vVvrcn4i+SxlfA9rEysgEqgexke9xkdX0MSExbOSp8NidEqGFaHzOZq7+WMhnl7xXXMGCkl/vX61OZS6Q44TJqoPZg71OrUNXNTjz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2E8P1CS+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mrfuW1qE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2E8P1CS+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mrfuW1qE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C83381FC0B;
	Fri, 23 Feb 2024 13:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA0sZ6JJc18kHRKhInWcch5SyXuj+GsIXNvAp5t0Yuw=;
	b=2E8P1CS+aFuUOk5ohR4B+AOhEnxvH84ci8ZpAr/GzeTi6cUjSeaIczBTjkvKwU/vmBXJDs
	uKwnRzlkZMeojLRw6IlXgObcDZK5cpbm9lqWyBO9RJQVkaTBERA5iTjc0Y4hmyR5sbFe9H
	oSIgNqKTmBavTCwOzhIkvwHG/bfAe5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA0sZ6JJc18kHRKhInWcch5SyXuj+GsIXNvAp5t0Yuw=;
	b=mrfuW1qEMcKf5erVGxjtZtpxIgX8QHxk7lOXA/dX0hRUl1HFig4Q7YESXVH0UKruR7IrBQ
	H+5tLH507pDZU3DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA0sZ6JJc18kHRKhInWcch5SyXuj+GsIXNvAp5t0Yuw=;
	b=2E8P1CS+aFuUOk5ohR4B+AOhEnxvH84ci8ZpAr/GzeTi6cUjSeaIczBTjkvKwU/vmBXJDs
	uKwnRzlkZMeojLRw6IlXgObcDZK5cpbm9lqWyBO9RJQVkaTBERA5iTjc0Y4hmyR5sbFe9H
	oSIgNqKTmBavTCwOzhIkvwHG/bfAe5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA0sZ6JJc18kHRKhInWcch5SyXuj+GsIXNvAp5t0Yuw=;
	b=mrfuW1qEMcKf5erVGxjtZtpxIgX8QHxk7lOXA/dX0hRUl1HFig4Q7YESXVH0UKruR7IrBQ
	H+5tLH507pDZU3DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE04F13776;
	Fri, 23 Feb 2024 13:59:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MttgLqik2GVhfgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 13:59:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83BDDA07D1; Fri, 23 Feb 2024 14:59:00 +0100 (CET)
Date: Fri, 23 Feb 2024 14:59:00 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] fs/writeback: correct comment of
 __wakeup_flusher_threads_bdi
Message-ID: <20240223135900.cogmgf5zvub3cpm2@quack3>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172024.23625-7-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.81%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Fri 09-02-24 01:20:23, Kemeng Shi wrote:
> Commit e8e8a0c6c9bfc ("writeback: move nr_pages == 0 logic to one
> location") removed parameter nr_pages of __wakeup_flusher_threads_bdi
> and we try to writeback all dirty pages in __wakeup_flusher_threads_bdi
> now. Just correct stale comment.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e8868e814e0a..816505d74b2f 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2345,8 +2345,7 @@ void wb_workfn(struct work_struct *work)
>  }
>  
>  /*
> - * Start writeback of `nr_pages' pages on this bdi. If `nr_pages' is zero,
> - * write back the whole world.
> + * Start writeback of all dirty pages on this bdi.
>   */
>  static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>  					 enum wb_reason reason)
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

