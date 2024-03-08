Return-Path: <linux-fsdevel+bounces-14013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA67876902
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 18:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1920A1C212E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FE1CF8F;
	Fri,  8 Mar 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qygk1F0i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eTPAwJo4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qygk1F0i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eTPAwJo4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFB15D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917272; cv=none; b=Qtw8Qwk220M5mjKnV9SFzv6xiZCjgBeds2zcDrhYQoS/ieifSkT8FBrfEXteG3kUWzeaS5/mHyo3ScjWyTE283Uxcss2E3Xd4mC3Ivu4H9PV3d3LCZqxSmK54Ntg9zvxjDFcFG6al5GWoaJbXwCWlxnysrWO0+T64TjN/ff/iBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917272; c=relaxed/simple;
	bh=i7E5PxhRRLf8NAgevQH7wCn8vUIulfXQVlSFAq2zhOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERyjRC6130a1pop/2ELcQlxvmQOEBUP6hExMo18qvB8fPyFE6UIJrEyDhfrImJ2g1mjTsWBD8NUxogOuPP7pM/kcHA95+5hRVg21HKJqWEY8RIy7n+Eu7T0OhC/hrRxTw/I1bBPuTg2ePoxyUpjF7g+qEgKlsL83wjf1yNVRVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qygk1F0i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eTPAwJo4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qygk1F0i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eTPAwJo4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EA0B67152;
	Fri,  8 Mar 2024 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709913659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6hUun/q+Fap0ufLg3Iy252uXcivOwOteBZoVbnftMc=;
	b=qygk1F0ikhZV+Q5FmhkAY2wVtQq6qbf5neNldYMDzyuZpjw1EhvQn15XahcLCuayk5HPvU
	nMWEuNZYmzVd9SJmiHxqnuNtvUaOxoNd9HwP5DG/sA6NxRUWWRQN68ip2yi3YkdaMKYlC0
	uJTz8eGlxcH7Ba7Oi8an0OG6vaN0vX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709913659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6hUun/q+Fap0ufLg3Iy252uXcivOwOteBZoVbnftMc=;
	b=eTPAwJo4cO522F7GeOHztZW7KMGWjbETS3JzjWjWfii1Mz+tKTu+V9EprV8jVW9rY3ltVz
	UakuUoeHVgGv6JCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709913659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6hUun/q+Fap0ufLg3Iy252uXcivOwOteBZoVbnftMc=;
	b=qygk1F0ikhZV+Q5FmhkAY2wVtQq6qbf5neNldYMDzyuZpjw1EhvQn15XahcLCuayk5HPvU
	nMWEuNZYmzVd9SJmiHxqnuNtvUaOxoNd9HwP5DG/sA6NxRUWWRQN68ip2yi3YkdaMKYlC0
	uJTz8eGlxcH7Ba7Oi8an0OG6vaN0vX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709913659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6hUun/q+Fap0ufLg3Iy252uXcivOwOteBZoVbnftMc=;
	b=eTPAwJo4cO522F7GeOHztZW7KMGWjbETS3JzjWjWfii1Mz+tKTu+V9EprV8jVW9rY3ltVz
	UakuUoeHVgGv6JCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F78413310;
	Fri,  8 Mar 2024 16:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id np9HFzs262VgTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Mar 2024 16:00:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6788A0803; Fri,  8 Mar 2024 17:00:58 +0100 (CET)
