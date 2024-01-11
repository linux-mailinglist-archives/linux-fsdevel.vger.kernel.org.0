Return-Path: <linux-fsdevel+bounces-7780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC882AAC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DF3282ED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36B11C93;
	Thu, 11 Jan 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O10PnA5U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pljCv8lT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DLTsdr/R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuJXopWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EE12E5B;
	Thu, 11 Jan 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3131F1FB93;
	Thu, 11 Jan 2024 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704964819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BG4l8S4qH/pdeuy9YBJx2ULMPOYWxsdX/Qk0+ysAZFY=;
	b=O10PnA5UoDnOwrvEgUiBBGbjS+bH1vG6SKp0R3FZcMaujzsxWrk45be2UkruykpAlnhyOy
	FOaiwp6HZgi3uYtfDOLkbCoANBBR/+YbtzDErp3ml2BVwd9dXeleOBm+3rXE0ULg6aED7W
	MSvN9buA+HtrWQcYmiF8/xqvGtxzKXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704964819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BG4l8S4qH/pdeuy9YBJx2ULMPOYWxsdX/Qk0+ysAZFY=;
	b=pljCv8lTzcTysH3Vk9QOXeS8pQ3SnFj5qeWlQy5YCu2XcNGgrg89pD66/zdUmbvKWr8CYa
	DbWBrnhydgmghuCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704964893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BG4l8S4qH/pdeuy9YBJx2ULMPOYWxsdX/Qk0+ysAZFY=;
	b=DLTsdr/RtTsy+HmSVVU6QgVHFa5zgKnnyU2o/LfFTxcurlifeV4zMlzHfliRCMxeRLb5+X
	v3ZzsydYyNEEGv2MVD38rzrXRcEEHN9QIZmMwc2AKBPTPV5DNRftTdXJgA4BCDGp++k3cx
	Lgi0B9tr+ZweoiGogwMKVf4tJFwBnhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704964893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BG4l8S4qH/pdeuy9YBJx2ULMPOYWxsdX/Qk0+ysAZFY=;
	b=WuJXopWpzXx8vtgBM4F+8BniNJcfaY4lMF9y3pOMnN4OhcKu0RBp5dbv4YJFHUnWkhc+yC
	lWcvAQ2muGx7sHBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 21930138E5;
	Thu, 11 Jan 2024 09:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jqgrCNGyn2X8KwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 11 Jan 2024 09:20:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5FD84A0807; Thu, 11 Jan 2024 10:21:47 +0100 (CET)
Date: Thu, 11 Jan 2024 10:21:47 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, jmorris@namei.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
	tomoyo-dev-en-owner@lists.osdn.me, tomoyo-dev-en@lists.osdn.me
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
Message-ID: <20240111092147.ywwuk4vopsml3plk@quack3>
References: <000000000000fcfb4a05ffe48213@google.com>
 <0000000000009e1b00060ea5df51@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009e1b00060ea5df51@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="DLTsdr/R";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WuJXopWp
X-Spamd-Result: default: False [2.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7406f415f386e786];
	 TAGGED_RCPT(0.00)[28aaddd5a3221d7fd709];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.03)[56.17%];
	 R_RATELIMIT(0.00)[to_ip_from(RLfgkate9mdgitaydm133m7cj1)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.66
X-Rspamd-Queue-Id: 3131F1FB93
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Wed 10-01-24 22:44:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15135c0be80000
> start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
> dashboard link: https://syzkaller.appspot.com/bug?extid=28aaddd5a3221d7fd709
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b5bb80a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10193ee7280000
> 
> If the result looks correct, please mark the issue as fixed by replying with: 

Makes some sense since fs cannot be corrupted by anybody while it is
mounted. I just don't see how the reproducer would be corrupting the
image... Still probably:

#syz fix: fs: Block writes to mounted block devices

and we'll see if syzbot can find new ways to tickle some similar problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

