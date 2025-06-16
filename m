Return-Path: <linux-fsdevel+bounces-51720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD71DADAB7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044B0188BAD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AB20127B;
	Mon, 16 Jun 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXuBwPDR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ol3PbQ+g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXuBwPDR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ol3PbQ+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218D1FF1C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064871; cv=none; b=T02ix+ejKasw+c1LwMVIh/hprTWfdpeG84D7ky7HfEW/j6FUWQ8RnJqZGPZzJXn/FO5wm6uGNgtjVspXf3wMJ2XxjGHKgRyxEj71YRl/aW6naKZdWSNsEnb64Pn8VfcbMtS69GPG2b/sEdfYXoNxmm6pBWkUGyP556+6TxC8TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064871; c=relaxed/simple;
	bh=1LjkGH023z5VJBTOK64K4NabHr8r9LPgJU7arBEMX7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/523CGEEDtM9fAuo4EIirA3CJsLTiGZWg8Cj5M2DGuppHYA7vIjAtZ/UV/6NlRRpOZo0R+HHa+iuMd72AMxV74SWGw08mINmzVh9yckotYsDxukVfKSMut8jVwheQldJwG+fp3vxM4+CDSbZygN6a0szMwQsjQU03ZVtJk3MYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXuBwPDR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ol3PbQ+g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXuBwPDR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ol3PbQ+g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66A611F38F;
	Mon, 16 Jun 2025 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750064867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IP/K83d2O/RVkoxEw8dV4eMvjAyYnww3kvorzbeLgg=;
	b=xXuBwPDR3EUxRqpDTIooEEAXPt2cgGVKvxR7kZaIK/cVsvvxPS/foniVbGAdiQUa3qspHa
	jqda0TvAN6VhcDaEfELiS8Zf9c6z9j5NiQH3PNH6fbE01FuTaq1q1CDVOI+wTy0gzbHENK
	Rntyu6wDJOu4RHQft57UmlwrS3wUxds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750064867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IP/K83d2O/RVkoxEw8dV4eMvjAyYnww3kvorzbeLgg=;
	b=Ol3PbQ+g8cgpO+bNF326NX+Lh80YPDQP0ChIJfCEOTMSSBLRsF25Ojx3+nrJoG9el0wlww
	+XQ9QdaW7FLIbKCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750064867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IP/K83d2O/RVkoxEw8dV4eMvjAyYnww3kvorzbeLgg=;
	b=xXuBwPDR3EUxRqpDTIooEEAXPt2cgGVKvxR7kZaIK/cVsvvxPS/foniVbGAdiQUa3qspHa
	jqda0TvAN6VhcDaEfELiS8Zf9c6z9j5NiQH3PNH6fbE01FuTaq1q1CDVOI+wTy0gzbHENK
	Rntyu6wDJOu4RHQft57UmlwrS3wUxds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750064867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IP/K83d2O/RVkoxEw8dV4eMvjAyYnww3kvorzbeLgg=;
	b=Ol3PbQ+g8cgpO+bNF326NX+Lh80YPDQP0ChIJfCEOTMSSBLRsF25Ojx3+nrJoG9el0wlww
	+XQ9QdaW7FLIbKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D180139E2;
	Mon, 16 Jun 2025 09:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W3/NEuPeT2g2RwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Jun 2025 09:07:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF41BA0951; Mon, 16 Jun 2025 11:07:46 +0200 (CEST)
Date: Mon, 16 Jun 2025 11:07:46 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
Message-ID: <2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rinzwbq7xxfjf5z7@3nqidi3mno46>
References: <20250604160918.2170961-1-amir73il@gmail.com>
 <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
 <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Hi Amir!

