Return-Path: <linux-fsdevel+bounces-8046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B482ECCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A7428414A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5D13FE9;
	Tue, 16 Jan 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUjj34+/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rs3CFGf2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUjj34+/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rs3CFGf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF113AF1;
	Tue, 16 Jan 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AE5F1FB92;
	Tue, 16 Jan 2024 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZgzZ9FXGsbBFgaVLyt5/yEDusbRz3pgCLbcpy3ZbLs=;
	b=OUjj34+/9ikg1e0fSg6vUsbeqxzJi3ThoKTp3H6C/moaXBnrArx0vUBKntGFVJG5OMEOvF
	2r4Q6h2c0EFAdg+mwreycO7n3iQVdekPHxlpZHMBEwgwakYzgQto2W6gztIrjUELvZPIJt
	pZeQ/t9R6zMsL5CUz6qsi33XWMrfU4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705401181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZgzZ9FXGsbBFgaVLyt5/yEDusbRz3pgCLbcpy3ZbLs=;
	b=Rs3CFGf2Iecmqxto/0+HDwQV/Oc6jANKlu9ZIERBUJyiI+KuHFDDrTTHqv4kWT8EzRAQd1
	VD+3NTFSYy+AwBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZgzZ9FXGsbBFgaVLyt5/yEDusbRz3pgCLbcpy3ZbLs=;
	b=OUjj34+/9ikg1e0fSg6vUsbeqxzJi3ThoKTp3H6C/moaXBnrArx0vUBKntGFVJG5OMEOvF
	2r4Q6h2c0EFAdg+mwreycO7n3iQVdekPHxlpZHMBEwgwakYzgQto2W6gztIrjUELvZPIJt
	pZeQ/t9R6zMsL5CUz6qsi33XWMrfU4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705401181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZgzZ9FXGsbBFgaVLyt5/yEDusbRz3pgCLbcpy3ZbLs=;
	b=Rs3CFGf2Iecmqxto/0+HDwQV/Oc6jANKlu9ZIERBUJyiI+KuHFDDrTTHqv4kWT8EzRAQd1
	VD+3NTFSYy+AwBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE7B813751;
	Tue, 16 Jan 2024 10:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JBgrOlxbpmWCKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jan 2024 10:33:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 77EB2A0803; Tue, 16 Jan 2024 11:33:00 +0100 (CET)
Date: Tue, 16 Jan 2024 11:33:00 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org,
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
Message-ID: <20240116103300.bpv233hnhvfk3uvf@quack3>
References: <00000000000057049306049e0525@google.com>
 <000000000000fa7c3b060f07d0ab@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fa7c3b060f07d0ab@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.03)[56.67%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead];
	 TAGGED_RCPT(0.00)[10c6178a65acf04efe47];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.87
X-Spam-Flag: NO

On Mon 15-01-24 19:35:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165bebf5e80000
> start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
> dashboard link: https://syzkaller.appspot.com/bug?extid=10c6178a65acf04efe47
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e4ea14680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f76f10680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 

Makes sense.

#syz fix: fs: Block writes to mounted block devices


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

