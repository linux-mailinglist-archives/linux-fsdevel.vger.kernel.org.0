Return-Path: <linux-fsdevel+bounces-11989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D06859F74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 10:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA01F21FF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C624B2A;
	Mon, 19 Feb 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWMh6DJ/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzteuApn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhZfcUQl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8v+r0UKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C432374C;
	Mon, 19 Feb 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334260; cv=none; b=oiq98HdcZHBtOKMNkIeGm6Wc8hbK8OK8YYjgDiPfYuLkQV7L/JYtnnYSZvD+paUDwBB9OcoDQuo5ZVV5PSVddCoQs9YqcJMMXqQVEwj3Fq7USYb2YiwBx8ePij4vxXtaxsSOejVKuK9TmkWnwqu1pG29urajuX20PPodYQ0DZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334260; c=relaxed/simple;
	bh=IJlX/1YNrW4MfN2e7g/IXhlJ0tovkeaoJK+d3hUcH1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLonUzOZOWfm87L73QS8uRueM+3U3cPrY1wo8qoH08UGpEGY7KOmOq5fXrcvrhqmzKLE+lNYKGQMA3gSOkwGB6CMN8kIdLcdV93JXP/5DoNLKzcKbaz6ietyrvdbcDD66mrIBRS98YujEMC4xPUAVLXNq2HL7ISjKDuiWLilc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWMh6DJ/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzteuApn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhZfcUQl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8v+r0UKC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD65221EBE;
	Mon, 19 Feb 2024 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708334256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIC/a+gVDD7XPQtjCAkXOILzScqhk7P47GEkxD0UDQs=;
	b=MWMh6DJ/ibVstvW8CHhxalEdn+EfDp2Pp6CLtUS7w2G8aKm80u24jjbaqFlFeJq3lsm9Ch
	zmZU9F9fWuq1aSYZnzyc2Nr6Wh+ESMVZCBy+st8OYiqW4rLl90iwbWjzdnPcA6cBBX1juT
	wQ7oin3joQHdQCFUzFj+7IJwYO/35a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708334256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIC/a+gVDD7XPQtjCAkXOILzScqhk7P47GEkxD0UDQs=;
	b=GzteuApnghPs8TtGI0ScLwvh9hL/i4LonLgBBl+wck2XX6f4rm3q0fbvXB4+6HxOzNxgPu
	qyCzH5DeLqoEgEBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708334254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIC/a+gVDD7XPQtjCAkXOILzScqhk7P47GEkxD0UDQs=;
	b=nhZfcUQlK7pH0NXDM7sv2fYcGG6ZDiDb66Gs3exRJKPJtn1oKKXZk7O+L9mcFpHEICfrnI
	AaunILK2z67g4pS3/czle2C8GcshxFhiA/5Fdd7m6L0ODF+AijttNP+JrMY5ZWs86XQc47
	L4h7iwvt+dm0nWThHKdQsKNIJzn5kPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708334254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIC/a+gVDD7XPQtjCAkXOILzScqhk7P47GEkxD0UDQs=;
	b=8v+r0UKCTIoGKIjYstbF4ma5EEhXx29Kjd7rwRP4H+96aLGc+a6L9kcHVm8j614GlmUDPP
	qNjxnGR/35wREXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18E5713647;
	Mon, 19 Feb 2024 09:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gyquBa4c02VrEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Feb 2024 09:17:34 +0000
Message-ID: <5bd3761f-217d-45bb-bcd2-797f82c8a44f@suse.cz>
Date: Mon, 19 Feb 2024 10:17:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/35] codetag: debug: skip objext checking when it's
 for objext itself
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
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
 <20240212213922.783301-33-surenb@google.com>
 <f0a56027-472d-44a6-aba5-912bd50ee3ae@suse.cz>
 <CAJuCfpGUTu7uhcR-23=0d3Wnn8ZbDtNwTaFnukd9qYYVHS9aSA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGUTu7uhcR-23=0d3Wnn8ZbDtNwTaFnukd9qYYVHS9aSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nhZfcUQl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8v+r0UKC
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: AD65221EBE
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/19/24 02:04, Suren Baghdasaryan wrote:
> On Fri, Feb 16, 2024 at 6:39 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 2/12/24 22:39, Suren Baghdasaryan wrote:
>> > objext objects are created with __GFP_NO_OBJ_EXT flag and therefore have
>> > no corresponding objext themselves (otherwise we would get an infinite
>> > recursion). When freeing these objects their codetag will be empty and
>> > when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to false
>> > warnings. Introduce CODETAG_EMPTY special codetag value to mark
>> > allocations which intentionally lack codetag to avoid these warnings.
>> > Set objext codetags to CODETAG_EMPTY before freeing to indicate that
>> > the codetag is expected to be empty.
>> >
>> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> > ---
>> >  include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
>> >  mm/slab.h                 | 25 +++++++++++++++++++++++++
>> >  mm/slab_common.c          |  1 +
>> >  mm/slub.c                 |  8 ++++++++
>> >  4 files changed, 60 insertions(+)
>> >
>> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
>> > index 0a5973c4ad77..1f3207097b03 100644
>>
>> ...
>>
>> > index c4bd0d5348cb..cf332a839bf4 100644
>> > --- a/mm/slab.h
>> > +++ b/mm/slab.h
>> > @@ -567,6 +567,31 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>> >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>> >                       gfp_t gfp, bool new_slab);
>> >
>> > +
>> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
>> > +
>> > +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>> > +{
>> > +     struct slabobj_ext *slab_exts;
>> > +     struct slab *obj_exts_slab;
>> > +
>> > +     obj_exts_slab = virt_to_slab(obj_exts);
>> > +     slab_exts = slab_obj_exts(obj_exts_slab);
>> > +     if (slab_exts) {
>> > +             unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
>> > +                                              obj_exts_slab, obj_exts);
>> > +             /* codetag should be NULL */
>> > +             WARN_ON(slab_exts[offs].ref.ct);
>> > +             set_codetag_empty(&slab_exts[offs].ref);
>> > +     }
>> > +}
>> > +
>> > +#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>> > +
>> > +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
>> > +
>> > +#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>> > +
>>
>> I assume with alloc_slab_obj_exts() moved to slub.c, mark_objexts_empty()
>> could move there too.
> 
> No, I think mark_objexts_empty() belongs here. This patch introduced
> the function and uses it. Makes sense to me to keep it all together.

Hi,

here I didn't mean moving between patches, but files. alloc_slab_obj_exts()
in slub.c means all callers of mark_objexts_empty() are in slub.c so it
doesn't need to be in slab.h

Also same thing with mark_failed_objexts_alloc() and
handle_failed_objexts_alloc() in patch 34/35.


