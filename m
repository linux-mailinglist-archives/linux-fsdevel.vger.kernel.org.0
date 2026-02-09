Return-Path: <linux-fsdevel+bounces-76723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EK5H10aimkjHAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:33:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF9113137
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B34F301BF64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8BA2E8DEB;
	Mon,  9 Feb 2026 17:33:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from leontynka.twibright.com (leontynka.twibright.com [109.81.181.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86172261B80
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.81.181.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658392; cv=none; b=geg8B9YqCBZT8vqsiBUH1tAI7THSwgIuHOW5D1z3+urCAT0+BO3zASu21UMGhNt5ZYg7g4W+8mDuoMJqnsklped3rKnB37USQSG+9AwGxvg475nivwWPI46ZFOTLuzKjNp5ApVy9k8KT+ep47e94w+3/Ay7oD0Xv5boDGtXOFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658392; c=relaxed/simple;
	bh=WzYpcXxHSSzXeUdBoW1H2nLswpH5cvcSoqfgQzOfCfs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=civU3586NTdVV0JK8tDe16t5HF2Gb6gpJJIWl5JHTt029qM1n8QTTYIjRxFQWg7A3lkf00sbm4MF2NpFXbzySS1iRWPV5hO1dCZA7UbzL0QtZXjVsfo9X+PgXryJVDloy8QSxB0mnRXniO29Yqj73OjKhzc0VJoOq2eouCKEJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=twibright.com; spf=pass smtp.mailfrom=twibright.com; arc=none smtp.client-ip=109.81.181.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=twibright.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twibright.com
Received: from mikulas (helo=localhost)
	by leontynka.twibright.com with local-esmtp (Exim 4.96)
	(envelope-from <mikulas@twibright.com>)
	id 1vpUhN-005mnZ-09;
	Mon, 09 Feb 2026 18:05:21 +0100
Date: Mon, 9 Feb 2026 18:05:21 +0100 (CET)
From: Mikulas Patocka <mikulas@twibright.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
    syzkaller <syzkaller@googlegroups.com>, 
    Viacheslav Sablin <sjava1902@gmail.com>, 
    Dmitry Vyukov <dvyukov@google.com>, Aleksandr Nogikh <nogikh@google.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
    Sasha Levin <sashal@kernel.org>, Christian Brauner <brauner@kernel.org>, 
    viro@zeniv.linux.org.uk, Deepanshu Kartikey <kartikey406@gmail.com>
Subject: Re: [PATCH (REPOST)] hpfs: make check=none mount option excludable
In-Reply-To: <6d2ed161-b302-4475-b32c-2feca1f84026@I-love.SAKURA.ne.jp>
Message-ID: <31825fd6-45b8-928f-0022-0696202032ce@twibright.com>
References: <51bdd056-61dd-4b57-8780-324b2f8bc99f@I-love.SAKURA.ne.jp> <6d2ed161-b302-4475-b32c-2feca1f84026@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[twibright.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76723-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,gmail.com,google.com,linux-foundation.org,suse.cz,kernel.org,zeniv.linux.org.uk];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikulas@twibright.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: F1FF9113137
X-Rspamd-Action: no action



On Sun, 18 Jan 2026, Tetsuo Handa wrote:

> Mikulas, are you there?
> 
> A patch was posted to https://lkml.kernel.org/r/20260117054014.1252933-1-kartikey406@gmail.com
> for a bug report which Mikulas would not accept as a valid bug because of "check=none".
> 
> If Mikulas keeps silence, maybe we should out-out hpfs from fuzz testing...

Hi

I've sent a pull request to Linus that makes the "check=none" mode 
equivalent to the "check=normal" check mode.

HPFS is not considered 'high-performance' anymore, so I think that the 
no-check mode is not required at all.

Mikulas

> On 2026/01/13 19:08, Tetsuo Handa wrote:
> > syzbot is reporting use-after-free read problem when a crafted HPFS image
> > was mounted with "check=none" option.
> > 
> > The "check=none" option is intended for only users who want maximum speed
> > and use the filesystem only on trusted input. But fuzzers are for using
> > the filesystem on untrusted input.
> > 
> > Mikulas Patocka (the HPFS maintainer) thinks that there is no need to add
> > some middle ground where "check=none" would check some structures and won't
> > check others. Therefore, to make sure that fuzzers and careful users do not
> > by error specify "check=none" at runtime, make "check=none" being
> > excludable at build time.
> > 
> > Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
> > Link: https://lkml.kernel.org/r/9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com
> > Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> > Mikulas wants fuzz testing systems not to specify "check=none" option. But it is
> > too difficult to enforce that. It is possible that an unexpected input hides
> > "hpfs: You really don't want any checks? You are crazy..." message due to changing
> > loglevel, and after that the kernel may hit this problem (i.e. we will be needlessly
> > bothered by stupid inputs).
> > 
> > Honestly speaking, the code that runs in the kernel space needs to be as careful as
> > possible, for any memory access error in the kernel space can result in serious result.
> > We are fixing various input validations for all (but HPFS) filesystems. It is strange
> > that HPFS is exempted from this rule. I expect that "check=none" behavior (if someone
> > wants such behavior) should be emulated in the user space using FUSE filesystem.
> > 
> >  fs/hpfs/Kconfig | 11 +++++++++++
> >  fs/hpfs/super.c |  2 ++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
> > index ac1e9318e65a..d3dfbe76be8a 100644
> > --- a/fs/hpfs/Kconfig
> > +++ b/fs/hpfs/Kconfig
> > @@ -15,3 +15,14 @@ config HPFS_FS
> >  
> >  	  To compile this file system support as a module, choose M here: the
> >  	  module will be called hpfs.  If unsure, say N.
> > +
> > +config HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
> > +	bool "Allow no-error-check mode for maximum speed"
> > +	depends on HPFS_FS
> > +	default n
> > +	help
> > +	  This option enables check=none mount option. If check=none is
> > +	  specified, users can expect maximum speed at the cost of minimum
> > +	  robustness. Sane users should not specify check=none option, for e.g.
> > +	  use-after-free bug will happen when the filesystem is corrupted or
> > +	  crafted.
> > diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
> > index 8ab85e7ac91e..656b1ae01812 100644
> > --- a/fs/hpfs/super.c
> > +++ b/fs/hpfs/super.c
> > @@ -285,7 +285,9 @@ static const struct constant_table hpfs_param_case[] = {
> >  };
> >  
> >  static const struct constant_table hpfs_param_check[] = {
> > +#ifdef CONFIG_HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
> >  	{"none",	0},
> > +#endif
> >  	{"normal",	1},
> >  	{"strict",	2},
> >  	{}
> 
> 

