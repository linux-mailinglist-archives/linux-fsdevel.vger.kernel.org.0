Return-Path: <linux-fsdevel+bounces-14151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3B878725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5559B21388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666FE53E1E;
	Mon, 11 Mar 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EXEFYmmD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbzKss+0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EXEFYmmD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbzKss+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAC51C44;
	Mon, 11 Mar 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181218; cv=none; b=TduTpwcCDdHt9j9/nsPXkwmD35MB+f774leDhOWk/bYZCaZy1MsEykvsbMos29e9NP+bbgzizMrNsITcX9VUpX8WH7b915t6BxGDtixGtIAAM0yFdPYO49b2kiwHlWUKZ6NvIaHXzhCMaMbaELJHHdI6kCN6ePTNIFYw2fA0Xl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181218; c=relaxed/simple;
	bh=Ia/8zB3aid9jaW1fNqMVPaILNhAg9IWGYmQHIwg4Xu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqYbS/teGqdbW9dkKrK9PjScqs0i8KqT2ieEH67Gdc6ip9Z5vhTGzWc2zBCx6W5DkLSPlOdQ5wiTV1KvGSMqCktMd+h/GgVpTyu8brio6JiWpO8O7EXXyIh7ctHUo1BUOOMpVXXJGuS+Mnas3og1RiGX3JIQyy33a8A3CSF2C+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EXEFYmmD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbzKss+0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EXEFYmmD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbzKss+0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DCC55CA0F;
	Mon, 11 Mar 2024 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710181215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GN0VDG+WrM51ERqPpJDImcxlIBb+21qjCIJ03ewQ9ao=;
	b=EXEFYmmDCUATUtX0yuQV3n0vZQFuC1JDdH2/XHbfGw6zjks2HTmFgtZIZHydT1+OBbTJpz
	TIea3SdIHxWMmUCucvsgOu6DTr0la8Fm7LLURR3mPxieH9HMXp1Kf4p+K+OGAilV+E1GL2
	SQN98ApwMHAFkYEU+JtFyiUmm4h3kPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710181215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GN0VDG+WrM51ERqPpJDImcxlIBb+21qjCIJ03ewQ9ao=;
	b=sbzKss+05q+DfnN1PJOxzbHLg9PPkyrwJEYj08xHFrvzZM+biD6xQPe7eo4XkusF7Y60kU
	jMpom94x4bKQuZDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710181215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GN0VDG+WrM51ERqPpJDImcxlIBb+21qjCIJ03ewQ9ao=;
	b=EXEFYmmDCUATUtX0yuQV3n0vZQFuC1JDdH2/XHbfGw6zjks2HTmFgtZIZHydT1+OBbTJpz
	TIea3SdIHxWMmUCucvsgOu6DTr0la8Fm7LLURR3mPxieH9HMXp1Kf4p+K+OGAilV+E1GL2
	SQN98ApwMHAFkYEU+JtFyiUmm4h3kPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710181215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GN0VDG+WrM51ERqPpJDImcxlIBb+21qjCIJ03ewQ9ao=;
	b=sbzKss+05q+DfnN1PJOxzbHLg9PPkyrwJEYj08xHFrvzZM+biD6xQPe7eo4XkusF7Y60kU
	jMpom94x4bKQuZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECFA136BA;
	Mon, 11 Mar 2024 18:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OutlC19L72UCOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 18:20:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8FBDA0807; Mon, 11 Mar 2024 19:20:10 +0100 (CET)
Date: Mon, 11 Mar 2024 19:20:10 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+d62e6bd2a2d05103d105@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] kernel BUG in ntfs_iget
Message-ID: <20240311182010.7lq6ncxf7pg4hqp5@quack3>
References: <000000000000602c0e05f55d793c@google.com>
 <0000000000007717e5061282baa0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007717e5061282baa0@google.com>
X-Spam-Level: **
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[syzkaller.appspot.com:url,suse.cz:email,suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4];
	 TAGGED_RCPT(0.00)[d62e6bd2a2d05103d105];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[43.75%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 2.90
X-Spam-Flag: NO

On Thu 29-02-24 02:29:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105d5a6a180000
> start commit:   2639772a11c8 get_maintainer: remove stray punctuation when..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1358d65ee80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dbbe45e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks good.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

