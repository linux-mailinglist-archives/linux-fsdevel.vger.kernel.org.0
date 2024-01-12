Return-Path: <linux-fsdevel+bounces-7863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F682BDFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 11:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC3A281F93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937157329;
	Fri, 12 Jan 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVPhsoZz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BTnLs+7K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVPhsoZz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BTnLs+7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53957301;
	Fri, 12 Jan 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B123A1FC24;
	Fri, 12 Jan 2024 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705053589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBVSPSStzukEuy78v0iO713Dp6S4Tr9jYl8yIfg303o=;
	b=LVPhsoZzrqmaIPxbO3hJzEKngFpRGRxhzEkLBJqX+H4UMHywFzgWicWjUcr+tHtOrnPKuE
	QtSvulQBOfynuRShDr9OezhwezW664d/eipB7f8XntSfTuC5f+Y+9uvuzw1Vtmw9fYqjyH
	bLqK5UKY0Fi0FwsPc40I+B6U1b34+c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705053589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBVSPSStzukEuy78v0iO713Dp6S4Tr9jYl8yIfg303o=;
	b=BTnLs+7K8qJ85T0XdQ/Ii+GrHsCuvh5oZb/cGkclZY4pD+OF61lQgeZDf+cAqTA01Ncu4G
	2nWOLgf2UxbYS4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705053589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBVSPSStzukEuy78v0iO713Dp6S4Tr9jYl8yIfg303o=;
	b=LVPhsoZzrqmaIPxbO3hJzEKngFpRGRxhzEkLBJqX+H4UMHywFzgWicWjUcr+tHtOrnPKuE
	QtSvulQBOfynuRShDr9OezhwezW664d/eipB7f8XntSfTuC5f+Y+9uvuzw1Vtmw9fYqjyH
	bLqK5UKY0Fi0FwsPc40I+B6U1b34+c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705053589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBVSPSStzukEuy78v0iO713Dp6S4Tr9jYl8yIfg303o=;
	b=BTnLs+7K8qJ85T0XdQ/Ii+GrHsCuvh5oZb/cGkclZY4pD+OF61lQgeZDf+cAqTA01Ncu4G
	2nWOLgf2UxbYS4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4FF413782;
	Fri, 12 Jan 2024 09:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c5tAKJUNoWUZPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Jan 2024 09:59:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5633AA0802; Fri, 12 Jan 2024 10:59:45 +0100 (CET)
Date: Fri, 12 Jan 2024 10:59:45 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+172bdd582e5d63486948@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] general protection fault in dtSplitUp
Message-ID: <20240112095945.oxx42ycamfouw3xs@quack3>
References: <000000000000ff4a1505e9f961a2@google.com>
 <000000000000ccb6c6060eb767bd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ccb6c6060eb767bd@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LVPhsoZz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BTnLs+7K
X-Spamd-Result: default: False [2.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.00)[24.04%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc];
	 TAGGED_RCPT(0.00)[172bdd582e5d63486948];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: B123A1FC24
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Thu 11-01-24 19:39:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268fc69e80000
> start commit:   a70385240892 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=172bdd582e5d63486948
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15692dba880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15017b2c880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Makes sense. When I'm looking at the dashboard I can see there's another
(older) reproducer which is not marked as not reproducing anymore. I
suppose this is because syzbot tests only the latest reproducer? Anyway,
let's close this, if syzbot can find another reproducer for the problem
with writes to mounted devices disabled, it'll surely tell us :)

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

