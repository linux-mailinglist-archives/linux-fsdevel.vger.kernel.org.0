Return-Path: <linux-fsdevel+bounces-7728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF2829ED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2730F1F24302
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26324CE0F;
	Wed, 10 Jan 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0/W7YZQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HwgEyC1O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0/W7YZQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HwgEyC1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A04CE01
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A78B51FDA5;
	Wed, 10 Jan 2024 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704905835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ss0j7QLA429M6AJOC+nmztDo3YiZiOJ51iFQeGhQubo=;
	b=c0/W7YZQ5D2z2shvrrLZil3cuYXPFa54YwiwDoLYq/QxcyHLyJDNygHO0hDLhhgFOevdcK
	68pWvE34cdvSavnbIkSMRtZY6RaqZPZ9ttEme+HMs6PfRSQ5LciBwsllrFCsEGxz8LGHux
	ZHqGeJZZvuIzQNTWWVIyuTFfT0Gqzdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704905835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ss0j7QLA429M6AJOC+nmztDo3YiZiOJ51iFQeGhQubo=;
	b=HwgEyC1Om2lSp38FF5b2dm+H8ZYbYmeZRktnUDr0vqT1oLRxXBtEF+41VSuDvGQN8TXXsn
	vjntduAoizqzO0CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704905835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ss0j7QLA429M6AJOC+nmztDo3YiZiOJ51iFQeGhQubo=;
	b=c0/W7YZQ5D2z2shvrrLZil3cuYXPFa54YwiwDoLYq/QxcyHLyJDNygHO0hDLhhgFOevdcK
	68pWvE34cdvSavnbIkSMRtZY6RaqZPZ9ttEme+HMs6PfRSQ5LciBwsllrFCsEGxz8LGHux
	ZHqGeJZZvuIzQNTWWVIyuTFfT0Gqzdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704905835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ss0j7QLA429M6AJOC+nmztDo3YiZiOJ51iFQeGhQubo=;
	b=HwgEyC1Om2lSp38FF5b2dm+H8ZYbYmeZRktnUDr0vqT1oLRxXBtEF+41VSuDvGQN8TXXsn
	vjntduAoizqzO0CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 68A27139C6;
	Wed, 10 Jan 2024 16:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EjSJGWvMnmXACgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 10 Jan 2024 16:57:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C6BEA07EB; Wed, 10 Jan 2024 17:58:45 +0100 (CET)
Date: Wed, 10 Jan 2024 17:58:45 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event
 watchers
Message-ID: <20240110165845.b7tgghzugm73pwog@quack3>
References: <20240109194818.91465-1-amir73il@gmail.com>
 <20240110135624.kcimvdq6hrteyfb4@quack3>
 <CAOQ4uxhNp57J8_W_x0siaZRCqTueY033iQGsXB2JA9o9jAJCVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhNp57J8_W_x0siaZRCqTueY033iQGsXB2JA9o9jAJCVA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="c0/W7YZQ";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HwgEyC1O
