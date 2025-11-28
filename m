Return-Path: <linux-fsdevel+bounces-70140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D39AC91FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 13:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C434C514
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE62329368;
	Fri, 28 Nov 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q7Al2de8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h+NMel9n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sjld7bFU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+VOBCrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E83101BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332961; cv=none; b=hVubT0tBfI8hK/S7ozJcNYL/WDb1940XTk4LT3Xu7mTtA+EGXDTDC95p98AjqNt+KC9/hhdEOanFRxdjMMp54t4Q4N39LA0iDQnoK1J/7HJFD8rKYVImarKVPr6miaR6MvnG1O58Jfnw86Oj2HipFFxpuNrqOxmF2z1MMwSdsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332961; c=relaxed/simple;
	bh=VwGekKleXAzXxu9Cdej1o1BYZpHdCZIrh39d4N1oRi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLisa916M857l0rI4Vd3v+U0sglK+ll1eW8F1dj/IWfINTERjDVk4D3HGxCBpJdX5sFLHrxvm42slfsh0hi+JYQR3fAVOkMNcse1LcfEsgotiZ3i26KEvYBXdiau4k/GQK1ams3jb0i4U5BSQsJ/vS0UimItb/qzg+T3zVQi0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q7Al2de8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h+NMel9n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sjld7bFU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+VOBCrq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5052533700;
	Fri, 28 Nov 2025 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764332956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTg9wBRcNzrb4HPD3Op/drYG5tysr9zgi0O8R8q+NQw=;
	b=q7Al2de86g8GqHD70bI/PrgH2rHFoeamDv+dbk1I2MtpwOWD4RTpgjqM774ihwnemxw9Jr
	4zqbBSjSWsTf0kIJvVTPmYlUCBnht7vM5Lwa91uzKXVG3PyJidzWIhAi8Zyld3ZsVW2jR6
	C5Hb2q2Tl1qrSAuxGYfzhFnFhr3PGMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764332956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTg9wBRcNzrb4HPD3Op/drYG5tysr9zgi0O8R8q+NQw=;
	b=h+NMel9na32MZrWJuW21lp86K+hRO0qG8lqbO6F1QCrUBNdlWh5oIdEOQmJHKzb1hEnemd
	+4ECNMmbmG78p0DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Sjld7bFU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2+VOBCrq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764332955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTg9wBRcNzrb4HPD3Op/drYG5tysr9zgi0O8R8q+NQw=;
	b=Sjld7bFU1bZST7f7HS7IVh96cvqF/s1uv4WsJZMdwLllyOA5hXmbr5EbI9B1Q1fvhcbKAA
	wALpzKcRgxXhQMdQSfLQJObF1uwBlKg9Jd6kjknzVr393Jl4XQpSVIUv5W/fOwQUsl9JkJ
	akxBKjqERu0HYrBcCI4F7O4FP+FoiYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764332955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTg9wBRcNzrb4HPD3Op/drYG5tysr9zgi0O8R8q+NQw=;
	b=2+VOBCrqNHTW5jGdGpqyRGYliEOp0aWiyX0clsunpoly9e+XIMpG+MVta84u80sKJQykEI
	YYWZdlqYTn/z/OCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 365FF3EA63;
	Fri, 28 Nov 2025 12:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ArI+DZuVKWntaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Nov 2025 12:29:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E25F3A08BE; Fri, 28 Nov 2025 13:29:06 +0100 (CET)
Date: Fri, 28 Nov 2025 13:29:06 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+94048264da5715c251f9@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in mntput
Message-ID: <dh6c3iksktkus55r7qkr74rclftpmxj2lbwstcvxdzc3ql3vls@c7f5ctbhg2fn>
References: <6928c5c3.a70a0220.d98e3.011a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6928c5c3.a70a0220.d98e3.011a.GAE@google.com>
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bf77a4e0e3514deb];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,googlegroups.com:email,appspotmail.com:email,goo.gl:url];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[94048264da5715c251f9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Score: -1.51
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5052533700
X-Rspamd-Action: no action
X-Spam-Flag: NO

Hello,

On Thu 27-11-25 13:42:27, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    92fd6e84175b Add linux-next specific files for 20251125
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a55612580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf77a4e0e3514deb
> dashboard link: https://syzkaller.appspot.com/bug?extid=94048264da5715c251f9
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1215f612580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17082f42580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bee2604d495b/disk-92fd6e84.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b12aade49e2c/vmlinux-92fd6e84.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/286fd34158cb/bzImage-92fd6e84.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+94048264da5715c251f9@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000023: 0000 [#1] SMP KASAN PTI

This is caused by 67c68da01266d ("namespace: convert fsmount() to
FD_PREPARE()") and the problem is we do:

	struct path newmount __free(path_put) = {};

	...

	newmount.mnt = vfs_create_mount(fc);
	if (IS_ERR(newmount.mnt))
		return PTR_ERR(ns);

Which is not safe to do because path_put() unconditionally calls
mntput(path.mnt) which only has "if (mnt)" so it tries to put error
pointer.

There are several ways to fix this:

1) We can just add IS_ERR_OR_NULL(mnt) check to mntput(). It is convenient
but I know Al didn't like these wholesale IS_ERR_OR_NULL() checks because
they kind of hide occasional sloppy programming practices.

2) We can provide alternative for path_put() as a destructor which properly
deals with error pointers.

3) We can just store result of vfs_create_mount() in a temporary variable
and store the result in newmount after we verify it is valid.

