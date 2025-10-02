Return-Path: <linux-fsdevel+bounces-63214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1260FBB2C5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9903424667
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A32C026D;
	Thu,  2 Oct 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="twgSRhSh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SqDj7+MA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="twgSRhSh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SqDj7+MA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC82BE641
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392489; cv=none; b=HcWZqoDiLAgh2vTh4mErobHiRm5C4yFQt11lnzi+u87wKJmmX7CJiq/KJ4N5psDHXE0pCxAkPNDRWGVs6SKH5SeKL8P/tgg3BrmrzYwHMDUW5MXDx8zExuOcnX4nDOxo/Uju9YDhNWyOexQVqefvFUW1+uRfS9BYiYJQZ4eIwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392489; c=relaxed/simple;
	bh=0+Bd8buq7omn/dPfsu0y3k+1rTSOidK70j0QI9MTbq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JllfW7eFzzOVn4iwVtdmvJ4LyRV5GkKDBzXa7AnXnR8bJHI5h/8hG8kKVHqwh1Ps9UusgLXCoNihgRp/j91WAk/IMm+hABfzLgH4crsbYspN82rYifi3f2B/siOtVYbWnkhIJ37wGfNYWnSgQn6haWfohnp7JM8hMBAQNhya/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=twgSRhSh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SqDj7+MA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=twgSRhSh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SqDj7+MA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B336A337ED;
	Thu,  2 Oct 2025 08:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmTkvnT5urNTb1v31JYgN8MHhWJrhisWDWciie9nWcQ=;
	b=twgSRhShIkb8T3lAQxMiIopvfFDo5nJUVGhkYS1CaRIwAwslNmBkOuhdDVlY0XYYZ3l/rY
	VKTi6OIvo36BNtvH6yFsNwoRJ7g2prVo26702fQZQAdJ1FJFjr/HtblBnSgZBXkceKoZi6
	UqldDsR8UL6knkl+cLLkoCnWO0gMjWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmTkvnT5urNTb1v31JYgN8MHhWJrhisWDWciie9nWcQ=;
	b=SqDj7+MAty16vj4RmOFxvajDx2TCnbsRNCPIYuCgPEDctpStd1FzmwiU0+7IvpKptZySFg
	CfdS+gNCPaSGCxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmTkvnT5urNTb1v31JYgN8MHhWJrhisWDWciie9nWcQ=;
	b=twgSRhShIkb8T3lAQxMiIopvfFDo5nJUVGhkYS1CaRIwAwslNmBkOuhdDVlY0XYYZ3l/rY
	VKTi6OIvo36BNtvH6yFsNwoRJ7g2prVo26702fQZQAdJ1FJFjr/HtblBnSgZBXkceKoZi6
	UqldDsR8UL6knkl+cLLkoCnWO0gMjWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmTkvnT5urNTb1v31JYgN8MHhWJrhisWDWciie9nWcQ=;
	b=SqDj7+MAty16vj4RmOFxvajDx2TCnbsRNCPIYuCgPEDctpStd1FzmwiU0+7IvpKptZySFg
	CfdS+gNCPaSGCxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F7C1395B;
	Thu,  2 Oct 2025 08:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t7YBKN4y3mg7TwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 08:07:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55E76A0A56; Thu,  2 Oct 2025 10:07:58 +0200 (CEST)
Date: Thu, 2 Oct 2025 10:07:58 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, chao@kernel.org, dan.j.williams@intel.com, 
	jack@suse.cz, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org, xiang@kernel.org
Subject: Re: [syzbot] [erofs?] WARNING in dax_iomap_rw
Message-ID: <aiji665th2iqsrwedypd2zw3guzykottzooslqja66tj4aqcr3@2hpzlh6ut4xp>
References: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ee1d7eda39c03d2c];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[47680984f2d4969027ea];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

Hello,

On Wed 01-10-25 17:10:33, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136ee6e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ee1d7eda39c03d2c
> dashboard link: https://syzkaller.appspot.com/bug?extid=47680984f2d4969027ea
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181036f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15875d04580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-50c19e20.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/33a22a854fe0/vmlinux-50c19e20.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e68f79994eb8/bzImage-50c19e20.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/71839d8fa466/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17630a7c580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 16
> erofs (device loop0): mounted with root inode @ nid 36.
> process 'syz.0.17' launched './file2' with NULL argv: empty string added
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5507 at fs/dax.c:1756 dax_iomap_rw+0xe34/0xed0 fs/dax.c:1756
> Modules linked in:

OK, this is a bit overzealous assert in dax_iomap_rw() which triggers for
erofs. I'll send a fix.

								Honza

> CPU: 0 UID: 0 PID: 5507 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:dax_iomap_rw+0xe34/0xed0 fs/dax.c:1756
> Code: ff ff 49 bd 00 00 00 00 00 fc ff df eb 84 e8 33 d7 6f ff 90 0f 0b 90 80 8c 24 c4 01 00 00 01 e9 b9 f4 ff ff e8 1d d7 6f ff 90 <0f> 0b 90 e9 ab f4 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 56 f3
> RSP: 0018:ffffc9000296f840 EFLAGS: 00010293
> RAX: ffffffff824eae63 RBX: ffffc9000296fc00 RCX: ffff88801f938000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000296fb30 R08: ffffc9000296fa9f R09: 0000000000000000
> R10: ffffc9000296f9f8 R11: fffff5200052df54 R12: 1ffff9200052df80
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000001
> FS:  0000555575829500(0000) GS:ffff88808d967000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f41f4179286 CR3: 0000000050011000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  __kernel_read+0x4cc/0x960 fs/read_write.c:530
>  prepare_binprm fs/exec.c:1609 [inline]
>  search_binary_handler fs/exec.c:1656 [inline]
>  exec_binprm fs/exec.c:1702 [inline]
>  bprm_execve+0x8ce/0x1450 fs/exec.c:1754
>  do_execveat_common+0x510/0x6a0 fs/exec.c:1860
>  do_execveat fs/exec.c:1945 [inline]
>  __do_sys_execveat fs/exec.c:2019 [inline]
>  __se_sys_execveat fs/exec.c:2013 [inline]
>  __x64_sys_execveat+0xc4/0xe0 fs/exec.c:2013
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7556f8eec9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffea3815728 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
> RAX: ffffffffffffffda RBX: 00007f75571e5fa0 RCX: 00007f7556f8eec9
> RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
> RBP: 00007f7557011f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f75571e5fa0 R14: 00007f75571e5fa0 R15: 0000000000000005
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

