Return-Path: <linux-fsdevel+bounces-51169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5EAAD39EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1AD3B0819
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2B729B76B;
	Tue, 10 Jun 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWQpHmkr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hd809/5y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SemISEZI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8KmkXUiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6C29B23E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563353; cv=none; b=ikTHZasN9txg3s/9QkEe+SvR3ovM4oeHx8KofH2PGhdKiDTek3Vb+ArI+yP+NUq9SN1fPMi0rSrP/kPBNQRJfP0PMiYn1kjgg8xIyyEXbqN0ghvd01isAWqB386nWnNZT5nrNpRUMUo4/oYjmcKD281zu/lpId7Dg44UFBw1T5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563353; c=relaxed/simple;
	bh=Q71sZ1lxkuJj3oesAYkvkpjr6rpAA3RyKl7AyG3n2UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAXMff8iiUO/pzkKKIVNFzBEcLuzQ9xJvvG/NjkMsBgRTcyWuKXaSAbY9QD5wY6ONXe+VT6vKXB2d2CppasaOJT4pTeDw7PQ4xe/539obqHj3inli4mYMjkVtHR8CGmY7Jy9/VmQ0xV2h9fB8vmMau3/276RihwzBUTBprKj96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWQpHmkr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hd809/5y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SemISEZI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8KmkXUiZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 448F8211F9;
	Tue, 10 Jun 2025 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749563349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwmt0r/hn/CClnw+F3ejUaU+6VqE+i5GsbA0w53nOMw=;
	b=PWQpHmkr9BSQfyOp6gFoQSreFkhmFfoLmqiPs2emIjc0LtL3ZG2JmJQNQ8IrZ5+6R6kWow
	orrjU8lh7FX2NZ7FFbo1V8Oz6VssXBf4WFFK0MvrFqQCb9TiK7ED5Vq/nSZmDJroJfUP4o
	+rxb5Bmh2T5mcw0G8V/aqxyOyIQoB28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749563349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwmt0r/hn/CClnw+F3ejUaU+6VqE+i5GsbA0w53nOMw=;
	b=Hd809/5yQrXkRjc4GW/p4kHlMIudXzQD114BfkDaeQHdyX0qLYeYOEGUJSZ4Bavv8w2iHi
	lLfhXdBRGxRvUYCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SemISEZI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8KmkXUiZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749563348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwmt0r/hn/CClnw+F3ejUaU+6VqE+i5GsbA0w53nOMw=;
	b=SemISEZIT7/9PrYXIuMdvySb6uGt0wmKrINhxjT5D3ta23yWEEwMAddhjvkTMvTdH5WOYr
	3OkIs6eqK3C3VCoLkmoxJ/6quKM8WOumOtmKSjw0DCybgTUdBDprL6BeQUlTtPPIj7qg99
	5YjHIHd9J+9Pd0t37kVOenuR5Q8dfRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749563348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwmt0r/hn/CClnw+F3ejUaU+6VqE+i5GsbA0w53nOMw=;
	b=8KmkXUiZX1RUxd/A7d0hOo0NeH/ook/rZGMYyfd39XwtSrdtYLgQ+Gq8+tojiwtCdR4K4b
	j2tQdYHPNe0LoyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DB9C13964;
	Tue, 10 Jun 2025 13:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tjDRCtQ3SGjsLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Jun 2025 13:49:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF3A9A09A8; Tue, 10 Jun 2025 15:49:03 +0200 (CEST)
Date: Tue, 10 Jun 2025 15:49:03 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
Message-ID: <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
References: <20250604160918.2170961-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604160918.2170961-1-amir73il@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 448F8211F9
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

Hi Amir!

On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> In v1 there was only patch 1 [1] to allow FAN_PRE_ACCESS events
> on readdir (with FAN_ONDIR).
> 
> Following your feedback on v1, v2 adds support for FAN_PATH_ACCESS
> event so that a non-populated directory could be populted either on
> first readdir or on first lookup.

OK, it's good that now we have a bit more wider context for the discussion
:). First, when reading this I've started wondering whether we need both
FAN_PRE_ACCESS on directories and FAN_PATH_ACCESS (only on directories).
Firstly, I don't love adding more use to the FAN_ONDIR flag when creating
marks because you can only specify you want FAN_PRE_ACCESS on files,
FAN_PRE_ACCESS on files & dirs but there's no way to tell you care only
about FAN_PRE_ACCESS on dirs. You have to filter that when receiving
events. Secondly, the distinction between FAN_PRE_ACCESS and
FAN_PATH_ACCESS is somewhat weak - it's kind of similar to the situation
with regular files when we notify about access to the whole file vs only to
a specific range.  So what if we had an event like FAN_PRE_DIR_ACCESS that
would report looked up name on lookup and nothing on readdir meaning you
need to fetch everything?

