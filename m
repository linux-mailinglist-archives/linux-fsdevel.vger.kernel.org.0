Return-Path: <linux-fsdevel+bounces-7085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695A821B79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF002816F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26CF9C3;
	Tue,  2 Jan 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rVfdmq1r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SV6DFXVz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JSvxxO/q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HnAFj7MG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532CEED2;
	Tue,  2 Jan 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49FD01FD5E;
	Tue,  2 Jan 2024 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704197701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzteoYRrFuNlezpMdhomW2MOjO8HHbS2clXQHZdwoPI=;
	b=rVfdmq1rDvgD7b4d1mF2ZCEBTZ+3ArKL958WQrnXGtgwaqj7DYXVivSIouvlQWFmEODG++
	8LOL1fg5CZ/04IpI6xQNy9MKa3/rZb7FOz0uZIASHNFFSp0VwW3+JIxJTxFsQ9eXP5TfbQ
	c2LS0a8wITbyz6A7J4aaQ3g+ntg5sIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704197701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzteoYRrFuNlezpMdhomW2MOjO8HHbS2clXQHZdwoPI=;
	b=SV6DFXVzlTFJxIWbgtrSlwhih/Zxvim1Tj7HPNfde+D0780UzoNLx9CmfZAMHgNivmAI0c
	m8jlTTyd8AVpOYDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704197699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzteoYRrFuNlezpMdhomW2MOjO8HHbS2clXQHZdwoPI=;
	b=JSvxxO/qXOCtnLRV+LIUGhAvLal1X95hYtx4VBVun3A4jsLFswEEfEIQOEuzPSW3e/NKIU
	5co3Dn9NR2YS3UxNHYPx5U1Cot9c5vdbgnVnmHuupC1J1qsfDEpJ11Mf2YYdWyJ/BtdZP8
	jMzocNegQ2W5++gY62vbJXg2d+juORI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704197699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzteoYRrFuNlezpMdhomW2MOjO8HHbS2clXQHZdwoPI=;
	b=HnAFj7MGtLTikRyJ7PpC/vBIkYW0P/An0eCjfGKLQ5fmEsF3ZMrXgSSBeYPUNLsGXEFplO
	1WZQB5FJhjN+PaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 358961340C;
	Tue,  2 Jan 2024 12:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gn4FDUP+k2VVPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 12:14:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C74D8A07EF; Tue,  2 Jan 2024 13:14:58 +0100 (CET)
Date: Tue, 2 Jan 2024 13:14:58 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
Cc: Christian Brauner <brauner@kernel.org>, axboe@kernel.dk,
	chao@kernel.org, christian@brauner.io, daniel.vetter@ffwll.ch,
	hch@lst.de, hdanton@sina.com, jack@suse.cz, jaegeuk@kernel.org,
	jinpu.wang@ionos.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, mcanal@igalia.com,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	terrelln@fb.com, willy@infradead.org, yukuai3@huawei.com
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
Message-ID: <20240102121458.bcnwj3g4hr6xhimt@quack3>
References: <0000000000001825ce06047bf2a6@google.com>
 <00000000000007d6a9060d441adc@google.com>
 <20231228-arterien-nachmachen-d74aec52820e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228-arterien-nachmachen-d74aec52820e@brauner>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.53
X-Spamd-Bar: ++
X-Spam-Flag: NO
X-Spamd-Result: default: False [2.53 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLqzkqenty6h5wkt76cn81i3yg)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.16)[69.10%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=710dc49bece494df];
	 TAGGED_RCPT(0.00)[062317ea1d0a6d5e29e7];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,goo.gl:url,suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,kernel.dk,brauner.io,ffwll.ch,lst.de,sina.com,suse.cz,ionos.com,lists.sourceforge.net,vger.kernel.org,riseup.net,igalia.com,googlegroups.com,fb.com,infradead.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="JSvxxO/q";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HnAFj7MG
X-Spam-Level: **
X-Rspamd-Queue-Id: 49FD01FD5E

On Thu 28-12-23 11:50:32, Christian Brauner wrote:
> On Sun, Dec 24, 2023 at 08:40:05AM -0800, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit fd1464105cb37a3b50a72c1d2902e97a71950af8
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Oct 18 15:29:24 2023 +0000
> > 
> >     fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14639595e80000
> > start commit:   2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
> > dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107e9518680000
> > 
> > If the result looks correct, please mark the issue as fixed by replying with:
> > 
> > #syz fix: fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Fwiw, this was always a false-positive. But we also reworked the locking
> that even the false-positive cannot be triggered anymore. So yay!

Yup, nice. I think you need to start the line with syz command so:

#syz fix: fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

