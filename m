Return-Path: <linux-fsdevel+bounces-52567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869CDAE4311
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE58617EA69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285023A9BE;
	Mon, 23 Jun 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wauj8ut5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHuwDAuS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wauj8ut5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHuwDAuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D12253F08
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684905; cv=none; b=HthNvvGVluXtTjeKzeqDituxlGhyzhaYqdMex0C8YM+6e/wfkqVY/CvXv2I49V8fkjRmuoKoPI8hPgWF64fqpHp7ifedMh8Kif4eLwqWJmro47V0v3aaPX1UdY7cpBjmEtlFCPxx//TaJYYYrYEdCM7nF7C1mgdAXKq5JEbadSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684905; c=relaxed/simple;
	bh=+uF5AGnhiA2grVvvi4Gf09rB9pRdPXRwAl5kewcrWRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8LuJ5itIWbCHSXiR/Zlq5bF2gGgyLIx1EwRZVSE1BCJCDfIhAMBC387KFY0RnswYr56zL9U3TRveA0+ZKPN8hQZYrVGz2AvTVvS50N+WSktVqfsT7oL6KadzolbZTAegm2nxmhqMd3mIYzF2Uum70eNoiN0eInZkEv2wcEfovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wauj8ut5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHuwDAuS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wauj8ut5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHuwDAuS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C01341F388;
	Mon, 23 Jun 2025 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750684901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFYkGkHMQ4Wi5IGNzt716cw9I2V5K3G4ncn+1jebdmY=;
	b=Wauj8ut5wQ83ofN7bFahzPNoxghk+mDr5aUNoEUK7m8RY4QPRHbOoM27QUqF7ygfZJW8pH
	rVkp3RRBq6SJMDmRzbYQiLmnSlpFOvaCQvPmbpe1R/cpeEamY7R/HlTsC7/Q0yKEnwkbnW
	EMuxeblomQNuaYun74gfNhlbe3QqGpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750684901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFYkGkHMQ4Wi5IGNzt716cw9I2V5K3G4ncn+1jebdmY=;
	b=rHuwDAuSLdRNmkKeWXTQ0vjaRo0JbMacVLLQVy6zHQeb7YpODkMmHR8Pvr0+3IU8yuw0aN
	0wooTiLQ9DlxhgCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Wauj8ut5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rHuwDAuS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750684901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFYkGkHMQ4Wi5IGNzt716cw9I2V5K3G4ncn+1jebdmY=;
	b=Wauj8ut5wQ83ofN7bFahzPNoxghk+mDr5aUNoEUK7m8RY4QPRHbOoM27QUqF7ygfZJW8pH
	rVkp3RRBq6SJMDmRzbYQiLmnSlpFOvaCQvPmbpe1R/cpeEamY7R/HlTsC7/Q0yKEnwkbnW
	EMuxeblomQNuaYun74gfNhlbe3QqGpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750684901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFYkGkHMQ4Wi5IGNzt716cw9I2V5K3G4ncn+1jebdmY=;
	b=rHuwDAuSLdRNmkKeWXTQ0vjaRo0JbMacVLLQVy6zHQeb7YpODkMmHR8Pvr0+3IU8yuw0aN
	0wooTiLQ9DlxhgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B108813A27;
	Mon, 23 Jun 2025 13:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ooc4K+VUWWi3UQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 13:21:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9AD2A09BE; Mon, 23 Jun 2025 15:21:40 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:21:40 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
Message-ID: <nbiurss2to6tvxu2oybpyn2bjcocxal3hqjtzqjol2vw3zs3pp@m5kf4kbr4mxl>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
 <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu>
 <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner>
 <CAOQ4uxjZy8tc_tOChJ_r_FPkUxE0qrz0CxmKeJj2MZ7wyhLpBw@mail.gmail.com>
 <20250623-notstand-aufkreuzen-7e558b3b8f7e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623-notstand-aufkreuzen-7e558b3b8f7e@brauner>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C01341F388
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,oracle.com,ffwll.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 23-06-25 15:00:43, Christian Brauner wrote:
> On Mon, Jun 23, 2025 at 02:54:00PM +0200, Amir Goldstein wrote:
> > On Mon, Jun 23, 2025 at 2:25 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Mon, Jun 23, 2025 at 02:06:43PM +0200, Jan Kara wrote:
> > > > On Mon 23-06-25 11:01:30, Christian Brauner wrote:
> > > > > Various filesystems such as pidfs (and likely drm in the future) have a
> > > > > use-case to support opening files purely based on the handle without
> > > > > having to require a file descriptor to another object. That's especially
> > > > > the case for filesystems that don't do any lookup whatsoever and there's
> > > > > zero relationship between the objects. Such filesystems are also
> > > > > singletons that stay around for the lifetime of the system meaning that
> > > > > they can be uniquely identified and accessed purely based on the file
> > > > > handle type. Enable that so that userspace doesn't have to allocate an
> > > > > object needlessly especially if they can't do that for whatever reason.
> > > > >
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > >
> > > > Hmm, maybe we should predefine some invalid fd value userspace should pass
> > > > when it wants to "autopick" fs root? Otherwise defining more special fd
> > > > values like AT_FDCWD would become difficult in the future. Or we could just
> > >
> > > Fwiw, I already did that with:
> > >
> > > #define PIDFD_SELF_THREAD               -10000 /* Current thread. */
> > > #define PIDFD_SELF_THREAD_GROUP         -20000 /* Current thread group leader. */
> > >
> > > I think the correct thing to do would have been to say anything below
> > >
> > > #define AT_FDCWD                -100    /* Special value for dirfd used to
> > >
> > > is reserved for the kernel. But we can probably easily do this and say
> > > anything from -10000 to -40000 is reserved for the kernel.
> > >
> > > I would then change:
> > >
> > > #define PIDFD_SELF_THREAD               -10000 /* Current thread. */
> > > #define PIDFD_SELF_THREAD_GROUP         -10001 /* Current thread group leader. */
> > >
> > > since that's very very new and then move
> > > PIDFD_SELF_THREAD/PIDFD_SELF_THREAD_GROUP to include/uapi/linux/fcntl.h
> > >
> > > and add that comment about the reserved range in there.
> > >
> > > The thing is that we'd need to enforce this on the system call level.
> > >
> > > Thoughts?
> > >
> > > > define that FILEID_PIDFS file handles *always* ignore the fd value and
> > > > auto-pick the root.
> > >
> > > I see the issue I don't think it's a big deal but I'm open to adding:
> > >
> > > #define AT_EBADF -10009 /* -10000 - EBADF */
> > >
> > > and document that as a stand-in for a handle that can't be resolved.
> > >
> > > Thoughts?
> > 
> > I think the AT prefix of AT_FDCWD may have been a mistake
> > because it is quite easy to confuse this value with the completely
> > unrelated namespace of AT_ flags.
> > 
> > This is a null dirfd value. Is it not?
> 
> Not necessarily dirfd. We do allow direct operations of file descriptor
> of any type. For example, in the mount api where you can mount files
> onto other files.
> 
> > 
> > FD_NULL, FD_NONE?
> 
> FD_INVALID, I think.
> 
> > 
> > You could envision that an *at() syscalls could in theory accept
> > (FD_NONE , "/an/absolute/path/only", ...
> > 
> > or MOUNTFD_NONE if we want to define a constant specifically for
> > this open_by_handle_at() extension.
> 
> I think this is useful beyond open_by_handle_at().

Yes, defining FD_INVALID seems like useful addition that may become useful
in other cases in the future as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