Date: Fri, 8 Mar 2024 17:00:58 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
Message-ID: <20240308160058.eu7thhohy2d3xtcz@quack3>
References: <20240116113247.758848-1-amir73il@gmail.com>
 <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3>
 <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
 <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
 <20240214112310.ovg2w3p6wztuslnw@quack3>
 <CAOQ4uxjS1NNJY0tQXRC3qo3_J4CB4xZpxJc7OCGp1236G6yNFw@mail.gmail.com>
 <20240215083648.dhjgdj43npgkoe7p@quack3>
 <CAOQ4uxjDndJr8oTGyWhLSebFsBcRQ4g=GwYZvdWQmRpXXdmx5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjDndJr8oTGyWhLSebFsBcRQ4g=GwYZvdWQmRpXXdmx5A@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qygk1F0i;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eTPAwJo4
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: 6EA0B67152
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 06-03-24 16:51:06, Amir Goldstein wrote:
> On Thu, Feb 15, 2024 at 10:36 AM Jan Kara <jack@suse.cz> wrote:
> > On Wed 14-02-24 15:40:31, Amir Goldstein wrote:
> > > > > > > Merged your improvement now (and I've split off the cleanup into a separate
> > > > > > > change and dropped the creation of fsnotify_path() which seemed a bit
> > > > > > > pointless with a single caller). All pushed out.
> > > > > > >
> > > > > >
> > > > >
> > > > > Jan & Jens,
> > > > >
> > > > > Although Jan has already queued this v3 patch with sufficient performance
> > > > > improvement for Jens' workloads, I got a performance regression report from
> > > > > kernel robot on will-it-scale microbenchmark (buffered write loop)
> > > > > on my fan_pre_content patches, so I tried to improve on the existing solution.
> > > > >
> > > > > I tried something similar to v1/v2 patches, where the sb keeps accounting
> > > > > of the number of watchers for specific sub-classes of events.
> > > > >
> > > > > I've made two major changes:
> > > > > 1. moved to counters into a per-sb state object fsnotify_sb_connector
> > > > >     as Christian requested
> > > > > 2. The counters are by fanotify classes, not by specific events, so they
> > > > >     can be used to answer the questions:
> > > > > a) Are there any fsnotify watchers on this sb?
> > > > > b) Are there any fanotify permission class listeners on this sb?
> > > > > c) Are there any fanotify pre-content (a.k.a HSM) class listeners on this sb?
> > > > >
> > > > > I think that those questions are very relevant in the real world, because
> > > > > a positive answer to (b) and (c) is quite rare in the real world, so the
> > > > > overhead on the permission hooks could be completely eliminated in
> > > > > the common case.
> > > > >
> > > > > If needed, we can further bisect the class counters per specific painful
> > > > > events (e.g. FAN_ACCESS*), but there is no need to do that before
> > > > > we see concrete benchmark results.
> > ...
> >
> > > > Then I dislike how we have to specialcase superblock in quite a few places
> > > > and add these wrappers and what not. This seems to be mostly caused by the
> > > > fact that you directly embed fsnotify_mark_connector into fsnotify_sb_info.
> > > > What if we just put fsnotify_connp_t there? I understand that this will
> > > > mean one more pointer fetch if there are actually marks attached to the
> > > > superblock and the event mask matches s_fsnotify_mask. But in that case we
> > > > are likely to generate the event anyway so the cost of that compared to
> > > > event generation is negligible?
> > > >
> > >
> > > I guess that can work.
> > > I can try it and see if there are any other complications.
> > >
> > > > And I'd allocate fsnotify_sb_info on demand from fsnotify_add_mark_locked()
> > > > which means that we need to pass object pointer (in the form of void *)
> > > > instead of fsnotify_connp_t to various mark adding functions (and transform
> > > > it to fsnotify_connp_t only in fsnotify_add_mark_locked() after possibly
> > > > setting up fsnotify_sb_info). Passing void * around is not great but it
> > > > should be fairly limited (and actually reduces the knowledge of fsnotify
> > > > internals outside of the fsnotify core).
> > >
> > > Unless I am missing something, I think we only need to pass an extra sb
> > > arg to fsnotify_add_mark_locked()? and it does not sound like a big deal.
> > > For adding an sb mark, connp arg could be NULL, and then we get connp
> > > from sb->fsnotify_sb_info after making sure that it is allocated.
> >
> > Yes that would be another possibility but frankly I like passing the
> > 'object' pointer instead of connp pointer a bit more. But we can see how
> > the code looks like.
> 
> Ok, here it is:
> 
> https://github.com/amir73il/linux/commits/fsnotify-sbinfo/
> 
> I agree that the interface does end up looking better this way.

Yep, the interface looks fine. I have left some comments on github
regarding typos and some suspicious things.

> I've requested to re-test performance on fsnotify-sbinfo.
> 
> You can use this rebased branch to look at the diff from the
> the previous patches that were tested by 0day:
> 
> https://github.com/amir73il/linux/commits/fsnotify-sbconn/
> 
> If you have the bandwidth to consider those patches as candidates
> for (the second half of?) 6.9 merge window, I can post them for review.

Well, unless Linus does rc8, I don't think we should queue these for the
merge window as it is too late by now. But please post them for review,
I'll have a look. I can then push them to my tree early into a stable
branch and you can base your patches on my branch. If the patches then need
to go through VFS tree, Christian is fine with pulling my tree...

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

