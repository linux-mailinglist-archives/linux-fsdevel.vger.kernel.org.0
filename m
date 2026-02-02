Return-Path: <linux-fsdevel+bounces-76039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA+DG9adgGl2/wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:51:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE80CCC7B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5F63037EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35AA19CC0C;
	Mon,  2 Feb 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChbfF7JM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQe29o4g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P3HNkWGI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uhB0mWpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF815C158
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036591; cv=none; b=Yy9mvH7/2vQIBFqvAe0Karc1ayElILxHGAxGb6+UDNE3OIncwmmaQMY/1KgsBUgL6T79+G8OUTAlAkBiawSINvIoQ1YEOcnDi5JRC9noWkUOS3/IgFyw+dtYXCK4qHfDM0ZDp7UG47nMjc1WQkeLdnTwK6uhtTqZNYPzJDphD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036591; c=relaxed/simple;
	bh=njfPVC9EWrWE95jlLfnacv5jiHj74alGP4iNUpJTm5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1m+v1NW+x0ZtDUKsgROvo/NUamiJ6gip43xoItvn1UHIU1emd5qDDuPRfbI0pjfRcQw8Y69OV8wuDd0SEFJXG9VB9owskeiKydQ27dAWTDUsxh05GW5zf2/Es3VMYnKmorCgheODIuOME6Ys4CZQL8uwabDPwbcb4plYPXCprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChbfF7JM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SQe29o4g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P3HNkWGI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uhB0mWpa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 084D45BD7C;
	Mon,  2 Feb 2026 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770036588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N81KfpjkmnwmQRvA7/KYwcynY2C1L9x0XdthuH/NpFM=;
	b=ChbfF7JMQ5Q/DY1zq4hhCQDD147gL31Y5rZXzM5YpOhCTJQv7M/iv3U4BStGshP6kF97e2
	gh6jlsG3iOvkoAnqntwDlctDQ39HscVH+WOFznplLYwOndfToYnn8pBWM7ZJtQsjX88f3S
	YIgjz/5n3+DR1bnpikjsiLGKDQmpJxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770036588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N81KfpjkmnwmQRvA7/KYwcynY2C1L9x0XdthuH/NpFM=;
	b=SQe29o4g24agjCsfeBzC+qWvmCblT/jRKNv52rboclk6HtUN5Is8+QAnbxRK8lSWRXKOqK
	vpEhDotyb+E6SSCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P3HNkWGI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uhB0mWpa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770036587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N81KfpjkmnwmQRvA7/KYwcynY2C1L9x0XdthuH/NpFM=;
	b=P3HNkWGIJqB46ft+ATJ2afueK8k0Kav3UEw3ImT5O1SMNlG3bBrqsF0RQOeVsMF9JSEnJN
	P8uBMTaggg5q+MDC/k+q0RPq8LZyMsnUpk7wj4z/3puMYC72s8pzYryugK8lMJ1umJGOkP
	ceNuy7dxVTKq16zUYOsUYUdxX4OqaFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770036587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N81KfpjkmnwmQRvA7/KYwcynY2C1L9x0XdthuH/NpFM=;
	b=uhB0mWpaEpEupmwJ3K3jEClOX+NphOm03P25lQngTEGuZD1Hf7KWNgD8+Zd/fLvoUQtdQm
	i17ROlPN5TO5OcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7DAF3EA62;
	Mon,  2 Feb 2026 12:49:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hAKWOGqdgGnjOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 12:49:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6A00A08F8; Mon,  2 Feb 2026 13:49:42 +0100 (CET)
Date: Mon, 2 Feb 2026 13:49:42 +0100
From: Jan Kara <jack@suse.cz>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Julian Sun <sunjunchao@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: Fix wakeup and logging timeouts for
 !DETECT_HUNG_TASK
Message-ID: <pdivemgl5d3mqrb5erbzn2qgohcktxv76lkqqjhc65cgomnysf@tgopkp5jaonj>
References: <20260131090724.4128443-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131090724.4128443-1-chenhuacai@loongson.cn>
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
	TAGGED_FROM(0.00)[bounces-76039-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email];
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
X-Rspamd-Queue-Id: BE80CCC7B7
X-Rspamd-Action: no action

On Sat 31-01-26 17:07:24, Huacai Chen wrote:
> Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
> is not enabled:
> 
> INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.
> 
> The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
> is not enabled, then it causes the warning message even if the writeback
> lasts for only one second.
> 
> I believe the wakeup and logging is also useful for !DETECT_HUNG_TASK,
> so I don't want to disable them completely. As DEFAULT_HUNG_TASK_TIMEOUT
> is 120 seconds, so for the !DETECT_HUNG_TASK case let's use 120 seconds
> instead of sysctl_hung_task_timeout_secs.
> 
> Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
> Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Thanks for the patch! I think if !CONFIG_DETECT_HUNG_TASK, we should just
not print the message from wb_wait_for_completion_cb() as well. After all
it's also a type of hung task detection and user explicitely disabled that.
Also there would be no way to tune the timeout so there are high chances
120s will be too much for somebody and too few for somebody else...

> +#ifndef CONFIG_DETECT_HUNG_TASK
> +	unsigned long hung_secs = 120;
> +#else
> +	unsigned long hung_secs = sysctl_hung_task_timeout_secs;
> +#endif
>  
>  	if (work->for_kupdate)
>  		dirtied_before = jiffies -
> @@ -2031,8 +2041,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  
>  		/* Report progress to inform the hung task detector of the progress. */
>  		if (work->done && work->done->progress_stamp &&
> -		   (jiffies - work->done->progress_stamp) > HZ *
> -		   sysctl_hung_task_timeout_secs / 2)
> +		   (jiffies - work->done->progress_stamp) > HZ * hung_secs / 2)
>  			wake_up_all(work->done->waitq);
>  
>  		wbc_detach_inode(&wbc);

Similarly here I'd just #ifdef out the wakeup when !CONFIG_DETECT_HUNG_TASK.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

