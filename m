Return-Path: <linux-fsdevel+bounces-53918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D7AF8E82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A9E1772B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDF42BEFFC;
	Fri,  4 Jul 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToM5WNjK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="glLUCUrv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToM5WNjK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="glLUCUrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1F2874EF
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621049; cv=none; b=QTmhEnD4y2fcTbKBRvcMs+L8EcWITg7am5goe3vijaDZ8ljmQ/fl7ZM7AbLsuMu/rSv57HURyKcZFZyeAWkKbHuJPlPgnOgusbW5Me7+1GFVkjn12B413f3vD0oXzkKP3tAJUhi0Wueun9g86JwgGa0IC57kLMmZwd0f+MVGPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621049; c=relaxed/simple;
	bh=dj2uDbiz5dFmmA8oWTWuiqcFFzkN4XqgJgiRGDmaEmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRoXwt80v/P4UNcCntdP0uKgFYyQUCAC//xgL+k+czMM+1ns+8bfRLRPqbb6zddEBeugaCjX0WpKoepO6oyZSwLg89Sn85bMzjI7cFgGwv9nYXvd8Z59lW1tmXVP+KfpzDxlMOdy9p3Ld0jFa+lR5QNL+QZIru1T99v80E7iI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToM5WNjK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=glLUCUrv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToM5WNjK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=glLUCUrv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B71121182;
	Fri,  4 Jul 2025 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751621045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfqpimPsDW3aGg3QBKrNXGHRkxzXX/g1hMOF2EDi0ic=;
	b=ToM5WNjKKuQ18/kPR9wpwfuM7elqlCkshFLcZrBTXXpE77rJ+gZju9qMSPursTgt13dbFb
	5GZHb1bwqLXR+p5jtQJwjjjWiDkoLzzptgYU+YEHaa1NR+S38y94y1fmJQlY/KZ6nn07h+
	84CHqQI+gN/p79H5h7gz/12XmecHC1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751621045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfqpimPsDW3aGg3QBKrNXGHRkxzXX/g1hMOF2EDi0ic=;
	b=glLUCUrvnhACgU+egFqK0kPGgjrwqSX0OGfS7FDkZIiy8sUX2NUQtAymhd5OOTR9FSrwSK
	9AxKuwgjyHvIXcDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ToM5WNjK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=glLUCUrv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751621045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfqpimPsDW3aGg3QBKrNXGHRkxzXX/g1hMOF2EDi0ic=;
	b=ToM5WNjKKuQ18/kPR9wpwfuM7elqlCkshFLcZrBTXXpE77rJ+gZju9qMSPursTgt13dbFb
	5GZHb1bwqLXR+p5jtQJwjjjWiDkoLzzptgYU+YEHaa1NR+S38y94y1fmJQlY/KZ6nn07h+
	84CHqQI+gN/p79H5h7gz/12XmecHC1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751621045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfqpimPsDW3aGg3QBKrNXGHRkxzXX/g1hMOF2EDi0ic=;
	b=glLUCUrvnhACgU+egFqK0kPGgjrwqSX0OGfS7FDkZIiy8sUX2NUQtAymhd5OOTR9FSrwSK
	9AxKuwgjyHvIXcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D5DA13757;
	Fri,  4 Jul 2025 09:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qpCAIrWdZ2jnJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Jul 2025 09:24:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4293DA0A31; Fri,  4 Jul 2025 11:24:01 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:24:01 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
