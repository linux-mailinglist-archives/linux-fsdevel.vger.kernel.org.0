Return-Path: <linux-fsdevel+bounces-70141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD576C92020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 13:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0D124E3BFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD121329C77;
	Fri, 28 Nov 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lirmZ8B3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKv0ddiR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJFN/zdc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZudxL5JE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0130FC32
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333655; cv=none; b=GIeWS7RxoCTLYhXDl5g8KqMb5MsBQrqPXFGX44KtX7EL9pBYMlxR02nohXtZBj6VfXcHlcf7TDntXAUW/ncMd+533ZYRpmTtVyjo5KU2knD5ge6kkb0bpNfOqsUzxFjFfQOH3Up1qJudzHJjyNlp3ZXd1CiewOzodITfvviWzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333655; c=relaxed/simple;
	bh=EvtjY45wJFYMAjnJui/76tpbrUZyiaupSmlaOUgw0kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKwbaMmvy+3LirAmiW1i1Zl8yiZzhUiuUqJSUS/bbp3GNsZayIsUUPqb5Tov6rBbBuCrWTgbD5XizKpzPzlwQX0lNW6LIb9WBFwob096phnSdjmM1KZ3UUAKCcGJihUDtXwkM9r/tCN+sr6uyK13rvHajN/+6RdvFG+lTMzkMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lirmZ8B3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKv0ddiR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJFN/zdc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZudxL5JE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D994521993;
	Fri, 28 Nov 2025 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764333652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON5zVeP22yo7Ut6qqqlmcKiobXeM3hgaanmhlr5X3j4=;
	b=lirmZ8B3SadAEucZArb3SJzHiMOGJVBwL3c767gMMHLK+0YDLHjrWuSr2BMhjhtUNBDNub
	4b6e7pm0DuBymLOT3lApCMTXDVPujtcIWNZf+RpT+JsA5MxBailGfHkfrL7xJnCKCmi2pt
	0qxtNq8s4TTPEf4aAsxEAoryx0rBIK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764333652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON5zVeP22yo7Ut6qqqlmcKiobXeM3hgaanmhlr5X3j4=;
	b=CKv0ddiR5X7wt6CJ0aJyBJsTl+CNcQAC2yKlJOg8aLNVHqHhMW00OZdnlIAZ+xOeGziL8/
	K6hKoWk8bHp3V3Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764333651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON5zVeP22yo7Ut6qqqlmcKiobXeM3hgaanmhlr5X3j4=;
	b=LJFN/zdccmCZZAG/N5N9yOyOI6R3/c9uKTOcin62BMN8GyKZ97aauv5FeFaNABd0VZgv/4
	9i2brQR04w1XTExBUggvM0wnye7aSmjwJWqzi8YAxIOdsqlwOvXwZQJq5DBTyjELGPeLoi
	lDQ8HWdm4P9j5YKjOEIlYkoEV+z14Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764333651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON5zVeP22yo7Ut6qqqlmcKiobXeM3hgaanmhlr5X3j4=;
	b=ZudxL5JEy69ckYC3n9DhD59GU/PCelYmBEhtXf/LU9CMRCqbSUJetxHP+f71rj+F5ul/vk
	LJFZy93bViDvXDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D09933EA63;
	Fri, 28 Nov 2025 12:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bUPmMlOYKWmRdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Nov 2025 12:40:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8694FA08BE; Fri, 28 Nov 2025 13:40:51 +0100 (CET)
Date: Fri, 28 Nov 2025 13:40:51 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+94048264da5715c251f9@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in mntput
Message-ID: <xoz24h3357hot5caj46ug72rw3tpcscrt2qtmjdpl2hymvuvyx@szn4js4453wx>
References: <6928c5c3.a70a0220.d98e3.011a.GAE@google.com>
 <dh6c3iksktkus55r7qkr74rclftpmxj2lbwstcvxdzc3ql3vls@c7f5ctbhg2fn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dh6c3iksktkus55r7qkr74rclftpmxj2lbwstcvxdzc3ql3vls@c7f5ctbhg2fn>
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bf77a4e0e3514deb];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[94048264da5715c251f9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spam-Flag: NO

On Fri 28-11-25 13:29:06, Jan Kara wrote:
> Hello,
> 
> On Thu 27-11-25 13:42:27, syzbot wrote:
> > syzbot found the following issue on:
> > 
> > HEAD commit:    92fd6e84175b Add linux-next specific files for 20251125
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13a55612580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=bf77a4e0e3514deb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=94048264da5715c251f9
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1215f612580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17082f42580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/bee2604d495b/disk-92fd6e84.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b12aade49e2c/vmlinux-92fd6e84.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/286fd34158cb/bzImage-92fd6e84.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+94048264da5715c251f9@syzkaller.appspotmail.com
> > 
> > Oops: general protection fault, probably for non-canonical address 0xdffffc0000000023: 0000 [#1] SMP KASAN PTI
> 
> This is caused by 67c68da01266d ("namespace: convert fsmount() to
> FD_PREPARE()") and the problem is we do:
> 
> 	struct path newmount __free(path_put) = {};
> 
> 	...
> 
> 	newmount.mnt = vfs_create_mount(fc);
> 	if (IS_ERR(newmount.mnt))
> 		return PTR_ERR(ns);
> 
> Which is not safe to do because path_put() unconditionally calls
> mntput(path.mnt) which only has "if (mnt)" so it tries to put error
> pointer.
> 
> There are several ways to fix this:
> 
> 1) We can just add IS_ERR_OR_NULL(mnt) check to mntput(). It is convenient
> but I know Al didn't like these wholesale IS_ERR_OR_NULL() checks because
> they kind of hide occasional sloppy programming practices.
> 
> 2) We can provide alternative for path_put() as a destructor which properly
> deals with error pointers.
> 
> 3) We can just store result of vfs_create_mount() in a temporary variable
> and store the result in newmount after we verify it is valid.
> 
> I'm leaning towards 3) but what do other people think?

Ah, OK, now I see you've already picked up a fix for this so please ignore
this message.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

