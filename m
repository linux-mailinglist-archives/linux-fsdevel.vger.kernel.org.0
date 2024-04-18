Return-Path: <linux-fsdevel+bounces-17231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C908A952C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4791C1F2278A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8B158844;
	Thu, 18 Apr 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BWkcHrD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2m/dGrmK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BWkcHrD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2m/dGrmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD431E489;
	Thu, 18 Apr 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429655; cv=none; b=sZX/fprbB+f1+duKZ7ob12LJt7fIhqzBtZLiXCNYRWZXjzI8EZNoZNGlx/EKw/petNwVPYIN8bv0/WvGKaxVVXuKr2M8ZR0tx073whIcJs2B7V+3ZtNk2J+CFC212FK2A2vlszVw1uJiidCWCCFl7VvkpieMAgxgQ21y81zimz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429655; c=relaxed/simple;
	bh=wzsQORsIYj6s/Fenr75u/noWw9XA1V6KqpGzf+bsj2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWUYCPynbmntpamxo/xRThulnQe2WnSf0ba9hqb49I5l9M4ZtYai4C7hXI7zk0XGmQhazmnpbKmXkLLr1an3aMt4RtXroDZ1TDocp5kypdJm4ToFAomGjq4Xb31N2Hvl9jM6Rpf+i7Een0n8xNNOADl1N8WIzJKgW56tm/higJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BWkcHrD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2m/dGrmK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BWkcHrD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2m/dGrmK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A48B95C704;
	Thu, 18 Apr 2024 08:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713429651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB3NxYWvxKO43qWNxBH78FaNL0CiJ3shRN52lzmNfoc=;
	b=1BWkcHrDEHsc+S0BGcomYHj1wRGh9+7Ah1M2UpiuPJpc2ggocrf+OwZPBqgjlNUN8MVJA4
	b9any/cHbhDRz1dpUAefxCkalNBxmNX65eR7gmqbgWUmy+M0rWiLUz72TuZO/WGxK4je2K
	6WtUCqJujuHjT/7hicoTDGnUYBqv/FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713429651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB3NxYWvxKO43qWNxBH78FaNL0CiJ3shRN52lzmNfoc=;
	b=2m/dGrmKWlibD+hqyauqHnyeR0rajguj/kyMJBTDRan+VU9q7NTwGKzwl2fVx2rteDVaqE
	xbSnPLQBddonmEDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1BWkcHrD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="2m/dGrmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713429651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB3NxYWvxKO43qWNxBH78FaNL0CiJ3shRN52lzmNfoc=;
	b=1BWkcHrDEHsc+S0BGcomYHj1wRGh9+7Ah1M2UpiuPJpc2ggocrf+OwZPBqgjlNUN8MVJA4
	b9any/cHbhDRz1dpUAefxCkalNBxmNX65eR7gmqbgWUmy+M0rWiLUz72TuZO/WGxK4je2K
	6WtUCqJujuHjT/7hicoTDGnUYBqv/FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713429651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB3NxYWvxKO43qWNxBH78FaNL0CiJ3shRN52lzmNfoc=;
	b=2m/dGrmKWlibD+hqyauqHnyeR0rajguj/kyMJBTDRan+VU9q7NTwGKzwl2fVx2rteDVaqE
	xbSnPLQBddonmEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98DEE13687;
	Thu, 18 Apr 2024 08:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YE1RJZPcIGadJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Apr 2024 08:40:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5287CA0812; Thu, 18 Apr 2024 10:40:51 +0200 (CEST)
Date: Thu, 18 Apr 2024 10:40:51 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+9157524e62303fd7b21c@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in jfs_commit_inode (2)
Message-ID: <20240418084051.esp56zy6ncoay3g2@quack3>
References: <000000000000e21aa80604153281@google.com>
 <000000000000a4f241061659def0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a4f241061659def0@google.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.06 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.43)[91.18%];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[9157524e62303fd7b21c];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A48B95C704
X-Spam-Flag: NO
X-Spam-Score: 0.06
X-Spamd-Bar: /

On Thu 18-04-24 00:25:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155eb8f7180000
> start commit:   4f9e7fabf864 Merge tag 'trace-v6.5-rc6' of git://git.kerne..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
> dashboard link: https://syzkaller.appspot.com/bug?extid=9157524e62303fd7b21c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101aff5ba80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d78db0680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks unlikely. The reproducer just mounts the jfs image and then a fuse
image...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

