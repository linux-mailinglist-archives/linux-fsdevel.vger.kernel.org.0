Return-Path: <linux-fsdevel+bounces-11841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F3857A18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87192284D19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4898208C0;
	Fri, 16 Feb 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpVGkkeB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPmGard6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpVGkkeB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPmGard6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC35200BF;
	Fri, 16 Feb 2024 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078557; cv=none; b=Y9WApQVRDk/08yPruY+BLcIlP3nDN5RnEf1gSRNnooaQ213w/NBBWPhd7ovFTTS2xB48tUrNqqbALKLmyojG9bhfOHm73xyoJEgliOGA5iAXA0Tr0Q3H1wlATzro1SlSHRaCWj09q75F5In66mjkiyRTv6nsYrP11QUCbEChriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078557; c=relaxed/simple;
	bh=YIYxvojQxw6XOlXKkIdL2ea1QJikSQ5k5vlsedIHYp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7fT+OUfYqtlqma2yiLAfzSDQeS/9ty3g/XRT73gF11PTx2wIfeMmlqZLP6apcF0LxslNBw1MeEo4xSWUEW0PQxc9WnqwT+zt/kzU8xPRo9+DAomoenRleG72KivrmHODuG4GiESPFrPuv/guRRxJGDHv+PH6Nyb/lEmOZJE9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpVGkkeB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aPmGard6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpVGkkeB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aPmGard6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76AC721EC9;
	Fri, 16 Feb 2024 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708078550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwO2sfrBZnb90QrTcYZAEyA1bZtsunbgLx7PRRLi+s4=;
	b=LpVGkkeBrh50QgIsYxDbL+ccnWdpkp5F/sXSjHRPWlHZ4/P+aHbpbdnBU9tPYTYijHQRo5
	iFYOs7LIV4rCrj+nDCkb/yB6qcZmYQj9bD0LFEatn1uo1dbxSW/fh2x+BM3W3WNy74A+2A
	nqm26ZC1nbmEwTqKsVfvgk+46DOhQIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708078550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwO2sfrBZnb90QrTcYZAEyA1bZtsunbgLx7PRRLi+s4=;
	b=aPmGard6iLZ9Lpa6jmNBfVhUlkN0RZi85t3/p3vBhUwAqdu+BlFLb8ejJeBGGezQhKu1Zt
	uMz7rBK+9wSXXtCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708078550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwO2sfrBZnb90QrTcYZAEyA1bZtsunbgLx7PRRLi+s4=;
	b=LpVGkkeBrh50QgIsYxDbL+ccnWdpkp5F/sXSjHRPWlHZ4/P+aHbpbdnBU9tPYTYijHQRo5
	iFYOs7LIV4rCrj+nDCkb/yB6qcZmYQj9bD0LFEatn1uo1dbxSW/fh2x+BM3W3WNy74A+2A
	nqm26ZC1nbmEwTqKsVfvgk+46DOhQIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708078550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwO2sfrBZnb90QrTcYZAEyA1bZtsunbgLx7PRRLi+s4=;
	b=aPmGard6iLZ9Lpa6jmNBfVhUlkN0RZi85t3/p3vBhUwAqdu+BlFLb8ejJeBGGezQhKu1Zt
	uMz7rBK+9wSXXtCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DF6C13343;
	Fri, 16 Feb 2024 10:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +ojoFtY1z2XbBQAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 16 Feb 2024 10:15:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14499A0807; Fri, 16 Feb 2024 11:15:46 +0100 (CET)
Date: Fri, 16 Feb 2024 11:15:46 +0100
From: Jan Kara <jack@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
	akpm@linux-foundation.org, oliver.sang@intel.com,
	feng.tang@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240216101546.xjcpzyb3pgf2eqm4@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
 <20240215170008.22eisfyzumn5pw3f@revolver>
 <20240215171622.gsbjbjz6vau3emkh@quack3>
 <20240215210742.grjwdqdypvgrpwih@revolver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215210742.grjwdqdypvgrpwih@revolver>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 15-02-24 16:07:42, Liam R. Howlett wrote:
> * Jan Kara <jack@suse.cz> [240215 12:16]:
> > On Thu 15-02-24 12:00:08, Liam R. Howlett wrote:
> > > * Jan Kara <jack@suse.cz> [240215 08:16]:
> > > > On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > 
> > > > > Liam says that, unlike with xarray, once the RCU read lock is
> > > > > released ma_state is not safe to re-use for the next mas_find() call.
> > > > > But the RCU read lock has to be released on each loop iteration so
> > > > > that dput() can be called safely.
> > > > > 
> > > > > Thus we are forced to walk the offset tree with fresh state for each
> > > > > directory entry. mt_find() can do this for us, though it might be a
> > > > > little less efficient than maintaining ma_state locally.
> > > > > 
> > > > > Since offset_iterate_dir() doesn't build ma_state locally any more,
> > > > > there's no longer a strong need for offset_find_next(). Clean up by
> > > > > rolling these two helpers together.
> > > > > 
> > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > Well, in general I think even xas_next_entry() is not safe to use how
> > > > offset_find_next() was using it. Once you drop rcu_read_lock(),
> > > > xas->xa_node could go stale. But since you're holding inode->i_rwsem when
> > > > using offset_find_next() you should be protected from concurrent
> > > > modifications of the mapping (whatever the underlying data structure is) -
> > > > that's what makes xas_next_entry() safe AFAIU. Isn't that enough for the
> > > > maple tree? Am I missing something?
> > > 
> > > If you are stopping, you should be pausing the iteration.  Although this
> > > works today, it's not how it should be used because if we make changes
> > > (ie: compaction requires movement of data), then you may end up with a
> > > UAF issue.  We'd have no way of knowing you are depending on the tree
> > > structure to remain consistent.
> > 
> > I see. But we have versions of these structures that have locking external
> > to the structure itself, don't we?
> 
> Ah, I do have them - but I don't want to propagate its use as the dream
> is that it can be removed.
> 
> 
> > Then how do you imagine serializing the
> > background operations like compaction? As much as I agree your argument is
> > "theoretically clean", it seems a bit like a trap and there are definitely
> > xarray users that are going to be broken by this (e.g.
> > tag_pages_for_writeback())...
> 
> I'm not sure I follow the trap logic.  There are locks for the data
> structure that need to be followed for reading (rcu) and writing
> (spinlock for the maple tree).  If you don't correctly lock the data
> structure then you really are setting yourself up for potential issues
> in the future.
> 
> The limitations are outlined in the documentation as to how and when to
> lock.  I'm not familiar with the xarray users, but it does check for
> locking with lockdep, but the way this is written bypasses the lockdep
> checking as the locks are taken and dropped without the proper scope.
> 
> If you feel like this is a trap, then maybe we need to figure out a new
> plan to detect incorrect use?

OK, I was a bit imprecise. What I wanted to say is that this is a shift in
the paradigm in the sense that previously, we mostly had (and still have)
data structure APIs (lists, rb-trees, radix-tree, now xarray) that were
guaranteeing that unless you call into the function to mutate the data
structure it stays intact. Now maple trees are shifting more in a direction
of black-box API where you cannot assume what happens inside. Which is fine
but then we have e.g. these iterators which do not quite follow this
black-box design and you have to remember subtle details like calling
"mas_pause()" before unlocking which is IMHO error-prone. Ideally, users of
the black-box API shouldn't be exposed to the details of the internal
locking at all (but then the performance suffers so I understand why you do
things this way). Second to this ideal variant would be if we could detect
we unlocked the lock without calling xas_pause() and warn on that. Or maybe
xas_unlock*() should be calling xas_pause() automagically and we'd have
similar helpers for RCU to do the magic for you?

> Looking through tag_pages_for_writeback(), it does what is necessary to
> keep a safe state - before it unlocks it calls xas_pause().  We have the
> same on maple tree; mas_pause().  This will restart the next operation
> from the root of the tree (the root can also change), to ensure that it
> is safe.

OK, I've missed the xas_pause(). Thanks for correcting me.

> If you have other examples you think are unsafe then I can have a look
> at them as well.

I'm currently not aware of any but I'll let you know if I find some.
Missing xas/mas_pause() seems really easy.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

