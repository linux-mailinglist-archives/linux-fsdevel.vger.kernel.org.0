Return-Path: <linux-fsdevel+bounces-11660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D206855CB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 09:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D8FB30D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69712B8B;
	Thu, 15 Feb 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QS6E0z4J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+tf7eCu4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="midBJdaH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9uD6uVph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EF13AE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986216; cv=none; b=Z1zz3VHoRbkwJBbppiljCrKosQyBpMhIxnBDB2xilnu4ByEVuyBCewwLiqkobjb8mVYinBNz2HBLLwY4iQlHCjIGqSA+BdOIDxPMM5jBF2GhpxTG2wag7/cYKGoXQJS8P99Q3yNoPwvkVf4eJ28uPPv1pe+qxWfjuCAwsAn2lCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986216; c=relaxed/simple;
	bh=P4Gc64LRE8bBTzC2XSv+YtMC0ULexOS4a7QVYyLXtZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaNLT15TB+dimq2IkT5Dijs4L6abEPuX/G1VTvmVBiRxuK2OzkDvDYkpWD4ECmKd4sKoaluFePAPjvfDRBo55VJ3hUs4rT7pAZkvutAyQhJpenXp81DHe6E4AM9/acZiQG6l/CBGUhr1SKFsv33q5T7cKVWbVU10babZ0DBMafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QS6E0z4J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+tf7eCu4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=midBJdaH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9uD6uVph; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAE761F86A;
	Thu, 15 Feb 2024 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707986213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLRvQitWhA14QQZm41OlwqjbOt6KdcO+kQ33ZhxGwyI=;
	b=QS6E0z4JrSIsYUnaoctTARNn8eG/dRwWlcKcoocZYVVxKV7RxzHTKpq1IVdCj1vFF+IEzB
	8qYsu8sAk8+FafpmALqJrbaEK+6M6qc63FF4nDcInSObkAlPpWNqPDGm1MUvAoiiN4l/6y
	KvU8n47sqVB/euw+IsUdnZV3HGrUynI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707986213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLRvQitWhA14QQZm41OlwqjbOt6KdcO+kQ33ZhxGwyI=;
	b=+tf7eCu4pd+OSFQqZERsA3JswoPtfvYD1bzXzfCaIkUUHmyVAkKWgHfWyr3EhG5QQXhYOx
	FJz3CawGzcVRapCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707986212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLRvQitWhA14QQZm41OlwqjbOt6KdcO+kQ33ZhxGwyI=;
	b=midBJdaHCFQ86aVp9MxBrYlNc5E96HukO6DmuMTKGdqKQZUaDec0/X9OQpVYgVJ0QuC5yD
	k1HY8hogiqsH/IE+8j46Vh+5VXYmV/AyftgFqkv4Y0kETWw6aHka2+uSDquX/A3xKCTvlN
	qtvR8fUc/2r3Ugy5wCprgQXpH99nZww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707986212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLRvQitWhA14QQZm41OlwqjbOt6KdcO+kQ33ZhxGwyI=;
	b=9uD6uVph5BfqD/eWBk4AOfy2yZXgd8XCAHuykEzQD41cHhQYBLuxo25oS4qSULBipbt6rw
	0F4ubXo/OfI7F0Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B0C361346A;
	Thu, 15 Feb 2024 08:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SZ/eKiTNzWUdXAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 08:36:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 467CEA0809; Thu, 15 Feb 2024 09:36:48 +0100 (CET)
Date: Thu, 15 Feb 2024 09:36:48 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
Message-ID: <20240215083648.dhjgdj43npgkoe7p@quack3>
References: <20240116113247.758848-1-amir73il@gmail.com>
 <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3>
 <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
 <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
 <20240214112310.ovg2w3p6wztuslnw@quack3>
 <CAOQ4uxjS1NNJY0tQXRC3qo3_J4CB4xZpxJc7OCGp1236G6yNFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjS1NNJY0tQXRC3qo3_J4CB4xZpxJc7OCGp1236G6yNFw@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=midBJdaH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9uD6uVph
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: CAE761F86A
X-Spam-Flag: NO

On Wed 14-02-24 15:40:31, Amir Goldstein wrote:
> > > > > Merged your improvement now (and I've split off the cleanup into a separate
> > > > > change and dropped the creation of fsnotify_path() which seemed a bit
> > > > > pointless with a single caller). All pushed out.
> > > > >
> > > >
> > >
> > > Jan & Jens,
> > >
> > > Although Jan has already queued this v3 patch with sufficient performance
> > > improvement for Jens' workloads, I got a performance regression report from
> > > kernel robot on will-it-scale microbenchmark (buffered write loop)
> > > on my fan_pre_content patches, so I tried to improve on the existing solution.
> > >
> > > I tried something similar to v1/v2 patches, where the sb keeps accounting
> > > of the number of watchers for specific sub-classes of events.
> > >
> > > I've made two major changes:
> > > 1. moved to counters into a per-sb state object fsnotify_sb_connector
> > >     as Christian requested
> > > 2. The counters are by fanotify classes, not by specific events, so they
> > >     can be used to answer the questions:
> > > a) Are there any fsnotify watchers on this sb?
> > > b) Are there any fanotify permission class listeners on this sb?
> > > c) Are there any fanotify pre-content (a.k.a HSM) class listeners on this sb?
> > >
> > > I think that those questions are very relevant in the real world, because
> > > a positive answer to (b) and (c) is quite rare in the real world, so the
> > > overhead on the permission hooks could be completely eliminated in
> > > the common case.
> > >
> > > If needed, we can further bisect the class counters per specific painful
> > > events (e.g. FAN_ACCESS*), but there is no need to do that before
> > > we see concrete benchmark results.
...
 
> > Then I dislike how we have to specialcase superblock in quite a few places
> > and add these wrappers and what not. This seems to be mostly caused by the
> > fact that you directly embed fsnotify_mark_connector into fsnotify_sb_info.
> > What if we just put fsnotify_connp_t there? I understand that this will
> > mean one more pointer fetch if there are actually marks attached to the
> > superblock and the event mask matches s_fsnotify_mask. But in that case we
> > are likely to generate the event anyway so the cost of that compared to
> > event generation is negligible?
> >
> 
> I guess that can work.
> I can try it and see if there are any other complications.
> 
> > And I'd allocate fsnotify_sb_info on demand from fsnotify_add_mark_locked()
> > which means that we need to pass object pointer (in the form of void *)
> > instead of fsnotify_connp_t to various mark adding functions (and transform
> > it to fsnotify_connp_t only in fsnotify_add_mark_locked() after possibly
> > setting up fsnotify_sb_info). Passing void * around is not great but it
> > should be fairly limited (and actually reduces the knowledge of fsnotify
> > internals outside of the fsnotify core).
> 
> Unless I am missing something, I think we only need to pass an extra sb
> arg to fsnotify_add_mark_locked()? and it does not sound like a big deal.
> For adding an sb mark, connp arg could be NULL, and then we get connp
> from sb->fsnotify_sb_info after making sure that it is allocated.

Yes that would be another possibility but frankly I like passing the
'object' pointer instead of connp pointer a bit more. But we can see how
the code looks like.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