> I am still tagging this as RFC for two semi-related reasons:
> 
> 1) In my original draft of man-page for FAN_PATH_ACCESS [2],
> I had introduced a new class FAN_CLASS_PRE_PATH, which FAN_PATH_ACCESS
> requires and is defined as:
> "Unlike FAN_CLASS_PRE_CONTENT, this class can be used along with
>  FAN_REPORT_DFID_NAME to report the names of the looked up files along
>  with O_PATH file descriptos in the new path lookup events."
> 
> I am not sure if we really need FAN_CLASS_PRE_PATH, so wanted to ask
> your opinion.
> 
> The basic HSM (as implemented in my POC) does not need to get the lookup
> name in the event - it populates dir on first readdir or lookup access.
> So I think that support for (FAN_CLASS_PRE_CONTENT | FAN_REPORT_DFID_NAME)
> could be added later per demand.

The question here is what a real user is going to do? I know Meta guys
don't care about directory events for their usecase. You seem to care about
them so I presume you have some production use in mind? How's that going to
work? Because if I should guess I'd think that someone asks for the name
being looked up sooner rather than later because for large dirs not having
to fetch everything on lookup would be a noticeable win... And if that's
the case then IMHO we should design (but not necessarily fully implement)
API that's the simplest and most logical when this is added.

This ties to the discussion how the FAN_PATH_ACCESS / FAN_PRE_DIR_ACCESS
event is going to report the name.

> 2) Current code does not generate FAN_PRE_ACCESS from vfs internal
> lookup helpers such as  lookup_one*() helpers from overalyfs and nfsd.
> This is related to the API of reporting an O_PATH event->fd for
> FAN_PATH_ACCESS event, which requires a mount.

AFAIU this means that you could not NFS export a filesystem that is HSM
managed and you could not use HSM managed filesystem to compose overlayfs.
I don't find either of those a critical feature but OTOH it would be nice
if the API didn't restrict us from somehow implementing this in the future.

> If we decide that we want to support FAN_PATH_ACCESS from all the
> path-less lookup_one*() helpers, then we need to support reporting
> FAN_PATH_ACCESS event with directory fid.
> 
> If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we still
> have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, because
> we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS events
> on its "work" mount - the path via which directories are populated.
> 
> There may be a middle ground:
> - Pass optional path arg to __lookup_slow() (i.e. from walk_component())
> - Move fsnotify hook into __lookup_slow()
> - fsnotify_lookup_perm() passes optional path data to fsnotify()
> - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS without
>   path data
> 
> This way, if HSM is enabled on an sb and not ignored on specific dir
> after it was populated, path lookup from syscall will trigger
> FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup inside
> non-populated directories.

OK, but how will this manifest from the user POV? If we have say nfs
exported filesystem that is HSM managed then there would have to be some
knowledge in nfsd to know how to access needed files so that HSM can pull
them? I guess I'm missing the advantage of this middle-ground solution...

> Supporting populate events from overalyfs/nfsd could be implemented
> later per demand by reporting directory fid instead of O_PATH fd.
> 
> If you think that is worth checking, I can prepare a patch for the above
> so we can expose it to performance regression bots.
> 
> Better yet, if you have no issues with the implementation in this
> patch set, maybe let it soak in for_next/for_testing as is to make
> sure that it does not already introduce any performance regressions.
> 
> Thoughts?

If I should summarize the API situation: If we ever want to support HSM +
NFS export / overlayfs, we must implement support for pre-content events
with FID (DFID + name to be precise). If we want to support HSM events on
lookup with looked up name, we don't have to go for full DFID + name but we
must at least add additional info with the name to the event. Also if we go
for reporting directory pre-content events with standard events, you want
to add support for returning O_PATH fds for better efficiency and the code
to handle FMODE_NONOTIFY directory fds in path lookup.

Frankly seeing all this I think that going for DFID + name events for
directory HSM events from the start may be the cleanest choice long term
because then we'll have one way how to access the directory HSM
functionality with possibility of extensions without having to add
different APIs for it. We'd just have to implement replying to FID events
because we won't have fd to identify event we reply to so that will need
some thought.

What are your thoughts? Am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

