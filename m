Return-Path: <linux-fsdevel+bounces-45437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE22A77973
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0CB188B4F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69351F236E;
	Tue,  1 Apr 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LQCzv7lw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+zx+wweq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LQCzv7lw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+zx+wweq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1701F1313
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506442; cv=none; b=ocvtKuE12qW8pJdyx35ZjXzVabWkwsOOog/RofMYmJgQFQDddUhGaYcXfW5FznlLc1I2QXlqltuu3VHm+Ah6QSDXEDHgI285Cxr/wbdZwM2xuA9N+u4PlEiCcvliYIyqruUIE2KbA4R+cqZrENEqWBhkxqpxxVhhs0uCR9cBymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506442; c=relaxed/simple;
	bh=4z0yWuovovzT4P0Rx5n7A0VZ8Le5ZD/+97cst0pdcGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDpmvjaNN7OLYgXYn0n/D8foCUk5I3Iwjm99gx979Nq0lX2LFgU1V2W3NNMDv2zR4dUgrr3YgVfYxX/SqdFWBidKqeSWA0O6RuQFFiMcjowq6UNMd5GaJvktTk05EpWrJ+CpcbEaJCMUm5N5K1lDJ8ZmFPtg9Ii3tn72CL32NxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LQCzv7lw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+zx+wweq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LQCzv7lw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+zx+wweq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF393211E8;
	Tue,  1 Apr 2025 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743506437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Qm5ZIzmgsTH99+u6cTQsdFe97BWstocOSAgLAVKl+0=;
	b=LQCzv7lw82pO8LAxuMgGur/XBrzsFQciXqJfRsQ/W2/02rA+j3khv6i2XoaYJKItUoBq1O
	z2nFygqtd2f8f5K87Cc/UX3f0ricKqsk+XIkh7KwpXMLype29Q+FrpPZUk6tQda8eu3zl/
	EXN8nW0/IhKReCadq4AYnt7JdVyS+vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743506437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Qm5ZIzmgsTH99+u6cTQsdFe97BWstocOSAgLAVKl+0=;
	b=+zx+wweqdmixvCE8O9nYTmgqZMsAcc+QjZJy85pfSYKYmRvDaXx2fx3llWMYBTAyIr7fbE
	d686O1ZWJZOsXoBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743506437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Qm5ZIzmgsTH99+u6cTQsdFe97BWstocOSAgLAVKl+0=;
	b=LQCzv7lw82pO8LAxuMgGur/XBrzsFQciXqJfRsQ/W2/02rA+j3khv6i2XoaYJKItUoBq1O
	z2nFygqtd2f8f5K87Cc/UX3f0ricKqsk+XIkh7KwpXMLype29Q+FrpPZUk6tQda8eu3zl/
	EXN8nW0/IhKReCadq4AYnt7JdVyS+vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743506437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Qm5ZIzmgsTH99+u6cTQsdFe97BWstocOSAgLAVKl+0=;
	b=+zx+wweqdmixvCE8O9nYTmgqZMsAcc+QjZJy85pfSYKYmRvDaXx2fx3llWMYBTAyIr7fbE
	d686O1ZWJZOsXoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C18DB13691;
	Tue,  1 Apr 2025 11:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kYs7LwXM62d9JQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Apr 2025 11:20:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 76DF4A07E6; Tue,  1 Apr 2025 13:20:37 +0200 (CEST)
Date: Tue, 1 Apr 2025 13:20:37 +0200
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, 
	hch@infradead.org, david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [RFC PATCH 1/4] locking/percpu-rwsem: add freezable alternative
 to down_read
Message-ID: <3bfnds6nsvxy5jfbcoy62uva6kebhacjuavqxvelbfs6ut6rqf@m4pzsudbqg6l>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-2-James.Bottomley@HansenPartnership.com>
 <77774eb380e343976de3de681204e2c7f3ab1926.camel@HansenPartnership.com>
 <20250401-anwalt-dazugeben-18d8c3efd1fd@brauner>
 <f6bdfa23b9f54055f8a539ce396f1134b0921417.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6bdfa23b9f54055f8a539ce396f1134b0921417.camel@HansenPartnership.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,vger.kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 31-03-25 21:13:20, James Bottomley wrote:
> On Tue, 2025-04-01 at 01:32 +0200, Christian Brauner wrote:
> > On Mon, Mar 31, 2025 at 03:51:43PM -0400, James Bottomley wrote:
> > > On Thu, 2025-03-27 at 10:06 -0400, James Bottomley wrote:
> > > [...]
> > > > -static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem,
> > > > bool
> > > > reader)
> > > > +static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem,
> > > > bool
> > > > reader,
> > > > +			      bool freeze)
> > > >  {
> > > >  	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
> > > >  	bool wait;
> > > > @@ -156,7 +157,8 @@ static void percpu_rwsem_wait(struct
> > > > percpu_rw_semaphore *sem, bool reader)
> > > >  	spin_unlock_irq(&sem->waiters.lock);
> > > >  
> > > >  	while (wait) {
> > > > -		set_current_state(TASK_UNINTERRUPTIBLE);
> > > > +		set_current_state(TASK_UNINTERRUPTIBLE |
> > > > +				  freeze ? TASK_FREEZABLE : 0);
> > > 
> > > This is a bit embarrassing, the bug I've been chasing is here: the
> > > ?
> > > operator is lower in precedence than | meaning this expression
> > > always
> > > evaluates to TASK_FREEZABLE and nothing else (which is why the
> > > process
> > > goes into R state and never wakes up).
> > > 
> > > Let me fix that and redo all the testing.
> > 
> > I don't think that's it. I think you're missing making pagefault
> > writers such
> > as systemd-journald freezable:
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index b379a46b5576..528e73f192ac 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct
> > super_block *sb, int level)
> >  static inline void __sb_start_write(struct super_block *sb, int
> > level)
> >  {
> >         percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
> > -                                  level == SB_FREEZE_WRITE);
> > +                                  (level == SB_FREEZE_WRITE ||
> > +                                   level == SB_FREEZE_PAGEFAULT));
> >  }
> 
> Yes, I was about to tell Jan that the condition here simply needs to be
> true.  All our rwsem levels need to be freezable to avoid a hibernation
> failure.

So there is one snag with this. SB_FREEZE_PAGEFAULT level is acquired under
mmap_sem, SB_FREEZE_INTERNAL level is possibly acquired under some other
filesystem locks. So if you freeze the filesystem, a task can block on
frozen filesystem with e.g. mmap_sem held and if some other task then
blocks on grabbing that mmap_sem, hibernation fails because we'll be unable
to hibernate the task waiting for mmap_sem. So if you'd like to completely
avoid these hibernation failures, you'd have to make a slew of filesystem
related locks use freezable sleeping. I don't think that's feasible.

I was hoping that failures due to SB_FREEZE_PAGEFAULT level not being
freezable would be rare enough but you've proven they are quite frequent.
We can try making SB_FREEZE_PAGEFAULT level (or even SB_FREEZE_INTERNAL)
freezable and see whether that works good enough...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

