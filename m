Return-Path: <linux-fsdevel+bounces-24197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E193B1A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F81F23119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A423749;
	Wed, 24 Jul 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZBbrg3Ar";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b1i0F8SP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZBbrg3Ar";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b1i0F8SP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C201494C8;
	Wed, 24 Jul 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827813; cv=none; b=BAk+EuxWnxBYzEs3JK3+bI8IoA8ZzjFlw287y+/YdOhwYv1BBfSHMgBEkuzh4hBuA8BsNgWXoN60T8J/HF3cIKl3U6BZO79Y9nWmG5Obcjl+tysIkYlc7AmqOmk4//zGEmh24Sh+CRc4e9j16/maxghMmZTmxkYuHOchWdc6KiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827813; c=relaxed/simple;
	bh=F3Mc1gljNyvAcgDBDUA1YynRl/LCAnNs98LevOMjHnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poeqfsMfuVkMepmZDXQ9qvi/zrOqYiOra6L8I9DzvsyPp0h8/K+5S2aVEt+zoEsnSFwjaR66Vtg4JWMuFh0oZlO5ChZfDF8AhfxUFCDrOzDr5txj3LN7Vzlet/BQC18pXSzB/MgkOcQZIJ5G/gR+2gkqXc54AZy/Hmf12fBN8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZBbrg3Ar; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b1i0F8SP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZBbrg3Ar; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b1i0F8SP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48EAD1F7A1;
	Wed, 24 Jul 2024 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721827810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfH8hrgqItTtjnVn4i5MjiuCGCIZRWDHNb/C5lajMog=;
	b=ZBbrg3ArdLo3VvM+I+5jmxRV4h3bMiTvL5cIqg9tHwHpv3t54uxWU7zSwd607m0nKr6JNu
	PM0HQJvdVgsQtHeAw8o9vtPRD+fI4rVjhH21EuZ/RlIQBgqK+ZacMHFbiLhnRlHh+14RZb
	BI5snj0ifCjzD5lG+8TyB5k41NVWw7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721827810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfH8hrgqItTtjnVn4i5MjiuCGCIZRWDHNb/C5lajMog=;
	b=b1i0F8SPEkueO7uBkpdATFqSX0Yr5RVIRvy1419pEbV11XG7m96n52SffSv9ZgAv3sTq+G
	WJXoes6ThQm843Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721827810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfH8hrgqItTtjnVn4i5MjiuCGCIZRWDHNb/C5lajMog=;
	b=ZBbrg3ArdLo3VvM+I+5jmxRV4h3bMiTvL5cIqg9tHwHpv3t54uxWU7zSwd607m0nKr6JNu
	PM0HQJvdVgsQtHeAw8o9vtPRD+fI4rVjhH21EuZ/RlIQBgqK+ZacMHFbiLhnRlHh+14RZb
	BI5snj0ifCjzD5lG+8TyB5k41NVWw7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721827810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfH8hrgqItTtjnVn4i5MjiuCGCIZRWDHNb/C5lajMog=;
	b=b1i0F8SPEkueO7uBkpdATFqSX0Yr5RVIRvy1419pEbV11XG7m96n52SffSv9ZgAv3sTq+G
	WJXoes6ThQm843Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 398E41324F;
	Wed, 24 Jul 2024 13:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAALDuIBoWZhFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 13:30:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1CF5A08E4; Wed, 24 Jul 2024 15:30:09 +0200 (CEST)
Date: Wed, 24 Jul 2024 15:30:09 +0200
From: Jan Kara <jack@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240724133009.6st3vmk5ondigbj7@quack3>
References: <20240723104533.mznf3svde36w6izp@quack3>
 <2136178.1721725194@warthog.procyon.org.uk>
 <2147168.1721743066@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2147168.1721743066@warthog.procyon.org.uk>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Tue 23-07-24 14:57:46, David Howells wrote:
> Jan Kara <jack@suse.cz> wrote:
> 
> > Well, it seems like you are trying to get rid of the dependency
> > sb_writers->mmap_sem. But there are other places where this dependency is
> > created, in particular write(2) path is a place where it would be very
> > difficult to get rid of it (you take sb_writers, then do all the work
> > preparing the write and then you copy user data into page cache which
> > may require mmap_sem).
> >
> > ...
> > 
> > This is the problematic step - from quite deep in the locking chain holding
> > invalidate_lock and having PG_Writeback set you suddently jump to very outer
> > locking context grabbing sb_writers. Now AFAICT this is not a real deadlock
> > problem because the locks are actually on different filesystems, just
> > lockdep isn't able to see this. So I don't think you will get rid of these
> > lockdep splats unless you somehow manage to convey to lockdep that there's
> > the "upper" fs (AFS in this case) and the "lower" fs (the one behind
> > cachefiles) and their locks are different.
> 
> I'm not sure you're correct about that.  If you look at the lockdep splat:
> 
> >  -> #2 (sb_writers#14){.+.+}-{0:0}:
> 
> The sb_writers lock is "personalised" to the filesystem type (the "#14"
> annotation) which is set here:
> 
> 	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
> 		if (__percpu_init_rwsem(&s->s_writers.rw_sem[i],
> 					sb_writers_name[i],
> 					&type->s_writers_key[i]))  <----
> 			goto fail;
> 	}
> 
> in fs/super.c.

