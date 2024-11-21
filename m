Return-Path: <linux-fsdevel+bounces-35434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7109D4C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74742B263B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29B91D2F54;
	Thu, 21 Nov 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZNafvK0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nyyvu25H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZNafvK0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nyyvu25H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D71CEAAC;
	Thu, 21 Nov 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188950; cv=none; b=FkJ19Xjg96A6Nc0zlJD/7wKX+1ubjWNYXwsVyq0AF8M0agQFY2cB/28V+GlB/ZaKbXvrClUVtXLAPoqbY0OzjmTP4YyYd/qi3Q2r4UaNuTl33h8+c//UVZxDDKzgiwQswfDMKezLHEbL0IpUdNYccXmuB/VHPyry1cAe0oRNscs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188950; c=relaxed/simple;
	bh=H+InuCZAVe/s/oVInDzsiaHK8UMZy9fOxfpi6EvYjhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anpwi+WDVczFNQkyHBwny/+0gApc/fj8GE+3b8J3oGkbB5WI4PuBDf1ZMGy0d3cN504g1i1uuooUBJELssfiqm0ajPCnledfWp9KgMOniDZhEHaeL1qLrLdmx7uvvu0l/P6V0deG6GugJq1J0fmGeLbbQqss3VMkqNpR+RhE/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZNafvK0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nyyvu25H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZNafvK0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nyyvu25H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 897BD1F7FB;
	Thu, 21 Nov 2024 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GK16IzfkdgV1PUCdlVeB/mMd3MAHrVpEn6IZ5MBM7g4=;
	b=gZNafvK0SmbhL4HyBbYcQ9V+Zt+TfxC0C6tWy7Z6s3Rzn/q4Em6B97yw12Dy0p8nUH9ZWt
	FLJ4TChdTNC8HVNZkto8G4zuLKWoYTErolHhhlFioA4qCI60hGx3F51W4S/A4RPaGYobzl
	VUaysWdtPTcJCeyqpawBYe55tWkux+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GK16IzfkdgV1PUCdlVeB/mMd3MAHrVpEn6IZ5MBM7g4=;
	b=Nyyvu25HUbdK5PObarAyUxLcbWFfRsDo96LOjhl4OlNcFAnCkqlt1yAvbmXHI1S7qIHufG
	gShoFq6jd8ENlVCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GK16IzfkdgV1PUCdlVeB/mMd3MAHrVpEn6IZ5MBM7g4=;
	b=gZNafvK0SmbhL4HyBbYcQ9V+Zt+TfxC0C6tWy7Z6s3Rzn/q4Em6B97yw12Dy0p8nUH9ZWt
	FLJ4TChdTNC8HVNZkto8G4zuLKWoYTErolHhhlFioA4qCI60hGx3F51W4S/A4RPaGYobzl
	VUaysWdtPTcJCeyqpawBYe55tWkux+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GK16IzfkdgV1PUCdlVeB/mMd3MAHrVpEn6IZ5MBM7g4=;
	b=Nyyvu25HUbdK5PObarAyUxLcbWFfRsDo96LOjhl4OlNcFAnCkqlt1yAvbmXHI1S7qIHufG
	gShoFq6jd8ENlVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F36F13927;
	Thu, 21 Nov 2024 11:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zNMJHxIbP2fkBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:35:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36B93A089E; Thu, 21 Nov 2024 12:35:46 +0100 (CET)
Date: Thu, 21 Nov 2024 12:35:46 +0100
From: Jan Kara <jack@suse.cz>
To: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Subject: Re: [PATCH] fs: Fix data race in inode_set_ctime_to_ts
Message-ID: <20241121113546.apvyb43pnuceae3g@quack3>
References: <20241120024306.156920-1-zhenghaoran@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120024306.156920-1-zhenghaoran@buaa.edu.cn>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,gmail.com,buaa.edu.cn];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 20-11-24 10:43:06, Hao-ran Zheng wrote:
> A data race may occur when the function `inode_set_ctime_to_ts()` and
> the function `inode_get_ctime_sec()` are executed concurrently. When
> two threads call `aio_read` and `aio_write` respectively, they will
> be distributed to the read and write functions of the corresponding
> file system respectively. Taking the btrfs file system as an example,
> the `btrfs_file_read_iter` and `btrfs_file_write_iter` functions are
> finally called. These two functions created a data race when they
> finally called `inode_get_ctime_sec()` and `inode_set_ctime_to_ns()`.
> The specific call stack that appears during testing is as follows:
> 
> ```
> ============DATA_RACE============
> btrfs_delayed_update_inode+0x1f61/0x7ce0 [btrfs]
> btrfs_update_inode+0x45e/0xbb0 [btrfs]
> btrfs_dirty_inode+0x2b8/0x530 [btrfs]
> btrfs_update_time+0x1ad/0x230 [btrfs]
> touch_atime+0x211/0x440
> filemap_read+0x90f/0xa20
> btrfs_file_read_iter+0xeb/0x580 [btrfs]
> aio_read+0x275/0x3a0
> io_submit_one+0xd22/0x1ce0
> __se_sys_io_submit+0xb3/0x250
> do_syscall_64+0xc1/0x190
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ============OTHER_INFO============
> btrfs_write_check+0xa15/0x1390 [btrfs]
> btrfs_buffered_write+0x52f/0x29d0 [btrfs]
> btrfs_do_write_iter+0x53d/0x1590 [btrfs]
> btrfs_file_write_iter+0x41/0x60 [btrfs]
> aio_write+0x41e/0x5f0
> io_submit_one+0xd42/0x1ce0
> __se_sys_io_submit+0xb3/0x250
> do_syscall_64+0xc1/0x190
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ```
> 
> The call chain after traceability is as follows:
> 
> ```
> Thread1:
> btrfs_delayed_update_inode() ->
> fill_stack_inode_item() ->
> inode_get_ctime_sec()
> 
> Thread2:
> btrfs_write_check() ->
> update_time_for_write() ->
> inode_set_ctime_to_ts()
> ```
> 
> To address this issue, it is recommended to
> add WRITE_ONCE when writing the `inode->i_ctime_sec` variable.

Thanks for the patch! This is really, really theoretic but with LTO I
suppose the compiler could get inventive and compile this in some other way
than plain stores.  But WRITE_ONCE() alone is not enough. You should have
READ_ONCE() in the reading counterparts as well.

								Honza

> 
> Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
> ---
>  include/linux/fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c1..d11b257a35e1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1674,8 +1674,8 @@ static inline struct timespec64 inode_get_ctime(const struct inode *inode)
>  static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
>  						      struct timespec64 ts)
>  {
> -	inode->i_ctime_sec = ts.tv_sec;
> -	inode->i_ctime_nsec = ts.tv_nsec;
> +	WRITE_ONCE(inode->i_ctime_sec, ts.tv_sec);
> +	WRITE_ONCE(inode->i_ctime_nsec, ts.tv_nsec);
>  	return ts;
>  }
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

