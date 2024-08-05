Return-Path: <linux-fsdevel+bounces-25018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2957947C04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FE7282066
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E7374F6;
	Mon,  5 Aug 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mAnm68CR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dbJvAehk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mAnm68CR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dbJvAehk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566F2C6BD
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865238; cv=none; b=TKpUgWfrsYxXTeLjE5gXG2KgGqGyHhIO1EJAdMYPwO6lIcM9m5gywfS+ig533PJPXlOh4QaV0HnkmktBvYNFRVAwEWI2VOvTE/VIwDGbb7Qo/u0wDJlqjvNc57J5TSFsc4bFcc/tWq73tAst2/fgoIybIP1sHI71LqefKJs85t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865238; c=relaxed/simple;
	bh=qy25XdRw4WYEkfP/Ym8kJ51CkAfuKpR64m6U6wwc89Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5Ib09Ckh8H54CurdgAD0t0IclTd/dRd9uh6DUryIeqCKo0HIqv3cYqbMAsyLD4syOrdQoB9ntuSaqvdoBYMgB5aSem6U2A0zzdasYLFOJM4QMeKUwGQreH3Dx7X40O6WlJSJCTQJedFdL4mG4YNcz3SiYFXaCNwZyLnN78UE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mAnm68CR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dbJvAehk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mAnm68CR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dbJvAehk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 065D921B8E;
	Mon,  5 Aug 2024 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722865235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfwqLxxyPbD5uPivzkX9y3Ly2R8iAEY15USvNXeffag=;
	b=mAnm68CRQzo9wn0fk3MChTGHySZa08tEg4s13dQOg0FIjp5dwNbrGWIIlUQhIfHJTBbyx3
	wIK2N8NfIoZGUvVyPk14+wp8gLFicF6qeKydNpejQhS2VNe1F/s+nRY4wFmWPGgOYQnzfJ
	JjLZzXtSJuPc+1KdbyrAsuxJys3X2pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722865235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfwqLxxyPbD5uPivzkX9y3Ly2R8iAEY15USvNXeffag=;
	b=dbJvAehknnNMoWbP92SbwMuuyv+jU8Z34AGF71IdlFG2DRU3dDxDnC30f/MiY7vMP80CUL
	Og/qATLt9GOeg5CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722865235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfwqLxxyPbD5uPivzkX9y3Ly2R8iAEY15USvNXeffag=;
	b=mAnm68CRQzo9wn0fk3MChTGHySZa08tEg4s13dQOg0FIjp5dwNbrGWIIlUQhIfHJTBbyx3
	wIK2N8NfIoZGUvVyPk14+wp8gLFicF6qeKydNpejQhS2VNe1F/s+nRY4wFmWPGgOYQnzfJ
	JjLZzXtSJuPc+1KdbyrAsuxJys3X2pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722865235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfwqLxxyPbD5uPivzkX9y3Ly2R8iAEY15USvNXeffag=;
	b=dbJvAehknnNMoWbP92SbwMuuyv+jU8Z34AGF71IdlFG2DRU3dDxDnC30f/MiY7vMP80CUL
	Og/qATLt9GOeg5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAB6013ACF;
	Mon,  5 Aug 2024 13:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fpEIOVLWsGaXPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 13:40:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A343FA0897; Mon,  5 Aug 2024 15:40:34 +0200 (CEST)
Date: Mon, 5 Aug 2024 15:40:34 +0200
From: Jan Kara <jack@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <20240805134034.mf3ljesorgupe6e7@quack3>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804080251.21239-1-laoar.shao@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,fromorbit.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 04-08-24 16:02:51, Yafang Shao wrote:
> Background
> ==========
> 
> Our big data workloads are deployed on XFS-based disks, and we frequently
> encounter hung tasks caused by xfs_ilock. These hung tasks arise because
> different applications may access the same files concurrently. For example,
> while a datanode task is writing to a file, a filebeat[0] task might be
> reading the same file concurrently. If the task writing to the file takes a
> long time, the task reading the file will hang due to contention on the XFS
> inode lock.
> 
> This inode lock contention between writing and reading files only occurs on
> XFS, but not on other file systems such as EXT4. Dave provided a clear
> explanation for why this occurs only on XFS[1]:
> 
>   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
>   : Atomic means that all the bytes from a single operation that started
>   : out together end up together, without interleaving from other I/O
>   : operations. [2]
>   : XFS is the only linux filesystem that provides this behaviour.
> 
> As we have been running big data on XFS for years, we don't want to switch
> to other file systems like EXT4. Therefore, we plan to resolve these issues
> within XFS.
> 
> Proposal
> ========
> 
> One solution we're currently exploring is leveraging the preadv2(2)
> syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS inode
> lock hung task. This can be illustrated as follows:
> 
>   retry:
>       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
>           sleep(n)
>           goto retry;
>       }
> 
> Since the tasks reading the same files are not critical tasks, a delay in
> reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NOWAIT but
> also enables IOCB_NOIO. Therefore, if the file is not in the page cache, it
> will loop indefinitely until someone else reads it from disk, which is not
> acceptable.
> 
> So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(2). This
> flag will allow reading from the disk if the file is not in the page cache
> but will not allow waiting for the lock if it is held by others. With this
> new flag, we can resolve our issues effectively.
> 
> Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dastard/ [0]
> Link: https://github.com/elastic/beats/tree/master/filebeat [1]
> Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/read.html [2]
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Dave Chinner <david@fromorbit.com>

Thanks for the detailed explanation! I understand your problem but I have to
say I find this flag like a hack to workaround particular XFS behavior and
the guarantees the new RWF_IOWAIT flag should provide are not very clear to
me. I've CCed Amir who's been dealing with similar issues with XFS at his
employer and had some patches as far as I remember.

What you could possibly do to read the file contents without blocking on
xfs_iolock is to mmap the file and grab the data from the mapping. It is
still hacky but at least we don't have to pollute the kernel with an IO
flag with unclear semantics.

								Honza

> ---
>  include/linux/fs.h      | 6 ++++++
>  include/uapi/linux/fs.h | 5 ++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..5df7b5b0927a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3472,6 +3472,12 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
>  			return -EPERM;
>  		ki->ki_flags &= ~IOCB_APPEND;
>  	}
> +	if (flags & RWF_IOWAIT) {
> +		kiocb_flags |= IOCB_NOWAIT;
> +		/* IOCB_NOIO is not allowed for RWF_IOWAIT */
> +		if (kiocb_flags & IOCB_NOIO)
> +			return -EINVAL;
> +	}
>  
>  	ki->ki_flags |= kiocb_flags;
>  	return 0;
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 191a7e88a8ab..17a8c065d636 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -332,9 +332,12 @@ typedef int __bitwise __kernel_rwf_t;
>  /* Atomic Write */
>  #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
>  
> +/* per-IO, allow waiting for IO, but not waiting for lock */
> +#define RWF_IOWAIT	((__force __kernel_rwf_t)0x00000080)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
> +			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC | RWF_IOWAIT)
>  
>  /* Pagemap ioctl */
>  #define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

