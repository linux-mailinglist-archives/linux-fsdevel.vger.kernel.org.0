Return-Path: <linux-fsdevel+bounces-46552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE0A8B5B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832B73A9637
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20DA235BE5;
	Wed, 16 Apr 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YZ7myU4Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xZlTVqia";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YZ7myU4Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xZlTVqia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017B22A4FC
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796375; cv=none; b=AAp9H7PV9u5Hj6rW/fj3mgf7pXVYQUBDz8f6uBxZEvJnPIGaVGfnJFxNRcdtiBS9uR+XY05rF609nenaVrWIGUx8tTcy14Wl9nluoFJjGRL6LsXiZTaBM/Y4co/SWF24BRVSJAke5QRb6JsL1VG4jfavwmmt43Ukst3h4dMy6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796375; c=relaxed/simple;
	bh=GrB0HYoTUhjWoDJaTlVLhgeTfueRoSZqNQi+As3DGsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrmKcWAPzaQLX0XOzjcSlI2sK7JXh8ZOZx53P1eXmVkU3Z6SuHqRiQuT594KUXiOcxKYXBY7JJIuIdR1d/DCwyP+zzFsvccbLDfE4PI3j0rOdyiOTPZypy1YlMqtCxJpYzuj5Uwz+5coQI+lJDCFcMqifeGIf4tHBe+67niqBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YZ7myU4Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xZlTVqia; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YZ7myU4Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xZlTVqia; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11EE0211A0;
	Wed, 16 Apr 2025 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gmy4FG3KzpIPRVfXg4Qq7YyPdx3r2noeWmQLQ77iMBQ=;
	b=YZ7myU4YV4ODEYv+tlKzIABVha2ZsVs4+Q5X+GwU0hfDLp7xN8zFfnCyXnAq86q3r5a4uk
	d9Bs7FfQOAgdMF+gd+bDADMfEEKTrqtZ1ih0dA4WnyPD3flUElOhMjJpXj96C3IcGxEfaB
	M8figfLDnbfWel+Y6mnqbkvkyuwF3FU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gmy4FG3KzpIPRVfXg4Qq7YyPdx3r2noeWmQLQ77iMBQ=;
	b=xZlTVqiaUXvk/HWIp1JsgznGJKecZzjw/6OwCJDaWkjcvtx+v9wh+W4UsnK0gkY+n9bmyO
	geNrRAKM3BlUivBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YZ7myU4Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xZlTVqia
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gmy4FG3KzpIPRVfXg4Qq7YyPdx3r2noeWmQLQ77iMBQ=;
	b=YZ7myU4YV4ODEYv+tlKzIABVha2ZsVs4+Q5X+GwU0hfDLp7xN8zFfnCyXnAq86q3r5a4uk
	d9Bs7FfQOAgdMF+gd+bDADMfEEKTrqtZ1ih0dA4WnyPD3flUElOhMjJpXj96C3IcGxEfaB
	M8figfLDnbfWel+Y6mnqbkvkyuwF3FU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gmy4FG3KzpIPRVfXg4Qq7YyPdx3r2noeWmQLQ77iMBQ=;
	b=xZlTVqiaUXvk/HWIp1JsgznGJKecZzjw/6OwCJDaWkjcvtx+v9wh+W4UsnK0gkY+n9bmyO
	geNrRAKM3BlUivBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0821713976;
	Wed, 16 Apr 2025 09:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VYX5AdR6/2dXdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:39:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BEA74A0947; Wed, 16 Apr 2025 11:39:27 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:39:27 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, mcgrof@kernel.org, willy@infradead.org, hare@suse.de, 
	djwong@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 6/7] fs/ext4: use sleeping version of sb_find_get_block()
Message-ID: <dgcfsvjukqu2to3fywej7ultn5dotdll73tw4clwinb4kiz3u3@bfbyfuty62v2>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <20250415231635.83960-7-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-7-dave@stgolabs.net>
X-Rspamd-Queue-Id: 11EE0211A0
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 16:16:34, Davidlohr Bueso wrote:
> Enable ext4_free_blocks() to use it, which has a cond_resched to begin
> with. Convert to the new nonatomic flavor to benefit from potential
> performance benefits and adapt in the future vs migration such that
> semantics are kept.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f88424c28194..1e98c5be4e0a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6642,7 +6642,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  		for (i = 0; i < count; i++) {
>  			cond_resched();
>  			if (is_metadata)
> -				bh = sb_find_get_block(inode->i_sb, block + i);
> +				bh = sb_find_get_block_nonatomic(inode->i_sb,
> +								 block + i);
>  			ext4_forget(handle, is_metadata, inode, bh, block + i);
>  		}
>  	}
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

