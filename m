Return-Path: <linux-fsdevel+bounces-45099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1DA71D99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 18:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F64716453A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB223FC52;
	Wed, 26 Mar 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x2OuAa67";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yrq5a6Dd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3Rn+cVq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lBH3nhTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3CA23FC41
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011248; cv=none; b=uFeJSmt8HROA2923c+vSJu/kIhklwPgY8cO8CZN0LXDcDptzr9q1GoDNjUi/QOd6+59Iv7VEYawZ4W3gP5eR0+UxHe+FF3m2/jLivMw4i0+6d4fuyL0ljWL4AycSq3heSzTJtjz+dWPuG+rIv9t6GdWdFVHRaWW6ceipHbfXbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011248; c=relaxed/simple;
	bh=N0xq3VsGYTDaUZ+tPwcuznwkTH42fsZXY1StO/CUKsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkB43drHxzrvNf8QWevsY6v2x0JQoT6RsM5NUw6SBLuvuy3Me5ptcal41tWQ+gf35xJrQNftJHjd7jgLCwUWxSUYSjUNlqLYRheIcOTMaGT6wOA0D9saLXd2R5uvp0tjDu6yd3nLaI7J/upEvufnTxRneWmfq/ZNv+58dg6sofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x2OuAa67; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yrq5a6Dd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3Rn+cVq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lBH3nhTS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4E8B1F391;
	Wed, 26 Mar 2025 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743011245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxjLSrIeDnh+b6kDBz6kP3IUcYhwNPjqT3MLq7qkDMw=;
	b=x2OuAa67i2oHWZSuf0YfZJcIlJdrPJgUsI+0aJZz3YklrGBNzvghE+qYk+DuEC5NBjDgaM
	zDSbeifV8rBhABGvrF1WCSvyNOYfWFLtHJRRxfKS7DHSjTY1aiNLzXh/y0zh1Di8H4oZfr
	OqunWqlffvQl3U0LnwQwtgUvNCb7XGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743011245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxjLSrIeDnh+b6kDBz6kP3IUcYhwNPjqT3MLq7qkDMw=;
	b=Yrq5a6Dd6wEtnOsa53HxndvXc+8SUy5wDqWJEzYXLOoB11S1gMrWRfB1Z5fu/fFoIWnp7u
	3AIZ+xDIt1ymWJBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M3Rn+cVq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lBH3nhTS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743011244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxjLSrIeDnh+b6kDBz6kP3IUcYhwNPjqT3MLq7qkDMw=;
	b=M3Rn+cVq6kM37gBDI4SCl+HNJligH9FJjTuV+9Fj6KFRGmWC/5kpphqc25NMtLQcBdQmIK
	8aa9OeQqPCMTixykf1u13bWqSHkBWCL4b8m9GfQgcLRruFxuQFSifItPJHDTkBFAf92Hsq
	6RO9ham9NUJffrgIhTvDpPwltVQGDXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743011244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxjLSrIeDnh+b6kDBz6kP3IUcYhwNPjqT3MLq7qkDMw=;
	b=lBH3nhTSiwVcvPbxi4Hi2vUlBibB0MFl/z/21m2/0igVMihLPkYlgUpK947wg8vjQgRwAN
	et+wUaHx/8w8QTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE4F1374A;
	Wed, 26 Mar 2025 17:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PpzrKqw95GeoCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Mar 2025 17:47:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51648A082A; Wed, 26 Mar 2025 18:47:20 +0100 (CET)
Date: Wed, 26 Mar 2025 18:47:20 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF Topic] Filesystem reclaim & memory
 allocation BOF
Message-ID: <pmj2eec6neqnd4rnxu4vdjo3jtokjv6tywhixst6yp3favurko@gmlswga5ihmb>
References: <Z-QcUwDHHfAXl9mK@casper.infradead.org>
 <20250326155522.GB1459574@mit.edu>
 <Z-QpFN4sW6wNXNBP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-QpFN4sW6wNXNBP@casper.infradead.org>
