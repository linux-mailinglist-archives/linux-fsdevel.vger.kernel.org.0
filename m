Return-Path: <linux-fsdevel+bounces-11997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E585A262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C55A283BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5622C856;
	Mon, 19 Feb 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PIRjpJoK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eizLTF4s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AGxB46Wv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="taNCoXnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2F28DBD;
	Mon, 19 Feb 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343250; cv=none; b=rz777X+g8W41Ae1cuYacLp5C18iOC5M2v8WS3jJsiorfI40Xk/o7V0fdqAReWUPgQFCRJn6V2D4vn8dw+gDg0yYGqAdiQVvOznksi2WY5YsIrjjVVrVNkNT2c9wPCJy/9rOe9PEf7bEf7TuJGDpmoPyt6YnYI+Ry/GWeHSyvsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343250; c=relaxed/simple;
	bh=SCzSVDeXhJh0zIbeBglTZd4xn7FK70eXZH9Wgo5j/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMH2g3g42qXr+JxNXoAwBo9VkJNGn47WygzQr1Tic5m0VsplbupCs0BHKgigN3ec1d0DbcQl5MTV+t/LPfeyaJ1AIz45I75arDmfkodYuhhwdRN+JVTolk4HN5w4y2NpqNJQxLkCSCH+ToTTKWzu7fyCzz3H19BnvPIjlpSDsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PIRjpJoK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eizLTF4s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AGxB46Wv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=taNCoXnS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C496A2231F;
	Mon, 19 Feb 2024 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HW1O8/0Ek2CVqztQkYAK9/MsoJrJt80t5MZg8IQsq0=;
	b=PIRjpJoKsye+XABw41EC1SvhJf8KDgpfk+8t9Sz/gPiS8ZmMYYgS57/imtPArptapRi+0j
	kAS4kZVRKX+ngzERASp8mNDrFMG0V+62B+bdH9/MVH03VwQb6AcT+jimE2fVbxnf55cC3c
	CMfsn+lnvfhs9Hb6VqoXSLsRJ11ZjL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HW1O8/0Ek2CVqztQkYAK9/MsoJrJt80t5MZg8IQsq0=;
	b=eizLTF4s3ePFkFwKSwMLtkIme5ckMcu693XFtQFdR1ZPUYmlJRV+VeQHxv1gyzij4+YY83
	p36jkYU1Pn1cowDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HW1O8/0Ek2CVqztQkYAK9/MsoJrJt80t5MZg8IQsq0=;
	b=AGxB46Wvp8LJasWBCsG7x7y4vc2KtMHqEZBCntJqhmCo57QcmulsEZqZp4uIW2+seLWdrL
	4PucXURDDxjU/yF+Vm7/FhGa3J/o3qRMZ9TBhisZvP4gGVIKlipa9RfUTVsyDvY5iqhe2e
	VlI7SPOBtdczh1kfOiJPu+gUj7upDU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HW1O8/0Ek2CVqztQkYAK9/MsoJrJt80t5MZg8IQsq0=;
	b=taNCoXnSCyevd55YOeoz9Lur0PEBKmpjgaV8JSqenHpZ8CqxIHxJBpjk9xQvdrmwINoFeB
	Mn1y+sf0zShB7mBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A78F113585;
	Mon, 19 Feb 2024 11:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gbbmKMw/02USbgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:47:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ED0B2A0806; Mon, 19 Feb 2024 12:47:19 +0100 (CET)
Date: Mon, 19 Feb 2024 12:47:19 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+4936b06b07f365af31cc@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_set_link
Message-ID: <20240219114719.pyntouzverbsk4da@quack3>
References: <000000000000375f00060eb11585@google.com>
 <00000000000029d2820611a09994@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000029d2820611a09994@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.70
X-Spamd-Result: default: False [1.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[34.64%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b];
	 TAGGED_RCPT(0.00)[4936b06b07f365af31cc];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,suse.cz,gmail.com,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sat 17-02-24 20:42:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10639b34180000
> start commit:   52b1853b080a Merge tag 'i2c-for-6.7-final' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
> dashboard link: https://syzkaller.appspot.com/bug?extid=4936b06b07f365af31cc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d62025e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c38055e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

The reproducers don't seem to be doing anything suspicious so I'm not sure
why the commit makes them not work anymore. There are no working
reproducers for this bug though so I'll leave it upto the nilfs maintainer
to decide what to do.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

