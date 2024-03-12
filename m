Return-Path: <linux-fsdevel+bounces-14197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 417848793C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222A6B252CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3846A7A131;
	Tue, 12 Mar 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BlDW88C6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5Ox/Bbz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BlDW88C6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5Ox/Bbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451A7A121;
	Tue, 12 Mar 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245224; cv=none; b=BfueA2e8+q7UCH8TPVFIorjfTnz73D6cksp59VOHH+n4xnD29tH4WUWZR7y3Yjd0w7qPnqMSGvNo82qvIbmteZbjvExPWUIn2e/iWO0ey0LJ8sE5Qhv46Q377G8rYcLuYtFRAtlzRaSAegrHLRrVxh5gSiHKTePI/7VGuTh9do4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245224; c=relaxed/simple;
	bh=Vl6uNECXw+Bli4pbtWV6uER2p1NypHIO2iJeQFZu8Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvPU9f6DrI27fvWrtwNybnFfAm8hwhTKrNwh8cIBSOutrIQ8a0+VoTteIY+aKI7W3BTFTAcBTE5b0cAcgF7th3HQe9aHUw3/eO/sUIkLdV4l6sxL4HVwaeFGSkvRKP5DId9FPV681zJj/Ak/zZm5aZHQhA3rLoQl1VIRKMpjIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BlDW88C6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5Ox/Bbz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BlDW88C6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5Ox/Bbz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 602D73764C;
	Tue, 12 Mar 2024 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710245219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJfjWeNXVPT/qepjRfaCmAM72afs7cwXQz/2lur6DYY=;
	b=BlDW88C6qDW8qPI/qYyjqlBqqSLuNnkovQpSqeHwBysb3v9cWTufR5lsAqU1AevnBVz65A
	Kek+OEtJyldQ+vbMju6DtoAv4uNM1YlqIIzPkrywRkkF1ULVUPCmnl0aWCIBb0VXO2ksMw
	tkrM9B2htN768A16b6mz5jsieoLHrlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710245219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJfjWeNXVPT/qepjRfaCmAM72afs7cwXQz/2lur6DYY=;
	b=a5Ox/BbzrR2BrYKPI19Ym7yP6y8MmBpiRq2brGEBZZqZprkD4SWnzBYLUix1ZBNMC2Thmw
	B94217bIe5ZIEUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710245219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJfjWeNXVPT/qepjRfaCmAM72afs7cwXQz/2lur6DYY=;
	b=BlDW88C6qDW8qPI/qYyjqlBqqSLuNnkovQpSqeHwBysb3v9cWTufR5lsAqU1AevnBVz65A
	Kek+OEtJyldQ+vbMju6DtoAv4uNM1YlqIIzPkrywRkkF1ULVUPCmnl0aWCIBb0VXO2ksMw
	tkrM9B2htN768A16b6mz5jsieoLHrlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710245219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJfjWeNXVPT/qepjRfaCmAM72afs7cwXQz/2lur6DYY=;
	b=a5Ox/BbzrR2BrYKPI19Ym7yP6y8MmBpiRq2brGEBZZqZprkD4SWnzBYLUix1ZBNMC2Thmw
	B94217bIe5ZIEUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5357B1379A;
	Tue, 12 Mar 2024 12:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dJ5UFGNF8GVzbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 Mar 2024 12:06:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05BFDA07D9; Tue, 12 Mar 2024 13:06:58 +0100 (CET)
Date: Tue, 12 Mar 2024 13:06:58 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
	almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, ebiederm@xmission.com,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu,
	viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [syzbot] [ntfs3?] WARNING in do_open_execat
Message-ID: <20240312120658.os72hvnk5jedwbaw@quack3>
References: <000000000000c74d44060334d476@google.com>
 <000000000000f67b790613665d7a@google.com>
 <20240311184800.d7nuzahhz36rlxpg@quack3>
 <CAGudoHGAzNkbgUsJwvTnmO2X5crtLfO47aaVmEMwZ=G2wWTQqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGAzNkbgUsJwvTnmO2X5crtLfO47aaVmEMwZ=G2wWTQqA@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BlDW88C6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="a5Ox/Bbz"
X-Spamd-Result: default: False [-0.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,syzkaller.appspot.com:url];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bdf178b2f20f99b0];
	 TAGGED_RCPT(0.00)[6ec38f7a8db3b3fb1002];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: 602D73764C
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 11-03-24 20:01:14, Mateusz Guzik wrote:
> On 3/11/24, Jan Kara <jack@suse.cz> wrote:
> > On Mon 11-03-24 11:04:04, syzbot wrote:
> >> syzbot suspects this issue was fixed by commit:
> >>
> >> commit 6f861765464f43a71462d52026fbddfc858239a5
> >> Author: Jan Kara <jack@suse.cz>
> >> Date:   Wed Nov 1 17:43:10 2023 +0000
> >>
> >>     fs: Block writes to mounted block devices
> >>
> >> bisection log:
> >> https://syzkaller.appspot.com/x/bisect.txt?x=17e3f58e180000
> >> start commit:   eb3479bc23fa Merge tag 'kbuild-fixes-v6.7' of
> >> git://git.ke..
> >> git tree:       upstream
> >> kernel config:
> >> https://syzkaller.appspot.com/x/.config?x=bdf178b2f20f99b0
> >> dashboard link:
> >> https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
> >> syz repro:
> >> https://syzkaller.appspot.com/x/repro.syz?x=15073fd4e80000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b20b8f680000
> >>
> >> If the result looks correct, please mark the issue as fixed by replying
> >> with:
> >
> > #syz fix: fs: Block writes to mounted block devices
> >
> 
> I don't think that's correct.
> 
> The bug is ntfs instantiating an inode with bogus type (based on an
> intentionally corrupted filesystem), violating the api contract with
> vfs, which in turn results in the warning way later.
> 
> It may be someone sorted out ntfs doing this in the meantime, I have
> not checked.
> 
> With this in mind I don't believe your patch fixed it, at best it
> happened to neuter the reproducer.

OK, I didn't dig deep into the bug. I've just seen there are no working
reproducers and given this is ntfs3 which doesn't really have great
maintenance effort put into it, I've opted for closing the bug. If there's
a way to tickle the bug without writing to mounted block device, syzbot
should eventually find it and create a new issue... But if you want to look
into this feel free to :) Thanks for sharing the info.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

