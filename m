Return-Path: <linux-fsdevel+bounces-14036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911F876E25
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 01:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4711F23232
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 00:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA315AF;
	Sat,  9 Mar 2024 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rJakwMzC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nkak6Cls";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rJakwMzC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nkak6Cls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7287FA;
	Sat,  9 Mar 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709944223; cv=none; b=XbHEAFFetMJ7IdYGBavo6Ro/KlM12HSPgj+epdyyvlE0dnde3CDtab6apXgJw9gM8WItThieFRJzYBF26G+tOY6exwCP/t69dKkcAN4nOMmGdMhzdyECWF/VL8+s9vJaKJFjhA2DFu+ObzMU0Vj6QNQh5lLPmitMjlQACFt+KdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709944223; c=relaxed/simple;
	bh=7e7DyPm4Rx7BhGRGnMQmTvuH2TIydwFQEmVBPojb0xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8IDKZZfieqQgJ7YEwv+YffmzRZLHi33my3jJSCsjGgpaWTQxHX3hTvZf342q2ZnGThBdlyZI8RpcrhxsT/CxBTord495Mbz0wgOE1h+7NTcoYh/3zeBksW0+dQJC38eisJajWYJzwRgHQbe6h8rhT7GseGD7uN/BrReHfnUTz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rJakwMzC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nkak6Cls; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rJakwMzC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nkak6Cls; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B64A05CA89;
	Fri,  8 Mar 2024 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709936181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4zGKvXi4CflbsXC56FskHWyF5BoRZo+pQ+TQaW5RPc=;
	b=rJakwMzCZ06bhc6Nn2hflxP2iey3tOeBcOKfbUfijUEng4/xGCzRyjSoDasScgFyoCcKsH
	WrRi+VKYrWjFjxr3iDL2Z52PVEJ7zR1pmRbt3/tgww+hhM/mznHc1tg7rKqe3xrZwwv7Q7
	QC8LVyW0OLAWs34nmnOiOUaMfNpMv78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709936181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4zGKvXi4CflbsXC56FskHWyF5BoRZo+pQ+TQaW5RPc=;
	b=nkak6ClsFfPPPdUGg/jnbhm0bpLcZpezFh3e54KH2RC0gnVLpVlOrZHa0OGbV70AhBe7kx
	alxHrxFxQfHVHDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709936181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4zGKvXi4CflbsXC56FskHWyF5BoRZo+pQ+TQaW5RPc=;
	b=rJakwMzCZ06bhc6Nn2hflxP2iey3tOeBcOKfbUfijUEng4/xGCzRyjSoDasScgFyoCcKsH
	WrRi+VKYrWjFjxr3iDL2Z52PVEJ7zR1pmRbt3/tgww+hhM/mznHc1tg7rKqe3xrZwwv7Q7
	QC8LVyW0OLAWs34nmnOiOUaMfNpMv78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709936181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4zGKvXi4CflbsXC56FskHWyF5BoRZo+pQ+TQaW5RPc=;
	b=nkak6ClsFfPPPdUGg/jnbhm0bpLcZpezFh3e54KH2RC0gnVLpVlOrZHa0OGbV70AhBe7kx
	alxHrxFxQfHVHDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8DCA133DC;
	Fri,  8 Mar 2024 22:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5bOKDWO62WpQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Mar 2024 22:16:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42BD8A0807; Fri,  8 Mar 2024 23:16:21 +0100 (CET)
Date: Fri, 8 Mar 2024 23:16:21 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+5869fb71f59eac925756@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, hch@infradead.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid
 context in __bread_gfp
Message-ID: <20240308221621.kcux2edaxyrk4edu@quack3>
References: <00000000000071ce7305ee97ad81@google.com>
 <000000000000ce24de06122b8a39@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ce24de06122b8a39@google.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rJakwMzC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nkak6Cls
X-Spamd-Result: default: False [0.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[39.43%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[syzkaller.appspot.com:url,suse.cz:email,suse.cz:dkim,suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140];
	 TAGGED_RCPT(0.00)[5869fb71f59eac925756];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: B64A05CA89
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat 24-02-24 18:28:01, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164a0a54180000
> start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
> dashboard link: https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fa78c7280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e73723280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

