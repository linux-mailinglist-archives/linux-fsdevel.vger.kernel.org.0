Return-Path: <linux-fsdevel+bounces-14291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6787A8C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 14:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F1C1C21D82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723A74437D;
	Wed, 13 Mar 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Maisu8p+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkYTQT/R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Maisu8p+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkYTQT/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAC35894;
	Wed, 13 Mar 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337953; cv=none; b=NmM0KjRZWoX6F9Jc7YvCfLo60dOFDJn8zCK40jv3XbSS6Fvupk4lyjHqbhriVpyMj3XWvm1H5URw4OT+kuUGMToPPLpvfbMPSbvd25HrYYGC33ppCl2uBnKYSgKXRE2Oc7U87VIVplvMdudtK7VlTkG+mI3iL1Ltvuf8T6lpd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337953; c=relaxed/simple;
	bh=rHfsoLgtf5f5k5fyHTRd1g6+/B0CcY2M6+E3znEcWu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zuvt7qaCp/BJoq3m9Ai/zgHKKDocxK+Mqs4iQ5Hl0EXI1JQwh15yOo3wHcWGn1bbnMayUZeLPkAgdOOKrYGaN7oaJQN98ch3OclQTZUSaO8KoxKShFs9UiwHLz2NG1r/6kbk9BuH7mKR+KaGRSQPLwUeErzjJpK4QNrO2Ci0mM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Maisu8p+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkYTQT/R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Maisu8p+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkYTQT/R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20D211F7D4;
	Wed, 13 Mar 2024 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710337948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFhbbMRYCJAgLqELLxWLqfsH3hbHEF1BH4hx+bhAMaM=;
	b=Maisu8p+8VOLtYY3TrJkR6rfS5B+biJ+LLvd8LzgWVs36+MO0dIgBYONhiDpj9BO0wU7As
	5WBYSK4zyJyrGYI8oVkWNfm29jvIUlPG3mv1SaFBB4ETsn/Low2VGH0rrgxV/8AONovAQG
	lFNCUTxmHnFtwn6WdPREzN5h/FCJMs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710337948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFhbbMRYCJAgLqELLxWLqfsH3hbHEF1BH4hx+bhAMaM=;
	b=IkYTQT/R3aiB5aD7xFbTOmZOArH9iK+B5x3LUVlKBuTsf4vF+4u7JaIoaAkSErym3uJ5X+
	FaW3DBH6chjv6vDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710337948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFhbbMRYCJAgLqELLxWLqfsH3hbHEF1BH4hx+bhAMaM=;
	b=Maisu8p+8VOLtYY3TrJkR6rfS5B+biJ+LLvd8LzgWVs36+MO0dIgBYONhiDpj9BO0wU7As
	5WBYSK4zyJyrGYI8oVkWNfm29jvIUlPG3mv1SaFBB4ETsn/Low2VGH0rrgxV/8AONovAQG
	lFNCUTxmHnFtwn6WdPREzN5h/FCJMs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710337948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFhbbMRYCJAgLqELLxWLqfsH3hbHEF1BH4hx+bhAMaM=;
	b=IkYTQT/R3aiB5aD7xFbTOmZOArH9iK+B5x3LUVlKBuTsf4vF+4u7JaIoaAkSErym3uJ5X+
	FaW3DBH6chjv6vDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAB161397F;
	Wed, 13 Mar 2024 13:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E5Z1KZuv8WWIVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Mar 2024 13:52:27 +0000
Message-ID: <b4e5a48f-9a43-4f80-a3e7-75c04dba9a0f@suse.cz>
Date: Wed, 13 Mar 2024 14:53:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/37] mm/slub: Mark slab_free_freelist_hook()
 __always_inline
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
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
 <20240306182440.2003814-4-surenb@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240306182440.2003814-4-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Maisu8p+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="IkYTQT/R"
X-Spamd-Result: default: False [-1.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 URIBL_BLOCKED(0.00)[chromium.org:email,suse.cz:email,suse.cz:dkim,linux.dev:email,soleen.com:email];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 BAYES_HAM(-2.97)[99.88%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[76];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,nvidia.com,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.77
X-Rspamd-Queue-Id: 20D211F7D4
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 3/6/24 19:24, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> It seems we need to be more forceful with the compiler on this one.
> This is done for performance reasons only.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..0f3369f6188b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2121,9 +2121,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>  	return !kasan_slab_free(s, x, init);
>  }
>  
> -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> -					   void **head, void **tail,
> -					   int *cnt)
> +static __fastpath_inline
> +bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
> +			     int *cnt)
>  {
>  
>  	void *object;

