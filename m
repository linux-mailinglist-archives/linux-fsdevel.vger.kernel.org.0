Return-Path: <linux-fsdevel+bounces-41526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE3A31127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB241881D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369421D5B8;
	Tue, 11 Feb 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YD6bYT2L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLPb1XVz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YD6bYT2L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLPb1XVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A726BDAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290926; cv=none; b=FcmC4o7NT67TAqUqWdSoRGbtZW4knP2F97A05RS3C4mlRGZUJ61u2sReaSRem90btpT4DIfGfyR24lpeMNZ5YxYmrZv8X8GJ+/JU+gQGJmkF1luvW2ASHidnqi/x7X/E0KPQ1jw579WZfHCh3Je3Wdm0PRugfpMj90Ghx7QO+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290926; c=relaxed/simple;
	bh=XVWAdJB34+ddUPrIAMiMey89jdieh+eZFJcQTX8leA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMrTQxRzg+Eqm96GFnM+1j/pgdzxgppuRjYJe+r9hUsWuQJDxK/00WeILSx+7fsctP+HTZvX0eI0tir5AObfdg/l/o6iqbK7wsucKTRhXJnLmUShedEyBL9H6jCJQsiRjnpYD2EqQ4wmoE1ji1MFRjjwlEqr5dK5L7nds4eBXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YD6bYT2L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLPb1XVz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YD6bYT2L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLPb1XVz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 838D620AF1;
	Tue, 11 Feb 2025 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739285621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS244AXQwCXDgtfb7NADhCw8c6ahdX2isUo+yb7AuRU=;
	b=YD6bYT2LtWf9y/jzsjQJpg191aRiAtAZGcG1ogyVgvERXyt+yNAHmzgQu0vwx0IoizVobT
	JegmAujqI2afTFqkhvzvYqvCe77zCRk5cf1dY2sLqsb0J3vkEz1NODYNzjCXhtmAnDzV+G
	AK68DMZD1EPfCeQ3X1Mvsw2ogP03Qg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739285621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS244AXQwCXDgtfb7NADhCw8c6ahdX2isUo+yb7AuRU=;
	b=ZLPb1XVz67/piZXfHzhEH/p5MYwsouksIzxMF37FVMtecu0CZ7nvjYICoAInxfaZPpH5Zi
	PxjmAo0czukgjADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739285621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS244AXQwCXDgtfb7NADhCw8c6ahdX2isUo+yb7AuRU=;
	b=YD6bYT2LtWf9y/jzsjQJpg191aRiAtAZGcG1ogyVgvERXyt+yNAHmzgQu0vwx0IoizVobT
	JegmAujqI2afTFqkhvzvYqvCe77zCRk5cf1dY2sLqsb0J3vkEz1NODYNzjCXhtmAnDzV+G
	AK68DMZD1EPfCeQ3X1Mvsw2ogP03Qg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739285621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS244AXQwCXDgtfb7NADhCw8c6ahdX2isUo+yb7AuRU=;
	b=ZLPb1XVz67/piZXfHzhEH/p5MYwsouksIzxMF37FVMtecu0CZ7nvjYICoAInxfaZPpH5Zi
	PxjmAo0czukgjADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73CBB13AA6;
	Tue, 11 Feb 2025 14:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XfVBHHVkq2dqWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Feb 2025 14:53:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1ECECA095C; Tue, 11 Feb 2025 15:53:41 +0100 (CET)
Date: Tue, 11 Feb 2025 15:53:41 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
Message-ID: <gihbrvdkldci257z5amkrowcsrzgjjmtnif7ycvpi6rsbktvnz@rfqybs7klfkj>
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area>
 <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <dc0649f70ca69741d351060c8c3816a347c00687.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc0649f70ca69741d351060c8c3816a347c00687.camel@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fromorbit.com,vger.kernel.org,lists.linux-foundation.org,suse.cz,kernel.org,toxicpanda.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 23-01-25 13:14:11, Jeff Layton wrote:
