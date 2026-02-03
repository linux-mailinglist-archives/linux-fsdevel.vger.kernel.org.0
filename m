Return-Path: <linux-fsdevel+bounces-76171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBV/Cwi8gWm7JAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:12:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B323D6A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF615304EAB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342D396B78;
	Tue,  3 Feb 2026 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j7ocEFwY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KV3rmFu4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j7ocEFwY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KV3rmFu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5E274B59
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109727; cv=none; b=os1dcjJSWuRgliCazA+OhiZualYxz0UYnTWT4C4oELOmlOIGanoGMm/YPescG2lYabZqS49LL0+Iin5U0yfczu7rqJI4ruYHGHH9ZIj7yIoTqRQPbr8c03cK77SNsX6RGTh4164jJ86+xx4gsVCNiWCpzdRoMcFwaDi0akJAgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109727; c=relaxed/simple;
	bh=E4o9NAvqcbzreQ1hTZgO2bamh3vjO6MrDkCHcXOc0E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F95IvFi3K7hDoiZr7pYnl58gFWqvQvQJcp6eRJzB7HBgsw4RpKk66Oie3wnj4OAA5hYoEi01/tl7i2HZP2n4UhjeGGMJ0B8xPCH6Z0Q+jpwjCRQ17n+fRgU6mh/060n29Pv4d7VqXbgrezJ1P0B37b4WjZ3FHpqMs9Xit3gAIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j7ocEFwY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KV3rmFu4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j7ocEFwY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KV3rmFu4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E3A23E6C3;
	Tue,  3 Feb 2026 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770109724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmVZ9Lpw6IixINYro1d3rpl2ieWDNrG5Zm+wuPf685k=;
	b=j7ocEFwY1nbBediHnXd5B+fpL5S5uxG7BrDdOcosSr7o1mPPtP0X02BXL6hzFeWACnpEIU
	gYvlgBRyxaubW+FxcUWhNJqn8/AUCr1MS1i+Oyft/3lsmfGQzr7EVZ8n0+KivbKc+IzQPL
	wNPRbnqxP7wgqHIWJLg5GeWDDSGsuVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770109724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmVZ9Lpw6IixINYro1d3rpl2ieWDNrG5Zm+wuPf685k=;
	b=KV3rmFu4Ln/ad5BV0QfUGyA7Su5s2/iMxQX38DoXziT5kVa7LqCiYqzmjZ6pnZH0HkTCSz
	GtFcdvbfvKiaSHBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j7ocEFwY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KV3rmFu4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770109724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmVZ9Lpw6IixINYro1d3rpl2ieWDNrG5Zm+wuPf685k=;
	b=j7ocEFwY1nbBediHnXd5B+fpL5S5uxG7BrDdOcosSr7o1mPPtP0X02BXL6hzFeWACnpEIU
	gYvlgBRyxaubW+FxcUWhNJqn8/AUCr1MS1i+Oyft/3lsmfGQzr7EVZ8n0+KivbKc+IzQPL
	wNPRbnqxP7wgqHIWJLg5GeWDDSGsuVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770109724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmVZ9Lpw6IixINYro1d3rpl2ieWDNrG5Zm+wuPf685k=;
	b=KV3rmFu4Ln/ad5BV0QfUGyA7Su5s2/iMxQX38DoXziT5kVa7LqCiYqzmjZ6pnZH0HkTCSz
	GtFcdvbfvKiaSHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDDFC3EA62;
	Tue,  3 Feb 2026 09:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f0UEOhu7gWkSfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Feb 2026 09:08:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1D76A08F8; Tue,  3 Feb 2026 10:08:43 +0100 (CET)
Date: Tue, 3 Feb 2026 10:08:43 +0100
From: Jan Kara <jack@suse.cz>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Julian Sun <sunjunchao@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] writeback: Fix wakeup and logging timeouts for
 !DETECT_HUNG_TASK
Message-ID: <zyla6hpdipy42mohwluccjda6msrykavxofcfeuf3rigoq24t5@72kmw2rza4fs>
References: <20260203063023.2159073-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203063023.2159073-1-chenhuacai@loongson.cn>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76171-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,loongson.cn:email];
	DMARC_NA(0.00)[suse.cz];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B323D6A23
X-Rspamd-Action: no action

On Tue 03-02-26 14:30:23, Huacai Chen wrote:
> Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
> is not enabled:
> 
> INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.
> 
> The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
> is not enabled, then it causes the warning message even if the writeback
> lasts for only one second.
> 
> So guard the wakeup and logging with "#ifdef CONFIG_DETECT_HUNG_TASK",
> so as to eliminate the warning messages.
> 
> Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
> Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Thanks! Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V2: Disable wakeup and logging for !DETECT_HUNG_TASK.
> 
>  fs/fs-writeback.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 5444fc706ac7..bfe469fff97c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -198,13 +198,15 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  
>  static bool wb_wait_for_completion_cb(struct wb_completion *done)
>  {
> +#ifdef CONFIG_DETECT_HUNG_TASK
>  	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
>  
> -	done->progress_stamp = jiffies;
>  	if (waited_secs > sysctl_hung_task_timeout_secs)
>  		pr_info("INFO: The task %s:%d has been waiting for writeback "
>  			"completion for more than %lu seconds.",
>  			current->comm, current->pid, waited_secs);
> +#endif
> +	done->progress_stamp = jiffies;
>  
>  	return !atomic_read(&done->cnt);
>  }
> @@ -2029,11 +2031,13 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 */
>  		__writeback_single_inode(inode, &wbc);
>  
> +#ifdef CONFIG_DETECT_HUNG_TASK
>  		/* Report progress to inform the hung task detector of the progress. */
>  		if (work->done && work->done->progress_stamp &&
>  		   (jiffies - work->done->progress_stamp) > HZ *
>  		   sysctl_hung_task_timeout_secs / 2)
>  			wake_up_all(work->done->waitq);
> +#endif
>  
>  		wbc_detach_inode(&wbc);
>  		work->nr_pages -= write_chunk - wbc.nr_to_write;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

