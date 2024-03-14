Return-Path: <linux-fsdevel+bounces-14407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8662087C0B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 16:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9AF1C20F6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C77874416;
	Thu, 14 Mar 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tjLgQCjs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deiIgmej";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWTTVirU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aYLQHl+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6B7353F;
	Thu, 14 Mar 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431664; cv=none; b=oT8c6Knds8w0Y7UTcOBGeUq2Hbc/7MZr7l4NjrWE5AdWCe1KZFmgustnggJb3iBnN6CttvaO+c2YMT4MH+TI3qU5yd+d9kL39sP3r7WoTzIIgPgs/l3S5VKN73iUipKbhvT03GLTDRUTO8i9u4el6wD9a2SpxCWXbiR9BNrmGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431664; c=relaxed/simple;
	bh=km/3aGcwVNjprkRJ5a9yQcLEWlg19dOOzcQex1nbcDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMY7NUvTtS/agUwjhDvxZX1jeUGXPY9XhMEPV26bEsANTtT4LslycTb4OLnxexMnV68DafSlE30NjfXyoTjRMCzuykS8EeovUIAFNi425hz9wxmDq4ul5tOr1cQhIA7qZfbdnlnaKroQrGMmauTQHvLBr8pf/U0TwWCaw6CoZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tjLgQCjs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deiIgmej; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWTTVirU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aYLQHl+L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A9211F86A;
	Thu, 14 Mar 2024 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710431660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BT7NUMGMj375LcHUS5Xp8EH29Otg/hkMc0woQNGiIn8=;
	b=tjLgQCjs4YoblTiknk6v6c925YSD176Y5HwHks5cFNCjarrSHZnNEBosRUXLkYpZuJQDgu
	+V5LUYgzSuPSn6h8z+ai0PgYyjYuQeJkuTUPS9S4rX5wpZjluyB08UhyDQS7styBkfHrCi
	sTt5gjYS0TpE5tM880uh41XJrpXOjp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710431660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BT7NUMGMj375LcHUS5Xp8EH29Otg/hkMc0woQNGiIn8=;
	b=deiIgmejfrJ1f/+HDe80GhXDzXeVJZUZmpGB+FgnmxIn0XO8HuDS1CKuV240QgjtijBZCb
	5jVWmsuSoaoKEzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710431658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BT7NUMGMj375LcHUS5Xp8EH29Otg/hkMc0woQNGiIn8=;
	b=AWTTVirUlEzlgXbsQ5/f9Ni0hm7MBI1wX/6gYrGxFWSWj6ybNhOifVLrALpsP0LQts1qfJ
	j3YdTiJh+dEBUQc6RnC4g86+BZft7fVBVnoWCu4AhYRNl7VoMzxaOEucNliSC3wuCrP5MN
	6a/lRkIjIIkgM/NcuUVenfQDVJGBHBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710431658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BT7NUMGMj375LcHUS5Xp8EH29Otg/hkMc0woQNGiIn8=;
	b=aYLQHl+LTd9+OOpdnBqccfKM8gwkHbTbLRCQxsonPrvfIziysIshoKCi2gTAW/ZjG0pg4N
	V8P5o+s9G9SCgMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F092B1368B;
	Thu, 14 Mar 2024 15:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Myy1Oqkd82V5MwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 15:54:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 916D4A07D9; Thu, 14 Mar 2024 16:54:17 +0100 (CET)
Date: Thu, 14 Mar 2024 16:54:17 +0100
From: Jan Kara <jack@suse.cz>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>,
	axboe@kernel.dk, brauner@kernel.org, jmorris@namei.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	serge@hallyn.com, syzkaller-bugs@googlegroups.com,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
Message-ID: <20240314155417.aysvaktvvqxc34zb@quack3>
References: <000000000000fcfb4a05ffe48213@google.com>
 <0000000000009e1b00060ea5df51@google.com>
 <20240111092147.ywwuk4vopsml3plk@quack3>
 <bbeeb617-6730-4159-80b1-182841925cce@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbeeb617-6730-4159-80b1-182841925cce@I-love.SAKURA.ne.jp>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7406f415f386e786];
	 TAGGED_RCPT(0.00)[28aaddd5a3221d7fd709];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Sun 10-03-24 09:52:01, Tetsuo Handa wrote:
> On 2024/01/11 18:21, Jan Kara wrote:
> > On Wed 10-01-24 22:44:04, syzbot wrote:
> >> syzbot suspects this issue was fixed by commit:
> >>
> >> commit 6f861765464f43a71462d52026fbddfc858239a5
> >> Author: Jan Kara <jack@suse.cz>
> >> Date:   Wed Nov 1 17:43:10 2023 +0000
> >>
> >>     fs: Block writes to mounted block devices
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15135c0be80000
> >> start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
> >> git tree:       upstream
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=28aaddd5a3221d7fd709
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b5bb80a80000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10193ee7280000
> >>
> >> If the result looks correct, please mark the issue as fixed by replying with: 
> > 
> > Makes some sense since fs cannot be corrupted by anybody while it is
> > mounted. I just don't see how the reproducer would be corrupting the
> > image... Still probably:
> > 
> > #syz fix: fs: Block writes to mounted block devices
> > 
> > and we'll see if syzbot can find new ways to tickle some similar problem.
> > 
> > 								Honza
> 
> Since the reproducer is doing open(O_RDWR) before switching loop devices
> using ioctl(LOOP_SET_FD/LOOP_CLR_FD), I think that that commit converted
> a run many times, multi threaded program into a run once, single threaded
> program. That will likely hide all race bugs.
> 
> Does that commit also affect open(3) (i.e. open for ioctl only) case?
> If that commit does not affect open(3) case, the reproducer could continue
> behaving as run many times, multi threaded program that overwrites
> filesystem images using ioctl(LOOP_SET_FD/LOOP_CLR_FD), by replacing
> open(O_RDWR) with open(3) ?

Hum, that's a good point. I had a look into details how syskaller sets up
loop devices and indeed it gets broken by CONFIG_BLK_DEV_WRITE_MOUNTED=n.
Strace confirms that:

openat(AT_FDCWD, "/dev/loop0", O_RDWR)  = 4
ioctl(4, LOOP_SET_FD, 3)                = 0
close(3)                                = 0
mkdir("./file0", 0777)                  = -1 EEXIST (File exists)
mount("/dev/loop0", "./file0", "reiserfs", 0, "") = -1 EBUSY (Device or resource busy)
ioctl(4, LOOP_CLR_FD)                   = 0
close(4)                                = 0

which explains why syzbot was not able to reproduce some problems for which
CONFIG_BLK_DEV_WRITE_MOUNTED=n should have made no difference (I wanted to
have a look into that but other things kept getting higher priority).

It should be easily fixable by opening /dev/loop0 with O_RDONLY instead of
O_RDWR. Aleksandr?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

