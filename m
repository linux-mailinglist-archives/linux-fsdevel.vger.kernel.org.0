Return-Path: <linux-fsdevel+bounces-62558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA527B99874
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7593AA914
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2D2E62C3;
	Wed, 24 Sep 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfBi+CGz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="grT3aDMy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfBi+CGz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="grT3aDMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8FE1A9F8D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711912; cv=none; b=RzvobDApQ9MBc8tjJGAMGalH1gVKNQK8mvUtFX746VFwNbBjnWc3vuJj/mWLMqZANjcYDQxfMQaneOg6UxrM19ppETXfPEq4a0m157X1zSpsw9XqtcIrcUcUhmgM7PaWSxBbPctWDVHCvxkS+rAEwNBAlnLirEHfEXb/1TFuZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711912; c=relaxed/simple;
	bh=8A5MmysxBhtmG5TdDxNcLAWj+kAlErz7UozgaIhk7AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcv4qVa1Cn6Tw1CkLH6Rz3FO9bAGwa2Jnc0OySSpvvhGUg5rZAKv0A951cS5TIm6cvksSxq0WwTShe2uyceG1em9X5XRp6z7yQ1h52glB+E4YhLlqn9hBMwso1ZAAFSBHen0UDjkBOQ7Dkf1kJL5PkfsYFiDlQFjKC2FwdvSmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfBi+CGz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=grT3aDMy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfBi+CGz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=grT3aDMy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F1BA33C4D;
	Wed, 24 Sep 2025 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758711904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IN730g8TVV3pXRYVV4cU5ljS04QgWjzQ/7HWfHgg/fY=;
	b=JfBi+CGzFoX1/os0W15NAGOv4NRE8Asz6VNN7TDWOHuN+8ogddwt8df7bQjgo1ynAXaL6n
	OtTiMWz+tHFLBwGBaRyngfGuNA/F1my0AUp54f0C5hy6pxCgtvYdEJ9CJH1u0gEcDNEsYg
	hNmiTFwrJpJN+0SXpRHTvtP1qHSLZuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758711904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IN730g8TVV3pXRYVV4cU5ljS04QgWjzQ/7HWfHgg/fY=;
	b=grT3aDMyg+m8kRfBET4t1nq4wtLBiRvAX633IJRDpNoTCHyR+uUaqf5fJ+TMWl8hd35txV
	LrymM7ZOqxy7yyAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758711904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IN730g8TVV3pXRYVV4cU5ljS04QgWjzQ/7HWfHgg/fY=;
	b=JfBi+CGzFoX1/os0W15NAGOv4NRE8Asz6VNN7TDWOHuN+8ogddwt8df7bQjgo1ynAXaL6n
	OtTiMWz+tHFLBwGBaRyngfGuNA/F1my0AUp54f0C5hy6pxCgtvYdEJ9CJH1u0gEcDNEsYg
	hNmiTFwrJpJN+0SXpRHTvtP1qHSLZuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758711904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IN730g8TVV3pXRYVV4cU5ljS04QgWjzQ/7HWfHgg/fY=;
	b=grT3aDMyg+m8kRfBET4t1nq4wtLBiRvAX633IJRDpNoTCHyR+uUaqf5fJ+TMWl8hd35txV
	LrymM7ZOqxy7yyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F14A013A61;
	Wed, 24 Sep 2025 11:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oyefOl/Q02h7NQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:05:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B167CA0A9A; Wed, 24 Sep 2025 13:05:03 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:05:03 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-security-module@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid
 context in hook_sb_delete
Message-ID: <fnxbqe3nlcptxqcs7tkt6qnacupkxu2xn4duwc6g6n2bk4tstb@hi2gl5cwishr>
References: <68d32659.a70a0220.4f78.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[12479ae15958fc3f54ec];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,appspotmail.com:email,goo.gl:url,googlegroups.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.30

Hello!

Added Landlock guys to CC since this is a bug in Landlock.

On Tue 23-09-25 15:59:37, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    ce7f1a983b07 Add linux-next specific files for 20250923
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=118724e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
> dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1376e27c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e78e2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c30be6f36c31/disk-ce7f1a98.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ae9ea347d4d8/vmlinux-ce7f1a98.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d59682a4f33c/bzImage-ce7f1a98.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at fs/inode.c:1928

The first catch from the new might_sleep() annotations in iput().

> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6028, name: syz.0.17
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz.0.17/6028:
>  #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
>  #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
>  #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
>  #1: ffff8880326bc998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #1: ffff8880326bc998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: hook_sb_delete+0xae/0xbd0 security/landlock/fs.c:1405
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 UID: 0 PID: 6028 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  __might_resched+0x495/0x610 kernel/sched/core.c:8960
>  iput+0x2b/0xc50 fs/inode.c:1928
>  hook_sb_delete+0x6b5/0xbd0 security/landlock/fs.c:1468

Indeed looks like a bug because we can call iput() while holding
sb->s_inode_list_lock in one case in hook_sb_delete().

								Honza

>  security_sb_delete+0x80/0x150 security/security.c:1467
>  generic_shutdown_super+0xaa/0x2c0 fs/super.c:634
>  kill_anon_super fs/super.c:1281 [inline]
>  kill_litter_super+0x76/0xb0 fs/super.c:1291
>  deactivate_locked_super+0xbc/0x130 fs/super.c:473
>  cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
>  task_work_run+0x1d4/0x260 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc08e18eec9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcd5efff18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007fc08e3e5fa0 RCX: 00007fc08e18eec9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000002c0
> RBP: 00007fc08e211f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc08e3e5fa0 R14: 00007fc08e3e5fa0 R15: 0000000000000002
>  </TASK>
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

