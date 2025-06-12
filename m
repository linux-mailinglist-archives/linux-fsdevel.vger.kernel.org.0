Return-Path: <linux-fsdevel+bounces-51424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024FAD6B8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C40178369
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B103E223DFD;
	Thu, 12 Jun 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="woaIe7Rc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g0CRbyj6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="woaIe7Rc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g0CRbyj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEA1DDC1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718895; cv=none; b=KlJJKKSVcwmn3jXtwKiU1LOoWNyuWmLi6k62vdPRjkf5VVy7dGY7RQu4ZOaJo9IcWZdrXEAJxr5UqbYJY2xazBDgYRUkuVcQzxHNLWUhKSs3crOzHdF2hmPLhSmt7l2D1RZqKEoeaJfmugJb7icUcu9rggA0oE44WEr3jlSYJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718895; c=relaxed/simple;
	bh=yHCNSWUUPCvueXr9uU8Y5LOn3y+xXzJpqtId2WyJ3lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq0zb3ADqO8L7WFx1uz68zXFQKQVKzE8lOrQm1ASYyLSpLvArX6nMrV0WWgDV34Fc0H7QRiwRfqMQizp9LI+yQlbfdYIh5+61KMYxba/Y82p5wVvWv9FdlxfvkqpHOqhdkmJFR1MM5wbdO+7XyK/ZHVIU7Y/aPqazw966Bz6oLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=woaIe7Rc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g0CRbyj6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=woaIe7Rc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g0CRbyj6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87DA8211FF;
	Thu, 12 Jun 2025 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749718891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxV1LbLqq2fLvkoQv9Eg6WCPphq83+KF+iydz1u2y+U=;
	b=woaIe7RcGTHJ6bG0S3acLCUWG30aGioHfoi8WNIOKiPDmtW2jj/EJV675zDvVB0H5CaG+a
	LLmu2D7pQPe4QBgG7fUhoOSdp3fqrWkbHSU/T4knh/wRnrzweGzM2bWt7/Y7di0kopGZts
	1Ij4X3St287y7onA1Ovu9XnXt/O4gMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749718891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxV1LbLqq2fLvkoQv9Eg6WCPphq83+KF+iydz1u2y+U=;
	b=g0CRbyj655kFFRJ1jJw+ocfM229bCFpVWAw6KuVTvUSxINlIOEp7PEC8lW/bOooZN7ws9O
	DjMrao+NotIO0mAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=woaIe7Rc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g0CRbyj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749718891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxV1LbLqq2fLvkoQv9Eg6WCPphq83+KF+iydz1u2y+U=;
	b=woaIe7RcGTHJ6bG0S3acLCUWG30aGioHfoi8WNIOKiPDmtW2jj/EJV675zDvVB0H5CaG+a
	LLmu2D7pQPe4QBgG7fUhoOSdp3fqrWkbHSU/T4knh/wRnrzweGzM2bWt7/Y7di0kopGZts
	1Ij4X3St287y7onA1Ovu9XnXt/O4gMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749718891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxV1LbLqq2fLvkoQv9Eg6WCPphq83+KF+iydz1u2y+U=;
	b=g0CRbyj655kFFRJ1jJw+ocfM229bCFpVWAw6KuVTvUSxINlIOEp7PEC8lW/bOooZN7ws9O
	DjMrao+NotIO0mAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 712DC139E2;
	Thu, 12 Jun 2025 09:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3CCgG2uXSmjTNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 09:01:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1FE25A099E; Thu, 12 Jun 2025 11:01:16 +0200 (CEST)
Date: Thu, 12 Jun 2025 11:01:16 +0200
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, NeilBrown <neil@brown.name>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <csh2jbt5gythdlqps7b4jgizfeww6siuu7de5ftr6ygpnta6bd@umja7wbmnw7j>
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
 <20250611.Bee1Iohoh4We@digikod.net>
 <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
 <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org>
 <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 87DA8211FF
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[maowtm.org,digikod.net,brown.name,suse.cz,vger.kernel.org,meta.com,kernel.org,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,google.com,toxicpanda.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 11-06-25 11:08:30, Song Liu wrote:
> On Wed, Jun 11, 2025 at 10:50 AM Tingmao Wang <m@maowtm.org> wrote:
> [...]
> > > I think we will need some callback mechanism for this. Something like:
> > >
> > > for_each_parents(starting_path, root, callback_fn, cb_data, bool try_rcu) {
> > >    if (!try_rcu)
> > >       goto ref_walk;
> > >
> > >    __read_seqcount_begin();
> > >     /* rcu walk parents, from starting_path until root */
> > >    walk_rcu(starting_path, root, path) {
> > >     callback_fn(path, cb_data);
> > >   }
> > >   if (!read_seqcount_retry())
> > >     return xxx;  /* successful rcu walk */
> > >
> > > ref_walk:
> > >   /* ref walk parents, from starting_path until root */
> > >    walk(starting_path, root, path) {
> > >     callback_fn(path, cb_data);
> > >   }
> > >   return xxx;
> > > }
> > >
> > > Personally, I don't like this version very much, because the callback
> > > mechanism is not very flexible, and it is tricky to use it in BPF LSM.
> >
> > Aside from the "exposing mount seqcounts" problem, what do you think about
> > the parent_iterator approach I suggested earlier?  I feel that it is
> > better than such a callback - more flexible, and also fits in right with
> > the BPF API you already designed (i.e. with a callback you might then have
> > to allow BPF to pass a callback?).  There are some specifics that I can
> > improve - Mickaël suggested some in our discussion:
> >
> > - Letting the caller take rcu_read_lock outside rather than doing it in
> > path_walk_parent_start
> >
> > - Instead of always requiring a struct parent_iterator, allow passing in
> > NULL for the iterator to path_walk_parent to do a reference walk without
> > needing to call path_walk_parent_start - this way might be simpler and
> > path_walk_parent_start/end can just be for rcu case.
> >
> > but what do you think about the overall shape of it?
> 
> Personally, I don't have strong objections to this design. But VFS
> folks may have other concerns with it.

From what I've read above I'm not sure about details of the proposal but I
don't think mixing of RCU & non-RCU walk in a single function / iterator is
a good idea. IMHO the code would be quite messy. After all we have
follow_dotdot_rcu() and follow_dotdot() as separate functions for a reason.
Also given this series went through several iterations and we don't yet
have an acceptable / correct solution suggests getting even the standard
walk correct is hard enough. RCU walk is going to be only worse. So I'd
suggest to get the standard walk finished and agreed on first and
investigate feasibility of RCU variant later.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

