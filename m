Return-Path: <linux-fsdevel+bounces-66477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2C4C206BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AF4466FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FCD1EF39E;
	Thu, 30 Oct 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mu7KNNvM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qxq/awBg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mu7KNNvM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qxq/awBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186512139CE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832479; cv=none; b=FTd2sfKQodVY+XrsJqtHyKDyBg0W7RFQScy58xRy8VxrboqkBAzdHsyMRvl8RD3IX6+ci5WnLALhUdADRaqh8Qz3iEIUIknlqH2+sMIv/RHqc6cMzuIKFljCzWuEOQSkz03eTTLST+A/c8obczgS/kOBBZDpx3joo6FYz5greU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832479; c=relaxed/simple;
	bh=hq9XtVZRzhAVug4Maq8yb9Ti4WS8ZDwShlvYS1b06U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHlkB20jeV+a9aldAKH5vmrYNcIL8vD0anCQo22LUiiLHwRLaYtzh5WUMSoyJaBipldVoGn3rrjUP74doZzqAA95/XRhhKkCPgBD+lk9y2Q+mvZeAQN6mTK9zKZQ+iOfdSUpfyE0tCClyuR+wOziA+BfffoPaxI7ABFeso/mthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mu7KNNvM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qxq/awBg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mu7KNNvM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qxq/awBg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 064112294D;
	Thu, 30 Oct 2025 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761832476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOuE4SYFXNFnOQcZdMaACX07dbTgh+eTHmbkmwNMen8=;
	b=mu7KNNvMfoS1o9Gs0tFVZE2DCCgKHHv2c4t1ARaizi9PCKcCXHnOvgPCsMnopJROvxTnsr
	aw8R+SZMrUc/KwUARX8GMSi5nOp3GMK6TJVUfot125WMsGu6Bn73GuC4P+hzUVNhb62bFI
	wMkKjl9PIBRkrkfMxvi2VDpyo7sYJ5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761832476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOuE4SYFXNFnOQcZdMaACX07dbTgh+eTHmbkmwNMen8=;
	b=qxq/awBgVkP71zq+fqWjXYs9vvRiLwPyJ0pIOoBgYRjIQdebGb/r4I+uHk5DR/4R2dL6KH
	wapAGtIyX5nLmaBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mu7KNNvM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="qxq/awBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761832476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOuE4SYFXNFnOQcZdMaACX07dbTgh+eTHmbkmwNMen8=;
	b=mu7KNNvMfoS1o9Gs0tFVZE2DCCgKHHv2c4t1ARaizi9PCKcCXHnOvgPCsMnopJROvxTnsr
	aw8R+SZMrUc/KwUARX8GMSi5nOp3GMK6TJVUfot125WMsGu6Bn73GuC4P+hzUVNhb62bFI
	wMkKjl9PIBRkrkfMxvi2VDpyo7sYJ5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761832476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOuE4SYFXNFnOQcZdMaACX07dbTgh+eTHmbkmwNMen8=;
	b=qxq/awBgVkP71zq+fqWjXYs9vvRiLwPyJ0pIOoBgYRjIQdebGb/r4I+uHk5DR/4R2dL6KH
	wapAGtIyX5nLmaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F07FE1396A;
	Thu, 30 Oct 2025 13:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U4+xOhtuA2nhfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 13:54:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7F34A0AD6; Thu, 30 Oct 2025 14:54:35 +0100 (CET)
Date: Thu, 30 Oct 2025 14:54:35 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: push list presence check into
 inode_io_list_del()
Message-ID: <pzstmkemz36aecf7ckphbcz3ph55cn6si3ca2nm6sku444365m@pntnbgblgxuf>
References: <20251029131428.654761-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029131428.654761-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 064112294D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Spam-Score: -4.01

On Wed 29-10-25 14:14:27, Mateusz Guzik wrote:
> For consistency with sb routines.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Not sure if you've noticed but inode_io_list_del() is also called from
ext4_evict_inode() (for annoying reasons but that's besides this thread).
So there you have another list_empty() check to deduplicate. Plus ext4
actually uses list_empty_careful() for the unlocked check which kind of
makes sense because in theory these checks could race with someone removing
the inode from writeback lists.

								Honza

> ---
> 
> rebased
> 
>  fs/fs-writeback.c | 3 +++
>  fs/inode.c        | 4 +---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index f784d8b09b04..5dccbe5fb09d 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1349,6 +1349,9 @@ void inode_io_list_del(struct inode *inode)
>  {
>  	struct bdi_writeback *wb;
>  
> +	if (list_empty(&inode->i_io_list))
> +		return;
> +
>  	wb = inode_to_wb_and_lock_list(inode);
>  	spin_lock(&inode->i_lock);
>  
> diff --git a/fs/inode.c b/fs/inode.c
> index 1396f79b2551..b5c2efebaa18 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -815,9 +815,7 @@ static void evict(struct inode *inode)
>  	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
>  	BUG_ON(!list_empty(&inode->i_lru));
>  
> -	if (!list_empty(&inode->i_io_list))
> -		inode_io_list_del(inode);
> -
> +	inode_io_list_del(inode);
>  	inode_sb_list_del(inode);
>  
>  	spin_lock(&inode->i_lock);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

