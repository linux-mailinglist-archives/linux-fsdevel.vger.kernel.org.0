Return-Path: <linux-fsdevel+bounces-43082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A59A4DBD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4E31630E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC741FECAC;
	Tue,  4 Mar 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlJMINsy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sYccBKaJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlJMINsy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sYccBKaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4681FCF60
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086422; cv=none; b=RWRnUKiN6+3qoy7pDy6jXCYDl7EZzH90VkRf3yNiPtMD8Vxoz1PnMHm+aLx+a1Vq9BzFuY3vB0xT9cnw2Z7Fc7qhOUqpaJJNgr4An196HmGWmBf2xs0t1DXOMIEOXFoICRmnZK5cNROkuacEBOgPPLOhqtAF2sXd/5uzcmqw0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086422; c=relaxed/simple;
	bh=8i20S32RfVyRRLepWWmbfWA2h5fpHsqa2owR7azEDnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvlZQS0wL8I5y/FjRNtKzwZ9dt4Q7qmbG2gJWnSm2lKeMJkhRIcIEi4ZjiJ4Dqj5BgbGKTORxiNByeCtr+Jv9oVaXRO0St3XjVCFqk2NIqhZfnI/9VLhpz+reodzFurPITvNyP8W8Ct/lOfn7HeZ/D2gBFCZwlTsTv7x+zJiH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlJMINsy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sYccBKaJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlJMINsy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sYccBKaJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 516CB1F393;
	Tue,  4 Mar 2025 11:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741086419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfUptBLw87//QQS3yhszHdPpQdoIdUVVfuqBEq+kkvw=;
	b=FlJMINsytySLtTAtSFpXKcbH/PSEGKlnPThfY+qfWGt15cRoC7HFwutb00OTD9DZJTxalx
	A+ij43tokAhtVavBIT9nXy+EEV9hhZC9iAahuxcRXgisw+/t90MjwIhEvzAYWv79MwACBM
	7a/P47fjlOfspxxy52jzYwXiWNRZzlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741086419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfUptBLw87//QQS3yhszHdPpQdoIdUVVfuqBEq+kkvw=;
	b=sYccBKaJr8foywehyQc7+YpIvKy2OVmlwnMP47wgIPMUO+ZWFfK+fLZz+L5DtY2pf9uemR
	GiVGQ0+mF5nOOeCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FlJMINsy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sYccBKaJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741086419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfUptBLw87//QQS3yhszHdPpQdoIdUVVfuqBEq+kkvw=;
	b=FlJMINsytySLtTAtSFpXKcbH/PSEGKlnPThfY+qfWGt15cRoC7HFwutb00OTD9DZJTxalx
	A+ij43tokAhtVavBIT9nXy+EEV9hhZC9iAahuxcRXgisw+/t90MjwIhEvzAYWv79MwACBM
	7a/P47fjlOfspxxy52jzYwXiWNRZzlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741086419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfUptBLw87//QQS3yhszHdPpQdoIdUVVfuqBEq+kkvw=;
	b=sYccBKaJr8foywehyQc7+YpIvKy2OVmlwnMP47wgIPMUO+ZWFfK+fLZz+L5DtY2pf9uemR
	GiVGQ0+mF5nOOeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 422BF13967;
	Tue,  4 Mar 2025 11:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qSUjENPexmefbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Mar 2025 11:06:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05DA3A0912; Tue,  4 Mar 2025 12:06:58 +0100 (CET)
Date: Tue, 4 Mar 2025 12:06:58 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	jack@suse.cz, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
Message-ID: <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com>
 <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
X-Rspamd-Queue-Id: 516CB1F393
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
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
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[7229071b47908b19d5b7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.dk,kernel.org,oracle.com,suse.cz,toxicpanda.com,vger.kernel.org,kvack.org,googlegroups.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

Josef, Amir,

this is indeed an interesting case:

On Sun 02-03-25 08:32:30, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
...
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:145 fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> Modules linked in:
> CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> sp : ffff8000a42569d0
> x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000d68a1708
> x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 0000000000008000
> x23: 0000000000000001 x22: ffff8000a4256b00 x21: 0000000000001000
> x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000a42566e0
> x17: 000000000000e388 x16: ffff800080466c24 x15: 0000000000000001
> x14: 1fffe0001b31513c x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000001000
> x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145 (P)
>  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
>  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
>  __do_fault+0xf8/0x498 mm/memory.c:4988
>  do_read_fault mm/memory.c:5403 [inline]
>  do_fault mm/memory.c:5537 [inline]
>  do_pte_missing mm/memory.c:4058 [inline]
>  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
>  __handle_mm_fault mm/memory.c:6043 [inline]
>  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
>  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
>  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
>  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
>  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
>  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-common.c:510
>  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
>  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inline] (P)
>  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
>  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
>  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
>  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-io.c:1039
>  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:792
>  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0x704/0xa9c fs/read_write.c:679

The backtrace actually explains it all. We had a buffered write whose
buffer was mmapped file on a filesystem with an HSM mark. Now the prefaulting
of the buffer happens already (quite deep) under the filesystem freeze
protection (obtained in vfs_write()) which breaks assumptions of HSM code
and introduces potential deadlock of HSM handler in userspace with filesystem
freezing. So we need to think how to deal with this case...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

