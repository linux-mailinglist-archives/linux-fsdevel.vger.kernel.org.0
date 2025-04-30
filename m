Return-Path: <linux-fsdevel+bounces-47699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF39AA4468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1192F3B614F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54C2116E0;
	Wed, 30 Apr 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iNCkWHcY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eIq5atmb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aNrBN2x+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g7Am51QQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9E20FAB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999470; cv=none; b=taCDNmJ5oDqpAWinOtMjPuQSVR7pByNRD9thQAVLwqpFfE5obAEL8ctHC+cuXVnR4D2DTTTMcM971TbmFI3shhGIs+KKV09IDWfx/PsZri6QbdgbLEUde9X8ZpwR+yguqBCePIgLTj1NN1WN1w5otJb0WMmTwKOdXAq41SsFNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999470; c=relaxed/simple;
	bh=foh/DuW95cZsqjg/VSKVkrUj1kdRRcUgMbDthE7FEGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0qQK4oX9uCRGFXdr+oFk2upNDerzGqKyECV8TTg6VCy6kYPxEw1ajuRL9fKg/D+toHpFb4zP6/WVxHO1QyFdiUyTv6i5m0bVyWa6j8rOo4hpjlwiahn6/Vlnq7L9ZfU+GmWNAE2Rp0WP0ReDBEbQpDac6VIsK0Qi41odeJY/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iNCkWHcY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eIq5atmb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aNrBN2x+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g7Am51QQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAF842118E;
	Wed, 30 Apr 2025 07:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745999465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X8C4pJloyXrdEwF36eGw3ZP+Jop5IM/qNsnFLvGmzzQ=;
	b=iNCkWHcYmEITbvVyJpzTg8CnTMat4tqT0JaJBSxJ+CHzokJKXO+m261WKwkiwFTu4Xfoll
	soFf6aqDI3VBXEEKoekYBu18oHPkK4vOUgALv+Dj5cpcQW1At4PMpNo0PsYEiMrt+56BpQ
	2nEXdHF8lohB5OeJAVT1U6WfIvkABzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745999465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X8C4pJloyXrdEwF36eGw3ZP+Jop5IM/qNsnFLvGmzzQ=;
	b=eIq5atmb+t5rpdNmRnb1kUMzZXE4wY3ZrSHDiZVr/MkHwXp5+OUQYGBSXPsQbL3OBom+uc
	c7Z11NWVM55SzZCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745999464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X8C4pJloyXrdEwF36eGw3ZP+Jop5IM/qNsnFLvGmzzQ=;
	b=aNrBN2x+Fce0SYuar+DVNj7eyhp2Gn9glw/Jvfy4PMoInmtucIYA0Q3El6frkoBS2/f0Hf
	Wo/0aJzich/YPFtlazhHzZuYXoUsbN+9lvhIbQgcQ6E1O5L17M7SDQmoa+bNL5j4rpZ3UI
	PK20OADMzZDugngAZhjTTD6K4SEdbj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745999464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X8C4pJloyXrdEwF36eGw3ZP+Jop5IM/qNsnFLvGmzzQ=;
	b=g7Am51QQWD/hQMoE3jr1Lh6fOmagzPkeWFv4dVgj+Iu5TKZ0Ol/nhFO46/wR87jseIoSh7
	CHUNWgRqI9QImVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CA59139E7;
	Wed, 30 Apr 2025 07:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ZU4JmjWEWiUBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 07:51:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2DB0EA0AF0; Wed, 30 Apr 2025 09:51:00 +0200 (CEST)
Date: Wed, 30 Apr 2025 09:51:00 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 1/4] ext4: fix out of bounds punch offset
Message-ID: <mfwnu23qasbm5nrvxon42xleoiswobikq5ogg7i6v4zawwhrid@dpjyzgwc2a2a>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 30-04-25 09:12:58, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Punching a hole with a start offset that exceeds max_end is not
> permitted and will result in a negative length in the
> truncate_inode_partial_folio() function while truncating the page cache,
> potentially leading to undesirable consequences.
> 
> A simple reproducer:
> 
>   truncate -s 9895604649994 /mnt/foo
>   xfs_io -c "pwrite 8796093022208 4096" /mnt/foo
>   xfs_io -c "fpunch 8796093022213 25769803777" /mnt/foo
> 
>   kernel BUG at include/linux/highmem.h:275!
>   Oops: invalid opcode: 0000 [#1] SMP PTI
>   CPU: 3 UID: 0 PID: 710 Comm: xfs_io Not tainted 6.15.0-rc3
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
>   RIP: 0010:zero_user_segments.constprop.0+0xd7/0x110
>   RSP: 0018:ffffc90001cf3b38 EFLAGS: 00010287
>   RAX: 0000000000000005 RBX: ffffea0001485e40 RCX: 0000000000001000
>   RDX: 000000000040b000 RSI: 0000000000000005 RDI: 000000000040b000
>   RBP: 000000000040affb R08: ffff888000000000 R09: ffffea0000000000
>   R10: 0000000000000003 R11: 00000000fffc7fc5 R12: 0000000000000005
>   R13: 000000000040affb R14: ffffea0001485e40 R15: ffff888031cd3000
>   FS:  00007f4f63d0b780(0000) GS:ffff8880d337d000(0000)
>   knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000000001ae0b038 CR3: 00000000536aa000 CR4: 00000000000006f0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    truncate_inode_partial_folio+0x3dd/0x620
>    truncate_inode_pages_range+0x226/0x720
>    ? bdev_getblk+0x52/0x3e0
>    ? ext4_get_group_desc+0x78/0x150
>    ? crc32c_arch+0xfd/0x180
>    ? __ext4_get_inode_loc+0x18c/0x840
>    ? ext4_inode_csum+0x117/0x160
>    ? jbd2_journal_dirty_metadata+0x61/0x390
>    ? __ext4_handle_dirty_metadata+0xa0/0x2b0
>    ? kmem_cache_free+0x90/0x5a0
>    ? jbd2_journal_stop+0x1d5/0x550
>    ? __ext4_journal_stop+0x49/0x100
>    truncate_pagecache_range+0x50/0x80
>    ext4_truncate_page_cache_block_range+0x57/0x3a0
>    ext4_punch_hole+0x1fe/0x670
>    ext4_fallocate+0x792/0x17d0
>    ? __count_memcg_events+0x175/0x2a0
>    vfs_fallocate+0x121/0x560
>    ksys_fallocate+0x51/0xc0
>    __x64_sys_fallocate+0x24/0x40
>    x64_sys_call+0x18d2/0x4170
>    do_syscall_64+0xa7/0x220
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fix this by filtering out cases where the punching start offset exceeds
> max_end.
> 
> Fixes: 982bf37da09d ("ext4: refactor ext4_punch_hole()")
> Reported-by: Liebes Wang <wanghaichi0403@gmail.com>
> Closes: https://lore.kernel.org/linux-ext4/ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com/
> Tested-by: Liebes Wang <wanghaichi0403@gmail.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94c7d2d828a6..4ec4a80b6879 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4016,7 +4016,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	/* No need to punch hole beyond i_size */
> -	if (offset >= inode->i_size)
> +	if (offset >= inode->i_size || offset >= max_end)
>  		return 0;
>  
>  	/*
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

