Return-Path: <linux-fsdevel+bounces-11732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D088569D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C731C239F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D543113665E;
	Thu, 15 Feb 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G2VUrmve";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CaMgsam2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95516135A40;
	Thu, 15 Feb 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015509; cv=none; b=ARj/QcG0jJ4E9w4GHP7j2mdMiTjNw49NuVdhLECXsHze+Ep+Jcfib/+fz5cgvpJrzn1zSx4BkfYFmMFDmIRXi2Iv+PJpibuV6/zlT40Heq86G9GperFPfOfpT62S/8zXUSZodjvqV6eO1J3WHogcvvl1dYG9z0aLPOCxDRGZtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015509; c=relaxed/simple;
	bh=dhI2UYB4aZIMTpkPZ7wbc9Q1Ft64yp0o85zXW/dWLZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4x6W0hDfWKG6mM3eE6si/imwsXto99jhTcT/4MWSsVAi9in5zLAV03V4MNpyPl8oiMH7BPOMT3cRTTmrOEPlp9HhZkQKYlUmfoW+OigrFhHYW/Eg4dzSHxFIynkMUGAWbr1SRgCdIL1xAFQ3f0jXefxffq/AJzD66fM2KHenh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G2VUrmve; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CaMgsam2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DEFE1F8BF;
	Thu, 15 Feb 2024 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708015503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRHpwz0jmcW35D6Wb8el2YM1B2vf23RXP7/FUXCRfsQ=;
	b=G2VUrmvezAJDdL1bvOsw0AVvncGfh7BJpd88nRO1U3Sffr4ODpgmfexpnmj40SUq7oeG/8
	dqPynMGycM85bT6H3wTJMoVnhXGce8fOr0FDrPpOmQiphkR595nt5zURkfLOQa0PgGJddy
	TxKsTcmPRy9XpYBzA3ytF9ETrah3a5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708015501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRHpwz0jmcW35D6Wb8el2YM1B2vf23RXP7/FUXCRfsQ=;
	b=CaMgsam2Wq0Sy+5TGkRRdIpU+51MJ1joWXAnMU4Z8NDpef4JgM7ikKEDU4+rmgELUx2ZkA
	pLcSLScJMrI4nuAL18Vs20cwDFykqhko9Df1IlPJOLmdfUrYyjhItpCmzm3G12Jg+p2ukW
	1WjmqNlWOosKrYvpCgIB3qAozJT1Ymk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C44713A53;
	Thu, 15 Feb 2024 16:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8HpaEo0/zmW6CQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 15 Feb 2024 16:45:01 +0000
Date: Thu, 15 Feb 2024 17:44:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz,
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
Message-ID: <Zc4_i_ED6qjGDmhR@tiehlicka>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CaMgsam2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[27.68%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,suse.cz,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 7DEFE1F8BF
X-Spam-Flag: NO

On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> On Thu, Feb 15, 2024 at 1:22 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > [...]
> > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> > >  #ifdef CONFIG_MEMORY_FAILURE
> > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> > >  #endif
> > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > +     {
> > > +             struct seq_buf s;
> > > +             char *buf = kmalloc(4096, GFP_ATOMIC);
> > > +
> > > +             if (buf) {
> > > +                     printk("Memory allocations:\n");
> > > +                     seq_buf_init(&s, buf, 4096);
> > > +                     alloc_tags_show_mem_report(&s);
> > > +                     printk("%s", buf);
> > > +                     kfree(buf);
> > > +             }
> > > +     }
> > > +#endif
> >
> > I am pretty sure I have already objected to this. Memory allocations in
> > the oom path are simply no go unless there is absolutely no other way
> > around that. In this case the buffer could be preallocated.
> 
> Good point. We will change this to a smaller buffer allocated on the
> stack and will print records one-by-one. Thanks!

__show_mem could be called with a very deep call chains. A single
pre-allocated buffer should just do ok.

-- 
Michal Hocko
SUSE Labs

