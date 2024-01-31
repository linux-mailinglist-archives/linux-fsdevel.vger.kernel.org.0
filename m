Return-Path: <linux-fsdevel+bounces-9639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F301843F14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20A91F3066A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732427867E;
	Wed, 31 Jan 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rpey7Rf1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4y0RAUW0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/bToHT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FPAKO1Qh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7D76040;
	Wed, 31 Jan 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702557; cv=none; b=TLZ28GU3nGruDemZJYE0w9Q0SXxuKNDuNms6y9DlRquaNxdo+0v64PaAHtoMV+SNfIXjJrKPDASKvqiEiVcgVJwN+Xa2m4dHrTfhYU2vxEcSKS69kaz33SE/9IUlLJQHjujm/hE2KkI4nwfAweLjAq8dPWOBjLXBgLyX18dP5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702557; c=relaxed/simple;
	bh=mNpShDixWPH2+65Z/sczb7dFR7wo+uzcpUkD0tcCHIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPLgPTh34oV3wiNGpUX1T+HTECzZZ+Rkcpo52PjTATwaQNjozEG3LtziXFQ50LX3mBVBnZoT/5j9rk003LD+QQCL7sVw5AV+V4+7qugtCcvx+dhfY7eEgf0ged0366DDr91aJwwuO5WPWZua/Kxq9Fu4/tI11aN6Ms+Pk7+ZHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rpey7Rf1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4y0RAUW0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/bToHT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FPAKO1Qh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66DFA22152;
	Wed, 31 Jan 2024 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706702553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFW/uyXSTx1zaklDUdqba1GObwi/+lntUdbkEgumfhs=;
	b=Rpey7Rf1LZ5ZnGaWiEN9vE4sOhX10lrAY0Ag6Z2I7T0xgBXV55PGq5Mn/LRYfftJssp62g
	EpwuYNgXGJYjCMZUinGRqMAIcElwxVTON4kJ1CKKNVKt2Rmzrb+s3LvTpYYkLlmwwI9L4M
	jaApy9L09gO2IijxBLWfx2hqXL5sxgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706702553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFW/uyXSTx1zaklDUdqba1GObwi/+lntUdbkEgumfhs=;
	b=4y0RAUW05JehdlyAy2WXJFU36Z2KXZO4ojLZJkPicB8HnrgIPbdpe4i1IEfrL8/3Uqn91G
	Q+q+l4Ztl0mH8bAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706702551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFW/uyXSTx1zaklDUdqba1GObwi/+lntUdbkEgumfhs=;
	b=s/bToHT9gYtY8WaNz9I17AGxDAdjPKdtBHsUveca/u9xwSZYc/ujEqVWGmErykBQ0zUHsq
	00jqheW7gGJqgQ/ztC6kugn3tF6hroto7SuBLKtu17tgR0TNkB4JhG96LSNd+mgxwws+nJ
	130YkEBNi1IIJpP6LVQBo1wYbk/aueA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706702551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFW/uyXSTx1zaklDUdqba1GObwi/+lntUdbkEgumfhs=;
	b=FPAKO1QhoQboW9CLlurttKTeuO2WQ5EFbKOchrZeLQ/rH2HYwxjMja0NYBB8FP2MXpeUm2
	JHvnY51co/vx9NDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5641C139D9;
	Wed, 31 Jan 2024 12:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2dnIFNc2umW3SgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 12:02:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B13ABA0809; Wed, 31 Jan 2024 13:02:30 +0100 (CET)
Date: Wed, 31 Jan 2024 13:02:30 +0100
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>,
	adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: current->journal_info got nested! (was Re: [syzbot] [xfs?]
 [ext4?] general protection fault in jbd2__journal_start)
Message-ID: <20240131120230.2lzbwxg7j5ou6lyc@quack3>
References: <000000000000e98460060fd59831@google.com>
 <000000000000d6e06d06102ae80b@google.com>
 <ZbmILkfdGks57J4a@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbmILkfdGks57J4a@dread.disaster.area>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b0b9993d7d6d1990];
	 TAGGED_RCPT(0.00)[cdee56dbcdf0096ef605];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SUBJECT_HAS_EXCLAIM(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,suse.com:email,storage.googleapis.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Wed 31-01-24 10:37:18, Dave Chinner wrote:
> On Tue, Jan 30, 2024 at 06:52:21AM -0800, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ca8d97e80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b0b9993d7d6d1990
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cdee56dbcdf0096ef605
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104393efe80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1393b90fe80000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7c6cc521298d/disk-861c0981.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6203c94955db/vmlinux-861c0981.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/17e76e12b58c/bzImage-861c0981.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/d31d4eed2912/mount_3.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com
> > 
> > general protection fault, probably for non-canonical address 0xdffffc000a8a4829: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: probably user-memory-access in range [0x0000000054524148-0x000000005452414f]
> > CPU: 1 PID: 5065 Comm: syz-executor260 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> > RIP: 0010:jbd2__journal_start+0x87/0x5d0 fs/jbd2/transaction.c:496
> > Code: 74 63 48 8b 1b 48 85 db 74 79 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 63 4d 8f ff 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 4a 4d 8f ff 4c 39 65 00 0f 85 1a
> > RSP: 0018:ffffc900043265c8 EFLAGS: 00010203
> > RAX: 000000000a8a4829 RBX: ffff8880205fa3a8 RCX: ffff8880235dbb80
> > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88801c1a6000
> > RBP: 000000005452414e R08: 0000000000000c40 R09: 0000000000000001
>                ^^^^^^^^
> Hmmmm - TRAN. That's looks suspicious, I'll come back to that.

Indeed, thanks for the great analysis.

<snip analysis>

> The question here is what to do about this? The obvious solution is
> to have save/restore semantics in the filesystem code that
> sets/clears current->journal_info, and then filesystems can also do
> the necessary "recursion into same filesystem" checks they need to
> ensure that they aren't nesting transactions in a way that can
> deadlock.

As others have mentioned, this seems potentially dangerous because that
just hides potential deadlocks. E.g. for ext4 taking a page fault while
having a transaction started violates lock ordering requirements
(mapping->invalidate_lock > transaction start). OTOH we have lockdep
tracking for this anyway so I guess we don't care too much for ext4.

> Maybe there are other options - should filesystems even be allowed to
> trigger page faults when they have set current->journal_info?

For ext4 it would definitely be a bug if this happens and it is not only
about usage of current->journal_info as I wrote above.

> What other potential avenues are there that could cause this sort of
> transaction context nesting that we haven't realised exist? Does
> ext4 data=jounral have problems like this in the data copy-in path?
> What other filesystems allow page faults in transaction contexts?

So I'm reasonably confident we aren't hitting any such path in ext4 as
lockdep would tell us about it (we treat transaction start as lock
acquisition in jbd2 and tell lockdep about it). For the write path, we are
relying on VFS prefaulting pages before calling ->write_begin (where we
start a transaction) and then doing atomic copy. For the read path we don't
start any transaction (except for possible atime update but that's just a
tiny transaction on the side after the read completes). So ext4 on its own
should be fine. But we have also btrfs, ceph, gfs2, nilfs2, ocfs2, and
reiserfs using current->journal_info so overall chances for interaction are
... non-trivial.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

