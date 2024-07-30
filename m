Return-Path: <linux-fsdevel+bounces-24597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB39411AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4724A1F237AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6019DFA9;
	Tue, 30 Jul 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aWrAGm9a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+DCzSl+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aWrAGm9a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+DCzSl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51728198850
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341921; cv=none; b=FRuhyyw6T356hotUid6f4pZxSU6lbkeOZaAdyUyb5NmlnkcmEC1yvqWieNqZXKMuuALMXQtF6iLClVShoFJxmhkdnz3k5qQGW5w/3C15I4oFnWI8sHIXLnDXneKZZNqTYHF7wd8uIpgwsLq/xKnrer93CnG4iAdBqnEHZa9IakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341921; c=relaxed/simple;
	bh=iyp2ksf8Ssdwe8kUjwD1QSqEgLWE/lUKNEVgfF7Ld84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AckoQRagq2qQ48IyBmGRcyQ0AOms6879E3rquFnrHK1yU2ysSd664cn/EYqJ6OzQrmzmdUn4q8gUelMkdNpi2BEs4ym6uwCJhG58dZW5ciEdaOIjbpp5j/8RDXhHHtXG+OWjML3GkWhDsSOG5mB63CTHU9q+Z9yvcz7mOp+x3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aWrAGm9a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+DCzSl+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aWrAGm9a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+DCzSl+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9389A1F7EB;
	Tue, 30 Jul 2024 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722341917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+EUxgOpV+xRL+481sCjzjumGLfmJXZ4nQhDBQad88g=;
	b=aWrAGm9afIyu486IPRGx85s4lFeOFRHL04b9rtrjvSLbQ3UWOVRBsVTImLQnyVzUa8ZxEH
	L0KQLgeUHjO0roI3jlzqPTdIGaDtyC8AEuzCdSK/YUGifl0PxcWrUVus2pqcFQDeCawGHJ
	Eta3FDznEkqWZT8c+fezNR13wRfdjhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722341917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+EUxgOpV+xRL+481sCjzjumGLfmJXZ4nQhDBQad88g=;
	b=K+DCzSl+ZvjLeMlJ4J60BmH2Sa/3xA4d4LvcBdQ38UKXtOhNwEulgfQEi0kYhpH/eWSu4h
	9vN1MUrLdSHjmyBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722341917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+EUxgOpV+xRL+481sCjzjumGLfmJXZ4nQhDBQad88g=;
	b=aWrAGm9afIyu486IPRGx85s4lFeOFRHL04b9rtrjvSLbQ3UWOVRBsVTImLQnyVzUa8ZxEH
	L0KQLgeUHjO0roI3jlzqPTdIGaDtyC8AEuzCdSK/YUGifl0PxcWrUVus2pqcFQDeCawGHJ
	Eta3FDznEkqWZT8c+fezNR13wRfdjhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722341917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+EUxgOpV+xRL+481sCjzjumGLfmJXZ4nQhDBQad88g=;
	b=K+DCzSl+ZvjLeMlJ4J60BmH2Sa/3xA4d4LvcBdQ38UKXtOhNwEulgfQEi0kYhpH/eWSu4h
	9vN1MUrLdSHjmyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8858B13297;
	Tue, 30 Jul 2024 12:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9h1EIR3aqGa9RQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 12:18:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F78EA099C; Tue, 30 Jul 2024 14:18:37 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:18:37 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, jack@suse.cz, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240730121837.fixxjcbbu7caxf2s@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com>
 <20240729171120.GB3596468@perftesting>
 <CAOQ4uxjjBiPkg9uxyW12Xd+GZ7t3aP1m9Ayzr8WzqryfqK1x3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjjBiPkg9uxyW12Xd+GZ7t3aP1m9Ayzr8WzqryfqK1x3g@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Mon 29-07-24 21:57:34, Amir Goldstein wrote:
> On Mon, Jul 29, 2024 at 8:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > If I am reading correctly, iomap (i.e. xfs) write shared memory fault
> > > does not reach this code?
> > >
> > > Do we care about writable shared memory faults use case for HSM?
> > > It does not sound very relevant to HSM, but we cannot just ignore it..
> > >
> >
> > Sorry I realized I went off to try and solve this problem and never responded to
> > you.  I'm addressing the other comments, but this one is a little tricky.
> >
> > We're kind of stuck between a rock and a hard place with this.  I had originally
> > put this before the ->fault() callback, but purposefully moved it into
> > filemap_fault() because I want to be able to drop the mmap lock while we're
> > waiting for a response from the HSM.
> >
> > The reason to do this is because there are things that take the mmap lock for
> > simple things outside of the process, like /proc/$PID/smaps and other related
> > things, and this can cause high priority tasks to block behind possibly low
> > priority IO, creating a priority inversion.
> >
> > Now, I'm not sure how widespread of a problem this is anymore, I know there's
> > been work done to the kernel and tools to avoid this style of problem.  I'm ok
> > with a "try it and see" approach, but I don't love that.
> >
> 
> I defer this question to Jan.
> 
> > However I think putting fsnotify hooks into XFS itself for this particular path
> > is a good choice either.
> 
> I think you meant "not a good choice" and I agree -
> it is not only xfs, but could be any fs that will be converted to iomap
> Other fs have ->fault != filemap_fault, even if they do end up calling
> filemap_fault, IOW, there is no API guarantee that they will.
> 
> > What do you think?  Just move it to before ->fault(),
> > leave the mmap lock in place, and be done with it?
> 
> If Jan blesses the hook called with mmap lock, then yeh,
> putting the hook in the most generic "vfs" code would be
> the best choice for maintenance.

Well, I agree with Josef's comment about a rock and a hard place. For once,
regardless whether the hook will happen from before ->fault or from inside
the ->fault handler there will be fault callers where we cannot drop
mmap_lock (not all archs support dropping mmap_lock inside a fault AFAIR -
but a quick grep seems to show that these days maybe they do, also some
callers - most notably through GUP - don't allow dropping of mmap_lock
inside fault). So we have to have a way to handle a fault without
FAULT_FLAG_ALLOW_RETRY flag.

Now of course waiting for userspace reply to fanotify event with mmap_lock
held is ... dangerous. For example consider application with two threads:

T1					T2
page fault on inode I			write to inode I
  lock mm->mmap_lock			  inode_lock(I)
    send fanotify event			  ...
					  fault_in_iov_iter_readable()
					    lock mm->mmap_lock -> blocks
					      behind T1

now the HSM handler needs to fill in contents of inode I requested by the
page fault:

  inode_lock(I) -> deadlock

So conceptually I think the flow could look like (in __do_fault):

	if (!(vmf->flags & FAULT_FLAG_TRIED) &&
	    fsnotify_may_send_pre_content_event()) {
		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
			return VM_FAULT_RETRY;
		fpin = maybe_unlock_mmap_for_io(vmf, NULL);
		if (!fpin)
			return ???VM_FAULT_SIGSEGV???;
		err = fsnotify_fault(...);
		if (err)
			return VM_FAULT_SIGBUS | VM_FAULT_RETRY;
		/*
		 * We are fine with proceeding with the fault. Retry the fault
		 * to let the filesystem handle it.
		 */
		return VM_FAULT_RETRY;
	}

The downside is that if we enter the page fault without ability to drop
mmap_lock on a file needing HSM handling, we get SIGSEGV. I'm not sure it
matters in practice because these are not that common paths e.g. stuff like
putting a breakpoint / uprobe on a file but maybe there are some surprises.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

