Return-Path: <linux-fsdevel+bounces-13848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D4874AD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28211C212E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC783A07;
	Thu,  7 Mar 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6w0vWuG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/AQk1ks";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6w0vWuG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/AQk1ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AD6F50D;
	Thu,  7 Mar 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803691; cv=none; b=c/hjaTGPAacw09YH/X3490J1Kki27bIQdVU09hW0ByPgl7DYveoaPKNHM51Y/TaZrnUFziv6mt3D7Y/h+LAVL7UKTfb+kGRVEp/mPTJvQtK4UMCOKZzk/xJX7dvViM6RcFei2l6ML8D3njltqlw5XTo1bl+0ceLvVbrxUeeDMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803691; c=relaxed/simple;
	bh=nz7xYhjPgR+k2P+R36G4p2fLnGFIgKuusPB9cxERIDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtESEckDDvkuchayQgYBMpLTDHdjG/+AMyUynFQLWZ5cfzG8+GV1jqBK3bsBnl4bpOgOnQ/9OL9sE017Le78pkzwi3Ojn9HBvm7HYGdyM1cM7rTCzjlnJZj0yOuPmn6njH/FOJ7m+pTQyEcANmy5s2aPfVmSiVWTV9irUNDVCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6w0vWuG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/AQk1ks; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6w0vWuG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/AQk1ks; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B18734D3C;
	Thu,  7 Mar 2024 09:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709803517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+ugExIOwHThY92Q+DIFd3j6pfBZQ+SQxZDMAbZwm3k=;
	b=e6w0vWuGi9jbOVMgCGKn594YJFgf0EUGg3FVUT/cZYTZs4RxSZY10A4rLDMCZhaRyH3Qyd
	fD8mDN/KWRukdjuxI2Vahe9tT0cxwMWmMMGbxwMNk1lGwM66JNJT5hyGrGg1gKWvtHAYXx
	Vs1YifDzT1BWdG1JzUtj8SSohPkOHE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709803517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+ugExIOwHThY92Q+DIFd3j6pfBZQ+SQxZDMAbZwm3k=;
	b=S/AQk1ksNINSe/dxm9r3vJubFKxB7C9PQTEEvTf9P+jv4YlF9MTNc+wYbSBGb54qAHbMNf
	SBdbv87Q9FzV9ACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709803517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+ugExIOwHThY92Q+DIFd3j6pfBZQ+SQxZDMAbZwm3k=;
	b=e6w0vWuGi9jbOVMgCGKn594YJFgf0EUGg3FVUT/cZYTZs4RxSZY10A4rLDMCZhaRyH3Qyd
	fD8mDN/KWRukdjuxI2Vahe9tT0cxwMWmMMGbxwMNk1lGwM66JNJT5hyGrGg1gKWvtHAYXx
	Vs1YifDzT1BWdG1JzUtj8SSohPkOHE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709803517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+ugExIOwHThY92Q+DIFd3j6pfBZQ+SQxZDMAbZwm3k=;
	b=S/AQk1ksNINSe/dxm9r3vJubFKxB7C9PQTEEvTf9P+jv4YlF9MTNc+wYbSBGb54qAHbMNf
	SBdbv87Q9FzV9ACg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67388132A4;
	Thu,  7 Mar 2024 09:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kgPiGP2H6WUoGwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Mar 2024 09:25:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DEA8A0803; Thu,  7 Mar 2024 10:25:17 +0100 (CET)
Date: Thu, 7 Mar 2024 10:25:17 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+ca4b16c6465dca321d40@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: trying to register non-static key in txEnd
Message-ID: <20240307092517.clgkvqttd4rw6dx5@quack3>
References: <000000000000c801280606a82e95@google.com>
 <0000000000006786560612c32ff9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006786560612c32ff9@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.69
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[45.41%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b6602324d4e5a4a9];
	 TAGGED_RCPT(0.00)[ca4b16c6465dca321d40];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sun 03-03-24 07:23:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e0e374180000
> start commit:   c7402612e2e6 Merge tag 'net-6.7-rc6' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b6602324d4e5a4a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca4b16c6465dca321d40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16941c8ae80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d9c3c1e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

