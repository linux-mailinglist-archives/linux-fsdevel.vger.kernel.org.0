Return-Path: <linux-fsdevel+bounces-62116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D642B84617
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121E0623BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7263043DA;
	Thu, 18 Sep 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yAbG/z53";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wEOWNzPt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yAbG/z53";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wEOWNzPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83582FB603
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195544; cv=none; b=CkNU/xJ5jxYblg6F/DLkDGxz+HwA4TosCx78HaAH1xtsFY07GzyYSlfXW4jALvrzx8e/obQFCXuXVMVmiY70scUL/DFcewYy1kj6arwLLpj1/Ddr6W5l9oO8KFq7EDev69lqPvi2Z93q4G6tDztsgTOrgWik2Gq0K0iTZ1fiDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195544; c=relaxed/simple;
	bh=FiCYTYBmBwByIybftqCSpMtDVDCIhnvrAqqcqSn93Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4dNnz+O53MRllj+Unc4/8E92LUtY6I5vlhv8vKa/WQiy02Cxp26tXzrYw0xYMN58vDgKSk6zQiHGyqwmYmu8cLAB6B/a1c587neJt0B75ek4bN+MWwMy5msvHZ3IjMY5BQi23hM8ML1cW/3gSB+0iJBSVAP04B0jyVW4SNJ25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yAbG/z53; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEOWNzPt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yAbG/z53; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEOWNzPt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA3D31F393;
	Thu, 18 Sep 2025 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758195540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXXknVDpmNYnLUtM1qz0zJi5d3AHN3Yxt2BrVK20pvY=;
	b=yAbG/z53WbruUxX/3ies41/VNu2qWdBGFLaPMVRN80Cqe+oNynqfJXnyf+t56Cx0mM2SdW
	+RVPmSGF6YFbQCt9A4UJ5/Jc4haI1+n43JilnK3sGxohsgBrAS2Jw3Ki3js3oL6P4rR15/
	f5tG+7EqBS5TJH4OmQlCKzmqFbTeoe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758195540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXXknVDpmNYnLUtM1qz0zJi5d3AHN3Yxt2BrVK20pvY=;
	b=wEOWNzPth5hUlnK6FcdpsFJbnSHl9DOJAzXfjeo/GAewIY/wgz1P66A196GZT8LOd2sBZM
	mNY8RzOOf0aePvAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758195540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXXknVDpmNYnLUtM1qz0zJi5d3AHN3Yxt2BrVK20pvY=;
	b=yAbG/z53WbruUxX/3ies41/VNu2qWdBGFLaPMVRN80Cqe+oNynqfJXnyf+t56Cx0mM2SdW
	+RVPmSGF6YFbQCt9A4UJ5/Jc4haI1+n43JilnK3sGxohsgBrAS2Jw3Ki3js3oL6P4rR15/
	f5tG+7EqBS5TJH4OmQlCKzmqFbTeoe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758195540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXXknVDpmNYnLUtM1qz0zJi5d3AHN3Yxt2BrVK20pvY=;
	b=wEOWNzPth5hUlnK6FcdpsFJbnSHl9DOJAzXfjeo/GAewIY/wgz1P66A196GZT8LOd2sBZM
	mNY8RzOOf0aePvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B186F13A51;
	Thu, 18 Sep 2025 11:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id luEtKFLvy2i6BwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 18 Sep 2025 11:38:58 +0000
Date: Thu, 18 Sep 2025 12:38:56 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org, 
	minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded
 trace event
Message-ID: <6x64jf7szyy52gug6qoixhhjq6vsrcqpozqj4ambsehh2jprj2@qeye6qevem4g>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com>
 <20250915194158.472edea5@gandalf.local.home>
 <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
 <20250916115220.4a90c745@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916115220.4a90c745@batman.local.home>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtinr53e731m8tnofz4ju9k8y)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue, Sep 16, 2025 at 11:52:20AM -0400, Steven Rostedt wrote:
> On Mon, 15 Sep 2025 18:19:53 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
> 
> 
> > Hi Steve,
> > 
> > Thanks for the comments and suggestion you are right we can use bpf to
> > get the comm. There is nothing special about this trace event.  I will
> > drop comm in the next revision.
> > 
> > The reason I did the task_struct parameter (current): I believe there
> > is a limitation that we must  specify at least 1 parameter to the
> > TRACE_EVENT()  PROTO and ARGS macros.
> 
> OK, then this is another issue. We don't want tracepoint "markers".
> Each tracepoint can take up to 5K in memory due to the code it
> generates and the meta data to control it.
> 
> For something like that, we highly recommend dynamic probes (fprobes,
> kprobes, etc).
> 
> The only purpose of a static tracepoint is to get data within a
> function that is too difficult to get via a probe. It should never be
> used as a trigger where its purpose is "we hit this path".
>

Isn't the usual problem with that approach, that of static functions/static
inline functions? I was tracing through a problem a few months ago, and man
I really did think "wouldn't it be nice to have a tracepoint instead of fishing
around for kprobe spots".

Not that I particularly think a tracepoint is super worth it in this case, but,
y'know.

-- 
Pedro

