Return-Path: <linux-fsdevel+bounces-63037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F226DBA9DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4621742117E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBDB30C617;
	Mon, 29 Sep 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wbJcHrun";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThOxv94r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wbJcHrun";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThOxv94r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367230C111
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161059; cv=none; b=WUT4+U3GZqTNUEyDIryspfn5zq/0Ise/QIFktWGyQdu06BjX1OAMZNWYKycxtVbs6WwoHiy4RB1qqXgF4JpX4amU122emiIs91r8vepKJs6nm+h4AzU39tIR0/w5e+I/ZPvDC97hlAjYIqV2WV+7YUqORoSIaYA1DXW+QNRJ9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161059; c=relaxed/simple;
	bh=au2dm5NwRXaVkU46penzNrr4ULAUqI/WSbBeU4sYwx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9PWcme3DuNhw5pqTMYB9uqs1/hD1FW7P6qjH6uFHny46KKRKBRM0DcWtJWyJnSmD2f2RBS1iOEpmhVJV5Bo9qNwnXH2eq5ZvjhEdjSfVkkgB3v9Dd6Z6jZOTqN6M+8WRmcsCrIqYDPhi+5ZPLBNQMOvvZ56i4gXx6EmbF0XeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wbJcHrun; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThOxv94r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wbJcHrun; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThOxv94r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 530CF33822;
	Mon, 29 Sep 2025 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759161054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYsWua7S03YKA+jRl3wdZkd5URkxSCLwGuFh9T2+Qss=;
	b=wbJcHrunGzgVBwu/3MerFM20LDEiEe6r4oC1Xp+aXPOg4XYU9FaOr+CUx6pWh/ZZ9EUsgG
	wXB9sNS+so7HP8WNucAIBqKGXrzFkUkBH+iNPl0u8zyzEDff+EuEAz3FGbfySRoqIGuqtn
	8ZLieod9mvYu5OcaLtJ/D5SP5O6KbQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759161054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYsWua7S03YKA+jRl3wdZkd5URkxSCLwGuFh9T2+Qss=;
	b=ThOxv94rH28QsfNhCDElAt/WM70LNA36ORCQcgM6zGocavowgFgKpk05RLrH4zEVFr9js8
	mbbB8t2oZuO/jWAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wbJcHrun;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ThOxv94r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759161054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYsWua7S03YKA+jRl3wdZkd5URkxSCLwGuFh9T2+Qss=;
	b=wbJcHrunGzgVBwu/3MerFM20LDEiEe6r4oC1Xp+aXPOg4XYU9FaOr+CUx6pWh/ZZ9EUsgG
	wXB9sNS+so7HP8WNucAIBqKGXrzFkUkBH+iNPl0u8zyzEDff+EuEAz3FGbfySRoqIGuqtn
	8ZLieod9mvYu5OcaLtJ/D5SP5O6KbQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759161054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYsWua7S03YKA+jRl3wdZkd5URkxSCLwGuFh9T2+Qss=;
	b=ThOxv94rH28QsfNhCDElAt/WM70LNA36ORCQcgM6zGocavowgFgKpk05RLrH4zEVFr9js8
	mbbB8t2oZuO/jWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35AE713A21;
	Mon, 29 Sep 2025 15:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ckRDd6q2mgRTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Sep 2025 15:50:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C046A0ACB; Mon, 29 Sep 2025 17:50:45 +0200 (CEST)
Date: Mon, 29 Sep 2025 17:50:45 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com
Subject: Re: [PATCH v2 2/2] writeback: Add logging for slow writeback
 (exceeds sysctl_hung_task_timeout_secs)
Message-ID: <ehjjehcopkhidopj676n5hl2etdsl6lxdhgzhsz2f3rgfaxtwd@cqgb6xry3jho>
References: <20250929122850.586278-1-sunjunchao@bytedance.com>
 <20250929122850.586278-2-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929122850.586278-2-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 530CF33822
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Spam-Score: -4.01

On Mon 29-09-25 20:28:50, Julian Sun wrote:
> When a writeback work lasts for sysctl_hung_task_timeout_secs, we want
> to identify that it's slow-this helps us pinpoint potential issues.
> 
> Additionally, recording the starting jiffies is useful when debugging a
> crashed vmcore.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

So this works but I'd rather do:

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 61785a9d6669..131d0d11672b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -213,6 +213,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>   */
>  void wb_wait_for_completion(struct wb_completion *done)
>  {
> +	done->wait_stamp = jiffies;
>  	atomic_dec(&done->cnt);		/* put down the initial count */
>  	wait_event(*done->waitq,
>  		   ({ done->progress_stamp = jiffies; !atomic_read(&done->cnt); }));

static bool wb_wait_for_completion_cb(struct wb_completion *done,
				      unsigned long wait_start)
{
	done->progress_stamp = jiffies;
	if ((jiffies - wait_start) / HZ > sysctl_hung_task_timeout_secs)
		pr_info(dump here kind of hang check warning);

	return !atomic_read(&done->cnt);
}

void wb_wait_for_completion(struct wb_completion *done)
{
	unsigned long wait_start = jiffies;

	atomic_dec(&done->cnt);		/* put down the initial count */
	wait_event(*done->waitq, wb_wait_for_completion_cb(done, wait_start));
}

This way we can properly dump info about blocked task which is IMO more
interesting than info about BDI.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

