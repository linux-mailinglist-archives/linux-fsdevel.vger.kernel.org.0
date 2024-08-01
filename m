Return-Path: <linux-fsdevel+bounces-24838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4977945423
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122AAB2250A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259214A603;
	Thu,  1 Aug 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rcZEhYdi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMHSUL/C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rcZEhYdi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMHSUL/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485E17579
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722548098; cv=none; b=L0vANFhML1vt39FLIua4v4fmbXznVRPYdXNTpS/MP/DPqrWnR5eDUA02RbR+iVimKZkOIzaSvCEgjCDNnZGvZT/Nu76ubRDUM1Lbuen25hZxJpvft79qJLnatDnb0NS6JyTjTKzl8xTCg5ThcYG/LpDQHYtiBylEPelJ4+k6S2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722548098; c=relaxed/simple;
	bh=xXZZbKVYDg/dsWPV5zNxCBgMDTwxkUWCI3jInfjQ5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzquNfTEetEJdRIzBG8yLjhsV38d5nE2Jff3jTdiCai+1CoLtN/lfdAdOFcpUk4jPuWPoS2hvWR+pBIhPZhD9eICzGEtRdUV/7kI/kBWPHSWpnsgirzkRx5yJBwk53xBewz4UfD0f5mZwi/+Uz4bsp4arQufhyrnBFgy3z6V6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rcZEhYdi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMHSUL/C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rcZEhYdi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMHSUL/C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24AA61FB6F;
	Thu,  1 Aug 2024 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722548095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akHXh/uDAUZJdhf2042b06oEFybdt5Efht4gmmnsoO0=;
	b=rcZEhYdi6CgzGmeYWznITO19SOT5aXutNRTKV2v4/n7CkbLo/qOc0ozlYKsRkX/4dl5IlS
	0E1VGJybTrepxjCKWZbacwpzpCT8D6+2ZTPW0uSsSqj3a2eGq0knbSx3UgKbFJl9i5kBsI
	KkdkWlkaisu6yHwodgJ0rn2r05tuuW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722548095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akHXh/uDAUZJdhf2042b06oEFybdt5Efht4gmmnsoO0=;
	b=EMHSUL/ChbepX+5TCZjPLSPI/9DRFDGABoHc49/WR/4dUx/4EfUIolzNWWbeMCQRsPA6y6
	7/FDuJqot518WgDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722548095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akHXh/uDAUZJdhf2042b06oEFybdt5Efht4gmmnsoO0=;
	b=rcZEhYdi6CgzGmeYWznITO19SOT5aXutNRTKV2v4/n7CkbLo/qOc0ozlYKsRkX/4dl5IlS
	0E1VGJybTrepxjCKWZbacwpzpCT8D6+2ZTPW0uSsSqj3a2eGq0knbSx3UgKbFJl9i5kBsI
	KkdkWlkaisu6yHwodgJ0rn2r05tuuW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722548095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akHXh/uDAUZJdhf2042b06oEFybdt5Efht4gmmnsoO0=;
	b=EMHSUL/ChbepX+5TCZjPLSPI/9DRFDGABoHc49/WR/4dUx/4EfUIolzNWWbeMCQRsPA6y6
	7/FDuJqot518WgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 191A1136CF;
	Thu,  1 Aug 2024 21:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JCweBn//q2Y/dQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 21:34:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC30DA08CB; Thu,  1 Aug 2024 23:34:54 +0200 (CEST)
Date: Thu, 1 Aug 2024 23:34:54 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240801213454.hcx5nsmvntysf5ym@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <CAOQ4uxgXEzT=Buwu8SOkQG+2qcObmdH4NgsGme8bECObiobfTQ@mail.gmail.com>
 <20240729171120.GB3596468@perftesting>
 <CAOQ4uxjjBiPkg9uxyW12Xd+GZ7t3aP1m9Ayzr8WzqryfqK1x3g@mail.gmail.com>
 <20240730121837.fixxjcbbu7caxf2s@quack3>
 <20240730165149.GA3828363@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730165149.GA3828363@perftesting>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,fb.com,vger.kernel.org,kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 30-07-24 12:51:49, Josef Bacik wrote:
