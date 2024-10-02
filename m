Return-Path: <linux-fsdevel+bounces-30694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD03898D697
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869C2284527
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5EC1D0B88;
	Wed,  2 Oct 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TnzRLz4w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2EB3bn2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TnzRLz4w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2EB3bn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F01D0799;
	Wed,  2 Oct 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876448; cv=none; b=dCcpqE3+p6X+b+OiWotYevA61hKflERhVjVa2CsuLvQ36wb++6GLLdLbqLI0dFY3YdZ9Ff8v3Ro7VhvtdB304JLUDptNfHkdItY6zZTW4Bk12xieyi8SO2RMabXgjbXEr20/wvx5RtX/j7TgeMiqvULnZSXf2YHVa/TTrzu921c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876448; c=relaxed/simple;
	bh=jZLPez61J5wMwXMokqI09G0R/ctDuFExVER5WYtsa7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tESCzqOrA/8M3ks8m0FHb7R+6HObo9KiLi0Ll+XumW2uODA8j8xzlUJ1cfjEO9IA0kKbWNDwUue4uc/1Z03iKI8NA0MBv/MzvnoLOZdtcgUfqQvd3cyURCuzUmWgerCK+sbSbQLucsvn7QphZW32a1LUVBi1152TYqKzdqE3QG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TnzRLz4w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2EB3bn2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TnzRLz4w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2EB3bn2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 382071FD63;
	Wed,  2 Oct 2024 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727876444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qN4jdMdYc3XrKwX0MrXijGkE/HH5JkxIjoq4ke+SNt4=;
	b=TnzRLz4wyBRrAd/SRoVhfy79zNrs0HGerb4290Wa41zekCbCvDy4L9rxcnZ+mXvugbfFTX
	KCLJTSlrLOWlrQAXblhefVK2oWRLMQ3VUyhU+nQLT6EyC+NeOc/Yoop6Cu4sYevnELBi2D
	9P/+c8y6owZak/YRNt7s7ghKItcB+Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727876444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qN4jdMdYc3XrKwX0MrXijGkE/HH5JkxIjoq4ke+SNt4=;
	b=E2EB3bn2CHboFzcxEQ5RrhbOjVJ8rMRz6+NPt6ePzB1JvQNHQjmk3I9GiR2kSwfAbBfEbN
	CLZmd2ExkWya1uCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727876444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qN4jdMdYc3XrKwX0MrXijGkE/HH5JkxIjoq4ke+SNt4=;
	b=TnzRLz4wyBRrAd/SRoVhfy79zNrs0HGerb4290Wa41zekCbCvDy4L9rxcnZ+mXvugbfFTX
	KCLJTSlrLOWlrQAXblhefVK2oWRLMQ3VUyhU+nQLT6EyC+NeOc/Yoop6Cu4sYevnELBi2D
	9P/+c8y6owZak/YRNt7s7ghKItcB+Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727876444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qN4jdMdYc3XrKwX0MrXijGkE/HH5JkxIjoq4ke+SNt4=;
	b=E2EB3bn2CHboFzcxEQ5RrhbOjVJ8rMRz6+NPt6ePzB1JvQNHQjmk3I9GiR2kSwfAbBfEbN
	CLZmd2ExkWya1uCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AA0913974;
	Wed,  2 Oct 2024 13:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJJhClxN/WacIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Oct 2024 13:40:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D4080A08CB; Wed,  2 Oct 2024 15:40:43 +0200 (CEST)
Date: Wed, 2 Oct 2024 15:40:43 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [syzbot] [jfs?] KASAN: null-ptr-deref Read in drop_buffers (3)
Message-ID: <20241002134043.4wyvsahhhsrtem2g@quack3>
References: <66fcb7f9.050a0220.f28ec.04e8.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fcb7f9.050a0220.f28ec.04e8.GAE@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[de1498ff3a934ac5e8b4];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 01-10-24 20:03:21, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b18307980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=de1498ff3a934ac5e8b4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10718307980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f3939f980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e32cde8d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9c681f5609bc/vmlinux-e32cde8d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/00b4d54de1d9/bzImage-e32cde8d.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/14b0b7eafa4c/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2881 [inline]
> BUG: KASAN: null-ptr-deref in drop_buffers+0x6f/0x710 fs/buffer.c:2893
> Read of size 4 at addr 0000000000000060 by task kswapd0/74

Weird. This shows bh has been NULL in drop_buffers() which can happen only
when the buffer_head circular list on the page has been corrupted
(otherwise page_buffers() would have BUGed earlier). The reproducer does
only mount of JFS and FAT filesystems so likely suitably corrupted
filesystem for one of these is causing memory corruption. Added relevant
maintainers to CC to have a look.

								Honza

> CPU: 0 UID: 0 PID: 74 Comm: kswapd0 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_report+0xe8/0x550 mm/kasan/report.c:491
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>  buffer_busy fs/buffer.c:2881 [inline]
>  drop_buffers+0x6f/0x710 fs/buffer.c:2893
>  try_to_free_buffers+0x295/0x5f0 fs/buffer.c:2947
>  shrink_folio_list+0x240c/0x8cc0 mm/vmscan.c:1432
>  evict_folios+0x549b/0x7b50 mm/vmscan.c:4583
>  try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4778
>  shrink_one+0x3b9/0x850 mm/vmscan.c:4816
>  shrink_many mm/vmscan.c:4879 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4957 [inline]
>  shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
>  kswapd_shrink_node mm/vmscan.c:6765 [inline]
>  balance_pgdat mm/vmscan.c:6957 [inline]
>  kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

