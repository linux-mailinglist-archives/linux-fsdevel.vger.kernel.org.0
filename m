Return-Path: <linux-fsdevel+bounces-41518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075CDA30EAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC2E3A74BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E62250C00;
	Tue, 11 Feb 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1SScb7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWylvlJq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1SScb7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWylvlJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FB2505B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285047; cv=none; b=JC0iOKEecLai+/UyODuI96lZhpgx3dMnwZtI/wJ25xAeyIigxrn1Slx1xONI07gLi6am/juFIGJ0lZD4hbIfMrTZjpXQSlmGqUz9lglQMcnQfwrR7oVJxBnVzhahAtzBJ46uRX736HHE0POlqoJx2Nxh9rTu14XZDMwLhvjAHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285047; c=relaxed/simple;
	bh=IahyDTbjrcYjCoDJUv3OnlbwGd5shCRC4kJSNcEwGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVpc0NA9H9UO0pSRSy4WKmcBvmAqa+NTmidh0bnTi6xF1kSj7azId4t/oHPcJmyRlhkziN+Nxdt7rvf8yV/EuVNdlCQSKYAjWeFzfCN46ttTSpodEEMHqJI44TIwK0L6m/tFNWI/BiaNVtT4bzlrhK03vrVuy0tkzQiyqfXIWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1SScb7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWylvlJq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1SScb7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWylvlJq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3163E389AD;
	Tue, 11 Feb 2025 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739281397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VEBIexmL7SWSiS0m6pdz8xGnSXtW/lNBhhiiEd8WIw=;
	b=O1SScb7C08E7Y/NJoR+I/57RazP96XEZvgVIezmjZa1/5BKqJMkga7r1BjfsdtIfkh3PDv
	ElrhlUclxJISnSZhEyaAQy6AS72NcHmeC5N37TSTVNoXQ0rSGEDTRc3xWGd7r/kU8OMx6D
	uuZYzrL8GaDBELiXu0FNMNbDjegAEdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739281397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VEBIexmL7SWSiS0m6pdz8xGnSXtW/lNBhhiiEd8WIw=;
	b=AWylvlJq/MJv5IsvIWFgfUFPQdWl8OsM46cPlDzqXO+WYsuNqhUt+WTiGzIfD1MWrvRKNS
	fAvCSYYcQVY9FWAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739281397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VEBIexmL7SWSiS0m6pdz8xGnSXtW/lNBhhiiEd8WIw=;
	b=O1SScb7C08E7Y/NJoR+I/57RazP96XEZvgVIezmjZa1/5BKqJMkga7r1BjfsdtIfkh3PDv
	ElrhlUclxJISnSZhEyaAQy6AS72NcHmeC5N37TSTVNoXQ0rSGEDTRc3xWGd7r/kU8OMx6D
	uuZYzrL8GaDBELiXu0FNMNbDjegAEdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739281397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VEBIexmL7SWSiS0m6pdz8xGnSXtW/lNBhhiiEd8WIw=;
	b=AWylvlJq/MJv5IsvIWFgfUFPQdWl8OsM46cPlDzqXO+WYsuNqhUt+WTiGzIfD1MWrvRKNS
	fAvCSYYcQVY9FWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2139213715;
	Tue, 11 Feb 2025 13:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C/gUCPVTq2dVPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Feb 2025 13:43:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9E34A095C; Tue, 11 Feb 2025 14:43:01 +0100 (CET)
Date: Tue, 11 Feb 2025 14:43:01 +0100
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Kundan Kumar <kundan.kumar@samsung.com>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com, axboe@kernel.dk, 
	clm@meta.com, willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <jafwdcn2jvl6mr3byswuj3jakolpfzbirnzpmlj3y7teooo7sx@vaptimf74pjl>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
 <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
 <Z6qkLjSj1K047yPt@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qkLjSj1K047yPt@dread.disaster.area>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 11-02-25 12:13:18, Dave Chinner wrote:
