Return-Path: <linux-fsdevel+bounces-20809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4C8D812F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AF51C21107
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D9684A5A;
	Mon,  3 Jun 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6W/tjwL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2RIwMKT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="flPfk7AO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FUz/Pj4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6482C6A3;
	Mon,  3 Jun 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414035; cv=none; b=p8kD0k5JkZyR3doAe5gJmsVR/RbCG0MtsxjD6PVFb29dYlzVbszi4EwmjBSKGwjtPfKOtCtbGwlTlklO7MhUMk97ZHSUH1NzhAGV/MPar3xZdJcYitHeseCbT/5l3zlilZAw6LvyKBkFdgfBQrVQzazFHWiJwnESWHzPQVJ0O3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414035; c=relaxed/simple;
	bh=cJPnpg2hCwgHukR1vYoWJ+DVnA03/FFtOwtTCUJ8wkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMs2O09di+tB4XMzUfMUv/nXqsLLfeTKOLs4EwYrOkWKppwk7D+uRuivGFsQekBYqaX9r+tu8UdjKofIzZ5xoCPq9uCpJ+LalTB1Iy6pUFZs/lAnQlyjCrHA1BbYcEd2p+yXpi3NQYYr5rRELQAtzEE2NMeyBw51FL2L5Xe8lCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6W/tjwL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p2RIwMKT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=flPfk7AO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FUz/Pj4g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63A272224D;
	Mon,  3 Jun 2024 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717414031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pfFFXzKIW4SMjbgPuQqcNQPPQGz7PtcZJ46Fj089Is=;
	b=y6W/tjwLyJFxYOMqAVNiil/WQmavDW8lR/py1GpPK1u/XNM6fc+gV0qTEt47HpLOW1/hh5
	PxMOJvMm4dp6wluFyY5UtrEO0BIEH67CI8b0a4TdpSMtj1pS+ULuY7XCKL7hK+gy1lSLAA
	I6CDN8g9JIBJoxujiCClmPECcCM4g00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717414031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pfFFXzKIW4SMjbgPuQqcNQPPQGz7PtcZJ46Fj089Is=;
	b=p2RIwMKT1kTsj9NXcpvegHJol5lw/KUIDeHqirTbn039oAQbu8V8mzDa3yH6SBTEjIrlTa
	ts0FHhDL8vR+S0Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=flPfk7AO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="FUz/Pj4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717414030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pfFFXzKIW4SMjbgPuQqcNQPPQGz7PtcZJ46Fj089Is=;
	b=flPfk7AOOeYAnUfLtCpiJv36/Q16dFQN4aXjltYqF/2fKTOb1Xw4Qoxp34/tZvKvR5tb1K
	Pav9u71FY5VZRtJowJ4bon3w0m134DzwyfCGDFQSW6S6Msg2qSpjft255ZXFkLlexH4Sjf
	8REr4OA0CUrTdkFoqT27hgkFO7z1znY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717414030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pfFFXzKIW4SMjbgPuQqcNQPPQGz7PtcZJ46Fj089Is=;
	b=FUz/Pj4gT+sjqZWtu+0NyY8suUgunZRzh1/vNXe92rZEbWS7Ha0DJnNTVHro4FGrP5i/C9
	29QjW+mtQUuUzOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59687139CB;
	Mon,  3 Jun 2024 11:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nr/PFY6oXWb/JwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 11:27:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0799EA087F; Mon,  3 Jun 2024 13:27:05 +0200 (CEST)
Date: Mon, 3 Jun 2024 13:27:05 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
Message-ID: <20240603112705.hafr4gh5foxccw7f@quack3>
References: <00000000000054d8540619f43b86@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000054d8540619f43b86@google.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.92 / 50.00];
	BAYES_HAM(-2.41)[97.28%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[42986aeeddfd7ed93c8b];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 63A272224D
X-Spam-Flag: NO
X-Spam-Score: -0.92
X-Spamd-Bar: /

On Sun 02-06-24 20:50:18, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1466269a980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
> dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a5b3ec980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103820f2980000

Based on strace (and also the reproducer) this looks purely in exfat
driver. So:

#syz set subsystems: exfat

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

