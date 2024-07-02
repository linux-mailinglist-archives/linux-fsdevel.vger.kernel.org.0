Return-Path: <linux-fsdevel+bounces-22920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE6923AFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D994281105
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258E157483;
	Tue,  2 Jul 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uxSo8KW0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AhQ4e/Fx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vw73PFWL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ho2GxMOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF014F9FA;
	Tue,  2 Jul 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914515; cv=none; b=rFVwdL24t8GpPInaxrCpr+IHQC1imzCz5MSqPw7zvTMuFqjyufSk34FOhLu3RrWH20zeOdqHM4HLrjx2xonvb2otk5PhXPARSBbDip5KlobvFyq2ckG7VB3q6uPR1cWTC8THmkx27yHjW7Gw8B36Ii2wINyeoaJhuuBK7/w8biA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914515; c=relaxed/simple;
	bh=pKzdN6zQ8+YZCkXU1ly2+sx3rugOOC0ui044eHAwIF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUatVkiDCrh+vbPo855GjUDQCy0QNJr8VytcAsbmQOVqQSzS4AlOqcYKSLEJ0wpROgtCueo2BrVRs5Mgn9dNcfJ9JiTwMNkDAatk7ClzyMngmdEn6IbatRsWzpTy/0VUKn6G+iWB3lJE01fNTsPA6OY9VthLjyb0szDYTBTCwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uxSo8KW0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AhQ4e/Fx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vw73PFWL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ho2GxMOC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE3331FB96;
	Tue,  2 Jul 2024 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719914512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEi8cgHl/U1n72reX2G1VxiSazemZP/lxQo7blAElqU=;
	b=uxSo8KW0q1L3c7zd72VSW5ucrqMQ9TpMj1m1AmodGRueHb0ylN6oOn5f2tNNVhSWkJmmG5
	xf8yVVTVZLn8VXNcvyNIrppvfx/4/rPRl//zhclKgFsat0i+G3LmYtYfztIuFefikvUvj5
	UtsRJKcsmWVgbVV0jongv3Clrn7u7Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719914512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEi8cgHl/U1n72reX2G1VxiSazemZP/lxQo7blAElqU=;
	b=AhQ4e/FxEd9KpLLes95Ya8wmrINo6A4WZ9v5iZVG/EATMjdz9mgM1AcEVN0f6IpQPgjwbG
	d/lyJktBI3b8rzBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vw73PFWL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ho2GxMOC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719914511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEi8cgHl/U1n72reX2G1VxiSazemZP/lxQo7blAElqU=;
	b=vw73PFWLYs8H4rGWbAKPFpXVfjZqNNjpFaggu9g9orMhsb89eEUQYR2eB29zCuuPaMYGMV
	kexSTshdxOC6Am4XbMC3DbaF/CD6Yc42wqxlEElo7Wqs+tuWpa0w6q9Qs/AUHuCP647kQg
	FxJjoBzVryKPBfEbbJX9C8Q9UqUt2vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719914511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEi8cgHl/U1n72reX2G1VxiSazemZP/lxQo7blAElqU=;
	b=Ho2GxMOCs0IEHwNGr+tVvQdKE8Q9YsmmGkZQD3dhDAbfW+R9DWpQqFOlYtJM5hgx7Qpi+R
	Tgs3/Scokkc64+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEE4313A9A;
	Tue,  2 Jul 2024 10:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zDFkNg/Qg2ZnOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jul 2024 10:01:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5D60FA08A6; Tue,  2 Jul 2024 12:01:47 +0200 (CEST)
Date: Tue, 2 Jul 2024 12:01:47 +0200
From: Jan Kara <jack@suse.cz>
To: Ian Kent <ikent@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
	raven@themaw.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240702100147.by5iwwutbnr23hac@quack3>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <cfda4682-34b4-462c-acf6-976b0d79ba06@redhat.com>
 <20240628111345.3bbcgie4gar6icyj@quack3>
 <20240702-sauna-tattoo-31b01a5f98f6@brauner>
 <a9963f50-6349-4e76-8f12-c12c2ad4d2ab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9963f50-6349-4e76-8f12-c12c2ad4d2ab@redhat.com>
