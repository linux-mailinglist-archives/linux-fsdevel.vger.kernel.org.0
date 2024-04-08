Return-Path: <linux-fsdevel+bounces-16365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B12F89C63C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4311C21A38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF880BF8;
	Mon,  8 Apr 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MofoLoFN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wp7MzA1f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MofoLoFN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wp7MzA1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBD80624;
	Mon,  8 Apr 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585150; cv=none; b=cCpaFYVXg7C8qrOz1o91IN8KhiZFL3ELqYsFCW9284PLI2dC1FdT4UFg2kVJG/sJj9ptLNyxdw6JbHbrYX3BvHDvL+/QqZB0+g/WagkvnEozMgqil5sSE2ih1ck8pCjYTWj67Bh/3JYdtXI7zyN/fJLyTTyzLVicWS6YZa4vBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585150; c=relaxed/simple;
	bh=s8bdLcGMbFj1E3CCUGSRfPeiS+tNSHD+/NTrJNSxZuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2p0tSSyzlZeTlZA905Jj0W1w9YJlgWl8lYgGg6arkwpYL5WB9qMndCPc3mbVocqosGpn5XfaYD8sct1zD1J9RQcI2kwokg5eyED0J47NUfYQnKduSGMlzlxCGHqAsC+qF6oOACoEyU7iOlPjdF38huV9ZHt8oM/q3zhMRCGH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MofoLoFN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wp7MzA1f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MofoLoFN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wp7MzA1f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3226822981;
	Mon,  8 Apr 2024 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712585144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CFyho3n5Kge6NnS/vjp6526Vx90yRChUiIgeH6TJ3Y=;
	b=MofoLoFNaYPJvKE7Eo9vI5nwMS5shYrpA/T++PEKIH3KSKdlm0VeGnxGPjd0Fh6IcrwR79
	5IE4vvs+vDto2ccNIDYdMJ62wsnuHoK1ANPoLO8DKZ3OOKKJj96B6EFxR3MWsK4w/Zf/YY
	eJ/s0ZCg6pAchiUIVR1jlIpl5BC+jRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712585144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CFyho3n5Kge6NnS/vjp6526Vx90yRChUiIgeH6TJ3Y=;
	b=wp7MzA1fG9cc4YhoIObUi0ULJ5FYVCMro5U5XhsByywCu6EqDwI4rME/O3jcYSl8kYdmGB
	O1E8LR9XvDewMrAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MofoLoFN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wp7MzA1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712585144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CFyho3n5Kge6NnS/vjp6526Vx90yRChUiIgeH6TJ3Y=;
	b=MofoLoFNaYPJvKE7Eo9vI5nwMS5shYrpA/T++PEKIH3KSKdlm0VeGnxGPjd0Fh6IcrwR79
	5IE4vvs+vDto2ccNIDYdMJ62wsnuHoK1ANPoLO8DKZ3OOKKJj96B6EFxR3MWsK4w/Zf/YY
	eJ/s0ZCg6pAchiUIVR1jlIpl5BC+jRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712585144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CFyho3n5Kge6NnS/vjp6526Vx90yRChUiIgeH6TJ3Y=;
	b=wp7MzA1fG9cc4YhoIObUi0ULJ5FYVCMro5U5XhsByywCu6EqDwI4rME/O3jcYSl8kYdmGB
	O1E8LR9XvDewMrAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2641313A92;
	Mon,  8 Apr 2024 14:05:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uApOCbj5E2aoagAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 08 Apr 2024 14:05:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AEA5EA0814; Mon,  8 Apr 2024 16:05:43 +0200 (CEST)
Date: Mon, 8 Apr 2024 16:05:43 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, viro@zeniv.linux.org.uk,
	axboe@kernel.dk, gustavoars@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 00/26] fs & block: remove bdev->bd_inode
Message-ID: <20240408140543.lslhx5epe6hnns6h@quack3>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <227a872d-51e9-babc-0489-7fcc7112c0e6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227a872d-51e9-babc-0489-7fcc7112c0e6@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3226822981
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Sun 07-04-24 10:20:39, Yu Kuai wrote:
> Hi, Christian!
> Hi, Jan!
> +CC Gustavo
> 
> While testing this set, I found that the branch vfs.all seems broken,
> xfstests report success while lots of BUG is reported in dmesg:
> 
> [22709.079704] =============================================================================^M
> [22709.082404] BUG kmalloc-16 (Not tainted): Right Redzone overwritten^M
> [22709.084148] -----------------------------------------------------------------------------^M
> [22709.084148] ^M
> [22709.086784] 0xffff88817d52e7a0-0xffff88817d52e7a7 @offset=1952. First
> byte 0x0 instead of 0xcc^M
> [22709.089169] Allocated in do_handle_open+0x97/0x440 age=10 cpu=13
> pid=814795^M
> [22709.091158]  __kmalloc+0x41d/0x5e0^M
> [22709.092153]  do_handle_open+0x97/0x440^M
> [22709.093240]  __x64_sys_open_by_handle_at+0x23/0x30^M
> [22709.094482]  do_syscall_64+0xb1/0x210^M
> [22709.095316]  entry_SYSCALL_64_after_hwframe+0x6c/0x74^M
> [22709.096414] Freed in kvfree+0x4c/0x60 age=43560 cpu=15 pid=813506^M
> [22709.097719]  kfree+0x31c/0x530^M
> [22709.098396]  kvfree+0x4c/0x60^M
> [22709.099048]  ext4_mb_release+0x29c/0x570^M
> [22709.099901]  ext4_put_super+0x17f/0x590^M
> [22709.100735]  generic_shutdown_super+0xba/0x240^M
> [22709.101698]  kill_block_super+0x22/0x70^M
> [22709.102525]  ext4_kill_sb+0x2a/0x70^M
> [22709.103297]  deactivate_locked_super+0x4f/0xe0^M
> [22709.104261]  deactivate_super+0x81/0x90^M
> [22709.104876]  cleanup_mnt+0xe0/0x1b0^M
> [22709.105419]  __cleanup_mnt+0x1a/0x30^M
> [22709.105964]  task_work_run+0x88/0x100^M
> [22709.106531]  syscall_exit_to_user_mode+0x3cc/0x3e0^M
> [22709.107263]  do_syscall_64+0xc5/0x210^M
> [22709.107820]  entry_SYSCALL_64_after_hwframe+0x6c/0x74^M
> 
> While digging this problem, I found that commit 1b43c4629756 ("fs:
> Annotate struct file_handle with __counted_by() and use struct_size()")
> might made a mistake, and I verified following patch can fix the
> problem.

Yep, this should have been fixed recently in VFS tree as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