> On Mon, 2025-01-20 at 12:41 +0100, Amir Goldstein wrote:
> > On Sun, Jan 19, 2025 at 10:15 PM Dave Chinner <david@fromorbit.com> wrote:
> > > 
> > > On Fri, Jan 17, 2025 at 07:01:50PM +0100, Amir Goldstein wrote:
> > > > Hi all,
> > > > 
> > > > I would like to present the idea of vfs write barriers that was proposed by Jan
> > > > and prototyped for the use of fanotify HSM change tracking events [1].
> > > > 
> > > > The historical records state that I had mentioned the idea briefly at the end of
> > > > my talk in LSFMM 2023 [2], but we did not really have a lot of time to discuss
> > > > its wider implications at the time.
> > > > 
> > > > The vfs write barriers are implemented by taking a per-sb srcu read side
> > > > lock for the scope of {mnt,file}_{want,drop}_write().
> > > > 
> > > > This could be used by users - in the case of the prototype - an HSM service -
> > > > to wait for all in-flight write syscalls, without blocking new write syscalls
> > > > as the stricter fsfreeze() does.
> > > > 
> > > > This ability to wait for in-flight write syscalls is used by the prototype to
> > > > implement a crash consistent change tracking method [3] without the
> > > > need to use the heavy fsfreeze() hammer.
> > > 
> > > How does this provide anything guarantee at all? It doesn't order or
> > > wait for physical IOs in any way, so writeback can be active on a
> > > file and writing data from both sides of a syscall write "barrier".
> > > i.e. there is no coherency between what is on disk, the cmtime of
> > > the inode and the write barrier itself.
> > > 
> > > Freeze is an actual physical write barrier. A very heavy handed
> > > physical right barrier, yes, but it has very well defined and
> > > bounded physical data persistence semantics.
> > 
> > Yes. Freeze is a "write barrier to persistence storage".
> > This is not what "vfs write barrier" is about.
> > I will try to explain better.
> > 
> > Some syscalls modify the data/metadata of filesystem objects in memory
> > (a.k.a "in-core") and some syscalls query in-core data/metadata
> > of filesystem objects.
> > 
> > It is often the case that in-core data/metadata readers are not fully
> > synchronized with in-core data/metadata writers and it is often that
> > in-core data and metadata are not modified atomically w.r.t the
> > in-core data/metadata readers.
> > Even related metadata attributes are often not modified atomically
> > w.r.t to their readers (e.g. statx()).
> > 
> > When it comes to "observing changes" multigrain ctime/mtime has
> > improved things a lot for observing a change in ctime/mtime since
> > last sampled and for observing an order of ctime/mtime changes
> > on different inodes, but it hasn't changed the fact that ctime/mtime
> > changes can be observed *before* the respective metadata/data
> > changes can be observed.
> > 
> > An example problem is that a naive backup or indexing program can
> > read old data/metadata with new timestamp T and wrongly conclude
> > that it read all changes up to time T.
> > 
> > It is true that "real" backup programs know that applications and
> > filesystem needs to be quisences before backup, but actual
> > day to day cloud storage sync programs and indexers cannot
> > practically freeze the filesystem for their work.
> > 
> 
> Right. That is still a known problem. For directory operations, the
> i_rwsem keeps things consistent, but for regular files, it's possible
> to see new timestamps alongside with old file contents. That's a
> problem since caching algorithms that watch for timestamp changes can
> end up not seeing the new contents until the _next_ change occurs,
> which might not ever happen.
> 
> It would be better to change the file write code to update the
> timestamps after copying data to the pagecache. It would still be
> possible in that case to see old attributes + new contents, but that's
> preferable to the reverse for callers that are watching for changes to
> attributes.
> 
> Would fixing that help your use-case at all?

I think Amir wanted to make here a point in the other direction: I.e., if
the application did:
 * sample inode timestamp
 * vfs_write_barrier()
 * read file data

then it is *guaranteed* it will never see old data & new timestamp and hence
the caching problem is solved. No need to update timestamp after the write.

Now I agree updating timestamps after write is much nicer from usability
POV (given how common pattern above it) but this is just a simple example
demonstrating possible uses for vfs_write_barrier().

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

