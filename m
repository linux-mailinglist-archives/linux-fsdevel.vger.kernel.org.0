Return-Path: <linux-fsdevel+bounces-62780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7EBBA09C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92D4621504
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F73064B8;
	Thu, 25 Sep 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eiICR31A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1hfiOngX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VK6c/htl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsSN62LB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C4274B51
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817823; cv=none; b=AuNXO+dFLl/rUnMu93CwqTM4tK5zGce7HGt24BkMC021s5L4kP13aFhqvF7Hrvbgk5+jW0flGHWSEmLAzlbOM8KYsFp5vBVXIy9XWaPGUEcui7KjALuGw5FCEZjGnvpsMw5b0G4XJgHMEyxc9vDu1cpWZzC78i5IB6RfrIILFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817823; c=relaxed/simple;
	bh=0BgcTt05Cf0n8m3nPQYSFb/zIsDrQ9XY7PWCaKNuye8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFyiqACsmXcZMyfrzCdBcqQe9OpjLbRjqJmHpxvqEZ+JYuJZTP9Hmgt8g/XhlonXFuiW4BL3pItNnj5lAFwznXGaISKcDOgow0Ih8oK+tMZcTBCT1ZuGG4tbD0yijXQSOnYlFmnjeoK+Ed75w6ClwJsJPUPSi4/lQb2e6vauD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eiICR31A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1hfiOngX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VK6c/htl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsSN62LB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FDA216D19;
	Thu, 25 Sep 2025 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758817820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/s02BsWmMqZvdLMg918Ho0ZuXWV0QvnlyfQBuUBNJME=;
	b=eiICR31AFhA4RszXxWvFTNeFfjS3aiOQYAeSe2uH2cj0BAbwa+Y++EaqcBl5EVpYky2LGs
	aDwJEGAY2feM48ahHBqw/bDA36Z1HDOrb7CSt65c8qJ2eKNMbkw8o5fzGnePZ6DkStv1bB
	Ik975EONbPLdujtTUzVO3iGwCgT9wfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758817820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/s02BsWmMqZvdLMg918Ho0ZuXWV0QvnlyfQBuUBNJME=;
	b=1hfiOngXeNoXE6lpJsuY1D0C1GQxINKpDwHPupfBK/SL5RzLCAwI/rTuNFCWaSuTZSATOy
	vEpoDuVEKNsO5XDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="VK6c/htl";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NsSN62LB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758817819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/s02BsWmMqZvdLMg918Ho0ZuXWV0QvnlyfQBuUBNJME=;
	b=VK6c/htl0mQnCzJ36Wby009a2ATEIJWg4a3zoe+0iRDOt3NpDOlfg9CC9ssarHlaqc2C/1
	GNMTYpAUvXn1LHeXQssytsEQpyg9Y8UTT7Y+m51afK9mP1G184HlTTTKeXphsCjfH8jKHY
	Tyy17XOVVGUNnYNRGEHEBem6bdOjsV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758817819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/s02BsWmMqZvdLMg918Ho0ZuXWV0QvnlyfQBuUBNJME=;
	b=NsSN62LBJ6kt6zRn3nmvIf8Fh2Kp5wwQuXAtBQNg9iA3EeuBuz8xIoNYmf3eNn3H484Fsg
	9bK8DktRCM9SE9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA7B132C9;
	Thu, 25 Sep 2025 16:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7LvEORpu1Wh1ZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Sep 2025 16:30:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C4C1A0AA5; Thu, 25 Sep 2025 18:30:18 +0200 (CEST)
Date: Thu, 25 Sep 2025 18:30:18 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, lance.yang@linux.dev, 
	mhiramat@kernel.org, agruenba@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH 0/3] Suppress undesirable hung task
 warnings.