Message-ID: <gi5bf6arjqycvzs5trox65ld5xaabnkihh4dp5oycsb2a2katp@46puvf6luehw>
References: <20250604160918.2170961-1-amir73il@gmail.com>
 <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
 <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
 <2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rinzwbq7xxfjf5z7@3nqidi3mno46>
 <CAOQ4uxgjHGL4=9LCCbb=o1rFyziK4QTrJKzUYf=b2Ri9bk4ZPA@mail.gmail.com>
 <uxetof5i2ejhwujegsbhltntnozd4rz6cxtqx3xmtc63xugkyq@53bwknir2ha7>
 <CAOQ4uxhnXaQRDK=LpdPbAMfUU8EPze17=EHASQmG7bN5NdHWew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhnXaQRDK=LpdPbAMfUU8EPze17=EHASQmG7bN5NdHWew@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9B71121182
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 03-07-25 21:14:11, Amir Goldstein wrote:
> On Tue, Jun 17, 2025 at 11:43 AM Jan Kara <jack@suse.cz> wrote:
> > On Mon 16-06-25 19:00:42, Amir Goldstein wrote:
> > > On Mon, Jun 16, 2025 at 11:07 AM Jan Kara <jack@suse.cz> wrote:
> > > > On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> > > > > On Tue, Jun 10, 2025 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > > > > > If we decide that we want to support FAN_PATH_ACCESS from all the
> > > > > > > path-less lookup_one*() helpers, then we need to support reporting
> > > > > > > FAN_PATH_ACCESS event with directory fid.
> > > > > > >
> > > > > > > If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we still
> > > > > > > have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, because
> > > > > > > we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS events
> > > > > > > on its "work" mount - the path via which directories are populated.
> > > > > > >
> > > > > > > There may be a middle ground:
> > > > > > > - Pass optional path arg to __lookup_slow() (i.e. from walk_component())
> > > > > > > - Move fsnotify hook into __lookup_slow()
> > > > > > > - fsnotify_lookup_perm() passes optional path data to fsnotify()
> > > > > > > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS without
> > > > > > >   path data
> > > > > > >
> > > > > > > This way, if HSM is enabled on an sb and not ignored on specific dir
> > > > > > > after it was populated, path lookup from syscall will trigger
> > > > > > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup inside
> > > > > > > non-populated directories.
> > > > > >
> > > > > > OK, but how will this manifest from the user POV? If we have say nfs
> > > > > > exported filesystem that is HSM managed then there would have to be some
> > > > > > knowledge in nfsd to know how to access needed files so that HSM can pull
> > > > > > them? I guess I'm missing the advantage of this middle-ground solution...
> > > > >
> > > > > The advantage is that an admin is able to set up a "lazy populated fs"
> > > > > with the guarantee that:
> > > > > 1. Non-populated objects can never be accessed
> > > > > 2. If the remote fetch service is up and the objects are accessed
> > > > >     from a supported path (i.e. not overlayfs layer) then the objects
> > > > >     will be populated on access
> > > > >
> > > > > This is stronger and more useful than silently serving invalid content IMO.
> > > > >
> > > > > This is related to the discussion about persistent marks and how to protect
> > > > > against access to non-populated objects while service is down, but since
> > > > > we have at least one case that can result in an EIO error (service down)
> > > > > then another case (access from overlayfs) maybe is not a game changer(?)
> > > >
> > > > Yes, reporting error for unpopulated content would be acceptable behavior.
> > > > I just don't see this would be all that useful.
> > > >
> > >
> > > Regarding overlayfs, I think there is an even bigger problem.
> > > There is the promise that we are not calling the blocking pre-content hook
> > > with freeze protection held.
> > > In overlayfs it is very common to take the upper layer freeze protection
> > > for a relatively large scope (e.g. ovl_want_write() in ovl_create_object())
> > > and perform lookups on upper fs or lower fs within this scope.
> > > I am afraid that cleaning that up is not going to be realistic.
> > >
> > > IMO, it is perfectly reasonable that overlayfs and HSM (at least pre-dir-access)
> > > will be mutually exclusive features.
> > >
> > > This is quite similar to overlayfs resulting in EIO if lower fs has an
> > > auto mount point.
> > >
> > > Is it quite common for users to want overlayfs mounted over
> > > /var/lib/docker/overlay2
> > > on the root fs.
> > > HSM is not likely to be running on / and /etc, but likely on a very
> > > distinct lazy populated source dir or something.
> > > We can easily document and deny mounting overlayfs over subtrees where
> > > HSM is enabled (or just pre-path events).
> > >
> > > This way we can provide HSM lazy dir populate to the users that do not care
> > > about overlayfs without having to solve very hard to unsolvable issues.
> > >
> > > I will need to audit all the other users of vfs lookup helpers other than
> > > overlayfs and nfsd, to estimate how many of them are pre-content event
> > > safe and how many are a hopeless case.
> > >
> > > On the top of my head, trying to make a cachefilesd directory an HSM
> > > directory is absolutely insane, so not every user of vfs lookup helpers
> > > should be able to populate HSM content - should should simply fail
> > > (with a meaningful kmsg log).
> >
> > Right. What you write makes a lot of sense. You've convinced me that
> > returning error from overlayfs (or similar users) when they try to access
> > HSM managed dir is the least painful solution :).
> >
> 
> Oh oh, now I need to try to convince you of a solution that is less painful
> than the least painful solution ;)

