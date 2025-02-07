Return-Path: <linux-fsdevel+bounces-41166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7FA2BC45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118601889462
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D413232386;
	Fri,  7 Feb 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mdoH9hHQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LFyY7PfD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mdoH9hHQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LFyY7PfD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170671A2C0B;
	Fri,  7 Feb 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913421; cv=none; b=oHgQ2EIZ4sFMQpaSjB4aDCp5Ts80yvi202PJqJQdwBB8/oCvpx1aEkOIteomk98C/D7/wlHpMIA94m+SyBiIT/ro2W8nEjS0ApMAhiHJ7b2pMB4nxKzYETv/gZUNI5ZOwJ6cnEcyeL/J9ctBNQWrX9tUBaVNpOjj8cgd4+PCiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913421; c=relaxed/simple;
	bh=Ypa6JVpcLYsHkslflRSol+aoU3IqgScPIjxA3Tar2nI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XIs2doni6njZsJdIBZX7pa8bEi3TsUECA/jjfLo19vX4bWYyX2dewNhQgqhJe7eIIrb7MwA8NKjex8iPomjt7tbePlieA8K0kSL93my2GelwNQRHJkLISV49CnhHcDO9P/nBu9QaTAUpTqLENcJFcU8DHiTXJI4KUb8JHr/1e1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mdoH9hHQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LFyY7PfD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mdoH9hHQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LFyY7PfD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ACF31F443;
	Fri,  7 Feb 2025 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738913418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azGmcD+lFtdjZRrYJSsfQju7n1gQphxNEq9pNxlsrbc=;
	b=mdoH9hHQz5RshyD3oqq6k19PGCXSLwuZ1Z6SpFXH6dFev9Lmg7f2q4Ve5A8/Z6fWiV0Q/J
	OXOzQNPQcmIW+FwQFwZylqH4vJ1yk0GPxjYpgmnIJX4Zeoz+WxIlhC+cofQe/rNWcU2cKS
	m462jBcyqHjghtCA4f/ntoAyD4Z6uAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738913418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azGmcD+lFtdjZRrYJSsfQju7n1gQphxNEq9pNxlsrbc=;
	b=LFyY7PfD7zJ0yaUcy7beyg93gzA1j0CzccDXrZ7Y7y9VAXcB/X5qFIp/3iIuEOp3nX1kv9
	BLSw3/VTxrVuSBAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738913418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azGmcD+lFtdjZRrYJSsfQju7n1gQphxNEq9pNxlsrbc=;
	b=mdoH9hHQz5RshyD3oqq6k19PGCXSLwuZ1Z6SpFXH6dFev9Lmg7f2q4Ve5A8/Z6fWiV0Q/J
	OXOzQNPQcmIW+FwQFwZylqH4vJ1yk0GPxjYpgmnIJX4Zeoz+WxIlhC+cofQe/rNWcU2cKS
	m462jBcyqHjghtCA4f/ntoAyD4Z6uAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738913418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azGmcD+lFtdjZRrYJSsfQju7n1gQphxNEq9pNxlsrbc=;
	b=LFyY7PfD7zJ0yaUcy7beyg93gzA1j0CzccDXrZ7Y7y9VAXcB/X5qFIp/3iIuEOp3nX1kv9
	BLSw3/VTxrVuSBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9093B13694;
	Fri,  7 Feb 2025 07:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QxfhEIO2pWd4OQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 07:30:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
In-reply-to: <lfzaikkzt46fatqzqjeanxx2m2cwll46mqdcbizph22cck6stw@rhdne3332qdx>
References:
 <>, <lfzaikkzt46fatqzqjeanxx2m2cwll46mqdcbizph22cck6stw@rhdne3332qdx>
Date: Fri, 07 Feb 2025 18:30:00 +1100
Message-id: <173891340026.22054.12085488968187293785@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, Kent Overstreet wrote:
> On Fri, Feb 07, 2025 at 05:34:23PM +1100, NeilBrown wrote:
> > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> > > > Do you think there could be a problem with changing the error returned
> > > > in this circumstance? i.e. if you try to destroy a subvolume with a
> > > > non-existant name on a different filesystem could getting -ENOENT
> > > > instead of -EXDEV be noticed?
> > > 
> > > -EXDEV is the standard error code for "we're crossing a filesystem
> > > boundary and we can't or aren't supposed to be", so no, let's not change
> > > that.
> > > 
> > 
> > OK.  As bcachefs is the only user of user_path_locked_at() it shouldn't
> > be too hard.
> 
> Hang on, why does that require keeping user_path_locked_at()? Just
> compare i_sb...
> 

I changed user_path_locked_at() to not return a dentry at all when the
full path couldn't be found.  If there is no dentry, then there is no
->d_sb.
(if there was an ->i_sb, there would be an inode and this all wouldn't
be an issue).

To recap: the difference happens if the path DOESN'T exist but the
parent DOES exist on a DIFFERENT filesystem.  It is very much a corner
case and the error code shouldn't matter.  But I had to ask...

NeilBrown


