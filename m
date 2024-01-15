Return-Path: <linux-fsdevel+bounces-7943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130D82DA5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE29AB21961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296601862F;
	Mon, 15 Jan 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="msSEKnM2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jm5offHg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="msSEKnM2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jm5offHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3C18622;
	Mon, 15 Jan 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF3821EC2;
	Mon, 15 Jan 2024 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705326148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JctaG+RAw/QJiVZZcVRMYh+/2tbE9PXTDPR2pEygJ5s=;
	b=msSEKnM2i/qWGCxQn23LtvtB/MFntQOOTrzP9njtHgw4h5dIaUCZ0Ehhxumd+NJFFUe64x
	M3ZDGEwQXh3tYo1qkfQmSlind1+i6dP1ppF2cK15xhrxY5u5nIAd4V4zllDj6Nbyvr4u60
	vADplLPUvGAPA9s06JBIeLcnjbTB8y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705326148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JctaG+RAw/QJiVZZcVRMYh+/2tbE9PXTDPR2pEygJ5s=;
	b=Jm5offHgUuqdEXex/jp1LqnOgiaIRM1Xt0ELsez0cHE5SHtpXsbsXX4rtqZzKbglApEnjj
	yDQu8TsWQVRnKjAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705326148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JctaG+RAw/QJiVZZcVRMYh+/2tbE9PXTDPR2pEygJ5s=;
	b=msSEKnM2i/qWGCxQn23LtvtB/MFntQOOTrzP9njtHgw4h5dIaUCZ0Ehhxumd+NJFFUe64x
	M3ZDGEwQXh3tYo1qkfQmSlind1+i6dP1ppF2cK15xhrxY5u5nIAd4V4zllDj6Nbyvr4u60
	vADplLPUvGAPA9s06JBIeLcnjbTB8y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705326148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JctaG+RAw/QJiVZZcVRMYh+/2tbE9PXTDPR2pEygJ5s=;
	b=Jm5offHgUuqdEXex/jp1LqnOgiaIRM1Xt0ELsez0cHE5SHtpXsbsXX4rtqZzKbglApEnjj
	yDQu8TsWQVRnKjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50E11136F5;
	Mon, 15 Jan 2024 13:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /zq2E0Q2pWXoZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jan 2024 13:42:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19A03A07EA; Mon, 15 Jan 2024 14:42:28 +0100 (CET)
Date: Mon, 15 Jan 2024 14:42:28 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, dave.kleikamp@oracle.com,
	ghandatmanas@gmail.com, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
Message-ID: <20240115134228.vk73b4lkk7lxkgyr@quack3>
References: <00000000000027993305eb841df8@google.com>
 <000000000000c746f0060ee2b23a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c746f0060ee2b23a@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=msSEKnM2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jm5offHg
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.24 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLjmuxkameenh34oafz4d4fopd)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.25)[73.41%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901];
	 TAGGED_RCPT(0.00)[c1056fdfe414463fdb33];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,oracle.com,gmail.com,suse.cz,lists.sourceforge.net,vger.kernel.org,lists.linuxfoundation.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.24
X-Rspamd-Queue-Id: 5AF3821EC2
X-Spam-Flag: NO

On Sat 13-01-24 23:18:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ec162be80000
> start commit:   493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f431d2880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1208894a880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

