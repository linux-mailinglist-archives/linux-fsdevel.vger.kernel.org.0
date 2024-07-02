Return-Path: <linux-fsdevel+bounces-22963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF94924402
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D761C23F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783B1BE22A;
	Tue,  2 Jul 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cVZ1n+op";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eeBQ+Znn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SgfSY445";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0kNTFFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B7846D;
	Tue,  2 Jul 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939634; cv=none; b=G/gCsQfRibM6trWBUFSUmg9HG+TaaeaXkWFiduVLrh35+MrJHUMxYQZiNTAIsbmC/lZ/hSaXelxG3U8ej31FZs5queMLxCjgKdKVvz3TNUNwdVHwh9IjervAS9sX2xSmX72EXuSHsIRSShj2ZycI12i627ia6j7zppQ0rKjMnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939634; c=relaxed/simple;
	bh=K8VsCGrUyV4lSHiM8Vd6ArHffkld8kqllhhm3HPOngE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEYbfyhimEUlD7duRVZWUAbC3+cyJuxwxFe9Wusz0vMOTiEFBVwiZRXeUZzrP0ZrgIGbAp6SLXzoxyEw2MYaqLsF9frLRGuyEZfP8pflG+WvBL00FoYiSATnNLeBMMJOEJ4ozwY/SCkkcNr0MN0se4BBJEEmmYq0P+eZTw8ytSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cVZ1n+op; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eeBQ+Znn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SgfSY445; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0kNTFFe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BED241FBB3;
	Tue,  2 Jul 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719939631;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93MeAty8m/ZPbv/+ZPblI57xMCCiCRrqvCNZ35C2P0g=;
	b=cVZ1n+opU5gK4buhdJNaT17zO244czOisrP4KWJeFFxE8o3Q27QrCR7B8u+vI4dXmZRKYG
	0KxOQyujGupF/spyqb4qFs2jE58g0W+wL0nwa+1lmCImX+Ib4BHqsfd8dshv9awIPUtD9E
	dCeoSA04xfLRcc73G0szl5GjGpBga40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719939631;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93MeAty8m/ZPbv/+ZPblI57xMCCiCRrqvCNZ35C2P0g=;
	b=eeBQ+Znnc4REG1k027OHwl2f7eGGOVd6a38T6KGvZjqJCyNwS15c7jY5hhT/5yCVm3L0Ar
	Nztm+gzLNnm0qtCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SgfSY445;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v0kNTFFe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719939630;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93MeAty8m/ZPbv/+ZPblI57xMCCiCRrqvCNZ35C2P0g=;
	b=SgfSY445r2ehH/qfQ6aSkd53Wv9bvaE4IemcwYTlw8zJlNGuDESxNCD70BpouulR/QuP0G
	yF85AVXPmYNbETbeebtEceQnYju4JUIJ7ZrotnKU+8nc0M1pfuO7+UDdRX9xn1/v3gEM9b
	rKSIWwTqDBn8pldAVCKJKfiurnxOCRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719939630;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93MeAty8m/ZPbv/+ZPblI57xMCCiCRrqvCNZ35C2P0g=;
	b=v0kNTFFe3WMSnHZySF7qX9SRXSKoiXkPjlw4jIJNWrEeN8BpFmgHZZQ3POLNymkOUVXlas
	hyUwJnDWd4G9zyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F0F31395F;
	Tue,  2 Jul 2024 17:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QSlcHi4yhGbDRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 17:00:30 +0000
Date: Tue, 2 Jul 2024 19:00:21 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+026119922c20a8915631@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, clm@fb.com, dsterba@suse.com, jack@suse.cz,
	josef@toxicpanda.com, konishi.ryusuke@gmail.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [nilfs?] [btrfs?] WARNING in filemap_unaccount_folio
Message-ID: <20240702170021.GM21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000005c66ec061902110a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005c66ec061902110a@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: BED241FBB3
X-Spam-Score: -1.52
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.52 / 50.00];
	BAYES_HAM(-2.81)[99.19%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=713476114e57eef3];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,suse.com,suse.cz,toxicpanda.com,gmail.com,vger.kernel.org,googlegroups.com,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[026119922c20a8915631];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, May 21, 2024 at 07:55:32PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=142a7cb2980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
> dashboard link: https://syzkaller.appspot.com/bug?extid=026119922c20a8915631
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d43f84980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4fadc980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e1377d4772/disk-b6394d6f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/19fbbb3b6dd5/vmlinux-b6394d6f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4dcce16af95d/bzImage-b6394d6f.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e197bb1019a1/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1c62d475ecf4/mount_2.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+026119922c20a8915631@syzkaller.appspotmail.com

#syz set subsystems: nilfs