> On Tue, Jul 30, 2024 at 02:18:37PM +0200, Jan Kara wrote:
> > On Mon 29-07-24 21:57:34, Amir Goldstein wrote:
> > > On Mon, Jul 29, 2024 at 8:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > > > If I am reading correctly, iomap (i.e. xfs) write shared memory fault
> > > > > does not reach this code?
> > > > >
> > > > > Do we care about writable shared memory faults use case for HSM?
> > > > > It does not sound very relevant to HSM, but we cannot just ignore it..
> > > > >
> > > >
> > > > Sorry I realized I went off to try and solve this problem and never responded to
> > > > you.  I'm addressing the other comments, but this one is a little tricky.
> > > >
> > > > We're kind of stuck between a rock and a hard place with this.  I had originally
> > > > put this before the ->fault() callback, but purposefully moved it into
> > > > filemap_fault() because I want to be able to drop the mmap lock while we're
> > > > waiting for a response from the HSM.
> > > >
> > > > The reason to do this is because there are things that take the mmap lock for
> > > > simple things outside of the process, like /proc/$PID/smaps and other related
> > > > things, and this can cause high priority tasks to block behind possibly low
> > > > priority IO, creating a priority inversion.
> > > >
> > > > Now, I'm not sure how widespread of a problem this is anymore, I know there's
> > > > been work done to the kernel and tools to avoid this style of problem.  I'm ok
> > > > with a "try it and see" approach, but I don't love that.
> > > >
> > > 
> > > I defer this question to Jan.
> > > 
> > > > However I think putting fsnotify hooks into XFS itself for this particular path
> > > > is a good choice either.
> > > 
> > > I think you meant "not a good choice" and I agree -
> > > it is not only xfs, but could be any fs that will be converted to iomap
> > > Other fs have ->fault != filemap_fault, even if they do end up calling
> > > filemap_fault, IOW, there is no API guarantee that they will.
> > > 
> > > > What do you think?  Just move it to before ->fault(),
> > > > leave the mmap lock in place, and be done with it?
> > > 
> > > If Jan blesses the hook called with mmap lock, then yeh,
> > > putting the hook in the most generic "vfs" code would be
> > > the best choice for maintenance.
> > 
> > Well, I agree with Josef's comment about a rock and a hard place. For once,
> > regardless whether the hook will happen from before ->fault or from inside
> > the ->fault handler there will be fault callers where we cannot drop
> > mmap_lock (not all archs support dropping mmap_lock inside a fault AFAIR -
> > but a quick grep seems to show that these days maybe they do, also some
> > callers - most notably through GUP - don't allow dropping of mmap_lock
> > inside fault). So we have to have a way to handle a fault without
> > FAULT_FLAG_ALLOW_RETRY flag.
> > 
> > Now of course waiting for userspace reply to fanotify event with mmap_lock
> > held is ... dangerous. For example consider application with two threads:
> > 
> > T1					T2
> > page fault on inode I			write to inode I
> >   lock mm->mmap_lock			  inode_lock(I)
> >     send fanotify event			  ...
> > 					  fault_in_iov_iter_readable()
> > 					    lock mm->mmap_lock -> blocks
> > 					      behind T1
> > 
> > now the HSM handler needs to fill in contents of inode I requested by the
> > page fault:
> > 
> >   inode_lock(I) -> deadlock
> > 
> > So conceptually I think the flow could look like (in __do_fault):
> > 
> > 	if (!(vmf->flags & FAULT_FLAG_TRIED) &&
> > 	    fsnotify_may_send_pre_content_event()) {
> > 		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> > 			return VM_FAULT_RETRY;
> > 		fpin = maybe_unlock_mmap_for_io(vmf, NULL);
> > 		if (!fpin)
> > 			return ???VM_FAULT_SIGSEGV???;
> > 		err = fsnotify_fault(...);
> > 		if (err)
> > 			return VM_FAULT_SIGBUS | VM_FAULT_RETRY;
> > 		/*
> > 		 * We are fine with proceeding with the fault. Retry the fault
> > 		 * to let the filesystem handle it.
> > 		 */
> > 		return VM_FAULT_RETRY;
> > 	}
> > 
> > The downside is that if we enter the page fault without ability to drop
> > mmap_lock on a file needing HSM handling, we get SIGSEGV. I'm not sure it
> > matters in practice because these are not that common paths e.g. stuff like
> > putting a breakpoint / uprobe on a file but maybe there are some surprises.
> > 
> 
> The only thing I don't like about this is that now the fault handler
> loses the ability to drop the mmap sem.  I think in practice this doesn't
> really matter, because we're trying to avoid doing IO while under the
> mmap sem, and presumably this will have instantiated the pages to avoid
> the IO.
> 
> However if you use reflink this wouldn't be the case, and now we've
> re-introduced the priority inversion possiblity.

Hum, you're right. I was focused on handling the case when HSM needs to
pull in the page but the common case when the page is local, just not in
cache, is also very important.

> I'm leaning more towards just putting the fsnotify hook in the xfs code
> for the write case, and anybody else who implements their own ->fault
> without calling the generic one will just have to do the same.
> 
> That being said I'm not going to die on any particular hill here, if you
> still want to do the above before the ->fault() handler then I'll update
> my code to do that and we can move on.  Thanks,

I think for now issuing the pre content event from ->fault is OK. I'm not
thrilled about it (since it ultimately means duplication among page fault
handlers) but I don't see a cleaner solution that would perform reasonably
well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

