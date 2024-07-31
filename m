Return-Path: <linux-fsdevel+bounces-24703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55473943584
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 20:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2B21F22068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995643F9CC;
	Wed, 31 Jul 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p0t5IPJ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GsvrsjJp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p0t5IPJ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GsvrsjJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3111E86F;
	Wed, 31 Jul 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449822; cv=none; b=ov3OT29E22t8dKuJbzd87nw33VH7t+yFiyC1VQEX+m50Z8nuKuVl5WYt1t6WtRr9L9uqiMaBFjMwHTl9Skha4H2V+g6THIX1r4+Z5wNM11dURHXgaLp4HjriF5M5TTD9tjdFxFUN2vVxfjqTfKu0w2F6ExDty3SWhsQQ5X7BGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449822; c=relaxed/simple;
	bh=T78gojsJos0AvEsr/bGf1cVoJzOEEIAvQcHXm7gNmv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsG+1Goe1GYd6gUYRm/5JJ+/+Id3QWkqTWU9PMcwDTr+7hb0EYfj7arMyy4OU+Cr7+NVwbGRi3vyDg025S8QX5lCtdnmM4h8vUqAA/pthSWT6mCLvDX6CBuInHeWS+F1oBBprcLu4I3mw44QAys4PFfNPITc8jgSLiZoxdvHsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p0t5IPJ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GsvrsjJp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p0t5IPJ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GsvrsjJp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3363021A73;
	Wed, 31 Jul 2024 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722449818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhqt3zhWjxJOvSd3wly17MpAhUjrqZHZ1CI5gzl1Wpc=;
	b=p0t5IPJ56goKwtBHRxZouwjqDJdx01leBesprvyECnXbSdnOOPUfDJfQvjZdCU5/s8LCo8
	EfYzZfqSle3bOkt0oBYlgrVwYcQ7i8LNj8DGIzveK1YSOmuDrtAcvKCtQXMMNRJy3xAJ4I
	bRy3e37XX10y8cllJOiwxp3vXfwSqug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722449818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhqt3zhWjxJOvSd3wly17MpAhUjrqZHZ1CI5gzl1Wpc=;
	b=GsvrsjJpGpJEVQN+kvw35K8+c6QyaBsj5qlqG/A2uJghuxVc3gGP1qoQXf13JN/6kNl2VQ
	KNL+N8FdvZgqfiCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p0t5IPJ5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GsvrsjJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722449818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhqt3zhWjxJOvSd3wly17MpAhUjrqZHZ1CI5gzl1Wpc=;
	b=p0t5IPJ56goKwtBHRxZouwjqDJdx01leBesprvyECnXbSdnOOPUfDJfQvjZdCU5/s8LCo8
	EfYzZfqSle3bOkt0oBYlgrVwYcQ7i8LNj8DGIzveK1YSOmuDrtAcvKCtQXMMNRJy3xAJ4I
	bRy3e37XX10y8cllJOiwxp3vXfwSqug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722449818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhqt3zhWjxJOvSd3wly17MpAhUjrqZHZ1CI5gzl1Wpc=;
	b=GsvrsjJpGpJEVQN+kvw35K8+c6QyaBsj5qlqG/A2uJghuxVc3gGP1qoQXf13JN/6kNl2VQ
	KNL+N8FdvZgqfiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BDB01368F;
	Wed, 31 Jul 2024 18:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o/N4Bpp/qmZuNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 31 Jul 2024 18:16:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4540EA0873; Wed, 31 Jul 2024 20:16:57 +0200 (CEST)
