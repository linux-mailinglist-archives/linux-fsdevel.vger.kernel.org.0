Return-Path: <linux-fsdevel+bounces-19589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488928C78E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0023F281FE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0314BFAB;
	Thu, 16 May 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fztK2EiO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fu0W55kc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fztK2EiO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fu0W55kc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364C146D7F;
	Thu, 16 May 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871908; cv=none; b=TmKBfZ1HXy9YnJdAqeH5NPqYFBL9Y2pwkZxB5vxcnm5ODBOeADKCZfL8m71xf86wecYw8kCSnldTDLZh1Yw5Hpkl0I/J5xek+nsHkD+fOtN71sHGUN3VY2HY0IVoqVwkjuQVRNNV1Isfz8dq81LF66394N7RCgQXczR1Bau5xRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871908; c=relaxed/simple;
	bh=LW40CIlbMTKDUSpREPl3MGLSPFjJOFqK/CYmT7n1/KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwVEyqquX5Ok1bgCdn4EGsDvK2mosVhGO325v/ARRsFB9jeWfQBL0ZDlLKxF3xsLonaXTyAOUJwQAt2WCrNGmlKgc3oWm8V8BSrp6z60EIe5pdCvJsdWTWNGEK6glldKz83B8kIySnbtGOKPkZjsyr/hnk2JaNKG0i4Jc+W5HSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fztK2EiO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fu0W55kc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fztK2EiO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fu0W55kc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 887BC5C5BF;
	Thu, 16 May 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715871904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vl8867/EB6hcGN7QQaR2OYX9pnZOjnhcKwMi97OTjQk=;
	b=fztK2EiOnb7G1g2Eru30uB6WCsNzzNr+uuWZb7uVlcHXLrzQRQv1J+Diq8bHuARxR9OFRp
	teU4Qa1j2SVhQ963vEktr/N9UuWVB6NhrjOg/znu569C+eE2QUeIaKH36Ro60dFe5vZM9i
	9g1S94m0MuqARUK5RHMm4pmBFt84XZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715871904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vl8867/EB6hcGN7QQaR2OYX9pnZOjnhcKwMi97OTjQk=;
	b=fu0W55kcHK1TNvDG1fpNERRqUDt/cxvCmqklfg7UQsd3xgh3ZU4b0UVUZI//+EMg78etkV
	bwcmOeMmMUa9WfDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fztK2EiO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fu0W55kc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715871904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vl8867/EB6hcGN7QQaR2OYX9pnZOjnhcKwMi97OTjQk=;
	b=fztK2EiOnb7G1g2Eru30uB6WCsNzzNr+uuWZb7uVlcHXLrzQRQv1J+Diq8bHuARxR9OFRp
	teU4Qa1j2SVhQ963vEktr/N9UuWVB6NhrjOg/znu569C+eE2QUeIaKH36Ro60dFe5vZM9i
	9g1S94m0MuqARUK5RHMm4pmBFt84XZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715871904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vl8867/EB6hcGN7QQaR2OYX9pnZOjnhcKwMi97OTjQk=;
	b=fu0W55kcHK1TNvDG1fpNERRqUDt/cxvCmqklfg7UQsd3xgh3ZU4b0UVUZI//+EMg78etkV
	bwcmOeMmMUa9WfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77459137C3;
	Thu, 16 May 2024 15:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cXf2HKAgRmaKCQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:05:04 +0000
Date: Thu, 16 May 2024 17:04:58 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in emit_fiemap_extent
Message-ID: <20240516150458.GZ4449@twin.jikos.cz>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.01 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.28)[89.93%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[9992306148b06272f3bb];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 887BC5C5BF
X-Spam-Flag: NO
X-Spam-Score: 0.01
X-Spamd-Bar: /

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

#syx fix: btrfs: fix race between ordered extent completion and fiemap

