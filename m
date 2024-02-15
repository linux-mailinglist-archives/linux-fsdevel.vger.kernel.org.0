Return-Path: <linux-fsdevel+bounces-11767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55278856F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886901C21ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11B41420D2;
	Thu, 15 Feb 2024 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XEuIaBAO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XEuIaBAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15B13F006;
	Thu, 15 Feb 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034102; cv=none; b=cBj7xjeFX0CnaRmLo5+GMu814IteGRvAbFFAmyxA5v/sdHC9G/2mVdWmxWVwNovDFNwcr+TT6AFc3XT5N29EZoowDvlXIc0ps0q7nRZz6Nx3oTdtvdJYqPdVMy3uiD7piwKTRsn3rvKwC1f/cN8Vtu8s81h1m/n3sYegrxpFwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034102; c=relaxed/simple;
	bh=EB3SfacV8ivD3eAhKkH8T1nctItZs4WuWtn0yuuD5oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERMyOzAoHeyB7sZ8mBHak1f2Qe4Acir//PxV+OVOLTvuICh1rBWB4TaSDDr2SBbbnAyHkxuVPfslvb5oi2r73hhs4BZOwDawvLxqR1cSM167Tly291JhIGU6MC38N9+mTq0g92NU0wrFpmcXuyhIhXGV05lFQeggRF/luN0VsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XEuIaBAO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XEuIaBAO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6268E1FB3E;
	Thu, 15 Feb 2024 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708034098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78B4kvvPSh8JDp9MHEmUxKS9HotTbXRsyldcw+EPHkU=;
	b=XEuIaBAOxeePupxKYra105qK2slJRCLUXGOEKQ/xnXZZAwW+48by16u68ar6eWKoaSYpjc
	Tn/7hEvXdWLkIhptV62iov5EAoxylOrXOVNApwCagldQRDJOnig0gYDPyKJkkVw/yS/2ue
	VFnq+zX2B3UORW2oSne33WmHN03TH+E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708034098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78B4kvvPSh8JDp9MHEmUxKS9HotTbXRsyldcw+EPHkU=;
	b=XEuIaBAOxeePupxKYra105qK2slJRCLUXGOEKQ/xnXZZAwW+48by16u68ar6eWKoaSYpjc
	Tn/7hEvXdWLkIhptV62iov5EAoxylOrXOVNApwCagldQRDJOnig0gYDPyKJkkVw/yS/2ue
	VFnq+zX2B3UORW2oSne33WmHN03TH+E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38FD213A82;
	Thu, 15 Feb 2024 21:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QXBuDTKIzmWKTwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 15 Feb 2024 21:54:58 +0000
Date: Thu, 15 Feb 2024 22:54:53 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <Zc6ILbveSQvDtayj@tiehlicka>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XEuIaBAO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,google.com,linux-foundation.org,cmpxchg.org,linux.dev,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 6268E1FB3E
X-Spam-Flag: NO

On Thu 15-02-24 15:33:30, Kent Overstreet wrote:
> On Thu, Feb 15, 2024 at 09:22:07PM +0100, Vlastimil Babka wrote:
> > On 2/15/24 19:29, Kent Overstreet wrote:
> > > On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
> > >> On Thu, Feb 15, 2024 at 8:45 AM Michal Hocko <mhocko@suse.com> wrote:
> > >> >
> > >> > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > >> > > On Thu, Feb 15, 2024 at 1:22 AM Michal Hocko <mhocko@suse.com> wrote:
> > >> > > >
> > >> > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > >> > > > [...]
> > >> > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> > >> > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > >> > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> > >> > > > >  #endif
> > >> > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > >> > > > > +     {
> > >> > > > > +             struct seq_buf s;
> > >> > > > > +             char *buf = kmalloc(4096, GFP_ATOMIC);
> > >> > > > > +
> > >> > > > > +             if (buf) {
> > >> > > > > +                     printk("Memory allocations:\n");
> > >> > > > > +                     seq_buf_init(&s, buf, 4096);
> > >> > > > > +                     alloc_tags_show_mem_report(&s);
> > >> > > > > +                     printk("%s", buf);
> > >> > > > > +                     kfree(buf);
> > >> > > > > +             }
> > >> > > > > +     }
> > >> > > > > +#endif
> > >> > > >
> > >> > > > I am pretty sure I have already objected to this. Memory allocations in
> > >> > > > the oom path are simply no go unless there is absolutely no other way
> > >> > > > around that. In this case the buffer could be preallocated.
> > >> > >
> > >> > > Good point. We will change this to a smaller buffer allocated on the
> > >> > > stack and will print records one-by-one. Thanks!
> > >> >
> > >> > __show_mem could be called with a very deep call chains. A single
> > >> > pre-allocated buffer should just do ok.
> > >> 
> > >> Ack. Will do.
> > > 
> > > No, we're not going to permanently burn 4k here.
> > > 
> > > It's completely fine if the allocation fails, there's nothing "unsafe"
> > > about doing a GFP_ATOMIC allocation here.
> > 
> > Well, I think without __GFP_NOWARN it will cause a warning and thus
> > recursion into __show_mem(), potentially infinite? Which is of course
> > trivial to fix, but I'd myself rather sacrifice a bit of memory to get this
> > potentially very useful output, if I enabled the profiling. The necessary
> > memory overhead of page_ext and slabobj_ext makes the printing buffer
> > overhead negligible in comparison?
> 
> __GFP_NOWARN is a good point, we should have that.
> 
> But - and correct me if I'm wrong here - doesn't an OOM kick in well
> before GFP_ATOMIC 4k allocations are failing?

Not really, GFP_ATOMIC users can compete with reclaimers and consume
those reserves.

> I'd expect the system to
> be well and truly hosed at that point.

It is OOMed...
 
> If we want this report to be 100% reliable, then yes the preallocated
> buffer makes sense - but I don't think 100% makes sense here; I think we
> can accept ~99% and give back that 4k.

Think about that from the memory reserves consumers. The atomic reserve
is a scarse resource and now you want to use it for debugging purposes
for which you could have preallocated.
-- 
Michal Hocko
SUSE Labs

