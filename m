Return-Path: <linux-fsdevel+bounces-8312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9872D832C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 16:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AF81C23F3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A854BC5;
	Fri, 19 Jan 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWM6ElDs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dNXizWJn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWM6ElDs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dNXizWJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697A853810;
	Fri, 19 Jan 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678025; cv=none; b=TJ/uj0NjPTg1qNQZGy4x6Oyps4vR7wpuWl3Ozn7gzm5Qwptp+CtgvjQat4tM4t3X2Wn9L8F4FKbUHPALNlVHRHPlVMh09zH/8zaDv+gUSciVdqL6Eu1aelVr+kQyEhmoXsC5vL0XPOHopGSnA0KCS3hL1gxEVLuH2PNUFSmzYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678025; c=relaxed/simple;
	bh=19rSRL58dOC4OZ9Gg2gm/OwItV5wyPowOqlclDsjcp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey6sB3WtBhW4PRq5hJFlNEhdT4CJX1oaeOzdlqoniOdc/feBUBO1P66arTMjj91H11NDyqv409hmu29a/Ode6KLbd8g/kHDhtwymUBz0DkznlvzYPSYuCnnhSALPUBW7BTyc99gtPbTeSFxE8tW9HE+BGdvVk4yhXa5NfpXgcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nWM6ElDs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dNXizWJn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nWM6ElDs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dNXizWJn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 546DF1F7F9;
	Fri, 19 Jan 2024 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705678020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxcPS0/G6HHJ5b5iYVi8rX0C+ZxopTM5emRTtqK5mEc=;
	b=nWM6ElDsO70gVDzIpw/X5OmojQFWVg/b/CD497QQi7snPAYNYzEHuJ7rHYQtoiNDT59S/A
	a/Pqa7Dr7xQkI/kI5ceavl0ALoQFu1u/LQz3V1mj0NcKi/KykjlIwAlGiOiawov4LB579z
	8em9bFDW9httwADNp3xaJAm3RGRtQLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705678020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxcPS0/G6HHJ5b5iYVi8rX0C+ZxopTM5emRTtqK5mEc=;
	b=dNXizWJnimFWh8EDbrLRiAzjUlrUXxZgfydlBxFe+TvWNgZaIPQfZnWGNRwtkHykTdLfSy
	LQ1glfjwFfUmSsAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705678020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxcPS0/G6HHJ5b5iYVi8rX0C+ZxopTM5emRTtqK5mEc=;
	b=nWM6ElDsO70gVDzIpw/X5OmojQFWVg/b/CD497QQi7snPAYNYzEHuJ7rHYQtoiNDT59S/A
	a/Pqa7Dr7xQkI/kI5ceavl0ALoQFu1u/LQz3V1mj0NcKi/KykjlIwAlGiOiawov4LB579z
	8em9bFDW9httwADNp3xaJAm3RGRtQLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705678020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxcPS0/G6HHJ5b5iYVi8rX0C+ZxopTM5emRTtqK5mEc=;
	b=dNXizWJnimFWh8EDbrLRiAzjUlrUXxZgfydlBxFe+TvWNgZaIPQfZnWGNRwtkHykTdLfSy
	LQ1glfjwFfUmSsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49B831388C;
	Fri, 19 Jan 2024 15:27:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5N/2EcSUqmUxRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Jan 2024 15:27:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DB033A0803; Fri, 19 Jan 2024 16:26:59 +0100 (CET)
Date: Fri, 19 Jan 2024 16:26:59 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	akpm@linux-foundation.org, tj@kernel.org, xiujianfeng@huawei.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] writeback: move wb_wakeup_delayed defination to
 fs-writeback.c
Message-ID: <20240119152659.fvfk2axsd2pwhebk@quack3>
References: <20240118203339.764093-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118203339.764093-1-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nWM6ElDs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dNXizWJn
X-Spamd-Result: default: False [5.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_SPAM(5.10)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 5.29
X-Rspamd-Queue-Id: 546DF1F7F9
X-Spam-Level: *****
X-Spam-Flag: NO
X-Spamd-Bar: +++++

On Fri 19-01-24 04:33:39, Kemeng Shi wrote:
> The wb_wakeup_delayed is only used in fs-writeback.c. Move it to
> fs-writeback.c after defination of wb_wakeup and make it static.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Yeah, not sure why it was left there. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c           | 25 +++++++++++++++++++++++++
>  include/linux/backing-dev.h |  1 -
>  mm/backing-dev.c            | 25 -------------------------
>  3 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 1767493dffda..5ab1aaf805f7 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -141,6 +141,31 @@ static void wb_wakeup(struct bdi_writeback *wb)
>  	spin_unlock_irq(&wb->work_lock);
>  }
>  
> +/*
> + * This function is used when the first inode for this wb is marked dirty. It
> + * wakes-up the corresponding bdi thread which should then take care of the
> + * periodic background write-out of dirty inodes. Since the write-out would
> + * starts only 'dirty_writeback_interval' centisecs from now anyway, we just
> + * set up a timer which wakes the bdi thread up later.
> + *
> + * Note, we wouldn't bother setting up the timer, but this function is on the
> + * fast-path (used by '__mark_inode_dirty()'), so we save few context switches
> + * by delaying the wake-up.
> + *
> + * We have to be careful not to postpone flush work if it is scheduled for
> + * earlier. Thus we use queue_delayed_work().
> + */
> +static void wb_wakeup_delayed(struct bdi_writeback *wb)
> +{
> +	unsigned long timeout;
> +
> +	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
> +	spin_lock_irq(&wb->work_lock);
> +	if (test_bit(WB_registered, &wb->state))
> +		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
> +	spin_unlock_irq(&wb->work_lock);
> +}
> +
>  static void finish_writeback_work(struct bdi_writeback *wb,
>  				  struct wb_writeback_work *work)
>  {
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 1a97277f99b1..8e7af9a03b41 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -38,7 +38,6 @@ struct backing_dev_info *bdi_alloc(int node_id);
>  
>  void wb_start_background_writeback(struct bdi_writeback *wb);
>  void wb_workfn(struct work_struct *work);
> -void wb_wakeup_delayed(struct bdi_writeback *wb);
>  
>  void wb_wait_for_completion(struct wb_completion *done);
>  
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 1e3447bccdb1..039dc74b505a 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -372,31 +372,6 @@ static int __init default_bdi_init(void)
>  }
>  subsys_initcall(default_bdi_init);
>  
> -/*
> - * This function is used when the first inode for this wb is marked dirty. It
> - * wakes-up the corresponding bdi thread which should then take care of the
> - * periodic background write-out of dirty inodes. Since the write-out would
> - * starts only 'dirty_writeback_interval' centisecs from now anyway, we just
> - * set up a timer which wakes the bdi thread up later.
> - *
> - * Note, we wouldn't bother setting up the timer, but this function is on the
> - * fast-path (used by '__mark_inode_dirty()'), so we save few context switches
> - * by delaying the wake-up.
> - *
> - * We have to be careful not to postpone flush work if it is scheduled for
> - * earlier. Thus we use queue_delayed_work().
> - */
> -void wb_wakeup_delayed(struct bdi_writeback *wb)
> -{
> -	unsigned long timeout;
> -
> -	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
> -	spin_lock_irq(&wb->work_lock);
> -	if (test_bit(WB_registered, &wb->state))
> -		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
> -	spin_unlock_irq(&wb->work_lock);
> -}
> -
>  static void wb_update_bandwidth_workfn(struct work_struct *work)
>  {
>  	struct bdi_writeback *wb = container_of(to_delayed_work(work),
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