> On Mon, Feb 10, 2025 at 06:28:28PM +0100, Jan Kara wrote:
> > On Tue 04-02-25 06:06:42, Christoph Hellwig wrote:
> > > On Tue, Feb 04, 2025 at 01:50:08PM +1100, Dave Chinner wrote:
> > > > I doubt that will create enough concurrency for a typical small
> > > > server or desktop machine that only has a single NUMA node but has a
> > > > couple of fast nvme SSDs in it.
> > > > 
> > > > > 2) Fixed number of writeback contexts, say min(10, numcpu).
> > > > > 3) NUMCPU/N number of writeback contexts.
> > > > 
> > > > These don't take into account the concurrency available from
> > > > the underlying filesystem or storage.
> > > > 
> > > > That's the point I was making - CPU count has -zero- relationship to
> > > > the concurrency the filesystem and/or storage provide the system. It
> > > > is fundamentally incorrect to base decisions about IO concurrency on
> > > > the number of CPU cores in the system.
> > > 
> > > Yes.  But as mention in my initial reply there is a use case for more
> > > WB threads than fs writeback contexts, which is when the writeback
> > > threads do CPU intensive work like compression.  Being able to do that
> > > from normal writeback threads vs forking out out to fs level threads
> > > would really simply the btrfs code a lot.  Not really interesting for
> > > XFS right now of course.
> > > 
> > > Or in other words: fs / device geometry really should be the main
> > > driver, but if a file systems supports compression (or really expensive
> > > data checksums) being able to scale up the numbes of threads per
> > > context might still make sense.  But that's really the advanced part,
> > > we'll need to get the fs geometry aligned to work first.
> > 
> > As I'm reading the thread it sounds to me the writeback subsystem should
> > provide an API for the filesystem to configure number of writeback
> > contexts which would be kind of similar to what we currently do for cgroup
> > aware writeback?
> 
> Yes, that's pretty much what I've been trying to say.
> 
> > Currently we create writeback context per cgroup so now
> > additionally we'll have some property like "inode writeback locality" that
> > will also influence what inode->i_wb gets set to and hence where
> > mark_inode_dirty() files inodes etc.
> 
> Well, that's currently selected by __inode_attach_wb() based on
> whether there is a memcg attached to the folio/task being dirtied or
> not. If there isn't a cgroup based writeback task, then it uses the
> bdi->wb as the wb context.
> 
> In my mind, what you are describing above sounds like we would be
> heading down the same road list_lru started down back in 2012 to
> support NUMA scalability for LRU based memory reclaim.
> 
> i.e. we originally had a single global LRU list for important
> caches. This didn't scale up, so I introduced the list_lru construct
> to abstract the physical layout of the LRU from the objects being
> stored on it and the reclaim infrastructure walking it. That gave us
> per-NUMA-node LRUs and NUMA-aware shrinkers for memory reclaim. The
> fundamental concept was that we abstract away the sharding of the
> object tracking into per-physical-node structures via generic
> infrastructure (i.e. list_lru).
> 
> Then memcgs needed memory reclaim, and so they were added as extra
> lists with a different indexing mechanism to the list-lru contexts.
> These weren't per-node lists because there could be thousands of
> them. Hence it was just a single "global" list per memcg, and so it
> didn't scale on large machines.
> 
> This wasn't seen as a problem initially, but a few years later
> applications using memcgs wanted to scale properly on large NUMA
> systems. So now we have each memcg tracking the physical per-node
> memory usage for reclaim purposes (i.e.  combinatorial explosion of
> memcg vs per-node lists).
> 
> Hence suggesting "physically sharded lists for global objects,
> single per-cgroup lists for cgroup-owned objects" sounds like
> exactly the same problem space progression is about to play out with
> writeback contexts.
> 
> i.e. we shared the global writeback context into a set of physically
> sharded lists for scalability and perofrmance reasons, but leave
> cgroups with the old single threaded list constructs. Then someone
> says "my cgroup based workload doesn't perform the same as a global
> workload" and we're off to solve the problem list_lru solves again.
> 
> So....
> 
> Should we be looking towards using a subset of the existing list_lru
> functionality for writeback contexts here? i.e. create a list_lru
> object with N-way scalability, allow the fs to provide an
> inode-number-to-list mapping function, and use the list_lru
> interfaces to abstract away everything physical and cgroup related
> for tracking dirty inodes?

Interesting idea. Indeed, the similarity with problems list_lru is solving
is significant. I like the idea.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

