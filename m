Return-Path: <linux-fsdevel+bounces-7697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73356829789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0424B27A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C440C1F;
	Wed, 10 Jan 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hEJ8qMaO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7LFhnqDj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hEJ8qMaO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7LFhnqDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3A40BE1;
	Wed, 10 Jan 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6021F8AA;
	Wed, 10 Jan 2024 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704882196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WETjVolhji6G7lTfr0ieEjojcZP9xv2Ujf5NrqcwyQs=;
	b=hEJ8qMaOfNMyXJqGFa0jJFuMqxoT2rdFMMFOM1dabkvp+G2+IjUtrbIZ7rzGypgqHlFcBp
	2o2Lz2ucyXwjzKfzlJE/yeE2bpndxPLUAwRQX0Ck/CM5jNBrZBrWC1GMDPtQasM0s2pGKn
	pETh4nqxsM3hV1/vhH0pnfcQXRsXw4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704882196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WETjVolhji6G7lTfr0ieEjojcZP9xv2Ujf5NrqcwyQs=;
	b=7LFhnqDjj8tmEGWxzw/e88+jwCW7IDSl6p3zx0CLXRYPp56Id375IVa7PsOEJM8iRub2Fy
	EI0zr82zBwVTT7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704882196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WETjVolhji6G7lTfr0ieEjojcZP9xv2Ujf5NrqcwyQs=;
	b=hEJ8qMaOfNMyXJqGFa0jJFuMqxoT2rdFMMFOM1dabkvp+G2+IjUtrbIZ7rzGypgqHlFcBp
	2o2Lz2ucyXwjzKfzlJE/yeE2bpndxPLUAwRQX0Ck/CM5jNBrZBrWC1GMDPtQasM0s2pGKn
	pETh4nqxsM3hV1/vhH0pnfcQXRsXw4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704882196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WETjVolhji6G7lTfr0ieEjojcZP9xv2Ujf5NrqcwyQs=;
	b=7LFhnqDjj8tmEGWxzw/e88+jwCW7IDSl6p3zx0CLXRYPp56Id375IVa7PsOEJM8iRub2Fy
	EI0zr82zBwVTT7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BEAB13CB3;
	Wed, 10 Jan 2024 10:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EJSAFhRwnmXAagAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jan 2024 10:23:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B19ADA07EB; Wed, 10 Jan 2024 11:23:15 +0100 (CET)
Date: Wed, 10 Jan 2024 11:23:15 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+f13a9546e229c1a6e378@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de
Subject: Re: [syzbot] [reiserfs?] general protection fault in
 __hrtimer_run_queues (3)
Message-ID: <20240110102315.bmbpu7mx2kxczgz7@quack3>
References: <0000000000008023b805ff38a0af@google.com>
 <0000000000002fb443060e903163@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002fb443060e903163@google.com>
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hEJ8qMaO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7LFhnqDj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.45 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.04)[59.03%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4];
	 TAGGED_RCPT(0.00)[f13a9546e229c1a6e378];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 2.45
X-Rspamd-Queue-Id: 6E6021F8AA
X-Spam-Flag: NO

On Tue 09-01-24 20:52:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1730f285e80000
> start commit:   e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
> dashboard link: https://syzkaller.appspot.com/bug?extid=f13a9546e229c1a6e378
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1227af7b280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13803daf280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Quite likely since that commit stops syzbot from corrupting filesystem
while it is mounted.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

