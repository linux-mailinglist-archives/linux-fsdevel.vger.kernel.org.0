Return-Path: <linux-fsdevel+bounces-19539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08888C6A52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46211C213B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D1156255;
	Wed, 15 May 2024 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGGsKCDb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ncl0nM74";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGGsKCDb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ncl0nM74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A415624D;
	Wed, 15 May 2024 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789599; cv=none; b=sd/645/3/aaLavY0D95rbpymcMLRwMYu6LAZJRuMnXf7VLKMQpb5y3v1x5fvfa43b7vqsz4yfShS5eWijATN2oK93CGEmQrvdY+Jp6D94p5u/OPfPuuU+j8JZAsaxdQ9EBN+ceSQvGrfCIc7H8aZ31B7R9QNkc5/uPnILirB6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789599; c=relaxed/simple;
	bh=6KFAktHlckvn9kXUIg/2ZeqLAvcGfH7sutdSydTSF6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArlPS2bxMp2a1xcsUqW88lJvD7VesgI9AFbiwKLtOyowTmrfpsnBjgYczaRiSoqPcwVKbxDXwtlTa1eDrolmAhw5HNHlN+RGLGyrNCnF73SKw5tzKNixpgYzspuzBX+c/+//RvV7GT77HGd4j+aPHY4Ury9RFdAE3OKn2RVrhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FGGsKCDb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ncl0nM74; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FGGsKCDb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ncl0nM74; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B7E3208BC;
	Wed, 15 May 2024 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715789596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8tleQ6Q2fB1v8wfKi3LmYiVSkhChrLrR1OmwIuZqv8=;
	b=FGGsKCDbOS9BJosidUDNjOxDakuyDPMjryv4W3hwVuurVuyoiN17DHofVKJCYwa0ajbw+U
	tAOP3fIwBmRY+Xd7cJMWc8NrAWc4KDqXCdmK8k4py3shX8D1j/o5nb2SqQ8kvVB0oKSzeL
	y/hM6HmdxkHXBYq9/aMQerUJhXt7UuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715789596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8tleQ6Q2fB1v8wfKi3LmYiVSkhChrLrR1OmwIuZqv8=;
	b=Ncl0nM74+blaLrlxw2NscfvXk8B0E2wJf0i7tHWi4oH7BBCe9QHOCYA5PGb2gkubJQiMYK
	wuqEINAZ9tkeAwDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FGGsKCDb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ncl0nM74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715789596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8tleQ6Q2fB1v8wfKi3LmYiVSkhChrLrR1OmwIuZqv8=;
	b=FGGsKCDbOS9BJosidUDNjOxDakuyDPMjryv4W3hwVuurVuyoiN17DHofVKJCYwa0ajbw+U
	tAOP3fIwBmRY+Xd7cJMWc8NrAWc4KDqXCdmK8k4py3shX8D1j/o5nb2SqQ8kvVB0oKSzeL
	y/hM6HmdxkHXBYq9/aMQerUJhXt7UuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715789596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8tleQ6Q2fB1v8wfKi3LmYiVSkhChrLrR1OmwIuZqv8=;
	b=Ncl0nM74+blaLrlxw2NscfvXk8B0E2wJf0i7tHWi4oH7BBCe9QHOCYA5PGb2gkubJQiMYK
	wuqEINAZ9tkeAwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB07F1372E;
	Wed, 15 May 2024 16:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +7PzOBvfRGYTZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 16:13:15 +0000
Date: Wed, 15 May 2024 18:13:14 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: kernel BUG at fs/inode.c:LINE! (2)
Message-ID: <20240515161314.GO4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000c8fcd905adefe24b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c8fcd905adefe24b@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.56 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650];
	BAYES_HAM(-0.73)[83.78%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[c92c93d1f1aaaacdb9db];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 0B7E3208BC
X-Spam-Flag: NO
X-Spam-Score: 0.56
X-Spamd-Bar: /

On Fri, Aug 28, 2020 at 06:18:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d012a719 Linux 5.9-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000
> 
> The issue was bisected to:
> 
> commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
> Author: Marc Zyngier <maz@kernel.org>
> Date:   Wed Aug 19 16:12:17 2020 +0000
> 
>     epoll: Keep a reference on files added to the check list
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a50519900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a50519900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a50519900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com
> Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")
> 
> ------------[ cut here ]------------
> kernel BUG at fs/inode.c:1668!

#syz set subsystem: fs

This has been among btrfs bugs but this is is 'fs' and probably with a
fix but I was not able to identify it among all the changes in
eventpoll.c

