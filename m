Return-Path: <linux-fsdevel+bounces-19541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0568C6A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313A5B21039
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977EC15625D;
	Wed, 15 May 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zbKH+RMK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kK1Wxx5y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="anl80dIj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xZzorhKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0A155A26;
	Wed, 15 May 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789750; cv=none; b=bwqMxDeLSISdezuvvwGb7fdXQh6I+iEdywKUnkoBUgCi0UeG0zk4BWDEd8iXUD2eKVeeTE+rYDNw4C3b8DJEN5RX4FblT9flORu8UNWDjUkZGJBeNQFOYa8r4imG10c1dbepIpsBYw20GhX0iH9UeMtjRVM1zJzK/XY5g5GX3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789750; c=relaxed/simple;
	bh=fCrm3kzOE+zio8J9d8t20yvZ3OY1Oo8ur1Y2bhn0lLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAmKBtmzpIH3HXukmlE/pnItUcMPovwxvEuN8pZHdLjueZ6tvFw2uM6ReywhXcgykMapa6u8halq5vXxPZ9ZGCR4OT0Jh+GiBICBVPCpd1e2Ka0S3wNy2Hez4vur/WUX/VFiFghtLYpmZnVw+1CVrGBBd1Vwo9sfI8AipZa2jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zbKH+RMK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kK1Wxx5y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=anl80dIj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xZzorhKN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ED7333D32;
	Wed, 15 May 2024 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715789741;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ7gK1lBQmlsoTMc1I2R4fLUioA9nrB0M5WFq7R60E4=;
	b=zbKH+RMKkyJKXwK58MczrOc3F2+jf+CTPRXi2ghzcMZMeo7VcX3Liqn7ro3miP7KYcrUXM
	MYPkND/TvNxxKUYVfrahwWsUrGZdEQWFRzH2jjoMxVrukS1NepbQO6NK8OQprX2k9uh2B4
	Nfy0dDZ28i1qJ55JzAzILGRGNvc+mTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715789741;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ7gK1lBQmlsoTMc1I2R4fLUioA9nrB0M5WFq7R60E4=;
	b=kK1Wxx5yAGe24p6Z6ifaHRO8Z/jMBCgZO7P0UhqNdU1pTcUibyAB049W+JyGkr/nevcJYr
	/mbbN6DDt1qkkSAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715789739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ7gK1lBQmlsoTMc1I2R4fLUioA9nrB0M5WFq7R60E4=;
	b=anl80dIjfsxyjIbj6aThW8jiHNmVIkBlj+IAnAxGuXnAOmMNVxjkMIoRE0xhBJrKFpi2fl
	lisAl2Furjy5aeaW6chHK8G/AO2mw8zWw/Hf3ENkCtZ9Erv+25+TB0SCZPuy+8OcZXoJRR
	y05KfRZjG66ntQtul0hWzUkgRQI6wc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715789739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ7gK1lBQmlsoTMc1I2R4fLUioA9nrB0M5WFq7R60E4=;
	b=xZzorhKNHZLsTGeeiuu4kw0FpxSLyG95eiuxQJEoc7nwKyZCwBqv44HajvQw/KEVxSC+Gf
	VBOtASO1+IESzcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D6C1372E;
	Wed, 15 May 2024 16:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X5OxNqrfRGYaFAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 16:15:38 +0000
Date: Wed, 15 May 2024 18:15:37 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: kernel BUG at fs/inode.c:LINE! (2)
Message-ID: <20240515161537.GP4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240515161314.GO4449@twin.jikos.cz>
 <0000000000007147c206188065ca@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007147c206188065ca@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: 0.27
X-Spam-Level: 
X-Spamd-Result: default: False [0.27 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.23)[89.45%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[c92c93d1f1aaaacdb9db];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]

On Wed, May 15, 2024 at 09:13:17AM -0700, syzbot wrote:
> > On Fri, Aug 28, 2020 at 06:18:17AM -0700, syzbot wrote:
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    d012a719 Linux 5.9-rc2
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
> >> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000
> >> 
> >> The issue was bisected to:
> >> 
> >> commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
> >> Author: Marc Zyngier <maz@kernel.org>
> >> Date:   Wed Aug 19 16:12:17 2020 +0000
> >> 
> >>     epoll: Keep a reference on files added to the check list
> >> 
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a50519900000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a50519900000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=11a50519900000
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com
> >> Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")
> >> 
> >> ------------[ cut here ]------------
> >> kernel BUG at fs/inode.c:1668!
> >
> > #syz set subsystem: fs
> 
> The specified label "subsystem" is unknown.
> Please use one of the supported labels.

#syz set subsystems: fs