Right, forgot about that. Thanks for correction! So after pondering about
this some more, this is actually a real problem and deadlockable. See
below.

> I think the problem is (1) that on one side, you've got, say, sys_setxattr()
> taking an sb_writers lock and then accessing a userspace buffer, which (a) may
> take mm->mmap_lock and vma->vm_lock and (b) may cause reading or writeback
> from the netfs-based filesystem via an mmapped xattr name buffer].

Yes, we agree on that. I was just pointing out that:

vfs_write()
  file_start_write() -> grabs sb_writers
  generic_file_write_iter()
    generic_perform_write()
      fault_in_iov_iter_readable()

is another path which enforces exactly the same lock ordering.

> Then (2) on the other side, you have a read or a write to the network
> filesystem through netfslib which may invoke the cache, which may require
> cachefiles to check the xattr on the cache file and maybe set/remove it -
> which requires the sb_writers lock on the cache filesystem.
> 
> So if ->read_folio(), ->readahead() or ->writepages() can ever be called with
> mm->mmap_lock or vma->vm_lock held, netfslib may call down to cachefiles and
> ultimately, it should[*] then take the sb_writers lock on the backing
> filesystem to perform xattr manipulation.

Well, ->read_folio() under mm->mmap_lock is a standard thing to happen in a
page fault. Now grabbing sb_writers (of any filesystem) in that path is
problematic and can deadlock though:

page fault
  grab mm->mmap_lock
  filemap_fault()
    if (unlikely(!folio_test_uptodate(folio))) {
      filemap_read_folio() on fs A
        now if you grab sb_writers on fs B:
			freeze_super() on fs B		write(2) on fs B
							  sb_start_write(fs B)
			  sb->s_writers.frozen = SB_FREEZE_WRITE;
			  sb_wait_write(sb, SB_FREEZE_WRITE);
			    - waits for write
	sb_start_write(fs B) - blocked behind freeze_super()
							  generic_perform_write()
							    fault_in_iov_iter_readable()
							      page fault
							        grab mm->mmap_lock
								  => deadlock

Now this is not the deadlock your lockdep trace is showing but it is a
similar one. Like:

filemap_invalidate() on fs A	freeze_super() on fs B	page fault on fs A	write(2) on fs B
  filemap_invalidate_lock()				  lock mm->mmap_lock	  sb_start_write(fs B)
  filemap_fdatawrite_wbc()				  filemap_fault()
    afs_writepages()					    filemap_invalidate_lock_shared()
      cachefiles_issue_write()				      => blocks behind filemap_invalidate()
				  sb->s_writers.frozen = SB_FREEZE_WRITE;
				  sb_wait_write(sb, SB_FREEZE_WRITE);
				    => blocks behind write(2)
        sb_start_write() on fs B
	  => blocks behind freeze_super()
							  			  generic_perform_write()
										    fault_in_iov_iter_readable()
										      page fault
										        grab mm->mmap_lock
											  => deadlock

So I still maintain that grabbing sb_start_write() from quite deep within
locking hierarchy (like from writepages when having pages locked, but even
holding invalidate_lock is enough for the problems) is problematic and
prone to deadlocks.

> [*] I say "should" because at the moment cachefiles calls vfs_set/removexattr
>     functions which *don't* take this lock (which is a bug).  Is this an error
>     on the part of vfs_set/removexattr()?  Should they take this lock
>     analogously with vfs_truncate() and vfs_iocb_iter_write()?
> 
> However, as it doesn't it manages to construct a locking chain via the
> mapping.invalidate_lock, the afs vnode->validate_lock and something in execve
> that I don't exactly follow.
> 
> 
> I wonder if this is might be deadlockable by a multithreaded process (ie. so
> they share the mm locks) where one thread is writing to a cached file whilst
> another thread is trying to set/remove the xattr on that file.

Yep, see above. Now the hard question is how to fix this because what you
are doing seems to be inherent in how cachefiles fs is designed to work.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

