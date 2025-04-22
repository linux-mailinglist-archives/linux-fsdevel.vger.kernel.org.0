Return-Path: <linux-fsdevel+bounces-46905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F44CA9653D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E10117B450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06B520468E;
	Tue, 22 Apr 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hb7a/XJ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYkgFSkv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wo+thxlv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wNecXUMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6981F098A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315874; cv=none; b=I2vNy5ns2LMj7TBbS7bzcbnDJ3wPAOQmO2qczhYdt3Mb+susbIryhFRo+KVshNENhDtLELEKlJnzl55QQP8EeUR3UILrn8DbP4ZyCEbcMeWCbKAvGSbUS4rjzMFDHq4zmXGfK9mt5TJ7Mrm6u1XvT/MYyFZTwdZ5DRGeY9czong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315874; c=relaxed/simple;
	bh=VXtEZKxo7iuywOtDoeVJ2XyvR2e+2QKsDbiH1pymoWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o10QkgmxVtjWkSJkD9+tU88tZ00SDQ5L4BG+gNIcJT+exAYM8mytZILZONUZ7LD3163gd70/vn39y6FB3HY2vmuRj44vupxwDPjqTfsxJ/Jdzj4QXek9OQIZWFdnTZgoqtNNIdillrmDUIc3E9udb80k6ZfybySPAK6ySEMg9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hb7a/XJ1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYkgFSkv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wo+thxlv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wNecXUMv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7A1A211B3;
	Tue, 22 Apr 2025 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745315870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVzEJEZtGDqEkk/ry21wvt7tl9QN9BzZRqrz9Vv2fFM=;
	b=Hb7a/XJ1FzJDiI+8dreOOWmWzh5kSFfkCjeQb3jqH1fHQEOTa1d46UbK5eH0xqSRqvV/QK
	WnXqbXTwaw4sOGWiwRQ7DnsPI9JrWw1FukY2TOTAKsLRPcDLCQo/THr4abluHbDN5VBus/
	kcEDvIrjhEhNfjVRytfdIOZNxhvknMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745315870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVzEJEZtGDqEkk/ry21wvt7tl9QN9BzZRqrz9Vv2fFM=;
	b=GYkgFSkv3m5Hfupd1OD4HPD5jDnpplUN3GBN9DUhIkLMjbhp+VigIgckwI+CNxEh8YaQEe
	OLus8u0unOj1QqBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745315869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVzEJEZtGDqEkk/ry21wvt7tl9QN9BzZRqrz9Vv2fFM=;
	b=wo+thxlvlLMwEP/tEbIQBPkwuNyxANGgUb/qcb/joupyjxQ9jfT/iJhXaSI1Mk5XJPEXps
	bLheu42ZxjvpKLI8So+n7ssT7rBhHUraawxPE5QNbJWBfLFT0ompWUQ4435mtrkcWTZN7H
	piaIACz4+kNZ4oSlgF61PWFMZx1NAJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745315869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVzEJEZtGDqEkk/ry21wvt7tl9QN9BzZRqrz9Vv2fFM=;
	b=wNecXUMvimVI2gtyPoG3VsGy0AzkjVCp7cloPU/tkyfc6AxWVxAqSd8Lih+iRkRYhe9pj8
	OBtERqoPdq03l+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD797139D5;
	Tue, 22 Apr 2025 09:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ibI9Lh1oB2gDbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Apr 2025 09:57:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 710EEA0A56; Tue, 22 Apr 2025 11:57:45 +0200 (CEST)
Date: Tue, 22 Apr 2025 11:57:45 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: Reseting pending fanotify events
Message-ID: <sosw5x6ohd6dfvxqblu5fjdpx6t7dssro2xozmhw3ru7hol3ga@lj5mdvdrkjbp>
References: <CAOQ4uxgXO0XJzYmijXu=3yDF_hq3E1yPUxHqhwka19-_jeaNFA@mail.gmail.com>
 <20250408185506.3692124-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxjnjSeDpzk9j6QBQzhiSwwmOAejefxNL3Ar49BuCzBsKg@mail.gmail.com>
 <d2n57euuuy2gd63gweovkyvcya3igjttdabgpz4txxtf4v2pou@3eb7slijnhcl>
 <CAOQ4uxgBqR0hC2v2AbktjiWqfeEiJHsZq00Uhpg2PY3HyjGkpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgBqR0hC2v2AbktjiWqfeEiJHsZq00Uhpg2PY3HyjGkpg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 19-04-25 00:37:44, Amir Goldstein wrote:
