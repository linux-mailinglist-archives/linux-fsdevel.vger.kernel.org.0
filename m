Return-Path: <linux-fsdevel+bounces-27795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB696422F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0E282A82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA818E370;
	Thu, 29 Aug 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qim55DdY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9xXFTZs4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rLjqS3Ov";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gieVXgay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91314B950;
	Thu, 29 Aug 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928492; cv=none; b=dZVPqMwoCRxbYRu4Mc61Fk2q85LCQ0c8rUoXu9jG0FMQ+/t0KNDqfAnBrrmKifBC+M/QTxUFIqp6RPH4TYGm1vQuSazV2uzuXOqN3baPUaKwCGHzKa+G+9xnd/GxY06MRuN407m3RmLwht6AKVH2L4+MlXL5JsqhvCCnlAkET+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928492; c=relaxed/simple;
	bh=vuJHAnJgqAzc6OocswqQsMXxp93fDT5iaJNUt46Rkv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKerYXMt0y3SpeU701MqhyWjSzLFRJ8HOKVDiPwswJCzLasFaL9bi4TJAuF2zlFuYB20cPMR8m5BdknddHCUw2xWWv52T5FfztpfhJix/FQOTHK2HSAjlY8XhZkaXc8eBJd0cPQlDknm2MQWca/Onu1DHD7BeF1s2hjOA2zXpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qim55DdY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9xXFTZs4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rLjqS3Ov; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gieVXgay; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 029DF1F45E;
	Thu, 29 Aug 2024 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724928487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYshNOA125TAq+wwYlbfMDtD7jQaRDujc9AboFKKLPM=;
	b=qim55DdYitf3H3MHYaWbW05FnClviBJ6ATBpRqLFUWk48nGk0PBzyAc2WQn10BIgLSGrH2
	g64PqahIQfo3JSxF1RNfof4PdY5+IfmPRaDNFSiN6m4/N/B5eqT/s9lEMb6PNd3P2YLGaN
	w2GVUV3If+ubg19dLioqI+O9B14Zvns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724928487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYshNOA125TAq+wwYlbfMDtD7jQaRDujc9AboFKKLPM=;
	b=9xXFTZs4mG6AFPRwv5pR2rgfrxgmHub4ikn1hK0J6MculsEXOAVG/gC24Jmlbpwp5EXhee
	SG7xJS9j4fct3bCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rLjqS3Ov;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gieVXgay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724928486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYshNOA125TAq+wwYlbfMDtD7jQaRDujc9AboFKKLPM=;
	b=rLjqS3OvCY9IxdTS3AyQPiM43CrzOT8uK2HgrdvRumyqou4aPw8refUghxFTEVXK6P7XCx
	PJxJ9QJED5Ze9r2AacSgS/fENqOtLGCZ7rJ2lUsWGUoucezQPe6GO2CYKBF4sLcQDo/Kfo
	gDeon9Jjy4Ai9hw3FtI+m5t89bmbq6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724928486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYshNOA125TAq+wwYlbfMDtD7jQaRDujc9AboFKKLPM=;
	b=gieVXgaybs7KsI52JK2WhMwXjnb2bKDzWUlQSfKwuO+7dIWZIyPLqdqlWy7Es4XT9HMitN
	nFaqiSbd5K0Y9IAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E701A13B01;
	Thu, 29 Aug 2024 10:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i8BlOOVR0GZUDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 10:48:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65FA2A0965; Thu, 29 Aug 2024 12:48:05 +0200 (CEST)
Date: Thu, 29 Aug 2024 12:48:05 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 11/16] fanotify: disable readahead if we have
 pre-content watches
Message-ID: <20240829104805.gu5xt2nruupzt2jm@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <9a458c9c553c6a8d5416c91650a9b152458459d0.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a458c9c553c6a8d5416c91650a9b152458459d0.1723670362.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: 029DF1F45E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,toxicpanda.com:email,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 14-08-24 17:25:29, Josef Bacik wrote:
> With page faults we can trigger readahead on the file, and then
> subsequent faults can find these pages and insert them into the file
> without emitting an fanotify event.  To avoid this case, disable
> readahead if we have pre-content watches on the file.  This way we are
> guaranteed to get an event for every range we attempt to access on a
> pre-content watched file.
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

...

> @@ -674,6 +675,14 @@ void page_cache_sync_ra(struct readahead_control *ractl,
>  {
>  	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
>  
> +	/*
> +	 * If we have pre-content watches we need to disable readahead to make
> +	 * sure that we don't find 0 filled pages in cache that we never emitted
> +	 * events for.
> +	 */
> +	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
> +		return;
> +

There are callers which don't pass struct file to readahead (either to
page_cache_sync_ra() or page_cache_async_ra()). Luckily these are very few
- cramfs for a block device (we don't care) and btrfs from code paths like
send-receive or defrag. Now if you tell me you're fine breaking these
corner cases for btrfs, I'll take your word for it but it looks like a
nasty trap to me. Now doing things like defrag or send-receive on offline
files on HSM managed filesystem doesn't look like a terribly good idea
anyway so perhaps we just want btrfs to check and refuse such things?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

