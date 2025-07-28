Return-Path: <linux-fsdevel+bounces-56130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CFB138D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 12:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B89C18925C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B9B254876;
	Mon, 28 Jul 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Pk4jipK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y2EgD9b9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xq8iTNCs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5YSIxWB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7F220F38
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698084; cv=none; b=sah5cWte27WyiAdZSZnkVxQYf9llizfQxfogsNKW2HwqYSbY/xDsWcAy7ZZ6V4vsheH54feNlpZ4LUNRvfxBw/M7IyoVT2ZcVbepX9vPw7rAVYC9eYGqcB8jLZOUwET0EJlyeEM8NUYfhOZBZ0tZh9C7FmERUqlZhZk9DkwUAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698084; c=relaxed/simple;
	bh=2iXxc2X4H+XnyE8Li+VMuh38AZe2PWpUJ34y2E51YQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLypzr0QmLbcEVmmprhSyYSY1/A9O4guJen/W48hwXcioi5USJABSb21qfth7VryU2yqUD+TOlA7sGuNRNgYvNEsy7tm9wkesli9uA8AJIGxVfnEGNvrNL+gWDOcvt/bTNdWg4o3Q/EG3iZNLcmotIz9T3y8q1tmU/770jePyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Pk4jipK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y2EgD9b9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xq8iTNCs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5YSIxWB9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2E681F444;
	Mon, 28 Jul 2025 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753698081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhsArjASlgaDmS6hfZQyB3yR9SRWmH4b6qgJSEDURv4=;
	b=0Pk4jipKkXKgnsuJKi2owCO1LPalrzZ/BdXP7B9udLaHuQEFF3zqos0j/MvNS+lLSz1xr8
	b2OvSP4am9K1tD+WGoMyp+2M82lWtLQmqdcRxyQnojlZiw+7Q9sqCLKmDryLquDxfj7wNF
	AEIE+IrRApCKZpcSH5Vd1RPu5RThIYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753698081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhsArjASlgaDmS6hfZQyB3yR9SRWmH4b6qgJSEDURv4=;
	b=y2EgD9b92LovJM+d93z4tIzHPXe/nVMQG+PdsgkdEOFxppN0oJ1KPEnAmgUUAK3kCQuWVQ
	LwNUv/EE/0s11vCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Xq8iTNCs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5YSIxWB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753698080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhsArjASlgaDmS6hfZQyB3yR9SRWmH4b6qgJSEDURv4=;
	b=Xq8iTNCs45tlp0C3Y6/kbzBLIbBczh6QVU+Ke9dky1mymCSaye9MaYtb264Rhdl4rsZ4Fu
	ADsiSgLFlUu/BRGAWuwvuI5DAg9+gGFNLCK7APDAfK3IYk8ES3lEuv41/UUP1TCJjUMAX9
	xxvAyBcqG9zIXdccMHaFwJJ9CZ0iFok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753698080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhsArjASlgaDmS6hfZQyB3yR9SRWmH4b6qgJSEDURv4=;
	b=5YSIxWB9+ixzFg4bsWkEXImqiQ8h0RXQ7mmSVHQdepGGCOyPmeul8wGTgJTI2LUlvfCdqw
	qlrzzUsPCj4hrHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7645138A5;
	Mon, 28 Jul 2025 10:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvSPNCBPh2igPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Jul 2025 10:21:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9286AA09BE; Mon, 28 Jul 2025 12:21:16 +0200 (CEST)
Date: Mon, 28 Jul 2025 12:21:16 +0200
From: Jan Kara <jack@suse.cz>
To: Jiufei Xue <jiufei.xue@samsung.com>
Cc: tj@kernel.org, jack@suse.cz, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: writeback: fix use-after-free in __mark_inode_dirty()
Message-ID: <d6v3y66k2vqy7sqfgn3fzyrbwnfbfrlhxb2udll4du35drimhs@rsjk27kixujb>
References: <CGME20250728100434epcas5p3995d3444fcec14715c60f73e7a60b1c0@epcas5p3.samsung.com>
 <20250728100715.3863241-1-jiufei.xue@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728100715.3863241-1-jiufei.xue@samsung.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E2E681F444
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
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email,samsung.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Mon 28-07-25 18:07:15, Jiufei Xue wrote:
> An use-after-free issue occurred when __mark_inode_dirty() get the
> bdi_writeback that was in the progress of switching.
> 
> CPU: 1 PID: 562 Comm: systemd-random- Not tainted 6.6.56-gb4403bd46a8e #1
> ......
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __mark_inode_dirty+0x124/0x418
> lr : __mark_inode_dirty+0x118/0x418
> sp : ffffffc08c9dbbc0
> ........
> Call trace:
>  __mark_inode_dirty+0x124/0x418
>  generic_update_time+0x4c/0x60
>  file_modified+0xcc/0xd0
>  ext4_buffered_write_iter+0x58/0x124
>  ext4_file_write_iter+0x54/0x704
>  vfs_write+0x1c0/0x308
>  ksys_write+0x74/0x10c
>  __arm64_sys_write+0x1c/0x28
>  invoke_syscall+0x48/0x114
>  el0_svc_common.constprop.0+0xc0/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x40/0xe4
>  el0t_64_sync_handler+0x120/0x12c
>  el0t_64_sync+0x194/0x198
> 
> Root cause is:
> 
> systemd-random-seed                         kworker
> ----------------------------------------------------------------------
> ___mark_inode_dirty                     inode_switch_wbs_work_fn
> 
>   spin_lock(&inode->i_lock);
>   inode_attach_wb
>   locked_inode_to_wb_and_lock_list
>      get inode->i_wb
>      spin_unlock(&inode->i_lock);
>      spin_lock(&wb->list_lock)
>   spin_lock(&inode->i_lock)
>   inode_io_list_move_locked
>   spin_unlock(&wb->list_lock)
>   spin_unlock(&inode->i_lock)
>                                     spin_lock(&old_wb->list_lock)
>                                       inode_do_switch_wbs
>                                         spin_lock(&inode->i_lock)
>                                         inode->i_wb = new_wb
>                                         spin_unlock(&inode->i_lock)
>                                     spin_unlock(&old_wb->list_lock)
>                                     wb_put_many(old_wb, nr_switched)
>                                       cgwb_release
>                                       old wb released
>   wb_wakeup_delayed() accesses wb,
>   then trigger the use-after-free
>   issue
> 
> Fix this race condition by holding inode spinlock until
> wb_wakeup_delayed() finished.
> 
> Signed-off-by: Jiufei Xue <jiufei.xue@samsung.com>

Looks good! Thanks for the fix. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index cc57367fb..a07b8cf73 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2608,10 +2608,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			wakeup_bdi = inode_io_list_move_locked(inode, wb,
>  							       dirty_list);
>  
> -			spin_unlock(&wb->list_lock);
> -			spin_unlock(&inode->i_lock);
> -			trace_writeback_dirty_inode_enqueue(inode);
> -
>  			/*
>  			 * If this is the first dirty inode for this bdi,
>  			 * we have to wake-up the corresponding bdi thread
> @@ -2621,6 +2617,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			if (wakeup_bdi &&
>  			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
>  				wb_wakeup_delayed(wb);
> +
> +			spin_unlock(&wb->list_lock);
> +			spin_unlock(&inode->i_lock);
> +			trace_writeback_dirty_inode_enqueue(inode);
> +
>  			return;
>  		}
>  	}
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

