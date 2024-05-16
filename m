Return-Path: <linux-fsdevel+bounces-19590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3708C78F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510C1B21DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD6014D2A3;
	Thu, 16 May 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mW5unzg1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubUCighw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mW5unzg1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubUCighw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B11459F3;
	Thu, 16 May 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872113; cv=none; b=K4f9F/xMWtuTPv9PBnxvZXMXSC0MoDmXhLO271GwI7kAD8wry2KATXF29fVCUG2dH+Z798wQK46dC7+8yuhMBtfLGnk8UbQV+sXBObCCYFmeFVNEhxkFYa+dzpgPYQvlwnzOIJAz2zSD/gMXALHUZuL6xnm38vrnI4K/KYQ9n90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872113; c=relaxed/simple;
	bh=PLj3kHvsq5pXlJ3MZBETvmLmxpLPhx6qk+JPicL+q04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY3ofc9bQltH3OKettRRiDxlyDWSfqZwKKJpUUnLTFUmJW/w5/lb1WX73RcEmdojUGv/PlgATqhuf9Pa+p+mYCOKMnc26T8dplkf/VgrT1Q4FbK9OYbBRca6cfl9l6kEybX0oweMGP34ptBq/ah/EbdcYkqkrwbr18gzWqm/dtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mW5unzg1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubUCighw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mW5unzg1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubUCighw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B66D55C5D1;
	Thu, 16 May 2024 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715872109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwOCimsYiQZW+MRPKFuhdCubR4+tShwzjZXOuhyF9Ek=;
	b=mW5unzg1n8r2KDbdhto6yyL8PgBgQO0lzT7LOSnoqTv0l0EP+mR9ZGvYz9HqauKK71YDrz
	4U4Jns98nuqsBwuUIjPGC0+dsRQF9Wimp1jArsx5Bca0F/zmFrCLdkCryZCIW8KtZHeFO3
	m0jjnhwhDeJHoCsIfDxNxXADY0MioBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715872109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwOCimsYiQZW+MRPKFuhdCubR4+tShwzjZXOuhyF9Ek=;
	b=ubUCighwwB4LHsYQNZjVkORRDznbxZJJOKg8EObqMuD3K5NW4q/5w/Teo6rnhi405rzdLN
	O5yTIZtlSLm15bDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715872109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwOCimsYiQZW+MRPKFuhdCubR4+tShwzjZXOuhyF9Ek=;
	b=mW5unzg1n8r2KDbdhto6yyL8PgBgQO0lzT7LOSnoqTv0l0EP+mR9ZGvYz9HqauKK71YDrz
	4U4Jns98nuqsBwuUIjPGC0+dsRQF9Wimp1jArsx5Bca0F/zmFrCLdkCryZCIW8KtZHeFO3
	m0jjnhwhDeJHoCsIfDxNxXADY0MioBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715872109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwOCimsYiQZW+MRPKFuhdCubR4+tShwzjZXOuhyF9Ek=;
	b=ubUCighwwB4LHsYQNZjVkORRDznbxZJJOKg8EObqMuD3K5NW4q/5w/Teo6rnhi405rzdLN
	O5yTIZtlSLm15bDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2B7F137C3;
	Thu, 16 May 2024 15:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zkCRJ20hRmaBSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:08:29 +0000
Date: Thu, 16 May 2024 17:08:27 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in emit_fiemap_extent
Message-ID: <20240516150827.GA4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000091164305fe966bdd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000091164305fe966bdd@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.10 / 50.00];
	BAYES_HAM(-1.60)[92.47%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[9992306148b06272f3bb];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -0.10
X-Spam-Flag: NO

On Tue, Jun 20, 2023 at 02:34:46PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=166d2acf280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
> dashboard link: https://syzkaller.appspot.com/bug?extid=9992306148b06272f3bb
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c65e87280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1094a78b280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2dc89d5fee38/disk-40f71e7c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0ced5a475218/vmlinux-40f71e7c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d543a4f69684/bzImage-40f71e7c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7cde8d2312ae/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5351 at fs/btrfs/extent_io.c:2824 emit_fiemap_extent+0xee/0x410

#syz fix: btrfs: fix race between ordered extent completion and fiemap

