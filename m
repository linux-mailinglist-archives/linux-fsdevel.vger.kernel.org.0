Return-Path: <linux-fsdevel+bounces-45748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060CA7BAF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B7E3AEA3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB51DB127;
	Fri,  4 Apr 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wtvfVyF1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNaxwECt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wtvfVyF1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNaxwECt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22C1AAA1A
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762783; cv=none; b=AEnvBLxtqg49qoilQq9h5UoIX5vexj3y5FCwpgPBQsLCd3PLE503PHGYVppPiIXBqihvHrFpGBYc6+ILwsCAvKutN+5mP0zP9cLg5rnm0wUIESV4bk3t5Rvp5V8pVwJOpih5bPRqRNUuLXvt9AvwqxIZZHw2jBla6bcTy52d9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762783; c=relaxed/simple;
	bh=iIvZFKUo6HhC//luS8XmR1wJkVNAW0g10A8C29sCPWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgZWMDqD9btggDM8xhWE0JxWWb3IYUGZaIRHPib7yLHIhXKlVbQ4KFgivEoV3kjDYaWG4r2z/WcBaib4EsIEr3ESWVENQFgCq8/1WMCybbtqQCmUw4TuEM9d592IqNFERwfZDPF5Gj9z3/8XIYEzHJRkYp/EI44Vz+tP7fcoLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wtvfVyF1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNaxwECt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wtvfVyF1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNaxwECt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CCB81F385;
	Fri,  4 Apr 2025 10:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743762780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNIU3WIQ6pKBKbu8eUDqiDF++dbLxGd1edJKIVG9ftQ=;
	b=wtvfVyF1uqTp6CeKdjVGf9hR/SL8AaQXeg+zA5+E7Ibo12o76AsQ+Tzjx6TXgntPrsKv7/
	5mIdmg3f6JuxyYGjmc0lJ16YKNSIDEOgHuEGdeTSYaDeLceAZiHY5SFVU040EO0pPaEqjG
	E1KCg3vUjlcxn9tDenG+qboPS1jcvME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743762780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNIU3WIQ6pKBKbu8eUDqiDF++dbLxGd1edJKIVG9ftQ=;
	b=rNaxwECtXv9s5nLbHzHDbkc8jlD1PMK06gCppoL7owyHFRAcYnwWigIuxp4TikTCEABww8
	VmPpwsp5+1nrvoCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743762780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNIU3WIQ6pKBKbu8eUDqiDF++dbLxGd1edJKIVG9ftQ=;
	b=wtvfVyF1uqTp6CeKdjVGf9hR/SL8AaQXeg+zA5+E7Ibo12o76AsQ+Tzjx6TXgntPrsKv7/
	5mIdmg3f6JuxyYGjmc0lJ16YKNSIDEOgHuEGdeTSYaDeLceAZiHY5SFVU040EO0pPaEqjG
	E1KCg3vUjlcxn9tDenG+qboPS1jcvME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743762780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNIU3WIQ6pKBKbu8eUDqiDF++dbLxGd1edJKIVG9ftQ=;
	b=rNaxwECtXv9s5nLbHzHDbkc8jlD1PMK06gCppoL7owyHFRAcYnwWigIuxp4TikTCEABww8
	VmPpwsp5+1nrvoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CD351364F;
	Fri,  4 Apr 2025 10:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jt/TAly172cpIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Apr 2025 10:33:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BB372A07E6; Fri,  4 Apr 2025 12:32:59 +0200 (CEST)
Date: Fri, 4 Apr 2025 12:32:59 +0200
From: Jan Kara <jack@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+4d7cd7dd0ce1aa8d5c65@syzkaller.appspotmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] isofs: Prevent the use of too small fid
Message-ID: <5lnoza375x4ap3kaunr4w66j7e7eui6kowk72s67ky3wchd6uz@ek2pfltls6ss>
References: <67eee51c.050a0220.9040b.0240.GAE@google.com>
 <tencent_9C8CB8A7E7C6C512C7065DC98B6EDF6EC606@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9C8CB8A7E7C6C512C7065DC98B6EDF6EC606@qq.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[4d7cd7dd0ce1aa8d5c65];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Fri 04-04-25 13:31:29, Edward Adam Davis wrote:
> syzbot reported a slab-out-of-bounds Read in isofs_fh_to_parent. [1]
> 
> The handle_bytes value passed in by the reproducing program is equal to 12.
> In handle_to_path(), only 12 bytes of memory are allocated for the structure
> file_handle->f_handle member, which causes an out-of-bounds access when
> accessing the member parent_block of the structure isofs_fid in isofs,
> because accessing parent_block requires at least 16 bytes of f_handle.
> Here, fh_len is used to indirectly confirm that the value of handle_bytes
> is greater than 3 before accessing parent_block.
> 
> [1]
> BUG: KASAN: slab-out-of-bounds in isofs_fh_to_parent+0x1b8/0x210 fs/isofs/export.c:183
> Read of size 4 at addr ffff0000cc030d94 by task syz-executor215/6466
> CPU: 1 UID: 0 PID: 6466 Comm: syz-executor215 Not tainted 6.14.0-rc7-syzkaller-ga2392f333575 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0x198/0x550 mm/kasan/report.c:521
>  kasan_report+0xd8/0x138 mm/kasan/report.c:634
>  __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
>  isofs_fh_to_parent+0x1b8/0x210 fs/isofs/export.c:183
>  exportfs_decode_fh_raw+0x2dc/0x608 fs/exportfs/expfs.c:523
>  do_handle_to_path+0xa0/0x198 fs/fhandle.c:257
>  handle_to_path fs/fhandle.c:385 [inline]
>  do_handle_open+0x8cc/0xb8c fs/fhandle.c:403
>  __do_sys_open_by_handle_at fs/fhandle.c:443 [inline]
>  __se_sys_open_by_handle_at fs/fhandle.c:434 [inline]
>  __arm64_sys_open_by_handle_at+0x80/0x94 fs/fhandle.c:434
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> 
> Allocated by task 6466:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x40/0x78 mm/kasan/common.c:68
>  kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:562
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __do_kmalloc_node mm/slub.c:4294 [inline]
>  __kmalloc_noprof+0x32c/0x54c mm/slub.c:4306
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  handle_to_path fs/fhandle.c:357 [inline]
>  do_handle_open+0x5a4/0xb8c fs/fhandle.c:403
>  __do_sys_open_by_handle_at fs/fhandle.c:443 [inline]
>  __se_sys_open_by_handle_at fs/fhandle.c:434 [inline]
>  __arm64_sys_open_by_handle_at+0x80/0x94 fs/fhandle.c:434
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> 
> Reported-by: syzbot+4d7cd7dd0ce1aa8d5c65@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4d7cd7dd0ce1aa8d5c65
> Tested-by: syzbot+4d7cd7dd0ce1aa8d5c65@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Thanks! This is indeed an old bug :). Added to my tree.

								Honza

> ---
>  fs/isofs/export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/isofs/export.c b/fs/isofs/export.c
> index 35768a63fb1d..421d247fae52 100644
> --- a/fs/isofs/export.c
> +++ b/fs/isofs/export.c
> @@ -180,7 +180,7 @@ static struct dentry *isofs_fh_to_parent(struct super_block *sb,
>  		return NULL;
>  
>  	return isofs_export_iget(sb,
> -			fh_len > 2 ? ifid->parent_block : 0,
> +			fh_len > 3 ? ifid->parent_block : 0,
>  			ifid->parent_offset,
>  			fh_len > 4 ? ifid->parent_generation : 0);
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

