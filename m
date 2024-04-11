Return-Path: <linux-fsdevel+bounces-16741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846968A1F76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 21:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EF81C2358F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC9168B1;
	Thu, 11 Apr 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NXai15Yc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cYarYQZN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NXai15Yc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cYarYQZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECD13FFC;
	Thu, 11 Apr 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863528; cv=none; b=UX7eohrmQfMPQEZeLfexb+NUaVXCXlhNAJUb8WXs4IQlzrzn4IT8cLjfCpq4kMQI5NbdyBi/V9dfgzoxxSSnW7zWLMFzxN6eW9gUHNFrGtMhrCsG/B8FC64a5pBsyqxaDInWCOPvnWQrkgKOETYP8CM0tne2yjbOyuQg4UlrYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863528; c=relaxed/simple;
	bh=RksIQbExvaCJUcl0G0CcojxzWfnl6xUQsFg4B3A8VxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEb3n4FIVYCLSXbYEAwPy9ci73VZynGCAX2o4w6T9Ah+Nrz3MFGZGG+hkqYCmf/Z2stvFFKvQjTqOJjelB+y7tbQoPgRHdL+5pafSr0f0lx4AVRa2LdbLBg0pXFbjYwImwjJegb7bXr9cAMrnuSmRoS7HV+SwPfj6yffj6hT1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NXai15Yc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cYarYQZN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NXai15Yc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cYarYQZN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A747B5D430;
	Thu, 11 Apr 2024 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712863523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCHGpeVSvZ41S2YiaygRkdmX2r+S8qFcFRruOh3fP68=;
	b=NXai15YcYjFYP8nF3KNJin/UlgLz6V+g04lF0JS8rUIaAEqdkG+o1iAi2WYuUysrSNW28E
	y3xM1tVsDCK+nPftORBjO/9k35B+nLFgfIOexwOzXZXClqwfLC2ziaI+qXgm+shTXtij77
	0Ohp7hQk3hvKIZ/Hlp6CE8apUan6oQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712863523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCHGpeVSvZ41S2YiaygRkdmX2r+S8qFcFRruOh3fP68=;
	b=cYarYQZNFNpy4leSIBv43g9d6QSQkgzXwZE/8pKybhzZ7TLpKQTIE8eLfZ9y1SVcwM30VQ
	MiaYmv+vxrvaenAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NXai15Yc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cYarYQZN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712863523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCHGpeVSvZ41S2YiaygRkdmX2r+S8qFcFRruOh3fP68=;
	b=NXai15YcYjFYP8nF3KNJin/UlgLz6V+g04lF0JS8rUIaAEqdkG+o1iAi2WYuUysrSNW28E
	y3xM1tVsDCK+nPftORBjO/9k35B+nLFgfIOexwOzXZXClqwfLC2ziaI+qXgm+shTXtij77
	0Ohp7hQk3hvKIZ/Hlp6CE8apUan6oQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712863523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCHGpeVSvZ41S2YiaygRkdmX2r+S8qFcFRruOh3fP68=;
	b=cYarYQZNFNpy4leSIBv43g9d6QSQkgzXwZE/8pKybhzZ7TLpKQTIE8eLfZ9y1SVcwM30VQ
	MiaYmv+vxrvaenAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 566B413685;
	Thu, 11 Apr 2024 19:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OiHpCCM5GGZuJgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 11 Apr 2024 19:25:23 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,  syzbot
 <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>,
  linux-ext4@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  repnop@google.com,
  syzkaller-bugs@googlegroups.com, khazhy@chromium.org
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
In-Reply-To: <CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com>
	(Amir Goldstein's message of "Thu, 11 Apr 2024 19:07:00 +0300")
Organization: SUSE
References: <00000000000042c9190615cdb315@google.com>
	<20240411121319.adhz4ylacbv6ocuu@quack3>
	<CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com>
Date: Thu, 11 Apr 2024 15:25:21 -0400
Message-ID: <875xwn8zxa.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=16ca158ef7e08662];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	TAGGED_RCPT(0.00)[5e3f9b2a67b45f16d4e6];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A747B5D430
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.01

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, Apr 11, 2024 at 3:13=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>>
>> On Thu 11-04-24 01:11:20, syzbot wrote:
>> > Hello,
>> >
>> > syzbot found the following issue on:
>> >
>> > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
>> > git tree:       linux-next
>> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12be955d18=
0000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D16ca158ef7=
e08662
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3f9b2a67b4=
5f16d4e6
>> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for =
Debian) 2.40
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c91175=
180000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d18=
0000
>> >
>> > Downloadable assets:
>> > disk image: https://storage.googleapis.com/syzbot-assets/b050f81f73ed/=
disk-6ebf211b.raw.xz
>> > vmlinux: https://storage.googleapis.com/syzbot-assets/412c9b9a536e/vml=
inux-6ebf211b.xz
>> > kernel image: https://storage.googleapis.com/syzbot-assets/016527216c4=
7/bzImage-6ebf211b.xz
>> > mounted in repro: https://storage.googleapis.com/syzbot-assets/75ad050=
c9945/mount_0.gz
>> >
>> > IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
>> > Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
>> >
>> > Quota error (device loop0): do_check_range: Getting block 0 out of ran=
ge 1-5
>> > EXT4-fs error (device loop0): ext4_release_dquot:6905: comm kworker/u8=
:4: Failed to release dquot type 1
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > BUG: KASAN: slab-use-after-free in fsnotify+0x2a4/0x1f70 fs/notify/fsn=
otify.c:539
>> > Read of size 8 at addr ffff88802f1dce80 by task kworker/u8:4/62
>> >
>> > CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.9.0-rc3-next-20240410-=
syzkaller #0
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 03/27/2024
>> > Workqueue: events_unbound quota_release_workfn
>> > Call Trace:
>> >  <TASK>
>> >  __dump_stack lib/dump_stack.c:88 [inline]
>> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>> >  print_address_description mm/kasan/report.c:377 [inline]
>> >  print_report+0x169/0x550 mm/kasan/report.c:488
>> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
>> >  fsnotify+0x2a4/0x1f70 fs/notify/fsnotify.c:539
>> >  fsnotify_sb_error include/linux/fsnotify.h:456 [inline]
>> >  __ext4_error+0x255/0x3b0 fs/ext4/super.c:843
>> >  ext4_release_dquot+0x326/0x450 fs/ext4/super.c:6903
>> >  quota_release_workfn+0x39f/0x650 fs/quota/dquot.c:840
>> >  process_one_work kernel/workqueue.c:3218 [inline]
>> >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>> >  kthread+0x2f0/0x390 kernel/kthread.c:389
>> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>> >  </TASK>
>>
>> Amir, I believe this happens on umount when the filesystem calls
>> fsnotify_sb_error() after calling fsnotify_sb_delete(). In theory these =
two
>> calls can even run in parallel and fsnotify() can be holding
>> fsnotify_sb_info pointer while fsnotify_sb_delete() is freeing it so we
>> need to figure out some proper synchronization for that...
>
> Is it really needed to handle any for non SB_ACTIVE sb?

I think it should be fine to exclude volumes being teared down.  Cc'ing
Khazhy, who sponsored this work at the time and owned the use-case.

--=20
Gabriel Krisman Bertazi