X-Spamd-Result: default: False [-2.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A78B51FDA5
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Wed 10-01-24 16:41:46, Amir Goldstein wrote:
> On Wed, Jan 10, 2024 at 3:56 PM Jan Kara <jack@suse.cz> wrote:
> > On Tue 09-01-24 21:48:18, Amir Goldstein wrote:
> > > Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> > > optimized the case where there are no fsnotify watchers on any of the
> > > filesystem's objects.
> > >
> > > It is quite common for a system to have a single local filesystem and
> > > it is quite common for the system to have some inotify watches on some
> > > config files or directories, so the optimization of no marks at all is
> > > often not in effect.
> >
> > I agree.
> >
> > > Access event watchers are far less common, so optimizing the case of
> > > no marks with access events could improve performance for more systems,
> > > especially for the performance sensitive hot io path.
> > >
> > > Maintain a per-sb counter of objects that have marks with access
> > > events in their mask and use that counter to optimize out the call to
> > > fsnotify() in fsnotify access hooks.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I'm not saying no to this but let's discuss first before hacking in some
> > partial solution :). AFAIU what Jens sees is something similar as was
> > reported for example here [1]. In these cases we go through
> > fsnotify_parent() down to fsnotify() until the check:
> >
> >         if (!(test_mask & marks_mask))
> >                 return 0;
> >
> > there. And this is all relatively cheap (pure fetches like
> > sb->s_fsnotify_marks, mnt->mnt_fsnotify_marks, inode->i_fsnotify_marks,
> > sb->s_fsnotify_mask, mnt->mnt_fsnotify_mask, inode->i_fsnotify_mask) except
> > for parent handling in __fsnotify_parent(). That requires multiple atomic
> > operations - take_dentry_name_snapshot() is lock & unlock of d_lock, dget()
> > is cmpxchg on d_lockref, dput() is another cmpxchg on d_lockref - and this
> > gets really expensive, even more so if multiple threads race for the same
> > parent dentry.
> 
> Sorry, I forgot to link the Jens regression report [1] which included this
> partial perf report:
> 
>      3.36%             [kernel.vmlinux]  [k] fsnotify
>      2.32%             [kernel.vmlinux]  [k] __fsnotify_paren
> 
> Your analysis about __fsnotify_parent() may be correct, but what would be
> the explanation to time spent in fsnotify() in this report?

OK, I don't have a good explanation for why fsnotify() itself is so high in
Jens' profile. Maybe cacheline fetches caused by inode->i_fsnotify_mask and
inode->i_fsnotify_marks checks are causing the overhead but it would be
good to have it confirmed.

> In general, I think that previous optimization work as this commit by Mel:
> 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead when
> there is no watcher") showed improvements when checks were inlined.

Well, I believe that commit helped exactly because the check for
DCACHE_FSNOTIFY_PARENT_WATCHED was moved ahead of all the work now in
__fsnotify_parent().

> [1] https://lore.kernel.org/linux-fsdevel/53682ece-f0e7-48de-9a1c-879ee34b0449@kernel.dk/
> 
> > So I think what we ideally need is a way to avoid this expensive "stabilize
> > parent & its name" game unless we are pretty sure we are going to generate
> > the event. There's no way to avoid fetching the parent early if
> > dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED (we can still postpone the
> > take_dentry_name_snapshot() cost though). However for the case where
> > dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED == 0 (and this is the case
> > here AFAICT) we need the parent only after the check of 'test_mask &
> > marks_mask'. So in that case we could completely avoid the extra cost of
> > parent dentry handling.
> >
> > So in principle I believe we could make fsnotify noticeably lighter for the
> > case where no event is generated. Just the question is how to refactor the
> > current set of functions to achieve this without creating an unmaintainable
> > mess. I suspect if we lifted creation & some prefilling of iter_info into
> > __fsnotify_parent() and then fill in the parent in case we need it for
> > reporting only in fsnotify(), the code could be reasonably readable. We'd
> > need to always propagate the dentry down to fsnotify() though, currently we
> > often propagate only the inode because the dentry may be (still in case of
> > create or already in case of unlink) negative. Similarly we'd somehow need
> > to communicate down into fsnotify() whether the passed name needs
> > snapshotting or not...
> >
> > What do you think?
> 
> I am not saying no ;)
> but it sound a bit complicated so if the goal is to reduce the overhead
> of fsnotify_access() and fsnotify_perm(), which I don't think any application
> cares about, then I'd rather go with a much simpler solution even if it
> does not cover all the corner cases.

OK, let's figure out what exactly causes slowdown in Jens' case first. I
agree your solution helps mitigate the cost of fsnotify_access() for reads
but I forsee people complaining about fsnotify_modify() cost for writes in
short order :) and there it is not so simple to solve as there's likely
some watch for FS_MODIFY event somewhere.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

