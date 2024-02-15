Return-Path: <linux-fsdevel+bounces-11765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA4856F8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC231C21C1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E11420A8;
	Thu, 15 Feb 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Edmgj46n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyfgUjX1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dt8snzWR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fMBcDkXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF76A349;
	Thu, 15 Feb 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033843; cv=none; b=g7W9zGlNXcvwdO6qF9Fvyk7EOTMcOmgOtp6Ce7C0LYtQ2uYY0GHWgXQ+FFCBClYZlqhFSPtXG49DjwZGQpS8Cu28TnhScQqibPYxR4HYPR8+6YPRvNXKrr8ekTkx2xhOsZKRkTpziitsDtA2YbJnxT1hxzMc2Qo1zRgYQAvIE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033843; c=relaxed/simple;
	bh=M5gdYQ4piUl+0+Cj4QZUYsVYsHtsk558gXiu5u6jrOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbdUFqUJEKhQI/fowwdyoyfjJVgK+htHagwWT9JfXCs0+VZUxTWpUMprHDSZXZabyp88fLzZ38/M8Bp4lPRLDC2jIOzrSm/ZRyS4dLodrgpqcBkqtAL7zg2MnVlnnxIsYT0LRACpspgs+iQpSZFbooDgZKIC9Z//fcDycVNM6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Edmgj46n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyfgUjX1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dt8snzWR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fMBcDkXf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4D9C22056;
	Thu, 15 Feb 2024 21:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708033838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV2jhmuXtgna00Xa5XigbZslr56lI5Yx29VeaYM+7Zs=;
	b=Edmgj46nkQwX4hkEiqNNmlqFUjqk6QdiDJIx2824hQeWuM0T5ckRuEzFPW6OLjQ1Ilcjxy
	rsLZNRdn07GLchwBR6I+DTrLu2oPmG8wCuNGI2/VuOAyifQNAMKrYF6QxXY34IxRbs5trw
	QTutvQ28lyxpaJ7x7HWXIv27a6rUPNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708033838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV2jhmuXtgna00Xa5XigbZslr56lI5Yx29VeaYM+7Zs=;
	b=CyfgUjX1BLTALID9hEdUAVE0y33o5d942E1u9kjOUb6ETdEOWaAQbBwUvnixG0Sw95rehn
	v/izwNk1+5r4FOCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708033837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV2jhmuXtgna00Xa5XigbZslr56lI5Yx29VeaYM+7Zs=;
	b=Dt8snzWRDzt5u+n7VObmiYvxWro4RymUpbiy9sw6TJUMHM7ygUD5jEAxWkRS7EzXUv8zi7
	ktWK6jolt9A0D7NGfbauD2ABizMFXygQsNOY5kcVfPjw/IQVTSy3RBsMvbGiWV66IpKOLm
	+RXZxjZszD7RZGyYJUHBpVyt5gyyCrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708033837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV2jhmuXtgna00Xa5XigbZslr56lI5Yx29VeaYM+7Zs=;
	b=fMBcDkXfHOR+SAskPJRLfaYNJtLmrqLqJTOD9a9kdNJtFih9vtJOhzZxQryT203bFs1NmW
	kiz2q60HV/OG58Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3743813A82;
	Thu, 15 Feb 2024 21:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6IIYDS2HzmWgTgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 21:50:37 +0000
Message-ID: <ab4b1789-910a-4cd6-802c-5012bf9d8984@suse.cz>
Date: Thu, 15 Feb 2024 22:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
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
 <20240212213922.783301-8-surenb@google.com>
 <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz>
 <tbqg7sowftykfj3rptpcbewoiy632fbgbkzemgwnntme4wxhut@5dlfmdniaksr>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <tbqg7sowftykfj3rptpcbewoiy632fbgbkzemgwnntme4wxhut@5dlfmdniaksr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Dt8snzWR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fMBcDkXf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.00 / 50.00];
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
	 BAYES_HAM(-0.00)[26.94%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[google.com,linux-foundation.org,suse.com,cmpxchg.org,linux.dev,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.00
X-Rspamd-Queue-Id: C4D9C22056
X-Spam-Flag: NO

On 2/15/24 22:37, Kent Overstreet wrote:
> On Thu, Feb 15, 2024 at 10:31:06PM +0100, Vlastimil Babka wrote:
>> On 2/12/24 22:38, Suren Baghdasaryan wrote:
>> > Slab extension objects can't be allocated before slab infrastructure is
>> > initialized. Some caches, like kmem_cache and kmem_cache_node, are created
>> > before slab infrastructure is initialized. Objects from these caches can't
>> > have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
>> > caches and avoid creating extensions for objects allocated from these
>> > slabs.
>> > 
>> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> > ---
>> >  include/linux/slab.h | 7 +++++++
>> >  mm/slub.c            | 5 +++--
>> >  2 files changed, 10 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/include/linux/slab.h b/include/linux/slab.h
>> > index b5f5ee8308d0..3ac2fc830f0f 100644
>> > --- a/include/linux/slab.h
>> > +++ b/include/linux/slab.h
>> > @@ -164,6 +164,13 @@
>> >  #endif
>> >  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>> >  
>> > +#ifdef CONFIG_SLAB_OBJ_EXT
>> > +/* Slab created using create_boot_cache */
>> > +#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
>> 
>> There's
>>    #define SLAB_SKIP_KFENCE        ((slab_flags_t __force)0x20000000U)
>> already, so need some other one?
> 
> What's up with the order of flags in that file? They don't seem to
> follow any particular ordering.

Seems mostly in increasing order, except commit 4fd0b46e89879 broke it for
SLAB_RECLAIM_ACCOUNT?

> Seems like some cleanup is in order, but any history/context we should
> know first?

Yeah noted, but no need to sidetrack you.

