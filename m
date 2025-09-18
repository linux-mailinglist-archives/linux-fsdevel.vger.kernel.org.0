Return-Path: <linux-fsdevel+bounces-62118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B07B8467C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2315B3B8258
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02932C0F95;
	Thu, 18 Sep 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NsIOQ9dm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZggasU2L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xkWzZFbk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fEARIWCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E74244693
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196101; cv=none; b=D0nMxaUwP2RQ4sucSI0MCMH0slFdlvjWeZezVHwYU9xZn7Fakd0FbjjQS96HJwcghXceQMYus4DZbRpMGWd017SDyn0YYpKVImQeLy0POsyTvscrNzgBMlPe8r4eCOTges/rXo8xuPUzcFYhjsZqitdaSxLPj1W6CFAo12+3vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196101; c=relaxed/simple;
	bh=rarRi69eoavMUwhEZO6pAQ62R1SM9DnmB82uisdv1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il+AhZudmuH8/bLb5zVoeLn4ytKP5SQyalxKHlLUsc5BIQuXMmsujM7U51xJeqxyma1rZes0r7r1bBOfzsjNdgzUdq7Gm3Ev5Iz23VNzoDiHFqdOO+HVui5Xslulw+P/1xtd7vTvx8cxNo1wU7Xe2i1a6dbA2C0U1U7WNTFU9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NsIOQ9dm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZggasU2L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xkWzZFbk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fEARIWCP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBAD13370E;
	Thu, 18 Sep 2025 11:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758196098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMOUNhsGvHhAUf+LAQd/OeevBQv2Y/jWS09GwOJd9iM=;
	b=NsIOQ9dmZFWlj08ASM+0tOMuI4uoRfRClAIqbSviXN95afpsSEv0/k6us7ReW9EDQbMATt
	DO4pT8FNhprSDvzHqGokIQkpNkIDPwrCROySAxvUypdJUG7nowS6fJIKV+lI03hjePLg5h
	my7YP9F1oR4x0Q3UTQm5r7xSSDr3pvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758196098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMOUNhsGvHhAUf+LAQd/OeevBQv2Y/jWS09GwOJd9iM=;
	b=ZggasU2LVxHLbH3HTpFmVQH4zVMbSmnK3BQfjhGyz6PtB65oXsT7FG1Ol9eUat9Kty9Orn
	gq92C7/av8p7a2DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758196096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMOUNhsGvHhAUf+LAQd/OeevBQv2Y/jWS09GwOJd9iM=;
	b=xkWzZFbksNveYnTPRm0DcByD49XuDyxamylUpbKpu0inMYFysqgpyG0smmm6q9aoco6Rab
	wa95agUh4EP5poYjiP1I1rkJocMxNwckXcYDriQaTYSVCg3KVQGhIRyXTxLKPeM9E3nvU4
	nfsOdVzyH1/Ozc4zX+/MIS/3WekAXfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758196096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMOUNhsGvHhAUf+LAQd/OeevBQv2Y/jWS09GwOJd9iM=;
	b=fEARIWCPoiFLAGz2DBjeHMdArIdFQp8TGO5mUnjbbvWOaPJ7mWYgBEbtYOGrZPzdR/byiS
	tRVFCXVoMDw1ecDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB6D013A51;
	Thu, 18 Sep 2025 11:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sN1MMn7xy2joCgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 18 Sep 2025 11:48:14 +0000
Date: Thu, 18 Sep 2025 12:48:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org, 
	minchan@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, kernel-team@android.com, android-mm@google.com, 
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
Subject: Re: [PATCH v2 6/7] mm: add assertion for VMA count limit
Message-ID: <4n557wud5bb33jxgiale6quhnxqoqf2ykwqxv6yemmosz4uxjh@ommmu37yiuc5>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-7-kaleshsingh@google.com>
 <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linux-foundation.org:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Sep 17, 2025 at 03:44:27PM +0200, David Hildenbrand wrote:
> On 15.09.25 18:36, Kalesh Singh wrote:
> > Building on the vma_count helpers, add a VM_WARN_ON_ONCE() to detect
> > cases where the VMA count exceeds the sysctl_max_map_count limit.
> > 
> > This check will help catch future bugs or regressions where
> > the VMAs are allocated exceeding the limit.
> > 
> > The warning is placed in the main vma_count_*() helpers, while the
> > internal *_nocheck variants bypass it. _nocheck helpers are used to
> > ensure that the assertion does not trigger a false positive in
> > the legitimate case of a temporary VMA increase past the limit
> > by a VMA split in munmap().
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> > 
> > Changes in v2:
> >    - Add assertions if exceeding max_vma_count limit, per Pedro
> > 
> >   include/linux/mm.h               | 12 ++++++--
> >   mm/internal.h                    |  1 -
> >   mm/vma.c                         | 49 +++++++++++++++++++++++++-------
> >   tools/testing/vma/vma_internal.h |  7 ++++-
> >   4 files changed, 55 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 8bad1454984c..3a3749d7015c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4219,19 +4219,27 @@ static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
> >   void snapshot_page(struct page_snapshot *ps, const struct page *page);
> > +int vma_count_remaining(const struct mm_struct *mm);
> > +
> >   static inline void vma_count_init(struct mm_struct *mm)
> >   {
> >   	ACCESS_PRIVATE(mm, __vma_count) = 0;
> >   }
> > -static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> > +static inline void __vma_count_add_nocheck(struct mm_struct *mm, int nr_vmas)
> >   {
> >   	ACCESS_PRIVATE(mm, __vma_count) += nr_vmas;
> >   }
> > +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> > +{
> > +	VM_WARN_ON_ONCE(!vma_count_remaining(mm));
> 
> Can't that fire when changing the max count from user space at just the
> wrong time?
> 
> I assume we'll have to tolerated that and might just want to drop this patch
> from the series.

Ah yes, of course, userspace can dynamically change it. Good catch. I guess
we'll need to kill the assertion idea then.

-- 
Pedro

