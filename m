Return-Path: <linux-fsdevel+bounces-63171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB7BB04B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096EA19462E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F921CC43;
	Wed,  1 Oct 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tUYyUvKo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tq6tqG82";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0QUtbbC8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+ouw00QD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AAC1E3DDE
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320945; cv=none; b=JmuDcbt+ExErFkSh5zjQsDKCAPi9WI3/Ejpn0MbZ4q8vqUNLodW2O5ansry/d11mh0JBUnRvTXkByPBUhzaHeXOFp9HS+XrEI7fa7X4MKwgQGdZL8cKfANiQYjrBSRB4eQJHqXNlEojmz3rzkPv9GuvzTyvXrg8Fe7NA1Ne9li0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320945; c=relaxed/simple;
	bh=Ug0SoXvIAOQxVCaHdHL2z7cZsNpGQXTPQ8N5oIwsgyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq0gs9ha90DnhNp0p+qyk9mTpGCKR8vf5iF5reMqEAL64+OYi/yqYNfyKOg8vaoiB8s0kobdIhmztvYh7XanLFH4B1wA5uSPdpx4hUdD29OuNxnqIch34jIlgBnHVDT9DY1JF6Qnr/wNNh/btjHB+Lv74uRUobW2IpXok5XI7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tUYyUvKo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tq6tqG82; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0QUtbbC8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+ouw00QD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F182A1FD9D;
	Wed,  1 Oct 2025 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759320918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFi5Fj1xOeCOIglDwmt3tluJPzzYn8OSotgbNMb/9xA=;
	b=tUYyUvKon9bCy30ai2OGqoJ2Nne1uHiVU23pzSlcdl1vT7kCZDCgtryVdNBffKCpmd4q6k
	hgMMS3weUDdtB6NaG31/JT41Udjd/lSUWKGRHhW+AQ7x3MFcJUPn4yyw48eqh8Br8nuejr
	0PAeHo7JKjUDgzdiBnjA+YpF/SeewJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759320918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFi5Fj1xOeCOIglDwmt3tluJPzzYn8OSotgbNMb/9xA=;
	b=tq6tqG822OuSRE3mAl63Xq1pGTVWsH7FLo+BJ+OxE3WHRc3PVAcxsyjPe3XDcrTuSe/lHe
	G3b4XPFfSzJDiEDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0QUtbbC8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+ouw00QD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759320917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFi5Fj1xOeCOIglDwmt3tluJPzzYn8OSotgbNMb/9xA=;
	b=0QUtbbC8n1oGFpQYh7EA3VT7W9wuaeR/wdRwmAYI0flYDp17lpHK38eHdSc0cXj7uIbDQS
	Nm1b2ZEbEZ8Z2MOCFa4NElZMoLfJT9+n3LOc/w2pGMY9LlO0mzMSeya8LbLQ9WUQXbzGtl
	+Xa5L7LgRpxSWu2S4QhLuFxMSEkRAAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759320917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFi5Fj1xOeCOIglDwmt3tluJPzzYn8OSotgbNMb/9xA=;
	b=+ouw00QDE8qkOcRRVK600666U6Wi+LcgFW4i9Rb1y25jAry0zQ3ddDQdptwORO/q6X/wcB
	moV2/Ghhph/XjmCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C7F413A42;
	Wed,  1 Oct 2025 12:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9aeOFlQb3WjDeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 12:15:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E898A0A2D; Wed,  1 Oct 2025 14:15:11 +0200 (CEST)
Date: Wed, 1 Oct 2025 14:15:11 +0200
From: Jan Kara <jack@suse.cz>
To: Jakub Acs <acsjakub@amazon.de>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/notify: call exportfs_encode_fid with s_umount
Message-ID: <e4o5wuh2h7viev2khbr7excdm7xv6ubw3va55e56q4apjno62s@hu3ybnftbhhz>
References: <20251001100955.59634-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001100955.59634-1-acsjakub@amazon.de>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com,szeredi.hu,kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,amazon.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: F182A1FD9D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 01-10-25 10:09:55, Jakub Acs wrote:
> Calling intotify_show_fdinfo() on fd watching an overlayfs inode, while
> the overlayfs is being unmounted, can lead to dereferencing NULL ptr.
> 
> This issue was found by syzkaller.
> 
> Race Condition Diagram:
> 
> Thread 1                           Thread 2
> --------                           --------
> 
> generic_shutdown_super()
>  shrink_dcache_for_umount
>   sb->s_root = NULL
> 
>                     |
>                     |             vfs_read()
>                     |              inotify_fdinfo()
>                     |               * inode get from mark *
>                     |               show_mark_fhandle(m, inode)
>                     |                exportfs_encode_fid(inode, ..)
>                     |                 ovl_encode_fh(inode, ..)
>                     |                  ovl_check_encode_origin(inode)
>                     |                   * deref i_sb->s_root *
>                     |
>                     |
>                     v
>  fsnotify_sb_delete(sb)
> 
> Which then leads to:
> 
> [   32.133461] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   32.134438] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> [   32.135032] CPU: 1 UID: 0 PID: 4468 Comm: systemd-coredum Not tainted 6.17.0-rc6 #22 PREEMPT(none)
> 
> <snip registers, unreliable trace>
> 
> [   32.143353] Call Trace:
> [   32.143732]  ovl_encode_fh+0xd5/0x170
> [   32.144031]  exportfs_encode_inode_fh+0x12f/0x300
> [   32.144425]  show_mark_fhandle+0xbe/0x1f0
> [   32.145805]  inotify_fdinfo+0x226/0x2d0
> [   32.146442]  inotify_show_fdinfo+0x1c5/0x350
> [   32.147168]  seq_show+0x530/0x6f0
> [   32.147449]  seq_read_iter+0x503/0x12a0
> [   32.148419]  seq_read+0x31f/0x410
> [   32.150714]  vfs_read+0x1f0/0x9e0
> [   32.152297]  ksys_read+0x125/0x240
> 
> IOW ovl_check_encode_origin derefs inode->i_sb->s_root, after it was set
> to NULL in the unmount path.
> 
> Fix it by protecting calling exportfs_encode_fid() from
> show_mark_fhandle() with s_umount lock.
> 
> This form of fix was suggested by Amir in [1].
> 
> [1]: https://lore.kernel.org/all/CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com/
> 
> Fixes: c45beebfde34 ("ovl: support encoding fid from inode with no alias")
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
> 
> This issue was already discussed in [1] with no consensus reached on the
> fix.
> 
> This form was suggested as a band-aid fix, without explicity yes/no
> reaction. Hence reviving the discussion around the band-aid.

FWIW I'm working on a proper fix. But it's a larger rework so it will take
some time to settle. For the time being, since this seems to happen in
practical workloads, I guess we can live with this workaround so I'll pick
this patch, add some comment about band-aid into the code and push it to
Linus. Thanks!

								Honza

> 
>  fs/notify/fdinfo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 1161eabf11ee..9cc7eb863643 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -17,6 +17,7 @@
>  #include "fanotify/fanotify.h"
>  #include "fdinfo.h"
>  #include "fsnotify.h"
> +#include "../internal.h"
>  
>  #if defined(CONFIG_PROC_FS)
>  
> @@ -46,7 +47,12 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>  
>  	size = f->handle_bytes >> 2;
>  
> +	if (!super_trylock_shared(inode->i_sb))
> +		return;
> +
>  	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
> +	up_read(&inode->i_sb->s_umount);
> +
>  	if ((ret == FILEID_INVALID) || (ret < 0))
>  		return;
>  
> -- 
> 2.47.3
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

