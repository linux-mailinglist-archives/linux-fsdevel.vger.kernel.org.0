Return-Path: <linux-fsdevel+bounces-78532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MILJqR1oGmtjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:32:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837F1AA78C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02C4630B652C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA943E9F9;
	Thu, 26 Feb 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NG02SaEA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vZUpkvzU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HfOhQgRY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ou9/ol6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645A43DA5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121488; cv=none; b=Gqv9g1yM/w2dWZGDgO8rNUg55ih2y2Mb1peMRWI8AWNf2osdKh/hE9GZb7693dNnrkkMefJ0MraC/gpmh/MaHsPd1rLN33O6q2N3xBboJZG4oqXy+JkgnJR96qMCjoBEIoimkT5R2/koTQND6pobeXjxEQKQnbselzFOiiDSnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121488; c=relaxed/simple;
	bh=+3rgpsLVX9mZ19UFhL39bQlgBOJHDwAAlzpTDofRvBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7mhMNVX739nghytJi/RPN+nUMYo6+ZWFt1u/UJHYgWuFGzVzBoA1XYy9UDg2+Wq5Lev7I93vxm5Zv/e+Wfm+dGZLE2oli73vtnBfnF6cfkk5jbqnjQO+n7dERqvTh5b3E9zfKxNxjg1HTzMNdiI55322aT6ehhBFSmpHhetwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NG02SaEA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vZUpkvzU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HfOhQgRY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ou9/ol6P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BEE64D3A3;
	Thu, 26 Feb 2026 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772121475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i2DZUCnLiSh6tyQFm0xCUt8fe3VYUbhBSYNeIXhkxg=;
	b=NG02SaEAsXx+lDCSiB3amx64tqbg8TG1jtqSbe9w2ZAcGzD8OPQMQbk3OyqBnVHljB8ER3
	jwp0HDKJ5svhCCUfz9+fnrHIY0J6hxiHZvIOdeKoVHnyhkP+esATYtGuvhR9kjBcF3c8qe
	Jknj16VXc6/8W8zcnAZxMt/eClONpUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772121475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i2DZUCnLiSh6tyQFm0xCUt8fe3VYUbhBSYNeIXhkxg=;
	b=vZUpkvzU+q6hT29J0iw8lo0GnI9doWRm/MlSCNeFBZeVo2njjviIYge35511ZWhXUq3ifp
	vW7Pcr2AotFSEkCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HfOhQgRY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ou9/ol6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772121474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i2DZUCnLiSh6tyQFm0xCUt8fe3VYUbhBSYNeIXhkxg=;
	b=HfOhQgRYpIlp1Uv3yeURbbMHZIL6QVp0rbyUaqGhZyTtpKnoTpYgNp0taGnBc0EmVJvLX1
	iUO8Gb3N1niWZTU2N+uxoZn/WDVluRQcRoNsSSF6XS8dtU5p8DG1vqLi2xJSz0vFLzWVb7
	pxEU0/euYzt/JwCJlN+uH7u1llAiL3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772121474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i2DZUCnLiSh6tyQFm0xCUt8fe3VYUbhBSYNeIXhkxg=;
	b=ou9/ol6P/TAzf69n7/tN9yd3xUIGBxpNMRWF7raz3J8Jzul6LTg5BJuzyRLbLWWhk2GV/x
	p7hDo7WQr7RC+WBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 703EB3EA62;
	Thu, 26 Feb 2026 15:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p7RfG4JtoGnNegAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 15:57:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28214A0A27; Thu, 26 Feb 2026 16:57:39 +0100 (CET)
Date: Thu, 26 Feb 2026 16:57:39 +0100
From: Jan Kara <jack@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	patches@lists.linux.dev, stable@vger.kernel.org, Jakub Acs <acsjakub@amazon.de>, 
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.19-5.15] fsnotify: Shutdown fsnotify before
 destroying sb's dcache
Message-ID: <xsb2gj3d7vokquylyk3zsnzugjlojnzqyamvyouz5usqn7g2rk@ab56trnvkoq7>
References: <20260214212452.782265-1-sashal@kernel.org>
 <20260214212452.782265-85-sashal@kernel.org>
 <CAOQ4uxgKwp2FSAUwqhHN-kTBcy0DsFmLstGUY+zJWppOzTAmHA@mail.gmail.com>
 <z6nyopsvzubwxowiqxdg2yt5v6yu4i3uzlflvryjwuk2su7z4m@35ikyzqbxb46>
 <aaBUCU50P-GYMnne@laps>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaBUCU50P-GYMnne@laps>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.dev,vger.kernel.org,amazon.de,kernel.org,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-78532-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3837F1AA78C
X-Rspamd-Action: no action

On Thu 26-02-26 09:09:13, Sasha Levin wrote:
> On Tue, Feb 17, 2026 at 11:00:42AM +0100, Jan Kara wrote:
> > On Sun 15-02-26 09:11:30, Amir Goldstein wrote:
> > > On Sat, Feb 14, 2026 at 11:27 PM Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > From: Jan Kara <jack@suse.cz>
> > > >
> > > > [ Upstream commit 74bd284537b3447c651588101c32a203e4fe1a32 ]
> > > >
> > > > Currently fsnotify_sb_delete() was called after we have evicted
> > > > superblock's dcache and inode cache. This was done mainly so that we
> > > > iterate as few inodes as possible when removing inode marks. However, as
> > > > Jakub reported, this is problematic because for some filesystems
> > > > encoding of file handles uses sb->s_root which gets cleared as part of
> > > > dcache eviction. And either delayed fsnotify events or reading fdinfo
> > > > for fsnotify group with marks on fs being unmounted may trigger encoding
> > > > of file handles during unmount.
> > > 
> > > In retrospect, the text "Now that we iterate inode connectors..."
> > > would have helped LLM (as well as human) patch backports understand
> > > that this is NOT a standalone patch.
> > 
> > Good point :)
> > 
> > > Sasha,
> > > 
> > > I am very for backporting this fix, but need to backport the series
> > > https://lore.kernel.org/linux-fsdevel/20260121135513.12008-1-jack@suse.cz/
> > 
> > Yes. Without commits 94bd01253c3d5 ("fsnotify: Track inode connectors for a
> > superblock") and a05fc7edd988c ("fsnotify: Use connector list for
> > destroying inode marks") the reordering alone can cause large latencies
> > during filesystem unmount.
> 
> Looks like going even to 6.18 requires a bunch of dependencies, so a backport
> would be appreciated :)

Well, given nobody hit the race in practice (not even syzbot) and I don't
know of a way to even theoretically trigger this without CAP_SYS_ADMIN, I
don't think significant effort in fixing this is really warranted...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

