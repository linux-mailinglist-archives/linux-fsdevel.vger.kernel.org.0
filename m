Return-Path: <linux-fsdevel+bounces-10682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAB484D5B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62ED1C25B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9841EA72;
	Wed,  7 Feb 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9EdvZpE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWLYDSc1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfv3f70U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+iWRhUIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B57149DE8;
	Wed,  7 Feb 2024 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344340; cv=none; b=bdhoOlgZSMAwor/ObxniBHh3H2kqbT6Pi6CMBYdkht8MQB7dE+upXnG+SXd21/i15PZX7Qgu0Fcebig6kOT0NJAy82CK5OELSWrWX+d1NLmjHsom/9sRzk+AVQvQ4GDdQAoVtG5eUnHEvDWUSmD7wrHOx6YTisMZfq8xoFPFWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344340; c=relaxed/simple;
	bh=bx+KURCYSGlETV+r29jDrgPWZ+/PJ7n49T3tpO3jhKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8GNTtPwNgSqmiM1Kiu3Uw77IgQB9SXh4jNrvktjdPoqXtVZ4eiA2PByyx5ZvlWja9zm3bL/XZ5C/obVWQ+ornFGrz8kOvGAXa1a4X48fNw9MFZ3ODNsTiUSJCKIvVfzGCUNBvWx7yuvFtkwulBWADG4gPN6l0QUR8WNT/BUHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9EdvZpE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWLYDSc1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfv3f70U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+iWRhUIA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFD732220A;
	Wed,  7 Feb 2024 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707344336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goluLwcuX68TlGMIeX0uo6uwWYziPKeRnES2FOv7XD8=;
	b=i9EdvZpE4brZX7uKo4nWXIlUAMiTu1g8s/GapJXkzjSPCT0IMWkIBbD0XjnIn234X7nXXU
	+rRaF7HaNKFO4Zvi+heGJ5nblKhJUL0HEkU5SCp8KW5e3iW+GmT6i8GVNV2Hhi4eyHa94y
	X5QxfOBJ/ALQfJ4c2norfz8JUT67wcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707344336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goluLwcuX68TlGMIeX0uo6uwWYziPKeRnES2FOv7XD8=;
	b=rWLYDSc1KHvbg0Y/VXyqlOwP9wHlTbzxiOVr2rfPbI5Ku5jRH3JX5T9y5Hd+iQWM0Dl1cy
	w6YDf1+Oj9+hmzCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707344334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goluLwcuX68TlGMIeX0uo6uwWYziPKeRnES2FOv7XD8=;
	b=kfv3f70UJdkswQswPkgWSVlK7JsruYEFaOGhCm9aPBKozXsIv68GCbciMbNx7y5TY0d+0c
	prkIhLT7H4dWKnCTEY/jIn8hJMzqr7MyTEanFIQp/8IWJyaNCiPz4EvMjXAMcw099/nUU3
	eK/rS52dGm7RlBmW6y3yzBjGOZ3Ob0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707344334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goluLwcuX68TlGMIeX0uo6uwWYziPKeRnES2FOv7XD8=;
	b=+iWRhUIAaw/CTSPN3xRgqLOKiY+xPI13THkHsy9on96k1Epo0A17MmiJSO3HbT1311BOlz
	AgXfRsvrQjJ5inCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDEE71326D;
	Wed,  7 Feb 2024 22:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RLhYLs4BxGUfJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 22:18:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F0BFA0809; Wed,  7 Feb 2024 23:18:50 +0100 (CET)
Date: Wed, 7 Feb 2024 23:18:50 +0100
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: syzbot <syzbot+53b443b5c64221ee8bad@syzkaller.appspotmail.com>,
	axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com,
	dchinner@redhat.com, djwong@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmapi_convert_delalloc
Message-ID: <20240207221850.hrqrnra4bkgjsqbg@quack3>
References: <0000000000001bebd305ee5cd30e@google.com>
 <00000000000032f84a0610c46f89@google.com>
 <ZcPzZNStEgLX+bAq@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcPzZNStEgLX+bAq@dread.disaster.area>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kfv3f70U;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+iWRhUIA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[30.60%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=11e478e28144788c];
	 TAGGED_RCPT(0.00)[53b443b5c64221ee8bad];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: CFD732220A
X-Spam-Flag: NO

On Thu 08-02-24 08:17:24, Dave Chinner wrote:
> On Tue, Feb 06, 2024 at 10:02:05PM -0800, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> > 
> >     fs: Block writes to mounted block devices
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b0ad7be80000
> > start commit:   e8c127b05766 Merge tag 'net-6.6-rc6' of git://git.kernel.o..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a6f291680000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116bc355680000
> > 
> > If the result looks correct, please mark the issue as fixed by replying with:
> > 
> > #syz fix: fs: Block writes to mounted block devices
> 
> For real? The test doesn't even open a mounted block device for
> writes...

I was also confused by this. Somehow this commit makes the reproducer stop
working but I have no idea how that's possible.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

