Return-Path: <linux-fsdevel+bounces-7948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBC82DB85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 15:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8B11C21C1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B021A287;
	Mon, 15 Jan 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lGpl1b5f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qxbu2KL4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lGpl1b5f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qxbu2KL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797B19BD2;
	Mon, 15 Jan 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 175CC1F8AE;
	Mon, 15 Jan 2024 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705329502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijZfYFHSKVHJRzGZBOWDbHvnwNJnJ+2TfD5KBYD4yrQ=;
	b=lGpl1b5f0xbFZrP9087vPnpLgqSpY5mszCFZIGVn8NQp6fMV4w0HtbRDFhxEqDOC3s1qHb
	0ZUpwS8iIpZ26Fl+R4oGrRrUT3EGnl0VG//EUAqsKNrG5bzS+62gSWJ6K1rikqk79hRBbi
	5t91eu3wSKmN3INICROOLjN871MOMYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705329502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijZfYFHSKVHJRzGZBOWDbHvnwNJnJ+2TfD5KBYD4yrQ=;
	b=qxbu2KL4ljeVjjloj0Ol38e1Xd5jJJE/J1dJ9S3cFvPcIBonePlcYsghB7qUYuMDLFg6Pu
	qK1eEE7DF0nxQcCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705329502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijZfYFHSKVHJRzGZBOWDbHvnwNJnJ+2TfD5KBYD4yrQ=;
	b=lGpl1b5f0xbFZrP9087vPnpLgqSpY5mszCFZIGVn8NQp6fMV4w0HtbRDFhxEqDOC3s1qHb
	0ZUpwS8iIpZ26Fl+R4oGrRrUT3EGnl0VG//EUAqsKNrG5bzS+62gSWJ6K1rikqk79hRBbi
	5t91eu3wSKmN3INICROOLjN871MOMYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705329502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijZfYFHSKVHJRzGZBOWDbHvnwNJnJ+2TfD5KBYD4yrQ=;
	b=qxbu2KL4ljeVjjloj0Ol38e1Xd5jJJE/J1dJ9S3cFvPcIBonePlcYsghB7qUYuMDLFg6Pu
	qK1eEE7DF0nxQcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B535132FA;
	Mon, 15 Jan 2024 14:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A/y+Al5DpWXQdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jan 2024 14:38:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AB4E8A07EA; Mon, 15 Jan 2024 15:38:17 +0100 (CET)
Date: Mon, 15 Jan 2024 15:38:17 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+84b5465f68c3eb82c161@syzkaller.appspotmail.com>
Cc: anton@tuxera.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs?] BUG: unable to handle kernel paging request in
 lookup_open
Message-ID: <20240115143817.bihmmw4uhuch4vp7@quack3>
References: <0000000000002562100600ed9473@google.com>
 <0000000000003bf67c060ef84f04@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003bf67c060ef84f04@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lGpl1b5f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qxbu2KL4
X-Spamd-Result: default: False [2.14 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ae56ea581f8fd3f3];
	 TAGGED_RCPT(0.00)[84b5465f68c3eb82c161];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.55)[80.97%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.14
X-Rspamd-Queue-Id: 175CC1F8AE
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Mon 15-01-24 01:05:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11feec2be80000
> start commit:   831fe284d827 Merge tag 'spi-fix-v6.5-rc1' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae56ea581f8fd3f3
> dashboard link: https://syzkaller.appspot.com/bug?extid=84b5465f68c3eb82c161
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a52a24a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156f908aa80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks sensible:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

