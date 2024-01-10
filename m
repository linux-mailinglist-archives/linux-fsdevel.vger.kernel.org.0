Return-Path: <linux-fsdevel+bounces-7708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B7829BDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8292847E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A248CFE;
	Wed, 10 Jan 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pfAkztn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BR+qBYMY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pfAkztn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BR+qBYMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AE48CE2
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69711221D9;
	Wed, 10 Jan 2024 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704894985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLRnWsIRzElnUujRRgoD6us/xfwB7vnIkjGPIIIES3c=;
	b=pfAkztn7D//NYnaqsJuI6FpiPDvjyjmqj6AsHbKQMXjmFMF5efU7uyqxzhyxjJITpraLqm
	M5e86OyXQblYpR39Psa1YVRZmLPO9SAq6fsl9uIZeKKooN3IWz4iNl/mrRNut8gU3laev4
	/QboteiHm7jYLDsb9SOHCbqdUgzO4BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704894985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLRnWsIRzElnUujRRgoD6us/xfwB7vnIkjGPIIIES3c=;
	b=BR+qBYMYNo3E7xL3X97etqmlfAQtU2dOl+e2VU9oUPIlHTbkr69FX91hG3T3TPHFLxJQmr
	P4AniDlcP/RPZLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704894985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLRnWsIRzElnUujRRgoD6us/xfwB7vnIkjGPIIIES3c=;
	b=pfAkztn7D//NYnaqsJuI6FpiPDvjyjmqj6AsHbKQMXjmFMF5efU7uyqxzhyxjJITpraLqm
	M5e86OyXQblYpR39Psa1YVRZmLPO9SAq6fsl9uIZeKKooN3IWz4iNl/mrRNut8gU3laev4
	/QboteiHm7jYLDsb9SOHCbqdUgzO4BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704894985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLRnWsIRzElnUujRRgoD6us/xfwB7vnIkjGPIIIES3c=;
	b=BR+qBYMYNo3E7xL3X97etqmlfAQtU2dOl+e2VU9oUPIlHTbkr69FX91hG3T3TPHFLxJQmr
	P4AniDlcP/RPZLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D0E21398A;
	Wed, 10 Jan 2024 13:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fPavFgminmWHUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jan 2024 13:56:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0928A07EB; Wed, 10 Jan 2024 14:56:24 +0100 (CET)
Date: Wed, 10 Jan 2024 14:56:24 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event
 watchers
Message-ID: <20240110135624.kcimvdq6hrteyfb4@quack3>
References: <20240109194818.91465-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109194818.91465-1-amir73il@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Tue 09-01-24 21:48:18, Amir Goldstein wrote:
> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> optimized the case where there are no fsnotify watchers on any of the
> filesystem's objects.
> 
> It is quite common for a system to have a single local filesystem and
> it is quite common for the system to have some inotify watches on some
> config files or directories, so the optimization of no marks at all is
> often not in effect.

I agree.

> Access event watchers are far less common, so optimizing the case of
> no marks with access events could improve performance for more systems,
> especially for the performance sensitive hot io path.
> 
> Maintain a per-sb counter of objects that have marks with access
> events in their mask and use that counter to optimize out the call to
> fsnotify() in fsnotify access hooks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I'm not saying no to this but let's discuss first before hacking in some
partial solution :). AFAIU what Jens sees is something similar as was
reported for example here [1]. In these cases we go through
fsnotify_parent() down to fsnotify() until the check:

        if (!(test_mask & marks_mask))
                return 0;

there. And this is all relatively cheap (pure fetches like
sb->s_fsnotify_marks, mnt->mnt_fsnotify_marks, inode->i_fsnotify_marks,
sb->s_fsnotify_mask, mnt->mnt_fsnotify_mask, inode->i_fsnotify_mask) except
for parent handling in __fsnotify_parent(). That requires multiple atomic
operations - take_dentry_name_snapshot() is lock & unlock of d_lock, dget()
is cmpxchg on d_lockref, dput() is another cmpxchg on d_lockref - and this
gets really expensive, even more so if multiple threads race for the same
parent dentry.

So I think what we ideally need is a way to avoid this expensive "stabilize
parent & its name" game unless we are pretty sure we are going to generate
the event. There's no way to avoid fetching the parent early if
dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED (we can still postpone the
take_dentry_name_snapshot() cost though). However for the case where
dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED == 0 (and this is the case
here AFAICT) we need the parent only after the check of 'test_mask &
marks_mask'. So in that case we could completely avoid the extra cost of
parent dentry handling.

So in principle I believe we could make fsnotify noticeably lighter for the
case where no event is generated. Just the question is how to refactor the
current set of functions to achieve this without creating an unmaintainable
mess. I suspect if we lifted creation & some prefilling of iter_info into
__fsnotify_parent() and then fill in the parent in case we need it for
reporting only in fsnotify(), the code could be reasonably readable. We'd
need to always propagate the dentry down to fsnotify() though, currently we
often propagate only the inode because the dentry may be (still in case of
create or already in case of unlink) negative. Similarly we'd somehow need
to communicate down into fsnotify() whether the passed name needs
snapshotting or not...

What do you think?

								Honza

[1] https://lore.kernel.org/all/SJ0PR08MB6494F5A32B7C60A5AD8B33C2AB09A@SJ0PR08MB6494.namprd08.prod.outlook.com

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

