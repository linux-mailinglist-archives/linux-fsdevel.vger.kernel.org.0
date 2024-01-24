Return-Path: <linux-fsdevel+bounces-8691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2983A642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152EC1C22D6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F0418E37;
	Wed, 24 Jan 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aiLQxVbu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8A5wySg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YSCKWoDg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0PF6S6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6B18E0C;
	Wed, 24 Jan 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090487; cv=none; b=EhhgTqqw5dE8EaXaWftf8KqVm3UVVYdhah2yk2FXCT1DnmYFbOREDBvCqZWcrh65S+iX7S++AXzEaOofLEyBE+qsSV7zsoiaOKOSJznoYZdRZnkywRLlaUt/Ak60WbSuTdAY8qtUGaBemlMYpP8qKGO6B0sUyK+nhJnwIiQTeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090487; c=relaxed/simple;
	bh=6RdrlxDSG8hsAc72E55qkn9THWxTOLO7Jy0CRSHrLnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz6RASxmTjHR8TWbRol9C+jZO6/1bgusaF1UaGwtVUkQq7m8o+GhAzE3rxqew+ODcH0qNoXC1NMXd04+LDA82Z7NGm2nwGmf63lcDEptI5cqdlN/4Hbvua7DXb4+zRChs14oOC9u51aWE4Mlh/DjQY8ZW4JxR0IrovF5fMOnRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aiLQxVbu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8A5wySg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YSCKWoDg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0PF6S6B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AAA321FE0;
	Wed, 24 Jan 2024 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706090482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GbOmVt6oFKgK+k7wbfOq9ydRZzfYO9V5/Y2eqOkhTw=;
	b=aiLQxVbuM4h8WeFZzWlEy6ymisyOydc25AD9QvcYPr6+al3UNEEJTAcFCh0tfrhVKuYFu6
	9d0nmBE0mSvPqS3ER2KSYyptEH0qCQNulIbP8GBTDufT+sLCMxN+jyKkBeXEQuphJc+CJg
	VDy/QVsl+CgKbiVjX9jlVpmUuv1x7rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706090482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GbOmVt6oFKgK+k7wbfOq9ydRZzfYO9V5/Y2eqOkhTw=;
	b=O8A5wySg8/1PFTSGWC0kFH8FK1sOeMd6t15ot7TyqRmlKbKqL7/CnGX5ImKTwCyDw+oS6M
	xNTPwuU5nOLZ9aDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706090481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GbOmVt6oFKgK+k7wbfOq9ydRZzfYO9V5/Y2eqOkhTw=;
	b=YSCKWoDgns404OGWP7Dr8/4KblkejC/L5rV6mNaptJ3f6nzuL8Erm0fZ9XTtxluG6UnrJZ
	Bgr5bZyz5n8yDHJinxhKqSSLU6iNfYgQ1wDSbU+mu9bsmk7unSCdL9+ORaZF3cfA5H9QzW
	yzWGKHHM8WbKABcF17q3qq8FuTgoHL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706090481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GbOmVt6oFKgK+k7wbfOq9ydRZzfYO9V5/Y2eqOkhTw=;
	b=k0PF6S6B91e8zCjslnl5MkSwU/Fb5Ax1xfl+/aMmL2DE6yOKFT3a49dpCWyDICamg9m6Py
	/PopjBYF6gklrbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D5781333E;
	Wed, 24 Jan 2024 10:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zvn2DvHfsGVlAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jan 2024 10:01:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3042A0808; Wed, 24 Jan 2024 11:01:20 +0100 (CET)
Date: Wed, 24 Jan 2024 11:01:20 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+87466712bb342796810a@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com,
	dchinner@redhat.com, djwong@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in
 xfs_filestream_select_ag
Message-ID: <20240124100120.x3mwjbj7epfw3ffo@quack3>
References: <000000000000d207ef05f7790759@google.com>
 <00000000000084a9da060fad26bf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000084a9da060fad26bf@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YSCKWoDg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k0PF6S6B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[20.22%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7];
	 TAGGED_RCPT(0.00)[87466712bb342796810a];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 4AAA321FE0
X-Spam-Flag: NO

On Wed 24-01-24 00:50:10, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119af36be80000
> start commit:   17214b70a159 Merge tag 'fsverity-for-linus' of git://git.k..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
> dashboard link: https://syzkaller.appspot.com/bug?extid=87466712bb342796810a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1492946ac80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e45ad6c80000

So this surprises me a bit because XFS isn't using block device buffer
cache and thus syzbot has no way of corrupting cached metadata even before
these changes. The reproducer tries to mount the loop device again after
mounting the XFS image so I can imagine something bad happens but it isn't
all that clear what. So I'll defer to XFS maintainers whether they want to
mark this bug as fixed or investigate further.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