Date: Wed, 31 Jul 2024 20:16:57 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240731181657.dprkkq5jxgatgx2v@quack3>
References: <20240723104533.mznf3svde36w6izp@quack3>
 <2136178.1721725194@warthog.procyon.org.uk>
 <2147168.1721743066@warthog.procyon.org.uk>
 <20240724133009.6st3vmk5ondigbj7@quack3>
 <20240729-gespickt-negativ-c1ce987e3c07@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-gespickt-negativ-c1ce987e3c07@brauner>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 3363021A73
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Mon 29-07-24 17:28:22, Christian Brauner wrote:
> On Wed, Jul 24, 2024 at 03:30:09PM GMT, Jan Kara wrote:
> > On Tue 23-07-24 14:57:46, David Howells wrote:
> > > Then (2) on the other side, you have a read or a write to the network
> > > filesystem through netfslib which may invoke the cache, which may require
> > > cachefiles to check the xattr on the cache file and maybe set/remove it -
> > > which requires the sb_writers lock on the cache filesystem.
> > > 
> > > So if ->read_folio(), ->readahead() or ->writepages() can ever be called with
> > > mm->mmap_lock or vma->vm_lock held, netfslib may call down to cachefiles and
> > > ultimately, it should[*] then take the sb_writers lock on the backing
> > > filesystem to perform xattr manipulation.
> > 
> > Well, ->read_folio() under mm->mmap_lock is a standard thing to happen in a
> > page fault. Now grabbing sb_writers (of any filesystem) in that path is
> > problematic and can deadlock though:
> > 
> > page fault
> >   grab mm->mmap_lock
> >   filemap_fault()
> >     if (unlikely(!folio_test_uptodate(folio))) {
> >       filemap_read_folio() on fs A
> >         now if you grab sb_writers on fs B:
> > 			freeze_super() on fs B		write(2) on fs B
> > 							  sb_start_write(fs B)
> > 			  sb->s_writers.frozen = SB_FREEZE_WRITE;
> > 			  sb_wait_write(sb, SB_FREEZE_WRITE);
> > 			    - waits for write
> > 	sb_start_write(fs B) - blocked behind freeze_super()
> > 							  generic_perform_write()
> > 							    fault_in_iov_iter_readable()
> > 							      page fault
> > 							        grab mm->mmap_lock
> > 								  => deadlock
> > 
> > Now this is not the deadlock your lockdep trace is showing but it is a
> > similar one. Like:
> > 
> > filemap_invalidate() on fs A	freeze_super() on fs B	page fault on fs A	write(2) on fs B
> >   filemap_invalidate_lock()				  lock mm->mmap_lock	  sb_start_write(fs B)
> >   filemap_fdatawrite_wbc()				  filemap_fault()
> >     afs_writepages()					    filemap_invalidate_lock_shared()
> >       cachefiles_issue_write()				      => blocks behind filemap_invalidate()
> > 				  sb->s_writers.frozen = SB_FREEZE_WRITE;
> > 				  sb_wait_write(sb, SB_FREEZE_WRITE);
> > 				    => blocks behind write(2)
> >         sb_start_write() on fs B
> > 	  => blocks behind freeze_super()
> > 							  			  generic_perform_write()
> > 										    fault_in_iov_iter_readable()
> > 										      page fault
> > 										        grab mm->mmap_lock
> > 											  => deadlock
> > 
> > So I still maintain that grabbing sb_start_write() from quite deep within
> > locking hierarchy (like from writepages when having pages locked, but even
> > holding invalidate_lock is enough for the problems) is problematic and
> > prone to deadlocks.
> > 
> > > [*] I say "should" because at the moment cachefiles calls vfs_set/removexattr
> > >     functions which *don't* take this lock (which is a bug).  Is this an error
> > >     on the part of vfs_set/removexattr()?  Should they take this lock
> > >     analogously with vfs_truncate() and vfs_iocb_iter_write()?
> > > 
> > > However, as it doesn't it manages to construct a locking chain via the
> > > mapping.invalidate_lock, the afs vnode->validate_lock and something in execve
> > > that I don't exactly follow.
> > > 
> > > 
> > > I wonder if this is might be deadlockable by a multithreaded process (ie. so
> > > they share the mm locks) where one thread is writing to a cached file whilst
> > > another thread is trying to set/remove the xattr on that file.
> > 
> > Yep, see above. Now the hard question is how to fix this because what you
> > are doing seems to be inherent in how cachefiles fs is designed to work.
> 
> So one idea may be to create a private mount for cachefiles and then claim
> write access when that private mount is created and retaining that write access
> for the duration of cachefiles being run. See my draft patch below.

OK, that would deal with one problem but the fundamental knot in this coil
is mmap_lock. I don't see the exact call stack that gets us to xattr code
but I can see e.g.:

filemap_invalidate() - grabs invalidate_lock on AFS inode
  afs_writepages
    netfs_writepages
      netfs_write_folio
        cachefiles_issue_write
          vfs_fallocate()
	    - grabs i_rwsem on backing fs inode

Which again is taking locks out of order. That would be no problem because
these are on different filesystems (AFS vs backing fs) but if you have
process with two threads, one doing page fault on AFS, another doing
write(2) to backing fs, their mmap_lock will tie the locking hierarchies on
these two filesystems together. Like:

filemap_invalidate() on fs A	page fault on fs A	write(2) on fs B
  filemap_invalidate_lock()	  lock mm->mmap_lock
  filemap_fdatawrite_wbc()	  filemap_fault()
    afs_writepages()		    filemap_invalidate_lock_shared()
      cachefiles_issue_write()	      => blocks behind filemap_invalidate()
        vfs_fallocate() on fs B
							  inode_lock(inode on fs B)
				  			  generic_perform_write()
							    fault_in_iov_iter_readable()
							      page fault
							        grab mm->mmap_lock
								  => blocks behind page fault
	  inode_lock(inode on fs B)
	    => deadlock

So I don't think there's easy way to completely avoid these deadlocks.
Realistically, I don't think that a process taking a page fault on upper fs
while doing write on lower fs is that common but it's certainly a DoS
vector. Also it's kind of annoying because of the lockdep splats in testing
and resulting inability to find other locking issues (as lockdep gets
disabled).

To fix this, either we'd have to keep the lower cache filesystem private to
cachefiles (but I don't think that works with the usecases) or we have to
somehow untangle this mmap_lock knot. This "page fault does quite some fs
locking under mmap_lock" problem is not causing filesystems headaches for
the first time. I would *love* to be able to always drop mmap_lock in the
page fault handler, fill the data into the page cache and then retry the
fault (so that filemap_map_pages() would then handle the fault without
filesystem involvement). It would make many things in filesystem locking
simpler. As far as I'm checking there are now not that many places that
could not handle dropping of mmap_lock during fault (traditionally the
problem is with get_user_pages() / pin_user_pages() users). So maybe this
dream would be feasible after all.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

