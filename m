Return-Path: <linux-fsdevel+bounces-62415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3FB91ED8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959B2423D5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881642E542C;
	Mon, 22 Sep 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnCJh8IJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6tDJUbPl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnCJh8IJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6tDJUbPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4617260D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554858; cv=none; b=BNOi6ZzjmQ7CtRlXoPoC84DFql0o9FhhnEubPVk/5+31Q2meCmF6DtRkBK0MN1OljXlvk/ZwEg99oL5CL6xPXouhPaDg5NbIdi85NJwlgGUa9EMQcfcKkkTOr/77d/z8aKdw4jZXoDaMEN00BDw9qu1/SmoY1CabjPZjBbP12OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554858; c=relaxed/simple;
	bh=Vw6JJ7xrCIwh6MqyjOkTVkannJHgEmX47UGmuXG+9Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol2A74D/t7WNskwD3FZ+dB33RVGv8wkETR0FSZ8hQBSAWHo6NQhplK7n5ihERW5EMwR7jsVPFtXTOSgnL1cW3rKGfM1pz8foaY6pjiTbAXuamxNobhYVvenuTL6FwGNyt/wTvzIWP2xwK4NLIwwd4Q4/1T5CmADwh4DV1/Pisv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnCJh8IJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6tDJUbPl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnCJh8IJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6tDJUbPl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC9D41F395;
	Mon, 22 Sep 2025 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758554855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb+DXx+3ADAp+EoOOgHeeXZgUzRoFnTs9AYorQ75bCM=;
	b=JnCJh8IJFkuMqJxVQU00Jyy2lJHqLhBBIjbqNFgL5nOeKX/O/TfNKaSvBgDKiHpRSXN46f
	X4aIKirmoFDIQ6Ke9+rt0kjUUvrhYip+a/Iawy7fdVspYdB7XcV8xFnK7Zvw4SxD5kkook
	m2/4+HzM9LAfD9G9vyNJZfEF5ZFhUFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758554855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb+DXx+3ADAp+EoOOgHeeXZgUzRoFnTs9AYorQ75bCM=;
	b=6tDJUbPlqJioZyGmF1fM2NZufXV2CD+L8O45l0A4SRfTOdLwBwkpTCdfQrZrjthXcYQFy4
	aHKQ1hYI+3kzguCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758554855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb+DXx+3ADAp+EoOOgHeeXZgUzRoFnTs9AYorQ75bCM=;
	b=JnCJh8IJFkuMqJxVQU00Jyy2lJHqLhBBIjbqNFgL5nOeKX/O/TfNKaSvBgDKiHpRSXN46f
	X4aIKirmoFDIQ6Ke9+rt0kjUUvrhYip+a/Iawy7fdVspYdB7XcV8xFnK7Zvw4SxD5kkook
	m2/4+HzM9LAfD9G9vyNJZfEF5ZFhUFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758554855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb+DXx+3ADAp+EoOOgHeeXZgUzRoFnTs9AYorQ75bCM=;
	b=6tDJUbPlqJioZyGmF1fM2NZufXV2CD+L8O45l0A4SRfTOdLwBwkpTCdfQrZrjthXcYQFy4
	aHKQ1hYI+3kzguCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92CC21388C;
	Mon, 22 Sep 2025 15:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kRbQI+dq0WgYJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 15:27:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2AB47A07C4; Mon, 22 Sep 2025 17:27:35 +0200 (CEST)
Date: Mon, 22 Sep 2025 17:27:35 +0200
From: Jan Kara <jack@suse.cz>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Julian Sun <sunjunchao@bytedance.com>, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, akpm@linux-foundation.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, agruenba@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <4ntd7nnkoidyakbfm3caieku5tvpmzklhm27vgr3fu746hsrov@wqiqxasc4s7p>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <20250922132718.GB49638@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922132718.GB49638@noisy.programming.kicks-ass.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 22-09-25 15:27:18, Peter Zijlstra wrote:
> On Mon, Sep 22, 2025 at 05:41:43PM +0800, Julian Sun wrote:
> > As suggested by Andrew Morton in [1], we need a general mechanism 
> > that allows the hung task detector to ignore unnecessary hung 
> > tasks. This patch set implements this functionality.
> > 
> > Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will 
> > ignores all tasks that have the PF_DONT_HUNG flag set.
> > 
> > Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(), 
> > which enable the hung task detector to ignore hung tasks caused by these
> > wait events.
> > 
> > Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg 
> > teardown to eliminate the hung task warning.
> > 
> > Julian Sun (3):
> >   sched: Introduce a new flag PF_DONT_HUNG.
> >   writeback: Introduce wb_wait_for_completion_no_hung().
> >   memcg: Don't trigger hung task when memcg is releasing.
> 
> This is all quite terrible. I'm not at all sure why a task that is
> genuinely not making progress and isn't killable should not be reported.

In principle it is a variation of the old problem where hung task detector
was reporting tasks that were waiting for IO to complete for too long (e.g.
if sync(2) took longer than 2 minutes or whatever the limit is set). In
this case we are waiting for IO in a cgroup to complete which has the
additional dimension that cgroup IO may be throttled so it progresses extra
slowly. But the reports of hang check firing for long running IO
disappeared quite some time ago - I have a vague recollection there were
some tweaks to it for this case but maybe I'm wrong and people just learned
to tune the hang check timer :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

