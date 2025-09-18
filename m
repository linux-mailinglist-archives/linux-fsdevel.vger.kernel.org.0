Return-Path: <linux-fsdevel+bounces-62115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82CEB845DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E364A2E96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07385303A06;
	Thu, 18 Sep 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lhdT2L1t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RiyRI2no";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mZ/uXFCm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F4mpeiMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F62F6189
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195104; cv=none; b=AetmHIm4rqQUbRHwp77d7aSo1dE0gtZdwsrV6YVsk2RvE2ZZvTWankZQwLQCCjXGWlOFtAL/505YrlTZskdg0lWHFpvlBTlYDXqSCLjDh+RAsDMcavk0J22bZuYYh7DyinYQY/KHtyuE6IlJ3KiroRhDChCSA/YdjwDkLaC5N5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195104; c=relaxed/simple;
	bh=MLl6OKx32oF/mUyZeLnKIVTtA/C1JJP+sSJUZhdTOM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGvTpshiz/S4kApePYhHxgM1IXeHC3dCnXFSKPtIA6b+jVQqQR+Hwj0d1o5rk/01wAPvsuH6/v3saHYJT19m4SqCqxleec2USdDStKT7Z1HWvRjkU1o0sBPdEjIPmtMpfErAPvnl47rTfbjQnqE9gxNf2ZWwjbSgXzPPFB44JCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lhdT2L1t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RiyRI2no; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mZ/uXFCm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F4mpeiMA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AE0233791;
	Thu, 18 Sep 2025 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758195099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0jk5pHWcSpilbLxJaV/z4FUuxkpZfccsNZuNA2Q9Bo=;
	b=lhdT2L1tZ/eU01dAvv55m+bCEsqSXn9IA/5PI3U3FxpNs0aIVG5VXdU/1hy0iSeEN7Pw79
	Bofhd8h+Lu/NUDQgTx+DFJ2rfruf0Ez7PC6X5J22of1d6Wb9cAQUAzeg5iFC2cXxYAzxBy
	JAGOlD4SlPjr6tEiifhJG8ab/O4KClw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758195099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0jk5pHWcSpilbLxJaV/z4FUuxkpZfccsNZuNA2Q9Bo=;
	b=RiyRI2nob+MF0STXidJ4xVHvz+Hvs6a7btnXjChpqptOZmH1OMRuQau6ztX6QilOsI19tM
	mWjgrlV4vqR3/4AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mZ/uXFCm";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F4mpeiMA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758195098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0jk5pHWcSpilbLxJaV/z4FUuxkpZfccsNZuNA2Q9Bo=;
	b=mZ/uXFCm/LcB68G+Pulz+vmUd3OkOcAShB69OktBNN3CDzNOUlingOy/CvYD7qdUPgI1pD
	SIT86IppWhAFXzD3Adv0o6HXgCYSPrRAOiK85uI5+GizLBu7dT+PSMZDf/D257u/Ah4LNl
	j2rcNCxlLRaGLIFjVQ9W0ZkBFdbN/vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758195098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0jk5pHWcSpilbLxJaV/z4FUuxkpZfccsNZuNA2Q9Bo=;
	b=F4mpeiMAiFwgKtIBR86KL8f7OjWr7aG5rnz8aOXCA4LWMC1X5SXu1uiugKiTYOreT33gH6
	4P4VfZBx5MQ+j7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80F0C13A51;
	Thu, 18 Sep 2025 11:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r3swHJjty2gJBQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 18 Sep 2025 11:31:36 +0000
Date: Thu, 18 Sep 2025 12:31:30 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, 
	lorenzo.stoakes@oracle.com, david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
Message-ID: <zol3d77dnwgrkbwc7lui3qm2mkwqftzifr6gn7smtbg4jo4bte@y4dzwfvt2xtj>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-2-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-2-kaleshsingh@google.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8AE0233791
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLg31yqq1xypujqsbh8raoa6zf)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:dkim,suse.de:email]
X-Spam-Score: -4.01

On Mon, Sep 15, 2025 at 09:36:32AM -0700, Kalesh Singh wrote:
> The VMA count limit check in do_mmap() and do_brk_flags() uses a
> strict inequality (>), which allows a process's VMA count to exceed
> the configured sysctl_max_map_count limit by one.
> 
> A process with mm->map_count == sysctl_max_map_count will incorrectly
> pass this check and then exceed the limit upon allocation of a new VMA
> when its map_count is incremented.
> 
> Other VMA allocation paths, such as split_vma(), already use the
> correct, inclusive (>=) comparison.
> 
> Fix this bug by changing the comparison to be inclusive in do_mmap()
> and do_brk_flags(), bringing them in line with the correct behavior
> of other allocation paths.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>


Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

