Return-Path: <linux-fsdevel+bounces-14487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B7C87D180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD36B22EF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B6481A4;
	Fri, 15 Mar 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIVcH5dt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9OBHnLK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIVcH5dt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9OBHnLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDB46544;
	Fri, 15 Mar 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521575; cv=none; b=ekl6km9mc+d/CQr3EvYS8POoBOd9UKdB3UyIIPueAt6lCwLKksGJRgDSysHVXRMidM14dNd3kIiukjJoPfJVBEYnm8tuRkKsT2eGbJQlXAIHMUqbSpsQLrt+FVfo3g7cM+aebkyKAO4KUyu3aYM4oa09yf2uPCuWVswf48poiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521575; c=relaxed/simple;
	bh=GymzEVzWnJExJHnhAe7WBPtD33yCrqjQV+HKZXGqHkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVnZLBY3h0H5BZvvrvLosR3UZLbDT6Ev68GW3W1yQRU0WIyasNQni1AB8AMb6S0jAJWX2Vf7nddDgl0VYoUmftZczVOeZxk8NbKFULHg0z04kbJhxrjrfY5rmJlVCFLiY19QkYneIZYR4olp0HtX6bLwzjIb7Z0Ts3LhAmwqpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIVcH5dt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9OBHnLK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIVcH5dt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9OBHnLK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30C061FB77;
	Fri, 15 Mar 2024 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710521571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4ELQ8jx6kpMYkwxWHw4XIu0o8oKQ+ttZ5iD5/+0aoI=;
	b=GIVcH5dtOURRjsdtUmCD+8IDbDFZfndkzp834onReclyzr3ZSsGzmKoG48Q3RIstX5UoFO
	EzKBDq+9pMXna3n4ZEBof828Uw6Dsb9kv4FwJRm/OVnxA+xXwas3cGxIxx2NiCfRTgWRUc
	1t6fi4yhOmG1E7l7RXRD/lGQuIcIduM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710521571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4ELQ8jx6kpMYkwxWHw4XIu0o8oKQ+ttZ5iD5/+0aoI=;
	b=v9OBHnLKouzjKpvvHgKihPfEoR5Q62+JbhEIKayzSwUE6wLlA2eYmYRzKueSggUnWW2ior
	OKON2/VpvyuA/JCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710521571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4ELQ8jx6kpMYkwxWHw4XIu0o8oKQ+ttZ5iD5/+0aoI=;
	b=GIVcH5dtOURRjsdtUmCD+8IDbDFZfndkzp834onReclyzr3ZSsGzmKoG48Q3RIstX5UoFO
	EzKBDq+9pMXna3n4ZEBof828Uw6Dsb9kv4FwJRm/OVnxA+xXwas3cGxIxx2NiCfRTgWRUc
	1t6fi4yhOmG1E7l7RXRD/lGQuIcIduM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710521571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4ELQ8jx6kpMYkwxWHw4XIu0o8oKQ+ttZ5iD5/+0aoI=;
	b=v9OBHnLKouzjKpvvHgKihPfEoR5Q62+JbhEIKayzSwUE6wLlA2eYmYRzKueSggUnWW2ior
	OKON2/VpvyuA/JCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92B6B1368C;
	Fri, 15 Mar 2024 16:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o1p9I+J89GVLbwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Mar 2024 16:52:50 +0000
Message-ID: <e6e96b64-01b1-4e23-bb0b-45438f9a6cc4@suse.cz>
Date: Fri, 15 Mar 2024 17:52:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/37] mm/slab: add allocation accounting into slab
 allocation and free paths
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 aliceryhl@google.com, rientjes@google.com, minchan@google.com,
 kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-24-surenb@google.com>
 <1f51ffe8-e5b9-460f-815e-50e3a81c57bf@suse.cz>
 <CAJuCfpE5mCXiGLHTm1a8PwLXrokexx9=QrrRF4fWVosTh5Q7BA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpE5mCXiGLHTm1a8PwLXrokexx9=QrrRF4fWVosTh5Q7BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GIVcH5dt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v9OBHnLK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[76];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,nvidia.com,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 30C061FB77
X-Spam-Flag: NO

On 3/15/24 16:43, Suren Baghdasaryan wrote:
> On Fri, Mar 15, 2024 at 3:58 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 3/6/24 19:24, Suren Baghdasaryan wrote:
>> > Account slab allocations using codetag reference embedded into slabobj_ext.
>> >
>> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
>> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> Nit below:
>>
>> > @@ -3833,6 +3913,7 @@ void slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
>> >                         unsigned int orig_size)
>> >  {
>> >       unsigned int zero_size = s->object_size;
>> > +     struct slabobj_ext *obj_exts;
>> >       bool kasan_init = init;
>> >       size_t i;
>> >       gfp_t init_flags = flags & gfp_allowed_mask;
>> > @@ -3875,6 +3956,12 @@ void slab_post_alloc_hook(struct kmem_cache *s,        struct obj_cgroup *objcg,
>> >               kmemleak_alloc_recursive(p[i], s->object_size, 1,
>> >                                        s->flags, init_flags);
>> >               kmsan_slab_alloc(s, p[i], init_flags);
>> > +             obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
>> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
>> > +             /* obj_exts can be allocated for other reasons */
>> > +             if (likely(obj_exts) && mem_alloc_profiling_enabled())

Could you at least flip these two checks then so the static key one goes first?

>> > +                     alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
>> > +#endif
>>
>> I think you could still do this a bit better:
>>
>> Check mem_alloc_profiling_enabled() once before the whole block calling
>> prepare_slab_obj_exts_hook() and alloc_tag_add()
>> Remove need_slab_obj_ext() check from prepare_slab_obj_exts_hook()
> 
> Agree about checking mem_alloc_profiling_enabled() early and one time,
> except I would like to use need_slab_obj_ext() instead of
> mem_alloc_profiling_enabled() for that check. Currently they are
> equivalent but if there are more slab_obj_ext users in the future then
> there will be cases when we need to prepare_slab_obj_exts_hook() even
> when mem_alloc_profiling_enabled()==false. need_slab_obj_ext() will be
> easy to extend for such cases.

I thought we don't generally future-proof internal implementation details
like this until it's actually needed. But at least what I suggested above
would help, thanks.

> Thanks,
> Suren.
> 
>>
>> >       }
>> >
>> >       memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
>> > @@ -4353,6 +4440,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>> >              unsigned long addr)
>> >  {
>> >       memcg_slab_free_hook(s, slab, &object, 1);
>> > +     alloc_tagging_slab_free_hook(s, slab, &object, 1);
>> >
>> >       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>> >               do_slab_free(s, slab, object, object, 1, addr);
>> > @@ -4363,6 +4451,7 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
>> >                   void *tail, void **p, int cnt, unsigned long addr)
>> >  {
>> >       memcg_slab_free_hook(s, slab, p, cnt);
>> > +     alloc_tagging_slab_free_hook(s, slab, p, cnt);
>> >       /*
>> >        * With KASAN enabled slab_free_freelist_hook modifies the freelist
>> >        * to remove objects, whose reuse must be delayed.
>>