I'm leaning towards 3) but what do other people think?

								Honza

> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
> CPU: 0 UID: 0 PID: 6414 Comm: syz.3.69 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:mntput+0x31/0xc0 fs/namespace.c:1430
> Code: 41 56 41 54 53 48 89 fb e8 1c da 7e ff 48 85 db 74 47 49 bf 00 00 00 00 00 fc ff df 4c 8d b3 24 01 00 00 4d 89 f4 49 c1 ec 03 <43> 0f b6 04 3c 84 c0 75 50 48 83 c3 e0 41 8b 2e 31 ff 89 ee e8 26
> RSP: 0018:ffffc9000462fd90 EFLAGS: 00010202
> RAX: ffffffff8242c664 RBX: fffffffffffffff4 RCX: ffff888077aa5b80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffff4
> RBP: ffffc9000462fed0 R08: ffff888077aa5b87 R09: 1ffff1100ef54b70
> R10: dffffc0000000000 R11: ffffed100ef54b71 R12: 0000000000000023
> R13: dffffc0000000000 R14: 0000000000000118 R15: dffffc0000000000
> FS:  00007fdf2c77f6c0(0000) GS:ffff888125e8b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555575df7808 CR3: 0000000076002000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __do_sys_fsmount fs/namespace.c:4380 [inline]
>  __se_sys_fsmount+0x893/0xa90 fs/namespace.c:4279
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdf2b98f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdf2c77f038 EFLAGS: 00000246 ORIG_RAX: 00000000000001b0
> RAX: ffffffffffffffda RBX: 00007fdf2bbe6180 RCX: 00007fdf2b98f749
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 00007fdf2ba13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fdf2bbe6218 R14: 00007fdf2bbe6180 R15: 00007ffd8048bbc8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:mntput+0x31/0xc0 fs/namespace.c:1430
> Code: 41 56 41 54 53 48 89 fb e8 1c da 7e ff 48 85 db 74 47 49 bf 00 00 00 00 00 fc ff df 4c 8d b3 24 01 00 00 4d 89 f4 49 c1 ec 03 <43> 0f b6 04 3c 84 c0 75 50 48 83 c3 e0 41 8b 2e 31 ff 89 ee e8 26
> RSP: 0018:ffffc9000462fd90 EFLAGS: 00010202
> RAX: ffffffff8242c664 RBX: fffffffffffffff4 RCX: ffff888077aa5b80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffff4
> RBP: ffffc9000462fed0 R08: ffff888077aa5b87 R09: 1ffff1100ef54b70
> R10: dffffc0000000000 R11: ffffed100ef54b71 R12: 0000000000000023
> R13: dffffc0000000000 R14: 0000000000000118 R15: dffffc0000000000
> FS:  00007fdf2c77f6c0(0000) GS:ffff888125f8b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd4a51d5e8 CR3: 0000000076002000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>    0:	41 56                	push   %r14
>    2:	41 54                	push   %r12
>    4:	53                   	push   %rbx
>    5:	48 89 fb             	mov    %rdi,%rbx
>    8:	e8 1c da 7e ff       	call   0xff7eda29
>    d:	48 85 db             	test   %rbx,%rbx
>   10:	74 47                	je     0x59
>   12:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
>   19:	fc ff df
>   1c:	4c 8d b3 24 01 00 00 	lea    0x124(%rbx),%r14
>   23:	4d 89 f4             	mov    %r14,%r12
>   26:	49 c1 ec 03          	shr    $0x3,%r12
> * 2a:	43 0f b6 04 3c       	movzbl (%r12,%r15,1),%eax <-- trapping instruction
>   2f:	84 c0                	test   %al,%al
>   31:	75 50                	jne    0x83
>   33:	48 83 c3 e0          	add    $0xffffffffffffffe0,%rbx
>   37:	41 8b 2e             	mov    (%r14),%ebp
>   3a:	31 ff                	xor    %edi,%edi
>   3c:	89 ee                	mov    %ebp,%esi
>   3e:	e8                   	.byte 0xe8
>   3f:	26                   	es
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

