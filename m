Return-Path: <linux-fsdevel+bounces-39630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03580A1644E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 23:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048C83A4947
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0D1DF99F;
	Sun, 19 Jan 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s2IqHUZ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MghWj3Fr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s2IqHUZ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MghWj3Fr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EAB1A260
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737325561; cv=none; b=krAd3IzCc1MA+Rp3kxXjDC9MihEp9iJjmGn/8on+pnV3J8NHMrA8tBg3NcX5bZG5TOfMWHJ4QCLPkdgwyyz7X8FhANzCvxCHtnPvhgm60qsRiHlxYBVY/r53bgAQsYHhR31AD9GMokJkofQNrdNFto8fGh9pF4TrVxU6AxaEe/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737325561; c=relaxed/simple;
	bh=aGHyJdeE6DSVUpifNaJPOTITTcBypKJDbF41Lk1G1PA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XD6AxcefmbFBGUazSrjZNhbmq5+NGd1BDreB6OgjKty+v+Qf8j2ZWOAPmans1qCsTSGx07zukuSpf+fwr1V4wPMhVcIZ0AcSMJJJeI8DtFsm/OOzMkFEMCA/vIHsCjkGDvIxYlrRv8orfuSuYx7JoT8iEIblTyl2SUyZtB5WlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s2IqHUZ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MghWj3Fr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s2IqHUZ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MghWj3Fr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0A5A21189;
	Sun, 19 Jan 2025 22:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737325550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iA+NoB99IPkfnL/WPRxel/tTgZhBZaGayhfQ6+WFm8=;
	b=s2IqHUZ9m3ADU6Se8wkbx1+QZZHXsLbA9EvRJ00PX4fllrsGJ12O/Yo7dcqCxBAKBYvJxA
	G+10RrHss2nzKQf5gpEH2wNrh3QxRLll/ViQIOsDdbd8otKojQykli+iSNdwt2NkJV56GF
	DvYphAP5gKbbU3/+MgypmeBDKdqS+AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737325550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iA+NoB99IPkfnL/WPRxel/tTgZhBZaGayhfQ6+WFm8=;
	b=MghWj3FrR4cO5xTVL1MK/tZ6ss0JIt3HHPouptYv9t0vp1uEC+C1N+8Vd0e6K14QtaV1VO
	cUr5vhB8z2EJz6DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737325550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iA+NoB99IPkfnL/WPRxel/tTgZhBZaGayhfQ6+WFm8=;
	b=s2IqHUZ9m3ADU6Se8wkbx1+QZZHXsLbA9EvRJ00PX4fllrsGJ12O/Yo7dcqCxBAKBYvJxA
	G+10RrHss2nzKQf5gpEH2wNrh3QxRLll/ViQIOsDdbd8otKojQykli+iSNdwt2NkJV56GF
	DvYphAP5gKbbU3/+MgypmeBDKdqS+AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737325550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iA+NoB99IPkfnL/WPRxel/tTgZhBZaGayhfQ6+WFm8=;
	b=MghWj3FrR4cO5xTVL1MK/tZ6ss0JIt3HHPouptYv9t0vp1uEC+C1N+8Vd0e6K14QtaV1VO
	cUr5vhB8z2EJz6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E825013834;
	Sun, 19 Jan 2025 22:25:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCO3Jux7jWduDAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 19 Jan 2025 22:25:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, lsf-pc@lists.linuxfoundation.org,
 "Al Viro" <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
In-reply-to: <Z41z9gKyyVMiRZnB@dread.disaster.area>
References: <>, <Z41z9gKyyVMiRZnB@dread.disaster.area>
Date: Mon, 20 Jan 2025 09:25:37 +1100
Message-id: <173732553757.22054.12851849131700067664@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 20 Jan 2025, Dave Chinner wrote:
> On Sat, Jan 18, 2025 at 12:06:30PM +1100, NeilBrown wrote:
> > 
> > My question to fs-devel is: is anyone willing to convert their fs (or
> > advice me on converting?) to use the new interface and do some testing
> > and be open to exploring any bugs that appear?
> 
> tl;dr: You're asking for people to put in a *lot* of time to convert
> complex filesystems to concurrent directory modifications without
> clear indication that it will improve performance. Hence I wouldn't
> expect widespread enthusiasm to suddenly implement it...

Thanks Dave!
Your point as detailed below seems to be that, for xfs at least, it may
be better to reduce hold times for exclusive locks rather than allow
concurrent locks.  That seems entirely credible for a local fs but
doesn't apply for NFS as we cannot get a success status before the
operation is complete.  So it seems likely that different filesystems
will want different approaches.  No surprise.

There is some evidence that ext4 can be converted to concurrent
modification without a lot of work, and with measurable benefits.  I
guess I should focus there for local filesystems.

But I don't want to assume what is best for each file system which is
why I asked for input from developers of the various filesystems.

But even for xfs, I think that to provide a successful return from mkdir
would require waiting for some IO to complete, and that other operations
might benefit from starting before that IO completes.
So maybe an xfs implementation of mkdir_shared would be:
 - take internal exclusive lock on directory
 - run fast foreground part of mkdir
 - drop the lock
 - wait for background stuff, which could affect error return, to
  complete
 - return appropriate error, or success

So xfs could clearly use exclusive locking where that is the best
choice, but not have exclusive locking imposed for the entire operation.
That is my core goal : don't impose a particular locking style - allow
the filesystem to manage locking within an umbrella that ensures the
guarantees that the vfs needs (like no creation inside a directory
during rmdir).

Thanks,
NeilBrown
 

> 
> In more detail....
> 
> It's not exactly simple to take a directory tree structure that is
> exclusively locked for modification and make it safe for concurrent
> updates. It -might- be possible to make the directory updates in XFS
> more concurrent, but it still has an internal name hash btree index
> that would have to be completely re-written to support concurrent
> updates.
> 
> That's also ignoring all the other bits of the filesystem that will
> single thread outside the directory. e.g. during create we have to
> allocate an inode, and locality algorithms will cluster new inodes
> in the same directory close together. That means they are covered by
> the same exclusive lock (e.g. the AGI and AGF header blocks in XFS).
> Unlink has the same problem.
> 
> IOWs, it's not just directory ops and structures that need locking
> changes; the way filesystems do inode and block allocation and
> freeing also needs to change to support increased concurrency in
> directory operations.
> 
> Hence I suspect that concurrent directory mods for filesystems like
> XFS will need a new processing model - possibly a low overhead
> intent-based modification model using in-memory whiteouts and async
> background batching of intents. We kinda already do this with unlink
> - we do the directory removal in the foreground, and defer the rest
> of the unlink (i.e. inode freeing) to async background worker
> threads.
> 
> e.g. doing background batching of namespace ops means things like
> "rm *" in a directory doesn't need to transactionally modify the
> directory as it runs. We could track all the inodes we are unlinking
> via the intents and then simply truncate away the entire directory
> when it becomes empty and rmdir() is called. We still have to clean
> up and mark all the inodes free, but that can be done in the
> background.
> 
> As such, I suspect that moving XFS to a more async processing model
> for directory namespace ops to minimise lock hold times will be
> simpler (and potentially faster!) than rewriting large chunks of the
> XFS directory and inode management operations to allow for
> i_rwsem/ILOCK/AGI/AGF locking concurrency...
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