> On Tue, Apr 15, 2025 at 5:51 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 09-04-25 14:36:16, Amir Goldstein wrote:
> > > On Tue, Apr 8, 2025 at 8:55 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> > > >
> > > > > 1. Start a new server instance
> > > > > 2. Set default response in case of new instance crash
> > > > > 3. Hand over a ref of the existing group fd to the new instance if the
> > > > > old instance is running
> > > > > 4. Start handling events in new instance (*)
> > > > > 5. Stop handling new events in old instance, but complete pending events
> > > > > 6. Shutdown old instance
> > > >
> > > > I think this should work for our case, we will only need to reconstruct
> > > > the group/interested mask in case of crash. I can help add the feature for
> > > > setting different default responses.
> > > >
> > >
> > > Please go ahead.
> > >
> > > We did not yet get any feedback from Jan on this idea,
> > > but ain't nothing like a patch to solicit feedback.
> >
> > I'm sorry for the delay but I wanted to find time to give a deeper thought
> > to this.
> >
> 
> Same here. I had to think hard.
> 
> > > > > I might have had some patches similar to this floating around.
> > > > > If you are interested in this feature, I could write and test a proper patch.
> > > >
> > > > That would be appreciated if its not too much trouble, the approach outlined
> > > > in sketch should be enough for our use-case (pending the sb vs mount monitoring
> > > > point you've raised).
> > > >
> > >
> > > Well, the only problem is when I can get to it, which does not appear to be
> > > anytime soon. If this is an urgent issue for you I could give you more pointers
> > > to  try and do it yourself.
> > >
> > > There is one design decision that we would need to make before
> > > getting to the implementation.
> > > Assuming that this API is acceptable:
> > >
> > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM | FAN_MARK_DEFAULT, ...
> > >
> > > What happens when fd is closed?
> > > Can the sbinfo->default_mask out live the group fd?
> >
> > So I think there are two options how to consistently handle this and we
> > need to decide which one to pick. Do we want to:
> >
> > a) tie the concept to a particular notification group - i.e., if a particular
> > notification group is not existing anymore, we want events on particular
> > object(s) auto-rejected.
> >
> > or
> >
> > b) tie the concept to the object itself - i.e., if there's no notification
> > group handling events for the object, auto-reject the events.
> >
> > Both has its advantages and disadvantages. With a) we can easily have
> > multiple handlers cooperate on one filesystem (e.g. an HSM and antivirus
> > solution), the notification group can just register itself as mandatory for
> > all events on the superblock object and we don't have to care about details
> > how the notification group watches for events or so. But what gets complex
> > with this variant is how to hand over control from the old to the new
> > version of the service or even worse how to recover from crashed service -
> > you need to register the new group as mandatory and somehow "unregister"
> > the crashed one.
> >
> 
> I prefer this option, but with a variant -
> The group has two fds:
> one control-only fd (RDONLY) to keep it alive and add marks
> and one queue-fd (RDWR) to handle events.
> 
> The control fd can be placed in the fd store.
> When service crashes, the queue fd is closed so the group
> cannot handle events and default response is returned.
> 
> When the service starts it finds the control fd in the fd store and
> issues an ioctl or something to get the queue fd.

Yes, this sounds elegant. I like it.

> > For b) hand-over or crash recovery is simple. As soon as someone places a
> > mark over given object, it is implicitly the new handler for the object and
> > auto-reject does not trigger. But if you set that e.g. all events on the
> > superblock need to be handled, then you really have to setup watches so
> > that notification system understands each event really got handled (which
> > potentially conflicts with the effort to avoid handling uninteresting
> > events). Also any coexistence of two services using this facility is going
> > to be "interesting".
> >
> > > I think that closing this group should remove the default mask
> > > and then the default mask is at least visible at fdinfo of this fd.
> >
> > Once we decide the above dilema, we can decide on what's the best way to
> > set these and also about visibility (I agree that is very important as
> > well).
> 
> With the control fd design, this problem is also solved - the marks
> are still visible on the control fd, and so will be the default response
> and the state of the queue fd.

Yep, sounds good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

