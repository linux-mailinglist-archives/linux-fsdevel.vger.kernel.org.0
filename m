Return-Path: <linux-fsdevel+bounces-5358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACFB80AC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4131F210BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47D4CB20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tU5rg+J6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WY/+/qKj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tU5rg+J6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WY/+/qKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F0A173B;
	Fri,  8 Dec 2023 09:47:46 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC8971F458;
	Fri,  8 Dec 2023 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702057664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ty0wkmYBzhMqy5lLUe3gr3yBKvt3QqcxRuI17ne1tpQ=;
	b=tU5rg+J60uTl33suc+vysMg4/c7ONg3pOCdPI5/B0uag7ybZVCxCk3soIVw0N1aq98Vekl
	uRFPmvqowmZpxJ1QixeFmNMXO3O6hvZ1lMgggPgKrX1yI0wyJV5LTO1WozbKXuL4km6+uM
	c4RvaarTbxqOP2EOnMW4O11dpw8rmz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702057664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ty0wkmYBzhMqy5lLUe3gr3yBKvt3QqcxRuI17ne1tpQ=;
	b=WY/+/qKjUM23d2X621auToV3XZASU1Jw4lKcsnGiwBykB58+5xS4iHMFiX4pVT65CkN8o8
	+VgmcyjXbLyf6RCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702057664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ty0wkmYBzhMqy5lLUe3gr3yBKvt3QqcxRuI17ne1tpQ=;
	b=tU5rg+J60uTl33suc+vysMg4/c7ONg3pOCdPI5/B0uag7ybZVCxCk3soIVw0N1aq98Vekl
	uRFPmvqowmZpxJ1QixeFmNMXO3O6hvZ1lMgggPgKrX1yI0wyJV5LTO1WozbKXuL4km6+uM
	c4RvaarTbxqOP2EOnMW4O11dpw8rmz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702057664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ty0wkmYBzhMqy5lLUe3gr3yBKvt3QqcxRuI17ne1tpQ=;
	b=WY/+/qKjUM23d2X621auToV3XZASU1Jw4lKcsnGiwBykB58+5xS4iHMFiX4pVT65CkN8o8
	+VgmcyjXbLyf6RCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AA52013A6B;
	Fri,  8 Dec 2023 17:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Jl4/KcBWc2VCUgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 08 Dec 2023 17:47:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 43F3EA07DC; Fri,  8 Dec 2023 18:47:44 +0100 (CET)
Date: Fri, 8 Dec 2023 18:47:44 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>, Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231208174744.2vsubexeolns7nb5@quack3>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231207-netzhaut-wachen-81c34f8ee154@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-netzhaut-wachen-81c34f8ee154@brauner>
X-Spam-Level: 
X-Spam-Score: -3.80
Authentication-Results: smtp-out2.suse.de;
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 07-12-23 18:21:18, Christian Brauner wrote:
> [Cc fsdevel & Jan because we had some discussions about fanotify
> returning non-thread-group pidfds. That's just for awareness or in case
> this might need special handling.]

Thanks!

> On Thu, Nov 30, 2023 at 09:39:44AM -0700, Tycho Andersen wrote:
> > From: Tycho Andersen <tandersen@netflix.com>
> > 
> > We are using the pidfd family of syscalls with the seccomp userspace
> > notifier. When some thread triggers a seccomp notification, we want to do
> > some things to its context (munge fd tables via pidfd_getfd(), maybe write
> > to its memory, etc.). However, threads created with ~CLONE_FILES or
> > ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
> > purpose, since their fd table or mm are distinct from the thread group
> > leader's. In this patch, we relax this restriction for pidfd_open().
> > 
> > In order to avoid dangling poll() users we need to notify pidfd waiters
> > when individual threads die, but once we do that all the other machinery
> > seems to work ok viz. the tests. But I suppose there are more cases than
> > just this one.
> > 
> > Another weirdness is the open-coding of this vs. exporting using
> > do_notify_pidfd(). This particular location is after __exit_signal() is
> > called, which does __unhash_process() which kills ->thread_pid, so we need
> > to use the copy we have locally, vs do_notify_pid() which accesses it via
> > task_pid(). Maybe this suggests that the notification should live somewhere
> > in __exit_signals()? I just put it here because I saw we were already
> > testing if this task was the leader.
> > 
> > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > ---
> 
> So we've always said that if there's a use-case for this then we're
> willing to support it. And I think that stance hasn't changed. I know
> that others have expressed interest in this as well.
> 
> So currently the series only enables pidfds for threads to be created
> and allows notifications for threads. But all places that currently make
> use of pidfds refuse non-thread-group leaders. We can certainly proceed
> with a patch series that only enables creation and exit notification but
> we should also consider unlocking additional functionality:
 
...

> * pidfd_prepare() is used to create pidfds for:
> 
>   (1) CLONE_PIDFD via clone() and clone3()
>   (2) SCM_PIDFD and SO_PEERPIDFD
>   (3) fanotify

So for fanotify there's no problem I can think of. All we do is return the
pidfd we get to userspace with the event to identify the task generating
the event. So in practice this would mean userspace will get proper pidfd
instead of error value (FAN_EPIDFD) for events generated by
non-thread-group leader. IMO a win.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