On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> On Tue, Jun 10, 2025 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
> > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > I am still tagging this as RFC for two semi-related reasons:
> > >
> > > 1) In my original draft of man-page for FAN_PATH_ACCESS [2],
> > > I had introduced a new class FAN_CLASS_PRE_PATH, which FAN_PATH_ACCESS
> > > requires and is defined as:
> > > "Unlike FAN_CLASS_PRE_CONTENT, this class can be used along with
> > >  FAN_REPORT_DFID_NAME to report the names of the looked up files along
> > >  with O_PATH file descriptos in the new path lookup events."
> > >
> > > I am not sure if we really need FAN_CLASS_PRE_PATH, so wanted to ask
> > > your opinion.
> > >
> > > The basic HSM (as implemented in my POC) does not need to get the lookup
> > > name in the event - it populates dir on first readdir or lookup access.
> > > So I think that support for (FAN_CLASS_PRE_CONTENT | FAN_REPORT_DFID_NAME)
> > > could be added later per demand.
> >
> > The question here is what a real user is going to do? I know Meta guys
> > don't care about directory events for their usecase. You seem to care about
> > them so I presume you have some production use in mind?
> 
> Yes we have had it in production for a long time -
> You can instantaneously create a lazy clone of the entire "cloud fs" locally.
> Directories get populated with sparse files on first access.
> Sparse files get populated with data on first IO access.
> It is essentially the same use case as Meta and many other similar users.
> The need for directory populate is just a question of scale -
> How much does it take to create a "metadata clone" or the remote fs copy
> and create all the sparse files.
> At some point, it becomes too heavy to not do it lazily.
> 
> > How's that going to
> > work? Because if I should guess I'd think that someone asks for the name
> > being looked up sooner rather than later because for large dirs not having
> > to fetch everything on lookup would be a noticeable win...
> 
> Populating a single sparse file on lookup would be a large win, but also pretty
> hard to implement this "partially populated dir" state correctly. For
> that reason,
> We have not implemented this so far, but one can imagine (as you wrote) that
> someone else may want to make use of that in the future.

OK, thanks for clarification.

> > > 2) Current code does not generate FAN_PRE_ACCESS from vfs internal
> > > lookup helpers such as  lookup_one*() helpers from overalyfs and nfsd.
> > > This is related to the API of reporting an O_PATH event->fd for
> > > FAN_PATH_ACCESS event, which requires a mount.
> >
> > AFAIU this means that you could not NFS export a filesystem that is HSM
> > managed and you could not use HSM managed filesystem to compose overlayfs.
> > I don't find either of those a critical feature but OTOH it would be nice
> > if the API didn't restrict us from somehow implementing this in the future.
> >
> 
> Right.
> There are a few ways to address this.
> FAN_REPORT_DFID_NAME is one of them.
> 
> Actually, the two cases, overlayfs and nfsd are different
> in the aspect that the overlayfs layer uses a private mount clone
> while nfsd actually exports a specific user visible mount.
> So at least in theory nfsd could report lookup events with a path
> as demonstrated with commit from my WIP FAN_PRE_MODIFY patches
> https://github.com/amir73il/linux/commit/4a8b6401e64d8dbe0721e5aaa496f0ad59208560

OK, I agree that for nfsd reporting the event with the mount that nfsd exports
would make sense.

> Another way is to say that event->fd does not need to indicate the
> mount where the event happened.
> Especially if event->fd is O_PATH fd, then it could simply refer to a
> directory dentry using some arbitrary mount that the listener has access to.
> For example, we can allow an opt-in flag to say that the listener keeps
> an O_PATH fd for the path provided in fanotify_mark() (i.e. for an sb mark)
> and let fanotify report event->fd based on the listener's mount regardless
> of the event generator's mount.

So this would be controversial I think. Mounts can have different
properties (like different read-only settings, different id mappings, ...),
can reveal different parts of the filesystem and generally will be
differently placed in mount hierarchy. So in particular with sb marks the
implications of arbitrarily combining mount of a sb with some random dentry
(which need not even be accesible through the mount) could lead to surprising
results.

> There is no real concern about the listener keeping the fs mount busy because:
> 1. lsof will show this reference to the mount
> 2. A proper listener with FAN_REPORT_DFID_NAME has to keep open
>    mount_fd mapped to fsid anyway to be able to repose paths from events
>    (for example: fsnotifywatch implementation in inotify-tools)
> 
> Then functionally, FAN_REPORT_DIR_FID and FAN_REPORT_DIR_FD
> would be similar, except that the latter keeps a reference to the object while
> in the event queue and the former does not.

Yeah, I'm not that concerned about keeping the fs busy. After all we
currently grab inode references and drop them on umount and we could do the
same with whatever other references we have to the fs. 

> > > If we decide that we want to support FAN_PATH_ACCESS from all the
> > > path-less lookup_one*() helpers, then we need to support reporting
> > > FAN_PATH_ACCESS event with directory fid.
> > >
> > > If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we still
> > > have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, because
> > > we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS events
> > > on its "work" mount - the path via which directories are populated.
> > >
> > > There may be a middle ground:
> > > - Pass optional path arg to __lookup_slow() (i.e. from walk_component())
> > > - Move fsnotify hook into __lookup_slow()
> > > - fsnotify_lookup_perm() passes optional path data to fsnotify()
> > > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS without
> > >   path data
> > >
> > > This way, if HSM is enabled on an sb and not ignored on specific dir
> > > after it was populated, path lookup from syscall will trigger
> > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup inside
> > > non-populated directories.
> >
> > OK, but how will this manifest from the user POV? If we have say nfs
> > exported filesystem that is HSM managed then there would have to be some
> > knowledge in nfsd to know how to access needed files so that HSM can pull
> > them? I guess I'm missing the advantage of this middle-ground solution...
> 
> The advantage is that an admin is able to set up a "lazy populated fs"
> with the guarantee that:
> 1. Non-populated objects can never be accessed
> 2. If the remote fetch service is up and the objects are accessed
>     from a supported path (i.e. not overlayfs layer) then the objects
>     will be populated on access
> 
> This is stronger and more useful than silently serving invalid content IMO.
>
> This is related to the discussion about persistent marks and how to protect
> against access to non-populated objects while service is down, but since
> we have at least one case that can result in an EIO error (service down)
> then another case (access from overlayfs) maybe is not a game changer(?)

