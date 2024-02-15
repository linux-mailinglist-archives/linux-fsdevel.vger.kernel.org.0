Return-Path: <linux-fsdevel+bounces-11752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9AD856E7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F53AB2576A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 20:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00213AA56;
	Thu, 15 Feb 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fyDN9U4/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BwTk6WcO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fyDN9U4/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BwTk6WcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6D13959C;
	Thu, 15 Feb 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028533; cv=none; b=SguGoVOY9E966DcDO97S1ZFye61gncC08R6Pihx8gOv4k9iEdyi4BoiapVjvNGv2zCebbHt2BVoIJLbJS+nCgtyJyF1OCLmPd6Bfc+eOLfEhSKqRFAU6BLUNX0jb6Ka/JLaHqPSTyK1qYtNsmiwQep4dOYFy1wsNKlc+kGrEwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028533; c=relaxed/simple;
	bh=1sAlfiUyLqC/42u5WdlSFvGKZdqnhnY/hW80I5Hne0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuxFqUnrAiuR6gsF0470lijGAWEUu6vbcc5A31siKFa4t0zEwhLvzUN15L/LmJ01A6niXE9ZbekW6ECtOxK8qWjx1by8cE+X2VxxMD5IBUoBlSZJojTCOVOWd379PX7IOhKKld9oN5oZWDpwIYHVilFaMGHKuesCMBzPzF63FZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fyDN9U4/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BwTk6WcO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fyDN9U4/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BwTk6WcO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BFFF1F8D9;
	Thu, 15 Feb 2024 20:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708028529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PvwLOkhLs20C3GH06d6BicWz8S2K2wPQ3EkGdP8tjQ=;
	b=fyDN9U4/AWiJg7n/Ot+hmcJ3eO/iy+4wR8VghNMMsaZEFyvOfaPkOvOVvDq2I457tMO7lt
	EzYnQ3Rs+Bb+39he43kxtsDka1L2HfiA94nnBcCxPkk/NdR78i6EI+4qinR2XKjVSOuA0c
	59rJ9CmZHRVQj1vVOW/91YcW/TsmXfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708028529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PvwLOkhLs20C3GH06d6BicWz8S2K2wPQ3EkGdP8tjQ=;
	b=BwTk6WcO2bzcQNWckWXoRwyXeoTj9pDbrBgoFK2MBYXpW/4jyFifpgxKiK3ENRMnx+A4Qv
	Swr43Y+7PhBXo+Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708028529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PvwLOkhLs20C3GH06d6BicWz8S2K2wPQ3EkGdP8tjQ=;
	b=fyDN9U4/AWiJg7n/Ot+hmcJ3eO/iy+4wR8VghNMMsaZEFyvOfaPkOvOVvDq2I457tMO7lt
	EzYnQ3Rs+Bb+39he43kxtsDka1L2HfiA94nnBcCxPkk/NdR78i6EI+4qinR2XKjVSOuA0c
	59rJ9CmZHRVQj1vVOW/91YcW/TsmXfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708028529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PvwLOkhLs20C3GH06d6BicWz8S2K2wPQ3EkGdP8tjQ=;
	b=BwTk6WcO2bzcQNWckWXoRwyXeoTj9pDbrBgoFK2MBYXpW/4jyFifpgxKiK3ENRMnx+A4Qv
	Swr43Y+7PhBXo+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6778A13A82;
	Thu, 15 Feb 2024 20:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ufzF3ByzmWgOwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 20:22:08 +0000
Message-ID: <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
Date: Thu, 15 Feb 2024 21:22:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com> <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.976];
	 RCPT_COUNT_GT_50(0.00)[73];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,linux-foundation.org,cmpxchg.org,linux.dev,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/15/24 19:29, Kent Overstreet wrote:
> On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
>> On Thu, Feb 15, 2024 at 8:45 AM Michal Hocko <mhocko@suse.com> wrote:
>> >
>> > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
>> > > On Thu, Feb 15, 2024 at 1:22 AM Michal Hocko <mhocko@suse.com> wrote:
>> > > >
>> > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
>> > > > [...]
>> > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>> > > > >  #ifdef CONFIG_MEMORY_FAILURE
>> > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>> > > > >  #endif
>> > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
>> > > > > +     {
>> > > > > +             struct seq_buf s;
>> > > > > +             char *buf = kmalloc(4096, GFP_ATOMIC);
>> > > > > +
>> > > > > +             if (buf) {
>> > > > > +                     printk("Memory allocations:\n");
>> > > > > +                     seq_buf_init(&s, buf, 4096);
>> > > > > +                     alloc_tags_show_mem_report(&s);
>> > > > > +                     printk("%s", buf);
>> > > > > +                     kfree(buf);
>> > > > > +             }
>> > > > > +     }
>> > > > > +#endif
>> > > >
>> > > > I am pretty sure I have already objected to this. Memory allocations in
>> > > > the oom path are simply no go unless there is absolutely no other way
>> > > > around that. In this case the buffer could be preallocated.
>> > >
>> > > Good point. We will change this to a smaller buffer allocated on the
>> > > stack and will print records one-by-one. Thanks!
>> >
>> > __show_mem could be called with a very deep call chains. A single
>> > pre-allocated buffer should just do ok.
>> 
>> Ack. Will do.
> 
> No, we're not going to permanently burn 4k here.
> 
> It's completely fine if the allocation fails, there's nothing "unsafe"
> about doing a GFP_ATOMIC allocation here.

Well, I think without __GFP_NOWARN it will cause a warning and thus
recursion into __show_mem(), potentially infinite? Which is of course
trivial to fix, but I'd myself rather sacrifice a bit of memory to get this
potentially very useful output, if I enabled the profiling. The necessary
memory overhead of page_ext and slabobj_ext makes the printing buffer
overhead negligible in comparison?