:)

> I have been experimenting with some code and also did a first pass audit
> of the vfs lookup callers.
> 
> First of all, Neil's work to categorize the callers into lookup_noperm*
> and lookup_one* really helped this audit. (thanks Neil!)
> 
> The lookup_noperm* callers are not "vfs users" they are internal fs
> callers that should not call fsnotify pre-content hooks IMO.
> 
> The lookup_one* callers are vfs callers like ovl,cachefiles, as well
> as nfsd,ksmbd.
> 
> Some of the lookup_one() calls are made from locked context, so not
> good for pre-content events, but most of them are not relevant anyway
> because they are not first access to dir (e.g. readdirplus which already
> started to iterate dir).
> 
> Adding lookup pre-content hooks to nfsd and ksmbd before the relevant
> lookup_one* callers and before fs locks are taken looks doable.
> 
> But the more important observation I had is that allowing access to
> dirs with unpopulated content is not that big of a deal.
> 
> Allowing access to files that are sparse files before their content is filled
> could have led applications to fault and users to suffer.
> 
> Allowing access to unpopulated dirs, e.g. from overlayfs or even from
> nfsd, just results in getting ENOENT or viewing an empty directory.

Right. Although if some important files would be missing, you'd still cause
troubles to applications and possible crashes (or app shutdowns). But I
take the ENOENT return in this case as a particular implementation of the
"just return error to userspace if we have no chance to handle the lookup
in this context" policy.

> My conclusion is, that if we place the fsnotify lookup hook in
> lookup_slow() then the only thing we need to do is:
> When doing lookup_one*() from possibly unsafe context,
> in a fs that has pre-dir-content watchers,
> we always allow the lookup,
> but we never let it leave a negative dcache entry.
> 
> If the lookup finds a child entry, then dir is anyway populated.
> If dir is not populated, the -ENOENT result will not be cached,
> so future lookups of the same name from safe context will call the hook again,
> populate the file or entire directory and create positive/negative dentry,
> and then following lookups of the same name will not call the hook.

Yes, this looks pretty much like what we've agreed on before, just now the
implementation is getting more concrete shape. Or am I missing something?

> The only flaw in this plan is that the users that do not populate
> directories can create entries in those directories, which can violate
> O_CREAT | O_EXCL and mkdir(), w.r.t to a remote file.
>
> But this flaw can be reported properly by the HSM daemon when
> trying to populate a directory which is marked as unpopulated and
> finding files inside it.
> 
> HSM could auto-resolve those conflicts or prompt admin for action
> and can return ESTALE error (or a like) to users.
> 
> Was I clear? Does that sound reasonable to you?

So far we have only one-way synchronization for files (i.e., we don't
expect the HSM client to actually modify the filesystem, the server is the
ultimate source of truth). Aren't we going to do it similarly for
directories? It would be weird to try to handle dir modifications without
supporting file modifications. And if we aim for one-way synchronization,
then I'd expect the HSM service to maybe just expose RO mount to
applications (superblock and the private mount used for filling in data
have to be obviously RW). If it lets applications write to the fs for
whatever reason, it has to keep all the pieces together, I don't think the
kernel is responsible there. Hmm?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