X-Rspamd-Queue-Id: C4E8B1F391
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 26-03-25 16:19:32, Matthew Wilcox wrote:
> On Wed, Mar 26, 2025 at 11:55:22AM -0400, Theodore Ts'o wrote:
> > On Wed, Mar 26, 2025 at 03:25:07PM +0000, Matthew Wilcox wrote:
> > > 
> > > We've got three reports now (two are syzkaller kiddie stuff, but one's a
> > > real workload) of a warning in the page allocator from filesystems
> > > doing reclaim.  Essentially they're using GFP_NOFAIL from reclaim
> > > context.  This got me thinking about bs>PS and I realised that if we fix
> > > this, then we're going to end up trying to do high order GFP_NOFAIL allocations
> > > in the memory reclaim path, and that is really no bueno.
> > > 
> > > https://lore.kernel.org/linux-mm/20250326105914.3803197-1-matt@readmodwrite.com/
> > > 
> > > I'll prepare a better explainer of the problem in advance of this.
> > 
> > Thanks for proposing this as a last-minute LSF/MM topic!
> > 
> > I was looking at this myself, and was going to reply to the mail
> > thread above, but I'll do it here.
> > 
> > >From my perspective, the problem is that as part of memory reclaim,
> > there is an attempt to shrink the inode cache, and there are cases
> > where an inode's refcount was elevated (for example, because it was
> > referenced by a dentry), and when the dentry gets flushed, now the
> > inode can get evicted.  But if the inode is one that has been deleted,
> > then at eviction time the file system will try to release the blocks
> > associated with the deleted-file.  This operation will require memory
> > allocation, potential I/O, and perhaps waiting for a journal
> > transaction to complete.
> > 
> > So basically, there are a class of inodes where if we are in reclaim,
> > we should probably skip trying to evict them because there are very
> > likely other inodes that will be more likely to result in memory
> > getting released expeditiously.  And if we take a look at
> > inode_lru_isolate(), there's logic there already about when inodes
> > should skipped getting evicted.  It's probably just a matter of adding
> > some additional coditions there.
> 
> This is a helpful way of looking at the problem.  I was looking at the
> problem further down where we've already entered evict_inode().  At that
> point we can't fail.  My proposal was going to be that the filesystem pin
> the metadata that it would need to modify in order to evict the inode.
> But avoiding entering evict_inode() is even better.
> 
> However, I can't see how inode_lru_isolate() can know whether (looking
> at the three reports):
> 
>  - the ext4 inode table has been reclaimed and ext4 would need to
>    allocate memory in order to reload the table from disc in order to
>    evict this inode
>  - the ext4 block bitmap has been reclaimed and ext4 would need to
>    allocate memory in order to reload the bitmap from disc to
>    discard the preallocation
>  - the fat cluster information has been reclaimed and fat would
>    need to allocate memory in order to reload the cluster from
>    disc to update the cluster information

Well, I think Ted was speaking about a more "big hammer" approach like
adding:

	if (current->flags & PF_MEMALLOC && !inode->i_nlink) {
		spin_unlock(&inode->i_lock);
		return LRU_SKIP;
	}

to inode_lru_isolate(). The problem isn't with inode_lru_isolate() here as
far as I'm reading the stacktrace. We are scanning *dentry* LRU list,
killing the dentry which is dropping the last reference to the inode and
iput() then ends up doing all the deletion work. So we would have to avoid
dropping dentry from the LRU if dentry->d_inode->i_nlink == 0 and that
frankly seems a bit silly to me.

> So maybe it makes sense for ->evict_inode() to change from void to
> being able to return an errno, and then change the filesystems to not
> set GFP_NOFAIL, and instead just decline to evict the inode.

So this would help somewhat but inode deletion is a *heavy* operation (you
can be freeing gigabytes of blocks) so you may end up doing a lot of
metadata IO through the journal and deep in the bowels of the filesystem we
are doing GFP_NOFAIL allocations anyway because there's just no sane way to
unroll what we've started. So I'm afraid that ->evict() doing GFP_NOFAIL
allocation for inodes with inode->i_nlink == 0 is a fact of life that is very
hard to change.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

