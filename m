Return-Path: <linux-fsdevel+bounces-7809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED2D82B4EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 19:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBEE1C23E19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC054BE6;
	Thu, 11 Jan 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wy52FIvW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yq895Kaf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wy52FIvW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yq895Kaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656F42068;
	Thu, 11 Jan 2024 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05025220C2;
	Thu, 11 Jan 2024 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704999085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sj827Oy0dLrs9nkkRq5Ag0QiOI3PKN49Fz2TDvOicqM=;
	b=wy52FIvW+CtgGNtHDERO0/tXEdU7+QrmUfxJgmxmOzMDoBZ38dCOYmZnY58GT5QhzaRAMA
	poyxFbtmYmtW+ZyLvh91CTusE8pEqa3qP7mnBEvDgFZ0urdvrmqAG1KYTGYHNrkR0aT2H8
	3vNozGFjLyAQWc8nKHDrRK1uZbT/H1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704999085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sj827Oy0dLrs9nkkRq5Ag0QiOI3PKN49Fz2TDvOicqM=;
	b=yq895KafECOGtBV29JLlyW5haxoeE+Mc/e5YMVnOpLZ8LpNm2+pNbR5PCv6PvhXdvyNpym
	G36rATxmFreB6RBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704999085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sj827Oy0dLrs9nkkRq5Ag0QiOI3PKN49Fz2TDvOicqM=;
	b=wy52FIvW+CtgGNtHDERO0/tXEdU7+QrmUfxJgmxmOzMDoBZ38dCOYmZnY58GT5QhzaRAMA
	poyxFbtmYmtW+ZyLvh91CTusE8pEqa3qP7mnBEvDgFZ0urdvrmqAG1KYTGYHNrkR0aT2H8
	3vNozGFjLyAQWc8nKHDrRK1uZbT/H1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704999085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sj827Oy0dLrs9nkkRq5Ag0QiOI3PKN49Fz2TDvOicqM=;
	b=yq895KafECOGtBV29JLlyW5haxoeE+Mc/e5YMVnOpLZ8LpNm2+pNbR5PCv6PvhXdvyNpym
	G36rATxmFreB6RBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6310132CF;
	Thu, 11 Jan 2024 18:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CZryN6w4oGWpegAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Jan 2024 18:51:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 834FBA0807; Thu, 11 Jan 2024 19:51:24 +0100 (CET)
Date: Thu, 11 Jan 2024 19:51:24 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+3779764ddb7a3e19437f@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, axboe@kernel.dk, bpf@vger.kernel.org,
	brauner@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	haoluo@google.com, hawk@kernel.org, jack@suse.cz,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	kuba@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, luto@kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, peterz@infradead.org,
	reiserfs-devel@vger.kernel.org, sdf@google.com, song@kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	tintinm2017@gmail.com, yhs@fb.com, yukuai3@huawei.com
Subject: Re: [syzbot] [bpf?] [reiserfs?] WARNING: locking bug in corrupted (2)
Message-ID: <20240111185124.ajlkmj4b2p57kbli@quack3>
References: <000000000000a4a46106002c5e42@google.com>
 <000000000000301d7e060eae2133@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000301d7e060eae2133@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.83 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.07)[62.78%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a];
	 TAGGED_RCPT(0.00)[3779764ddb7a3e19437f];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL3o6cafsyspy4quzngzwrpg9m)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,kernel.dk,vger.kernel.org,iogearbox.net,davemloft.net,google.com,suse.cz,gmail.com,linux.dev,infradead.org,googlegroups.com,linutronix.de,fb.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.83
X-Spam-Flag: NO

On Thu 11-01-24 08:35:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120430a5e80000
> start commit:   c17414a273b8 Merge tag 'sh-for-v6.5-tag1' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3779764ddb7a3e19437f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bbd544a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fd50b0a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks plausible.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

