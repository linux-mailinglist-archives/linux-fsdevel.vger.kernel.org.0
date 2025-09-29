Return-Path: <linux-fsdevel+bounces-63018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0ABA8E0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B133C4E14F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4922FB995;
	Mon, 29 Sep 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQODUmCv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hg5OmkDA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQODUmCv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hg5OmkDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5542C11F5
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141311; cv=none; b=QCi7t+yWKMkOdkvaqQ9QDd7bEwRaV1Wn+OicwvVEt0K7wFtn8j3tkuKQWrmU/HfnSDtO8vjTvhvq6/MhfeNcYLfM82onRB/Y7erermz2bF7wKXTUeTrQbL/HW4G9kV+2EHkDPh62Fahn2HHA4fb4q6kR+XAu8Cg2268+inhKJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141311; c=relaxed/simple;
	bh=6NzfXv3YDf/g/gnmzZseKY+XhteVQ0iQo5UPEG5NxN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVGlEbF36Phyo5aliDoW8LWf+bPidNTn2RaZ2ZN+ZkDi1K7tUAdlOsae+Ohgbp6sZCTFIj/xsjRA00RLTi9UwsF0Octw39YmXA44BVslu/eUGwdt2VPx7ABFCvSwYhHPZP3Ls6Esnzd3sstADB9Z/WaNkE9G3YV1sJVrO3BNvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oQODUmCv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hg5OmkDA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oQODUmCv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hg5OmkDA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8196D30E84;
	Mon, 29 Sep 2025 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759141307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBbEbKiBoKom71y30ecy0YdIq0Bng5Vq1hdVtMzv/e4=;
	b=oQODUmCv+pe601aiUzF8TtgBGR3m0BR9/Y1MGyCOmMuI2uNGdnhqqv0RWxQrSd4A8sjLYS
	rqG1WaPZ39WwusnZ7AWkx6Kbp/ySntTe1Y7GjefrKk260bDIlw5+SM6LBxuqeuNvFBY1jO
	GByDqSTNjiAjtNCAQGoIikzCxOt7N7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759141307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBbEbKiBoKom71y30ecy0YdIq0Bng5Vq1hdVtMzv/e4=;
	b=hg5OmkDAQ914kU6rv3K8wUkTPMQinEQU0omO3idjV9IoBPVK1wFvrUS1Re0HPT/V8F9QfE
	U16m43ZVhb6TFNCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oQODUmCv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hg5OmkDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759141307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBbEbKiBoKom71y30ecy0YdIq0Bng5Vq1hdVtMzv/e4=;
	b=oQODUmCv+pe601aiUzF8TtgBGR3m0BR9/Y1MGyCOmMuI2uNGdnhqqv0RWxQrSd4A8sjLYS
	rqG1WaPZ39WwusnZ7AWkx6Kbp/ySntTe1Y7GjefrKk260bDIlw5+SM6LBxuqeuNvFBY1jO
	GByDqSTNjiAjtNCAQGoIikzCxOt7N7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759141307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBbEbKiBoKom71y30ecy0YdIq0Bng5Vq1hdVtMzv/e4=;
	b=hg5OmkDAQ914kU6rv3K8wUkTPMQinEQU0omO3idjV9IoBPVK1wFvrUS1Re0HPT/V8F9QfE
	U16m43ZVhb6TFNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76C8313A21;
	Mon, 29 Sep 2025 10:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9T/+HLtd2mj9WQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Sep 2025 10:21:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33E11A0A96; Mon, 29 Sep 2025 12:21:47 +0200 (CEST)
Date: Mon, 29 Sep 2025 12:21:47 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com
Subject: Re: [PATCH 1/2] writeback: Wake up waiting tasks when finishing the
 writeback of a chunk.
Message-ID: <oz7nuthlqf42jzaqnm7xzwxddxpb2a7tmkkziljtzz4e3rlctc@6jvdfvuyexru>
References: <20250929092304.245154-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092304.245154-1-sunjunchao@bytedance.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,bytedance.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8196D30E84
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon 29-09-25 17:23:03, Julian Sun wrote:
> Writing back a large number of pages can take a lots of time.
> This issue is exacerbated when the underlying device is slow or
> subject to block layer rate limiting, which in turn triggers
> unexpected hung task warnings.
> 
> We can trigger a wake-up once a chunk has been written back and the
> waiting time for writeback exceeds half of
> sysctl_hung_task_timeout_secs.
> This action allows the hung task detector to be aware of the writeback
> progress, thereby eliminating these unexpected hung task warnings.
> 
> This patch has passed the xfstests 'check -g quick' test based on ext4,
> with no additional failures introduced.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Jan Kara <jack@suse.cz>

One question that appeared to me now below:

> @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_writeback_work *work)
>  		kfree(work);
>  	if (done) {
>  		wait_queue_head_t *waitq = done->waitq;
> +		/* Report progress to inform the hung task detector of the progress. */
> +		bool force_wake = (jiffies - done->stamp) >
> +				   sysctl_hung_task_timeout_secs * HZ / 2;
>  
>  		/* @done can't be accessed after the following dec */
> -		if (atomic_dec_and_test(&done->cnt))
> +		if (atomic_dec_and_test(&done->cnt) || force_wake)
>  			wake_up_all(waitq);
>  	}

Is this hunk actually useful for anything? Given how wb_completions work
finish_writeback_work() gets called at the moment when we should be waking
up waiters anyway so there's no point in messing with hung task detector in
this place?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

