Return-Path: <linux-fsdevel+bounces-9342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F428401E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A83284425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA05578A;
	Mon, 29 Jan 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QqwMqmKw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCJJC7if";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2txEFOd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NfJqAgE9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801C55765;
	Mon, 29 Jan 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521166; cv=none; b=ght2K2Bw6r7nGFgNuzfYWBoPMIbfPuW3sRyaQy9/cO9sdCdet+Ps9WC+pn2Q2mNEjmuxzES0esH38VVyqFl3x3sdcMf/EfL4xSxBrt8bKRJHiQjG3F9pioUX1mQ/YykpJPX/w6cMsVSvSUrshq2cCtubGrePOEL3yDNkAUAn9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521166; c=relaxed/simple;
	bh=aWQKANCB/jJlxRlIU3TNvJO3vbpQJA7QbcB8gMmUMn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKFfxoPpw9ngggyZuYlkNNoOwYks6ox3yDg+W4I8nYl+KkFcsPwXMRQC8rovMBqt5zqlE+zm3w1Bztlrfrl4pjOrMY+TNKuOLOVWQ5YG8TW4kSI6cWihBBLCYitij1iGvMRB/sftXngQdPy9hyRmg0eHBcm5AyhteRxsMg38oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QqwMqmKw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCJJC7if; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2txEFOd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NfJqAgE9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0EB01F7D9;
	Mon, 29 Jan 2024 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4ZRnNJagh1Jnd//oHgKH6RzaoD7F7RB0IJxLI/4+w=;
	b=QqwMqmKwn8G+sV4alb5J5Zb6QNYpHkBtse++XJGocEIXkwAQQR6VBMUFkrwIenXSWeenRy
	3EvYzQZ2omC1XO3k8b/2TLJGa5zrgnD44aEd3c1zld8/CCxSKrxhSvUINEDViYXaKSALNf
	yocKEbGJSGRnkqT+YOH/zen44ioq7N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4ZRnNJagh1Jnd//oHgKH6RzaoD7F7RB0IJxLI/4+w=;
	b=OCJJC7ifMExXqfg03eA10zHyBgtoOnmuHsTgr60bTaUC87QvCt1IJrkpCzPrmKGgIicDp/
	0QFU9yihX6SSmKDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4ZRnNJagh1Jnd//oHgKH6RzaoD7F7RB0IJxLI/4+w=;
	b=v2txEFOdGNP2le+AkjHqbQhAGL2WIIj9h42Q6mMdqF1Mhpu8eUpn5/Z7p6KlO6Qjksdzt7
	P7t9OTFNGs+alMjFO8u2+3z87x31/K7X1ZKez9L1tsAds7BTfg1Nhttc9NdvZN3R9nRjjJ
	eBK9zg0ouhwoaHOOG+jXpOC4OuohzLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4ZRnNJagh1Jnd//oHgKH6RzaoD7F7RB0IJxLI/4+w=;
	b=NfJqAgE9a+kXY3BwphnUzsA8n9tWXWviIQIYbzIRjq/UApjtkBQiEJhXXM09ek3NlFWcQG
	672vsJO1sGiwwMAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DD2C613911;
	Mon, 29 Jan 2024 09:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EezyNUhyt2UgRgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 09:39:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74B6EA0807; Mon, 29 Jan 2024 10:39:20 +0100 (CET)
Date: Mon, 29 Jan 2024 10:39:20 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+500a5eabc2495aaeb60e@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, peterz@infradead.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, yukuai3@huawei.com, yuran.pereira@hotmail.com
Subject: Re: [syzbot] [kernel?] general protection fault in timerqueue_del (2)
Message-ID: <20240129093920.tame7kmz46zmjpjf@quack3>
References: <000000000000c6ec640601d95e6c@google.com>
 <00000000000072355b060ffc546e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000072355b060ffc546e@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v2txEFOd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NfJqAgE9
X-Spamd-Result: default: False [1.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[hotmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d];
	 TAGGED_RCPT(0.00)[500a5eabc2495aaeb60e];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-1.32)[90.27%];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,suse.cz,vger.kernel.org,infradead.org,googlegroups.com,linutronix.de,huawei.com,hotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.37
X-Rspamd-Queue-Id: F0EB01F7D9
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On Sat 27-01-24 23:18:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172204dfe80000
> start commit:   4b954598a47b Merge tag 'exfat-for-6.5-rc5' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
> dashboard link: https://syzkaller.appspot.com/bug?extid=500a5eabc2495aaeb60e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169efdf6a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13733f31a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

