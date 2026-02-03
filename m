Return-Path: <linux-fsdevel+bounces-76178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP5eMWDJgWl1JwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:09:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B57D752E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BED31044E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6C39B4B8;
	Tue,  3 Feb 2026 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z58yJIjH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Izic+9LA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z58yJIjH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Izic+9LA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C539A806
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113198; cv=none; b=EAS3U/EkEIsItFC9T43hhCMLgh7CEjHGrQBoYxDSvN4qJS192anBz8nyTfYjNB/SNWI5UTWCIS1Bv1zLYLnMc+zfDQM/LrTzBbVaxh3JG5AlSevT77WoCwHRlNATbq59rvpqgIUwFzZkuHIgoqKVqrNN2d315LUG4Hd0dk5I53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113198; c=relaxed/simple;
	bh=qko5dkbX2GXaEXjHFVpPa08FRgE0Twm/N34KbffY/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyaW1V5gVtYZSXbSr1zYAA0Sgvs2B96wLdioTZ6i1GrorcHiZbRAkIW9vqjpPQrZQDxVNdvdJl3+cxg/JJL/+hAyC9KcLCvcfDTk79mvNBkXuLvCIh9asKsAWiIsfluFp3B2uXvSStsrlXTOf3WLRS4dC6rgmt4/oaER5PO8rXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z58yJIjH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Izic+9LA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z58yJIjH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Izic+9LA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47B4C5BCC3;
	Tue,  3 Feb 2026 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770113195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UhxYxeqp3CHMbamo8VRZgWr4tJdHiWs6YnWj50kjD28=;
	b=z58yJIjHtkzj98l0Bhnk7b0cKmawGVYjeSKJextXE7qyLVSzB2HLqQPj3YgDzEoaPlPX8L
	p6u6Ie8ot6tNGw7ECIq7u53xsNyavRHWtkhckZr8tcCZG0/4QxgdNtmktKl7x1LiUPYsMR
	UbJyUn9gqWp9xcu2v/djbFiRPH2j0Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770113195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UhxYxeqp3CHMbamo8VRZgWr4tJdHiWs6YnWj50kjD28=;
	b=Izic+9LAHAh7hG9Lq3sm5l/MvVl1dvLsq0aRkU2Tn00BUVxLGk0Ccm4XsUj1yB9R923m1z
	XXfxBfR9t3kLYnBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z58yJIjH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Izic+9LA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770113195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UhxYxeqp3CHMbamo8VRZgWr4tJdHiWs6YnWj50kjD28=;
	b=z58yJIjHtkzj98l0Bhnk7b0cKmawGVYjeSKJextXE7qyLVSzB2HLqQPj3YgDzEoaPlPX8L
	p6u6Ie8ot6tNGw7ECIq7u53xsNyavRHWtkhckZr8tcCZG0/4QxgdNtmktKl7x1LiUPYsMR
	UbJyUn9gqWp9xcu2v/djbFiRPH2j0Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770113195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UhxYxeqp3CHMbamo8VRZgWr4tJdHiWs6YnWj50kjD28=;
	b=Izic+9LAHAh7hG9Lq3sm5l/MvVl1dvLsq0aRkU2Tn00BUVxLGk0Ccm4XsUj1yB9R923m1z
	XXfxBfR9t3kLYnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3451B3EA62;
	Tue,  3 Feb 2026 10:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id daW/DKvIgWmkKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Feb 2026 10:06:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9A03A08F8; Tue,  3 Feb 2026 11:06:30 +0100 (CET)
Date: Tue, 3 Feb 2026 11:06:30 +0100
From: Jan Kara <jack@suse.cz>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Julian Sun <sunjunchao@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] writeback: Fix wakeup and logging timeouts for
 !DETECT_HUNG_TASK
Message-ID: <paqvsxwf3v5hi7gwylfez4yddlswsem27hzqy37mxuapn7dxss@5vefpyohwlba>
References: <20260203094014.2273240-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203094014.2273240-1-chenhuacai@loongson.cn>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76178-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,loongson.cn:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 50B57D752E
X-Rspamd-Action: no action

On Tue 03-02-26 17:40:14, Huacai Chen wrote:
> Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
> is not enabled:
> 
> INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.
> 
> The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
> is not enabled, then it causes the warning message even if the writeback
> lasts for only one second.
> 
> Guard the wakeup and logging with "#ifdef CONFIG_DETECT_HUNG_TASK" can
> eliminate the warning messages. But on the other hand, it is possible
> that sysctl_hung_task_timeout_secs be also 0 when DETECT_HUNG_TASK is
> enabled. So let's just check the value of sysctl_hung_task_timeout_secs
> to decide whether do wakeup and logging.
> 
> Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
> Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
> V2: Disable wakeup and logging for !DETECT_HUNG_TASK.
> V3: Also handle the case for DETECT_HUNG_TASK if sysctl_hung_task_timeout_secs is 0.

Good catch!

								Honza

> 
>  fs/fs-writeback.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 5444fc706ac7..79b02ac66ac6 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -198,10 +198,11 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  
>  static bool wb_wait_for_completion_cb(struct wb_completion *done)
>  {
> +	unsigned long timeout = sysctl_hung_task_timeout_secs;
>  	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
>  
>  	done->progress_stamp = jiffies;
> -	if (waited_secs > sysctl_hung_task_timeout_secs)
> +	if (timeout && (waited_secs > timeout))
>  		pr_info("INFO: The task %s:%d has been waiting for writeback "
>  			"completion for more than %lu seconds.",
>  			current->comm, current->pid, waited_secs);
> @@ -1944,6 +1945,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		.range_end		= LLONG_MAX,
>  	};
>  	unsigned long start_time = jiffies;
> +	unsigned long timeout = sysctl_hung_task_timeout_secs;
>  	long write_chunk;
>  	long total_wrote = 0;  /* count both pages and inodes */
>  	unsigned long dirtied_before = jiffies;
> @@ -2030,9 +2032,8 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		__writeback_single_inode(inode, &wbc);
>  
>  		/* Report progress to inform the hung task detector of the progress. */
> -		if (work->done && work->done->progress_stamp &&
> -		   (jiffies - work->done->progress_stamp) > HZ *
> -		   sysctl_hung_task_timeout_secs / 2)
> +		if (work->done && work->done->progress_stamp && timeout &&
> +		   (jiffies - work->done->progress_stamp) > HZ * timeout / 2)
>  			wake_up_all(work->done->waitq);
>  
>  		wbc_detach_inode(&wbc);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

