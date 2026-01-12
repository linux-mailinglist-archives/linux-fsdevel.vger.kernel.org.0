Return-Path: <linux-fsdevel+bounces-73220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53AD12658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B60F30A0F67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5293570D0;
	Mon, 12 Jan 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOs2C5D6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ehLoPK+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOs2C5D6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ehLoPK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2429732E757
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218658; cv=none; b=AW26exlxRK1AdlUuWUBA9ARxUKAqWHni5VNimkYjPKlnMj7bAa+eJQmyhKNRwMbe3HfVoazg+mHYV6O44vCL22fFxWqNwFm4eVFAe6/D2l6qBaFooCouuYFTTWLzmiOTevVqGKoEoyfrQ5mBE7l1VgwVkHN1P0SnwmwgYJoPJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218658; c=relaxed/simple;
	bh=pH974f3Bn5I4WcK029aYk1ZeT6uhpcMVBUmytK9RH+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGy1jmWoJjT6SiSpfnoGQaWzJfQNg10cTymIfFgqJ2zCTyK4Z+IAQAIO/pdoG460Xj+uvwYqsevT6x3IJq1pmKWt3x7lsXI695Kw2/ewTMC9WPhVQwLi06ZbdWsB+1odHXgGz9zhqU8+WSpLTroXb4h0vYw/83PX71GtTU9PbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OOs2C5D6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ehLoPK+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OOs2C5D6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ehLoPK+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E47133723;
	Mon, 12 Jan 2026 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768218655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJPRRt3ImAG8Vp3pEixELMQW+2ButA7EIv5F6kzOPXw=;
	b=OOs2C5D65/1Xvnpr3A5vvhu41RTQsKgtILa8MPYg/FeAGI1YIZFTy9NZpgGjSCBe2YQyrs
	j6Y54cuSLdk+x+WT0/JlaeMyqm2V+bAT0C5xVfcim96RhkbOHYlY45y57NgP5fjnKEC6Jl
	XoVta3a5es+hkIPONazG7Xwej4b9RwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768218655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJPRRt3ImAG8Vp3pEixELMQW+2ButA7EIv5F6kzOPXw=;
	b=5ehLoPK+Ub0MfiFWdRBvKZ1ojs2HLybkVBTe483VVq//MO3sBOciRlVlwYWMUd3YUio7Md
	zWroBdDblgLp3dBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OOs2C5D6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5ehLoPK+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768218655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJPRRt3ImAG8Vp3pEixELMQW+2ButA7EIv5F6kzOPXw=;
	b=OOs2C5D65/1Xvnpr3A5vvhu41RTQsKgtILa8MPYg/FeAGI1YIZFTy9NZpgGjSCBe2YQyrs
	j6Y54cuSLdk+x+WT0/JlaeMyqm2V+bAT0C5xVfcim96RhkbOHYlY45y57NgP5fjnKEC6Jl
	XoVta3a5es+hkIPONazG7Xwej4b9RwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768218655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJPRRt3ImAG8Vp3pEixELMQW+2ButA7EIv5F6kzOPXw=;
	b=5ehLoPK+Ub0MfiFWdRBvKZ1ojs2HLybkVBTe483VVq//MO3sBOciRlVlwYWMUd3YUio7Md
	zWroBdDblgLp3dBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 348EC3EA63;
	Mon, 12 Jan 2026 11:50:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ny7LDB/gZGl8SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Jan 2026 11:50:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EEA11A0A7E; Mon, 12 Jan 2026 12:50:54 +0100 (CET)
Date: Mon, 12 Jan 2026 12:50:54 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jkoolstra@xs4all.nl, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
Message-ID: <nns4dlqdzmet57xttlpp3ucdhejsoruzwx3qozy4q5aq3mz6tw@adzysckevosv>
References: <6740d107.050a0220.3c9d61.0195.GAE@google.com>
 <69647763.050a0220.eaf7.0084.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69647763.050a0220.eaf7.0084.GAE@google.com>
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d9ebb51ccc2ec42f];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,xs4all.nl,vger.kernel.org,gmail.com,googlegroups.com,mit.edu,zeniv.linux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[320c57a47bdabc1f294b];
	DKIM_TRACE(0.00)[suse.cz:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 3E47133723
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Sun 11-01-26 20:24:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 009a2ba40303cb1e3556c41233338e609ac509ea
> Author: Jori Koolstra <jkoolstra@xs4all.nl>
> Date:   Tue Nov 4 14:30:05 2025 +0000
> 
>     Fix a drop_nlink warning in minix_rename
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152d65fa580000
> start commit:   c0c9379f235d Merge tag 'usb-6.16-rc1' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d9ebb51ccc2ec42f
> dashboard link: https://syzkaller.appspot.com/bug?extid=320c57a47bdabc1f294b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f409d4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1044ec0c580000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Looks correct:

#syz fix: Fix a drop_nlink warning in minix_rename

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

