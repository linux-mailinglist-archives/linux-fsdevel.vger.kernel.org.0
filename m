Return-Path: <linux-fsdevel+bounces-7942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947082DA59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3C5B21C06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC0182BD;
	Mon, 15 Jan 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jUtq8cYK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PurxCMc+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jUtq8cYK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PurxCMc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F7182A1;
	Mon, 15 Jan 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C30721EF0;
	Mon, 15 Jan 2024 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705326101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jA5Cu9AWaUNPG7ZmLl1Q9dS9vTQjhzxdsBE+iAkyms=;
	b=jUtq8cYKSaU3axuFDd9TAXNHTpSqZ0HO0f61mPKt8OnTYiqjB2lbm9z1vKjcp/0eY/pJQh
	+p1pA6Lq5fpDBScDPHVJKSqufWbdrKP3/Oarhj1yg0DIy/tIKewTVeqnu7OtGcW8cH3kZ9
	HNBJjfkgaP5EHDbaaE04lesB18Bu1rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705326101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jA5Cu9AWaUNPG7ZmLl1Q9dS9vTQjhzxdsBE+iAkyms=;
	b=PurxCMc+LLigIrY8HAOAcwkNZ2VpzAZI+H5VTJhjNosVrLykFaplsTvf9s7i+11uriEpE/
	Ru/z7dKQP7JLuQDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705326101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jA5Cu9AWaUNPG7ZmLl1Q9dS9vTQjhzxdsBE+iAkyms=;
	b=jUtq8cYKSaU3axuFDd9TAXNHTpSqZ0HO0f61mPKt8OnTYiqjB2lbm9z1vKjcp/0eY/pJQh
	+p1pA6Lq5fpDBScDPHVJKSqufWbdrKP3/Oarhj1yg0DIy/tIKewTVeqnu7OtGcW8cH3kZ9
	HNBJjfkgaP5EHDbaaE04lesB18Bu1rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705326101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jA5Cu9AWaUNPG7ZmLl1Q9dS9vTQjhzxdsBE+iAkyms=;
	b=PurxCMc+LLigIrY8HAOAcwkNZ2VpzAZI+H5VTJhjNosVrLykFaplsTvf9s7i+11uriEpE/
	Ru/z7dKQP7JLuQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ACC9136F5;
	Mon, 15 Jan 2024 13:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0GxnChU2pWWkZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jan 2024 13:41:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DBD14A07EA; Mon, 15 Jan 2024 14:41:40 +0100 (CET)
Date: Mon, 15 Jan 2024 14:41:40 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+f91c29a5d5a01ada051a@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk,
	brauner@kernel.org, bvanassche@acm.org, hch@lst.de, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, martin.petersen@oracle.com, nathan@kernel.org,
	ndesaulniers@google.com, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, trix@redhat.com,
	viro@zeniv.linux.org.uk, yanaijie@huawei.com
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state
Message-ID: <20240115134140.a2jcs5dosdsizorj@quack3>
References: <000000000000ed1df405f05224aa@google.com>
 <0000000000008942ff060edc57fb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008942ff060edc57fb@google.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jUtq8cYK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PurxCMc+
X-Spamd-Result: default: False [2.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=94632a8e2ffd08bb];
	 TAGGED_RCPT(0.00)[f91c29a5d5a01ada051a];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.01)[51.24%];
	 R_RATELIMIT(0.00)[to_ip_from(RLgtcj9mh9ghuanj5qgfrqcyig)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.68
X-Rspamd-Queue-Id: 3C30721EF0
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Sat 13-01-24 15:43:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f71683e80000
> start commit:   8f6f76a6a29f Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94632a8e2ffd08bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15af0317680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10de04b0e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

