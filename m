Return-Path: <linux-fsdevel+bounces-19549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E28C6B2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 19:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8BE1C21EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAC3D388;
	Wed, 15 May 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aBDkZwEz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QUmdXHud";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aBDkZwEz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QUmdXHud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010FDDC7;
	Wed, 15 May 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792542; cv=none; b=j1XK6ABXGRkoZkKKWAnkKe1O7/yy+ndX5ljkf09XForROBZ7N067c8B35ZgsKuu9VJ5ysNBeGJV6CqMBHHBO6gm+niPSIOFQGoX9dwxsBeMl5s31qdqtpcUKuKV9cWCM0sOaezrIIsZiCyzM53+AFNECREr+iD1aavl8kc4BdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792542; c=relaxed/simple;
	bh=E5uF8oHkS7zkYx/5Kf0jAgtVGUPauFWEZYgmK+MbB2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io1dmr69fX09zgR8a2HErqP+vRRnRbyRpZHJ5QsDQ+az1Xpbz0jYKvjpxCvsCqLAc1Stwt75Ic8SBTCAYgZPI2/Qb0WYPQl2y0nuj7Nr/eyu001+XDo31eEUGl54H5v2+/udc5hZrYUaLm/O7aPDST/wRNpydU913GtAx21qquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aBDkZwEz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QUmdXHud; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aBDkZwEz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QUmdXHud; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4822C33D87;
	Wed, 15 May 2024 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715792538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLjtKjb/P3FY168ugmvr7swV+c4BM7FBAyUnwxZ80o8=;
	b=aBDkZwEzbj4sAkJqEw4MOeZMWUl+AK+yam2u0p/G/J1cAP55NpyMLwN8YiyhQN5crLLiYO
	+Pyc9LPKfY9n8xP5WpaxQxJZanhzNRDSVnVvuRVjxRj+G9PkpcG8JYiG35X85zW08bNCB7
	olnwyD5ZxKbAPEwowjjcesHhPRYTKvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715792538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLjtKjb/P3FY168ugmvr7swV+c4BM7FBAyUnwxZ80o8=;
	b=QUmdXHuduqWu9prgVCyOoQaVC/XIIvXGktr8av6z0tRtGfs4pKdUJV2DA+OZNnhAg5pNw9
	+f8ECxjEtIvZlsDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aBDkZwEz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QUmdXHud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715792538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLjtKjb/P3FY168ugmvr7swV+c4BM7FBAyUnwxZ80o8=;
	b=aBDkZwEzbj4sAkJqEw4MOeZMWUl+AK+yam2u0p/G/J1cAP55NpyMLwN8YiyhQN5crLLiYO
	+Pyc9LPKfY9n8xP5WpaxQxJZanhzNRDSVnVvuRVjxRj+G9PkpcG8JYiG35X85zW08bNCB7
	olnwyD5ZxKbAPEwowjjcesHhPRYTKvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715792538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLjtKjb/P3FY168ugmvr7swV+c4BM7FBAyUnwxZ80o8=;
	b=QUmdXHuduqWu9prgVCyOoQaVC/XIIvXGktr8av6z0tRtGfs4pKdUJV2DA+OZNnhAg5pNw9
	+f8ECxjEtIvZlsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28418136A8;
	Wed, 15 May 2024 17:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lDOtCZrqRGacAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 17:02:18 +0000
Date: Wed, 15 May 2024 19:02:16 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+e017b58b47bacf31a06b@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in mapping_try_invalidate
Message-ID: <20240515170216.GU4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000f6c32a0610c6af48@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f6c32a0610c6af48@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -1.71
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4822C33D87
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,storage.googleapis.com:url,suse.cz:dkim,suse.cz:replyto,appspotmail.com:email];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[e017b58b47bacf31a06b];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SUBJECT_HAS_QUESTION(0.00)[]

On Wed, Feb 07, 2024 at 12:43:22AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    99bd3cb0d12e Merge tag 'bcachefs-2024-02-05' of https://ev..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16629540180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
> dashboard link: https://syzkaller.appspot.com/bug?extid=e017b58b47bacf31a06b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/73aa72bd3577/disk-99bd3cb0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6c6bf1614995/vmlinux-99bd3cb0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7df252d11788/bzImage-99bd3cb0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e017b58b47bacf31a06b@syzkaller.appspotmail.com
> 
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:2072!

unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
{
	XA_STATE(xas, &mapping->i_pages, *start);
	struct folio *folio;

	rcu_read_lock();
	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
		if (!xa_is_value(folio)) {
			if (folio->index < *start)
				goto put;
			if (folio_next_index(folio) - 1 > end)
				goto put;
			if (!folio_trylock(folio))
				goto put;
			if (folio->mapping != mapping ||
			    folio_test_writeback(folio))
				goto unlock;
			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
					folio);

index out of range

> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 16388 Comm: syz-executor.2 Not tainted 6.8.0-rc3-syzkaller-00005-g99bd3cb0d12e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:find_lock_entries+0xfdf/0x1110 mm/filemap.c:2071
> Code: e8 96 4d cb ff eb 2a e8 8f 4d cb ff eb 3a e8 88 4d cb ff eb 4a e8 81 4d cb ff 4c 89 f7 48 c7 c6 a0 41 b3 8b e8 32 0f 10 00 90 <0f> 0b e8 6a 4d cb ff 4c 89 f7 48 c7 c6 a0 4b b3 8b e8 1b 0f 10 00
> RSP: 0018:ffffc90013457520 EFLAGS: 00010246
> RAX: f6dc7e6d18066c00 RBX: 0000000000000000 RCX: ffffc90013457303
> RDX: 0000000000000002 RSI: ffffffff8baac6e0 RDI: ffffffff8bfd93e0
> RBP: ffffc90013457670 R08: ffffffff8f842b6f R09: 1ffffffff1f0856d
> R10: dffffc0000000000 R11: fffffbfff1f0856e R12: ffffc900134575c0
> R13: ffffffffffffffff R14: ffffea0000b3c100 R15: ffffea0000b3c134
> FS:  00007f60b3b6e6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056197e1c4648 CR3: 000000007d35c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  mapping_try_invalidate+0x162/0x640 mm/truncate.c:499

>  open_ctree+0xa9c/0x2a00 fs/btrfs/disk-io.c:3220

An initial and unconditional

invalidate_bdev(fs_devices->latest_dev->bdev);

Looks like our block device structures are valid, so possibly the memory
related structures are wrong. Could be inherited from previous runs of
the reproducer or because of previous errors in the driver. The console
log has some IO errors and loop device size changes, that would point
towards loop device.

#syz set subsystems: block

