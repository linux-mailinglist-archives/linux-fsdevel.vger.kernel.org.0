Return-Path: <linux-fsdevel+bounces-8617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1162839903
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 20:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71660295027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2331C86AF4;
	Tue, 23 Jan 2024 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UGvXqjfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLM+5hH0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UGvXqjfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLM+5hH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BB612EC;
	Tue, 23 Jan 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036248; cv=none; b=C4dAX5vnDq0oCQOoZWTbzAH2RGuY+AJQv8cBqkoTobYdk66evj5bdvDTsHmwIilq8im4vt83I8drYKLghlYActFEwJAg0ph2sEEgDml/eGClPxSmR0d7Z4GtlHudE/Bx8F0v+5dS6F+aeT38JA5+couXERsqRN/kqslMOOo7GDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036248; c=relaxed/simple;
	bh=Ak/glq7j04rGYzsCmBK7FjkE6BR//6TwHFiUwcbnr2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W18ASThc9bmbXyxs8cof258V/rWYqnCY444NRhQDgyVW3lZoPX8mcb/1vcjve0614GFTLim8WONJwIoiJS5TDQ9Oamey/CGau/lRRjgw2YWxn22KCVjqDOYxsoDmSOiKVxKufK8AHph75RDgBsZLk88sOJvfoGJDaHuC9xvKqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UGvXqjfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLM+5hH0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UGvXqjfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLM+5hH0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 419481F79C;
	Tue, 23 Jan 2024 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706036245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qE/ObleNo0AJceF8Y88Xp5VWzLENyIMYmuPcvCBMHU=;
	b=UGvXqjfTTcKoezcGSY73OCl2fm/7D8UIzttmvvyxMEUYZ/2iq+CCzTpwxP+FXNJYGilFha
	crJYaHqFgQQ11/OIMF1j1MSOVUttj1dH93pDZNo8xvJZq3PCrz1A9lya2/L3hAiYRARoXZ
	GsyA6q49c+uQ0mtk+M07cE94WMYkls8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706036245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qE/ObleNo0AJceF8Y88Xp5VWzLENyIMYmuPcvCBMHU=;
	b=nLM+5hH0flFJ5Cdqt7OuSM8RtqVDyhFC4lpSXcp4sS87qlaGLHwjpgHXnWuJMjbLlP9ZcS
	j4he8Od5+pI32yDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706036245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qE/ObleNo0AJceF8Y88Xp5VWzLENyIMYmuPcvCBMHU=;
	b=UGvXqjfTTcKoezcGSY73OCl2fm/7D8UIzttmvvyxMEUYZ/2iq+CCzTpwxP+FXNJYGilFha
	crJYaHqFgQQ11/OIMF1j1MSOVUttj1dH93pDZNo8xvJZq3PCrz1A9lya2/L3hAiYRARoXZ
	GsyA6q49c+uQ0mtk+M07cE94WMYkls8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706036245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qE/ObleNo0AJceF8Y88Xp5VWzLENyIMYmuPcvCBMHU=;
	b=nLM+5hH0flFJ5Cdqt7OuSM8RtqVDyhFC4lpSXcp4sS87qlaGLHwjpgHXnWuJMjbLlP9ZcS
	j4he8Od5+pI32yDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36BE313786;
	Tue, 23 Jan 2024 18:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hn9UDRUMsGXYOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 18:57:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4EEBA0803; Tue, 23 Jan 2024 19:57:24 +0100 (CET)
Date: Tue, 23 Jan 2024 19:57:24 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+e57bfc56c27a9285a838@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
	roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] kernel BUG in direntry_check_right
Message-ID: <20240123185724.t6yvo4nwaoyiryom@quack3>
References: <00000000000020a5790609bb5db8@google.com>
 <000000000000e39a56060f84e6d9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e39a56060f84e6d9@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UGvXqjfT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nLM+5hH0
X-Spamd-Result: default: False [2.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9];
	 TAGGED_RCPT(0.00)[e57bfc56c27a9285a838];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.03)[55.44%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.66
X-Rspamd-Queue-Id: 419481F79C
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Mon 22-01-24 00:49:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bedc9be80000
> start commit:   305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
> dashboard link: https://syzkaller.appspot.com/bug?extid=e57bfc56c27a9285a838
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb0588e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce91ef680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Makes sense.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

