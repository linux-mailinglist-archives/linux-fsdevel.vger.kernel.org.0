Return-Path: <linux-fsdevel+bounces-32349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA479A3E50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA9D1C241B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE8E42A97;
	Fri, 18 Oct 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kh4caILb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kOIhd72p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kh4caILb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kOIhd72p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9B8F6B;
	Fri, 18 Oct 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254351; cv=none; b=KrqPrGPiR2pO37mmM6f2cAM/1mdNX6g98AK3v6cPic8vWvAK/slDvR2VTHR35o+5/l6j+7WjzGpiOYHIMfbf9jbT/kvP+nCaBNfeHADAPpEvnbpFeciWGotcK/lV6k8hCuDeNy363IYSCwo9n1Y3R7n+SEsPCf1s4CHWocrRxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254351; c=relaxed/simple;
	bh=vC1SX+wQnWxFmlQXkUP9yy/5qcQeEuByw8RrPHIZU4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJG7hSGUd048ZTeMUgPdO/hpMI/rAzdStd4fEqewn3bsXRo40jeVoXhexQTscBudfwKHoZ9Dt5Jf0RgCHcRq7srEHcE3ZiGC6bSDtTvtDCslJN9WIivlU99xlKd+YF3LcFJJZSHSRadcTPR5i/Wz4oyyEzXChrkh13lFlRS+okQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kh4caILb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kOIhd72p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kh4caILb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kOIhd72p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A85771FDCC;
	Fri, 18 Oct 2024 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729254347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9iA959EP4BEcv5e0iqenlfp8hBxwbKWSp7/y27GQG0=;
	b=Kh4caILb21FroSrjSfslzo7L1cIJsZXI/iUVt5zKaWqTPHHslBvq3KBcBpiqxFuBYti31o
	Tja/3GkrVl9czOmtnpNlDZq5x59MKOQO6dI4Nu/3w6DyXzYmZUi4+OHERpYSBbUlLfy1PP
	xZCDC1vyxxqX4UurZ05DhFvn7ogwhZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729254347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9iA959EP4BEcv5e0iqenlfp8hBxwbKWSp7/y27GQG0=;
	b=kOIhd72poBPwiAFQalmin4nWTsOL9OmmWECpnFVb30gl9DIEWmFeWt8KxbfYmgvLbuKGJ/
	gu4E/b49ygg+9sCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Kh4caILb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kOIhd72p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729254347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9iA959EP4BEcv5e0iqenlfp8hBxwbKWSp7/y27GQG0=;
	b=Kh4caILb21FroSrjSfslzo7L1cIJsZXI/iUVt5zKaWqTPHHslBvq3KBcBpiqxFuBYti31o
	Tja/3GkrVl9czOmtnpNlDZq5x59MKOQO6dI4Nu/3w6DyXzYmZUi4+OHERpYSBbUlLfy1PP
	xZCDC1vyxxqX4UurZ05DhFvn7ogwhZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729254347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9iA959EP4BEcv5e0iqenlfp8hBxwbKWSp7/y27GQG0=;
	b=kOIhd72poBPwiAFQalmin4nWTsOL9OmmWECpnFVb30gl9DIEWmFeWt8KxbfYmgvLbuKGJ/
	gu4E/b49ygg+9sCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99C2513433;
	Fri, 18 Oct 2024 12:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M12CJctTEmcAEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 12:25:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51C59A080A; Fri, 18 Oct 2024 14:25:43 +0200 (CEST)
Date: Fri, 18 Oct 2024 14:25:43 +0200
From: Jan Kara <jack@suse.cz>
To: Paul Moore <paul@paul-moore.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"audit@vger.kernel.org" <audit@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241018122543.cxbbtsmeksegoeh3@quack3>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
 <CAHC9VhR=-MMA3JoUABhwdqkraDp_vvsK2k7Nh0NA4yomtn855w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR=-MMA3JoUABhwdqkraDp_vvsK2k7Nh0NA4yomtn855w@mail.gmail.com>
X-Rspamd-Queue-Id: A85771FDCC
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 17-10-24 16:21:34, Paul Moore wrote:
> On Thu, Oct 17, 2024 at 1:05 PM Jeff Layton <jlayton@kernel.org> wrote:
> > On Thu, 2024-10-17 at 11:15 -0400, Paul Moore wrote:
> > > On Thu, Oct 17, 2024 at 10:58 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > On Thu, Oct 17, 2024 at 10:54:12AM -0400, Paul Moore wrote:
> > > > > Okay, good to know, but I was hoping that there we could come up with
> > > > > an explicit list of filesystems that maintain their own private inode
> > > > > numbers outside of inode-i_ino.
> > > >
> > > > Anything using iget5_locked is a good start.  Add to that file systems
> > > > implementing their own inode cache (at least xfs and bcachefs).
> > >
> > > Also good to know, thanks.  However, at this point the lack of a clear
> > > answer is making me wonder a bit more about inode numbers in the view
> > > of VFS developers; do you folks care about inode numbers?  I'm not
> > > asking to start an argument, it's a genuine question so I can get a
> > > better understanding about the durability and sustainability of
> > > inode->i_no.  If all of you (the VFS folks) aren't concerned about
> > > inode numbers, I suspect we are going to have similar issues in the
> > > future and we (the LSM folks) likely need to move away from reporting
> > > inode numbers as they aren't reliably maintained by the VFS layer.
> > >
> >
> > Like Christoph said, the kernel doesn't care much about inode numbers.
> >
> > People care about them though, and sometimes we have things in the
> > kernel that report them in some fashion (tracepoints, procfiles, audit
> > events, etc.). Having those match what the userland stat() st_ino field
> > tells you is ideal, and for the most part that's the way it works.
> >
> > The main exception is when people use 32-bit interfaces (somewhat rare
> > these days), or they have a 32-bit kernel with a filesystem that has a
> > 64-bit inode number space (NFS being one of those). The NFS client has
> > basically hacked around this for years by tracking its own fileid field
> > in its inode.
> 
> When I asked if the VFS dev cared about inode numbers this is more of
> what I was wondering about.  Regardless of if the kernel itself uses
> inode numbers for anything, it does appear that users do care about
> inode numbers to some extent, and I wanted to know if the VFS devs
> viewed the inode numbers as a first order UAPI interface/thing, or if
> it was of lesser importance and not something the kernel was going to
> provide much of a guarantee around.  Once again, I'm not asking this
> to start a war, I'm just trying to get some perspective from the VFS
> dev side of things.

Well, we do care to not break our users. So our opinion about "first order
UAPI" doesn't matter that much. If userspace is using it, we have to
avoid breaking it. And there definitely is userspace depending on st_ino +
st_dev being unique identifier of a file / directory so we want to maintain
that as much as possible (at least as long as there's userspace depending
on it which I don't see changing in the near future).

That being said historically people have learned NFS has its quirks,
similarly as btrfs needing occasionally a special treatment and adapted to
it, bcachefs is new enough that userspace didn't notice yet, that's going
to be interesting.

There's another aspect that even 64-bits start to be expensive to pack
things into for some filesystems (either due to external protocol
constraints such as for AFS or due to the combination of features such as
subvolumes, snapshotting, etc.). Going to 128-bits for everybody seems
like a waste so at last LSF summit we've discussed about starting to push
file handles (output of name_to_handle_at(2)) as a replacement of st_ino
for file/dir identifier in a filesystem. For the kernel this would be
convenient because each filesystem can pack there what it needs. But
userspace guys were not thrilled by this (mainly due to the complexities of
dynamically sized identifier and passing it around). So this transition
isn't currently getting much traction and we'll see how things evolve.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