X-Rspamd-Queue-Id: EE3331FB96
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 02-07-24 15:01:54, Ian Kent wrote:
> On 2/7/24 12:58, Christian Brauner wrote:
> > On Fri, Jun 28, 2024 at 01:13:45PM GMT, Jan Kara wrote:
> > > On Fri 28-06-24 10:58:54, Ian Kent wrote:
> > > > On 27/6/24 19:54, Jan Kara wrote:
> > > > > On Thu 27-06-24 09:11:14, Ian Kent wrote:
> > > > > > On 27/6/24 04:47, Matthew Wilcox wrote:
> > > > > > > On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
> > > > > > > > +++ b/fs/namespace.c
> > > > > > > > @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> > > > > > > >     static DECLARE_RWSEM(namespace_sem);
> > > > > > > >     static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> > > > > > > >     static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > > > > > > +static bool lazy_unlock = false; /* protected by namespace_sem */
> > > > > > > That's a pretty ugly way of doing it.  How about this?
> > > > > > Ha!
> > > > > > 
> > > > > > That was my original thought but I also didn't much like changing all the
> > > > > > callers.
> > > > > > 
> > > > > > I don't really like the proliferation of these small helper functions either
> > > > > > but if everyone
> > > > > > 
> > > > > > is happy to do this I think it's a great idea.
> > > > > So I know you've suggested removing synchronize_rcu_expedited() call in
> > > > > your comment to v2. But I wonder why is it safe? I *thought*
> > > > > synchronize_rcu_expedited() is there to synchronize the dropping of the
> > > > > last mnt reference (and maybe something else) - see the comment at the
> > > > > beginning of mntput_no_expire() - and this change would break that?
> > > > Interesting, because of the definition of lazy umount I didn't look closely
> > > > enough at that.
> > > > 
> > > > But I wonder, how exactly would that race occur, is holding the rcu read
> > > > lock sufficient since the rcu'd mount free won't be done until it's
> > > > released (at least I think that's how rcu works).
> > > I'm concerned about a race like:
> > > 
> > > [path lookup]				[umount -l]
> > > ...
> > > path_put()
> > >    mntput(mnt)
> > >      mntput_no_expire(m)
> > >        rcu_read_lock();
> > >        if (likely(READ_ONCE(mnt->mnt_ns))) {
> > > 					do_umount()
> > > 					  umount_tree()
> > > 					    ...
> > > 					    mnt->mnt_ns = NULL;
> > > 					    ...
> > > 					  namespace_unlock()
> > > 					    mntput(&m->mnt)
> > > 					      mntput_no_expire(mnt)
> > > 				              smp_mb();
> > > 					      mnt_add_count(mnt, -1);
> > > 					      count = mnt_get_count(mnt);
> > > 					      if (count != 0) {
> > > 						...
> > > 						return;
> > >          mnt_add_count(mnt, -1);
> > >          rcu_read_unlock();
> > >          return;
> > > -> KABOOM, mnt->mnt_count dropped to 0 but nobody cleaned up the mount!
> > >        }
> > Yeah, I think that's a valid concern. mntput_no_expire() requires that
> > the last reference is dropped after an rcu grace period and that can
> > only be done by synchronize_rcu_*() (It could be reworked but that would
> > be quite ugly.). See also mnt_make_shortterm() caller's for kernel
> > initiated unmounts.
> 
> I've thought about this a couple of times now.
> 
> Isn't it the case here that the path lookup thread will have taken a
> reference (because it's calling path_put()) and the umount will have
> taken a reference on system call entry.

Yes, path lookup has taken a reference to mnt in this case. Umount syscall
also has a reference to the mount in its struct path it has got from
user_path_at(). But note that single umount call can end up tearing the
whole tree of mounts AFAICT (in umount_tree()) so you cannot really rely on
the fact that the syscall holds a ref to the mount it is tearing down.

Secondly, even if the path_umount() would be holding a reference to the
mount being torn down, it is trivial to extend the race window so that
the task doing 'umount -l' continues until it gets past mntput_no_expire()
in path_umount() and only then the task doing path_put() wakes up and you
get the same problem.

> So for the mount being umounted the starting count will be at lest three
> then if the umount mntput() is called from namespace_unlock() it will
> correctly see count != 0 and the path lookup mntput() to release it's
> reference finally leaving the mntput() of the path_put() from the top
> level system call function to release the last reference.
> 
> Once again I find myself thinking this should be independent of the rcu
> wait because only path walks done before the mount being detached can be
> happening and the lockless walks are done holding the rcu read lock and
> how likely is it a ref-walk path lookup (that should follow a failed
> rcu-walk in this case) has been able to grab a reference anyway?

No, it really is not independent of the RCU wait. mntput_no_expire() uses
RCU for proper synchronization of dropping of the last mount reference.
AFAIU there's a rule - after you clear mnt->mnt_ns, you must wait for RCU
period to expire before you can drop the mnt reference you are holding. RCU
path walk uses this fact but also any part of the kernel calling
mntput_no_expire() implicitely depends on this behavior. And the changes to
lazy umount path must not break this rule (or they have to come up with a
different way to synchronize dropping of the last mnt reference).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