Yes, reporting error for unpopulated content would be acceptable behavior.
I just don't see this would be all that useful.
 
> > > Supporting populate events from overalyfs/nfsd could be implemented
> > > later per demand by reporting directory fid instead of O_PATH fd.
> > >
> > > If you think that is worth checking, I can prepare a patch for the above
> > > so we can expose it to performance regression bots.
> > >
> > > Better yet, if you have no issues with the implementation in this
> > > patch set, maybe let it soak in for_next/for_testing as is to make
> > > sure that it does not already introduce any performance regressions.
> > >
> > > Thoughts?
> >
> > If I should summarize the API situation: If we ever want to support HSM +
> > NFS export / overlayfs, we must implement support for pre-content events
> > with FID (DFID + name to be precise).
> 
> Yes, but there may be alternatives to FID.
> 
> > If we want to support HSM events on
> > lookup with looked up name, we don't have to go for full DFID + name but we
> > must at least add additional info with the name to the event.
> 
> Yes, reporting name is really a feature that could be opt-in.
> And if we report name, it is no effort to also report FID,
> regardless if we also report event->fd or not.
> 
> > Also if we go
> > for reporting directory pre-content events with standard events, you want
> > to add support for returning O_PATH fds for better efficiency and the code
> > to handle FMODE_NONOTIFY directory fds in path lookup.
> >
> 
> Yes. technically, O_PATH fd itself could be used to perform the populate of
> dir in a kin way to event->fd being used to populate a file, so it is
> elegant IMO.

I agree it is kind of elegant. But I find reporting DFID and leaving upto
userspace to provide "ignored" mount to fill in the contents elegant as
well and there's no need to define behavior of O_PATH dir fds with NONOTIFY
flags.

> > Frankly seeing all this I think that going for DFID + name events for
> > directory HSM events from the start may be the cleanest choice long term
> > because then we'll have one way how to access the directory HSM
> > functionality with possibility of extensions without having to add
> > different APIs for it.
> 
> I see the appeal in that.
> I definitely considered that when we planned the API
> just wanted to consult with you before going forward with implementation.
> 
> > We'd just have to implement replying to FID events
> > because we won't have fd to identify event we reply to so that will need
> > some thought.
> 
> I keep forgetting about that :-D
> 
> My suggestion for FAN_REPORT_DIR_FD could work around this
> problem ellegantly.

I agree FAN_REPORT_DIR_FD doesn't have this problem and that certainly adds
some appeal to it:). OTOH it is not that hard to solve - you'd need some
idr allocator in the notification group and pass the identifier together
with the event.

> > What are your thoughts? Am I missing something?
> 
> My thoughts are that FAN_REPORT_DIR_FD and
> FAN_REPORT_DFID_NAME may both be valid solutions and
> they are not even conflicting.
> In fact, there is no clear reason to deny mixing them together.
> 
> If you do not have any objection to the FAN_REPORT_DIR_FD
> solution, then we need to decide if we want to do them both?
> one at a time? both from the start?
> 
> My gut feeling is that FAN_REPORT_DIR_FD is going to be
> more easy to implement and to users to use for first version
> and then whether or not we need to extend to report name
> we can deal with later.

As I wrote in my first email what I'd like to avoid is having part of the
functionality accessible in one way (say through FAN_REPORT_DIR_FD) and
having to switch to different way (FAN_REPORT_DFID_NAME) for full
functionality. That is in my opinion confusing to users and makes the api
messy in the long term. So I'd lean more towards implementing fid-based
events from the start. I don't think implementation-wise it's going to be
much higher effort than FAN_REPORT_DIR_FD. I agree that for users it is
somewhat more effort - they have to keep the private mount, open fhandle to
get to the dir so that they can fill it in. But that doesn't seem to be
that high bar either?

We even have some precedens that events for regular files support both fd
and fid events and for directory operations only fid events are supported.
We could do it similarly for HSM events...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

