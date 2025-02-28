Return-Path: <linux-fsdevel+bounces-42868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A7A4A315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DE3AC7A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20F230BFA;
	Fri, 28 Feb 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfGBd38B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/j1LrXZu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfGBd38B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/j1LrXZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DA1C7018
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772295; cv=none; b=HOIb7gENtWq/05ID8dyAo/8dgGSSMfJmAKRBlf4YtJnLKAka1wqVwNvU53Hz9LM96viRkUoGX0ru/QSUIYJ+qEORqxY3aoq9+nRMgMKILD5d5LtLoJe2lB12WmyvoMVzyD4F8SdhVv5kFI9/Y4sEaMguDFhu5GR28q3FJX9baVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772295; c=relaxed/simple;
	bh=xCewYbvoKMW9bARiBc2fT1zRkI8HOS/0DOe5TwwaEBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5pJxFIbfklTfbVW1bwFeppwhPiQW8YGOL8HV3FuBm36KYCk2LSvV0M9654X0sjw3JDIKuoS8XAdnqh4lz9y4KEmVXve5om1kb2ZzUbkdujh5uYmYcW1Jv1U3+zHTQXyuUcxhM3E7FGsHzyWoHxRMBontpr9gon3YqesMV6nGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfGBd38B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/j1LrXZu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfGBd38B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/j1LrXZu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01A5E1F45A;
	Fri, 28 Feb 2025 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740772292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTVuubfeWwlqm7bf6np02n/e7UREnnWqdTUGXrlHKYQ=;
	b=JfGBd38Bm7FvgqjKfuyVNmuaRDvahWd36tyPJNKcDKavXB9ujy2koLzG5oAfGt7h+nzMB+
	70oLzpPsyqFavZC2yQ1cx5v4xy8Aix+qI2UG11sHW+Y5v5ANNzniBFXCBi5fDQiHZRl0qq
	ixY+BJgquee+LqY5Uc4p8y/AoIwdDIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740772292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTVuubfeWwlqm7bf6np02n/e7UREnnWqdTUGXrlHKYQ=;
	b=/j1LrXZuQ1b0GZJ+OqiYp4AL3K/zQfKdpYv2ufMeqILiJvTJfAyn2pJIhaTj1XdV140RQJ
	mgBak6Sj/MtsZ4Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740772292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTVuubfeWwlqm7bf6np02n/e7UREnnWqdTUGXrlHKYQ=;
	b=JfGBd38Bm7FvgqjKfuyVNmuaRDvahWd36tyPJNKcDKavXB9ujy2koLzG5oAfGt7h+nzMB+
	70oLzpPsyqFavZC2yQ1cx5v4xy8Aix+qI2UG11sHW+Y5v5ANNzniBFXCBi5fDQiHZRl0qq
	ixY+BJgquee+LqY5Uc4p8y/AoIwdDIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740772292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTVuubfeWwlqm7bf6np02n/e7UREnnWqdTUGXrlHKYQ=;
	b=/j1LrXZuQ1b0GZJ+OqiYp4AL3K/zQfKdpYv2ufMeqILiJvTJfAyn2pJIhaTj1XdV140RQJ
	mgBak6Sj/MtsZ4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E871D1344A;
	Fri, 28 Feb 2025 19:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4FVtOMMTwmdQHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Feb 2025 19:51:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98A2DA07C1; Fri, 28 Feb 2025 20:51:27 +0100 (CET)
Date: Fri, 28 Feb 2025 20:51:27 +0100
From: Jan Kara <jack@suse.cz>
To: Pan Deng <pan.deng@intel.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, tianyou.li@intel.com, tim.c.chen@linux.intel.com, 
	lipeng.zhu@intel.com
Subject: Re: [PATCH] fs: place f_ref to 3rd cache line in struct file to
 resolve false sharing
Message-ID: <uyqqemnrf46xdht3mr4okv6zw7asfhjabz3fu5fl5yan52ntoh@nflmsbxz6meb>
References: <20250228020059.3023375-1-pan.deng@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228020059.3023375-1-pan.deng@intel.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 28-02-25 10:00:59, Pan Deng wrote:
> When running syscall pread in a high core count system, f_ref contends
> with the reading of f_mode, f_op, f_mapping, f_inode, f_flags in the
> same cache line.

Well, but you have to have mulithreaded process using the same struct file
for the IO, don't you? Otherwise f_ref is not touched...

> This change places f_ref to the 3rd cache line where fields are not
> updated as frequently as the 1st cache line, and the contention is
> grealy reduced according to tests. In addition, the size of file
> object is kept in 3 cache lines.
> 
> This change has been tested with rocksdb benchmark readwhilewriting case
> in 1 socket 64 physical core 128 logical core baremetal machine, with
> build config CONFIG_RANDSTRUCT_NONE=y
> Command:
> ./db_bench --benchmarks="readwhilewriting" --threads $cnt --duration 60
> The throughput(ops/s) is improved up to ~21%.
> =====
> thread		baseline	compare
> 16		 100%		 +1.3%
> 32		 100%		 +2.2%
> 64		 100%		 +7.2%
> 128		 100%		 +20.9%
> 
> It was also tested with UnixBench: syscall, fsbuffer, fstime,
> fsdisk cases that has been used for file struct layout tuning, no
> regression was observed.

So overall keeping the first cacheline read mostly with important stuff
makes sense to limit cache traffic. But:

>  struct file {
> -	file_ref_t			f_ref;
>  	spinlock_t			f_lock;
>  	fmode_t				f_mode;
>  	const struct file_operations	*f_op;
> @@ -1102,6 +1101,7 @@ struct file {
>  	unsigned int			f_flags;
>  	unsigned int			f_iocb_flags;
>  	const struct cred		*f_cred;
> +	u8				padding[8];
>  	/* --- cacheline 1 boundary (64 bytes) --- */
>  	struct path			f_path;
>  	union {
> @@ -1127,6 +1127,7 @@ struct file {
>  		struct file_ra_state	f_ra;
>  		freeptr_t		f_freeptr;
>  	};
> +	file_ref_t			f_ref;
>  	/* --- cacheline 3 boundary (192 bytes) --- */
>  } __randomize_layout

This keeps struct file within 3 cachelines but it actually grows it from
184 to 192 bytes (and yes, that changes how many file structs we can fit in
a slab). So instead of adding 8 bytes of padding, just pick some
read-mostly element and move it into the hole - f_owner looks like one
possible candidate.

Also did you test how moving f_ref to the second cache line instead of the
third one behaves?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