Message-ID: <ceqwycvzll3mocwuzsjb77by5ajuqt3zqrwx3gb67pe6idupqz@ktty5g2jaww4>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <20250922132718.GB49638@noisy.programming.kicks-ass.net>
 <aNGQoPFTH2_xrd9L@infradead.org>
 <20250922145045.afc6593b4e91c55d8edefabb@linux-foundation.org>
 <20250923071607.GR3245006@noisy.programming.kicks-ass.net>
 <dndr5xdp3bweqtwlyixtzajxgkhxbt2qb2fzg6o2wy5msrhzi4@h3klek5hff5i>
 <CAHSKhteCMv0fUmDKHdKXhg=D-rz-Jmze5ei-Up16vMsNEy898w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHSKhteCMv0fUmDKHdKXhg=D-rz-Jmze5ei-Up16vMsNEy898w@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLuhuubkxd663ptcywq6p8zkwd)];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3FDA216D19
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 25-09-25 23:07:24, Julian Sun wrote:
> On Wed, Sep 24, 2025 at 6:34 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 23-09-25 09:16:07, Peter Zijlstra wrote:
> > > On Mon, Sep 22, 2025 at 02:50:45PM -0700, Andrew Morton wrote:
> > > > On Mon, 22 Sep 2025 11:08:32 -0700 Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > > On Mon, Sep 22, 2025 at 03:27:18PM +0200, Peter Zijlstra wrote:
> > > > > > > Julian Sun (3):
> > > > > > >   sched: Introduce a new flag PF_DONT_HUNG.
> > > > > > >   writeback: Introduce wb_wait_for_completion_no_hung().
> > > > > > >   memcg: Don't trigger hung task when memcg is releasing.
> > > > > >
> > > > > > This is all quite terrible. I'm not at all sure why a task that is
> > > > > > genuinely not making progress and isn't killable should not be reported.
> > > > >
> > > > > The hung device detector is way to aggressive for very slow I/O.
> > > > > See blk_wait_io, which has been around for a long time to work
> > > > > around just that.  Given that this series targets writeback I suspect
> > > > > it is about an overloaded device as well.
> > > >
> > > > Yup, it's writeback - the bug report is in
> > > > https://lkml.kernel.org/r/20250917212959.355656-1-sunjunchao@bytedance.com
> > > >
> > > > Memory is big and storage is slow, there's nothing wrong if a task
> > > > which is designed to wait for writeback waits for a long time.
> > > >
> > > > Of course, there's something wrong if some other task which isn't
> > > > designed to wait for writeback gets stuck waiting for the task which
> > > > *is* designed to wait for writeback, but we'll still warn about that.
> > > >
> > > >
> > > > Regarding an implementation, I'm wondering if we can put a flag in
> > > > `struct completion' telling the hung task detector that this one is
> > > > expected to wait for long periods sometimes.  Probably messy and it
> > > > only works for completions (not semaphores, mutexes, etc).  Just
> > > > putting it out there ;)
> > >
> > > So the problem is that there *is* progress (albeit rather slowly), the
> > > watchdog just doesn't see that. Perhaps that is the thing we should look
> > > at fixing.
> > >
> > > How about something like the below? That will 'spuriously' wake up the
> > > waiters as long as there is some progress being made. Thereby increasing
> > > the context switch counters of the tasks and thus the hung_task watchdog
> > > sees progress.
> > >
> > > This approach should be safer than the blk_wait_io() hack, which has a
> > > timer ticking, regardless of actual completions happening or not.
> >
> > I like the idea. The problem with your patch is that the progress is not
> > visible with high enough granularity in wb_writeback_work->done completion.
> > That is only incremented by 1, when say a request to writeout 1GB is queued
> > and decremented by 1 when that 1GB is written. The progress can be observed
> > with higher granularity by wb_writeback_work->nr_pages getting decremented
> > as we submit pages for writeback but this counter still gets updated only
> > once we are done with a particular inode so if all those 1GB of data are in
> > one inode there wouldn't be much to observe. So we might need to observe
> > how struct writeback_control member nr_to_write gets updated. That is
> > really updated frequently on IO submission but each filesystem updates it
> > in their writepages() function so implementing that gets messy pretty
> > quickly.
> >
> > But maybe a good place to hook into for registering progress would be
> > wbc_init_bio()? Filesystems call that whenever we create new bio for writeback
> > purposes. We do have struct writeback_control available there so through
> > that we could propagate information that forward progress is being made.
> >
> > What do people think?
> 
> Sorry for the late reply. Yes, Jan, I agree — your proposal sounds
> both fine-grained and elegant. But do we really have a strong need for
> such detailed progress tracking?
> 
> In background writeback, for example, if the bandwidth is very low
> (e.g. avg_write_bandwidth=24), writeback_chunk_size() already splits
> pages into chunks of MIN_WRITEBACK_PAGES (1024). This is usually
> enough to avoid hung task warnings, so reporting progress there might
> be sufficient.

Right.

> I’m also a bit concerned that reporting progress on every
> wbc_init_bio() could lead to excessive wakeups in normal or
> high-throughput cases, which might have side effects. Please correct
> me if I’m missing something.

Hum, fair, we'd have to somehow ratelimit it which adds even more
complexity. If the waking on completion is enough to silence the hung task
detector in your cases, I'm all for a simple solution. We can always
reconsider if it proves to not be good enough.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

