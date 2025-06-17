Return-Path: <linux-fsdevel+bounces-51866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C82FADC6DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A786F3AC9AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28B29824E;
	Tue, 17 Jun 2025 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bKraMVi3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RhREAylS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bKraMVi3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RhREAylS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7217A586
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153396; cv=none; b=b4Kz09r62BaSBkBgAJzmBPCFs35KYodnhFKAmbJWc//GMuhUK9f5uqREvTomMiOoc3Uuz2D6McyAG/zjkcsZJIWH0Z2j0GNKsLu6nCbcq69Urp78IuYZl/nJUNVqRTGTKSEClO5UK7SwDdv8DBmi8M+GnNhznO/tiX937GdkBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153396; c=relaxed/simple;
	bh=6cbAXMx6M699zKmxC7EtOzdoajJIK9YedrpKz2sdrxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLbL6E//x5gWdvrz60ylmhLZKvkjWlFwMaThgeCxiM6jGH88MSE3pBqpsBT3z0bZj9FzOruMrm8NDx4rh4S9wah7Ttry5BqH2kO400ahOqVgWGCLHLc9XeyEDdCZVTQRyptZ8ZUbqQJLO1TI1QIkKhuU86OrYkRwCHsW1VCK1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bKraMVi3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RhREAylS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bKraMVi3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RhREAylS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CF842119C;
	Tue, 17 Jun 2025 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750153392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESdVVC6Vqd+tWWO5c8CdVJaXlqhpCnDheWLaeuG4QG8=;
	b=bKraMVi3D1FBro8xYB9RC2UDxtZfw42KBXSL2PqLZYQVrmyNVs2alGJksLbDkPawOA6BKv
	GIS+RYipNXPW8y4j/K8i1tTZ64OoL/sEvjRXCdosPdt9jDeO/T0JzNxn1gDP4XVjCwfDqF
	JDj9gjjKqACIQe2qM6KYvUesAZqNCrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750153392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESdVVC6Vqd+tWWO5c8CdVJaXlqhpCnDheWLaeuG4QG8=;
	b=RhREAylSU7OsSV4cC/vm+qTDJmSNTnBQIApIyZSwJiGLmUDCrXf66Ig+qprOUI0RjAkdNh
	Fz2whe1PEWiUT8Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750153392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESdVVC6Vqd+tWWO5c8CdVJaXlqhpCnDheWLaeuG4QG8=;
	b=bKraMVi3D1FBro8xYB9RC2UDxtZfw42KBXSL2PqLZYQVrmyNVs2alGJksLbDkPawOA6BKv
	GIS+RYipNXPW8y4j/K8i1tTZ64OoL/sEvjRXCdosPdt9jDeO/T0JzNxn1gDP4XVjCwfDqF
	JDj9gjjKqACIQe2qM6KYvUesAZqNCrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750153392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESdVVC6Vqd+tWWO5c8CdVJaXlqhpCnDheWLaeuG4QG8=;
	b=RhREAylSU7OsSV4cC/vm+qTDJmSNTnBQIApIyZSwJiGLmUDCrXf66Ig+qprOUI0RjAkdNh
	Fz2whe1PEWiUT8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3FFF139E2;
	Tue, 17 Jun 2025 09:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dPKHO684UWgLEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Jun 2025 09:43:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AD927A29F0; Tue, 17 Jun 2025 11:43:11 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:43:11 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
Message-ID: <uxetof5i2ejhwujegsbhltntnozd4rz6cxtqx3xmtc63xugkyq@53bwknir2ha7>
References: <20250604160918.2170961-1-amir73il@gmail.com>
 <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
 <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
 <2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rinzwbq7xxfjf5z7@3nqidi3mno46>
 <CAOQ4uxgjHGL4=9LCCbb=o1rFyziK4QTrJKzUYf=b2Ri9bk4ZPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgjHGL4=9LCCbb=o1rFyziK4QTrJKzUYf=b2Ri9bk4ZPA@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 16-06-25 19:00:42, Amir Goldstein wrote:
> On Mon, Jun 16, 2025 at 11:07 AM Jan Kara <jack@suse.cz> wrote:
> > On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> > > On Tue, Jun 10, 2025 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > > > If we decide that we want to support FAN_PATH_ACCESS from all the
> > > > > path-less lookup_one*() helpers, then we need to support reporting
> > > > > FAN_PATH_ACCESS event with directory fid.
> > > > >
> > > > > If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we still
> > > > > have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, because
> > > > > we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS events
> > > > > on its "work" mount - the path via which directories are populated.
> > > > >
> > > > > There may be a middle ground:
> > > > > - Pass optional path arg to __lookup_slow() (i.e. from walk_component())
> > > > > - Move fsnotify hook into __lookup_slow()
> > > > > - fsnotify_lookup_perm() passes optional path data to fsnotify()
> > > > > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS without
> > > > >   path data
> > > > >
> > > > > This way, if HSM is enabled on an sb and not ignored on specific dir
> > > > > after it was populated, path lookup from syscall will trigger
> > > > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup inside
> > > > > non-populated directories.
> > > >
> > > > OK, but how will this manifest from the user POV? If we have say nfs
> > > > exported filesystem that is HSM managed then there would have to be some
> > > > knowledge in nfsd to know how to access needed files so that HSM can pull
> > > > them? I guess I'm missing the advantage of this middle-ground solution...
> > >
> > > The advantage is that an admin is able to set up a "lazy populated fs"
> > > with the guarantee that:
> > > 1. Non-populated objects can never be accessed
> > > 2. If the remote fetch service is up and the objects are accessed
> > >     from a supported path (i.e. not overlayfs layer) then the objects
> > >     will be populated on access
> > >
> > > This is stronger and more useful than silently serving invalid content IMO.
> > >
> > > This is related to the discussion about persistent marks and how to protect
> > > against access to non-populated objects while service is down, but since
> > > we have at least one case that can result in an EIO error (service down)
> > > then another case (access from overlayfs) maybe is not a game changer(?)
> >
> > Yes, reporting error for unpopulated content would be acceptable behavior.
> > I just don't see this would be all that useful.
> >
> 
> Regarding overlayfs, I think there is an even bigger problem.
> There is the promise that we are not calling the blocking pre-content hook
> with freeze protection held.
> In overlayfs it is very common to take the upper layer freeze protection
> for a relatively large scope (e.g. ovl_want_write() in ovl_create_object())
> and perform lookups on upper fs or lower fs within this scope.
> I am afraid that cleaning that up is not going to be realistic.
> 
> IMO, it is perfectly reasonable that overlayfs and HSM (at least pre-dir-access)
> will be mutually exclusive features.
> 
> This is quite similar to overlayfs resulting in EIO if lower fs has an
> auto mount point.
> 
> Is it quite common for users to want overlayfs mounted over
> /var/lib/docker/overlay2
> on the root fs.
> HSM is not likely to be running on / and /etc, but likely on a very
> distinct lazy populated source dir or something.
> We can easily document and deny mounting overlayfs over subtrees where
> HSM is enabled (or just pre-path events).
> 
> This way we can provide HSM lazy dir populate to the users that do not care
> about overlayfs without having to solve very hard to unsolvable issues.
> 
> I will need to audit all the other users of vfs lookup helpers other than
> overlayfs and nfsd, to estimate how many of them are pre-content event
> safe and how many are a hopeless case.
> 
> On the top of my head, trying to make a cachefilesd directory an HSM
> directory is absolutely insane, so not every user of vfs lookup helpers
> should be able to populate HSM content - should should simply fail
> (with a meaningful kmsg log).

Right. What you write makes a lot of sense. You've convinced me that
returning error from overlayfs (or similar users) when they try to access
HSM managed dir is the least painful solution :).

> > As I wrote in my first email what I'd like to avoid is having part of the
> > functionality accessible in one way (say through FAN_REPORT_DIR_FD) and
> > having to switch to different way (FAN_REPORT_DFID_NAME) for full
> > functionality. That is in my opinion confusing to users and makes the api
> > messy in the long term. So I'd lean more towards implementing fid-based
> > events from the start. I don't think implementation-wise it's going to be
> > much higher effort than FAN_REPORT_DIR_FD. I agree that for users it is
> > somewhat more effort - they have to keep the private mount, open fhandle to
> > get to the dir so that they can fill it in. But that doesn't seem to be
> > that high bar either?
> >
> 
> ok.
> 
> > We even have some precedens that events for regular files support both fd
> > and fid events and for directory operations only fid events are supported.
> > We could do it similarly for HSM events...
> 
> That's true.
> 
> Another advantage is that FAN_REPORT_FID | FAN_CLASS_PRE_CONTENT
> has not been allowed so far, so we can use it to set new semantics
> that do not allow FAN_ONDIR and FAN_EVENT_ON_CHILD at all.
> The two would be fully implied from the event type, unlike today
> where we ignore them for some event types and use different meanings
> to other event types.

Right.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

