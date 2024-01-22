Return-Path: <linux-fsdevel+bounces-8408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84C835FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E143228703A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5513B187;
	Mon, 22 Jan 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="leSP+l+3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9xAcknqy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SqW+JgTp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1JDCaYUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B213AC0C;
	Mon, 22 Jan 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920230; cv=none; b=eP6GCqFpZzcqHqqMcyg7K0NC4RiIdlmctsWiHrMNqF4Pf5fOkpj5hVVuFlZFyeduMw2/XDPZyykLONfKtXhXMR1lt/kHjyk+R0be2WAxRB3tWM2KSGq4fSxtkmEPxzCjPvrGsCjhz8Aw8M74ug1CEbc+GFgAqcHXrQ4xe6/Pf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920230; c=relaxed/simple;
	bh=NSBs+uABJkGB61m7svoBs6j0aHvwxQa7qKTnvMtgV5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4LOn8c3FjtCEbMDYtZdO6mAqt9THxa4XMwcdRcSRclaT8Fw+2Vsf8dHJLFxrorDLBxFlVI6JHGeGOzBd0fqRUTn28Nts4M+1BYrdbbr2SJoMaWFZr55XlaBxfiz+xLrCCdJsZGMXkzpUD1vkSM9Ze1cbwUXB4s+7FXPnUJUXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=leSP+l+3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9xAcknqy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SqW+JgTp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1JDCaYUA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D40D1F385;
	Mon, 22 Jan 2024 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705920226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmC+DrXD0VE+1TM4mtYcFfIi/ngzxSqDf/3wGBo/yNk=;
	b=leSP+l+3dEnIufDGPeKYxT+VdfNlFtbFaKAnqOD8euXSe0/LRydWdQ8GVh5YBqWDljh9I+
	ysXKgeGW4LM9g1uTpKqMNOLZS9V62cah3Klo1WtIjvEU5k+vMLrDgpo8O8KX6q3J8pwvk9
	jUr/VwES0HMCuxB8DZknmgOEaw4s2gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705920226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmC+DrXD0VE+1TM4mtYcFfIi/ngzxSqDf/3wGBo/yNk=;
	b=9xAcknqyiZaqFxvLwCOZf4c3pqyEG5VJRyZGg79j+ysCTE2JzDCZRqttZh63UJSzzZeT1M
	dk2HTXuDqA5JVnDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705920225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmC+DrXD0VE+1TM4mtYcFfIi/ngzxSqDf/3wGBo/yNk=;
	b=SqW+JgTpQS1X9tbcVdyVdCwzg24fBy0Y0CtYYC5dAisanj0Uu7HeD6ed4J1FLDbcqnBtu1
	z8JWfbMqtrkFxaNpAh4WOc9lwwQsF63CRRodKtAIsiLqullYRUJrK6/L6pubAMPK5KL7ex
	ZdPQxLyqRTaj/zkAvhOZX1xsiGsVoSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705920225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmC+DrXD0VE+1TM4mtYcFfIi/ngzxSqDf/3wGBo/yNk=;
	b=1JDCaYUAQOv8BxqBt+V5RA3AIYRPbXp9vv3R+rWza0yurYjU7OK3loX+yzawtLsNNHJXS4
	Wc1pRf99OCF9xGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E1B213995;
	Mon, 22 Jan 2024 10:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 245sA+FGrmVTDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jan 2024 10:43:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9D8CA0803; Mon, 22 Jan 2024 11:43:44 +0100 (CET)
Date: Mon, 22 Jan 2024 11:43:44 +0100
From: Jan Kara <jack@suse.cz>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com
Subject: Re: [PATCH] do_sys_name_to_handle(): use kzalloc() to fix
 kernel-infoleak
Message-ID: <20240122104344.egvhl4m4xiakuq55@quack3>
References: <20240119153906.4367-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119153906.4367-1-n.zhandarovich@fintech.ru>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SqW+JgTp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1JDCaYUA
X-Spamd-Result: default: False [-1.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[09b349b3066c2e0b1e96];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.com:email,oracle.com:email,fintech.ru:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,syzkaller.appspotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1D40D1F385
X-Spam-Level: 
X-Spam-Score: -1.31
X-Spam-Flag: NO

On Fri 19-01-24 07:39:06, Nikita Zhandarovich wrote:
> syzbot identified a kernel information leak vulnerability in
> do_sys_name_to_handle() and issued the following report [1].
> 
> [1]
> "BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _copy_to_user+0xbc/0x100 lib/usercopy.c:40
>  copy_to_user include/linux/uaccess.h:191 [inline]
>  do_sys_name_to_handle fs/fhandle.c:73 [inline]
>  __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
>  __se_sys_name_to_handle_at+0x949/0xb10 fs/fhandle.c:94
>  __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
>  ...
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3478 [inline]
>  __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
>  __do_kmalloc_node mm/slab_common.c:1006 [inline]
>  __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
>  kmalloc include/linux/slab.h:604 [inline]
>  do_sys_name_to_handle fs/fhandle.c:39 [inline]
>  __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
>  __se_sys_name_to_handle_at+0x441/0xb10 fs/fhandle.c:94
>  __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
>  ...
> 
> Bytes 18-19 of 20 are uninitialized
> Memory access of size 20 starts at ffff888128a46380
> Data copied to user address 0000000020000240"
> 
> Per Chuck Lever's suggestion, use kzalloc() instead of kmalloc() to
> solve the problem.
> 
> Fixes: 990d6c2d7aee ("vfs: Add name to file handle conversion support")
> Suggested-by: Chuck Lever III <chuck.lever@oracle.com>
> Reported-and-tested-by: syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Link to Chuck's suggestion: 
> https://lore.kernel.org/all/B4A8D625-6997-49C8-B105-B2DCFE8C6DDA@oracle.com/
> 
>  fs/fhandle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 18b3ba8dc8ea..57a12614addf 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -36,7 +36,7 @@ static long do_sys_name_to_handle(const struct path *path,
>  	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
>  		return -EINVAL;
>  
> -	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
> +	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
>  			 GFP_KERNEL);
>  	if (!handle)
>  		return -ENOMEM;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

